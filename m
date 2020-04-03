Content-Type: multipart/mixed; boundary="===============8302187082669636537=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: [Devel] Re: [PATCH] ACPICA: make acpi_gbl_next_cmd_num static
Date: Fri, 03 Apr 2020 11:24:19 +0200
Message-ID: <CAJZ5v0gHsUMS+LciZnzC12=QO+hsVkeQWHDR1LC8PMCxoWvtAQ@mail.gmail.com>
In-Reply-To: 20200403064712.26746-1-yanaijie@huawei.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============8302187082669636537==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 3, 2020 at 8:48 AM Jason Yan <yanaijie(a)huawei.com> wrote:
>
> Fix the following sparse warning:
>
> drivers/acpi/acpica/dbhistry.c:30:5: warning: symbol
> 'acpi_gbl_next_cmd_num' was not declared. Should it be static?
>
> Reported-by: Hulk Robot <hulkci(a)huawei.com>
> Signed-off-by: Jason Yan <yanaijie(a)huawei.com>

Bob, Erik, I'm leaving this one to you.

> ---
>  drivers/acpi/acpica/dbhistry.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/acpica/dbhistry.c b/drivers/acpi/acpica/dbhistr=
y.c
> index bb9600b867ee..801b35a08174 100644
> --- a/drivers/acpi/acpica/dbhistry.c
> +++ b/drivers/acpi/acpica/dbhistry.c
> @@ -27,7 +27,7 @@ static HISTORY_INFO acpi_gbl_history_buffer[HISTORY_SIZ=
E];
>  static u16 acpi_gbl_lo_history =3D 0;
>  static u16 acpi_gbl_num_history =3D 0;
>  static u16 acpi_gbl_next_history_index =3D 0;
> -u32 acpi_gbl_next_cmd_num =3D 1;
> +static u32 acpi_gbl_next_cmd_num =3D 1;
>
>  /***********************************************************************=
********
>   *
> --
> 2.17.2
>
--===============8302187082669636537==--

