Content-Type: multipart/mixed; boundary="===============5446662204359677785=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: [Devel] Re: [PATCH 1/1] Constify AcpiGetHandle pathname argument
Date: Wed, 27 Apr 2022 18:35:09 +0200
Message-ID: <CAJZ5v0ivSqJeMEYtJGQ7_Cic88L=H4Vc1k8by4hi6rP3_wXz3g@mail.gmail.com>
In-Reply-To: 20220427104957.956673-1-sakari.ailus@linux.intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============5446662204359677785==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 27, 2022 at 12:48 PM Sakari Ailus
<sakari.ailus(a)linux.intel.com> wrote:
>
> AcpiGetHandle doesn't write to the pathname argument, therefore make it
> const.
>
> This allows later on passing pathname to AcpiGetHandle which is const,
> without creating a copy of it.
>
> Signed-off-by: Sakari Ailus <sakari.ailus(a)linux.intel.com>
> ---
> Hi folks,
>
> This isn't required by acpica internally as such but upcoming patches to
> Linux depend on it.

I'm afraid that the kernel source cannot depart from the upstream
ACPICA this way, though.

>  source/components/namespace/nsxfname.c | 2 +-
>  source/include/acpixf.h                | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/source/components/namespace/nsxfname.c b/source/components/n=
amespace/nsxfname.c
> index 7a7393b61..da89b2d8e 100644
> --- a/source/components/namespace/nsxfname.c
> +++ b/source/components/namespace/nsxfname.c
> @@ -192,7 +192,7 @@ AcpiNsCopyDeviceId (
>  ACPI_STATUS
>  AcpiGetHandle (
>      ACPI_HANDLE             Parent,
> -    ACPI_STRING             Pathname,
> +    const char              *Pathname,
>      ACPI_HANDLE             *RetHandle)
>  {
>      ACPI_STATUS             Status;
> diff --git a/source/include/acpixf.h b/source/include/acpixf.h
> index 7610f2e30..a3f7397e7 100644
> --- a/source/include/acpixf.h
> +++ b/source/include/acpixf.h
> @@ -766,7 +766,7 @@ ACPI_EXTERNAL_RETURN_STATUS (
>  ACPI_STATUS
>  AcpiGetHandle (
>      ACPI_HANDLE             Parent,
> -    ACPI_STRING             Pathname,
> +    const char              *Pathname,
>      ACPI_HANDLE             *RetHandle))
>
>  ACPI_EXTERNAL_RETURN_STATUS (
> --
> 2.30.2
>
--===============5446662204359677785==--

