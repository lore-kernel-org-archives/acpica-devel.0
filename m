Content-Type: multipart/mixed; boundary="===============8617996283436426855=="
MIME-Version: 1.0
From: Colin King <colin.king at canonical.com>
Subject: [Devel] [PATCH] ACPI / util: cast data to u64 before shifting to fix
 sign extension
Date: Fri, 18 Mar 2016 15:08:01 +0000
Message-ID: <1458313681-24239-1-git-send-email-colin.king@canonical.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============8617996283436426855==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Colin Ian King <colin.king(a)canonical.com>

obj->buffer.pointer[i] should be cast to u64 to prevent an unintentional
sign extension.  For example, if pointer[7] is 0x80, then the value
0xffffffffff000000 is or'd into mask rather than the intended value
0xff00000000000000

Detected with static analysis by CoverityScan

Signed-off-by: Colin Ian King <colin.king(a)canonical.com>
---
 drivers/acpi/utils.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/utils.c b/drivers/acpi/utils.c
index f12a724..050673f 100644
--- a/drivers/acpi/utils.c
+++ b/drivers/acpi/utils.c
@@ -692,7 +692,7 @@ bool acpi_check_dsm(acpi_handle handle, const u8 *uuid,=
 int rev, u64 funcs)
 		mask =3D obj->integer.value;
 	else if (obj->type =3D=3D ACPI_TYPE_BUFFER)
 		for (i =3D 0; i < obj->buffer.length && i < 8; i++)
-			mask |=3D (((u8)obj->buffer.pointer[i]) << (i * 8));
+			mask |=3D (((u64)obj->buffer.pointer[i]) << (i * 8));
 	ACPI_FREE(obj);
 =

 	/*
-- =

2.7.3


--===============8617996283436426855==--

