Content-Type: multipart/mixed; boundary="===============2066647070515616942=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: Re: [Devel] [PATCH v5 5/5] ACPI / OSL: Remove PCI bits from ACPICA
 when CONFIG_PCI is unset
Date: Wed, 12 Dec 2018 10:25:53 +0100
Message-ID: <CAJZ5v0gOH--BDa-ShCSJbeOicLe+QWOnUj=Rz4Tcv-aaGuyRAQ@mail.gmail.com>
In-Reply-To: 20181212052846.32370-6-okaya@kernel.org
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============2066647070515616942==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 12, 2018 at 6:29 AM Sinan Kaya <okaya(a)kernel.org> wrote:
>
> Now that we allow CONFIG_PCI to be unset, remove useless code from ACPICA
> too.
>
> Signed-off-by: Sinan Kaya <okaya(a)kernel.org>
> ---
>  drivers/acpi/acpica/Makefile | 2 +-
>  drivers/acpi/osl.c           | 9 +++++++++
>  2 files changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/acpica/Makefile b/drivers/acpi/acpica/Makefile
> index b14621da5413..59700433a96e 100644
> --- a/drivers/acpi/acpica/Makefile
> +++ b/drivers/acpi/acpica/Makefile
> @@ -77,13 +77,13 @@ acpi-y +=3D           \
>         hwacpi.o        \
>         hwesleep.o      \
>         hwgpe.o         \
> -       hwpci.o         \
>         hwregs.o        \
>         hwsleep.o       \
>         hwvalid.o       \
>         hwxface.o       \
>         hwxfsleep.o
>
> +acpi-$(CONFIG_PCI) +=3D hwpci.o
>  acpi-$(ACPI_FUTURE_USAGE) +=3D hwtimer.o
>
>  acpi-y +=3D              \
> diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
> index 7b1e58f93f37..8b8eb17df3f2 100644
> --- a/drivers/acpi/osl.c
> +++ b/drivers/acpi/osl.c
> @@ -1837,3 +1837,12 @@ acpi_status acpi_os_enter_sleep(u8 sleep_state,
>                                                reg_a_value, reg_b_value);
>         return status;
>  }
> +
> +#ifndef CONFIG_PCI
> +acpi_status acpi_hw_derive_pci_id(struct acpi_pci_id *pci_id,
> +                     acpi_handle root_pci_device, acpi_handle pci_region)
> +{
> +       return AE_SUPPORT;
> +}
> +#endif
> +
> --

I would prefer the header to be modified instead.  Yes, it is an
ACPICA header, but then the change would complement the Makefile one
in a rather straightforward way.

--===============2066647070515616942==--

