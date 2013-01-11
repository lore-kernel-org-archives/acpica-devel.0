Content-Type: multipart/mixed; boundary="===============8278716213693069874=="
MIME-Version: 1.0
From: Lv Zheng <lv.zheng at intel.com>
Subject: [Devel] [PATCH v2 1/2] ACPICA: Linuxize: Add patch header fields for
 linuxized patches.
Date: Sat, 12 Jan 2013 01:18:29 +0800
Message-ID: <4bf315ef4eda0f6c1d231ca7e626b4f8a3b19c7d.1357924466.git.lv.zheng@intel.com>
In-Reply-To: cover.1357924466.git.lv.zheng@intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============8278716213693069874==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Linuxized patches are lack of patch headers, thus can not be
directly applied to the Linux source codes. This patch updates
the scripts to allow patch headers to be generated for the
linuxized patches.

Signed-off-by: Lv Zheng <lv.zheng(a)intel.com>
---
 generate/linux/patches/make-patches.pl |   59 ++++++++++++++++++++++++++++=
++++
 1 file changed, 59 insertions(+)

diff --git a/generate/linux/patches/make-patches.pl b/generate/linux/patche=
s/make-patches.pl
index 11d072a..7e643f0 100755
--- a/generate/linux/patches/make-patches.pl
+++ b/generate/linux/patches/make-patches.pl
@@ -125,6 +125,13 @@ system("echo [make-patches] Creating the Linux patches=
");
 system("echo [make-patches] Creating the mbox patch file");
 &make_mbox;
 =

+
+# Purify the linux patches, one per file
+
+system("echo [make-patches] Purifying the Linux patches");
+&purify_patches;
+
+
 # Remove the temporary files/dirs =

 =

 #system("rm -rf $git_root acpi_include bin drivers patches.git git.log");
@@ -234,6 +241,20 @@ sub make_mbox
 =

 =

 #
+# This function purifies the linux patches from the GIT log file.
+# Requires the git log and the git patch set (both created by git)
+#
+sub purify_patches
+{
+    $linux_patch_count =3D 0;
+    $patch_num =3D 0;
+
+    &walk_git_log (count_patches);
+    &walk_git_log (purify_patch);
+}
+
+
+#
 # Count the individual patches
 #
 sub count_patches
@@ -375,3 +396,41 @@ sub make_patch
     system("rm -f diff.linux");
 }
 =

+
+
+#
+# This function purifies a linux patch from the corresponding
+# GIT patch against the original ACPICA source tree
+#
+sub purify_patch
+{
+    my $patch_name =3D @_[0];
+    my $date =3D @_[1];
+    my $file_name =3D @_[2];
+    my $short_log =3D @_[3];
+    my $long_log =3D @_[4];
+
+
+
+    open(PTCH, $file_name) or return;
+    close(PTCH);
+
+    $patch_num++;
+
+    # Append the header
+
+    system("rm -f temp");
+    open(PTCH, ">temp") or die ("Cannot open temp for writing");
+    print(PTCH "From nobody $mbox_date\n");
+    print(PTCH "Subject: [Patch $patch_num/$linux_patch_count] ACPICA: $sh=
ort_log\n");
+    print(PTCH "From: $patch_from\n");
+    print(PTCH "Date: $date\n");
+    print(PTCH "\n");
+    close(PTCH);
+
+    # Append the full patch to the purified file
+
+    system("cat $file_name >> temp");
+    system("cat temp > $file_name");
+    system("rm -f temp");
+}
-- =

1.7.10


--===============8278716213693069874==--

