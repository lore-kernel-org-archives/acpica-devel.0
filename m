Content-Type: multipart/mixed; boundary="===============2756843921958085115=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: [Devel] Re: [PATCH v2 2/3] ACPI/table: Print MADT Wake table
 information
Date: Fri, 23 Apr 2021 14:38:41 +0200
Message-ID: <CAJZ5v0iwuqjPhceuO0dfq5zggpq9OHpv=bPtcZYhVtd-+-xyNQ@mail.gmail.com>
In-Reply-To: 20210422214708.716164-3-sathyanarayanan.kuppuswamy@linux.intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============2756843921958085115==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 22, 2021 at 11:47 PM Kuppuswamy Sathyanarayanan
<sathyanarayanan.kuppuswamy(a)linux.intel.com> wrote:
>
> When MADT is parsed, print MADT Wake table information as
> debug message. It will be useful to debug CPU boot issues
> related to MADT wake table.
>
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy(a)l=
inux.intel.com>

This obviously depends on the ACPICA changes from the previous patch,
so I can pick it up when that material gets integrated.

For now

Acked-by: Rafael J. Wysocki <rafael.j.wysocki(a)intel.com>

> ---
>  drivers/acpi/tables.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
> index 9d581045acff..206df4ad8b2b 100644
> --- a/drivers/acpi/tables.c
> +++ b/drivers/acpi/tables.c
> @@ -207,6 +207,17 @@ void acpi_table_print_madt_entry(struct acpi_subtabl=
e_header *header)
>                 }
>                 break;
>
> +       case ACPI_MADT_TYPE_MULTIPROC_WAKEUP:
> +               {
> +                       struct acpi_madt_multiproc_wakeup *p;
> +
> +                       p =3D (struct acpi_madt_multiproc_wakeup *) heade=
r;
> +
> +                       pr_debug("MP Wake (Mailbox version[%d] base_addre=
ss[%llx])\n",
> +                                p->mailbox_version, p->base_address);
> +               }
> +               break;
> +
>         default:
>                 pr_warn("Found unsupported MADT entry (type =3D 0x%x)\n",
>                         header->type);
> --
> 2.25.1
>
--===============2756843921958085115==--

