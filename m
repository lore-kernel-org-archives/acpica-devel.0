Content-Type: multipart/mixed; boundary="===============2962052327326686862=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: [Devel] Re: [PATCH 2/2] ACPI: SPCR: Add support for the new
 16550-compatible Serial Port Subtype
Date: Mon, 16 Aug 2021 18:39:32 +0200
Message-ID: <CAJZ5v0gAmajYYDhYhum-QbyreWYf-4R0ecrDL_hLXp=w4T1FBQ@mail.gmail.com>
In-Reply-To: 20210714214346.1397942-3-mw@semihalf.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============2962052327326686862==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 14, 2021 at 11:46 PM Marcin Wojtas <mw(a)semihalf.com> wrote:
>
> The Microsoft Debug Port Table 2 (DBG2) specification revision
> May 31, 2017 added definition of the 16550-compatible Serial Port
> Subtype with parameters defined in Generic Address Structure (GAS) [1]
>
> Add its support in the SPCR table parsing routine.
>
> [1] https://docs.microsoft.com/en-us/windows-hardware/drivers/bringup/acp=
i-debug-port-table
>
> Signed-off-by: Marcin Wojtas <mw(a)semihalf.com>
> ---
>  drivers/acpi/spcr.c | 1 +
>  1 file changed, 1 insertion(+)
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

Applied as 5.15 material, thanks!
--===============2962052327326686862==--

