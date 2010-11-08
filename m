Content-Type: multipart/mixed; boundary="===============4564875846727787023=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: Re: [Devel] Why are empty packages invalid for predefined ACPI
 objects?
Date: Sun, 07 Nov 2010 20:23:38 -0800
Message-ID: <4911F71203A09E4D9981D27F9D830858BC4F53A1@orsmsx503.amr.corp.intel.com>
In-Reply-To: 4CD572F2.8010805@gmail.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============4564875846727787023==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

I'd have to go through the spec, but thinking about it, I'm not sure that a=
ny predefined name allows an empty package. All the definitions are either =
1) Fixed length package, or 2) Variable length package that is defined as "=
one or more..."



>-----Original Message-----
>From: Moore, Robert
>Sent: Sunday, November 07, 2010 8:13 PM
>To: 'Gr=C3=A9goire Sutre'; devel(a)acpica.org
>Cc: Lin, Ming M
>Subject: RE: [Devel] Why are empty packages invalid for predefined ACPI
>objects?
>
>It may not be strictly against the acpi spec, but we'd like to see if this
>is happening on any platforms.
>
>I'm not sure I can think of a really valid reason why this should happen
>for the predefined objects.
>
>
>
>>-----Original Message-----
>>From: devel-bounces(a)acpica.org [mailto:devel-bounces(a)acpica.org] On B=
ehalf
>>Of Gr=C3=A9goire Sutre
>>Sent: Saturday, November 06, 2010 8:24 AM
>>To: devel(a)acpica.org
>>Subject: [Devel] Why are empty packages invalid for predefined ACPI
>>objects?
>>
>>Hi,
>>
>>The package validation function AcpiNsCheckPackage() in file nspredef.c
>>requires that packages be non-empty:
>>
>>     /* The package must have at least one element, else invalid */
>>
>>     if (!Count)
>>     {
>>         ACPI_WARN_PREDEFINED ((AE_INFO, Data->Pathname, Data->NodeFlags,
>>             "Return Package has no elements (empty)"));
>>
>>         return (AE_AML_OPERAND_VALUE);
>>     }
>>
>>I don't see, from the ACPI specification, why packages for predefined
>>ACPI objects must be non-empty.
>>
>>Where does this requirement come from?
>>
>>Best regards,
>>
>>Gr=C3=A9goire Sutre
>>_______________________________________________
>>Devel mailing list
>>Devel(a)acpica.org
>>http://lists.acpica.org/listinfo/devel

--===============4564875846727787023==--

