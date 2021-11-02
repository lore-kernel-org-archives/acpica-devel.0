Content-Type: multipart/mixed; boundary="===============1642493459989453483=="
MIME-Version: 1.0
From: Sudeep Holla <sudeep.holla at arm.com>
Subject: [Devel] [PATCH 3/3] ACPI: PCC: Implement OperationRegion handler for
 the PCC Type 3 subtype
Date: Tue, 02 Nov 2021 18:25:42 +0000
Message-ID: <20211102182542.3460787-4-sudeep.holla@arm.com>
In-Reply-To: 20211102182542.3460787-1-sudeep.holla@arm.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============1642493459989453483==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

PCC OpRegion provides a mechanism to communicate with the platform
directly from the AML. PCCT provides the list of PCC channel available
in the platform, a subset or all of them can be used in PCC Opregion.

This patch registers the PCC OpRegion handler before ACPI tables are loaded.
This relies on the special context data passed to identify and setup the
PCC channel before the OpRegion handler is executed for the first time.

Typical PCC Opregion declaration looks like this:

OperationRegion (PFRM, PCC, 2, 0x74)
Field (PFRM, ByteAcc, NoLock, Preserve)
{
    SIGN,   32,
    FLGS,   32,
    LEN,    32,
    CMD,    32,
    DATA,   800
}

It contains 4 named double words followed by 100 bytes of buffer names DATA.

ASL can fill out the buffer something like:

    /* Create global or local buffer */
    Name (BUFF, Buffer (0x0C){})
    /* Create double word fields over the buffer */
    CreateDWordField (BUFF, 0x0, WD0)
    CreateDWordField (BUFF, 0x04, WD1)
    CreateDWordField (BUFF, 0x08, WD2)

    /* Fill the named fields */
    WD0 =3D 0x50434300
    SIGN =3D BUFF
    WD0 =3D 1
    FLGS =3D BUFF
    WD0 =3D 0x10
    LEN =3D BUFF

    /* Fill the payload in the DATA buffer */
    WD0 =3D 0
    WD1 =3D 0x08
    WD2 =3D 0
    DATA =3D BUFF

    /* Write to CMD field to trigger handler */
    WD0 =3D 0x4404
    CMD =3D BUFF

This buffer is recieved by acpi_pcc_opregion_space_handler. This
handler will fetch the commplete buffer via internal_pcc_buffer.

The setup handler will receive the special PCC context data which will
contain the PCC channel index which used to setup the channel. The buffer
pointer and length is saved in region context which is then used in the
handler.

Signed-off-by: Sudeep Holla <sudeep.holla(a)arm.com>
---
 drivers/acpi/Kconfig        |   5 ++
 drivers/acpi/Makefile       |   1 +
 drivers/acpi/bus.c          |   1 +
 drivers/acpi/pcc_opregion.c | 111 ++++++++++++++++++++++++++++++++++++
 include/linux/acpi.h        |   6 ++
 5 files changed, 124 insertions(+)
 create mode 100644 drivers/acpi/pcc_opregion.c

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 1da360c51d66..c2998e489cec 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -524,6 +524,11 @@ config ACPI_PPTT
 	bool
 endif
 =

+config ACPI_PCC_OPREGION
+	bool "PCC Opregion"
+	depends on PCC
+	default y
+
 source "drivers/acpi/pmic/Kconfig"
 =

 config ACPI_VIOT
diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index 3018714e87d9..d010ed3f4937 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -67,6 +67,7 @@ acpi-$(CONFIG_ACPI_LPIT)	+=3D acpi_lpit.o
 acpi-$(CONFIG_ACPI_GENERIC_GSI) +=3D irq.o
 acpi-$(CONFIG_ACPI_WATCHDOG)	+=3D acpi_watchdog.o
 acpi-$(CONFIG_ACPI_PRMT)	+=3D prmt.o
+acpi-$(CONFIG_ACPI_PCC_OPREGION) +=3D pcc_opregion.o
 =

 # Address translation
 acpi-$(CONFIG_ACPI_ADXL)	+=3D acpi_adxl.o
diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index fa923a929224..5e1eea7fb6f4 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -1320,6 +1320,7 @@ static int __init acpi_init(void)
 		pr_debug("%s: kset create error\n", __func__);
 =

 	init_prmt();
+	init_pcc_opregion();
 	result =3D acpi_bus_init();
 	if (result) {
 		kobject_put(acpi_kobj);
diff --git a/drivers/acpi/pcc_opregion.c b/drivers/acpi/pcc_opregion.c
new file mode 100644
index 000000000000..c965ce555bd0
--- /dev/null
+++ b/drivers/acpi/pcc_opregion.c
@@ -0,0 +1,111 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Author: Sudeep Holla <sudeep.holla(a)arm.com>
+ * Copyright 2021 Arm Limited
+ *
+ * pcc_opregion.c
+ *
+ */
+#include <linux/kernel.h>
+#include <linux/acpi.h>
+#include <linux/completion.h>
+#include <linux/idr.h>
+#include <linux/io.h>
+
+#include <acpi/pcc.h>
+
+struct pcc_data {
+	struct pcc_mbox_chan *pcc_chan;
+	void __iomem *pcc_comm_addr;
+	struct completion done;
+        struct mbox_client cl;
+	struct acpi_pcc_info ctx;
+};
+
+struct acpi_pcc_info pcc_ctx;
+
+static void pcc_rx_callback(struct mbox_client *cl, void *m)
+{
+        struct pcc_data *data =3D container_of(cl, struct pcc_data, cl);
+
+	complete(&data->done);
+}
+
+static acpi_status
+acpi_pcc_opregion_setup(acpi_handle region_handle, u32 function,
+			void *handler_context,  void **region_context)
+{
+	struct pcc_data *data;
+	struct acpi_pcc_info *ctx =3D handler_context;
+	struct pcc_mbox_chan *pcc_chan;
+
+	data =3D kzalloc(sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return_ACPI_STATUS(AE_NO_MEMORY);
+
+	data->cl.rx_callback =3D pcc_rx_callback;
+	data->cl.knows_txdone =3D true;
+	data->ctx.length =3D ctx->length;
+	data->ctx.subspace_id =3D ctx->subspace_id;
+	data->ctx.internal_buffer =3D ctx->internal_buffer;
+
+	init_completion(&data->done);
+	data->pcc_chan =3D pcc_mbox_request_channel(&data->cl, ctx->subspace_id);
+	if (IS_ERR(data->pcc_chan)) {
+		pr_err("Failed to find PCC channel for subspace %d\n",
+		       ctx->subspace_id);
+		return_ACPI_STATUS(AE_NOT_FOUND);
+	}
+
+	pcc_chan =3D data->pcc_chan;
+	data->pcc_comm_addr =3D acpi_os_ioremap(pcc_chan->shmem_base_addr,
+					      pcc_chan->shmem_size);
+	if (!data->pcc_comm_addr) {
+		pr_err("Failed to ioremap PCC comm region mem for %d\n",
+		       ctx->subspace_id);
+		return_ACPI_STATUS(AE_NO_MEMORY);
+	}
+
+	*region_context =3D data;
+	return_ACPI_STATUS(AE_OK);
+}
+
+static acpi_status
+acpi_pcc_opregion_space_handler(u32 function, acpi_physical_address addr,
+				u32 bits, acpi_integer *value,
+				void *handler_context, void *region_context)
+{
+	int ret;
+	struct pcc_data* data =3D region_context;
+
+	reinit_completion(&data->done);
+
+	/* Write to Shared Memory */
+	memcpy_toio(data->pcc_comm_addr, (void *)value, data->ctx.length);
+
+	ret =3D mbox_send_message(data->pcc_chan->mchan, NULL);
+	if (ret < 0)
+		return_ACPI_STATUS(AE_ERROR);
+
+	if (data->pcc_chan->mchan->mbox->txdone_irq)
+		wait_for_completion(&data->done);
+
+	mbox_client_txdone(data->pcc_chan->mchan, ret);
+
+	memcpy_fromio(value, data->pcc_comm_addr, data->ctx.length);
+
+	return_ACPI_STATUS(AE_OK);
+}
+
+void __init init_pcc_opregion(void)
+{
+	acpi_status status;
+
+	status =3D acpi_install_address_space_handler(ACPI_ROOT_OBJECT,
+						    ACPI_ADR_SPACE_PLATFORM_COMM,
+						    &acpi_pcc_opregion_space_handler,
+						    &acpi_pcc_opregion_setup,
+						    &pcc_ctx);
+	if (ACPI_FAILURE(status))
+		pr_alert("OperationRegion handler could not be installed\n");
+}
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index fbc2146050a4..7dd565294408 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -1384,6 +1384,12 @@ static inline int find_acpi_cpu_cache_topology(unsig=
ned int cpu, int level)
 }
 #endif
 =

+#ifdef CONFIG_ACPI_PCC_OPREGION
+void init_pcc_opregion(void);
+#else
+static inline void init_pcc_opregion(void) { }
+#endif
+
 #ifdef CONFIG_ACPI
 extern void acpi_device_notify(struct device *dev);
 extern void acpi_device_notify_remove(struct device *dev);
-- =

2.25.1

--===============1642493459989453483==--

