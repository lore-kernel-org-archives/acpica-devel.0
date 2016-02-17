Content-Type: multipart/mixed; boundary="===============4884774522757206950=="
MIME-Version: 1.0
From: Zheng, Lv <lv.zheng at intel.com>
Subject: Re: [Devel] [PATCH] compiler: remove unnecessary zero check on
 Length	before zero'ing it
Date: Wed, 17 Feb 2016 05:58:02 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E883BB4BE5A@SHSMSX101.ccr.corp.intel.com>
In-Reply-To: 1452162077-12119-1-git-send-email-colin.king@canonical.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============4884774522757206950==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

> From: Devel [mailto:devel-bounces(a)acpica.org] On Behalf Of Colin King
> Subject: [Devel] [PATCH] compiler: remove unnecessary zero check on Length
> before zero'ing it
> =

> From: Colin Ian King <colin.king(a)canonical.com>
> =

> Length is being checked to see if the contents is non-zero before
> setting it to zero. It would be simpler to just set this to zero
> without doing the non-zero check as it saves a load and a jmp
> (~14 bytes in x86 object code). This also fixes a static analysis
> warning in DtCompileIort:
> =

> CID 1298707 (#1 of 1): Uninitialized scalar variable (UNINIT).
>   uninit_use_in_call: Using uninitialized value PaddingLength
>   when calling DtCompileGeneric.
> =

> ..since the length is not being intitialized in this code before
> calling DtCompileGeneric.
> =

> Signed-off-by: Colin Ian King <colin.king(a)canonical.com>

Acked-by: Lv Zheng <lv.zheng(a)intel.com>

Thanks
-Lv

> ---
>  source/compiler/dttable2.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> =

> diff --git a/source/compiler/dttable2.c b/source/compiler/dttable2.c
> index b281b5c..1add6f7 100644
> --- a/source/compiler/dttable2.c
> +++ b/source/compiler/dttable2.c
> @@ -1707,7 +1707,7 @@ DtCompileGeneric (
> =

>      /* Now we can actually compile the parse tree */
> =

> -    if (Length && *Length)
> +    if (Length)
>      {
>          *Length =3D 0;
>      }
> --
> 2.7.0.rc3
> =

> _______________________________________________
> Devel mailing list
> Devel(a)acpica.org
> https://lists.acpica.org/mailman/listinfo/devel

--===============4884774522757206950==--

