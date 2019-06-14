Content-Type: multipart/mixed; boundary="===============5344645163964926220=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: Re: [Devel] [PATCH v2 1/3] ACPI: Resolve objects on host-directed
 table loads
Date: Fri, 14 Jun 2019 11:12:53 +0200
Message-ID: <CAJZ5v0jqxWs=PPik-TCDqQiyxCSyRP7HTue1WsdWP9e-nik2eA@mail.gmail.com>
In-Reply-To: e2a4ddfd93a904b50b7ccc074e00e14dc4661963.1560327219.git.nikolaus.voss@loewensteinmedical.de
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============5344645163964926220==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 12, 2019 at 10:36 AM Nikolaus Voss
<nikolaus.voss(a)loewensteinmedical.de> wrote:
>
> If an ACPI SSDT overlay is loaded after built-in tables
> have been loaded e.g. via configfs or efivar_ssdt_load()
> it is necessary to rewalk the namespace to resolve
> references. Without this, relative and absolute paths
> like ^PCI0.SBUS or \_SB.PCI0.SBUS are not resolved
> correctly.
>
> Make configfs load use the same method as efivar_ssdt_load().
>
> Signed-off-by: Nikolaus Voss <nikolaus.voss(a)loewensteinmedical.de>

This is fine by me, so

Acked-by: Rafael J. Wysocki <rafael.j.wysocki(a)intel.com>

Or if you want me to take this patch (without the other two in the
series), please let me know.

As for the other two patches, someone else needs to review them for
you as I'm not particularly familiar with the PWM subsystem.

> ---
>  drivers/acpi/acpi_configfs.c   |  6 +-----
>  drivers/acpi/acpica/tbxfload.c | 11 +++++++++++
>  2 files changed, 12 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/acpi/acpi_configfs.c b/drivers/acpi/acpi_configfs.c
> index f92033661239..663f0d88f912 100644
> --- a/drivers/acpi/acpi_configfs.c
> +++ b/drivers/acpi/acpi_configfs.c
> @@ -56,11 +56,7 @@ static ssize_t acpi_table_aml_write(struct config_item=
 *cfg,
>         if (!table->header)
>                 return -ENOMEM;
>
> -       ACPI_INFO(("Host-directed Dynamic ACPI Table Load:"));
> -       ret =3D acpi_tb_install_and_load_table(
> -                       ACPI_PTR_TO_PHYSADDR(table->header),
> -                       ACPI_TABLE_ORIGIN_EXTERNAL_VIRTUAL, FALSE,
> -                       &table->index);
> +       ret =3D acpi_load_table(table->header);
>         if (ret) {
>                 kfree(table->header);
>                 table->header =3D NULL;
> diff --git a/drivers/acpi/acpica/tbxfload.c b/drivers/acpi/acpica/tbxfloa=
d.c
> index 4f30f06a6f78..ef8f8a9f3c9c 100644
> --- a/drivers/acpi/acpica/tbxfload.c
> +++ b/drivers/acpi/acpica/tbxfload.c
> @@ -297,6 +297,17 @@ acpi_status acpi_load_table(struct acpi_table_header=
 *table)
>         status =3D acpi_tb_install_and_load_table(ACPI_PTR_TO_PHYSADDR(ta=
ble),
>                                                 ACPI_TABLE_ORIGIN_EXTERNA=
L_VIRTUAL,
>                                                 FALSE, &table_index);
> +
> +       if (ACPI_SUCCESS(status)) {
> +               /* Complete the initialization/resolution of package obje=
cts */
> +
> +               status =3D acpi_ns_walk_namespace(ACPI_TYPE_PACKAGE,
> +                                               ACPI_ROOT_OBJECT,
> +                                               ACPI_UINT32_MAX, 0,
> +                                               acpi_ns_init_one_package,
> +                                               NULL, NULL, NULL);
> +       }
> +
>         return_ACPI_STATUS(status);
>  }
>
> --
> 2.17.1
>

--===============5344645163964926220==--

