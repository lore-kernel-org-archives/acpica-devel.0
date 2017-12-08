Content-Type: multipart/mixed; boundary="===============1829858922801976451=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: Re: [Devel] [PATCH] ACPICA: Fix indentation
Date: Fri, 08 Dec 2017 18:06:19 +0100
Message-ID: <CAJZ5v0hgt8MLkxSHeN1A49p4g6VCr-r8x7RGun9eVmtx0PZKgg@mail.gmail.com>
In-Reply-To: 1512750553-15467-1-git-send-email-gomonovych@gmail.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============1829858922801976451==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 8, 2017 at 5:29 PM, Vasyl Gomonovych <gomonovych(a)gmail.com> w=
rote:
> This patch avoids that smatch reports the following:
> drivers/acpi/acpica/exdump.c:623 acpi_ex_dump_operand() warn: inconsisten=
t indenting
>
> Signed-off-by: Vasyl Gomonovych <gomonovych(a)gmail.com>

This is ACPICA code, so changes like this should go in via the upstream.

Erik may want to pick this up, however.

> ---
>  drivers/acpi/acpica/exdump.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/acpi/acpica/exdump.c b/drivers/acpi/acpica/exdump.c
> index 83398dc..f43d3d7 100644
> --- a/drivers/acpi/acpica/exdump.c
> +++ b/drivers/acpi/acpica/exdump.c
> @@ -619,8 +619,8 @@ void acpi_ex_dump_operand(union acpi_operand_object *=
obj_desc, u32 depth)
>
>         ACPI_FUNCTION_NAME(ex_dump_operand)
>
> -           /* Check if debug output enabled */
> -           if (!ACPI_IS_DEBUG_ENABLED(ACPI_LV_EXEC, _COMPONENT)) {
> +       /* Check if debug output enabled */
> +       if (!ACPI_IS_DEBUG_ENABLED(ACPI_LV_EXEC, _COMPONENT)) {
>                 return;
>         }
>
> --

--===============1829858922801976451==--

