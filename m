Content-Type: multipart/mixed; boundary="===============0280429597890511379=="
MIME-Version: 1.0
From: Besar Wicaksono <bwicaksono at nvidia.com>
Subject: [Devel] [PATCH 2/2] ACPI: ARM Performance Monitoring Unit Table
 (APMT) initial support
Date: Tue, 19 Apr 2022 15:54:32 -0500
Message-ID: <20220419205432.46021-3-bwicaksono@nvidia.com>
In-Reply-To: 20220419205432.46021-1-bwicaksono@nvidia.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============0280429597890511379==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

ARM Performance Monitoring Unit Table describes the properties of PMU
support in ARM-based system. The APMT table contains a list of nodes,
each represents a PMU in the system that conforms to ARM CoreSight PMU
architecture. The properties of each node include information required
to access the PMU (e.g. MMIO base address, interrupt number) and also
identification. For more detailed information, please refer to the
specification below:
 * APMT: https://developer.arm.com/documentation/den0117/latest
 * ARM Coresight PMU:
        https://developer.arm.com/documentation/ihi0091/latest

The initial support adds the detection of APMT table and generic
infrastructure to create platform devices for ARM CoreSight PMUs.
Similar to IORT the root pointer of APMT is preserved during runtime
and each PMU platform device is given a pointer to the corresponding
APMT node.

Signed-off-by: Besar Wicaksono <bwicaksono(a)nvidia.com>
---
 arch/arm64/Kconfig          |   1 +
 drivers/acpi/arm64/Kconfig  |   3 +
 drivers/acpi/arm64/Makefile |   1 +
 drivers/acpi/arm64/apmt.c   | 176 ++++++++++++++++++++++++++++++++++++
 drivers/acpi/bus.c          |   2 +
 include/linux/acpi_apmt.h   |  19 ++++
 6 files changed, 202 insertions(+)
 create mode 100644 drivers/acpi/arm64/apmt.c
 create mode 100644 include/linux/acpi_apmt.h

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index e80fd2372f02..49e01c4377f2 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config ARM64
 	def_bool y
+	select ACPI_APMT if ACPI
 	select ACPI_CCA_REQUIRED if ACPI
 	select ACPI_GENERIC_GSI if ACPI
 	select ACPI_GTDT if ACPI
diff --git a/drivers/acpi/arm64/Kconfig b/drivers/acpi/arm64/Kconfig
index d4a72835f328..b3ed6212244c 100644
--- a/drivers/acpi/arm64/Kconfig
+++ b/drivers/acpi/arm64/Kconfig
@@ -18,3 +18,6 @@ config ACPI_AGDI
 	  reset command.
 =

 	  If set, the kernel parses AGDI table and listens for the command.
+
+config ACPI_APMT
+	bool
diff --git a/drivers/acpi/arm64/Makefile b/drivers/acpi/arm64/Makefile
index 7b9e4045659d..e21a9e84e394 100644
--- a/drivers/acpi/arm64/Makefile
+++ b/drivers/acpi/arm64/Makefile
@@ -2,4 +2,5 @@
 obj-$(CONFIG_ACPI_AGDI) 	+=3D agdi.o
 obj-$(CONFIG_ACPI_IORT) 	+=3D iort.o
 obj-$(CONFIG_ACPI_GTDT) 	+=3D gtdt.o
+obj-$(CONFIG_ACPI_APMT) 	+=3D apmt.o
 obj-y				+=3D dma.o
diff --git a/drivers/acpi/arm64/apmt.c b/drivers/acpi/arm64/apmt.c
new file mode 100644
index 000000000000..8b8b9f480548
--- /dev/null
+++ b/drivers/acpi/arm64/apmt.c
@@ -0,0 +1,176 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * ARM APMT table support.
+ * Design document number: ARM DEN0117.
+ *
+ * Copyright (c) 2022, NVIDIA CORPORATION & AFFILIATES.
+ *
+ */
+
+#define pr_fmt(fmt)	"ACPI: APMT: " fmt
+
+#include <linux/acpi.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/platform_device.h>
+
+#define DEV_NAME "arm-csite-pmu"
+
+/* There can be up to 3 resources: page 0 and 1 address, and interrupt. */
+#define DEV_MAX_RESOURCE_COUNT 3
+
+/* Root pointer to the mapped APMT table */
+static struct acpi_table_header *apmt_table;
+
+static int __init apmt_init_resources(struct resource *res,
+					      struct acpi_apmt_node *node)
+{
+	int irq, trigger;
+	int num_res =3D 0;
+
+	res[num_res].start =3D node->base_address0;
+	res[num_res].end =3D node->base_address0 + SZ_4K - 1;
+	res[num_res].flags =3D IORESOURCE_MEM;
+
+	num_res++;
+
+	res[num_res].start =3D node->base_address1;
+	res[num_res].end =3D node->base_address1 + SZ_4K - 1;
+	res[num_res].flags =3D IORESOURCE_MEM;
+
+	num_res++;
+
+	if (node->ovflw_irq !=3D 0) {
+		trigger =3D (node->ovflw_irq_flags & ACPI_APMT_OVFLW_IRQ_FLAGS_MODE);
+		trigger =3D (trigger =3D=3D ACPI_APMT_OVFLW_IRQ_FLAGS_MODE_LEVEL) ?
+			ACPI_LEVEL_SENSITIVE : ACPI_EDGE_SENSITIVE;
+		irq =3D acpi_register_gsi(NULL, node->ovflw_irq, trigger,
+						ACPI_ACTIVE_HIGH);
+
+		if (irq <=3D 0) {
+			pr_warn("APMT could not register gsi hwirq %d\n", irq);
+			return num_res;
+		}
+
+		res[num_res].start =3D irq;
+		res[num_res].end =3D irq;
+		res[num_res].flags =3D IORESOURCE_IRQ;
+
+		num_res++;
+	}
+
+	return num_res;
+}
+
+/**
+ * apmt_add_platform_device() - Allocate a platform device for APMT node
+ * @node: Pointer to device ACPI APMT node
+ *
+ * Returns: 0 on success, <0 failure
+ */
+static int __init apmt_add_platform_device(struct acpi_apmt_node *node,
+							struct fwnode_handle *fwnode)
+{
+	struct platform_device *pdev;
+	int ret, count;
+	struct resource res[DEV_MAX_RESOURCE_COUNT];
+
+	pdev =3D platform_device_alloc(DEV_NAME, PLATFORM_DEVID_AUTO);
+	if (!pdev)
+		return -ENOMEM;
+
+	memset(res, 0, sizeof(res));
+
+	count =3D apmt_init_resources(res, node);
+
+	ret =3D platform_device_add_resources(pdev, res, count);
+	if (ret)
+		goto dev_put;
+
+	/*
+	 * Add a copy of APMT node pointer to platform_data to be used to
+	 * retrieve APMT data information.
+	 */
+	ret =3D platform_device_add_data(pdev, &node, sizeof(node));
+	if (ret)
+		goto dev_put;
+
+	pdev->dev.fwnode =3D fwnode;
+
+	ret =3D platform_device_add(pdev);
+
+	if (ret)
+		goto dev_put;
+
+	return 0;
+
+dev_put:
+	platform_device_put(pdev);
+
+	return ret;
+}
+
+static int __init apmt_init_platform_devices(void)
+{
+	struct acpi_apmt_node *apmt_node;
+	struct acpi_table_apmt *apmt;
+	struct fwnode_handle *fwnode;
+	u64 offset, end;
+	int ret;
+
+	/*
+	 * apmt_table and apmt both point to the start of APMT table, but
+	 * have different struct types
+	 */
+	apmt =3D (struct acpi_table_apmt *)apmt_table;
+	offset =3D sizeof(*apmt);
+	end =3D apmt->header.length;
+
+	while (offset < end) {
+		apmt_node =3D ACPI_ADD_PTR(struct acpi_apmt_node, apmt,
+				 offset);
+
+		fwnode =3D acpi_alloc_fwnode_static();
+		if (!fwnode)
+			return -ENOMEM;
+
+		ret =3D apmt_add_platform_device(apmt_node, fwnode);
+		if (ret) {
+			acpi_free_fwnode_static(fwnode);
+			return ret;
+		}
+
+		offset +=3D apmt_node->length;
+	}
+
+	return 0;
+}
+
+void __init acpi_apmt_init(void)
+{
+	acpi_status status;
+	int ret;
+
+	/**
+	 * APMT table nodes will be used at runtime after the apmt init,
+	 * so we don't need to call acpi_put_table() to release
+	 * the APMT table mapping.
+	 */
+	status =3D acpi_get_table(ACPI_SIG_APMT, 0, &apmt_table);
+
+	if (ACPI_FAILURE(status)) {
+		if (status !=3D AE_NOT_FOUND) {
+			const char *msg =3D acpi_format_exception(status);
+
+			pr_err("Failed to get APMT table, %s\n", msg);
+		}
+
+		return;
+	}
+
+	ret =3D apmt_init_platform_devices();
+	if (ret) {
+		pr_err("Failed to initialize APMT platform devices, ret: %d\n", ret);
+		acpi_put_table(apmt_table);
+	}
+}
diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 3e58b613a2c4..25ddd9f300e7 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -27,6 +27,7 @@
 #include <linux/dmi.h>
 #endif
 #include <linux/acpi_agdi.h>
+#include <linux/acpi_apmt.h>
 #include <linux/acpi_iort.h>
 #include <linux/acpi_viot.h>
 #include <linux/pci.h>
@@ -1367,6 +1368,7 @@ static int __init acpi_init(void)
 	acpi_setup_sb_notify_handler();
 	acpi_viot_init();
 	acpi_agdi_init();
+	acpi_apmt_init();
 	return 0;
 }
 =

diff --git a/include/linux/acpi_apmt.h b/include/linux/acpi_apmt.h
new file mode 100644
index 000000000000..40bd634d082f
--- /dev/null
+++ b/include/linux/acpi_apmt.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * ARM CoreSight PMU driver.
+ * Copyright (c) 2022, NVIDIA CORPORATION & AFFILIATES.
+ *
+ */
+
+#ifndef __ACPI_APMT_H__
+#define __ACPI_APMT_H__
+
+#include <linux/acpi.h>
+
+#ifdef CONFIG_ACPI_APMT
+void acpi_apmt_init(void);
+#else
+static inline void acpi_apmt_init(void) { }
+#endif /* CONFIG_ACPI_APMT */
+
+#endif /* __ACPI_APMT_H__ */
-- =

2.17.1

--===============0280429597890511379==--

