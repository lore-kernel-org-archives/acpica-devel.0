Content-Type: multipart/mixed; boundary="===============6936903545336117047=="
MIME-Version: 1.0
From: Colin Ian King <colin.king at canonical.com>
Subject: Re: [Devel] [PATCH] Remove redundant assignment to NamepathOffset
Date: Wed, 03 May 2017 14:56:04 +0100
Message-ID: <7a341ec8-9336-0b3a-f6be-6262e366da79@canonical.com>
In-Reply-To: 20170418213047.18143-1-colin.king@canonical.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============6936903545336117047==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 18/04/17 22:30, Colin King wrote:
> From: Colin Ian King <colin.king(a)canonical.com>
> =

> NamepathOffset is being assigned and not used and the a few
> statements later it is being re-assigned, hence the earlier
> assignment is redundant and can be removed.  Remove it.
> =

> Signed-off-by: Colin Ian King <colin.king(a)canonical.com>
> ---
>  source/compiler/asloffset.c | 1 -
>  1 file changed, 1 deletion(-)
> =

> diff --git a/source/compiler/asloffset.c b/source/compiler/asloffset.c
> index e3fdf1c91..0964d4fea 100644
> --- a/source/compiler/asloffset.c
> +++ b/source/compiler/asloffset.c
> @@ -250,7 +250,6 @@ LsAmlOffsetWalk (
>          }
>  =

>          Length =3D Op->Asl.FinalAmlLength;
> -        NamepathOffset =3D Gbl_CurrentAmlOffset + Length;
>  =

>          /* Get to the NameSeg/NamePath Op (and length of the name) */
>  =

> =

Any chance this will be reviewed?

--===============6936903545336117047==--

