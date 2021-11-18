Content-Type: multipart/mixed; boundary="===============5039342217350562618=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: [Devel] Re: [PATCH] ACPICA: fix swap.cocci warning
Date: Thu, 18 Nov 2021 15:46:10 +0100
Message-ID: <CAJZ5v0ixtvzNiAwwLtXXgG-8FdvtWYy7RUh0pFz65sjcmyuNdQ@mail.gmail.com>
In-Reply-To: 20211109134728.1710-1-guozhengkui@vivo.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============5039342217350562618==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 9, 2021 at 2:47 PM Guo Zhengkui <guozhengkui(a)vivo.com> wrote:
>
> Fix following swap.cocci warning:
> ./drivers/acpi/acpica/nsrepair2.c:896:33-34: WARNING
> opportunity for swap()
>
> Signed-off-by: Guo Zhengkui <guozhengkui(a)vivo.com>

This change needs to be submitted to the upstream ACPICA project via
https://github.com/acpica/acpica/

Thanks!

> ---
>  drivers/acpi/acpica/nsrepair2.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/acpi/acpica/nsrepair2.c b/drivers/acpi/acpica/nsrepa=
ir2.c
> index 14b71b41e845..02a904ca4caf 100644
> --- a/drivers/acpi/acpica/nsrepair2.c
> +++ b/drivers/acpi/acpica/nsrepair2.c
> @@ -8,6 +8,7 @@
>   *
>   ***********************************************************************=
******/
>
> +#include <linux/minmax.h>
>  #include <acpi/acpi.h>
>  #include "accommon.h"
>  #include "acnamesp.h"
> @@ -875,7 +876,6 @@ acpi_ns_sort_list(union acpi_operand_object **element=
s,
>  {
>         union acpi_operand_object *obj_desc1;
>         union acpi_operand_object *obj_desc2;
> -       union acpi_operand_object *temp_obj;
>         u32 i;
>         u32 j;
>
> @@ -892,9 +892,7 @@ acpi_ns_sort_list(union acpi_operand_object **element=
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
> 2.20.1
>
--===============5039342217350562618==--

