Content-Type: multipart/mixed; boundary="===============6084717187990699895=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: [Devel] Re: [PATCH v2 1/2] ACPI: AGDI: Add AGDI tables to drivers/acpi
Date: Wed, 15 Dec 2021 13:17:53 +0100
Message-ID: <CAJZ5v0jiLfL0k12y5RZ+9LjLqiBMPqRHrqNQGqQ5Le2yOv7QWQ@mail.gmail.com>
In-Reply-To: 20211214044036.48245-2-ilkka@os.amperecomputing.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============6084717187990699895==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 14, 2021 at 5:41 AM Ilkka Koskinen
<ilkka(a)os.amperecomputing.com> wrote:
>
> ACPI for Arm Components 1.1 Platform Design Document v1.1 [0] specifices
> Arm Generic Diagnostic Device Interface (AGDI). It allows an admin to
> issue diagnostic dump and reset via an SDEI event or an interrupt. This
> patch adds support to ACPI/AGDI tables.
>
> [0] https://developer.arm.com/documentation/den0093/latest/
>
> Signed-off-by: Ilkka Koskinen <ilkka(a)os.amperecomputing.com>
> ---
>  drivers/acpi/tables.c |  2 +-
>  include/acpi/actbl2.h | 20 ++++++++++++++++++++
>  2 files changed, 21 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
> index 71419eb16e09..5e3169bcb9fb 100644
> --- a/drivers/acpi/tables.c
> +++ b/drivers/acpi/tables.c
> @@ -500,7 +500,7 @@ static const char table_sigs[][ACPI_NAMESEG_SIZE] __i=
nitconst =3D {
>         ACPI_SIG_WDDT, ACPI_SIG_WDRT, ACPI_SIG_DSDT, ACPI_SIG_FADT,
>         ACPI_SIG_PSDT, ACPI_SIG_RSDT, ACPI_SIG_XSDT, ACPI_SIG_SSDT,
>         ACPI_SIG_IORT, ACPI_SIG_NFIT, ACPI_SIG_HMAT, ACPI_SIG_PPTT,
> -       ACPI_SIG_NHLT };
> +       ACPI_SIG_NHLT, ACPI_SIG_AGDI };
>
>  #define ACPI_HEADER_SIZE sizeof(struct acpi_table_header)
>
> diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
> index 71ca090fd61b..66ca85b9f5fe 100644
> --- a/include/acpi/actbl2.h
> +++ b/include/acpi/actbl2.h

The changes in actbl2.h are ACPICA material and so they need to be
routed through the upstream ACPICA project.

Moreover, you have already submitted a pull request with them to the
upstream: https://github.com/acpica/acpica/pull/737/commits/cf36a6d658ca5aa=
8c329c2edfc3322c095ffd844

Please wait until this gets integrated and repost the rest of the
patches as incremental changes on top of that.
--===============6084717187990699895==--

