Content-Type: multipart/mixed; boundary="===============8335115214975357978=="
MIME-Version: 1.0
From: Leif Lindholm <leif.lindholm at linaro.org>
Subject: Re: [Devel] [PATCH v2] EFI: fix build for AARCH64
Date: Thu, 09 Feb 2017 12:34:23 +0000
Message-ID: <20170209123423.GB16034@bivouac.eciton.net>
In-Reply-To: 1AE640813FDE7649BE1B193DEA596E886CE38642@SHSMSX101.ccr.corp.intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============8335115214975357978==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Lv,

Many thanks for review.

On Thu, Feb 09, 2017 at 02:24:39AM +0000, Zheng, Lv wrote:
> Hi, Guys
> =

> Thanks for the reminder.
> Here goes my opinions.
> =

> > From: Devel [mailto:devel-bounces(a)acpica.org] On Behalf Of Al Stone
> > Sent: Friday, January 27, 2017 1:05 AM
> > Subject: Re: [Devel] [PATCH v2] EFI: fix build for AARCH64
> > =

> > On 01/03/2017 05:21 AM, Leif Lindholm wrote:
> > > AARCH64 build was left out of initial version, so add to .dsc and set
> > > ACPI_MACHINE_WIDTH correctly.
> > >
> > > Also, acpidump.inf specified explicit per-architecture (but identical)
> > > CFLAGS. Rather than duplicating this further, use the same setting for
> > > all architectures until there is actually a need to diverge.
> > >
> > > Also update README to make it obvious AArch64 is supported.
> > >
> > > Signed-off-by: Leif Lindholm <leif.lindholm(a)linaro.org>
> > > ---
> > >
> > > v2 contains a fix for a non-functional issue, which could generate
> > > warnings when building with CLANG.
> > >
> > >  generate/efi/AcpiPkg.dsc           | 2 +-
> > >  generate/efi/README                | 1 +
> > >  generate/efi/acpidump/acpidump.inf | 6 ++----
> > >  source/include/platform/acefi.h    | 2 +-
> > >  4 files changed, 5 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/generate/efi/AcpiPkg.dsc b/generate/efi/AcpiPkg.dsc
> > > index 323d39c..9302555 100644
> > > --- a/generate/efi/AcpiPkg.dsc
> > > +++ b/generate/efi/AcpiPkg.dsc
> > > @@ -18,7 +18,7 @@
> > >    PLATFORM_VERSION        =3D 1.0
> > >    DSC_SPECIFICATION       =3D 0x00010005
> > >    OUTPUT_DIRECTORY        =3D Build/Acpi
> > > -  SUPPORTED_ARCHITECTURES =3D IA32|X64
> > > +  SUPPORTED_ARCHITECTURES =3D AARCH64|IA32|X64
> > >    BUILD_TARGETS           =3D DEBUG|RELEASE
> > >    SKUID_IDENTIFIER        =3D DEFAULT
> > >
> > > diff --git a/generate/efi/README b/generate/efi/README
> > > index 7550e9d..b3ec3ff 100644
> > > --- a/generate/efi/README
> > > +++ b/generate/efi/README
> > > @@ -20,6 +20,7 @@ But the porting has only been tested in a Linux env=
ironment.
> > >
> > >     You can find built EFI binaries (e.x., acpidump.efi) in the follo=
wing
> > >     folders:
> > > +     Build/Acpi/DEBUG_GCC47/AARCH64: aarch64 targets
> > >       Build/Acpi/DEBUG_GCC47/IA32: i386 targets
> > >       Build/Acpi/DEBUG_GCC47/X64: x86_64 targets
> =

> Could you reorder this list in the README file?
> New support should be listed below the old supports.
> And I believe EFI is much more widely used on IA32 and X64 platforms.

That's probably true, I was going for alphabetical order :)
If we are sorting by order of most widely used, I would think x86_64
should go first. So please clarify which order you would prefer.

> > >
> > > diff --git a/generate/efi/acpidump/acpidump.inf b/generate/efi/acpidu=
mp/acpidump.inf
> > > index 8d2c979..e5f21c0 100644
> > > --- a/generate/efi/acpidump/acpidump.inf
> > > +++ b/generate/efi/acpidump/acpidump.inf
> > > @@ -55,7 +55,5 @@
> > >    BaseLib
> > >
> > >  [BuildOptions]
> > > -  MSFT:*_*_IA32_CC_FLAGS =3D /Oi- /WX- /D_EDK2_EFI /DACPI_DUMP_APP
> > > -  MSFT:*_*_X64_CC_FLAGS  =3D /Oi- /WX- /D_EDK2_EFI /DACPI_DUMP_APP
> > > -  GCC:*_*_IA32_CC_FLAGS  =3D -U__linux__ -U_LINUX -D_EDK2_EFI -DACPI=
_DUMP_APP -fno-builtin -
> > iwithprefix include
> > > -  GCC:*_*_X64_CC_FLAGS   =3D -U__linux__ -U_LINUX -D_EDK2_EFI -DACPI=
_DUMP_APP -fno-builtin -
> > iwithprefix include
> > > +  MSFT:*_*_*_CC_FLAGS =3D /Oi- /WX- /D_EDK2_EFI /DACPI_DUMP_APP
> > > +  GCC:*_*_*_CC_FLAGS  =3D -U__linux__ -U_LINUX -D_EDK2_EFI -DACPI_DU=
MP_APP -fno-builtin -iwithprefix
> > include
> =

> Maybe this should be in a separate patch.

I could, but this is actually part of the main build fix. It's been a
while since I wrote it, but I think the -U_LINUX was the change that
made it possible to build at all, whereas the changes below made the
application function properly.

> > > diff --git a/source/include/platform/acefi.h b/source/include/platfor=
m/acefi.h
> > > index 8328ab6..75ef89a 100644
> > > --- a/source/include/platform/acefi.h
> > > +++ b/source/include/platform/acefi.h
> > > @@ -140,7 +140,7 @@
> > >
> > >  #define VOID        void
> > >
> > > -#if defined(__ia64__) || defined(__x86_64__)
> > > +#if defined(__aarch64__) || defined(__ia64__) || defined(__x86_64__)
> > >
> > >  #define ACPI_MACHINE_WIDTH          64
> > >
> > >
> =

> TBH, I don't have any idea on how aarch64 EFI wrapper should be.
> So what we can do is just relying on the community.
> So I'm OK with this change.
> But it seems this commit should also define __aarch64__ in accygwin.h.
> Is this a mistake?

That is possibly true, but I don't have a Windows environment
available to test in.

Evan, Alexei? Could either of you test this?

Best Regards,

Leif

> =

> Thanks and best regards
> Lv
> =

> =

> > =

> > It's been over a month since this really very simple patch was submitte=
d.  In
> > the meantime, acpidump.efi does not build without it.  Any particular r=
eason
> > this has not been merged?  Leif isn't the only user that needs it.
> > =

> > Thanks.
> > =

> > --
> > ciao,
> > al
> > -----------------------------------
> > Al Stone
> > Software Engineer
> > Red Hat, Inc.
> > ahs3(a)redhat.com
> > -----------------------------------
> > _______________________________________________
> > Devel mailing list
> > Devel(a)acpica.org
> > https://lists.acpica.org/mailman/listinfo/devel

--===============8335115214975357978==--

