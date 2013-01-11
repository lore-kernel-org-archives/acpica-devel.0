Content-Type: multipart/mixed; boundary="===============4551615518990125596=="
MIME-Version: 1.0
From: Lv Zheng <lv.zheng at intel.com>
Subject: [Devel] [PATCH v2 2/2] ACPICA: Linuxize: Move acpisrc generation from
 make-patch.pl to linuxize.sh.
Date: Sat, 12 Jan 2013 01:18:36 +0800
Message-ID: <f882e6c90c8a65aa62da024678128fde6691db67.1357924466.git.lv.zheng@intel.com>
In-Reply-To: cover.1357924466.git.lv.zheng@intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============4551615518990125596==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This fix can help to generate correct linuxized patch where the
version of the acpisrc is critical.

Signed-off-by: Lv Zheng <lv.zheng(a)intel.com>
---
 generate/linux/patches/linuxize.sh     |    5 +++++
 generate/linux/patches/make-patches.pl |    5 -----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/generate/linux/patches/linuxize.sh b/generate/linux/patches/li=
nuxize.sh
index f4ac142..50163d3 100755
--- a/generate/linux/patches/linuxize.sh
+++ b/generate/linux/patches/linuxize.sh
@@ -17,6 +17,11 @@ if [ ! -z "$version" ] ; then
 	)
 fi
 =

+# Generate latest version of the acpisrc utility
+
+echo "[linuxize.sh] Generate acpisrc utility from source"
+sh acpisrc.sh $git_root > /dev/null
+
 rm -rf new.linux
 echo "[linuxize.sh] Coverting format (AcpiSrc)..."
 bin/acpisrc -ldqy $git_root/source new.linux > /dev/null
diff --git a/generate/linux/patches/make-patches.pl b/generate/linux/patche=
s/make-patches.pl
index 7e643f0..1ed1cdc 100755
--- a/generate/linux/patches/make-patches.pl
+++ b/generate/linux/patches/make-patches.pl
@@ -85,11 +85,6 @@ system("rm -rf $git_root; git clone $git_repo $git_root =
> /dev/null");
 system("cd $git_root; old_release=3D`git log --pretty=3Dformat:%H $old_rel=
ease~1..$old_release`");
 system("cd $git_root; new_release=3D`git log --pretty=3Dformat:%H $new_rel=
ease~1..$new_release`");
 =

-# Generate latest version of the acpisrc utility
-
-system("echo [make-patches] Generate acpisrc utility from source");
-system("sh acpisrc.sh $git_root > /dev/null");
-
 =

 # Create GIT log
 =

-- =

1.7.10


--===============4551615518990125596==--

