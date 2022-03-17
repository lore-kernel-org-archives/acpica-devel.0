Content-Type: multipart/mixed; boundary="===============5263168454860758582=="
MIME-Version: 1.0
From: Vit Kabele <vit at kabele.me>
Subject: [Devel] [PATCH 3/3 RESEND] acpica: Do not touch VGA memory when EBDA
 < 1KiB
Date: Thu, 17 Mar 2022 20:03:03 +0100
Message-ID: <YjOF5y0Edc0IdSOR@czspare1-lap.sysgo.cz>
In-Reply-To: cover.1647526995.git.vit@kabele.me
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============5263168454860758582==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The ACPICA code assumes that EBDA region must be at least 1KiB in size.
Because this is not guaranteed, it might happen that while scanning the
memory for RSDP pointer, the kernel touches memory above 640KiB.

This is unwanted as the VGA memory range may not be decoded or
even present when running under virtualization.

Signed-off-by: Vit Kabele <vit(a)kabele.me>
Reviewed-by: Rudolf Marek <r.marek(a)assembler.cz>
---
 drivers/acpi/acpica/tbxfroot.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/acpica/tbxfroot.c b/drivers/acpi/acpica/tbxfroot.c
index 67b7df1c0520..b1f4a91044d9 100644
--- a/drivers/acpi/acpica/tbxfroot.c
+++ b/drivers/acpi/acpica/tbxfroot.c
@@ -114,6 +114,7 @@ acpi_find_root_pointer(acpi_physical_address *table_add=
ress)
 	u8 *table_ptr;
 	u8 *mem_rover;
 	u32 physical_address;
+	u32 ebda_window_size;
 =

 	ACPI_FUNCTION_TRACE(acpi_find_root_pointer);
 =

@@ -143,25 +144,32 @@ acpi_find_root_pointer(acpi_physical_address *table_a=
ddress)
 	 */
 	if (physical_address > 0x400 &&
 	    physical_address < 0xA0000) {
+		/* Calculate the scan window size
+		 * The EBDA is not guaranteed to be larger than a KiB
+		 * and in case that it is smaller the scanning function would
+		 * leave the low memory and continue to the VGA range.
+		 */
+		ebda_window_size =3D ACPI_MIN(ACPI_EBDA_WINDOW_SIZE,
+					    0xA0000 - physical_address);
+
 		/*
-		 * 1b) Search EBDA paragraphs (EBDA is required to be a
-		 *     minimum of 1K length)
+		 * 1b) Search EBDA paragraphs
 		 */
 		table_ptr =3D acpi_os_map_memory((acpi_physical_address)
 					       physical_address,
-					       ACPI_EBDA_WINDOW_SIZE);
+					       ebda_window_size);
 		if (!table_ptr) {
 			ACPI_ERROR((AE_INFO,
 				    "Could not map memory at 0x%8.8X for length %u",
-				    physical_address, ACPI_EBDA_WINDOW_SIZE));
+				    physical_address, ebda_window_size));
 =

 			return_ACPI_STATUS(AE_NO_MEMORY);
 		}
 =

 		mem_rover =3D
 		    acpi_tb_scan_memory_for_rsdp(table_ptr,
-						 ACPI_EBDA_WINDOW_SIZE);
-		acpi_os_unmap_memory(table_ptr, ACPI_EBDA_WINDOW_SIZE);
+						 ebda_window_size);
+		acpi_os_unmap_memory(table_ptr, ebda_window_size);
 =

 		if (mem_rover) {
 =

-- =

2.30.2

--===============5263168454860758582==--

