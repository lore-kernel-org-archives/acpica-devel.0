Content-Type: multipart/mixed; boundary="===============0409665577598942356=="
MIME-Version: 1.0
From: Colin King <colin.king at canonical.com>
Subject: [Devel] [PATCH] tools/power/acpi: close file only if it is open
Date: Fri, 18 Mar 2016 14:28:32 +0000
Message-ID: <1458311312-23330-1-git-send-email-colin.king@canonical.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============0409665577598942356==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Colin Ian King <colin.king(a)canonical.com>

the logic on the test for a valid fd to close is incorrect and
the current code will close -ve fd's which is not was intended.
Since the only path to the exit label is on a failed open, we
may as well just close fd if it has been opened successfully
before the exit label and also remove the valid fd check.

Signed-off-by: Colin Ian King <colin.king(a)canonical.com>
---
 tools/power/acpi/tools/acpidbg/acpidbg.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/power/acpi/tools/acpidbg/acpidbg.c b/tools/power/acpi/to=
ols/acpidbg/acpidbg.c
index d070fcc..38ccac9 100644
--- a/tools/power/acpi/tools/acpidbg/acpidbg.c
+++ b/tools/power/acpi/tools/acpidbg/acpidbg.c
@@ -429,9 +429,8 @@ int main(int argc, char **argv)
 		acpi_aml_flush(fd);
 	acpi_aml_loop(fd);
 =

+	close(fd);
 exit:
-	if (fd < 0)
-		close(fd);
 	if (acpi_aml_batch_cmd)
 		free(acpi_aml_batch_cmd);
 	return ret;
-- =

2.7.3


--===============0409665577598942356==--

