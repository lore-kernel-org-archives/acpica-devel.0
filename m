Content-Type: multipart/mixed; boundary="===============8633285623240679531=="
MIME-Version: 1.0
From: Zheng, Lv <lv.zheng at intel.com>
Subject: Re: [Devel] [PATCH] ACPICA: remove duplicate u8 typedef
Date: Wed, 29 Apr 2015 00:27:51 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E880270FB03@SHSMSX101.ccr.corp.intel.com>
In-Reply-To: 1430232844-11018-1-git-send-email-olaf@aepfle.de
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============8633285623240679531==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

> From: Olaf Hering [mailto:olaf(a)aepfle.de]
> Sent: Tuesday, April 28, 2015 10:54 PM
> Subject: [PATCH] ACPICA: remove duplicate u8 typedef
> =

> During commit e252652fb2664d42de19f933aa3688bbc470de3f ("ACPICA:
> acpidump: Remove integer types translation protection.") two 'unsigned
> char' types got converted to 'u8'.
> =

> The result does not compile with gcc-4.5, it can not cope with duplicate
> typedefs.

The 2 u8 typedefs actually are different types in ACPICA.
If this really causes problem, I'm OK with deleting it from Linux side.
We'll take care of introducing a new type to eliminate such "divergence".

Thanks
-Lv

> =

> Signed-off-by: Olaf Hering <olaf(a)aepfle.de>
> ---
>  include/acpi/actypes.h | 1 -
>  1 file changed, 1 deletion(-)
> =

> diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
> index f5ca0e9..1c3002e 100644
> --- a/include/acpi/actypes.h
> +++ b/include/acpi/actypes.h
> @@ -124,7 +124,6 @@
>  #ifndef ACPI_USE_SYSTEM_INTTYPES
> =

>  typedef unsigned char u8;
> -typedef unsigned char u8;
>  typedef unsigned short u16;
>  typedef short s16;
>  typedef COMPILER_DEPENDENT_UINT64 u64;

--===============8633285623240679531==--

