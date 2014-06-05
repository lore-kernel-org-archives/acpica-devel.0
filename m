Content-Type: multipart/mixed; boundary="===============7562040210992376773=="
MIME-Version: 1.0
From: Zheng, Lv <lv.zheng at intel.com>
Subject: Re: [Devel] [PATCH 1/7] ACPICA: Only include ACPI asm files if ACPI
 is enabled
Date: Thu, 05 Jun 2014 04:44:57 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E8802621528@SHSMSX101.ccr.corp.intel.com>
In-Reply-To: 538FEDE9.4010603@linaro.org
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============7562040210992376773==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi, =


> From: Hanjun Guo [mailto:hanjun.guo(a)linaro.org]
> Sent: Thursday, June 05, 2014 12:11 PM
> To: Zheng, Lv; Lee Jones; Rafael J. Wysocki
> =

> On 2014-6-5 9:14, Zheng, Lv wrote:
> > Hi, Lee
> >
> >> From: Lee Jones [mailto:lee.jones(a)linaro.org]
> >> Sent: Wednesday, June 04, 2014 8:52 PM
> >> To: Rafael J. Wysocki
> >>
> >> On Wed, 04 Jun 2014, Rafael J. Wysocki wrote:
> >>
> >>> On Wednesday, June 04, 2014 01:09:50 PM Lee Jones wrote:
> >>>> Any drivers which support ACPI and Device Tree probing need to inclu=
de
> >>>> both respective header files.  Without this patch, if a driver is be=
ing
> >>>> used on a platform which does not support ACPI and subsequently does=
 not
> >>>> have the config option enabled, but includes linux/acpi.h the build
> >>>> breaks with:
> >>>>
> >>>>   In file included from ../include/acpi/platform/acenv.h:150:0,
> >>>>                    from ../include/acpi/acpi.h:56,
> >>>>                    from ../include/linux/match.h:2,
> >>>>                    from ../drivers/i2c/i2c-core.c:43:
> >>>>   ../include/acpi/platform/aclinux.h:73:23:
> >>>>    fatal error: asm/acenv.h: No such file or directory
> >>>>    #include <asm/acenv.h>
> >>>>                        ^
> >
> > Note that:
> > In our tree:
> > <asm/acenv.h> is only included by <acpi/acpi.h>.
> > And <acpi/acpi.h> is only included by
> > 1. <linux/acpi.h> when CONFIG_ACPI enabled
> > 2. <linux/sfi_acpi.h> - this is x86 specific, we'll clean it up by impl=
ementing stubs for all ACPI external interfaces.
> > So there is no case we need to exclude <asm/acenv.h> when CONFIG_ACPI i=
s not enabled.
> >
> > I cannot find linux/match.h here.
> > If <linux/match.h> want to include ACPI features, it shouldn't include =
<acpi/acpi.h>, but should include <linux/acpi.h>.
> > Please refer to:
> > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/=
?id=3D8b48463f
> > And stop including <acpi/acpi.h> directly in any cases.
> =

> Ah, I agree, please ignore my previous email,
> sorry for the noise.
> =

> Since it is very important to include <linux/acpi.h> but not <acpi/acpi.h=
>,
> can we document it somewhere as the guidance? Then people will not
> make such mistake :)

After I test the ACPICA stubs and remove the only abnormal direct <acpi/acp=
i.h> inclusion from <linux/sfi_acpi.h>.
We could have a commit to add something like:

#ifndef _LINUX_ACPI_H
#error ....
#endif
To the <acpi/platform/aclinux.h> (the Linux OSL for ACPICA headers, it is i=
ncluded by <acpi/acpi.h>).
Hope this can be the hint to prevent future mistakes.

Thanks and best regards
-Lv


> =

> Thanks
> Hanjun


--===============7562040210992376773==--

