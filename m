Content-Type: multipart/mixed; boundary="===============8936213137058503234=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: Re: [Devel] Base Address Granularity
Date: Thu, 03 Dec 2009 12:27:07 -0800
Message-ID: <4911F71203A09E4D9981D27F9D8308583E881CEE@orsmsx503.amr.corp.intel.com>
In-Reply-To: 136943.16644.qm@web62007.mail.re1.yahoo.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============8936213137058503234==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

There's more information in the actual specification of the I/O port descri=
ptor:

Base alignment, _ALN: Alignment for minimum base address, increment in 1-by=
te blocks.

I believe this is the required alignment within I/O space for the base addr=
ess that is programmed into the device. Where 0,1 =3D Byte aligned, 2 =3D w=
ord aligned, 4 =3D dword aligned, etc.

Bob


>-----Original Message-----
>From: devel-bounces(a)acpica.org [mailto:devel-bounces(a)acpica.org] On Be=
half
>Of master chief
>Sent: Thursday, December 03, 2009 11:28 AM
>To: devel(a)acpica.org
>Subject: [Devel] Base Address Granularity
>
>In the ACPI specification, under IO (IO Resource Descriptor Macro) I read:
>
>"AddressAlignment evaluates to an 8-bit integer that specifies the
>alignment granularity for the I/O address assigned. The field
>DescriptorName. _ALN is automatically created to refer to this portion of
>the resource descriptor."
>
>And while the latter part about the addition of _ALN is perfectly clear to
>me, I have trouble understanding the former part.  I looked at a number of
>Apple, Asus and GigaByte DSDT's and there I find Apple and GigaByte using a
>granularity of 0x01 and Asus 0x00.
>
>Apparently both work, even in my own DSDT code, but I cannot for the life
>of me find anything related to the exact meaning of this "granularity".
>
>Please advise.  Thank you.
>
>Chief
>
>
>
>_______________________________________________
>Devel mailing list
>Devel(a)acpica.org
>http://lists.acpica.org/listinfo/devel

--===============8936213137058503234==--

