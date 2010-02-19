Content-Type: multipart/mixed; boundary="===============5615008596937566318=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: Re: [Devel] [PATCH] ACPICA: exfield: minor format change in
 error	message (fwd)
Date: Thu, 18 Feb 2010 23:48:43 -0800
Message-ID: <4911F71203A09E4D9981D27F9D8308585995823D@orsmsx503.amr.corp.intel.com>
In-Reply-To: alpine.LFD.2.00.1002190141280.24628@localhost.localdomain
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============5615008596937566318==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Yes.

One nit:
+				    "length %d, found length %d",

We usually use %u on these:

+				    "length %u, found length %u",

>-----Original Message-----
>From: devel-bounces(a)acpica.org [mailto:devel-bounces(a)acpica.org] On Be=
half
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
>---------- Forwarded message ----------
>Date: Wed, 17 Feb 2010 03:13:27 +0000 (UTC)
>From: Naga Chumbalkar <nagananda.chumbalkar(a)hp.com>
>To: len.brown(a)intel.com
>Cc: linux-acpi(a)vger.kernel.org, Naga Chumbalkar
><nagananda.chumbalkar(a)hp.com>
>Subject: [PATCH] ACPICA: exfield: minor format change in error message
>
>Found this while debugging a problem.  Trivial, but useful, format change.
>
>Before:
>ACPI Error: SMBus or IPMI write requires Buffer of length 42, found length
>20
>(20091214/exfield-285)
>
>After:
>ACPI Error: SMBus or IPMI write requires Buffer of length 66, found length
>32
>(20091214/exfield-286)
>
>Signed-off-by: Naga Chumbalkar <nagananda.chumbalkar(a)hp.com>
>
>diff --git a/drivers/acpi/acpica/exfield.c b/drivers/acpi/acpica/exfield.c
>index 1588a2d..be2b03a 100644
>--- a/drivers/acpi/acpica/exfield.c
>+++ b/drivers/acpi/acpica/exfield.c
>@@ -281,7 +281,8 @@ acpi_ex_write_data_to_field(union acpi_operand_object
>*source_desc,
>
> 		if (source_desc->buffer.length < length) {
> 			ACPI_ERROR((AE_INFO,
>-				    "SMBus or IPMI write requires Buffer of length
>%X, found length %X",
>+				    "SMBus or IPMI write requires Buffer of "
>+				    "length %d, found length %d",
> 				    length, source_desc->buffer.length));
>
> 			return_ACPI_STATUS(AE_AML_BUFFER_LIMIT);
>--
>To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
>the body of a message to majordomo(a)vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>_______________________________________________
>Devel mailing list
>Devel(a)acpica.org
>http://lists.acpica.org/listinfo/devel

--===============5615008596937566318==--

