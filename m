Content-Type: multipart/mixed; boundary="===============6956660007573514769=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: [Devel] Re: [PATCH] ACPICA: fix -Wfallthrough
Date: Fri, 13 Nov 2020 21:01:24 +0000
Message-ID: <BYAPR11MB3256ECDE31F1900EE1D9254687E60@BYAPR11MB3256.namprd11.prod.outlook.com>
In-Reply-To: 61039da395c8a28444e2f3958d29deda4c0d49b3.camel@perches.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============6956660007573514769==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

I can do it this way:

In the global header actypes.h:

#ifndef ACPI_FALLTHROUGH
#define ACPI_FALLTHROUGH
#endif

In the gcc-specific header (acgcc.h):

#define ACPI_FALLTHROUGH        __attribute__((__fallthrough__))

This would not be #defined in the MSVC-specific header (acmsvc.h) -- thus u=
sing the default (null) in actypes.h (The per-environment headers are alway=
s included first).

(We do all macros in upper case, prefixed with "ACPI_")

If you can update your patch to use ACPI_FALLTHROUGH, I can do the rest (ab=
ove).

Thanks,
Bob

-----Original Message-----
From: Joe Perches <joe(a)perches.com> =

Sent: Friday, November 13, 2020 8:30 AM
To: Miguel Ojeda <miguel.ojeda.sandonis(a)gmail.com>; Nick Desaulniers <nde=
saulniers(a)google.com>
Cc: Moore, Robert <robert.moore(a)intel.com>; Kaneda, Erik <erik.kaneda(a)i=
ntel.com>; Wysocki, Rafael J <rafael.j.wysocki(a)intel.com>; Gustavo A . R =
. Silva <gustavoars(a)kernel.org>; clang-built-linux(a)googlegroups.com; Le=
n Brown <lenb(a)kernel.org>; linux-acpi(a)vger.kernel.org; devel(a)acpica.o=
rg; linux-kernel(a)vger.kernel.org
Subject: Re: [PATCH] ACPICA: fix -Wfallthrough

On Fri, 2020-11-13 at 09:14 +0100, Miguel Ojeda wrote:
> On Fri, Nov 13, 2020 at 1:09 AM Nick Desaulniers =

> <ndesaulniers(a)google.com> wrote:
> > =

> > Thank you for the explicit diagnostics observed.  Something fishy is =

> > going on though, https://godbolt.org/z/Gbxbxa is how I expect MSVC =

> > to handle include/linux/compiler_attributes.h.
> > =

> > The C preprocessor should make it such that MSVC never sees =

> > `__attribute__` or `__fallthrough__`; that it does begs the question.
> > That would seem to imply that `#if __has_attribute(__fallthrough__)` =

> > somehow evaluates to true on MSVC, but my godbolt link shows it does =

> > not.
> > =

> > Could the upstream ACPICA project be #define'ing something that =

> > could be altering this? (Or not #define'ing something?)
> > =

> > Worst case, we could do as Joe Perches suggested and disable =

> > -Wfallthrough for drivers/acpi/acpica/.
> =

> I agree, something is fishy. MSVC has several flags for conformance =

> and extensions support, including two full C preprocessors in newer =

> versions; which means we might be missing something, but I don't see =

> how the code in compiler_attributes.h could be confusing MSVC even in =

> older non-conforming versions.

I believe this has nothing to do with linux and only to do with compiling a=
cpica for other environments like Windows.

From: https://acpica.org/

The ACPI Component Architecture (ACPICA) project provides an operating syst=
em (OS)-independent reference implementation of the Advanced Configuration =
and Power Interface Specification (ACPI).

It can be easily adapted to execute under any host OS.


--===============6956660007573514769==--

