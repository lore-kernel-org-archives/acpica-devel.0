Content-Type: multipart/mixed; boundary="===============5654654324962697714=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: [Devel] Re: [PATCH v3 1/2] ACPI: Add _PLD panel positions
Date: Wed, 14 Apr 2021 15:50:53 +0200
Message-ID: <CAJZ5v0ich7DA47ybP552MJJg6-TkShnJyGcrz0PpWYETHHREHQ@mail.gmail.com>
In-Reply-To: 20210414083022.25453-2-me@fabwu.ch
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============5654654324962697714==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 14, 2021 at 10:30 AM Fabian W=C3=BCthrich <me(a)fabwu.ch> wrote:
>
> The ACPI specification v6.3 defines the panel positions in chapter 6.1.8
> "_PLD (Physical Location of Device)"
>
> Signed-off-by: Fabian W=C3=BCthrich <me(a)fabwu.ch>
> Reviewed-by: Daniel Scally <djrscally(a)gmail.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko(a)gmail.com>

This is ACPICA material.

Erik, can you pick up this one, please?

> ---
>  include/acpi/acbuffer.h | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/include/acpi/acbuffer.h b/include/acpi/acbuffer.h
> index 18197c16149f..d42e82a82852 100644
> --- a/include/acpi/acbuffer.h
> +++ b/include/acpi/acbuffer.h
> @@ -207,4 +207,13 @@ struct acpi_pld_info {
>  #define ACPI_PLD_GET_HORIZ_OFFSET(dword)        ACPI_GET_BITS (dword, 16=
, ACPI_16BIT_MASK)
>  #define ACPI_PLD_SET_HORIZ_OFFSET(dword,value)  ACPI_SET_BITS (dword, 16=
, ACPI_16BIT_MASK, value)      /* Offset 128+16=3D144, Len 16 */
>
> +/* Panel position defined in _PLD section of ACPI Specification 6.3 */
> +#define ACPI_PLD_PANEL_TOP                     0
> +#define ACPI_PLD_PANEL_BOTTOM                  1
> +#define ACPI_PLD_PANEL_LEFT                    2
> +#define ACPI_PLD_PANEL_RIGHT                   3
> +#define ACPI_PLD_PANEL_FRONT                   4
> +#define ACPI_PLD_PANEL_BACK                    5
> +#define ACPI_PLD_PANEL_UNKNOWN                 6
> +
>  #endif                         /* ACBUFFER_H */
> --
> 2.31.1
>
--===============5654654324962697714==--

