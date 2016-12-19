Content-Type: multipart/mixed; boundary="===============2750616622178467999=="
MIME-Version: 1.0
From: Zheng, Lv <lv.zheng at intel.com>
Subject: Re: [Devel] [PATCH] ACPICA: use designated initializers
Date: Mon, 19 Dec 2016 06:06:21 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E886CDFF348@SHSMSX101.ccr.corp.intel.com>
In-Reply-To: 20161217010425.GA140581@beast
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============2750616622178467999==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

> From: Kees Cook [mailto:keescook(a)chromium.org]
> Subject: [PATCH] ACPICA: use designated initializers
> =

> Prepare to mark sensitive kernel structures for randomization by making
> sure they're using designated initializers. These were identified during
> allyesconfig builds of x86, arm, and arm64, with most initializer fixes
> extracted from grsecurity.

This commit is not suitable for ACPICA upstream.
It's not portable. Please drop.

Thanks
Lv

> =

> Signed-off-by: Kees Cook <keescook(a)chromium.org>
> ---
>  drivers/acpi/acpica/hwxfsleep.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> =

> diff --git a/drivers/acpi/acpica/hwxfsleep.c b/drivers/acpi/acpica/hwxfsl=
eep.c
> index f76e0eab32b8..25cd5c66e102 100644
> --- a/drivers/acpi/acpica/hwxfsleep.c
> +++ b/drivers/acpi/acpica/hwxfsleep.c
> @@ -70,11 +70,12 @@ static acpi_status acpi_hw_sleep_dispatch(u8 sleep_st=
ate, u32 function_id);
>  /* Legacy functions are optional, based upon ACPI_REDUCED_HARDWARE */
> =

>  static struct acpi_sleep_functions acpi_sleep_dispatch[] =3D {
> -	{ACPI_HW_OPTIONAL_FUNCTION(acpi_hw_legacy_sleep),
> -	 acpi_hw_extended_sleep},
> -	{ACPI_HW_OPTIONAL_FUNCTION(acpi_hw_legacy_wake_prep),
> -	 acpi_hw_extended_wake_prep},
> -	{ACPI_HW_OPTIONAL_FUNCTION(acpi_hw_legacy_wake), acpi_hw_extended_wake}
> +	{ .legacy_function =3D ACPI_HW_OPTIONAL_FUNCTION(acpi_hw_legacy_sleep),
> +	  .extended_function =3D acpi_hw_extended_sleep },
> +	{ .legacy_function =3D ACPI_HW_OPTIONAL_FUNCTION(acpi_hw_legacy_wake_pr=
ep),
> +	  .extended_function =3D acpi_hw_extended_wake_prep },
> +	{ .legacy_function =3D ACPI_HW_OPTIONAL_FUNCTION(acpi_hw_legacy_wake),
> +	  .extended_function =3D acpi_hw_extended_wake }
>  };
> =

>  /*
> --
> 2.7.4
> =

> =

> --
> Kees Cook
> Nexus Security

--===============2750616622178467999==--

