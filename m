Content-Type: multipart/mixed; boundary="===============8741531369568290912=="
MIME-Version: 1.0
From: Colin King <colin.king at canonical.com>
Subject: [Devel] [PATCH] AcpiExec: Add in missing TableEvents INSTALL and
 UNINSTALL
Date: Fri, 26 Aug 2016 22:54:09 +0100
Message-ID: <20160826215409.9843-1-colin.king@canonical.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============8741531369568290912==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Colin Ian King <colin.king(a)canonical.com>

commit ed6a5fbc694f3a27d93014391aa9a6f6fe490461 ("Tables: Add
new table events indicating table installation/uninstallation") added
new table events but the TableEvents array was not updated with
these two new events.  Update TableEvents with the new INSTALL
and UNINSTALL event types.

Signed-off-by: Colin Ian King <colin.king(a)canonical.com>
---
 source/tools/acpiexec/aehandlers.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/source/tools/acpiexec/aehandlers.c b/source/tools/acpiexec/aeh=
andlers.c
index f08ffbe..b52e4d8 100644
--- a/source/tools/acpiexec/aehandlers.c
+++ b/source/tools/acpiexec/aehandlers.c
@@ -187,6 +187,8 @@ static char                *TableEvents[] =3D
 {
     "LOAD",
     "UNLOAD",
+    "INSTALL",
+    "UNINSTALL",
     "UNKNOWN"
 };
 #endif /* !ACPI_REDUCED_HARDWARE */
-- =

2.9.3


--===============8741531369568290912==--

