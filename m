Content-Type: multipart/mixed; boundary="===============8716049057124634676=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: Re: [Devel] [patch 3/6] From: <idoenmez@suse.de>
Date: Wed, 19 Sep 2012 15:08:17 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E346B643EB@ORSMSX101.amr.corp.intel.com>
In-Reply-To: 20120919111905.287403690@ett.arch.suse.de
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============8716049057124634676==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Thomas,

This code is not used to insert the date/time into AML "binaries". It is us=
ed for the various listing files.

Can you explain further?

Bob


> -----Original Message-----
> From: devel-bounces(a)acpica.org [mailto:devel-bounces(a)acpica.org] On
> Behalf Of trenn(a)suse.de
> Sent: Wednesday, September 19, 2012 4:15 AM
> To: devel(a)acpica.org
> Subject: [Devel] [patch 3/6] From: <idoenmez(a)suse.de>
> =

> acpica: Do not compile in date or time into binaries
> =

> Otherwise the data/time compiled in may cause constant re-compilation in
> build service environments
> =

> Signed-off-by: Thomas Renninger <trenn(a)suse.de>
> ---
>  source/compiler/aslcompile.c |    9 ++-------
>  source/compiler/aslutils.c   |    4 ++--
>  source/include/acapps.h      |    8 ++++----
>  3 files changed, 8 insertions(+), 13 deletions(-)
> =

> Index: acpica-unix2-20120913/source/compiler/aslcompile.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- acpica-unix2-20120913.orig/source/compiler/aslcompile.c
> +++ acpica-unix2-20120913/source/compiler/aslcompile.c
> @@ -161,8 +161,6 @@ void
>  AslCompilerFileHeader (
>      UINT32                  FileId)
>  {
> -    struct tm               *NewTime;
> -    time_t                  Aclock;
>      char                    *Prefix =3D "";
> =

> =

> @@ -202,12 +200,9 @@ AslCompilerFileHeader (
> =

>      /* Compilation header with timestamp */
> =

> -    (void) time (&Aclock);
> -    NewTime =3D localtime (&Aclock);
> -
>      FlPrintFile (FileId,
> -        "%sCompilation of \"%s\" - %s%s\n",
> -        Prefix, Gbl_Files[ASL_FILE_INPUT].Filename, asctime (NewTime),
> +        "%sCompilation of \"%s\"\n",
> +        Prefix, Gbl_Files[ASL_FILE_INPUT].Filename,
>          Prefix);
> =

>      switch (FileId)
> Index: acpica-unix2-20120913/source/compiler/aslutils.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- acpica-unix2-20120913.orig/source/compiler/aslutils.c
> +++ acpica-unix2-20120913/source/compiler/aslutils.c
> @@ -456,8 +456,8 @@ UtDisplaySummary (
>      {
>          /* Compiler name and version number */
> =

> -        FlPrintFile (FileId, "%s version %X%s [%s]\n\n",
> -            ASL_COMPILER_NAME, (UINT32) ACPI_CA_VERSION, ACPI_WIDTH,
> __DATE__);
> +        FlPrintFile (FileId, "%s version %X%s\n\n",
> +            ASL_COMPILER_NAME, (UINT32) ACPI_CA_VERSION, ACPI_WIDTH);
>      }
> =

>      /* Summary of main input and output files */
> Index: acpica-unix2-20120913/source/include/acapps.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- acpica-unix2-20120913.orig/source/include/acapps.h
> +++ acpica-unix2-20120913/source/include/acapps.h
> @@ -69,15 +69,15 @@
>  /* Macros for signons and file headers */
> =

>  #define ACPI_COMMON_SIGNON(UtilityName) \
> -    "\n%s\n%s version %8.8X%s [%s]\n%s\n\n", \
> +    "\n%s\n%s version %8.8X%s\n%s\n\n", \
>      ACPICA_NAME, \
> -    UtilityName, ((UINT32) ACPI_CA_VERSION), ACPI_WIDTH, __DATE__, \
> +    UtilityName, ((UINT32) ACPI_CA_VERSION), ACPI_WIDTH, \
>      ACPICA_COPYRIGHT
> =

>  #define ACPI_COMMON_HEADER(UtilityName, Prefix) \
> -    "%s%s\n%s%s version %8.8X%s [%s]\n%s%s\n%s\n", \
> +    "%s%s\n%s%s version %8.8X%s\n%s%s\n%s\n", \
>      Prefix, ACPICA_NAME, \
> -    Prefix, UtilityName, ((UINT32) ACPI_CA_VERSION), ACPI_WIDTH,
> __DATE__, \
> +    Prefix, UtilityName, ((UINT32) ACPI_CA_VERSION), ACPI_WIDTH, \
>      Prefix, ACPICA_COPYRIGHT, \
>      Prefix
> =

> =

> _______________________________________________
> Devel mailing list
> Devel(a)acpica.org
> http://lists.acpica.org/listinfo/devel

--===============8716049057124634676==--

