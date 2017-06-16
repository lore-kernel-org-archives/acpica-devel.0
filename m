Content-Type: multipart/mixed; boundary="===============7810533708395198721=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: Re: [Devel] [PATCH] iASL: Add support for the SDEI table
Date: Fri, 16 Jun 2017 21:19:56 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37E5C1120@ORSMSX110.amr.corp.intel.com>
In-Reply-To: 20170616104726.15065-1-james.morse@arm.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============7810533708395198721==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



> -----Original Message-----
> From: Devel [mailto:devel-bounces(a)acpica.org] On Behalf Of James Morse
> Sent: Friday, June 16, 2017 3:47 AM
> To: devel(a)acpica.org
> Subject: [Devel] [PATCH] iASL: Add support for the SDEI table
> =

> ACPI 6.2 adds support for the Software Delegated Exception Interface,
[Moore, Robert] =


This looks good, could you add a pull request up on github?

https://github.com/acpica/acpica/pulls


> which is described by "Software Delegated Exception Interface (SDEI)"
> ARM DEN0054A.
> =

> Add the necessary types in the ACPICA header files and support for
> compiling/decompiling the table.
> =

> Signed-off-by: James Morse <james.morse(a)arm.com>
> ---
>  source/common/dmtable.c      |  1 +
>  source/common/dmtbdump.c     | 20 ++++++++++++++++++++
>  source/common/dmtbinfo.c     | 11 +++++++++++
>  source/compiler/dtcompiler.h |  5 +++++
>  source/compiler/dttable2.c   | 18 ++++++++++++++++++
>  source/compiler/dttemplate.h |  9 +++++++++
>  source/include/acdisasm.h    |  6 ++++++
>  source/include/actbl2.h      | 16 ++++++++++++++++
>  8 files changed, 86 insertions(+)
> =

> diff --git a/source/common/dmtable.c b/source/common/dmtable.c index
> b85bb0c3a..b7e03568b 100644
> --- a/source/common/dmtable.c
> +++ b/source/common/dmtable.c
> @@ -493,6 +493,7 @@ const ACPI_DMTABLE_DATA     AcpiDmTableData[] =3D
>      {ACPI_SIG_RSDT, NULL,                   AcpiDmDumpRsdt,
> DtCompileRsdt,  TemplateRsdt},
>      {ACPI_SIG_S3PT, NULL,                   NULL,           NULL,
> TemplateS3pt},
>      {ACPI_SIG_SBST, AcpiDmTableInfoSbst,    NULL,           NULL,
> TemplateSbst},
> +    {ACPI_SIG_SDEI, NULL,                   AcpiDmDumpSDEI,
> DtCompileSDEI,  TemplateSDEI},
>      {ACPI_SIG_SLIC, NULL,                   AcpiDmDumpSlic,
> DtCompileSlic,  TemplateSlic},
>      {ACPI_SIG_SLIT, NULL,                   AcpiDmDumpSlit,
> DtCompileSlit,  TemplateSlit},
>      {ACPI_SIG_SPCR, AcpiDmTableInfoSpcr,    NULL,           NULL,
> TemplateSpcr},
> diff --git a/source/common/dmtbdump.c b/source/common/dmtbdump.c index
> 9441ca494..025653ee6 100644
> --- a/source/common/dmtbdump.c
> +++ b/source/common/dmtbdump.c
> @@ -3677,6 +3677,26 @@ NextSubTable:
> =

> =

> /***********************************************************************
> ********
>   *
> + * FUNCTION:    AcpiDmDumpSDEI
> + *
> + * PARAMETERS:  Table               - A SDEI table
> + *
> + * RETURN:      None
> + *
> + * DESCRIPTION: Format the contents of a SDEI Descriptor Table
> + *
> + **********************************************************************
> + ********/
> +
> +void
> +AcpiDmDumpSDEI (
> +    ACPI_TABLE_HEADER       *Table)
> +{
> +    AcpiDmDumpTable (Table->Length, 0, Table, 0, AcpiDmTableInfoSDEI);
> +}
> +
> +
> +/**********************************************************************
> +*********
> + *
>   * FUNCTION:    AcpiDmDumpSlic
>   *
>   * PARAMETERS:  Table               - A SLIC table
> diff --git a/source/common/dmtbinfo.c b/source/common/dmtbinfo.c index
> 692763fd4..e175f620c 100644
> --- a/source/common/dmtbinfo.c
> +++ b/source/common/dmtbinfo.c
> @@ -218,6 +218,7 @@
>  #define ACPI_RASF_OFFSET(f)             (UINT16) ACPI_OFFSET
> (ACPI_TABLE_RASF,f)
>  #define ACPI_S3PT_OFFSET(f)             (UINT16) ACPI_OFFSET
> (ACPI_TABLE_S3PT,f)
>  #define ACPI_SBST_OFFSET(f)             (UINT16) ACPI_OFFSET
> (ACPI_TABLE_SBST,f)
> +#define ACPI_SDEI_OFFSET(f)             (UINT16) ACPI_OFFSET
> (ACPI_TABLE_SDEI,f)
>  #define ACPI_SLIT_OFFSET(f)             (UINT16) ACPI_OFFSET
> (ACPI_TABLE_SLIT,f)
>  #define ACPI_SPCR_OFFSET(f)             (UINT16) ACPI_OFFSET
> (ACPI_TABLE_SPCR,f)
>  #define ACPI_SPMI_OFFSET(f)             (UINT16) ACPI_OFFSET
> (ACPI_TABLE_SPMI,f)
> @@ -2763,6 +2764,16 @@ ACPI_DMTABLE_INFO
> AcpiDmTableInfoPmtt2[] =3D
>      ACPI_DMT_TERMINATOR
>  };
> =

> +/**********************************************************************
> +*********
> + *
> + * SDEI - Software Delegated Execption Interface Descriptor Table
> + *
> +
> +***********************************************************************
> +*******/
> +
> +ACPI_DMTABLE_INFO           AcpiDmTableInfoSDEI[] =3D
> +{
> +    ACPI_DMT_TERMINATOR
> +};
> =

> =

> /***********************************************************************
> ********
>   *
> diff --git a/source/compiler/dtcompiler.h b/source/compiler/dtcompiler.h
> index 61b40b4a9..5cdb2a678 100644
> --- a/source/compiler/dtcompiler.h
> +++ b/source/compiler/dtcompiler.h
> @@ -638,6 +638,10 @@ DtCompileS3pt (
>      DT_FIELD                **PFieldList);
> =

>  ACPI_STATUS
> +DtCompileSDEI (
> +    void                    **PFieldList);
> +
> +ACPI_STATUS
>  DtCompileSlic (
>      void                    **PFieldList);
> =

> @@ -726,6 +730,7 @@ extern const unsigned char  TemplateRasf[];  extern
> const unsigned char  TemplateRsdt[];  extern const unsigned char
> TemplateS3pt[];  extern const unsigned char  TemplateSbst[];
> +extern const unsigned char  TemplateSDEI[];
>  extern const unsigned char  TemplateSlic[];  extern const unsigned char
> TemplateSlit[];  extern const unsigned char  TemplateSpcr[]; diff --git
> a/source/compiler/dttable2.c b/source/compiler/dttable2.c index
> 356a7d0d1..e5106d1c8 100644
> --- a/source/compiler/dttable2.c
> +++ b/source/compiler/dttable2.c
> @@ -1282,6 +1282,24 @@ DtCompileS3pt (
>      return (AE_OK);
>  }
> =

> +/**********************************************************************
> +********
> + *
> + * FUNCTION:    DtCompileSDEI
> + *
> + * PARAMETERS:  List                - Current field list pointer
> + *
> + * RETURN:      Status
> + *
> + * DESCRIPTION: Compile SDEI.
> + *
> +
> +***********************************************************************
> +******/
> +
> +ACPI_STATUS
> +DtCompileSDEI (
> +    void                    **List)
> +{
> +    return (AE_OK);
> +}
> =

> =

> /***********************************************************************
> *******
>   *
> diff --git a/source/compiler/dttemplate.h b/source/compiler/dttemplate.h
> index bb4dded4e..281e45e38 100644
> --- a/source/compiler/dttemplate.h
> +++ b/source/compiler/dttemplate.h
> @@ -1178,6 +1178,15 @@ const unsigned char TemplateSbst[] =3D
>      0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00   /* 00000028    "........"
> */
>  };
> =

> +const unsigned char TemplateSDEI[] =3D
> +{
> +    0x53,0x44,0x45,0x49,0x3e,0x00,0x00,0x00,  /* 00000000    "SDEI>..."
> */
> +    0x01,0x59,0x41,0x52,0x4d,0x20,0x20,0x20,  /* 00000008    ".mARM  "
> */
> +    0x54,0x45,0x4D,0x50,0x4C,0x41,0x54,0x45,  /* 00000010    "TEMPLATE"
> */
> +    0x01,0x00,0x00,0x00,0x49,0x4E,0x54,0x4C,  /* 00000018    "....INTL"
> */
> +    0x30,0x09,0x16,0x20                       /* 00000028    "0.. " */
> +};
> +
>  const unsigned char TemplateSlic[] =3D
>  {
>      0x53,0x4C,0x49,0x43,0x76,0x01,0x00,0x00,  /* 00000000    "SLICv..."
> */
> diff --git a/source/include/acdisasm.h b/source/include/acdisasm.h index
> 5beec2d4f..301695eb4 100644
> --- a/source/include/acdisasm.h
> +++ b/source/include/acdisasm.h
> @@ -271,6 +271,7 @@ typedef enum
>      ACPI_DMT_PCCT,
>      ACPI_DMT_PMTT,
>      ACPI_DMT_PPTT,
> +    ACPI_DMT_SDEI,
>      ACPI_DMT_SLIC,
>      ACPI_DMT_SRAT,
> =

> @@ -527,6 +528,7 @@ extern ACPI_DMTABLE_INFO
> AcpiDmTableInfoS3ptHdr[];
>  extern ACPI_DMTABLE_INFO        AcpiDmTableInfoS3pt0[];
>  extern ACPI_DMTABLE_INFO        AcpiDmTableInfoS3pt1[];
>  extern ACPI_DMTABLE_INFO        AcpiDmTableInfoSbst[];
> +extern ACPI_DMTABLE_INFO        AcpiDmTableInfoSDEI[];
>  extern ACPI_DMTABLE_INFO        AcpiDmTableInfoSlic[];
>  extern ACPI_DMTABLE_INFO        AcpiDmTableInfoSlit[];
>  extern ACPI_DMTABLE_INFO        AcpiDmTableInfoSpcr[];
> @@ -731,6 +733,10 @@ AcpiDmDumpS3pt (
>      ACPI_TABLE_HEADER       *Table);
> =

>  void
> +AcpiDmDumpSDEI (
> +    ACPI_TABLE_HEADER       *Table);
> +
> +void
>  AcpiDmDumpSlic (
>      ACPI_TABLE_HEADER       *Table);
> =

> diff --git a/source/include/actbl2.h b/source/include/actbl2.h index
> 80495d8fa..f3264d7c3 100644
> --- a/source/include/actbl2.h
> +++ b/source/include/actbl2.h
> @@ -186,6 +186,7 @@
>  #define ACPI_SIG_MCHI           "MCHI"      /* Management Controller
> Host Interface table */
>  #define ACPI_SIG_MSDM           "MSDM"      /* Microsoft Data
> Management Table */
>  #define ACPI_SIG_MTMR           "MTMR"      /* MID Timer table */
> +#define ACPI_SIG_SDEI           "SDEI"      /* Software Delegated
> Exception Interface Table */
>  #define ACPI_SIG_SLIC           "SLIC"      /* Software Licensing
> Description Table */
>  #define ACPI_SIG_SPCR           "SPCR"      /* Serial Port Console
> Redirection table */
>  #define ACPI_SIG_SPMI           "SPMI"      /* Server Platform
> Management Interface table */
> @@ -1410,6 +1411,21 @@ typedef struct acpi_mtmr_entry
> =

>  } ACPI_MTMR_ENTRY;
> =

> +/**********************************************************************
> +*********
> + *
> + * SDEI - Software Delegated Exception Interface Descriptor Table
> + *
> + * Conforms to "Software Delegated Exception Interface (SDEI)" ARM
> +DEN0054A,
> + * May 8th, 2017. Copyright 2017 ARM Ltd.
> + *
> +
> +***********************************************************************
> +*******/
> +
> +typedef struct acpi_table_sdei
> +{
> +    ACPI_TABLE_HEADER       Header;             /* Common ACPI table
> header */
> +
> +} ACPI_TABLE_SDEI;
> +
> =

> =

> /***********************************************************************
> ********
>   *
> --
> 2.11.0
> =

> _______________________________________________
> Devel mailing list
> Devel(a)acpica.org
> https://lists.acpica.org/mailman/listinfo/devel

--===============7810533708395198721==--

