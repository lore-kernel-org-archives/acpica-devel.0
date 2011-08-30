Content-Type: multipart/mixed; boundary="===============8123213631121602240=="
MIME-Version: 1.0
From: Thomas Renninger <trenn at suse.de>
Subject: [Devel] [PATCH] ACPICA: Fix wrongly mapped acpi table header when
 overriding via initrd
Date: Tue, 30 Aug 2011 13:30:40 +0200
Message-ID: <201108301330.40955.trenn@suse.de>
In-Reply-To: 1314179290-31526-2-git-send-email-trenn@suse.de
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============8123213631121602240==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Michael Chang <mchang(a)suse.com>

Fix the overriding ACPI table header do not override the existing ACPI
header thus the existing one is still in use. This caused a discrepency
of header and body, which would introdce a serios side effect that when
overriding DSDT, system might have error with "Unable to load the System
Description Tables" due to DSDT table verified failed.

Most field in ACPI table is static, but the length field is dyamically
changed and corresponds the new assembled *.aml size. We reserve the
ACPI data region using the overridden table size but attemps to map it
with existing ACPI table size introduced by above discrepency. It
would lead to remap fail during verifying DSDT able if length difference
cross a page boundary.

Signed-off-by: Michael Chang <mchang(a)suse.com>
---
 drivers/acpi/acpica/tbutils.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/acpica/tbutils.c b/drivers/acpi/acpica/tbutils.c
index df85afe..2e797d9 100644
--- a/drivers/acpi/acpica/tbutils.c
+++ b/drivers/acpi/acpica/tbutils.c
@@ -511,9 +511,9 @@ acpi_tb_install_table(acpi_physical_address address,
 				   ACPI_CAST_PTR(void, address)));
 			acpi_os_unmap_memory(mapped_table,
 					     sizeof(struct acpi_table_header));
+			address =3D tmp_addr;
 			mapped_table =3D acpi_os_map_memory(address,
 					  sizeof(struct acpi_table_header));
-			address =3D tmp_addr;
 		}
 		flags =3D ACPI_TABLE_ORIGIN_MAPPED;
 		table_to_install =3D mapped_table;
-- =

1.7.3.4


--===============8123213631121602240==--

