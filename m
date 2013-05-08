Content-Type: multipart/mixed; boundary="===============4839992872687852858=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: Re: [Devel] [PATCH 2/2] Resolve problem where -Werror fails to
 build	when compiling iasl
Date: Wed, 08 May 2013 19:56:05 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E36FE5459B@ORSMSX103.amr.corp.intel.com>
In-Reply-To: 1368021217-19585-3-git-send-email-naresh.bhat@linaro.org
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============4839992872687852858==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

What version of gcc is this?

Anyway, this is not quite the final patch, but I think we have it correct.
See the git commit.

Thanks,
Bob


> -----Original Message-----
> From: devel-bounces(a)acpica.org [mailto:devel-bounces(a)acpica.org] On B=
ehalf
> Of Naresh Bhat
> Sent: Wednesday, May 08, 2013 6:54 AM
> To: devel(a)acpica.org
> Cc: al.stone(a)linaro.org
> Subject: [Devel] [PATCH 2/2] Resolve problem where -Werror fails to build
> when compiling iasl
> =

> Signed-off-by: Naresh Bhat <naresh.bhat(a)linaro.org>
> Signed-off-by: Al Stone <ahs3(a)redhat.com>
> =

> While compiling ACPI test suite on ARM architecture got the following
> error .
> ..
> ...
> mits -o obj32/dtio.o ../../../source/compiler/dtio.c
> ../../../source/compiler/dtio.c: In function 'DtGetNextLine':
> ../../../source/compiler/dtio.c:516:9: error: comparison is always false
> due to limited range of data type [-Werror=3Dtype-limits]
> cc1: all warnings being treated as errors
> make[1]: *** [obj32/dtio.o] Error 1
> ...
> ....
> This patch will resolve problem where -Werror fails to build when
> compiling iasl
> ---
>  source/compiler/dtio.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> =

> diff --git a/source/compiler/dtio.c b/source/compiler/dtio.c index
> 724115c..1593afb 100644
> --- a/source/compiler/dtio.c
> +++ b/source/compiler/dtio.c
> @@ -498,7 +498,7 @@ DtGetNextLine (
>      UINT32                  State =3D DT_NORMAL_TEXT;
>      UINT32                  CurrentLineOffset;
>      UINT32                  i;
> -    char                    c;
> +    int                     c;
> =

> =

>      for (i =3D 0; ;)
> @@ -512,7 +512,7 @@ DtGetNextLine (
>              UtExpandLineBuffers ();
>          }
> =

> -        c =3D (char) getc (Handle);
> +        c =3D getc (Handle);
>          if (c =3D=3D EOF)
>          {
>              switch (State)
> --
> 1.7.9.5
> =

> _______________________________________________
> Devel mailing list
> Devel(a)acpica.org
> https://lists.acpica.org/mailman/listinfo/devel

--===============4839992872687852858==--

