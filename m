Content-Type: multipart/mixed; boundary="===============2977012541378188895=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: [Devel] Re: [PATCH] ACPICA: proactively check null ptr to avoid API
 misuse
Date: Wed, 16 Feb 2022 13:22:27 +0100
Message-ID: <CAJZ5v0hsDVqZM=iP=4CYhGT99ScQ1xQNYHKcdJHHCscEhXOoCA@mail.gmail.com>
In-Reply-To: 20220216062615.779778-1-ztong0001@gmail.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============2977012541378188895==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 16, 2022 at 7:26 AM Tong Zhang <ztong0001(a)gmail.com> wrote:
>
> There are some cases that user use acpi_ns_walk_namespace() without
> checking acpi_disable flag. When acpi=3Doff is provided in boot cmdline,
> acpi_gbl_root_node is NULL and calling acpi_ns_walk_namespace() will
> crash kernel. In order to avoid such misuse, we proactively check null ptr
> and return an error when we know ACPI is disabled.

The issue should be fixed by this commit in the upstream ACPICA code
base: https://github.com/acpica/acpica/commit/b1c3656ef4950098e530be68d4b58=
9584f06cddc

>
> Signed-off-by: Tong Zhang <ztong0001(a)gmail.com>
> ---
>  drivers/acpi/acpica/nswalk.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/acpi/acpica/nswalk.c b/drivers/acpi/acpica/nswalk.c
> index 915c2433463d..9ae45db16d86 100644
> --- a/drivers/acpi/acpica/nswalk.c
> +++ b/drivers/acpi/acpica/nswalk.c
> @@ -171,6 +171,13 @@ acpi_ns_walk_namespace(acpi_object_type type,
>                 start_node =3D acpi_gbl_root_node;
>         }
>
> +       /* acpi_gbl_root_node is NULL when acpi=3Doff is provided.
> +        * We proactively check nulliness here and return an error if use=
r call
> +        * this function without checking acpi_disabled
> +        */
> +       if (start_node =3D=3D NULL)
> +               return_ACPI_STATUS(AE_ERROR);
> +
>         /* Null child means "get first node" */
>
>         parent_node =3D start_node;
> --
> 2.25.1
>
--===============2977012541378188895==--

