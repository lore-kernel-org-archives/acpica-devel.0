Content-Type: multipart/mixed; boundary="===============3125288689945263282=="
MIME-Version: 1.0
From: Evan Lloyd <Evan.Lloyd at arm.com>
Subject: Re: [Devel] [PATCH] Add support for hex AML C header file generation
Date: Wed, 20 Dec 2017 11:36:00 +0000
Message-ID: <AM4PR0801MB1444CB0D2EA0F288AA1EF1D98B0C0@AM4PR0801MB1444.eurprd08.prod.outlook.com>
In-Reply-To: 20171219205511.20072-1-evan.lloyd@arm.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============3125288689945263282==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

I have published the code for this at:
https://github.com/EvanLloyd/acpica/tree/aml_hex_include_v1
The differences can be examined at:
https://github.com/EvanLloyd/acpica/compare/aml_hex_include_v1

I am happy to make a pull request if the patch proves acceptable, and that =
is the simplest way to handle it.

Regards,
Evan

> -----Original Message-----
> From: Devel [mailto:devel-bounces(a)acpica.org] On Behalf Of
> evan.lloyd(a)arm.com
> Sent: 19 December 2017 20:55
> To: devel(a)acpica.org
> Cc: "nd(a)arm.com"@arm.com; "Matteo.Carlini(a)arm.com"@arm.com;
> "leif.lindholm(a)arm.com"@arm.com
> Subject: [Devel] [PATCH] Add support for hex AML C header file generation
>
> From: Sami Mujawar <sami.mujawar(a)arm.com>
>
> The iAsl compiler provides a list of options to support 'Firmware Support=
 - C
> Text Output'.
>
> One of the options, '-tc' supports generation of AML hex tables in C. This
> command generates a character array that represents the AML hex table
> data.
>         e.g. unsigned char AmlCode[] =3D {
>                // HEX AML data
>                ...
>                };
>
> However, there is no option to change the name of the generated character
> array (AmlCode) in the output hex file.
> This limits the ability to reference more than one table from the firmware
> code.
>
> Also, the generated output does not have header file include guards. This=
 is
> ideally desired if the hex file is to be included from a C source file.
>
> A solution to this is to modify the Hex C output such that the name of the
> array is derived from the input file name, and to add header file include
> guards.
>
> To address the above, without breaking existing implementations, a new
> option '-th' is introduced in the list of supported 'Firmware Support - C=
 Text
> Output' commands. This option generates an AML hex table output in a C
> header file suitable for including from a C source file.
>
> The '-th' option:
> 1. Uses the input file name as a prefix for the generated
>    C array name.
>    e.g. 'unsigned char DsdtAmlCode[]'
>
> 2. Adds a header file include guard.
>    e.g.
>         #ifndef DSDT_HEX_
>         #define DSDT_HEX_
>         ...
>
>         unsigned char DsdtAmlCode[] =3D {
>                 // HEX AML data
>                 ...
>         };
>
>         #endif // DSDT_HEX_
>
>   Where Dsdt.aml is the input file name.
>
>   Note: The header file include guard uses '<InputFileName>_HEX_'
>         format instead of '<InputFileName>_H_' to avoid possible
>         collision with an existing header guard.
>
> Signed-off-by: Sami Mujawar <sami.mujawar(a)arm.com>
> Signed-off-by: Evan Lloyd <evan.lloyd(a)arm.com>
> ---
>  source/compiler/aslcompile.c |  12 +-
>  source/compiler/aslglobal.h  |   1 +
>  source/compiler/aslhelp.c    |   1 +
>  source/compiler/aslhex.c     | 138 ++++++++++++++++++++
>  source/compiler/asloptions.c |   5 +
>  source/include/acapps.h      |   6 +
>  6 files changed, 160 insertions(+), 3 deletions(-)
>
> diff --git a/source/compiler/aslcompile.c b/source/compiler/aslcompile.c
> index
> ae78cec4da331c5065c19951e0436515642df4ea..6b12c54a93d2c441b66b
> 0a2f311070b37153d4a3 100644
> --- a/source/compiler/aslcompile.c
> +++ b/source/compiler/aslcompile.c
> @@ -544,7 +544,8 @@ AslCompilerSignon (
>              Prefix =3D "; ";
>          }
>          else if ((Gbl_HexOutputFlag =3D=3D HEX_OUTPUT_C) ||
> -                 (Gbl_HexOutputFlag =3D=3D HEX_OUTPUT_ASL))
> +                 (Gbl_HexOutputFlag =3D=3D HEX_OUTPUT_ASL) ||
> +                 (Gbl_HexOutputFlag =3D=3D HEX_OUTPUT_H))
>          {
>              FlPrintFile (ASL_FILE_HEX_OUTPUT, "/*\n");
>              Prefix =3D " * ";
> @@ -579,7 +580,11 @@ AslCompilerSignon (
>      /* Compiler signon with copyright */
>
>      FlPrintFile (FileId, "%s\n", Prefix);
> -    FlPrintFile (FileId, ACPI_COMMON_HEADER (UtilityName, Prefix));
> +    if (Gbl_HexOutputFlag =3D=3D HEX_OUTPUT_H) {
> +        FlPrintFile (FileId, ACPI_COMMON_HEADER_NO_COPYRIGHT
> (UtilityName, Prefix));
> +    } else {
> +        FlPrintFile (FileId, ACPI_COMMON_HEADER (UtilityName, Prefix));
> +    }
>  }
>
>
> @@ -621,7 +626,8 @@ AslCompilerFileHeader (
>              Prefix =3D "; ";
>          }
>          else if ((Gbl_HexOutputFlag =3D=3D HEX_OUTPUT_C) ||
> -                 (Gbl_HexOutputFlag =3D=3D HEX_OUTPUT_ASL))
> +                 (Gbl_HexOutputFlag =3D=3D HEX_OUTPUT_ASL) ||
> +                 (Gbl_HexOutputFlag =3D=3D HEX_OUTPUT_H))
>          {
>              Prefix =3D " * ";
>          }
> diff --git a/source/compiler/aslglobal.h b/source/compiler/aslglobal.h in=
dex
> 169b25e745ec69adc139ccb1e5cb26c710104b7e..ca93792159166861d915
> 2a7fcc4740e5e770efef 100644
> --- a/source/compiler/aslglobal.h
> +++ b/source/compiler/aslglobal.h
> @@ -328,6 +328,7 @@ ASL_EXTERN BOOLEAN                  ASL_INIT_GLOBAL
> (Gbl_OptimizeTrivialParseNod
>  #define HEX_OUTPUT_C                1
>  #define HEX_OUTPUT_ASM              2
>  #define HEX_OUTPUT_ASL              3
> +#define HEX_OUTPUT_H                4
>
>  ASL_EXTERN BOOLEAN                  ASL_INIT_GLOBAL (Gbl_HexOutputFlag,
> HEX_OUTPUT_NONE);
>
> diff --git a/source/compiler/aslhelp.c b/source/compiler/aslhelp.c index
> 2d78aeb23b1211c0fca054eb188598cad7c5be2a..1f149312b7038ee7984c
> 65470d984ab8556b563a 100644
> --- a/source/compiler/aslhelp.c
> +++ b/source/compiler/aslhelp.c
> @@ -229,6 +229,7 @@ Usage (
>
>      printf ("\nFirmware Support - C Text Output:\n");
>      ACPI_OPTION ("-tc",             "Create hex AML table in C (*.hex)");
> +    ACPI_OPTION ("-th",             "Create hex AML table in C header (*=
.hex)");
>      ACPI_OPTION ("-sc",             "Create named hex AML arrays in C (*=
.c)");
>      ACPI_OPTION ("-ic",             "Create include file in C for -sc sy=
mbols (*.h)");
>      ACPI_OPTION ("-so",             "Create namespace AML offset table i=
n C
> (*.offset.h)");
> diff --git a/source/compiler/aslhex.c b/source/compiler/aslhex.c index
> d7577a2cb1a8e19d9a8cfe135d40eb77c32706f5..30a69493c662f9371fe7a
> b4d5ff38278545a4dc8 100644
> --- a/source/compiler/aslhex.c
> +++ b/source/compiler/aslhex.c
> @@ -154,6 +154,10 @@
>  #define _COMPONENT          ACPI_COMPILER
>          ACPI_MODULE_NAME    ("ashex")
>
> +#ifndef PATH_MAX
> +#define PATH_MAX 256
> +#endif
> +
>  /*
>   * This module emits ASCII hex output files in either C, ASM, or ASL for=
mat
>   */
> @@ -172,6 +176,10 @@ static void
>  HxDoHexOutputAsm (
>      void);
>
> +static void
> +HxDoHexOutputH (
> +    void);
> +
>  static UINT32
>  HxReadAmlOutputFile (
>      UINT8                   *Buffer);
> @@ -212,6 +220,11 @@ HxDoHexOutput (
>          HxDoHexOutputAsl ();
>          break;
>
> +    case HEX_OUTPUT_H:
> +
> +        HxDoHexOutputH ();
> +        break;
> +
>      default:
>
>          /* No other output types supported */ @@ -341,6 +354,131 @@
> HxDoHexOutputC (  }
>
>
> +/*********************************************************
> *************
> +*********
> +*
> +* FUNCTION:    HxDoHexOutputH
> +*
> +* PARAMETERS:  None
> +*
> +* RETURN:      None
> +*
> +* DESCRIPTION: Create the hex output file. This is the same data as the
> AML
> +*              output file, but formatted into hex/ASCII bytes suitable =
for
> +*              inclusion into a C source file.
> +*
> +*********************************************************
> **************
> +*******/
> +
> +static void
> +HxDoHexOutputH (
> +    void)
> +{
> +    UINT8                   FileData[HEX_TABLE_LINE_SIZE];
> +    UINT32                  LineLength;
> +    UINT32                  Offset =3D 0;
> +    UINT32                  AmlFileSize;
> +    UINT32                  i;
> +    char                   *DotPosition;
> +    char                   *InputFileName;
> +    char                   *NamePosition;
> +    char                   *FileNameEndPosition;
> +    char                    FileNamePrefix[PATH_MAX];
> +    char                    FileGuard[PATH_MAX];
> +
> +    /* Get AML size, seek back to start */
> +
> +    AmlFileSize =3D FlGetFileSize (ASL_FILE_AML_OUTPUT);
> +    FlSeekFile (ASL_FILE_AML_OUTPUT, 0);
> +
> +    /*
> +     * Find the filename and use it as a prefix for
> +     * the AML code array and the header file guard
> +     */
> +    InputFileName =3D Gbl_Files[ASL_FILE_INPUT].Filename;
> +    FileNameEndPosition =3D InputFileName + strlen (InputFileName);
> +    NamePosition =3D strrchr (InputFileName, '/') + 1;
> +    DotPosition =3D strrchr (NamePosition, '.');
> +
> +    memset (FileNamePrefix, 0, sizeof (FileNamePrefix));
> +
> +    if (DotPosition) {
> +        if ((DotPosition - NamePosition) > (PATH_MAX - 1)) {
> +            AslError (ASL_ERROR, ASL_MSG_STRING_LENGTH, NULL, ": Input
> file name too long.");
> +            return;
> +         }
> +        strncpy (FileNamePrefix, NamePosition, (DotPosition - NamePositi=
on));
> +    } else {
> +        /* No dot or suffix */
> +        if ((FileNameEndPosition - NamePosition) > (PATH_MAX - 1)) {
> +            AslError (ASL_ERROR, ASL_MSG_STRING_LENGTH, NULL, ": Input
> file name too long.");
> +            return;
> +        }
> +        strcpy (FileNamePrefix, NamePosition);
> +    }
> +
> +    if (strrchr (FileNamePrefix, ' ')) {
> +        AslError (ASL_ERROR, ASL_MSG_SYNTAX, NULL, "Input file name has
> space.");
> +        return;
> +    }
> +
> +    strcpy (FileGuard, FileNamePrefix);
> +    AcpiUtStrupr (FileGuard);
> +
> +    FlPrintFile (ASL_FILE_HEX_OUTPUT, " * C header code output\n");
> +    FlPrintFile (ASL_FILE_HEX_OUTPUT, " * AML code block contains 0x%X
> bytes\n *\n */\n",
> +        AmlFileSize);
> +    FlPrintFile (ASL_FILE_HEX_OUTPUT, "\n");
> +    FlPrintFile (ASL_FILE_HEX_OUTPUT, "#ifndef %s_HEX_\n", FileGuard);
> +    FlPrintFile (ASL_FILE_HEX_OUTPUT, "#define %s_HEX_\n", FileGuard);
> +    FlPrintFile (ASL_FILE_HEX_OUTPUT, "\n");
> +    FlPrintFile (ASL_FILE_HEX_OUTPUT, "unsigned char %sAmlCode[]
> + =3D\n{\n", FileNamePrefix);
> +
> +    while (Offset < AmlFileSize) {
> +        /* Read enough bytes needed for one output line */
> +
> +        LineLength =3D HxReadAmlOutputFile (FileData);
> +        if (!LineLength) {
> +            break;
> +        }
> +
> +        FlPrintFile (ASL_FILE_HEX_OUTPUT, "    ");
> +
> +        for (i =3D 0; i < LineLength; i++) {
> +            /*
> +            * Print each hex byte.
> +            * Add a comma until the very last byte of the AML file
> +            * (Some C compilers complain about a trailing comma)
> +            */
> +            FlPrintFile (ASL_FILE_HEX_OUTPUT, "0x%2.2X", FileData[i]);
> +            if ((Offset + i + 1) < AmlFileSize) {
> +                FlPrintFile (ASL_FILE_HEX_OUTPUT, ",");
> +            } else {
> +                FlPrintFile (ASL_FILE_HEX_OUTPUT, " ");
> +            }
> +        }
> +
> +        /* Add fill spaces if needed for last line */
> +
> +        if (LineLength < HEX_TABLE_LINE_SIZE) {
> +            FlPrintFile (ASL_FILE_HEX_OUTPUT, "%*s",
> +                5 * (HEX_TABLE_LINE_SIZE - LineLength), " ");
> +        }
> +
> +        /* Emit the offset and ASCII dump for the entire line */
> +
> +        FlPrintFile (ASL_FILE_HEX_OUTPUT, "  /* %8.8X", Offset);
> +        LsDumpAsciiInComment (ASL_FILE_HEX_OUTPUT, LineLength,
> + FileData);
> +
> +        FlPrintFile (ASL_FILE_HEX_OUTPUT, "%*s*/\n",
> +            HEX_TABLE_LINE_SIZE - LineLength + 1, " ");
> +
> +        Offset +=3D LineLength;
> +    }
> +
> +    FlPrintFile (ASL_FILE_HEX_OUTPUT, "};\n");
> +    FlPrintFile (ASL_FILE_HEX_OUTPUT, "\n#endif // %s_HEX_\n",
> +FileGuard); }
> +
> +
>
> /**********************************************************
> *********************
>   *
>   * FUNCTION:    HxDoHexOutputAsl
> diff --git a/source/compiler/asloptions.c b/source/compiler/asloptions.c
> index
> 29a5c762d60985257f97f80b0bb09c786e06145b..7088b44ce734967ca8d8
> d5071905d2f05ef4c970 100644
> --- a/source/compiler/asloptions.c
> +++ b/source/compiler/asloptions.c
> @@ -842,6 +842,11 @@ AslDoOptions (
>              Gbl_HexOutputFlag =3D HEX_OUTPUT_ASL;
>              break;
>
> +        case 'h':
> +
> +            Gbl_HexOutputFlag =3D HEX_OUTPUT_H;
> +            break;
> +
>          default:
>
>              printf ("Unknown option: -t%s\n", AcpiGbl_Optarg); diff --git
> a/source/include/acapps.h b/source/include/acapps.h index
> faae2fb6917e41c39da62467345a3d1c7d458860..f6befeb98d08b07fd28a7
> d4fbf9bbf35b5483c95 100644
> --- a/source/include/acapps.h
> +++ b/source/include/acapps.h
> @@ -188,6 +188,12 @@
>      Prefix, ACPICA_COPYRIGHT, \
>      Prefix
>
> +#define ACPI_COMMON_HEADER_NO_COPYRIGHT(UtilityName, Prefix) \
> +    "%s%s\n%s%s version %8.8X%s\n%s\n", \
> +    Prefix, ACPICA_NAME, \
> +    Prefix, UtilityName, ((UINT32) ACPI_CA_VERSION), ACPI_WIDTH, \
> +    Prefix
> +
>  #define ACPI_COMMON_BUILD_TIME \
>      "Build date/time: %s %s\n", __DATE__, __TIME__
>
> --
> Guid("CE165669-3EF3-493F-B85D-6190EE5B9759")
>
> _______________________________________________
> Devel mailing list
> Devel(a)acpica.org
> https://lists.acpica.org/mailman/listinfo/devel
IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.

--===============3125288689945263282==--

