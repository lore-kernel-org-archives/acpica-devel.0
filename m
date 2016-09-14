Content-Type: multipart/mixed; boundary="===============0574510905437855918=="
MIME-Version: 1.0
From: Zheng, Lv <lv.zheng at intel.com>
Subject: Re: [Devel] [PATCH] ACPICA / Interpreter: Remove redundant newline
Date: Wed, 14 Sep 2016 03:14:27 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E886A184A06@SHSMSX101.ccr.corp.intel.com>
In-Reply-To: 1473447344.10509.3.camel@perches.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============0574510905437855918==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

> From: Joe Perches [mailto:joe(a)perches.com]
> Subject: Re: [PATCH] ACPICA / Interpreter: Remove redundant newline
> =

> On Fri, 2016-09-09 at 20:40 +0200, Borislav Petkov wrote:
> > On Fri, Sep 09, 2016 at 06:26:17PM +0000, Moore, Robert wrote:
> > > Is this a big deal?
> > > We do this on purpose for AcpiExec, to make the screen output more re=
adable.
> []
> > What do you mean "big deal"? All other ACPI_INFO calls don't have a "\n"
> > at the end except this one. How does one "\n" make some output more
> > readable?
> =

> Blank lines in logging/dmesg generally don't add value.
> =

> I would prefer if the unnecessary double parentheses also
> were removed in these macro uses and ##__VA_ARGS__ was
> used instead.

Ideally correct.
But __VA_ARGS__ is not portable.
And ACPICA is used in other environment.
I'd prefer to eliminate debugging/logging macros, but implement debugging/l=
ogging functions instead.
As stdarg is more portable than __VA_ARGS__.

Thanks and best regards
Lv

> =

> /*
>  * Error reporting. Callers module and line number are inserted by AE_INF=
O,
>  * the plist contains a set of parens to allow variable-length lists.
>  * These macros are used for both the debug and non-debug versions of the=
 code.
>  */
> #define ACPI_INFO(plist)                acpi_info plist
> #define ACPI_WARNING(plist)             acpi_warning plist
> #define ACPI_EXCEPTION(plist)           acpi_exception plist
> #define ACPI_ERROR(plist)               acpi_error plist
> #define ACPI_BIOS_WARNING(plist)        acpi_bios_warning plist
> #define ACPI_BIOS_ERROR(plist)          acpi_bios_error plist
> =

> It would also be good if format/argument verification
> was done here and in the non-debug macro variants.
> =

> #define ACPI_INFO(plist)
> #define ACPI_WARNING(plist)
> #define ACPI_EXCEPTION(plist)
> #define ACPI_ERROR(plist)
> #define ACPI_BIOS_WARNING(plist)
> #define ACPI_BIOS_ERROR(plist)


--===============0574510905437855918==--

