Content-Type: multipart/mixed; boundary="===============2135461464590344384=="
MIME-Version: 1.0
From: Ross Zwisler <ross.zwisler at linux.intel.com>
Subject: [Devel] [resend RFC 6/6] hmem: add performance attributes
Date: Mon, 05 Jun 2017 13:50:57 -0600
Message-ID: <20170605195057.31492-7-ross.zwisler@linux.intel.com>
In-Reply-To: 20170605195057.31492-1-ross.zwisler@linux.intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============2135461464590344384==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add performance information found in the HMAT to the sysfs representation.
This information lives as an attribute group named "via_mem_initX" in the
memory target:

  # tree mem_tgt2
  mem_tgt2
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
  =E2=94=9C=E2=94=80=E2=94=80 uevent
  =E2=94=94=E2=94=80=E2=94=80 via_mem_init0
      =E2=94=9C=E2=94=80=E2=94=80 mem_init0 -> ../../mem_init0
      =E2=94=9C=E2=94=80=E2=94=80 mem_tgt2 -> ../../mem_tgt2
      =E2=94=9C=E2=94=80=E2=94=80 read_bw_MBps
      =E2=94=9C=E2=94=80=E2=94=80 read_lat_nsec
      =E2=94=9C=E2=94=80=E2=94=80 write_bw_MBps
      =E2=94=94=E2=94=80=E2=94=80 write_lat_nsec

This attribute group surfaces latency and bandwidth performance for a given
(initiator,target) pairing.  For example:

  # grep . mem_tgt2/via_mem_init0/* 2>/dev/null
  mem_tgt2/via_mem_init0/read_bw_MBps:40960
  mem_tgt2/via_mem_init0/read_lat_nsec:50
  mem_tgt2/via_mem_init0/write_bw_MBps:40960
  mem_tgt2/via_mem_init0/write_lat_nsec:50

The initiator has a symlink to the performance information which lives in
the target's attribute group:

  # ls -l mem_init0/via_mem_tgt2
  lrwxrwxrwx. 1 root root 0 Jun  1 10:00 mem_init0/via_mem_tgt2 ->
  ../mem_tgt2/via_mem_init0

We create performance attribute groups only for local (initiator,target)
pairings, where the local initiator for a given target is defined by the
"Processor Proximity Domain" field in the HMAT's Memory Subsystem Address
Range Structure table.

A given target is only local to a single initiator, so each target will
have at most one "via_mem_initX" attribute group.  A given memory initiator
may have multiple local memory targets, so multiple "via_mem_tgtX" links
may exist for a given initiator.

If a given memory target is cached we give performance numbers only for the
media itself, and rely on the "is_cached" attribute to represent the
fact that there is a caching layer.

The fact that we only expose a subset of the performance information
presented in the HMAT via sysfs as a compromise, driven by fact that those
usages will be the highest performing and because to represent all possible
paths could cause an unmanageable explosion of sysfs entries.

If we dump everything from the HMAT into sysfs we end up with
O(num_targets * num_initiators * num_caching_levels) attributes.  Each of
these attributes only takes up 2 bytes in a System Locality Latency and
Bandwidth Information Structure, but if we have to create a directory entry
for each it becomes much more expensive.

For example, very large systems today can have on the order of thousands of
NUMA nodes.  Say we have a system which used to have 1,000 NUMA nodes that
each had both a CPU and local memory.  The HMAT allows us to separate the
CPUs and memory into separate NUMA nodes, so we can end up with 1,000 CPU
initiator NUMA nodes and 1,000 memory target NUMA nodes.  If we represented
the performance information for each possible CPU/memory pair in sysfs we
would end up with 1,000,000 attribute groups.

This is a lot to pass in a set of packed data tables, but I think we'll
break sysfs if we try to create millions of attributes, regardless of how
we nest them in a directory hierarchy.

By only representing performance information for local (initiator,target)
pairings, we reduce the number of sysfs entries to O(num_targets).

Signed-off-by: Ross Zwisler <ross.zwisler(a)linux.intel.com>
---
 drivers/acpi/hmem/Makefile          |   2 +-
 drivers/acpi/hmem/core.c            | 134 +++++++++++++++++++++++++++++-
 drivers/acpi/hmem/hmem.h            |   9 ++
 drivers/acpi/hmem/perf_attributes.c | 158 ++++++++++++++++++++++++++++++++=
++++
 4 files changed, 301 insertions(+), 2 deletions(-)
 create mode 100644 drivers/acpi/hmem/perf_attributes.c

diff --git a/drivers/acpi/hmem/Makefile b/drivers/acpi/hmem/Makefile
index d2aa546..44e8304 100644
--- a/drivers/acpi/hmem/Makefile
+++ b/drivers/acpi/hmem/Makefile
@@ -1,2 +1,2 @@
 obj-$(CONFIG_ACPI_HMEM) :=3D hmem.o
-hmem-y :=3D core.o initiator.o target.o
+hmem-y :=3D core.o initiator.o target.o perf_attributes.o
diff --git a/drivers/acpi/hmem/core.c b/drivers/acpi/hmem/core.c
index 2947fac..df93058 100644
--- a/drivers/acpi/hmem/core.c
+++ b/drivers/acpi/hmem/core.c
@@ -25,9 +25,94 @@
 =

 static LIST_HEAD(target_list);
 static LIST_HEAD(initiator_list);
+LIST_HEAD(locality_list);
 =

 static bool bad_hmem;
 =

+static int add_performance_attributes(struct memory_target *tgt)
+{
+	struct attribute_group performance_attribute_group =3D {
+		.attrs =3D performance_attributes,
+	};
+	struct kobject *init_kobj, *tgt_kobj;
+	struct device *init_dev, *tgt_dev;
+	char via_init[128], via_tgt[128];
+	int ret;
+
+	if (!tgt->local_init)
+		return 0;
+
+	init_dev =3D &tgt->local_init->dev;
+	tgt_dev =3D &tgt->dev;
+	init_kobj =3D &init_dev->kobj;
+	tgt_kobj =3D &tgt_dev->kobj;
+
+	snprintf(via_init, 128, "via_%s", dev_name(init_dev));
+	snprintf(via_tgt, 128, "via_%s", dev_name(tgt_dev));
+
+	/* Create entries for initiator/target pair in the target.  */
+	performance_attribute_group.name =3D via_init;
+	ret =3D sysfs_create_group(tgt_kobj, &performance_attribute_group);
+	if (ret < 0)
+		return ret;
+
+	ret =3D sysfs_add_link_to_group(tgt_kobj, via_init, init_kobj,
+			dev_name(init_dev));
+	if (ret < 0)
+		goto err;
+
+	ret =3D sysfs_add_link_to_group(tgt_kobj, via_init, tgt_kobj,
+			dev_name(tgt_dev));
+	if (ret < 0)
+		goto err;
+
+	/* Create a link in the initiator to the performance attributes. */
+	ret =3D sysfs_add_group_link(init_kobj, tgt_kobj, via_init, via_tgt);
+	if (ret < 0)
+		goto err;
+
+	tgt->has_perf_attributes =3D true;
+	return 0;
+err:
+	/* Removals of links that haven't been added yet are harmless. */
+	sysfs_remove_link_from_group(tgt_kobj, via_init, dev_name(init_dev));
+	sysfs_remove_link_from_group(tgt_kobj, via_init, dev_name(tgt_dev));
+	sysfs_remove_group(tgt_kobj, &performance_attribute_group);
+	return ret;
+}
+
+static void remove_performance_attributes(struct memory_target *tgt)
+{
+	struct attribute_group performance_attribute_group =3D {
+		.attrs =3D performance_attributes,
+	};
+	struct kobject *init_kobj, *tgt_kobj;
+	struct device *init_dev, *tgt_dev;
+	char via_init[128], via_tgt[128];
+
+	if (!tgt->local_init)
+		return;
+
+	init_dev =3D &tgt->local_init->dev;
+	tgt_dev =3D &tgt->dev;
+	init_kobj =3D &init_dev->kobj;
+	tgt_kobj =3D &tgt_dev->kobj;
+
+	snprintf(via_init, 128, "via_%s", dev_name(init_dev));
+	snprintf(via_tgt, 128, "via_%s", dev_name(tgt_dev));
+
+	performance_attribute_group.name =3D via_init;
+
+	/* Remove entries for initiator/target pair in the target.  */
+	sysfs_remove_link_from_group(tgt_kobj, via_init, dev_name(init_dev));
+	sysfs_remove_link_from_group(tgt_kobj, via_init, dev_name(tgt_dev));
+
+	/* Remove the initiator's link to the performance attributes. */
+	sysfs_remove_link(init_kobj, via_tgt);
+
+	sysfs_remove_group(tgt_kobj, &performance_attribute_group);
+}
+
 static int link_node_for_kobj(unsigned int node, struct kobject *kobj)
 {
 	if (node_devices[node])
@@ -168,6 +253,9 @@ static void release_memory_target(struct device *dev)
 =

 static void __init remove_memory_target(struct memory_target *tgt)
 {
+	if (tgt->has_perf_attributes)
+		remove_performance_attributes(tgt);
+
 	if (tgt->is_registered) {
 		remove_node_for_kobj(pxm_to_node(tgt->ma->proximity_domain),
 				&tgt->dev.kobj);
@@ -299,6 +387,38 @@ hmat_parse_address_range(struct acpi_subtable_header *=
header,
 	return -EINVAL;
 }
 =

+static int __init hmat_parse_locality(struct acpi_subtable_header *header,
+		const unsigned long end)
+{
+	struct acpi_hmat_locality *hmat_loc;
+	struct memory_locality *loc;
+
+	if (bad_hmem)
+		return 0;
+
+	hmat_loc =3D (struct acpi_hmat_locality *)header;
+	if (!hmat_loc) {
+		pr_err("HMEM: NULL table entry\n");
+		bad_hmem =3D true;
+		return -EINVAL;
+	}
+
+	/* We don't report cached performance information in sysfs. */
+	if (hmat_loc->flags =3D=3D ACPI_HMAT_MEMORY ||
+			hmat_loc->flags =3D=3D ACPI_HMAT_LAST_LEVEL_CACHE) {
+		loc =3D kzalloc(sizeof(*loc), GFP_KERNEL);
+		if (!loc) {
+			bad_hmem =3D true;
+			return -ENOMEM;
+		}
+
+		loc->hmat_loc =3D hmat_loc;
+		list_add_tail(&loc->list, &locality_list);
+	}
+
+	return 0;
+}
+
 static int __init hmat_parse_cache(struct acpi_subtable_header *header,
 		const unsigned long end)
 {
@@ -442,6 +562,7 @@ srat_parse_memory_affinity(struct acpi_subtable_header =
*header,
 static void hmem_cleanup(void)
 {
 	struct memory_initiator *init, *init_iter;
+	struct memory_locality *loc, *loc_iter;
 	struct memory_target *tgt, *tgt_iter;
 =

 	list_for_each_entry_safe(tgt, tgt_iter, &target_list, list)
@@ -449,6 +570,11 @@ static void hmem_cleanup(void)
 =

 	list_for_each_entry_safe(init, init_iter, &initiator_list, list)
 		remove_memory_initiator(init);
+
+	list_for_each_entry_safe(loc, loc_iter, &locality_list, list) {
+		list_del(&loc->list);
+		kfree(loc);
+	}
 }
 =

 static int __init hmem_init(void)
@@ -499,13 +625,15 @@ static int __init hmem_init(void)
 	}
 =

 	if (!acpi_table_parse(ACPI_SIG_HMAT, hmem_noop_parse)) {
-		struct acpi_subtable_proc hmat_proc[2];
+		struct acpi_subtable_proc hmat_proc[3];
 =

 		memset(hmat_proc, 0, sizeof(hmat_proc));
 		hmat_proc[0].id =3D ACPI_HMAT_TYPE_ADDRESS_RANGE;
 		hmat_proc[0].handler =3D hmat_parse_address_range;
 		hmat_proc[1].id =3D ACPI_HMAT_TYPE_CACHE;
 		hmat_proc[1].handler =3D hmat_parse_cache;
+		hmat_proc[2].id =3D ACPI_HMAT_TYPE_LOCALITY;
+		hmat_proc[2].handler =3D hmat_parse_locality;
 =

 		acpi_table_parse_entries_array(ACPI_SIG_HMAT,
 					sizeof(struct acpi_table_hmat),
@@ -527,6 +655,10 @@ static int __init hmem_init(void)
 		ret =3D register_memory_target(tgt);
 		if (ret)
 			goto err;
+
+		ret =3D add_performance_attributes(tgt);
+		if (ret)
+			goto err;
 	}
 =

 	return 0;
diff --git a/drivers/acpi/hmem/hmem.h b/drivers/acpi/hmem/hmem.h
index 8ea42b6..6073ec4 100644
--- a/drivers/acpi/hmem/hmem.h
+++ b/drivers/acpi/hmem/hmem.h
@@ -39,9 +39,18 @@ struct memory_target {
 =

 	bool is_cached;
 	bool is_registered;
+	bool has_perf_attributes;
 };
 #define to_memory_target(dev) container_of(dev, struct memory_target, dev)
 =

+struct memory_locality {
+	struct list_head list;
+	struct acpi_hmat_locality *hmat_loc;
+};
+
 extern const struct attribute_group *memory_initiator_attribute_groups[];
 extern const struct attribute_group *memory_target_attribute_groups[];
+extern struct attribute *performance_attributes[];
+
+extern struct list_head locality_list;
 #endif /* _ACPI_HMEM_H_ */
diff --git a/drivers/acpi/hmem/perf_attributes.c b/drivers/acpi/hmem/perf_a=
ttributes.c
new file mode 100644
index 0000000..cb77b21
--- /dev/null
+++ b/drivers/acpi/hmem/perf_attributes.c
@@ -0,0 +1,158 @@
+/*
+ * Heterogeneous memory performance attributes
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
+#include <linux/acpi.h>
+#include <linux/device.h>
+#include <linux/sysfs.h>
+#include "hmem.h"
+
+#define NO_VALUE	-1
+#define LATENCY		0
+#define BANDWIDTH	1
+
+/* Performance attributes for an initiator/target pair. */
+static int get_performance_data(u32 init_pxm, u32 tgt_pxm,
+		struct acpi_hmat_locality *hmat_loc)
+{
+	int num_init =3D hmat_loc->number_of_initiator_Pds;
+	int num_tgt =3D hmat_loc->number_of_target_Pds;
+	int init_idx =3D NO_VALUE;
+	int tgt_idx =3D NO_VALUE;
+	u32 *initiators, *targets;
+	u16 *entries, val;
+	int i;
+
+	initiators =3D hmat_loc->data;
+	targets =3D &initiators[num_init];
+	entries =3D (u16 *)&targets[num_tgt];
+
+	for (i =3D 0; i < num_init; i++) {
+		if (initiators[i] =3D=3D init_pxm) {
+			init_idx =3D i;
+			break;
+		}
+	}
+
+	if (init_idx =3D=3D NO_VALUE)
+		return NO_VALUE;
+
+	for (i =3D 0; i < num_tgt; i++) {
+		if (targets[i] =3D=3D tgt_pxm) {
+			tgt_idx =3D i;
+			break;
+		}
+	}
+
+	if (tgt_idx =3D=3D NO_VALUE)
+		return NO_VALUE;
+
+	val =3D entries[init_idx*num_tgt + tgt_idx];
+	if (val < 10 || val =3D=3D 0xFFFF)
+		return NO_VALUE;
+
+	return (val * hmat_loc->entry_base_unit) / 10;
+}
+
+/*
+ * 'direction' is either READ or WRITE
+ * 'type' is either LATENCY or BANDWIDTH
+ * Latency is reported in nanoseconds and bandwidth is reported in MB/s.
+ */
+static int get_dev_attribute(struct device *dev, int direction, int type)
+{
+	struct memory_target *tgt =3D to_memory_target(dev);
+	int tgt_pxm =3D tgt->ma->proximity_domain;
+	int init_pxm =3D tgt->local_init->pxm;
+	struct memory_locality *loc;
+	int value;
+
+	list_for_each_entry(loc, &locality_list, list) {
+		struct acpi_hmat_locality *hmat_loc =3D loc->hmat_loc;
+
+		if (direction =3D=3D READ && type =3D=3D LATENCY &&
+		    (hmat_loc->data_type =3D=3D ACPI_HMAT_ACCESS_LATENCY ||
+		     hmat_loc->data_type =3D=3D ACPI_HMAT_READ_LATENCY)) {
+			value =3D get_performance_data(init_pxm, tgt_pxm,
+					hmat_loc);
+			if (value !=3D NO_VALUE)
+				return value;
+		}
+
+		if (direction =3D=3D WRITE && type =3D=3D LATENCY &&
+		    (hmat_loc->data_type =3D=3D ACPI_HMAT_ACCESS_LATENCY ||
+		     hmat_loc->data_type =3D=3D ACPI_HMAT_WRITE_LATENCY)) {
+			value =3D get_performance_data(init_pxm, tgt_pxm,
+					hmat_loc);
+			if (value !=3D NO_VALUE)
+				return value;
+		}
+
+		if (direction =3D=3D READ && type =3D=3D BANDWIDTH &&
+		    (hmat_loc->data_type =3D=3D ACPI_HMAT_ACCESS_BANDWIDTH ||
+		     hmat_loc->data_type =3D=3D ACPI_HMAT_READ_BANDWIDTH)) {
+			value =3D get_performance_data(init_pxm, tgt_pxm,
+					hmat_loc);
+			if (value !=3D NO_VALUE)
+				return value;
+		}
+
+		if (direction =3D=3D WRITE && type =3D=3D BANDWIDTH &&
+		    (hmat_loc->data_type =3D=3D ACPI_HMAT_ACCESS_BANDWIDTH ||
+		     hmat_loc->data_type =3D=3D ACPI_HMAT_WRITE_BANDWIDTH)) {
+			value =3D get_performance_data(init_pxm, tgt_pxm,
+					hmat_loc);
+			if (value !=3D NO_VALUE)
+				return value;
+		}
+	}
+
+	return NO_VALUE;
+}
+
+static ssize_t read_lat_nsec_show(struct device *dev,
+			struct device_attribute *attr, char *buf)
+{
+	return sprintf(buf, "%d\n", get_dev_attribute(dev, READ, LATENCY));
+}
+static DEVICE_ATTR_RO(read_lat_nsec);
+
+static ssize_t write_lat_nsec_show(struct device *dev,
+			struct device_attribute *attr, char *buf)
+{
+	return sprintf(buf, "%d\n", get_dev_attribute(dev, WRITE, LATENCY));
+}
+static DEVICE_ATTR_RO(write_lat_nsec);
+
+static ssize_t read_bw_MBps_show(struct device *dev,
+			struct device_attribute *attr, char *buf)
+{
+	return sprintf(buf, "%d\n", get_dev_attribute(dev, READ, BANDWIDTH));
+}
+static DEVICE_ATTR_RO(read_bw_MBps);
+
+static ssize_t write_bw_MBps_show(struct device *dev,
+			struct device_attribute *attr, char *buf)
+{
+	return sprintf(buf, "%d\n", get_dev_attribute(dev, WRITE, BANDWIDTH));
+}
+static DEVICE_ATTR_RO(write_bw_MBps);
+
+struct attribute *performance_attributes[] =3D {
+	&dev_attr_read_lat_nsec.attr,
+	&dev_attr_write_lat_nsec.attr,
+	&dev_attr_read_bw_MBps.attr,
+	&dev_attr_write_bw_MBps.attr,
+	NULL
+};
-- =

2.9.4


--===============2135461464590344384==--

