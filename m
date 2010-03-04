Content-Type: multipart/mixed; boundary="===============6180092688485920976=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: Re: [Devel] [PATCH] ACPICA: exfield: minor format change in error
 message (fwd)
Date: Thu, 04 Mar 2010 12:46:19 -0800
Message-ID: <4911F71203A09E4D9981D27F9D83085859DCCF35@orsmsx503.amr.corp.intel.com>
In-Reply-To: 4911F71203A09E4D9981D27F9D830858599586A7@orsmsx503.amr.corp.intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============6180092688485920976==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This change and dozens of other were made and released for ACPICA version 2=
0100304, with the following description:


Standardized output of integer values for ACPICA warnings/errors. Always us=
e 0x prefix for hex output, always use %u for unsigned integer decimal outp=
ut. Affects ACPI_INFO, ACPI_ERROR, ACPI_EXCEPTION, and ACPI_WARNING (about =
400 invocations.) These invocations were converted from the original ACPI_D=
EBUG_PRINT invocations and were not consistent. ACPICA BZ 835.


Thanks for the help,
Bob


>-----Original Message-----
>From: Moore, Robert
>Sent: Friday, February 19, 2010 12:18 PM
>To: Moore, Robert; Chumbalkar, Nagananda; Len Brown; devel(a)acpica.org
>Cc: linux-acpi(a)vger.kernel.org
>Subject: RE: [Devel] [PATCH] ACPICA: exfield: minor format change in error
>message (fwd)
>
>I've discovered that this is a far bigger issue than one change in one
>file.
>
>Most all of the invocations of ACPI_ERROR use %X to format an integer
>value. Most of these invocations were originally debug statements where all
>output was assumed to be in hex. In today's environment, we should follow
>standard conventions for such output -- meaning prefix all of the %X
>formats with 0x, or convert all %X to %u.
>
>So, I'm going to open a bugzilla on this issue so we can address all
>invocations of ACPI_ERROR (and ACPI_WARNING) at the same time. There are
>over 300 invocations of these macros across ACPICA.
>
>Bob
>
>
>>-----Original Message-----
>>From: devel-bounces(a)acpica.org [mailto:devel-bounces(a)acpica.org] On B=
ehalf
>>Of Moore, Robert
>>Sent: Friday, February 19, 2010 9:09 AM
>>To: Chumbalkar, Nagananda; Len Brown; devel(a)acpica.org
>>Cc: linux-acpi(a)vger.kernel.org
>>Subject: Re: [Devel] [PATCH] ACPICA: exfield: minor format change in error
>>message (fwd)
>>
>>Thanks for your help, I'll roll this change into ACPICA today.
>>
>>
>>>-----Original Message-----
>>>From: Chumbalkar, Nagananda [mailto:Nagananda.Chumbalkar(a)hp.com]
>>>Sent: Friday, February 19, 2010 8:38 AM
>>>To: Moore, Robert; Len Brown; devel(a)acpica.org
>>>Cc: linux-acpi(a)vger.kernel.org
>>>Subject: RE: [Devel] [PATCH] ACPICA: exfield: minor format change in
>error
>>>message (fwd)
>>>
>>>[PATCH v2] ACPICA: exfield: minor format change in error message
>>>
>>>Change %X to %u.
>>>
>>>V1->V2:
>>>%d to %u
>>>
>>>Signed-off-by: Naga Chumbalkar <nagananda.chumbalkar(a)hp.com>
>>>
>>>diff --git a/drivers/acpi/acpica/exfield.c
>b/drivers/acpi/acpica/exfield.c
>>>index 1588a2d..b9400e7 100644
>>>--- a/drivers/acpi/acpica/exfield.c
>>>+++ b/drivers/acpi/acpica/exfield.c
>>>@@ -281,7 +281,8 @@ acpi_ex_write_data_to_field(union acpi_operand_object
>>>*source_desc,
>>>
>>> 		if (source_desc->buffer.length < length) {
>>> 			ACPI_ERROR((AE_INFO,
>>>-				    "SMBus or IPMI write requires Buffer of length
>>>%X, found length %X",
>>>+				    "SMBus or IPMI write requires Buffer of "
>>>+				    "length %u, found length %u",
>>> 				    length, source_desc->buffer.length));
>>>
>>> 			return_ACPI_STATUS(AE_AML_BUFFER_LIMIT);
>>>
>>>
>>>-----Original Message-----
>>>From: Moore, Robert [mailto:robert.moore(a)intel.com]
>>>Sent: Friday, February 19, 2010 1:49 AM
>>>To: Len Brown; devel(a)acpica.org
>>>Cc: linux-acpi(a)vger.kernel.org; Chumbalkar, Nagananda
>>>Subject: RE: [Devel] [PATCH] ACPICA: exfield: minor format
>>>change in error message (fwd)
>>>
>>>Yes.
>>>
>>>One nit:
>>>+				    "length %d, found length %d",
>>>
>>>We usually use %u on these:
>>>
>>>+				    "length %u, found length %u",
>>>
>>>>-----Original Message-----
>>>>From: devel-bounces(a)acpica.org
>>>[mailto:devel-bounces(a)acpica.org] On Behalf
>>>>Of Len Brown
>>>>Sent: Thursday, February 18, 2010 10:43 PM
>>>>To: devel(a)acpica.org
>>>>Cc: linux-acpi(a)vger.kernel.org; Naga Chumbalkar
>>>>Subject: [Devel] [PATCH] ACPICA: exfield: minor format change in error
>>>>message (fwd)
>>>>
>>>>Bob,
>>>>one for you.
>>>>
>>>>thanks,
>>>>Len Brown, Intel Open Source Technology Center
>>>>
>>
>>_______________________________________________
>>Devel mailing list
>>Devel(a)acpica.org
>>http://lists.acpica.org/listinfo/devel

--===============6180092688485920976==--

