Content-Type: multipart/mixed; boundary="===============4375817194585748757=="
MIME-Version: 1.0
From: Zheng, Lv <lv.zheng at intel.com>
Subject: Re: [Devel] [PATCH 1/7] ACPICA: Only include ACPI asm files if ACPI
 is enabled
Date: Thu, 05 Jun 2014 00:59:59 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E88026203F6@SHSMSX101.ccr.corp.intel.com>
In-Reply-To: 1603851.9SBouhvdWS@vostro.rjw.lan
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============4375817194585748757==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

> From: linux-i2c-owner(a)vger.kernel.org [mailto:linux-i2c-owner(a)vger.ke=
rnel.org] On Behalf Of Rafael J. Wysocki
> Sent: Thursday, June 05, 2014 5:30 AM
> =

> On Wednesday, June 04, 2014 01:51:37 PM Lee Jones wrote:
> > On Wed, 04 Jun 2014, Rafael J. Wysocki wrote:
> >
> > > On Wednesday, June 04, 2014 01:09:50 PM Lee Jones wrote:
> > > > Any drivers which support ACPI and Device Tree probing need to incl=
ude
> > > > both respective header files.  Without this patch, if a driver is b=
eing
> > > > used on a platform which does not support ACPI and subsequently doe=
s not
> > > > have the config option enabled, but includes linux/acpi.h the build
> > > > breaks with:
> > > >
> > > >   In file included from ../include/acpi/platform/acenv.h:150:0,
> > > >                    from ../include/acpi/acpi.h:56,
> > > >                    from ../include/linux/match.h:2,
> > > >                    from ../drivers/i2c/i2c-core.c:43:
> > > >   ../include/acpi/platform/aclinux.h:73:23:
> > > >    fatal error: asm/acenv.h: No such file or directory
> > > >    #include <asm/acenv.h>
> > > >                        ^
> > >
> > > Which kernel does this happen with?
> >
> > a0a962d (tag: refs/tags/next-20140602, refs/remotes/next/master)
> >   Add linux-next specific files for 20140602
> =

> It looks like the problem is with include/linux/match.h that should not
> include acpi/acpi.h directly.

This is another example that many mis-ordered inclusions are caused by the =
mis-ordered <asm/acpi.h> inclusion.

> =

> But I can't find this file in the Linus' next branch even, so I guess it's
> on its way to that branch?
> =


I guess,
In their tree, they have CONFIG_ACPI enabled for ARM, but we've changed to =
make:
1. <asm/acenv.h> the architecture specific layer for ACPICA, and
2. <asm/acpi.h> is now the architecture specific layer for Linux ACPI.
So they need to follow this.

Thanks and best regards
-Lv

> Rafael
> =

> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> the body of a message to majordomo(a)vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--===============4375817194585748757==--

