Content-Type: multipart/mixed; boundary="===============2555756195112265331=="
MIME-Version: 1.0
From: Colin Ian King <colin.king at canonical.com>
Subject: Re: [Devel] [PATCH][V2] Remove redundant assignment to ObjectType
Date: Wed, 03 May 2017 14:55:56 +0100
Message-ID: <4c536146-ff8b-8f3f-af65-34e35a20bd8d@canonical.com>
In-Reply-To: 20170418213020.17977-1-colin.king@canonical.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============2555756195112265331==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 18/04/17 22:30, Colin King wrote:
> From: Colin Ian King <colin.king(a)canonical.com>
> =

> There are several occurrances of ObjectType being assigned
> twice successively and the first assignment is clearly
> unncessary and can hence be removed.  Remove the redundant
> assignments and also a no longer needed OpInfo.
> =

> Signed-off-by: Colin Ian King <colin.king(a)canonical.com>
> ---
>  source/common/adwalk.c | 5 -----
>  1 file changed, 5 deletions(-)
> =

> diff --git a/source/common/adwalk.c b/source/common/adwalk.c
> index 22fbfe416..73533027e 100644
> --- a/source/common/adwalk.c
> +++ b/source/common/adwalk.c
> @@ -747,7 +747,6 @@ AcpiDmLoadDescendingOp (
>  =

>      WalkState =3D Info->WalkState;
>      OpInfo =3D AcpiPsGetOpcodeInfo (Op->Common.AmlOpcode);
> -    ObjectType =3D OpInfo->ObjectType;
>      ObjectType =3D AslMapNamedOpcodeToDataType (Op->Asl.AmlOpcode);
>  =

>      /* Only interested in operators that create new names */
> @@ -885,7 +884,6 @@ AcpiDmXrefDescendingOp (
>  =

>      WalkState =3D Info->WalkState;
>      OpInfo =3D AcpiPsGetOpcodeInfo (Op->Common.AmlOpcode);
> -    ObjectType =3D OpInfo->ObjectType;
>      ObjectType =3D AslMapNamedOpcodeToDataType (Op->Asl.AmlOpcode);
>  =

>      if ((!(OpInfo->Flags & AML_NAMED)) &&
> @@ -1182,14 +1180,11 @@ AcpiDmCommonAscendingOp (
>      void                    *Context)
>  {
>      ACPI_OP_WALK_INFO       *Info =3D Context;
> -    const ACPI_OPCODE_INFO  *OpInfo;
>      ACPI_OBJECT_TYPE        ObjectType;
>  =

>  =

>      /* Close scope if necessary */
>  =

> -    OpInfo =3D AcpiPsGetOpcodeInfo (Op->Common.AmlOpcode);
> -    ObjectType =3D OpInfo->ObjectType;
>      ObjectType =3D AslMapNamedOpcodeToDataType (Op->Asl.AmlOpcode);
>  =

>      if (AcpiNsOpensScope (ObjectType))
> =


Any chance this will be reviewed?

--===============2555756195112265331==--

