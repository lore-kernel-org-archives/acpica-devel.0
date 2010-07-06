Content-Type: multipart/mixed; boundary="===============4287077310159432662=="
MIME-Version: 1.0
From: Lin Ming <ming.m.lin at intel.com>
Subject: Re: [Devel] [patch 4/5] Fix aligment issues
Date: Tue, 06 Jul 2010 09:19:47 +0800
Message-ID: <1278379187.9540.39.camel@minggr.sh.intel.com>
In-Reply-To: 20100705120818.293314314@linux.it
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============4287077310159432662==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, 2010-07-05 at 20:03 +0800, malattia(a)linux.it wrote:
> Add more platforms to the list of the ones requiring aligned memory acces=
s. Also
> fix callsites where wrong assumptions where made in terms of aligment.
> =

> Signed-off-by: Mattia Dongili <malattia(a)linux.it>
> ---
>  compiler/asltree.c  |   15 ++++++++++-----
>  executer/exoparg2.c |   12 +++++++++---
>  include/actypes.h   |   26 +++++++++++++-------------
>  3 files changed, 32 insertions(+), 21 deletions(-)
> =

> Index: b/include/actypes.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- a/include/actypes.h	2010-07-02 21:42:26.465350281 +0900
> +++ b/include/actypes.h	2010-07-04 11:18:22.506529460 +0900
> @@ -205,6 +205,19 @@
>  =

>  /*! [End] no source code translation !*/
>  =

> +/*
> + * In the case of the Itanium Processor Family (IPF), the hardware does =
not
> + * support misaligned memory transfers. Set the MISALIGNMENT_NOT_SUPPORT=
ED flag
> + * to indicate that special precautions must be taken to avoid alignment=
 faults.
> + * (IA64 or ia64 is currently used by existing compilers to indicate IPF=
.)
> + *
> + * Note: EM64T and other X86-64 processors support misaligned transfers,
> + * so there is no need to define this flag.
> + */
> +#if defined (__IA64__) || defined (__ia64__) | defined(__alpha__) || def=
ined(__sparc__) || defined(__hppa__) || defined(__arm__)
> +#define ACPI_MISALIGNMENT_NOT_SUPPORTED
> +#endif
> +
>  =

>  /***********************************************************************=
********
>   *
> @@ -231,19 +244,6 @@
>  #define ACPI_SIZE_MAX                   ACPI_UINT64_MAX
>  #define ACPI_USE_NATIVE_DIVIDE          /* Has native 64-bit integer sup=
port */
>  =

> -/*
> - * In the case of the Itanium Processor Family (IPF), the hardware does =
not
> - * support misaligned memory transfers. Set the MISALIGNMENT_NOT_SUPPORT=
ED flag
> - * to indicate that special precautions must be taken to avoid alignment=
 faults.
> - * (IA64 or ia64 is currently used by existing compilers to indicate IPF=
.)
> - *
> - * Note: EM64T and other X86-64 processors support misaligned transfers,
> - * so there is no need to define this flag.
> - */
> -#if defined (__IA64__) || defined (__ia64__)
> -#define ACPI_MISALIGNMENT_NOT_SUPPORTED
> -#endif
> -
>  =

>  /***********************************************************************=
********
>   *
> Index: b/executer/exoparg2.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- a/executer/exoparg2.c	2010-07-02 21:42:26.477349196 +0900
> +++ b/executer/exoparg2.c	2010-07-04 11:18:22.506529460 +0900
> @@ -248,6 +248,8 @@
>      ACPI_OPERAND_OBJECT     **Operand =3D &WalkState->Operands[0];
>      ACPI_OPERAND_OBJECT     *ReturnDesc1 =3D NULL;
>      ACPI_OPERAND_OBJECT     *ReturnDesc2 =3D NULL;
> +    UINT64                  ReturnValue1 =3D 0;
> +    UINT64                  ReturnValue2 =3D 0;
>      ACPI_STATUS             Status;
>  =

> =

> @@ -281,8 +283,10 @@
>  =

>          Status =3D AcpiUtDivide (Operand[0]->Integer.Value,
>                                 Operand[1]->Integer.Value,
> -                               &ReturnDesc1->Integer.Value,
> -                               &ReturnDesc2->Integer.Value);
> +                               &ReturnValue1, &ReturnValue2);

Why need to replace &ReturnDesc1->Integer.Value with &ReturnValue1?

> +        ReturnDesc1->Integer.Value =3D ReturnValue1;
> +        ReturnDesc2->Integer.Value =3D ReturnValue2;
> +
>          if (ACPI_FAILURE (Status))
>          {
>              goto Cleanup;
> @@ -357,6 +361,7 @@
>      ACPI_OPERAND_OBJECT     **Operand =3D &WalkState->Operands[0];
>      ACPI_OPERAND_OBJECT     *ReturnDesc =3D NULL;
>      UINT64                  Index;
> +    UINT64                  ReturnValue =3D 0;
>      ACPI_STATUS             Status =3D AE_OK;
>      ACPI_SIZE               Length;
>  =

> @@ -400,7 +405,8 @@
>          Status =3D AcpiUtDivide (Operand[0]->Integer.Value,
>                                 Operand[1]->Integer.Value,
>                                 NULL,
> -                               &ReturnDesc->Integer.Value);
> +                               &ReturnValue);
> +        ReturnDesc->Integer.Value =3D ReturnValue;
>          break;

Ditto.


--===============4287077310159432662==--

