Content-Type: multipart/mixed; boundary="===============8202843987467752458=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: Re: [Devel] [PATCH] ACPICA: exfield: minor format change in
 error	message (fwd)
Date: Fri, 19 Feb 2010 09:08:47 -0800
Message-ID: <4911F71203A09E4D9981D27F9D830858599583B5@orsmsx503.amr.corp.intel.com>
In-Reply-To: 66D9D2F0CDB5C9428E6166B01EC85EE161E3A2E496@GVW0676EXC.americas.hpqcorp.net
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============8202843987467752458==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Thanks for your help, I'll roll this change into ACPICA today.


>-----Original Message-----
>From: Chumbalkar, Nagananda [mailto:Nagananda.Chumbalkar(a)hp.com]
>Sent: Friday, February 19, 2010 8:38 AM
>To: Moore, Robert; Len Brown; devel(a)acpica.org
>Cc: linux-acpi(a)vger.kernel.org
>Subject: RE: [Devel] [PATCH] ACPICA: exfield: minor format change in error
>message (fwd)
>
>[PATCH v2] ACPICA: exfield: minor format change in error message
>
>Change %X to %u.
>
>V1->V2:
>%d to %u
>
>Signed-off-by: Naga Chumbalkar <nagananda.chumbalkar(a)hp.com>
>
>diff --git a/drivers/acpi/acpica/exfield.c b/drivers/acpi/acpica/exfield.c
>index 1588a2d..b9400e7 100644
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
>+				    "length %u, found length %u",
> 				    length, source_desc->buffer.length));
>
> 			return_ACPI_STATUS(AE_AML_BUFFER_LIMIT);
>
>
>-----Original Message-----
>From: Moore, Robert [mailto:robert.moore(a)intel.com]
>Sent: Friday, February 19, 2010 1:49 AM
>To: Len Brown; devel(a)acpica.org
>Cc: linux-acpi(a)vger.kernel.org; Chumbalkar, Nagananda
>Subject: RE: [Devel] [PATCH] ACPICA: exfield: minor format
>change in error message (fwd)
>
>Yes.
>
>One nit:
>+				    "length %d, found length %d",
>
>We usually use %u on these:
>
>+				    "length %u, found length %u",
>
>>-----Original Message-----
>>From: devel-bounces(a)acpica.org
>[mailto:devel-bounces(a)acpica.org] On Behalf
>>Of Len Brown
>>Sent: Thursday, February 18, 2010 10:43 PM
>>To: devel(a)acpica.org
>>Cc: linux-acpi(a)vger.kernel.org; Naga Chumbalkar
>>Subject: [Devel] [PATCH] ACPICA: exfield: minor format change in error
>>message (fwd)
>>
>>Bob,
>>one for you.
>>
>>thanks,
>>Len Brown, Intel Open Source Technology Center
>>


--===============8202843987467752458==--

