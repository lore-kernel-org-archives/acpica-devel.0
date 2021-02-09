Content-Type: multipart/mixed; boundary="===============1201879373567332219=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: [Devel] Re: [PATCH] Enable ACPI_ADR_SPACE_PCI_CONFIG in
 acpi_gbl_default_address_spaces only when ACPI_PCI_CONFIGURED is defined
Date: Tue, 09 Feb 2021 15:35:14 +0100
Message-ID: <CAJZ5v0ifzqR90BJY3u6NGvMLuVn8YApLZH=oA5COcmjs_GKFqQ@mail.gmail.com>
In-Reply-To: 20210209031744.26474-1-weidongcui@gmail.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============1201879373567332219==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 9, 2021 at 4:22 AM Weidong Cui <weidongcui(a)gmail.com> wrote:
>
> Signed-off-by: Weidong Cui <weidongcui(a)gmail.com>
> Signed-off-by: Xinyang Ge <aegiryy(a)gmail.com>

ACPICA material, left to Erik & Bob, thanks!

> ---
>  drivers/acpi/acpica/evhandler.c | 2 ++
>  include/acpi/acconfig.h         | 4 ++++
>  2 files changed, 6 insertions(+)
>
> diff --git a/drivers/acpi/acpica/evhandler.c b/drivers/acpi/acpica/evhand=
ler.c
> index 5884eba04..4c25ad433 100644
> --- a/drivers/acpi/acpica/evhandler.c
> +++ b/drivers/acpi/acpica/evhandler.c
> @@ -26,7 +26,9 @@ acpi_ev_install_handler(acpi_handle obj_handle,
>  u8 acpi_gbl_default_address_spaces[ACPI_NUM_DEFAULT_SPACES] =3D {
>         ACPI_ADR_SPACE_SYSTEM_MEMORY,
>         ACPI_ADR_SPACE_SYSTEM_IO,
> +#ifdef ACPI_PCI_CONFIGURED
>         ACPI_ADR_SPACE_PCI_CONFIG,
> +#endif
>         ACPI_ADR_SPACE_DATA_TABLE
>  };
>
> diff --git a/include/acpi/acconfig.h b/include/acpi/acconfig.h
> index a225eff49..790999028 100644
> --- a/include/acpi/acconfig.h
> +++ b/include/acpi/acconfig.h
> @@ -162,7 +162,11 @@
>  /* Maximum space_ids for Operation Regions */
>
>  #define ACPI_MAX_ADDRESS_SPACE          255
> +#ifdef ACPI_PCI_CONFIGURED
>  #define ACPI_NUM_DEFAULT_SPACES         4
> +#else
> +#define ACPI_NUM_DEFAULT_SPACES         3
> +#endif
>
>  /* Array sizes.  Used for range checking also */
>
> --
> 2.24.3 (Apple Git-128)
>
--===============1201879373567332219==--

