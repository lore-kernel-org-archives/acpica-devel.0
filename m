Content-Type: multipart/mixed; boundary="===============1176811512823847201=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: Re: [Devel] Concatenate() operator
Date: Fri, 02 Jun 2017 21:37:27 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37E5BD78B@ORSMSX110.amr.corp.intel.com>
In-Reply-To: a441a8b4-fb86-e3b6-2dbf-a43de32b910a@redhat.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============1176811512823847201==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



> -----Original Message-----
> From: Al Stone [mailto:ahs3(a)redhat.com]
> Sent: Friday, June 2, 2017 8:59 AM
> To: Moore, Robert <robert.moore(a)intel.com>; devel(a)acpica.org
> Subject: Re: [Devel] Concatenate() operator
> =

> On 06/02/2017 08:48 AM, Moore, Robert wrote:
> >
> > There are a few things going on here.
> >
> > 1) The version of the DSDT is 1, so integers are 32 bits (as per ACPI
> specification). So, any integers larger than 32 bits are truncated to 32
> bits. Change the version to 2, and you will get 64-bit integers.
> =

> Ah.  Missed this part.  That helps some.
> =

> > 2) Yes, the strings will be converted to integers
> >
> > 2) The compiler is folding both Concatenate operators to simple
> constants (buffers).
> =

> Yup, got that part.
> =

> > 3)The string-to-integer implicit conversion is in fact covered by the
> ACPI spec, and the strings are always treated as hex constants, as
> below:
> >
> > 19.3.5.7 Data Type Conversion Rules
> >
> > From String-to-Integer conversion section from the table:
> >
> > "the ASCII string is interpreted as a hexadecimal constant"
> > "a 0x prefix is not allowed"
> >
> > There are no octal constants in all of ACPI, BTW.
> =

> Okay.  Now I see why this happens.  Thanks.
> =

> The part about octal is not correct, though.  ASL literal constants are
> allowed to be decimal, hexadecimal, or octal -- =

[Moore, Robert] =


Yes, it looks like you are right about this. We'll investigate a bit furthe=
r.
Thanks,
Bob



that's what section
> 19.3.2.1 says quite explicitly.  iasl does appear to behave properly
> with 32-bit values, but it looks like 64-bit octal conversion is off a
> bit; here's a simple test case for
> that:
> =

> DefinitionBlock ("", "DSDT", 2, "xxxxx", "Many", 0x00000001) {
> 	Name (WBCD, 321)
> 	Name (WBCO, 0321)
> 	Name (WBCX, 0x0321)
> =

> 	Name (QBCD, 987654321987654321)
> 	Name (QBCO, 066646645757675011261)
> 	Name (QBCX, 0xdb4da5f7ef412b1)
> }
> =

> The QBC* values should all produce identical bytes; decimal and hex are
> correct.
> =

> > I think this covers your questions.
> > Bob
> >
> >
> =

> =

> --
> ciao,
> al
> -----------------------------------
> Al Stone
> Software Engineer
> Red Hat, Inc.
> ahs3(a)redhat.com
> -----------------------------------

--===============1176811512823847201==--

