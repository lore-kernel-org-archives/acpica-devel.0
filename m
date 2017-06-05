Content-Type: multipart/mixed; boundary="===============0537545116438647979=="
MIME-Version: 1.0
From: Ross Zwisler <ross.zwisler at linux.intel.com>
Subject: [Devel] [resend RFC 5/6] sysfs: add sysfs_add_group_link()
Date: Mon, 05 Jun 2017 13:50:56 -0600
Message-ID: <20170605195057.31492-6-ross.zwisler@linux.intel.com>
In-Reply-To: 20170605195057.31492-1-ross.zwisler@linux.intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============0537545116438647979==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The current __compat_only_sysfs_link_entry_to_kobj() code allows us to
create symbolic links in sysfs to groups or attributes.  Something like:

/sys/.../entry1/groupA -> /sys/.../entry2/groupA

This patch extends this functionality with a new sysfs_add_group_link()
call that allows the link to have a different name than the group or
attribute, so:

/sys/.../entry1/link_name -> /sys/.../entry2/groupA

__compat_only_sysfs_link_entry_to_kobj() now just calls
sysfs_add_group_link(), passing in the same name for both the
group/attribute and for the link name.

This is needed by the ACPI HMAT enabling work because we want to have a
group of performance attributes that live in a memory target.  This group
represents the performance between the (initiator,target) pair, and in the
target the attribute group is named "via_mem_initX" to represent this
pairing:

  # tree mem_tgt2/via_mem_init0/
  mem_tgt2/via_mem_init0/
  =E2=94=9C=E2=94=80=E2=94=80 mem_init0 -> ../../mem_init0
  =E2=94=9C=E2=94=80=E2=94=80 mem_tgt2 -> ../../mem_tgt2
  =E2=94=9C=E2=94=80=E2=94=80 read_bw_MBps
  =E2=94=9C=E2=94=80=E2=94=80 read_lat_nsec
  =E2=94=9C=E2=94=80=E2=94=80 write_bw_MBps
  =E2=94=94=E2=94=80=E2=94=80 write_lat_nsec

We then want to link to this attribute group from the initiator, but change
the name to "via_mem_tgtX" since we're now looking at it from the
initiator's perspective:

  # ls -l mem_init0/via_mem_tgt2
  lrwxrwxrwx. 1 root root 0 Jun  1 10:00 mem_init0/via_mem_tgt2 ->
  ../mem_tgt2/via_mem_init0

Signed-off-by: Ross Zwisler <ross.zwisler(a)linux.intel.com>
---
 fs/sysfs/group.c      | 30 +++++++++++++++++++++++-------
 include/linux/sysfs.h |  2 ++
 2 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/fs/sysfs/group.c b/fs/sysfs/group.c
index ac2de0e..19db57c8 100644
--- a/fs/sysfs/group.c
+++ b/fs/sysfs/group.c
@@ -367,15 +367,15 @@ void sysfs_remove_link_from_group(struct kobject *kob=
j, const char *group_name,
 EXPORT_SYMBOL_GPL(sysfs_remove_link_from_group);
 =

 /**
- * __compat_only_sysfs_link_entry_to_kobj - add a symlink to a kobject poi=
nting
- * to a group or an attribute
+ * sysfs_add_group_link - add a symlink to a kobject pointing to a group or
+ * an attribute
  * @kobj:		The kobject containing the group.
  * @target_kobj:	The target kobject.
  * @target_name:	The name of the target group or attribute.
+ * @link_name:		The name of the link to the target group or attribute.
  */
-int __compat_only_sysfs_link_entry_to_kobj(struct kobject *kobj,
-				      struct kobject *target_kobj,
-				      const char *target_name)
+int sysfs_add_group_link(struct kobject *kobj, struct kobject *target_kobj,
+		const char *target_name, const char *link_name)
 {
 	struct kernfs_node *target;
 	struct kernfs_node *entry;
@@ -400,12 +400,28 @@ int __compat_only_sysfs_link_entry_to_kobj(struct kob=
ject *kobj,
 		return -ENOENT;
 	}
 =

-	link =3D kernfs_create_link(kobj->sd, target_name, entry);
+	link =3D kernfs_create_link(kobj->sd, link_name, entry);
 	if (IS_ERR(link) && PTR_ERR(link) =3D=3D -EEXIST)
-		sysfs_warn_dup(kobj->sd, target_name);
+		sysfs_warn_dup(kobj->sd, link_name);
 =

 	kernfs_put(entry);
 	kernfs_put(target);
 	return IS_ERR(link) ? PTR_ERR(link) : 0;
 }
+EXPORT_SYMBOL_GPL(sysfs_add_group_link);
+
+/**
+ * __compat_only_sysfs_link_entry_to_kobj - add a symlink to a kobject poi=
nting
+ * to a group or an attribute
+ * @kobj:		The kobject containing the group.
+ * @target_kobj:	The target kobject.
+ * @target_name:	The name of the target group or attribute.
+ */
+int __compat_only_sysfs_link_entry_to_kobj(struct kobject *kobj,
+				      struct kobject *target_kobj,
+				      const char *target_name)
+{
+	return sysfs_add_group_link(kobj, target_kobj, target_name,
+			target_name);
+}
 EXPORT_SYMBOL_GPL(__compat_only_sysfs_link_entry_to_kobj);
diff --git a/include/linux/sysfs.h b/include/linux/sysfs.h
index c6f0f0d..865f499 100644
--- a/include/linux/sysfs.h
+++ b/include/linux/sysfs.h
@@ -278,6 +278,8 @@ int sysfs_add_link_to_group(struct kobject *kobj, const=
 char *group_name,
 			    struct kobject *target, const char *link_name);
 void sysfs_remove_link_from_group(struct kobject *kobj, const char *group_=
name,
 				  const char *link_name);
+int sysfs_add_group_link(struct kobject *kobj, struct kobject *target_kobj,
+		const char *target_name, const char *link_name);
 int __compat_only_sysfs_link_entry_to_kobj(struct kobject *kobj,
 				      struct kobject *target_kobj,
 				      const char *target_name);
-- =

2.9.4


--===============0537545116438647979==--

