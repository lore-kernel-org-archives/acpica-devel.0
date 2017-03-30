Content-Type: multipart/mixed; boundary="===============3791750700453258811=="
MIME-Version: 1.0
From: Zheng, Lv <lv.zheng at intel.com>
Subject: Re: [Devel] [PATCH] ACPICA: use designated initializers
Date: Thu, 30 Mar 2017 02:12:29 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E886CE6BD95@SHSMSX101.ccr.corp.intel.com>
In-Reply-To: CAGXu5jJk2+_r_72B=yqz9=s=S3VY6v8o7jis7e6YMhy2tSJgHw@mail.gmail.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============3791750700453258811==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

> From: keescook(a)google.com [mailto:keescook(a)google.com] On Behalf Of K=
ees Cook
> Subject: Re: [PATCH] ACPICA: use designated initializers
> =

> On Sun, Dec 18, 2016 at 10:06 PM, Zheng, Lv <lv.zheng(a)intel.com> wrote:
> > Hi,
> >
> >> From: Kees Cook [mailto:keescook(a)chromium.org]
> >> Subject: [PATCH] ACPICA: use designated initializers
> >>
> >> Prepare to mark sensitive kernel structures for randomization by making
> >> sure they're using designated initializers. These were identified duri=
ng
> >> allyesconfig builds of x86, arm, and arm64, with most initializer fixes
> >> extracted from grsecurity.
> >
> > This commit is not suitable for ACPICA upstream.
> > It's not portable. Please drop.
> =

> What compilers are building this that do not support designated
> initializers? Also, couldn't this be made into a macro so it could be
> supported in either case?

It's MSVC.
In ACPICA upstream, it supports Intel compiler, GCC and MSVC.

> =

> #ifdef __GNUC__
> # define ACPI_SLEEP_FUNCTIONS(legacy, extended) { \
>     .legacy_function =3D legacy, \
>     .extended_function =3D extended, \
> }
> #else
> # define ACPI_SLEEP_FUNCTIONS(legacy, extended) { legacy, extended }
> #endif
> =

> ...
> =

>  static struct acpi_sleep_functions acpi_sleep_dispatch[] =3D {
>         ACPI_SLEEP_FUNCTIONS(
>                ACPI_HW_OPTIONAL_FUNCTION(acpi_hw_legacy_sleep),
>                acpi_hw_extended_sleep),
> ...

There are many such cases in ACPICA, and I couldn't see the benefit to intr=
oduce such mechanism to such a software whose purposes contain portability.
Unless you can invent a mechanism that can be utilized by all such cases.
Then you should put it into acgcc.h and implement a replaceable in acmsvc.h.
After that, you surely need to do a cleanup in the entire ACPICA code base =
using this new mechanism.

Thanks
Lv

> =

> =

> -Kees
> =

> >
> > Thanks
> > Lv
> >
> >>
> >> Signed-off-by: Kees Cook <keescook(a)chromium.org>
> >> ---
> >>  drivers/acpi/acpica/hwxfsleep.c | 11 ++++++-----
> >>  1 file changed, 6 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/drivers/acpi/acpica/hwxfsleep.c b/drivers/acpi/acpica/hwx=
fsleep.c
> >> index f76e0eab32b8..25cd5c66e102 100644
> >> --- a/drivers/acpi/acpica/hwxfsleep.c
> >> +++ b/drivers/acpi/acpica/hwxfsleep.c
> >> @@ -70,11 +70,12 @@ static acpi_status acpi_hw_sleep_dispatch(u8 sleep=
_state, u32 function_id);
> >>  /* Legacy functions are optional, based upon ACPI_REDUCED_HARDWARE */
> >>
> >>  static struct acpi_sleep_functions acpi_sleep_dispatch[] =3D {
> >> -     {ACPI_HW_OPTIONAL_FUNCTION(acpi_hw_legacy_sleep),
> >> -      acpi_hw_extended_sleep},
> >> -     {ACPI_HW_OPTIONAL_FUNCTION(acpi_hw_legacy_wake_prep),
> >> -      acpi_hw_extended_wake_prep},
> >> -     {ACPI_HW_OPTIONAL_FUNCTION(acpi_hw_legacy_wake), acpi_hw_extende=
d_wake}
> >> +     { .legacy_function =3D ACPI_HW_OPTIONAL_FUNCTION(acpi_hw_legacy_=
sleep),
> >> +       .extended_function =3D acpi_hw_extended_sleep },
> >> +     { .legacy_function =3D ACPI_HW_OPTIONAL_FUNCTION(acpi_hw_legacy_=
wake_prep),
> >> +       .extended_function =3D acpi_hw_extended_wake_prep },
> >> +     { .legacy_function =3D ACPI_HW_OPTIONAL_FUNCTION(acpi_hw_legacy_=
wake),
> >> +       .extended_function =3D acpi_hw_extended_wake }
> >>  };
> >>
> >>  /*
> >> --
> >> 2.7.4
> >>
> >>
> >> --
> >> Kees Cook
> >> Nexus Security
> =

> =

> =

> --
> Kees Cook
> Pixel Security

--===============3791750700453258811==--

