Content-Type: multipart/mixed; boundary="===============4458903518671411360=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: [Devel] Re: [PATCH] ACPICA: use swap() to make code cleaner
Date: Mon, 21 Feb 2022 20:18:13 +0100
Message-ID: <CAJZ5v0iUVfc-hr_stEbNEv2Ana+g-44Qrtm1b490cLZTDe=YEQ@mail.gmail.com>
In-Reply-To: 05530d163bb18634cceaf1f2b0b48409747d18d0.1644838495.git.yang.guang5@zte.com.cn
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============4458903518671411360==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 15, 2022 at 1:52 AM <davidcomponentone(a)gmail.com> wrote:
>
> From: Yang Guang <yang.guang5(a)zte.com.cn>
>
> Use the macro 'swap()' defined in 'include/linux/minmax.h' to avoid
> opencoding it.
>
> Reported-by: Zeal Robot <zealci(a)zte.com.cn>
> Signed-off-by: Yang Guang <yang.guang5(a)zte.com.cn>
> Signed-off-by: David Yang <davidcomponentone(a)gmail.com>
> ---
>  drivers/acpi/acpica/nsrepair2.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/drivers/acpi/acpica/nsrepair2.c b/drivers/acpi/acpica/nsrepa=
ir2.c
> index 14b71b41e845..ac6a5397660f 100644
> --- a/drivers/acpi/acpica/nsrepair2.c
> +++ b/drivers/acpi/acpica/nsrepair2.c
> @@ -875,7 +875,6 @@ acpi_ns_sort_list(union acpi_operand_object **element=
s,
>  {
>         union acpi_operand_object *obj_desc1;
>         union acpi_operand_object *obj_desc2;
> -       union acpi_operand_object *temp_obj;
>         u32 i;
>         u32 j;
>
> @@ -892,9 +891,7 @@ acpi_ns_sort_list(union acpi_operand_object **element=
s,
>                             || ((sort_direction =3D=3D ACPI_SORT_DESCENDI=
NG)
>                                 && (obj_desc1->integer.value <
>                                     obj_desc2->integer.value))) {
> -                               temp_obj =3D elements[j - 1];
> -                               elements[j - 1] =3D elements[j];
> -                               elements[j] =3D temp_obj;
> +                               swap(elements[j - 1], elements[j]);
>                         }
>                 }
>         }
> --

This is an ACPICA change that should be routed through the upstream
project at https://github.com/acpica/acpica, but there is no
counterpart of swap() in the upstream code base.
--===============4458903518671411360==--

