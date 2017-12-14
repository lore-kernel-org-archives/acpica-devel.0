Content-Type: multipart/mixed; boundary="===============3955309640872037530=="
MIME-Version: 1.0
From: Ross Zwisler <ross.zwisler at linux.intel.com>
Subject: [Devel] [PATCH v3 2/3] hmat: add heterogeneous memory sysfs support
Date: Wed, 13 Dec 2017 19:10:18 -0700
Message-ID: <20171214021019.13579-3-ross.zwisler@linux.intel.com>
In-Reply-To: 20171214021019.13579-1-ross.zwisler@linux.intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============3955309640872037530==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add a new sysfs subsystem, /sys/devices/system/hmat, which surfaces
information about memory initiators and memory targets to the user.  These
initiators and targets are described by the ACPI SRAT and HMAT tables.

A "memory initiator" in this case is a NUMA node containing one or more
devices such as CPU or separate memory I/O devices that can initiate
memory requests.  A "memory target" is NUMA node containing at least one
CPU-accessible physical address range.

The key piece of information surfaced by this patch is the mapping between
the ACPI table "proximity domain" numbers, held in the "firmware_id"
attribute, and Linux NUMA node numbers.  Every ACPI proximity domain will
end up being a unique NUMA node in Linux, but the numbers may get reordered
and Linux can create extra NUMA nodes that don't map back to ACPI proximity
domains.  The firmware_id value is needed if anyone ever wants to look at
the ACPI HMAT and SRAT tables directly and make sense of how they map to
NUMA nodes in Linux.

Initiators are found at /sys/devices/system/hmat/mem_initX, and the
attributes for a given initiator look like this:

  # tree mem_init0
  mem_init0
  =E2=94=9C=E2=94=80=E2=94=80 firmware_id
  =E2=94=9C=E2=94=80=E2=94=80 node0 -> ../../node/node0
  =E2=94=9C=E2=94=80=E2=94=80 power
  =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 async
  =E2=94=82=C2=A0=C2=A0 ...
  =E2=94=9C=E2=94=80=E2=94=80 subsystem -> ../../../../bus/hmat
  =E2=94=94=E2=94=80=E2=94=80 uevent

Where "mem_init0" on my system represents the CPU acting as a memory
initiator at NUMA node 0.  Users can discover which CPUs are part of this
memory initiator by following the node0 symlink and looking at cpumap,
cpulist and the cpu* symlinks.

Targets are found at /sys/devices/system/hmat/mem_tgtX, and the attributes
for a given target look like this:

  # tree mem_tgt2
  mem_tgt2
  =E2=94=9C=E2=94=80=E2=94=80 firmware_id
  =E2=94=9C=E2=94=80=E2=94=80 is_cached
  =E2=94=9C=E2=94=80=E2=94=80 node2 -> ../../node/node2
  =E2=94=9C=E2=94=80=E2=94=80 power
  =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 async
  =E2=94=82=C2=A0=C2=A0 ...
  =E2=94=9C=E2=94=80=E2=94=80 subsystem -> ../../../../bus/hmat
  =E2=94=94=E2=94=80=E2=94=80 uevent

Users can discover information about the memory owned by this memory target
by following the node2 symlink and looking at meminfo, vmstat and at the
memory* memory section symlinks.

Signed-off-by: Ross Zwisler <ross.zwisler(a)linux.intel.com>
---
 MAINTAINERS                   |   6 +
 drivers/acpi/Kconfig          |   1 +
 drivers/acpi/Makefile         |   1 +
 drivers/acpi/hmat/Kconfig     |   7 +
 drivers/acpi/hmat/Makefile    |   2 +
 drivers/acpi/hmat/core.c      | 536 ++++++++++++++++++++++++++++++++++++++=
++++
 drivers/acpi/hmat/hmat.h      |  47 ++++
 drivers/acpi/hmat/initiator.c |  43 ++++
 drivers/acpi/hmat/target.c    |  55 +++++
 9 files changed, 698 insertions(+)
 create mode 100644 drivers/acpi/hmat/Kconfig
 create mode 100644 drivers/acpi/hmat/Makefile
 create mode 100644 drivers/acpi/hmat/core.c
 create mode 100644 drivers/acpi/hmat/hmat.h
 create mode 100644 drivers/acpi/hmat/initiator.c
 create mode 100644 drivers/acpi/hmat/target.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 82ad0eabce4f..64ebec0708de 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6366,6 +6366,12 @@ S:	Supported
 F:	drivers/scsi/hisi_sas/
 F:	Documentation/devicetree/bindings/scsi/hisilicon-sas.txt
 =

+HMAT - ACPI Heterogeneous Memory Attribute Table Support
+M:	Ross Zwisler <ross.zwisler(a)linux.intel.com>
+L:	linux-mm(a)kvack.org
+S:	Supported
+F:	drivers/acpi/hmat/
+
 HMM - Heterogeneous Memory Management
 M:	J=C3=A9r=C3=B4me Glisse <jglisse(a)redhat.com>
 L:	linux-mm(a)kvack.org
diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 46505396869e..21cdd1288430 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -466,6 +466,7 @@ config ACPI_REDUCED_HARDWARE_ONLY
 	  If you are unsure what to do, do not enable this option.
 =

 source "drivers/acpi/nfit/Kconfig"
+source "drivers/acpi/hmat/Kconfig"
 =

 source "drivers/acpi/apei/Kconfig"
 source "drivers/acpi/dptf/Kconfig"
diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index 41954a601989..ed5eab6b0412 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -75,6 +75,7 @@ obj-$(CONFIG_ACPI_PROCESSOR)	+=3D processor.o
 obj-$(CONFIG_ACPI)		+=3D container.o
 obj-$(CONFIG_ACPI_THERMAL)	+=3D thermal.o
 obj-$(CONFIG_ACPI_NFIT)		+=3D nfit/
+obj-$(CONFIG_ACPI_HMAT)		+=3D hmat/
 obj-$(CONFIG_ACPI)		+=3D acpi_memhotplug.o
 obj-$(CONFIG_ACPI_HOTPLUG_IOAPIC) +=3D ioapic.o
 obj-$(CONFIG_ACPI_BATTERY)	+=3D battery.o
diff --git a/drivers/acpi/hmat/Kconfig b/drivers/acpi/hmat/Kconfig
new file mode 100644
index 000000000000..954ad4701005
--- /dev/null
+++ b/drivers/acpi/hmat/Kconfig
@@ -0,0 +1,7 @@
+config ACPI_HMAT
+	bool "ACPI Heterogeneous Memory Attribute Table Support"
+	depends on ACPI_NUMA
+	depends on SYSFS
+	help
+	  Exports a sysfs representation of the ACPI Heterogeneous Memory
+	  Attributes Table (HMAT).
diff --git a/drivers/acpi/hmat/Makefile b/drivers/acpi/hmat/Makefile
new file mode 100644
index 000000000000..edf4bcb1c97d
--- /dev/null
+++ b/drivers/acpi/hmat/Makefile
@@ -0,0 +1,2 @@
+obj-$(CONFIG_ACPI_HMAT) :=3D hmat.o
+hmat-y :=3D core.o initiator.o target.o
diff --git a/drivers/acpi/hmat/core.c b/drivers/acpi/hmat/core.c
new file mode 100644
index 000000000000..61b90dadf84b
--- /dev/null
+++ b/drivers/acpi/hmat/core.c
@@ -0,0 +1,536 @@
+/*
+ * Heterogeneous Memory Attributes Table (HMAT) representation in sysfs
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
+#include "hmat.h"
+
+static LIST_HEAD(target_list);
+static LIST_HEAD(initiator_list);
+
+static bool bad_hmat;
+
+static int link_node_for_kobj(unsigned int node, struct kobject *kobj)
+{
+	if (node_devices[node])
+		return sysfs_create_link(kobj, &node_devices[node]->dev.kobj,
+				kobject_name(&node_devices[node]->dev.kobj));
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
+#define HMAT_CLASS_NAME	"hmat"
+
+static struct bus_type hmat_subsys =3D {
+	/*
+	 * .dev_name is set before device_register() based on the type of
+	 * device we are registering.
+	 */
+	.name =3D HMAT_CLASS_NAME,
+};
+
+/* memory initiators */
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
+	hmat_subsys.dev_name =3D "mem_init";
+	init->dev.bus =3D &hmat_subsys;
+	init->dev.id =3D pxm_to_node(init->pxm);
+	init->dev.release =3D release_memory_initiator;
+	init->dev.groups =3D memory_initiator_attribute_groups;
+
+	ret =3D device_register(&init->dev);
+	if (ret < 0)
+		return ret;
+
+	init->is_registered =3D true;
+	return link_node_for_kobj(pxm_to_node(init->pxm), &init->dev.kobj);
+}
+
+static struct memory_initiator * __init add_memory_initiator(int pxm)
+{
+	struct memory_initiator *init;
+
+	if (pxm_to_node(pxm) =3D=3D NUMA_NO_NODE) {
+		pr_err("HMAT: No NUMA node for PXM %d\n", pxm);
+		bad_hmat =3D true;
+		return ERR_PTR(-EINVAL);
+	}
+
+	/*
+	 * Make sure we haven't already added an initiator for this proximity
+	 * domain.  We don't care about any other differences in the SRAT
+	 * tables (apic_id, etc), so we just use the data from the first table
+	 * we see for a given proximity domain.
+	 */
+	list_for_each_entry(init, &initiator_list, list)
+		if (init->pxm =3D=3D pxm)
+			return 0;
+
+	init =3D kzalloc(sizeof(*init), GFP_KERNEL);
+	if (!init) {
+		bad_hmat =3D true;
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
+		pr_err("HMAT: Incomplete memory target found\n");
+		return -EINVAL;
+	}
+
+	hmat_subsys.dev_name =3D "mem_tgt";
+	tgt->dev.bus =3D &hmat_subsys;
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
+		pr_err("HMAT: No NUMA node for PXM %d\n", ma->proximity_domain);
+		bad_hmat =3D true;
+		return -EINVAL;
+	}
+
+	/*
+	 * Make sure we haven't already added a target for this proximity
+	 * domain.  We don't care about any other differences in the SRAT
+	 * tables (base_address, length), so we just use the data from the
+	 * first table we see for a given proximity domain.
+	 */
+	list_for_each_entry(tgt, &target_list, list)
+		if (tgt->ma->proximity_domain =3D=3D ma->proximity_domain)
+			return 0;
+
+	tgt =3D kzalloc(sizeof(*tgt), GFP_KERNEL);
+	if (!tgt) {
+		bad_hmat =3D true;
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
+static int __init hmat_noop_parse(struct acpi_table_header *table)
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
+	if (bad_hmat)
+		return 0;
+
+	spa =3D (struct acpi_hmat_address_range *)header;
+	if (!spa) {
+		pr_err("HMAT: NULL table entry\n");
+		goto err;
+	}
+
+	if (spa->header.length !=3D sizeof(*spa)) {
+		pr_err("HMAT: Unexpected header length: %d\n",
+				spa->header.length);
+		goto err;
+	}
+
+	list_for_each_entry(tgt, &target_list, list) {
+		if ((spa->flags & ACPI_HMAT_MEMORY_PD_VALID) &&
+				spa->memory_PD =3D=3D tgt->ma->proximity_domain) {
+			/*
+			 * We only add a single HMAT target per proximity
+			 * domain so we wait for the one that matches the
+			 * single SRAT memory affinity structure per PXM we
+			 * saved in add_memory_target().
+			 */
+			if (hmat_spa_matches_srat(spa, tgt->ma)) {
+				tgt->spa =3D spa;
+				find_local_initiator(tgt);
+			}
+			return 0;
+		}
+	}
+
+	return 0;
+err:
+	bad_hmat =3D true;
+	return -EINVAL;
+}
+
+static int __init hmat_parse_cache(struct acpi_subtable_header *header,
+		const unsigned long end)
+{
+	struct acpi_hmat_cache *cache;
+	struct memory_target *tgt;
+
+	if (bad_hmat)
+		return 0;
+
+	cache =3D (struct acpi_hmat_cache *)header;
+	if (!cache) {
+		pr_err("HMAT: NULL table entry\n");
+		goto err;
+	}
+
+	if (cache->header.length < sizeof(*cache)) {
+		pr_err("HMAT: Unexpected header length: %d\n",
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
+	pr_err("HMAT: Couldn't find cached target PXM %d\n", cache->memory_PD);
+err:
+	bad_hmat =3D true;
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
+	if (bad_hmat)
+		return 0;
+
+	cpu =3D (struct acpi_srat_cpu_affinity *)header;
+	if (!cpu) {
+		pr_err("HMAT: NULL table entry\n");
+		bad_hmat =3D true;
+		return -EINVAL;
+	}
+
+	pxm =3D cpu->proximity_domain_lo;
+	if (acpi_srat_revision >=3D 2)
+		pxm |=3D *((unsigned int *)cpu->proximity_domain_hi) << 8;
+
+	if (!(cpu->flags & ACPI_SRAT_CPU_ENABLED))
+		return 0;
+
+	init =3D add_memory_initiator(pxm);
+	if (IS_ERR_OR_NULL(init))
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
+	if (bad_hmat)
+		return 0;
+
+	x2apic =3D (struct acpi_srat_x2apic_cpu_affinity *)header;
+	if (!x2apic) {
+		pr_err("HMAT: NULL table entry\n");
+		bad_hmat =3D true;
+		return -EINVAL;
+	}
+
+	if (!(x2apic->flags & ACPI_SRAT_CPU_ENABLED))
+		return 0;
+
+	init =3D add_memory_initiator(x2apic->proximity_domain);
+	if (IS_ERR_OR_NULL(init))
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
+	if (bad_hmat)
+		return 0;
+
+	gicc =3D (struct acpi_srat_gicc_affinity *)header;
+	if (!gicc) {
+		pr_err("HMAT: NULL table entry\n");
+		bad_hmat =3D true;
+		return -EINVAL;
+	}
+
+	if (!(gicc->flags & ACPI_SRAT_GICC_ENABLED))
+		return 0;
+
+	init =3D add_memory_initiator(gicc->proximity_domain);
+	if (IS_ERR_OR_NULL(init))
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
+	if (bad_hmat)
+		return 0;
+
+	ma =3D (struct acpi_srat_mem_affinity *)header;
+	if (!ma) {
+		pr_err("HMAT: NULL table entry\n");
+		bad_hmat =3D true;
+		return -EINVAL;
+	}
+
+	if (!(ma->flags & ACPI_SRAT_MEM_ENABLED))
+		return 0;
+
+	return add_memory_target(ma);
+}
+
+/*
+ * Remove our sysfs entries, unregister our devices and free allocated mem=
ory.
+ */
+static void hmat_cleanup(void)
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
+static int __init hmat_init(void)
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
+	ret =3D subsys_system_register(&hmat_subsys, NULL);
+	if (ret)
+		return ret;
+
+	if (!acpi_table_parse(ACPI_SIG_SRAT, hmat_noop_parse)) {
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
+	if (!acpi_table_parse(ACPI_SIG_HMAT, hmat_noop_parse)) {
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
+	if (bad_hmat) {
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
+	pr_err("HMAT: Error during initialization\n");
+	hmat_cleanup();
+	return ret;
+}
+
+static __exit void hmat_exit(void)
+{
+	hmat_cleanup();
+}
+
+module_init(hmat_init);
+module_exit(hmat_exit);
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("Intel Corporation");
diff --git a/drivers/acpi/hmat/hmat.h b/drivers/acpi/hmat/hmat.h
new file mode 100644
index 000000000000..108aad1f8ad7
--- /dev/null
+++ b/drivers/acpi/hmat/hmat.h
@@ -0,0 +1,47 @@
+/*
+ * Heterogeneous Memory Attributes Table (HMAT) representation in sysfs
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
+#ifndef _ACPI_HMAT_H_
+#define _ACPI_HMAT_H_
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
+#define to_memory_initiator(d) container_of((d), struct memory_initiator, =
dev)
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
+#define to_memory_target(d) container_of((d), struct memory_target, dev)
+
+extern const struct attribute_group *memory_initiator_attribute_groups[];
+extern const struct attribute_group *memory_target_attribute_groups[];
+#endif /* _ACPI_HMAT_H_ */
diff --git a/drivers/acpi/hmat/initiator.c b/drivers/acpi/hmat/initiator.c
new file mode 100644
index 000000000000..be2bf2b58940
--- /dev/null
+++ b/drivers/acpi/hmat/initiator.c
@@ -0,0 +1,43 @@
+/*
+ * Heterogeneous Memory Attributes Table (HMAT) sysfs initiator representa=
tion
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
+#include "hmat.h"
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
+static struct attribute *memory_initiator_attributes[] =3D {
+	&dev_attr_firmware_id.attr,
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
diff --git a/drivers/acpi/hmat/target.c b/drivers/acpi/hmat/target.c
new file mode 100644
index 000000000000..2a9b44d5f44c
--- /dev/null
+++ b/drivers/acpi/hmat/target.c
@@ -0,0 +1,55 @@
+/*
+ * Heterogeneous Memory Attributes Table (HMAT) sysfs target representation
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
+#include "hmat.h"
+
+/* attributes for memory targets */
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
+static struct attribute *memory_target_attributes[] =3D {
+	&dev_attr_firmware_id.attr,
+	&dev_attr_is_cached.attr,
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

2.14.3


--===============3955309640872037530==--

