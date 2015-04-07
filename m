Content-Type: multipart/mixed; boundary="===============7006278464095905907=="
MIME-Version: 1.0
From: Bob Paauwe <bob.j.paauwe at intel.com>
Subject: [Devel] [PATCH 1/2] Remove extra release mutex call.
Date: Tue, 07 Apr 2015 09:52:14 -0700
Message-ID: <1428425535-31774-2-git-send-email-bob.j.paauwe@intel.com>
In-Reply-To: 1428425535-31774-1-git-send-email-bob.j.paauwe@intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============7006278464095905907==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Remove the release mutex call when a table is re-loaded. This seems to
be here to release a mutex that was aquired at one time in table verify
function.  That aquire is no longer present, so remove the release.

Signed-off-by: Bob Paauwe <bob.j.paauwe(a)intel.com>
---
 drivers/acpi/acpica/tbinstal.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/acpi/acpica/tbinstal.c b/drivers/acpi/acpica/tbinstal.c
index 9bad45e..7fbc2b9 100644
--- a/drivers/acpi/acpica/tbinstal.c
+++ b/drivers/acpi/acpica/tbinstal.c
@@ -346,7 +346,6 @@ acpi_tb_install_standard_table(acpi_physical_address ad=
dress,
 				 */
 				acpi_tb_uninstall_table(&new_table_desc);
 				*table_index =3D i;
-				(void)acpi_ut_release_mutex(ACPI_MTX_TABLES);
 				return_ACPI_STATUS(AE_OK);
 			}
 		}
-- =

2.1.0


--===============7006278464095905907==--

