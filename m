Content-Type: multipart/mixed; boundary="===============6154312705720093757=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: Re: [Devel] [PATCH] ACPICA: Namespace: fix the no brace needed warning
Date: Mon, 02 Sep 2019 23:32:01 +0200
Message-ID: <CAJZ5v0huLagaNiK38JRaYY7=N38HSrHSqbw-HJiQDUmg_HTE2Q@mail.gmail.com>
In-Reply-To: 1567240295-44686-1-git-send-email-tiantao6@huawei.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============6154312705720093757==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 31, 2019 at 10:34 AM tiantao <tiantao6(a)huawei.com> wrote:
>
> for if else statements having single block no braces are needed fixed
> the following checkpatch warning
>
> WARNING: braces {} are not necessary for any arm of this statement
> +               if (!prev_node) {
> [...]
> +               } else {
> [...]
>
> Signed-off-by: tiantao <tiantao6(a)huawei.com>
> ---
>  drivers/acpi/acpica/nsaccess.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/acpi/acpica/nsaccess.c b/drivers/acpi/acpica/nsacces=
s.c
> index 2566e2d..7cef22a 100644
> --- a/drivers/acpi/acpica/nsaccess.c
> +++ b/drivers/acpi/acpica/nsaccess.c
> @@ -109,11 +109,10 @@ acpi_status acpi_ns_root_initialize(void)
>                 new_node->descriptor_type =3D ACPI_DESC_TYPE_NAMED;
>                 new_node->type =3D init_val->type;
>
> -               if (!prev_node) {
> +               if (!prev_node)
>                         acpi_gbl_root_node_struct.child =3D new_node;
> -               } else {
> +               else
>                         prev_node->peer =3D new_node;
> -               }
>
>                 new_node->parent =3D &acpi_gbl_root_node_struct;
>                 prev_node =3D new_node;
> --

The ACPICA code comes from an external project and the coding style in
it is different from the rest of the kernel, so the patch is not
applicable.

Thanks!

--===============6154312705720093757==--

