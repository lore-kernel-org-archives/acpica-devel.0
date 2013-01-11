Content-Type: multipart/mixed; boundary="===============7435274794587458512=="
MIME-Version: 1.0
From: Lv Zheng <lv.zheng at intel.com>
Subject: [Devel] [PATCH 1/2] ACPICA: Linuxize: Add patch header fields for
 linuxized patches.
Date: Sat, 12 Jan 2013 00:29:37 +0800
Message-ID: <b4290bf9f1459cc36ffb785f7d59ebbc1a54bca0.1357921698.git.lv.zheng@intel.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============7435274794587458512==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Linuxized patches are lack of patch headers, thus can not be
directly applied to the Linux source codes. This patch updates
the scripts to allow patch headers to be generated for the
linuxized patches.

Signed-off-by: Lv Zheng <lv.zheng(a)intel.com>
---
 generate/linux/patches/make-patches.pl |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/generate/linux/patches/make-patches.pl b/generate/linux/patche=
s/make-patches.pl
index 11d072a..a1f7699 100755
--- a/generate/linux/patches/make-patches.pl
+++ b/generate/linux/patches/make-patches.pl
@@ -344,6 +344,16 @@ sub make_patch
 =

     $linux_patch_count++;
 =

+    # Append the header
+
+    open(PTCH, ">>$file_name") or die ("Cannot open $file_name for appendi=
ng");
+    print(PTCH "From nobody\n");
+    print(PTCH "Subject: [Patch $linux_patch_count] ACPICA: $short_log\n");
+    print(PTCH "From: $patch_from\n");
+    print(PTCH "Date: $date\n");
+    print(PTCH "\n");
+    close(PTCH);
+
     # Format the log (eliminate long lines) and append it
 =

     system("rm -f temp temp2");
-- =

1.7.10


--===============7435274794587458512==--

