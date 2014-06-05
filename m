Content-Type: multipart/mixed; boundary="===============1139245748364114858=="
MIME-Version: 1.0
From: Zheng, Lv <lv.zheng at intel.com>
Subject: Re: [Devel] [PATCH 1/7] ACPICA: Only include ACPI asm files if ACPI
 is enabled
Date: Thu, 05 Jun 2014 01:12:54 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E880262042C@SHSMSX101.ccr.corp.intel.com>
In-Reply-To: 20140604125137.GA18171@lee--X1
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============1139245748364114858==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi, Lee

> From: Lee Jones [mailto:lee.jones(a)linaro.org]
> Sent: Wednesday, June 04, 2014 8:52 PM
> To: Rafael J. Wysocki
> =

> On Wed, 04 Jun 2014, Rafael J. Wysocki wrote:
> =

> > On Wednesday, June 04, 2014 01:09:50 PM Lee Jones wrote:
> > > Any drivers which support ACPI and Device Tree probing need to include
> > > both respective header files.  Without this patch, if a driver is bei=
ng
> > > used on a platform which does not support ACPI and subsequently does =
not
> > > have the config option enabled, but includes linux/acpi.h the build
> > > breaks with:
> > >
> > >   In file included from ../include/acpi/platform/acenv.h:150:0,
> > >                    from ../include/acpi/acpi.h:56,
> > >                    from ../include/linux/match.h:2,
> > >                    from ../drivers/i2c/i2c-core.c:43:
> > >   ../include/acpi/platform/aclinux.h:73:23:
> > >    fatal error: asm/acenv.h: No such file or directory
> > >    #include <asm/acenv.h>
> > >                        ^

Note that:
In our tree:
<asm/acenv.h> is only included by <acpi/acpi.h>.
And <acpi/acpi.h> is only included by
1. <linux/acpi.h> when CONFIG_ACPI enabled
2. <linux/sfi_acpi.h> - this is x86 specific, we'll clean it up by implemen=
ting stubs for all ACPI external interfaces.
So there is no case we need to exclude <asm/acenv.h> when CONFIG_ACPI is no=
t enabled.

I cannot find linux/match.h here.
If <linux/match.h> want to include ACPI features, it shouldn't include <acp=
i/acpi.h>, but should include <linux/acpi.h>.
Please refer to:
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=
=3D8b48463f
And stop including <acpi/acpi.h> directly in any cases.

Thanks and best regards
-Lv


> >
> > Which kernel does this happen with?
> =

> a0a962d (tag: refs/tags/next-20140602, refs/remotes/next/master)
>   Add linux-next specific files for 20140602
> =

> > > Cc: Lv Zheng <lv.zheng(a)intel.com>
> > > Cc: Rafael J. Wysocki <rafael.j.wysocki(a)intel.com>
> > > Cc: linux-acpi(a)vger.kernel.org
> > > Cc: devel(a)acpica.org
> > > Signed-off-by: Lee Jones <lee.jones(a)linaro.org>
> > > ---
> > >  include/acpi/platform/aclinux.h | 5 +++--
> > >  1 file changed, 3 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/include/acpi/platform/aclinux.h b/include/acpi/platform/=
aclinux.h
> > > index cd1f052..fdf7663 100644
> > > --- a/include/acpi/platform/aclinux.h
> > > +++ b/include/acpi/platform/aclinux.h
> > > @@ -70,9 +70,10 @@
> > >  #ifdef EXPORT_ACPI_INTERFACES
> > >  #include <linux/export.h>
> > >  #endif
> > > -#include <asm/acenv.h>
> > >
> > > -#ifndef CONFIG_ACPI
> > > +#ifdef CONFIG_ACPI
> > > +#include <asm/acenv.h>
> > > +#else
> > >
> > >  /* External globals for __KERNEL__, stubs is needed */
> > >
> > >
> >
> =

> --
> Lee Jones
> Linaro STMicroelectronics Landing Team Lead
> Linaro.org =E2=94=82 Open source software for ARM SoCs
> Follow Linaro: Facebook | Twitter | Blog

--===============1139245748364114858==--

