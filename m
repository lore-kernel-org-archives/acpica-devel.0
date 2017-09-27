Content-Type: multipart/mixed; boundary="===============7651914999924165952=="
MIME-Version: 1.0
From: Zheng, Lv <lv.zheng at intel.com>
Subject: Re: [Devel] [PATCH] tools/power/acpi: fix acpi power tool building
 error
Date: Wed, 27 Sep 2017 02:54:43 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E886CF6D69A@SHSMSX101.ccr.corp.intel.com>
In-Reply-To: 1504282974-2821-1-git-send-email-18502523564@163.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============7651914999924165952==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

> From: winton.liu [mailto:18502523564(a)163.com]
> Subject: [PATCH] tools/power/acpi: fix acpi power tool building error
> =

> When we tried to build acpi power tool, just like the following:
>  $make tools/acpi
>  ... ...
>  can't create power/acpi/tools/acpidbg/acpidbg.o: No such file or directo=
ry
>  ... ...
> =

> Root cause is that the 'tools' folder in the path
> 'power/acpi/tools/acpidbg/acpidbg.o' doesn't exist.

The problem actually is:
The tools/power/acpi makefiles tried to derive the descend mechanism from t=
ools generic makefile.
And the generic descend mechanism contains a trick to hide the intermediate=
 folder (ex., power) and finally it doesn't cover all build cases.

For example:
1. Stay in kernel source tree, type "make tools/acpi"
2. Stay in tools folder, type "make acpi"
3. Stay in tools/power/acpi, type "make"
4. Stay in tools/power/acpi/tools/acpidbg, type "make"
And if you combine -O, you'll find more problems.
It's not resolvable unless you can fix the descend mechanism.

Currently, we prepared the makefile to be safe for
1. Case 2,3,4 without -O.
2. Case 2 with -O
So you need to ensure all supported stuffs are still working after applying=
 your change.

Thanks
Lv

> =

> Signed-off-by: winton.liu <18502523564(a)163.com>
> ---
>  tools/power/acpi/Makefile.config | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> =

> diff --git a/tools/power/acpi/Makefile.config b/tools/power/acpi/Makefile=
.config
> index a1883bb..fb5559f 100644
> --- a/tools/power/acpi/Makefile.config
> +++ b/tools/power/acpi/Makefile.config
> @@ -18,7 +18,7 @@ include $(srctree)/../../scripts/Makefile.include
> =

>  OUTPUT=3D$(srctree)/
>  ifeq ("$(origin O)", "command line")
> -	OUTPUT :=3D $(O)/power/acpi/
> +	OUTPUT :=3D $(O)/tools/power/acpi/
>  endif
>  #$(info Determined 'OUTPUT' to be $(OUTPUT))
> =

> --
> 1.9.1
> =



--===============7651914999924165952==--

