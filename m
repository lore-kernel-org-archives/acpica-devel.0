Content-Type: multipart/mixed; boundary="===============5070242787655882411=="
MIME-Version: 1.0
From: Neel Natu <neelnatu at gmail.com>
Subject: Re: [Devel] Patch to override "Creator ID" and "Creator Revision"
Date: Mon, 11 Aug 2014 15:01:47 -0700
Message-ID: <CAFgRE9FwfupWSeYg7SJEc5t+CXfWztbHkfa=rQLWmDumWXaP_A@mail.gmail.com>
In-Reply-To: 94F2FBAB4432B54E8AACC7DFDE6C92E37D1D9061@ORSMSX112.amr.corp.intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============5070242787655882411==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Robert,

On Mon, Aug 11, 2014 at 2:40 PM, Moore, Robert <robert.moore(a)intel.com> w=
rote:
> CreatorID is meant to identify the compiler. The OemID, etc. are meant to=
 identify the manufacturer of the table.
>

Indeed. I got a bit carried away :-)

> So, why would you want to override the compiler revision? A different ver=
sion of the compiler can certainly generate different table contents, and t=
his helps us identify the compiler used to build the table.
>

I use this to compare the generated tables on different systems.

If the output changes because different compilers do output different
table contents then that's one thing.

However, if the only difference between the generated tables is due to
the compiler revision then I would like a way to control that. I
expect this to be the common case but perhaps I am mistaken?

best
Neel

>
>
>> -----Original Message-----
>> From: Devel [mailto:devel-bounces(a)acpica.org] On Behalf Of Moore, Robe=
rt
>> Sent: Monday, August 11, 2014 2:37 PM
>> To: Neel Natu; devel(a)acpica.org
>> Subject: Re: [Devel] Patch to override "Creator ID" and "Creator Revisio=
n"
>>
>> I doubt we would allow the creator ID to be overridden.
>>
>>
>>
>> > -----Original Message-----
>> > From: Devel [mailto:devel-bounces(a)acpica.org] On Behalf Of Neel Natu
>> > Sent: Monday, August 11, 2014 2:12 PM
>> > To: devel(a)acpica.org
>> > Subject: [Devel] Patch to override "Creator ID" and "Creator Revision"
>> >
>> > Hi,
>> >
>> > The following patch allows the "Creator ID" and "Creator Revision" to
>> > be overridden at compile time.
>> >
>> > At the moment the "Creator Revision" is a stand-in for the compiler
>> > version which implies that the tables change every time the compiler
>> > version changes. This patch decouples "Creator Revision" from the
>> > compiler version.
>> >
>> > It would be great if this could be committed.
>> >
>> > best
>> > Neel
>> >
>> > diff --git a/source/compiler/asldefine.h b/source/compiler/asldefine.h
>> > index b05bd7f..6a15bf1 100644
>> > --- a/source/compiler/asldefine.h
>> > +++ b/source/compiler/asldefine.h
>> > @@ -125,7 +125,9 @@
>> >  #define ASL_COMPILER_NAME           "ASL Optimizing Compiler"
>> >  #define AML_DISASSEMBLER_NAME       "AML Disassembler"
>> >  #define ASL_INVOCATION_NAME         "iasl"
>> > +#ifndef ASL_CREATOR_ID
>> >  #define ASL_CREATOR_ID              "INTL"
>> > +#endif
>> >
>> >  #define ASL_COMPLIANCE              "Supports ACPI Specification
>> Revision
>> > 5.1"
>> >
>> > diff --git a/source/include/acpixf.h b/source/include/acpixf.h index
>> > cafc37b..005325c 100644
>> > --- a/source/include/acpixf.h
>> > +++ b/source/include/acpixf.h
>> > @@ -118,7 +118,9 @@
>> >
>> >  /* Current ACPICA subsystem version in YYYYMMDD format */
>> >
>> > +#ifndef ACPI_CA_VERSION
>> >  #define ACPI_CA_VERSION                 0x20140724
>> > +#endif
>> >
>> >  #include "acconfig.h"
>> >  #include "actypes.h"
>> > _______________________________________________
>> > Devel mailing list
>> > Devel(a)acpica.org
>> > https://lists.acpica.org/mailman/listinfo/devel
>> _______________________________________________
>> Devel mailing list
>> Devel(a)acpica.org
>> https://lists.acpica.org/mailman/listinfo/devel

--===============5070242787655882411==--

