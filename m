Content-Type: multipart/mixed; boundary="===============4745282424408145521=="
MIME-Version: 1.0
From: Chumbalkar, Nagananda <Nagananda.Chumbalkar at hp.com>
Subject: Re: [Devel] [PATCH] ACPICA: exfield: minor format change in
 error	message (fwd)
Date: Fri, 19 Feb 2010 16:37:35 +0000
Message-ID: <66D9D2F0CDB5C9428E6166B01EC85EE161E3A2E496@GVW0676EXC.americas.hpqcorp.net>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============4745282424408145521==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

[PATCH v2] ACPICA: exfield: minor format change in error message

Change %X to %u.

V1->V2:
%d to %u

Signed-off-by: Naga Chumbalkar <nagananda.chumbalkar(a)hp.com>

diff --git a/drivers/acpi/acpica/exfield.c b/drivers/acpi/acpica/exfield.c
index 1588a2d..b9400e7 100644
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
+				    "length %u, found length %u",
 				    length, source_desc->buffer.length));
 =

 			return_ACPI_STATUS(AE_AML_BUFFER_LIMIT);


-----Original Message-----
From: Moore, Robert [mailto:robert.moore(a)intel.com] =

Sent: Friday, February 19, 2010 1:49 AM
To: Len Brown; devel(a)acpica.org
Cc: linux-acpi(a)vger.kernel.org; Chumbalkar, Nagananda
Subject: RE: [Devel] [PATCH] ACPICA: exfield: minor format =

change in error message (fwd)

Yes.

One nit:
+				    "length %d, found length %d",

We usually use %u on these:

+				    "length %u, found length %u",

>-----Original Message-----
>From: devel-bounces(a)acpica.org =

[mailto:devel-bounces(a)acpica.org] On Behalf
>Of Len Brown
>Sent: Thursday, February 18, 2010 10:43 PM
>To: devel(a)acpica.org
>Cc: linux-acpi(a)vger.kernel.org; Naga Chumbalkar
>Subject: [Devel] [PATCH] ACPICA: exfield: minor format change in error
>message (fwd)
>
>Bob,
>one for you.
>
>thanks,
>Len Brown, Intel Open Source Technology Center
>

--===============4745282424408145521==--

