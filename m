Content-Type: multipart/mixed; boundary="===============1680173641998139805=="
MIME-Version: 1.0
From: Stefan Reinauer <stefan.reinauer at coresystems.de>
Subject: Re: [Devel] ACPICA version 20100702 released
Date: Wed, 07 Jul 2010 10:55:05 +0200
Message-ID: <4C3440E9.5000004@coresystems.de>
In-Reply-To: 1278398690.4398.17.camel@minggr.sh.intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============1680173641998139805==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

 On 7/6/10 8:44 AM, Lin Ming wrote:
> Would you please try below patch?
>
Great! This works!

Stefan

> diff --git a/compiler/Makefile b/compiler/Makefile
> index 962ab67..c8c477b 100644
> --- a/compiler/Makefile
> +++ b/compiler/Makefile
> @@ -7,7 +7,7 @@ PROG=3D	iasl
>  ACPICA_SRC =3D    ..
>  ASL_COMPILER =3D  $(ACPICA_SRC)/compiler
>  ACPICA_COMMON =3D $(ACPICA_SRC)/common
> -ACPICA_CORE =3D   $(ACPICA_SRC)/components
> +ACPICA_CORE =3D   $(ACPICA_SRC)
>  ACPICA_TOOLS =3D  $(ACPICA_SRC)/tools
>  ACPICA_OSL =3D    $(ACPICA_SRC)/os_specific/service_layers
>  =

> diff --git a/tools/acpiexec/Makefile b/tools/acpiexec/Makefile
> index b9e892a..31f2338 100644
> --- a/tools/acpiexec/Makefile
> +++ b/tools/acpiexec/Makefile
> @@ -4,9 +4,9 @@
>  =

>  PROG =3D acpiexec
>  =

> -ACPICA_SRC =3D    ../../../source
> +ACPICA_SRC =3D    ../..
>  ACPICA_COMMON =3D $(ACPICA_SRC)/common
> -ACPICA_CORE =3D   $(ACPICA_SRC)/components
> +ACPICA_CORE =3D   $(ACPICA_SRC)
>  ACPICA_TOOLS =3D  $(ACPICA_SRC)/tools
>  ACPICA_OSL =3D    $(ACPICA_SRC)/os_specific/service_layers
>  =



--===============1680173641998139805==--

