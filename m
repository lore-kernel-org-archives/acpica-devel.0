Content-Type: multipart/mixed; boundary="===============8785785317156268603=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: Re: [Devel] [PATCH] ACPICA: use designated initializers
Date: Thu, 30 Mar 2017 14:26:08 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37E58E285@ORSMSX110.amr.corp.intel.com>
In-Reply-To: 1AE640813FDE7649BE1B193DEA596E886CE6BD95@SHSMSX101.ccr.corp.intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============8785785317156268603==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Yes, ACPICA must support many compilers, so we keep the code as simple as p=
ossible.

Many of the corporate OS vendors use their own compilers.


> -----Original Message-----
> From: Zheng, Lv
> Sent: Wednesday, March 29, 2017 7:12 PM
> To: Kees Cook <keescook(a)chromium.org>
> Cc: linux-kernel(a)vger.kernel.org; Moore, Robert
> <robert.moore(a)intel.com>; Wysocki, Rafael J
> <rafael.j.wysocki(a)intel.com>; Len Brown <lenb(a)kernel.org>; linux-
> acpi(a)vger.kernel.org; devel(a)acpica.org
> Subject: RE: [PATCH] ACPICA: use designated initializers
> =

> Hi,
> =

> > From: keescook(a)google.com [mailto:keescook(a)google.com] On Behalf Of
> > Kees Cook
> > Subject: Re: [PATCH] ACPICA: use designated initializers
> >
> > On Sun, Dec 18, 2016 at 10:06 PM, Zheng, Lv <lv.zheng(a)intel.com>
> wrote:
> > > Hi,
> > >
> > >> From: Kees Cook [mailto:keescook(a)chromium.org]
> > >> Subject: [PATCH] ACPICA: use designated initializers
> > >>
> > >> Prepare to mark sensitive kernel structures for randomization by
> > >> making sure they're using designated initializers. These were
> > >> identified during allyesconfig builds of x86, arm, and arm64, with
> > >> most initializer fixes extracted from grsecurity.
> > >
> > > This commit is not suitable for ACPICA upstream.
> > > It's not portable. Please drop.
> >
> > What compilers are building this that do not support designated
> > initializers? Also, couldn't this be made into a macro so it could be
> > supported in either case?
> =

> It's MSVC.
> In ACPICA upstream, it supports Intel compiler, GCC and MSVC.
> =

> >
> > #ifdef __GNUC__
> > # define ACPI_SLEEP_FUNCTIONS(legacy, extended) { \
> >     .legacy_function =3D legacy, \
> >     .extended_function =3D extended, \
> > }
> > #else
> > # define ACPI_SLEEP_FUNCTIONS(legacy, extended) { legacy, extended }
> > #endif
> >
> > ...
> >
> >  static struct acpi_sleep_functions acpi_sleep_dispatch[] =3D {
> >         ACPI_SLEEP_FUNCTIONS(
> >                ACPI_HW_OPTIONAL_FUNCTION(acpi_hw_legacy_sleep),
> >                acpi_hw_extended_sleep), ...
> =

> There are many such cases in ACPICA, and I couldn't see the benefit to
> introduce such mechanism to such a software whose purposes contain
> portability.
> Unless you can invent a mechanism that can be utilized by all such
> cases.
> Then you should put it into acgcc.h and implement a replaceable in
> acmsvc.h.
> After that, you surely need to do a cleanup in the entire ACPICA code
> base using this new mechanism.
> =

> Thanks
> Lv
> =

> >
> >
> > -Kees
> >
> > >
> > > Thanks
> > > Lv
> > >
> > >>
> > >> Signed-off-by: Kees Cook <keescook(a)chromium.org>
> > >> ---
> > >>  drivers/acpi/acpica/hwxfsleep.c | 11 ++++++-----
> > >>  1 file changed, 6 insertions(+), 5 deletions(-)
> > >>
> > >> diff --git a/drivers/acpi/acpica/hwxfsleep.c
> > >> b/drivers/acpi/acpica/hwxfsleep.c index f76e0eab32b8..25cd5c66e102
> > >> 100644
> > >> --- a/drivers/acpi/acpica/hwxfsleep.c
> > >> +++ b/drivers/acpi/acpica/hwxfsleep.c
> > >> @@ -70,11 +70,12 @@ static acpi_status acpi_hw_sleep_dispatch(u8
> > >> sleep_state, u32 function_id);
> > >>  /* Legacy functions are optional, based upon ACPI_REDUCED_HARDWARE
> > >> */
> > >>
> > >>  static struct acpi_sleep_functions acpi_sleep_dispatch[] =3D {
> > >> -     {ACPI_HW_OPTIONAL_FUNCTION(acpi_hw_legacy_sleep),
> > >> -      acpi_hw_extended_sleep},
> > >> -     {ACPI_HW_OPTIONAL_FUNCTION(acpi_hw_legacy_wake_prep),
> > >> -      acpi_hw_extended_wake_prep},
> > >> -     {ACPI_HW_OPTIONAL_FUNCTION(acpi_hw_legacy_wake),
> acpi_hw_extended_wake}
> > >> +     { .legacy_function =3D
> ACPI_HW_OPTIONAL_FUNCTION(acpi_hw_legacy_sleep),
> > >> +       .extended_function =3D acpi_hw_extended_sleep },
> > >> +     { .legacy_function =3D
> ACPI_HW_OPTIONAL_FUNCTION(acpi_hw_legacy_wake_prep),
> > >> +       .extended_function =3D acpi_hw_extended_wake_prep },
> > >> +     { .legacy_function =3D
> ACPI_HW_OPTIONAL_FUNCTION(acpi_hw_legacy_wake),
> > >> +       .extended_function =3D acpi_hw_extended_wake }
> > >>  };
> > >>
> > >>  /*
> > >> --
> > >> 2.7.4
> > >>
> > >>
> > >> --
> > >> Kees Cook
> > >> Nexus Security
> >
> >
> >
> > --
> > Kees Cook
> > Pixel Security

--===============8785785317156268603==--

