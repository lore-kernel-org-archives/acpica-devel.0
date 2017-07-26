Content-Type: multipart/mixed; boundary="===============0909823167697867409=="
MIME-Version: 1.0
From: Lorenzo Pieralisi <lorenzo.pieralisi at arm.com>
Subject: Re: [Devel] [PATCH] ResourceMgr: Allow _DMA method in walk resources
Date: Wed, 26 Jul 2017 18:04:03 +0100
Message-ID: <20170726170403.GA9926@red-moon>
In-Reply-To: 20170721152815.8501-1-lorenzo.pieralisi@arm.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============0909823167697867409==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Robert,

do you pull patches from the list or you require an explicit github pull
request for that ?

Plase let me know.

Thanks,
Lorenzo

On Fri, Jul 21, 2017 at 04:28:15PM +0100, Lorenzo Pieralisi wrote:
> The _DMA object contains a resource template, this change adds support
> for the walk resources function so that ACPI devices containing a _DMA
> object can actually parse it to detect DMA ranges for the respective
> bus.
> =

> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi(a)arm.com>
> ---
>  source/components/resources/rsxface.c | 7 ++++---
>  source/include/acnames.h              | 1 +
>  2 files changed, 5 insertions(+), 3 deletions(-)
> =

> diff --git a/source/components/resources/rsxface.c b/source/components/re=
sources/rsxface.c
> index 5e3f735..2c27eaf 100644
> --- a/source/components/resources/rsxface.c
> +++ b/source/components/resources/rsxface.c
> @@ -796,7 +796,7 @@ ACPI_EXPORT_SYMBOL (AcpiWalkResourceBuffer)
>   *                                device we are querying
>   *              Name            - Method name of the resources we want.
>   *                                (METHOD_NAME__CRS, METHOD_NAME__PRS, or
> - *                                METHOD_NAME__AEI)
> + *                                METHOD_NAME__AEI or METHOD_NAME__DMA)
>   *              UserFunction    - Called for each resource
>   *              Context         - Passed to UserFunction
>   *
> @@ -827,12 +827,13 @@ AcpiWalkResources (
>      if (!DeviceHandle || !UserFunction || !Name ||
>          (!ACPI_COMPARE_NAME (Name, METHOD_NAME__CRS) &&
>           !ACPI_COMPARE_NAME (Name, METHOD_NAME__PRS) &&
> -         !ACPI_COMPARE_NAME (Name, METHOD_NAME__AEI)))
> +         !ACPI_COMPARE_NAME (Name, METHOD_NAME__AEI) &&
> +         !ACPI_COMPARE_NAME (Name, METHOD_NAME__DMA)))
>      {
>          return_ACPI_STATUS (AE_BAD_PARAMETER);
>      }
>  =

> -    /* Get the _CRS/_PRS/_AEI resource list */
> +    /* Get the _CRS/_PRS/_AEI/_DMA resource list */
>  =

>      Buffer.Length =3D ACPI_ALLOCATE_LOCAL_BUFFER;
>      Status =3D AcpiRsGetMethodData (DeviceHandle, Name, &Buffer);
> diff --git a/source/include/acnames.h b/source/include/acnames.h
> index 27b0b97..69f8884 100644
> --- a/source/include/acnames.h
> +++ b/source/include/acnames.h
> @@ -162,6 +162,7 @@
>  #define METHOD_NAME__CLS        "_CLS"
>  #define METHOD_NAME__CRS        "_CRS"
>  #define METHOD_NAME__DDN        "_DDN"
> +#define METHOD_NAME__DMA        "_DMA"
>  #define METHOD_NAME__HID        "_HID"
>  #define METHOD_NAME__INI        "_INI"
>  #define METHOD_NAME__PLD        "_PLD"
> -- =

> 2.10.0
>=20

--===============0909823167697867409==--

