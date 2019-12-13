Content-Type: multipart/mixed; boundary="===============8457337301974671369=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: [Devel] Re: [PATCH] ACPICA: Fix compilation with bare-metal toolchian
Date: Fri, 13 Dec 2019 01:21:11 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E3B96BFE2C@ORSMSX110.amr.corp.intel.com>
In-Reply-To: 2847939.QcJ3fIVZhg@kreacher
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============8457337301974671369==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



> -----Original Message-----
> From: Rafael J. Wysocki [mailto:rjw(a)rjwysocki.net]
> Sent: Friday, July 5, 2019 2:44 AM
> To: Moore, Robert <robert.moore(a)intel.com>; Schmauss, Erik
> <erik.schmauss(a)intel.com>
> Cc: Laster K. <officiallazerl0rd(a)gmail.com>; Wysocki, Rafael J
> <rafael.j.wysocki(a)intel.com>; lenb(a)kernel.org; linux-
> acpi(a)vger.kernel.org; devel(a)acpica.org
> Subject: Re: [PATCH] ACPICA: Fix compilation with bare-metal toolchian
> =

> On Saturday, June 22, 2019 11:03:54 PM CEST Laster K. wrote:
> > An ifdef expects to be compiled with full-fledged Linux toolchain, but
> > it's common to compile kernel with just bare-metal toolchain which
> > doesn't define __linux__. So, also add __KERNEL__ check.
> >
[Moore, Robert] =

This sounds OK, as long as no other supported hosts define __KERNEL__.

> > Signed-off-by: Laster K. (lazerl0rd) <officiallazerl0rd(a)gmail.com>
> > ---
> > Apologies for the multiple/spammed e-mails, I was having mail client
> issues.
> >
> >  include/acpi/platform/acenv.h   | 2 +-
> >  include/acpi/platform/acenvex.h | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/acpi/platform/acenv.h
> > b/include/acpi/platform/acenv.h index 35ab3f87cc29..b69319198cb8
> > 100644
> > --- a/include/acpi/platform/acenv.h
> > +++ b/include/acpi/platform/acenv.h
> > @@ -148,7 +148,7 @@
> >
> >  #endif
> >
> > -#if defined(_LINUX) || defined(__linux__)
> > +#if defined(_LINUX) || defined(__KERNEL__) || defined(__linux__)
> >  #include <acpi/platform/aclinux.h>
> >
> >  #elif defined(_APPLE) || defined(__APPLE__) diff --git
> > a/include/acpi/platform/acenvex.h b/include/acpi/platform/acenvex.h
> > index 2e36c8344897..c7697a47e33f 100644
> > --- a/include/acpi/platform/acenvex.h
> > +++ b/include/acpi/platform/acenvex.h
> > @@ -19,7 +19,7 @@
> >   *
> >
> > **********************************************************************
> > *******/
> >
> > -#if defined(_LINUX) || defined(__linux__)
> > +#if defined(_LINUX) || defined(__KERNEL__) || defined(__linux__)
> >  #include <acpi/platform/aclinuxex.h>
> >
> >  #elif defined(__DragonFly__)
> >
> =

> Erik, Bob, any input here?
> =

>=20

--===============8457337301974671369==--

