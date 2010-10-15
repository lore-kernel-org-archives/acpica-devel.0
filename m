Content-Type: multipart/mixed; boundary="===============6202275893248133320=="
MIME-Version: 1.0
From: Lin Ming <ming.m.lin at intel.com>
Subject: Re: [Devel] [PATCH] ACPICA: Sanity check global lock bits before ACPI
 mode is enabled
Date: Fri, 15 Oct 2010 11:34:10 +0800
Message-ID: <1287113650.6530.3007.camel@minggr.sh.intel.com>
In-Reply-To: 1287001053-9964-1-git-send-email-trenn@suse.de
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============6202275893248133320==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 2010-10-14 at 04:17 +0800, Thomas Renninger wrote:
> Be careful, not even compile tested!

Compile error, =


- AcpiGbl_FACS.GlobalLock
+ AcpiGbl_FACS->GlobalLock

Thanks,
Lin Ming

> =

> Reason for moving AcpiTbInitializeFacs:
> Doing the sanity check shortly after enabling ACPI mode may more often sh=
ow:
>     if (AcpiGbl_FACS.GlobalLock & 0x1) {
>         ACPI_INFO ((AE_INFO, "Global lock acquired by BIOS before"
> 		    " ACPI mode got enabled"));
> Because it's expected that BIOS may do quite some HW accesses when acpi
> got enabled (assumption).
> =

> CC: Lin Ming <ming.m.lin(a)intel.com>
> CC: Len Brown <lenb(a)kernel.org>
> CC: Rafael Wysocki <rjw(a)suse.com>
> CC: devel(a)acpica.org
> Signed-off-by: Thomas Renninger <trenn(a)suse.de>
> ---
>  source/components/tables/tbutils.c    |   21 +++++++++++++++++++--
>  source/components/utilities/utxface.c |   23 ++++++++++++-----------
>  2 files changed, 31 insertions(+), 13 deletions(-)
> =

> diff --git a/source/components/tables/tbutils.c b/source/components/table=
s/tbutils.c
> index 100a91d..4562e9b 100644
> --- a/source/components/tables/tbutils.c
> +++ b/source/components/tables/tbutils.c
> @@ -159,10 +159,27 @@ AcpiTbInitializeFacs (
>  {
>      ACPI_STATUS             Status;
>  =

> -
>      Status =3D AcpiGetTableByIndex (ACPI_TABLE_INDEX_FACS,
>                  ACPI_CAST_INDIRECT_PTR (ACPI_TABLE_HEADER, &AcpiGbl_FACS=
));
> -    return (Status);
> +
> +    if (ACPI_FAILURE (Status))
> +	return (Status);
> +
> +    /*
> +     * Do some sanity checks on the Global Lock: A value of 0x1 is
> +     * possible but could be a hint for a hard to debug issue.
> +     * A value of 0x3 must not happen, but we try to handle it gracefull=
y.
> +     */
> +    if (AcpiGbl_FACS.GlobalLock & 0x1) {
> +        ACPI_INFO ((AE_INFO, "Global lock acquired by BIOS before"
> +		    " ACPI mode got enabled"));
> +	if (AcpiGbl_FACS.GlobalLock & 0x3) {
> +	    ACPI_ERROR ((AE_INFO, "Found stale global lock pending bits"));
> +	    AcpiGbl_FACS.GlobalLock &=3D ~0x3;
> +	}
> +    }
> +
> +    return (AE_OK);
>  }
>  =

> =

> diff --git a/source/components/utilities/utxface.c b/source/components/ut=
ilities/utxface.c
> index 9e52017..0819135 100644
> --- a/source/components/utilities/utxface.c
> +++ b/source/components/utilities/utxface.c
> @@ -193,6 +193,18 @@ AcpiInitializeSubsystem (
>          return_ACPI_STATUS (Status);
>      }
>  =

> +    /*
> +     * Obtain a permanent mapping for the FACS. This is required for the
> +     * Global Lock and the Firmware Waking Vector
> +     */
> +    Status =3D AcpiTbInitializeFacs ();
> +    if (ACPI_FAILURE (Status))
> +    {
> +        ACPI_WARNING ((AE_INFO, "Could not map the FACS table"));
> +        return_ACPI_STATUS (Status);
> +    }
> +
> +
>      /* Initialize the global OSI interfaces list with the static names */
>  =

>      Status =3D AcpiUtInitializeInterfaces ();
> @@ -251,17 +263,6 @@ AcpiEnableSubsystem (
>      }
>  =

>      /*
> -     * Obtain a permanent mapping for the FACS. This is required for the
> -     * Global Lock and the Firmware Waking Vector
> -     */
> -    Status =3D AcpiTbInitializeFacs ();
> -    if (ACPI_FAILURE (Status))
> -    {
> -        ACPI_WARNING ((AE_INFO, "Could not map the FACS table"));
> -        return_ACPI_STATUS (Status);
> -    }
> -
> -    /*
>       * Install the default OpRegion handlers.  These are installed unless
>       * other handlers have already been installed via the
>       * InstallAddressSpaceHandler interface.



--===============6202275893248133320==--

