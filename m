Content-Type: multipart/mixed; boundary="===============5933308346471185858=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: [Devel] Re: [PATCH] ACPICA: drop unneeded initialization value
Date: Thu, 07 Oct 2021 19:14:43 +0200
Message-ID: <CAJZ5v0jzmGWR82zfpGjd2K_YfvzS_ktVeq6oX-p=tx9OXjOTxA@mail.gmail.com>
In-Reply-To: 20211006113745.60186-1-sohaib.amhmd@gmail.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============5933308346471185858==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 6, 2021 at 1:37 PM Sohaib Mohamed <sohaib.amhmd(a)gmail.com> wr=
ote:
>
> Do not initialise statics to 0
>
> Signed-off-by: Sohaib Mohamed <sohaib.amhmd(a)gmail.com>
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

Please submit ACPICA changes like this to the upstream ACPICA project
as per MAINTANIERS.

Thanks!
--===============5933308346471185858==--

