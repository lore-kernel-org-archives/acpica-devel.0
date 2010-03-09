Content-Type: multipart/mixed; boundary="===============1040247663237338094=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: Re: [Devel] Name object change produces unexpected errors.
Date: Tue, 09 Mar 2010 14:32:32 -0800
Message-ID: <4911F71203A09E4D9981D27F9D83085859F2B6D0@orsmsx503.amr.corp.intel.com>
In-Reply-To: 1268012324.3356.7.camel@minggr.sh.intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============1040247663237338094==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

We are adding additional support to the compiler for checking the types for=
 the predefined ACPI names. The problem you are seeing is in fact a regress=
ion in the current release. I would suggest that you use the previous relea=
se for now (version number 20100121)

>> We can't use 0x00 and 0x01 here, because then we are stuck with two
>"Optimizations".  That is a no go since I have to deliver a product without
>errors, warnings and optimizations.  I am confused.  What are we supposed
>to use now?

It's too bad you can't use optimizations, that is one of the distinct advan=
tages of the iASL compiler.



>-----Original Message-----
>From: Lin, Ming M
>Sent: Sunday, March 07, 2010 5:39 PM
>To: master chief; Moore, Robert
>Cc: devel(a)acpica.org
>Subject: Re: [Devel] Name object change produces unexpected errors.
>
>On Sun, 2010-03-07 at 16:43 +0800, master chief wrote:
>> I was kind of expecting this to happen:
>>
>> ----------------------------------------------------------------------
>> ssdt.dsl    80:             Name (_ADR, Zero)
>> Error    4080 -                            ^ Invalid object type for
>reserved name, must be (Integer)
>>
>> ssdt.dsl    81:             Name (_SUN, One)
>> Error    4080 -                           ^ Invalid object type for
>reserved name, must be (Integer)
>>
>> ASL Input:  ssdt.dsl - 328 lines, 9645 bytes, 79 keywords
>> Compilation complete. 2 Errors, 0 Warnings, 0 Remarks, 0 Optimizations
>> ----------------------------------------------------------------------
>>
>> But aren't the constants 'Zero' and 'One' supposed to be of type integer
>already?
>
>Yes, they are integer.
>There is a bug in the latest release(20100304).
>
>>
>> We can't use 0x00 and 0x01 here, because then we are stuck with two
>"Optimizations".  That is a no go since I have to deliver a product without
>errors, warnings and optimizations.  I am confused.  What are we supposed
>to use now?
>>
>
>Would you please apply this patch or use the old release?
>
>diff --git a/compiler/aslpredef.c b/compiler/aslpredef.c
>index 04cd2d4..30d33d5 100644
>--- a/compiler/aslpredef.c
>+++ b/compiler/aslpredef.c
>@@ -535,6 +535,9 @@ ApCheckObjectType (
>     switch (Op->Asl.ParseOpcode)
>     {
>     case PARSEOP_INTEGER:
>+    case PARSEOP_ZERO:
>+    case PARSEOP_ONE:
>+    case PARSEOP_ONES:
>         ReturnBtype =3D ACPI_RTYPE_INTEGER;
>         break;
>
>---
>Lin Ming


--===============1040247663237338094==--

