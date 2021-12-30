Content-Type: multipart/mixed; boundary="===============7341545960446947050=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: [Devel] Re: [PATCH] ACPICA: Remove initialization of static variables
 to 0
Date: Thu, 30 Dec 2021 17:30:48 +0100
Message-ID: <CAJZ5v0j1+p8E+BF_Ekmenpp+9WG7b3k5Y7YjyJzi7e+K1Nv2NQ@mail.gmail.com>
In-Reply-To: 20211224091458.693093-1-yinxiujiang@kylinos.cn
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============7341545960446947050==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 24, 2021 at 10:15 AM Yin Xiujiang <yinxiujiang(a)kylinos.cn> wr=
ote:
>
> Remove the initialization of three static variables to 0 which is
> pointless
>
> Signed-off-by: Yin Xiujiang <yinxiujiang(a)kylinos.cn>
> ---
>  drivers/acpi/acpica/dbhistry.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/acpi/acpica/dbhistry.c b/drivers/acpi/acpica/dbhistr=
y.c
> index fd813c5d3952..60b77b11c0f2 100644
> --- a/drivers/acpi/acpica/dbhistry.c
> +++ b/drivers/acpi/acpica/dbhistry.c
> @@ -24,9 +24,9 @@ typedef struct history_info {
>  } HISTORY_INFO;
>
>  static HISTORY_INFO acpi_gbl_history_buffer[HISTORY_SIZE];
> -static u16 acpi_gbl_lo_history =3D 0;
> -static u16 acpi_gbl_num_history =3D 0;
> -static u16 acpi_gbl_next_history_index =3D 0;
> +static u16 acpi_gbl_lo_history;
> +static u16 acpi_gbl_num_history;
> +static u16 acpi_gbl_next_history_index;
>
>  /***********************************************************************=
********
>   *
> --

This is ACPICA material, so please submit it to the upstream ACPICA
project via https://github.com/acpica/acpica/

Thanks!
--===============7341545960446947050==--

