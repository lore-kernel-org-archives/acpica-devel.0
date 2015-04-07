Content-Type: multipart/mixed; boundary="===============4234237601028973941=="
MIME-Version: 1.0
From: Bob Paauwe <bob.j.paauwe at intel.com>
Subject: [Devel] [PATCH 2/2] Acutally unload a table.
Date: Tue, 07 Apr 2015 09:52:15 -0700
Message-ID: <1428425535-31774-3-git-send-email-bob.j.paauwe@intel.com>
In-Reply-To: 1428425535-31774-1-git-send-email-bob.j.paauwe@intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============4234237601028973941==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Instead of simply marking it as unloaded.  If a table is dynamically
loaded by a module and the module is then unloaded, the table is no
longer valid so it's best to make sure it is unloaded.

Signed-off-by: Bob Paauwe <bob.j.paauwe(a)intel.com>
---
 drivers/acpi/acpica/tbxfload.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/acpi/acpica/tbxfload.c b/drivers/acpi/acpica/tbxfload.c
index aadb300..ce75ca2 100644
--- a/drivers/acpi/acpica/tbxfload.c
+++ b/drivers/acpi/acpica/tbxfload.c
@@ -408,6 +408,7 @@ acpi_status acpi_unload_parent_table(acpi_handle object)
 =

 		status =3D acpi_tb_release_owner_id(i);
 		acpi_tb_set_table_loaded_flag(i, FALSE);
+		acpi_tb_uninstall_table(&acpi_gbl_root_table_list.tables[i]);
 		break;
 	}
 =

-- =

2.1.0


--===============4234237601028973941==--

