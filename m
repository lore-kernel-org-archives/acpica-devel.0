Content-Type: multipart/mixed; boundary="===============5526017340652053611=="
MIME-Version: 1.0
From: Vit Kabele <vit at kabele.me>
Subject: [Devel] [PATCH 2/3 RESEND] acpica: Check that the EBDA pointer is in
 valid range
Date: Thu, 17 Mar 2022 20:02:33 +0100
Message-ID: <YjOFyeR0OJfFsYjF@czspare1-lap.sysgo.cz>
In-Reply-To: cover.1647526995.git.vit@kabele.me
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============5526017340652053611==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If the memory at 0x40e is uninitialized, the retrieved physical_memory
address of EBDA may be beyond the low memory (i.e. above 640K).

If so, the kernel may unintentionally access the VGA memory, that
might not be decoded or even present in case of virtualization.

Signed-off-by: Vit Kabele <vit(a)kabele.me>
Reviewed-by: Rudolf Marek <r.marek(a)assembler.cz>
---
 drivers/acpi/acpica/tbxfroot.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpica/tbxfroot.c b/drivers/acpi/acpica/tbxfroot.c
index 9fec3df6c3ba..67b7df1c0520 100644
--- a/drivers/acpi/acpica/tbxfroot.c
+++ b/drivers/acpi/acpica/tbxfroot.c
@@ -138,8 +138,11 @@ acpi_find_root_pointer(acpi_physical_address *table_ad=
dress)
 	acpi_os_unmap_memory(table_ptr, ACPI_EBDA_PTR_LENGTH);
 =

 	/* EBDA present? */
-
-	if (physical_address > 0x400) {
+	/* Check that the EBDA pointer from 0x40e is sane and does not point
+	 * above valid low memory
+	 */
+	if (physical_address > 0x400 &&
+	    physical_address < 0xA0000) {
 		/*
 		 * 1b) Search EBDA paragraphs (EBDA is required to be a
 		 *     minimum of 1K length)
-- =

2.30.2

--===============5526017340652053611==--

