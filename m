Content-Type: multipart/mixed; boundary="===============1830815070989910145=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: [Devel] Re: [net-next: PATCH v3 1/1] ACPI: SPCR: Add new
 16550-compatible Serial Port Subtype
Date: Wed, 14 Jul 2021 14:27:01 +0200
Message-ID: <CAJZ5v0jegOF85Zvo8Oyio9cSvb_WfUCG0oNsXzWHSCTi151u0A@mail.gmail.com>
In-Reply-To: 20210621200459.3558199-1-mw@semihalf.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============1830815070989910145==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Sorry for the delay.

On Mon, Jun 21, 2021 at 10:05 PM Marcin Wojtas <mw(a)semihalf.com> wrote:
>
> The Microsoft Debug Port Table 2 (DBG2) specification revision
> May 31, 2017 adds support for 16550-compatible Serial Port
> Subtype with parameters defined in Generic Address Structure (GAS) [1]
>
> Add its support in SPCR parsing routine.
>
> [1] https://docs.microsoft.com/en-us/windows-hardware/drivers/bringup/acp=
i-debug-port-table
>
> Signed-off-by: Marcin Wojtas <mw(a)semihalf.com>
> ---
>  include/acpi/actbl1.h | 1 +
>  drivers/acpi/spcr.c   | 1 +
>  2 files changed, 2 insertions(+)
>
> diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
> index ce59903c2695..f746012eba8d 100644
> --- a/include/acpi/actbl1.h
> +++ b/include/acpi/actbl1.h

This is an ACPICA header, so the first part of the patch should go in
via the ACPICA upstream repository.

Can you please resend this as two patches to make it easier to process it?

> @@ -498,6 +498,7 @@ struct acpi_dbg2_device {
>  #define ACPI_DBG2_ARM_SBSA_GENERIC  0x000E
>  #define ACPI_DBG2_ARM_DCC           0x000F
>  #define ACPI_DBG2_BCM2835           0x0010
> +#define ACPI_DBG2_16550_WITH_GAS    0x0012
>
>  #define ACPI_DBG2_1394_STANDARD     0x0000
>
> diff --git a/drivers/acpi/spcr.c b/drivers/acpi/spcr.c
> index 88460bacd5ae..25c2d0be953e 100644
> --- a/drivers/acpi/spcr.c
> +++ b/drivers/acpi/spcr.c
> @@ -136,6 +136,7 @@ int __init acpi_parse_spcr(bool enable_earlycon, bool=
 enable_console)
>                 break;
>         case ACPI_DBG2_16550_COMPATIBLE:
>         case ACPI_DBG2_16550_SUBSET:
> +       case ACPI_DBG2_16550_WITH_GAS:
>                 uart =3D "uart";
>                 break;
>         default:
> --
> 2.29.0
>
--===============1830815070989910145==--

