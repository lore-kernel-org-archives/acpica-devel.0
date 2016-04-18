Content-Type: multipart/mixed; boundary="===============4812446067460398588=="
MIME-Version: 1.0
From: Colin King <colin.king at canonical.com>
Subject: [Devel] [PATCH] tools/acpi: fix inverted logic when closing fd
Date: Mon, 18 Apr 2016 23:17:51 +0100
Message-ID: <1461017871-5395-1-git-send-email-colin.king@canonical.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============4812446067460398588==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Colin Ian King <colin.king(a)canonical.com>

The current close on fd only occurs when fd is -ve, it should
actually be closing the file if it a valid fd. Fix the inverted logic.

Signed-off-by: Colin Ian King <colin.king(a)canonical.com>
---
 tools/power/acpi/tools/acpidbg/acpidbg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/power/acpi/tools/acpidbg/acpidbg.c b/tools/power/acpi/to=
ols/acpidbg/acpidbg.c
index d070fcc..ebe44dd 100644
--- a/tools/power/acpi/tools/acpidbg/acpidbg.c
+++ b/tools/power/acpi/tools/acpidbg/acpidbg.c
@@ -430,7 +430,7 @@ int main(int argc, char **argv)
 	acpi_aml_loop(fd);
 =

 exit:
-	if (fd < 0)
+	if (fd >=3D 0)
 		close(fd);
 	if (acpi_aml_batch_cmd)
 		free(acpi_aml_batch_cmd);
-- =

2.7.4


--===============4812446067460398588==--

