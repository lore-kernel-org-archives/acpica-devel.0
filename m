Content-Type: multipart/mixed; boundary="===============6618858169422740527=="
MIME-Version: 1.0
From: Ross Zwisler <ross.zwisler at linux.intel.com>
Subject: [Devel] [resend RFC 4/6] hmem: add heterogeneous memory sysfs support
Date: Mon, 05 Jun 2017 13:50:55 -0600
Message-ID: <20170605195057.31492-5-ross.zwisler@linux.intel.com>
In-Reply-To: 20170605195057.31492-1-ross.zwisler@linux.intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============6618858169422740527==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add a new sysfs subsystem, /sys/devices/system/hmem, which surfaces
information about memory initiators and memory targets to the user.  These
initiators and targets are described by the ACPI SRAT and HMAT tables.

A "memory initiator" in this case is any device such as a CPU or a separate
memory I/O device that can initiate a memory request.  A "memory target" is
a CPU-accessible physical address range.

The key piece of information surfaced by this patch is the mapping between
the ACPI table "proximity domain" numbers, held in the "firmware_id"
attribute, and Linux NUMA node numbers.

Initiators are found at /sys/devices/system/hmem/mem_initX, and the
attributes for a given initiator look like this:

  # tree mem_init0/
  mem_init0/
  =E2=94=9C=E2=94=80=E2=94=80 cpu0 -> ../../cpu/cpu0
  =E2=94=9C=E2=94=80=E2=94=80 firmware_id
  =E2=94=9C=E2=94=80=E2=94=80 is_enabled
  =E2=94=9C=E2=94=80=E2=94=80 node0 -> ../../node/node0
  =E2=94=9C=E2=94=80=E2=94=80 power
  =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 async
  =E2=94=82=C2=A0=C2=A0 ...
  =E2=94=9C=E2=94=80=E2=94=80 subsystem -> ../../../../bus/hmem
  =E2=94=94=E2=94=80=E2=94=80 uevent

Where "mem_init0" on my system represents the CPU acting as a memory
initiator at NUMA node 0.

Targets are found at /sys/devices/system/hmem/mem_tgtX, and the attributes
for a given target look like this:

  # tree mem_tgt2/
  mem_tgt2/
  =E2=94=9C=E2=94=80=E2=94=80 firmware_id
  =E2=94=9C=E2=94=80=E2=94=80 is_cached
  =E2=94=9C=E2=94=80=E2=94=80 is_enabled
  =E2=94=9C=E2=94=80=E2=94=80 is_isolated
  =E2=94=9C=E2=94=80=E2=94=80 node2 -> ../../node/node2
  =E2=94=9C=E2=94=80=E2=94=80 phys_addr_base
  =E2=94=9C=E2=94=80=E2=94=80 phys_length_bytes
  =E2=94=9C=E2=94=80=E2=94=80 power
  =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 async
  =E2=94=82=C2=A0=C2=A0 ...
  =E2=94=9C=E2=94=80=E2=94=80 subsystem -> ../../../../bus/hmem
  =E2=94=94=E2=94=80=E2=94=80 uevent

Signed-off-by: Ross Zwisler <ross.zwisler(a)linux.intel.com>
---
 MAINTAINERS                   |   5 +
 drivers/acpi/Kconfig          |   1 +
 drivers/acpi/Makefile         |   1 +
 drivers/acpi/hmem/Kconfig     |   7 +
 drivers/acpi/hmem/Makefile    |   2 +
 drivers/acpi/hmem/core.c      | 547 ++++++++++++++++++++++++++++++++++++++=
++++
 drivers/acpi/hmem/hmem.h      |  47 ++++
 drivers/acpi/hmem/initiator.c |  61 +++++
 drivers/acpi/hmem/target.c    |  97 ++++++++
 9 files changed, 768 insertions(+)
 create mode 100644 drivers/acpi/hmem/Kconfig
 create mode 100644 drivers/acpi/hmem/Makefile
 create mode 100644 drivers/acpi/hmem/core.c
 create mode 100644 drivers/acpi/hmem/hmem.h
 create mode 100644 drivers/acpi/hmem/initiator.c
 create mode 100644 drivers/acpi/hmem/target.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 053c3bd..554b833 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6085,6 +6085,11 @@ S:	Supported
 F:	drivers/scsi/hisi_sas/
 F:	Documentation/devicetree/bindings/scsi/hisilicon-sas.txt
 =

+HMEM (ACPI HETEROGENEOUS MEMORY SUPPORT)
+M:	Ross Zwisler <ross.zwisler(a)linux.intel.com>
+S:	Supported
+F:	drivers/acpi/hmem/
+
 HOST AP DRIVER
 M:	Jouni Malinen <j(a)w1.fi>
 L:	linux-wireless(a)vger.kernel.org
diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 1ce52f8..44dd97f 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -460,6 +460,7 @@ config ACPI_REDUCED_HARDWARE_ONLY
 	  If you are unsure what to do, do not enable this option.
 =

 source "drivers/acpi/nfit/Kconfig"
+source "drivers/acpi/hmem/Kconfig"
 =

 source "drivers/acpi/apei/Kconfig"
 source "drivers/acpi/dptf/Kconfig"
diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index b1aacfc..31e3f20 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -72,6 +72,7 @@ obj-$(CONFIG_ACPI_PROCESSOR)	+=3D processor.o
 obj-$(CONFIG_ACPI)		+=3D container.o
 obj-$(CONFIG_ACPI_THERMAL)	+=3D thermal.o
 obj-$(CONFIG_ACPI_NFIT)		+=3D nfit/
+obj-$(CONFIG_ACPI_HMEM)		+=3D hmem/
 obj-$(CONFIG_ACPI)		+=3D acpi_memhotplug.o
 obj-$(CONFIG_ACPI_HOTPLUG_IOAPIC) +=3D ioapic.o
 obj-$(CONFIG_ACPI_BATTERY)	+=3D battery.o
diff --git a/drivers/acpi/hmem/Kconfig b/drivers/acpi/hmem/Kconfig
new file mode 100644
index 0000000..09282be
--- /dev/null
+++ b/drivers/acpi/hmem/Kconfig
@@ -0,0 +1,7 @@
+config ACPI_HMEM
+	bool "ACPI Heterogeneous Memory Support"
+	depends on ACPI_NUMA
+	depends on SYSFS
+	help
+	  Exports a sysfs representation of the ACPI Heterogeneous Memory
+	  Attributes Table (HMAT).
diff --git a/drivers/acpi/hmem/Makefile b/drivers/acpi/hmem/Makefile
new file mode 100644
index 0000000..d2aa546
--- /dev/null
+++ b/drivers/acpi/hmem/Makefile
@@ -0,0 +1,2 @@
+obj-$(CONFIG_ACPI_HMEM) :=3D hmem.o
+hmem-y :=3D core.o initiator.o target.o
diff --git a/drivers/acpi/hmem/core.c b/drivers/acpi/hmem/core.c
new file mode 100644
index 0000000..2947fac
--- /dev/null
+++ b/drivers/acpi/hmem/core.c
@@ -0,0 +1,547 @@
+/*
+ * Heterogeneous memory representation in sysfs
+ *
+ * Copyright (c) 2017, Intel Corporation.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License f=
or
+ * more details.
+ */
+
+#include <acpi/acpi_numa.h>
+#include <linux/acpi.h>
+#include <linux/cpu.h>
+#include <linux/device.h>
+#include <linux/init.h>
+#include <linux/list.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include "hmem.h"
+
+static LIST_HEAD(target_list);
+static LIST_HEAD(initiator_list);
+
+static bool bad_hmem;
+
+static int link_node_for_kobj(unsigned int node, struct kobject *kobj)
+{
+	if (node_devices[node])
+		return sysfs_create_link(kobj, &node_devices[node]->dev.kobj,
+				kobject_name(&node_devices[node]->dev.kobj));
+
+	return 0;
+}
+
+static void remove_node_for_kobj(unsigned int node, struct kobject *kobj)
+{
+	if (node_devices[node])
+		sysfs_remove_link(kobj,
+				kobject_name(&node_devices[node]->dev.kobj));
+}
+
+#define HMEM_CLASS_NAME	"hmem"
+
+static struct bus_type hmem_subsys =3D {
+	/*
+	 * .dev_name is set before device_register() based on the type of
+	 * device we are registering.
+	 */
+	.name =3D HMEM_CLASS_NAME,
+};
+
+/* memory initiators */
+static int link_cpu_under_mem_init(struct memory_initiator *init)
+{
+	struct device *cpu_dev;
+	int cpu;
+
+	for_each_online_cpu(cpu) {
+		cpu_dev =3D get_cpu_device(cpu);
+		if (!cpu_dev)
+			continue;
+
+		if (pxm_to_node(init->pxm) =3D=3D cpu_to_node(cpu)) {
+			return sysfs_create_link(&init->dev.kobj,
+					&cpu_dev->kobj,
+					kobject_name(&cpu_dev->kobj));
+		}
+
+	}
+	return 0;
+}
+
+static void remove_cpu_under_mem_init(struct memory_initiator *init)
+{
+	struct device *cpu_dev;
+	int cpu;
+
+	for_each_online_cpu(cpu) {
+		cpu_dev =3D get_cpu_device(cpu);
+		if (!cpu_dev)
+			continue;
+
+		if (pxm_to_node(init->pxm) =3D=3D cpu_to_node(cpu)) {
+			sysfs_remove_link(&init->dev.kobj,
+					kobject_name(&cpu_dev->kobj));
+			return;
+		}
+
+	}
+}
+
+static void release_memory_initiator(struct device *dev)
+{
+	struct memory_initiator *init =3D to_memory_initiator(dev);
+
+	list_del(&init->list);
+	kfree(init);
+}
+
+static void __init remove_memory_initiator(struct memory_initiator *init)
+{
+	if (init->is_registered) {
+		remove_cpu_under_mem_init(init);
+		remove_node_for_kobj(pxm_to_node(init->pxm), &init->dev.kobj);
+		device_unregister(&init->dev);
+	} else
+		release_memory_initiator(&init->dev);
+}
+
+static int __init register_memory_initiator(struct memory_initiator *init)
+{
+	int ret;
+
+	hmem_subsys.dev_name =3D "mem_init";
+	init->dev.bus =3D &hmem_subsys;
+	init->dev.id =3D pxm_to_node(init->pxm);
+	init->dev.release =3D release_memory_initiator;
+	init->dev.groups =3D memory_initiator_attribute_groups;
+
+	ret =3D device_register(&init->dev);
+	if (ret < 0)
+		return ret;
+
+	init->is_registered =3D true;
+
+	ret =3D link_cpu_under_mem_init(init);
+	if (ret < 0)
+		return ret;
+
+	return link_node_for_kobj(pxm_to_node(init->pxm), &init->dev.kobj);
+}
+
+static struct memory_initiator * __init add_memory_initiator(int pxm)
+{
+	struct memory_initiator *init;
+
+	if (pxm_to_node(pxm) =3D=3D NUMA_NO_NODE) {
+		pr_err("HMEM: No NUMA node for PXM %d\n", pxm);
+		bad_hmem =3D true;
+		return ERR_PTR(-EINVAL);
+	}
+
+	init =3D kzalloc(sizeof(*init), GFP_KERNEL);
+	if (!init) {
+		bad_hmem =3D true;
+		return ERR_PTR(-ENOMEM);
+	}
+
+	init->pxm =3D pxm;
+
+	list_add_tail(&init->list, &initiator_list);
+	return init;
+}
+
+/* memory targets */
+static void release_memory_target(struct device *dev)
+{
+	struct memory_target *tgt =3D to_memory_target(dev);
+
+	list_del(&tgt->list);
+	kfree(tgt);
+}
+
+static void __init remove_memory_target(struct memory_target *tgt)
+{
+	if (tgt->is_registered) {
+		remove_node_for_kobj(pxm_to_node(tgt->ma->proximity_domain),
+				&tgt->dev.kobj);
+		device_unregister(&tgt->dev);
+	} else
+		release_memory_target(&tgt->dev);
+}
+
+static int __init register_memory_target(struct memory_target *tgt)
+{
+	int ret;
+
+	if (!tgt->ma || !tgt->spa) {
+		pr_err("HMEM: Incomplete memory target found\n");
+		return -EINVAL;
+	}
+
+	hmem_subsys.dev_name =3D "mem_tgt";
+	tgt->dev.bus =3D &hmem_subsys;
+	tgt->dev.id =3D pxm_to_node(tgt->ma->proximity_domain);
+	tgt->dev.release =3D release_memory_target;
+	tgt->dev.groups =3D memory_target_attribute_groups;
+
+	ret =3D device_register(&tgt->dev);
+	if (ret < 0)
+		return ret;
+
+	tgt->is_registered =3D true;
+
+	return link_node_for_kobj(pxm_to_node(tgt->ma->proximity_domain),
+			&tgt->dev.kobj);
+}
+
+static int __init add_memory_target(struct acpi_srat_mem_affinity *ma)
+{
+	struct memory_target *tgt;
+
+	if (pxm_to_node(ma->proximity_domain) =3D=3D NUMA_NO_NODE) {
+		pr_err("HMEM: No NUMA node for PXM %d\n", ma->proximity_domain);
+		bad_hmem =3D true;
+		return -EINVAL;
+	}
+
+	tgt =3D kzalloc(sizeof(*tgt), GFP_KERNEL);
+	if (!tgt) {
+		bad_hmem =3D true;
+		return -ENOMEM;
+	}
+
+	tgt->ma =3D ma;
+
+	list_add_tail(&tgt->list, &target_list);
+	return 0;
+}
+
+/* ACPI parsing code, starting with the HMAT */
+static int __init hmem_noop_parse(struct acpi_table_header *table)
+{
+	/* real work done by the hmat_parse_* and srat_parse_* routines */
+	return 0;
+}
+
+static bool __init hmat_spa_matches_srat(struct acpi_hmat_address_range *s=
pa,
+		struct acpi_srat_mem_affinity *ma)
+{
+	if (spa->physical_address_base !=3D ma->base_address ||
+	    spa->physical_address_length !=3D ma->length)
+		return false;
+
+	return true;
+}
+
+static void find_local_initiator(struct memory_target *tgt)
+{
+	struct memory_initiator *init;
+
+	if (!(tgt->spa->flags & ACPI_HMAT_PROCESSOR_PD_VALID) ||
+			pxm_to_node(tgt->spa->processor_PD) =3D=3D NUMA_NO_NODE)
+		return;
+
+	list_for_each_entry(init, &initiator_list, list) {
+		if (init->pxm =3D=3D tgt->spa->processor_PD) {
+			tgt->local_init =3D init;
+			return;
+		}
+	}
+}
+
+/* ACPI HMAT parsing routines */
+static int __init
+hmat_parse_address_range(struct acpi_subtable_header *header,
+		const unsigned long end)
+{
+	struct acpi_hmat_address_range *spa;
+	struct memory_target *tgt;
+
+	if (bad_hmem)
+		return 0;
+
+	spa =3D (struct acpi_hmat_address_range *)header;
+	if (!spa) {
+		pr_err("HMEM: NULL table entry\n");
+		goto err;
+	}
+
+	if (spa->header.length !=3D sizeof(*spa)) {
+		pr_err("HMEM: Unexpected header length: %d\n",
+				spa->header.length);
+		goto err;
+	}
+
+	list_for_each_entry(tgt, &target_list, list) {
+		if ((spa->flags & ACPI_HMAT_MEMORY_PD_VALID) &&
+				spa->memory_PD =3D=3D tgt->ma->proximity_domain) {
+			if (!hmat_spa_matches_srat(spa, tgt->ma)) {
+				pr_err("HMEM: SRAT and HMAT disagree on "
+						"address range info\n");
+				goto err;
+			}
+			tgt->spa =3D spa;
+			find_local_initiator(tgt);
+			return 0;
+		}
+	}
+
+	return 0;
+err:
+	bad_hmem =3D true;
+	return -EINVAL;
+}
+
+static int __init hmat_parse_cache(struct acpi_subtable_header *header,
+		const unsigned long end)
+{
+	struct acpi_hmat_cache *cache;
+	struct memory_target *tgt;
+
+	if (bad_hmem)
+		return 0;
+
+	cache =3D (struct acpi_hmat_cache *)header;
+	if (!cache) {
+		pr_err("HMEM: NULL table entry\n");
+		goto err;
+	}
+
+	if (cache->header.length < sizeof(*cache)) {
+		pr_err("HMEM: Unexpected header length: %d\n",
+				cache->header.length);
+		goto err;
+	}
+
+	list_for_each_entry(tgt, &target_list, list) {
+		if (cache->memory_PD =3D=3D tgt->ma->proximity_domain) {
+			tgt->is_cached =3D true;
+			return 0;
+		}
+	}
+
+	pr_err("HMEM: Couldn't find cached target PXM %d\n", cache->memory_PD);
+err:
+	bad_hmem =3D true;
+	return -EINVAL;
+}
+
+/*
+ * SRAT parsing.  We use srat_disabled() and pxm_to_node() so we don't redo
+ * any of the SRAT sanity checking done in drivers/acpi/numa.c.
+ */
+static int __init
+srat_parse_processor_affinity(struct acpi_subtable_header *header,
+		const unsigned long end)
+{
+	struct acpi_srat_cpu_affinity *cpu;
+	struct memory_initiator *init;
+	u32 pxm;
+
+	if (bad_hmem)
+		return 0;
+
+	cpu =3D (struct acpi_srat_cpu_affinity *)header;
+	if (!cpu) {
+		pr_err("HMEM: NULL table entry\n");
+		bad_hmem =3D true;
+		return -EINVAL;
+	}
+
+	pxm =3D cpu->proximity_domain_lo;
+	if (acpi_srat_revision >=3D 2)
+		pxm |=3D *((unsigned int *)cpu->proximity_domain_hi) << 8;
+
+	init =3D add_memory_initiator(pxm);
+	if (IS_ERR(init))
+		return PTR_ERR(init);
+
+	init->cpu =3D cpu;
+	return 0;
+}
+
+static int __init
+srat_parse_x2apic_affinity(struct acpi_subtable_header *header,
+		const unsigned long end)
+{
+	struct acpi_srat_x2apic_cpu_affinity *x2apic;
+	struct memory_initiator *init;
+
+	if (bad_hmem)
+		return 0;
+
+	x2apic =3D (struct acpi_srat_x2apic_cpu_affinity *)header;
+	if (!x2apic) {
+		pr_err("HMEM: NULL table entry\n");
+		bad_hmem =3D true;
+		return -EINVAL;
+	}
+
+	init =3D add_memory_initiator(x2apic->proximity_domain);
+	if (IS_ERR(init))
+		return PTR_ERR(init);
+
+	init->x2apic =3D x2apic;
+	return 0;
+}
+
+static int __init
+srat_parse_gicc_affinity(struct acpi_subtable_header *header,
+		const unsigned long end)
+{
+	struct acpi_srat_gicc_affinity *gicc;
+	struct memory_initiator *init;
+
+	if (bad_hmem)
+		return 0;
+
+	gicc =3D (struct acpi_srat_gicc_affinity *)header;
+	if (!gicc) {
+		pr_err("HMEM: NULL table entry\n");
+		bad_hmem =3D true;
+		return -EINVAL;
+	}
+
+	init =3D add_memory_initiator(gicc->proximity_domain);
+	if (IS_ERR(init))
+		return PTR_ERR(init);
+
+	init->gicc =3D gicc;
+	return 0;
+}
+
+static int __init
+srat_parse_memory_affinity(struct acpi_subtable_header *header,
+		const unsigned long end)
+{
+	struct acpi_srat_mem_affinity *ma;
+
+	if (bad_hmem)
+		return 0;
+
+	ma =3D (struct acpi_srat_mem_affinity *)header;
+	if (!ma) {
+		pr_err("HMEM: NULL table entry\n");
+		bad_hmem =3D true;
+		return -EINVAL;
+	}
+
+	return add_memory_target(ma);
+}
+
+/*
+ * Remove our sysfs entries, unregister our devices and free allocated mem=
ory.
+ */
+static void hmem_cleanup(void)
+{
+	struct memory_initiator *init, *init_iter;
+	struct memory_target *tgt, *tgt_iter;
+
+	list_for_each_entry_safe(tgt, tgt_iter, &target_list, list)
+		remove_memory_target(tgt);
+
+	list_for_each_entry_safe(init, init_iter, &initiator_list, list)
+		remove_memory_initiator(init);
+}
+
+static int __init hmem_init(void)
+{
+	struct acpi_table_header *tbl;
+	struct memory_initiator *init;
+	struct memory_target *tgt;
+	acpi_status status =3D AE_OK;
+	int ret;
+
+	if (srat_disabled())
+		return 0;
+
+	/*
+	 * We take a permanent reference to both the HMAT and SRAT in ACPI
+	 * memory so we can keep pointers to their subtables.  These tables
+	 * already had references on them which would never be released, taken
+	 * by acpi_sysfs_init(), so this shouldn't negatively impact anything.
+	 */
+	status =3D acpi_get_table(ACPI_SIG_SRAT, 0, &tbl);
+	if (ACPI_FAILURE(status))
+		return 0;
+
+	status =3D acpi_get_table(ACPI_SIG_HMAT, 0, &tbl);
+	if (ACPI_FAILURE(status))
+		return 0;
+
+	ret =3D subsys_system_register(&hmem_subsys, NULL);
+	if (ret)
+		return ret;
+
+	if (!acpi_table_parse(ACPI_SIG_SRAT, hmem_noop_parse)) {
+		struct acpi_subtable_proc srat_proc[4];
+
+		memset(srat_proc, 0, sizeof(srat_proc));
+		srat_proc[0].id =3D ACPI_SRAT_TYPE_CPU_AFFINITY;
+		srat_proc[0].handler =3D srat_parse_processor_affinity;
+		srat_proc[1].id =3D ACPI_SRAT_TYPE_X2APIC_CPU_AFFINITY;
+		srat_proc[1].handler =3D srat_parse_x2apic_affinity;
+		srat_proc[2].id =3D ACPI_SRAT_TYPE_GICC_AFFINITY;
+		srat_proc[2].handler =3D srat_parse_gicc_affinity;
+		srat_proc[3].id =3D ACPI_SRAT_TYPE_MEMORY_AFFINITY;
+		srat_proc[3].handler =3D srat_parse_memory_affinity;
+
+		acpi_table_parse_entries_array(ACPI_SIG_SRAT,
+					sizeof(struct acpi_table_srat),
+					srat_proc, ARRAY_SIZE(srat_proc), 0);
+	}
+
+	if (!acpi_table_parse(ACPI_SIG_HMAT, hmem_noop_parse)) {
+		struct acpi_subtable_proc hmat_proc[2];
+
+		memset(hmat_proc, 0, sizeof(hmat_proc));
+		hmat_proc[0].id =3D ACPI_HMAT_TYPE_ADDRESS_RANGE;
+		hmat_proc[0].handler =3D hmat_parse_address_range;
+		hmat_proc[1].id =3D ACPI_HMAT_TYPE_CACHE;
+		hmat_proc[1].handler =3D hmat_parse_cache;
+
+		acpi_table_parse_entries_array(ACPI_SIG_HMAT,
+					sizeof(struct acpi_table_hmat),
+					hmat_proc, ARRAY_SIZE(hmat_proc), 0);
+	}
+
+	if (bad_hmem) {
+		ret =3D -EINVAL;
+		goto err;
+	}
+
+	list_for_each_entry(init, &initiator_list, list) {
+		ret =3D register_memory_initiator(init);
+		if (ret)
+			goto err;
+	}
+
+	list_for_each_entry(tgt, &target_list, list) {
+		ret =3D register_memory_target(tgt);
+		if (ret)
+			goto err;
+	}
+
+	return 0;
+err:
+	pr_err("HMEM: Error during initialization\n");
+	hmem_cleanup();
+	return ret;
+}
+
+static __exit void hmem_exit(void)
+{
+	hmem_cleanup();
+}
+
+module_init(hmem_init);
+module_exit(hmem_exit);
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("Intel Corporation");
diff --git a/drivers/acpi/hmem/hmem.h b/drivers/acpi/hmem/hmem.h
new file mode 100644
index 0000000..8ea42b6
--- /dev/null
+++ b/drivers/acpi/hmem/hmem.h
@@ -0,0 +1,47 @@
+/*
+ * Heterogeneous memory representation in sysfs
+ *
+ * Copyright (c) 2017, Intel Corporation.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License f=
or
+ * more details.
+ */
+
+#ifndef _ACPI_HMEM_H_
+#define _ACPI_HMEM_H_
+
+struct memory_initiator {
+	struct list_head list;
+	struct device dev;
+
+	/* only one of the following three will be set */
+	struct acpi_srat_cpu_affinity *cpu;
+	struct acpi_srat_x2apic_cpu_affinity *x2apic;
+	struct acpi_srat_gicc_affinity *gicc;
+
+	int pxm;
+	bool is_registered;
+};
+#define to_memory_initiator(dev) container_of(dev, struct memory_initiator=
, dev)
+
+struct memory_target {
+	struct list_head list;
+	struct device dev;
+	struct acpi_srat_mem_affinity *ma;
+	struct acpi_hmat_address_range *spa;
+	struct memory_initiator *local_init;
+
+	bool is_cached;
+	bool is_registered;
+};
+#define to_memory_target(dev) container_of(dev, struct memory_target, dev)
+
+extern const struct attribute_group *memory_initiator_attribute_groups[];
+extern const struct attribute_group *memory_target_attribute_groups[];
+#endif /* _ACPI_HMEM_H_ */
diff --git a/drivers/acpi/hmem/initiator.c b/drivers/acpi/hmem/initiator.c
new file mode 100644
index 0000000..905f030
--- /dev/null
+++ b/drivers/acpi/hmem/initiator.c
@@ -0,0 +1,61 @@
+/*
+ * Heterogeneous memory initiator sysfs attributes
+ *
+ * Copyright (c) 2017, Intel Corporation.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License f=
or
+ * more details.
+ */
+
+#include <acpi/acpi_numa.h>
+#include <linux/acpi.h>
+#include <linux/device.h>
+#include <linux/sysfs.h>
+#include "hmem.h"
+
+static ssize_t firmware_id_show(struct device *dev,
+			struct device_attribute *attr, char *buf)
+{
+	struct memory_initiator *init =3D to_memory_initiator(dev);
+
+	return sprintf(buf, "%d\n", init->pxm);
+}
+static DEVICE_ATTR_RO(firmware_id);
+
+static ssize_t is_enabled_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct memory_initiator *init =3D to_memory_initiator(dev);
+	int is_enabled;
+
+	if (init->cpu)
+		is_enabled =3D !!(init->cpu->flags & ACPI_SRAT_CPU_ENABLED);
+	else if (init->x2apic)
+		is_enabled =3D !!(init->x2apic->flags & ACPI_SRAT_CPU_ENABLED);
+	else
+		is_enabled =3D !!(init->gicc->flags & ACPI_SRAT_GICC_ENABLED);
+
+	return sprintf(buf, "%d\n", is_enabled);
+}
+static DEVICE_ATTR_RO(is_enabled);
+
+static struct attribute *memory_initiator_attributes[] =3D {
+	&dev_attr_firmware_id.attr,
+	&dev_attr_is_enabled.attr,
+	NULL,
+};
+
+static struct attribute_group memory_initiator_attribute_group =3D {
+	.attrs =3D memory_initiator_attributes,
+};
+
+const struct attribute_group *memory_initiator_attribute_groups[] =3D {
+	&memory_initiator_attribute_group,
+	NULL,
+};
diff --git a/drivers/acpi/hmem/target.c b/drivers/acpi/hmem/target.c
new file mode 100644
index 0000000..dd57437
--- /dev/null
+++ b/drivers/acpi/hmem/target.c
@@ -0,0 +1,97 @@
+/*
+ * Heterogeneous memory target sysfs attributes
+ *
+ * Copyright (c) 2017, Intel Corporation.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License f=
or
+ * more details.
+ */
+
+#include <acpi/acpi_numa.h>
+#include <linux/acpi.h>
+#include <linux/device.h>
+#include <linux/sysfs.h>
+#include "hmem.h"
+
+/* attributes for memory targets */
+static ssize_t phys_addr_base_show(struct device *dev,
+			struct device_attribute *attr, char *buf)
+{
+	struct memory_target *tgt =3D to_memory_target(dev);
+
+	return sprintf(buf, "%#llx\n", tgt->ma->base_address);
+}
+static DEVICE_ATTR_RO(phys_addr_base);
+
+static ssize_t phys_length_bytes_show(struct device *dev,
+			struct device_attribute *attr, char *buf)
+{
+	struct memory_target *tgt =3D to_memory_target(dev);
+
+	return sprintf(buf, "%#llx\n", tgt->ma->length);
+}
+static DEVICE_ATTR_RO(phys_length_bytes);
+
+static ssize_t firmware_id_show(struct device *dev,
+			struct device_attribute *attr, char *buf)
+{
+	struct memory_target *tgt =3D to_memory_target(dev);
+
+	return sprintf(buf, "%d\n", tgt->ma->proximity_domain);
+}
+static DEVICE_ATTR_RO(firmware_id);
+
+static ssize_t is_cached_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct memory_target *tgt =3D to_memory_target(dev);
+
+	return sprintf(buf, "%d\n", tgt->is_cached);
+}
+static DEVICE_ATTR_RO(is_cached);
+
+static ssize_t is_isolated_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct memory_target *tgt =3D to_memory_target(dev);
+
+	return sprintf(buf, "%d\n",
+			!!(tgt->spa->flags & ACPI_HMAT_RESERVATION_HINT));
+}
+static DEVICE_ATTR_RO(is_isolated);
+
+static ssize_t is_enabled_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct memory_target *tgt =3D to_memory_target(dev);
+
+	return sprintf(buf, "%d\n",
+			!!(tgt->ma->flags & ACPI_SRAT_MEM_ENABLED));
+}
+static DEVICE_ATTR_RO(is_enabled);
+
+static struct attribute *memory_target_attributes[] =3D {
+	&dev_attr_phys_addr_base.attr,
+	&dev_attr_phys_length_bytes.attr,
+	&dev_attr_firmware_id.attr,
+	&dev_attr_is_cached.attr,
+	&dev_attr_is_isolated.attr,
+	&dev_attr_is_enabled.attr,
+	NULL
+};
+
+/* attributes which are present for all memory targets */
+static struct attribute_group memory_target_attribute_group =3D {
+	.attrs =3D memory_target_attributes,
+};
+
+const struct attribute_group *memory_target_attribute_groups[] =3D {
+	&memory_target_attribute_group,
+	NULL,
+};
-- =

2.9.4


--===============6618858169422740527==--

