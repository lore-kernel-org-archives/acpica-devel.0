Content-Type: multipart/mixed; boundary="===============1988334404726811374=="
MIME-Version: 1.0
From: Leif Lindholm <leif.lindholm at linaro.org>
Subject: Re: [Devel] [PATCH] EFI: fix build for AARCH64
Date: Mon, 19 Dec 2016 23:25:21 +0000
Message-ID: <20161219232521.GA16872@bivouac.eciton.net>
In-Reply-To: 20161219181430.28668-1-leif.lindholm@linaro.org
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============1988334404726811374==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 19, 2016 at 06:14:30PM +0000, Leif Lindholm wrote:
> AARCH64 build was left out of initial version, so add to .dsc and set
> ACPI_MACHINE_WIDTH correctly.
> =

> Also, acpidump.inf specified explicit per-architecture (but identical)
> CFLAGS. Rather than duplicating this further, use the same setting for
> all architectures until there is actually a need to diverge.
> =

> Also update README to make it obvious AArch64 is supported.
> =

> Signed-off-by: Leif Lindholm <leif.lindholm(a)linaro.org>
> ---
>  generate/efi/AcpiPkg.dsc           | 2 +-
>  generate/efi/README                | 1 +
>  generate/efi/acpidump/acpidump.inf | 6 ++----
>  source/include/platform/acefi.h    | 2 +-
>  4 files changed, 5 insertions(+), 6 deletions(-)
> =

> diff --git a/generate/efi/AcpiPkg.dsc b/generate/efi/AcpiPkg.dsc
> index 323d39c..9302555 100644
> --- a/generate/efi/AcpiPkg.dsc
> +++ b/generate/efi/AcpiPkg.dsc
> @@ -18,7 +18,7 @@
>    PLATFORM_VERSION        =3D 1.0
>    DSC_SPECIFICATION       =3D 0x00010005
>    OUTPUT_DIRECTORY        =3D Build/Acpi
> -  SUPPORTED_ARCHITECTURES =3D IA32|X64
> +  SUPPORTED_ARCHITECTURES =3D AARCH64|IA32|X64
>    BUILD_TARGETS           =3D DEBUG|RELEASE
>    SKUID_IDENTIFIER        =3D DEFAULT
>  =

> diff --git a/generate/efi/README b/generate/efi/README
> index 7550e9d..b3ec3ff 100644
> --- a/generate/efi/README
> +++ b/generate/efi/README
> @@ -20,6 +20,7 @@ But the porting has only been tested in a Linux environ=
ment.
>  =

>     You can find built EFI binaries (e.x., acpidump.efi) in the following
>     folders:
> +     Build/Acpi/DEBUG_GCC47/AARCH64: aarch64 targets
>       Build/Acpi/DEBUG_GCC47/IA32: i386 targets
>       Build/Acpi/DEBUG_GCC47/X64: x86_64 targets
>  =

> diff --git a/generate/efi/acpidump/acpidump.inf b/generate/efi/acpidump/a=
cpidump.inf
> index 8d2c979..e5f21c0 100644
> --- a/generate/efi/acpidump/acpidump.inf
> +++ b/generate/efi/acpidump/acpidump.inf
> @@ -55,7 +55,5 @@
>    BaseLib
>  =

>  [BuildOptions]
> -  MSFT:*_*_IA32_CC_FLAGS =3D /Oi- /WX- /D_EDK2_EFI /DACPI_DUMP_APP
> -  MSFT:*_*_X64_CC_FLAGS  =3D /Oi- /WX- /D_EDK2_EFI /DACPI_DUMP_APP
> -  GCC:*_*_IA32_CC_FLAGS  =3D -U__linux__ -U_LINUX -D_EDK2_EFI -DACPI_DUM=
P_APP -fno-builtin -iwithprefix include
> -  GCC:*_*_X64_CC_FLAGS   =3D -U__linux__ -U_LINUX -D_EDK2_EFI -DACPI_DUM=
P_APP -fno-builtin -iwithprefix include
> +  MSFT:*_*_*_CC_FLAGS =3D /Oi- /WX- /D_EDK2_EFI /DACPI_DUMP_APP
> +  GCC:*_*_*_CC_FLAGS  =3D -U__linux__ -U_LINUX -D_EDK2_EFI -DACPI_DUMP_A=
PP -fno-builtin -iwithprefix include
> diff --git a/source/include/platform/acefi.h b/source/include/platform/ac=
efi.h
> index dfa4894..30a5429 100644
> --- a/source/include/platform/acefi.h
> +++ b/source/include/platform/acefi.h
> @@ -140,7 +140,7 @@
>  =

>  #define VOID        void
>  =

> -#if defined(__ia64__) || defined(__x86_64__)
> +#if defined(__aarch64__) || (__ia64__) || defined(__x86_64__)

And this is of course a bug. Should be defined(__ia64__).

>  =

>  #define ACPI_MACHINE_WIDTH          64
>  =

> -- =

> 2.10.2
>=20

--===============1988334404726811374==--

