Content-Type: multipart/mixed; boundary="===============2935510332095043419=="
MIME-Version: 1.0
From: Vit Kabele <vit at kabele.me>
Subject: [Devel] [PATCH 1/3 RESEND] platform/x86: Check validity of EBDA
 pointer in mpparse.c
Date: Thu, 17 Mar 2022 19:58:37 +0100
Message-ID: <YjOE3QLbvU1d0wAX@czspare1-lap.sysgo.cz>
In-Reply-To: cover.1647526995.git.vit@kabele.me
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============2935510332095043419==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The pointer to EBDA area is retrieved from a word at 0x40e in BDA.
In case that the memory there is not initialized and contains garbage,
it might happen that the kernel touches memory above 640K.

This may cause unwanted reads from VGA memory which may not be decoded,
or even present when running under virtualization.

This patch adds sanity check for the EBDA pointer retrieved from the memory
so that scanning EBDA does not leave the low memory.

Signed-off-by: Vit Kabele <vit(a)kabele.me>
Reviewed-by: Rudolf Marek <r.marek(a)assembler.cz>
---
 arch/x86/include/asm/bios_ebda.h |  3 +++
 arch/x86/kernel/ebda.c           |  3 ---
 arch/x86/kernel/mpparse.c        | 12 +++++++++++-
 3 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/bios_ebda.h b/arch/x86/include/asm/bios_e=
bda.h
index 4d5a17e2febe..c3133c01d5b7 100644
--- a/arch/x86/include/asm/bios_ebda.h
+++ b/arch/x86/include/asm/bios_ebda.h
@@ -4,6 +4,9 @@
 =

 #include <asm/io.h>
 =

+#define BIOS_START_MIN		0x20000U	/* 128K, less than this is insane */
+#define BIOS_START_MAX		0x9f000U	/* 640K, absolute maximum */
+
 /*
  * Returns physical address of EBDA.  Returns 0 if there is no EBDA.
  */
diff --git a/arch/x86/kernel/ebda.c b/arch/x86/kernel/ebda.c
index 38e7d597b660..86c0801fc3ce 100644
--- a/arch/x86/kernel/ebda.c
+++ b/arch/x86/kernel/ebda.c
@@ -50,9 +50,6 @@
 =

 #define BIOS_RAM_SIZE_KB_PTR	0x413
 =

-#define BIOS_START_MIN		0x20000U	/* 128K, less than this is insane */
-#define BIOS_START_MAX		0x9f000U	/* 640K, absolute maximum */
-
 void __init reserve_bios_regions(void)
 {
 	unsigned int bios_start, ebda_start;
diff --git a/arch/x86/kernel/mpparse.c b/arch/x86/kernel/mpparse.c
index fed721f90116..6bba0744d32d 100644
--- a/arch/x86/kernel/mpparse.c
+++ b/arch/x86/kernel/mpparse.c
@@ -633,7 +633,17 @@ void __init default_find_smp_config(void)
 	 */
 =

 	address =3D get_bios_ebda();
-	if (address)
+
+	/* Check that the EBDA address is sane and the get_bios_ebda() did not
+	 * return just garbage from memory.
+	 * The upper bound is considered valid if it points below 1K before
+	 * end of the lower memory (i.e. 639K). The EBDA can be smaller
+	 * than 1K in which case the pointer will point above 639K but that
+	 * case is handled in step 2) above, and we don't need to adjust scan
+	 * size to not bump into the memory above 640K.
+	 */
+	if (address >=3D BIOS_START_MIN &&
+	    address < 639 * 0x400)
 		smp_scan_config(address, 0x400);
 }
 =

-- =

2.30.2

--===============2935510332095043419==--

