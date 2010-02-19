Content-Type: multipart/mixed; boundary="===============5616483867320618569=="
MIME-Version: 1.0
From: Len Brown <lenb at kernel.org>
Subject: [Devel] [PATCH] ACPICA: exfield: minor format change in error message
 (fwd)
Date: Fri, 19 Feb 2010 01:42:40 -0500
Message-ID: <alpine.LFD.2.00.1002190141280.24628@localhost.localdomain>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============5616483867320618569==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Bob,
one for you.

thanks,
Len Brown, Intel Open Source Technology Center

---------- Forwarded message ----------
Date: Wed, 17 Feb 2010 03:13:27 +0000 (UTC)
From: Naga Chumbalkar <nagananda.chumbalkar(a)hp.com>
To: len.brown(a)intel.com
Cc: linux-acpi(a)vger.kernel.org, Naga Chumbalkar <nagananda.chumbalkar(a)h=
p.com>
Subject: [PATCH] ACPICA: exfield: minor format change in error message

Found this while debugging a problem.  Trivial, but useful, format change.

Before:
ACPI Error: SMBus or IPMI write requires Buffer of length 42, found length =
20
(20091214/exfield-285)

After:
ACPI Error: SMBus or IPMI write requires Buffer of length 66, found length =
32
(20091214/exfield-286)

Signed-off-by: Naga Chumbalkar <nagananda.chumbalkar(a)hp.com>

diff --git a/drivers/acpi/acpica/exfield.c b/drivers/acpi/acpica/exfield.c
index 1588a2d..be2b03a 100644
--- a/drivers/acpi/acpica/exfield.c
+++ b/drivers/acpi/acpica/exfield.c
@@ -281,7 +281,8 @@ acpi_ex_write_data_to_field(union acpi_operand_object *=
source_desc,
 =

 		if (source_desc->buffer.length < length) {
 			ACPI_ERROR((AE_INFO,
-				    "SMBus or IPMI write requires Buffer of length %X, found length %X=
",
+				    "SMBus or IPMI write requires Buffer of "
+				    "length %d, found length %d",
 				    length, source_desc->buffer.length));
 =

 			return_ACPI_STATUS(AE_AML_BUFFER_LIMIT);
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
the body of a message to majordomo(a)vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

--===============5616483867320618569==--

