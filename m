Content-Type: multipart/mixed; boundary="===============6693786904481322743=="
MIME-Version: 1.0
From: Sami Mujawar <sami.mujawar at arm.com>
Subject: [Devel] [PATCH v3] Add support for hex AML C header file generation
Date: Wed, 14 Mar 2018 09:28:20 +0000
Message-ID: <20180314092820.44048-1-sami.mujawar@arm.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============6693786904481322743==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The iAsl compiler provides a list of options to support
'Firmware Support - C Text Output'.

One of the options, '-tc' supports generation of AML hex
tables in C. This command generates a character array that
represents the AML hex table data.
        e.g. unsigned char AmlCode[] =3D {
               // HEX AML data
               ...
               };

However, there is no option to change the name of the
generated character array (AmlCode) in the output hex file.
This limits the ability to reference more than one table from
the firmware code.

Also, the generated output does not have header file include
guards. This is ideally desired if the hex file is to be
included from a C source file.

A solution to this is to modify the Hex C output such that
the name of the array is derived from the input file name,
and to add header file include guards.

To address the above, without breaking existing implementations,
a new option '-th' is introduced in the list of supported
'Firmware Support - C Text Output' commands. This option
generates an AML hex table output in a C header file suitable
for including from a C source file.

The '-th' option:
1. Uses the input file name as a prefix for the generated
   C array name.
   e.g. 'unsigned char DadtAmlCode[]'

2. Adds a header file include guard.
   e.g.
        #ifndef DSDT_HEX_
        #define DSDT_HEX_
        ...

        unsigned char DadtAmlCode[] =3D {
                // HEX AML data
                ...
        };

        #endif // DSDT_HEX_

  Where Dadt.aml is the input file name.

  Note: The header file include guard uses '<InputFileName>_HEX_'
        format instead of '<InputFileName>_H_' to avoid possible
        collision with an existing header guard.

Signed-off-by: Sami Mujawar <sami.mujawar(a)arm.com>
Signed-off-by: Evan Lloyd <evan.lloyd(a)arm.com>
---

Notes:
    v3:
     - Please change the style for if statements so that braces
       are on separate lines.                                     [ERIK]
    - Resubmitting patch after fixing the issue.                  [SAMI]
    =

    v2:
    - The line below causes a segmentation fault for file
      paths without '/'. A command like "iasl -th hpet.dsl"
      should compile without segfaults.                           [ERIK]
    - Resubmitting patch after fixing the issue.                  [SAMI]

 source/compiler/aslcompile.c |  15 +-
 source/compiler/aslglobal.h  |   1 +
 source/compiler/aslhelp.c    |   1 +
 source/compiler/aslhex.c     | 167 ++++++++++++++++++++
 source/compiler/asloptions.c |   5 +
 source/include/acapps.h      |   6 +
 6 files changed, 192 insertions(+), 3 deletions(-)

diff --git a/source/compiler/aslcompile.c b/source/compiler/aslcompile.c
index b0a06e6beb73e05a10a4d85c1cfda4e0668bbcbb..ffe5afdfebfd6729f14f4b9e2cb=
ab626d64bbdd0 100644
--- a/source/compiler/aslcompile.c
+++ b/source/compiler/aslcompile.c
@@ -544,7 +544,8 @@ AslCompilerSignon (
             Prefix =3D "; ";
         }
         else if ((Gbl_HexOutputFlag =3D=3D HEX_OUTPUT_C) ||
-                 (Gbl_HexOutputFlag =3D=3D HEX_OUTPUT_ASL))
+                 (Gbl_HexOutputFlag =3D=3D HEX_OUTPUT_ASL) ||
+                 (Gbl_HexOutputFlag =3D=3D HEX_OUTPUT_H))
         {
             FlPrintFile (ASL_FILE_HEX_OUTPUT, "/*\n");
             Prefix =3D " * ";
@@ -579,7 +580,14 @@ AslCompilerSignon (
     /* Compiler signon with copyright */
 =

     FlPrintFile (FileId, "%s\n", Prefix);
-    FlPrintFile (FileId, ACPI_COMMON_HEADER (UtilityName, Prefix));
+    if (Gbl_HexOutputFlag =3D=3D HEX_OUTPUT_H)
+    {
+        FlPrintFile (FileId, ACPI_COMMON_HEADER_NO_COPYRIGHT (UtilityName,=
 Prefix));
+    }
+    else
+    {
+        FlPrintFile (FileId, ACPI_COMMON_HEADER (UtilityName, Prefix));
+    }
 }
 =

 =

@@ -621,7 +629,8 @@ AslCompilerFileHeader (
             Prefix =3D "; ";
         }
         else if ((Gbl_HexOutputFlag =3D=3D HEX_OUTPUT_C) ||
-                 (Gbl_HexOutputFlag =3D=3D HEX_OUTPUT_ASL))
+                 (Gbl_HexOutputFlag =3D=3D HEX_OUTPUT_ASL) ||
+                 (Gbl_HexOutputFlag =3D=3D HEX_OUTPUT_H))
         {
             Prefix =3D " * ";
         }
diff --git a/source/compiler/aslglobal.h b/source/compiler/aslglobal.h
index af65a45388127abf84006dafb7ce1431f0027cf6..904cc01e3cd6c5b18ef7d047c7a=
85d8615a23db9 100644
--- a/source/compiler/aslglobal.h
+++ b/source/compiler/aslglobal.h
@@ -328,6 +328,7 @@ ASL_EXTERN BOOLEAN                  ASL_INIT_GLOBAL (Gb=
l_OptimizeTrivialParseNod
 #define HEX_OUTPUT_C                1
 #define HEX_OUTPUT_ASM              2
 #define HEX_OUTPUT_ASL              3
+#define HEX_OUTPUT_H                4
 =

 ASL_EXTERN BOOLEAN                  ASL_INIT_GLOBAL (Gbl_HexOutputFlag, HE=
X_OUTPUT_NONE);
 =

diff --git a/source/compiler/aslhelp.c b/source/compiler/aslhelp.c
index 608f18532b54ba59c17057a4d5c08bef38d7b14c..e29d8fc85f0da30fde17334d4d2=
fc9653e852436 100644
--- a/source/compiler/aslhelp.c
+++ b/source/compiler/aslhelp.c
@@ -229,6 +229,7 @@ Usage (
 =

     printf ("\nFirmware Support - C Text Output:\n");
     ACPI_OPTION ("-tc",             "Create hex AML table in C (*.hex)");
+    ACPI_OPTION ("-th",             "Create hex AML table in C header (*.h=
ex)");
     ACPI_OPTION ("-sc",             "Create named hex AML arrays in C (*.c=
)");
     ACPI_OPTION ("-ic",             "Create include file in C for -sc symb=
ols (*.h)");
     ACPI_OPTION ("-so",             "Create namespace AML offset table in =
C (*.offset.h)");
diff --git a/source/compiler/aslhex.c b/source/compiler/aslhex.c
index fe2d58ada468643d54b565a108764ad4262f782b..cffb494457b74dc204eeb4ec484=
27260bc29efaf 100644
--- a/source/compiler/aslhex.c
+++ b/source/compiler/aslhex.c
@@ -154,6 +154,10 @@
 #define _COMPONENT          ACPI_COMPILER
         ACPI_MODULE_NAME    ("ashex")
 =

+#ifndef PATH_MAX
+#define PATH_MAX 256
+#endif
+
 /*
  * This module emits ASCII hex output files in either C, ASM, or ASL format
  */
@@ -172,6 +176,10 @@ static void
 HxDoHexOutputAsm (
     void);
 =

+static void
+HxDoHexOutputH (
+    void);
+
 static UINT32
 HxReadAmlOutputFile (
     UINT8                   *Buffer);
@@ -212,6 +220,11 @@ HxDoHexOutput (
         HxDoHexOutputAsl ();
         break;
 =

+    case HEX_OUTPUT_H:
+
+        HxDoHexOutputH ();
+        break;
+
     default:
 =

         /* No other output types supported */
@@ -342,6 +355,160 @@ HxDoHexOutputC (
 =

 =

 /*************************************************************************=
******
+*
+* FUNCTION:    HxDoHexOutputH
+*
+* PARAMETERS:  None
+*
+* RETURN:      None
+*
+* DESCRIPTION: Create the hex output file. This is the same data as the AML
+*              output file, but formatted into hex/ASCII bytes suitable for
+*              inclusion into a C source file.
+*
+**************************************************************************=
****/
+
+static void
+HxDoHexOutputH (
+    void)
+{
+    UINT8                   FileData[HEX_TABLE_LINE_SIZE];
+    UINT32                  LineLength;
+    UINT32                  Offset =3D 0;
+    UINT32                  AmlFileSize;
+    UINT32                  i;
+    UINT32                  FileNamePrefixLength;
+    char                    *DotPosition;
+    char                    *InputFileName;
+    char                    *NamePosition;
+    char                    *FileNameEndPosition;
+    char                    FileNamePrefix[PATH_MAX];
+    char                    FileGuard[PATH_MAX];
+
+    /* Get AML size, seek back to start */
+
+    AmlFileSize =3D FlGetFileSize (ASL_FILE_AML_OUTPUT);
+    FlSeekFile (ASL_FILE_AML_OUTPUT, 0);
+
+    /*
+     * Find the filename and use it as a prefix for
+     * the AML code array and the header file guard
+     */
+    InputFileName =3D Gbl_Files[ASL_FILE_INPUT].Filename;
+    FileNameEndPosition =3D InputFileName + strlen (InputFileName);
+
+    NamePosition =3D strrchr (InputFileName, '/');
+    if (NamePosition =3D=3D NULL)
+    {
+        /* '/' not found. This means the input file name
+         * does not contain the path and is in the current
+         * directory.
+         */
+        NamePosition =3D InputFileName;
+    }
+    else
+    {
+        /* '/' was found. So move to the next character
+         * which is the name of the input file.
+         */
+        NamePosition++;
+    }
+
+    /* Get the file name without the extension to use
+     * as a prefix.
+     */
+    DotPosition =3D strrchr (NamePosition, '.');
+    if (DotPosition)
+    {
+        /* No dot or suffix */
+        FileNameEndPosition =3D DotPosition;
+    }
+
+    FileNamePrefixLength =3D FileNameEndPosition - NamePosition;
+    if (FileNamePrefixLength > (PATH_MAX - 1))
+    {
+        AslError (ASL_ERROR, ASL_MSG_STRING_LENGTH, NULL, ": Input file na=
me too long.");
+        return;
+    }
+
+    strncpy (FileNamePrefix, NamePosition, FileNamePrefixLength);
+    /* NULL terminate the string */
+    FileNamePrefix[FileNamePrefixLength] =3D '\0';
+
+    if (strrchr (FileNamePrefix, ' '))
+    {
+        AslError (ASL_ERROR, ASL_MSG_SYNTAX, NULL, "Input file name has sp=
ace.");
+        return;
+    }
+
+    strcpy (FileGuard, FileNamePrefix);
+    AcpiUtStrupr (FileGuard);
+
+    /* Generate the hex output. */
+    FlPrintFile (ASL_FILE_HEX_OUTPUT, " * C header code output\n");
+    FlPrintFile (ASL_FILE_HEX_OUTPUT, " * AML code block contains 0x%X byt=
es\n *\n */\n",
+        AmlFileSize);
+    FlPrintFile (ASL_FILE_HEX_OUTPUT, "\n");
+    FlPrintFile (ASL_FILE_HEX_OUTPUT, "#ifndef %s_HEX_\n", FileGuard);
+    FlPrintFile (ASL_FILE_HEX_OUTPUT, "#define %s_HEX_\n", FileGuard);
+    FlPrintFile (ASL_FILE_HEX_OUTPUT, "\n");
+    FlPrintFile (ASL_FILE_HEX_OUTPUT, "unsigned char %sAmlCode[] =3D\n{\n"=
, FileNamePrefix);
+
+    while (Offset < AmlFileSize)
+    {
+        /* Read enough bytes needed for one output line */
+
+        LineLength =3D HxReadAmlOutputFile (FileData);
+        if (!LineLength)
+        {
+            break;
+        }
+
+        FlPrintFile (ASL_FILE_HEX_OUTPUT, "    ");
+
+        for (i =3D 0; i < LineLength; i++)
+        {
+            /*
+            * Print each hex byte.
+            * Add a comma until the very last byte of the AML file
+            * (Some C compilers complain about a trailing comma)
+            */
+            FlPrintFile (ASL_FILE_HEX_OUTPUT, "0x%2.2X", FileData[i]);
+            if ((Offset + i + 1) < AmlFileSize)
+            {
+                FlPrintFile (ASL_FILE_HEX_OUTPUT, ",");
+            }
+            else
+            {
+                FlPrintFile (ASL_FILE_HEX_OUTPUT, " ");
+            }
+        }
+
+        /* Add fill spaces if needed for last line */
+
+        if (LineLength < HEX_TABLE_LINE_SIZE)
+        {
+            FlPrintFile (ASL_FILE_HEX_OUTPUT, "%*s",
+                5 * (HEX_TABLE_LINE_SIZE - LineLength), " ");
+        }
+
+        /* Emit the offset and ASCII dump for the entire line */
+
+        FlPrintFile (ASL_FILE_HEX_OUTPUT, "  /* %8.8X", Offset);
+        LsDumpAsciiInComment (ASL_FILE_HEX_OUTPUT, LineLength, FileData);
+
+        FlPrintFile (ASL_FILE_HEX_OUTPUT, "%*s*/\n",
+            HEX_TABLE_LINE_SIZE - LineLength + 1, " ");
+
+        Offset +=3D LineLength;
+    }
+
+    FlPrintFile (ASL_FILE_HEX_OUTPUT, "};\n");
+    FlPrintFile (ASL_FILE_HEX_OUTPUT, "\n#endif // %s_HEX_\n", FileGuard);
+}
+
+
+/*************************************************************************=
******
  *
  * FUNCTION:    HxDoHexOutputAsl
  *
diff --git a/source/compiler/asloptions.c b/source/compiler/asloptions.c
index 2b1e6027fdb81e70900148cfd39ce6c453df57d1..a1aa56723349c0c8d91cff276d8=
7217149a18634 100644
--- a/source/compiler/asloptions.c
+++ b/source/compiler/asloptions.c
@@ -842,6 +842,11 @@ AslDoOptions (
             Gbl_HexOutputFlag =3D HEX_OUTPUT_ASL;
             break;
 =

+        case 'h':
+
+            Gbl_HexOutputFlag =3D HEX_OUTPUT_H;
+            break;
+
         default:
 =

             printf ("Unknown option: -t%s\n", AcpiGbl_Optarg);
diff --git a/source/include/acapps.h b/source/include/acapps.h
index 94a40187cb221cd8c369b4a3b0aa3df83ba6b039..c6063257be92fb80d186a24db97=
13ec6f45621b4 100644
--- a/source/include/acapps.h
+++ b/source/include/acapps.h
@@ -188,6 +188,12 @@
     Prefix, ACPICA_COPYRIGHT, \
     Prefix
 =

+#define ACPI_COMMON_HEADER_NO_COPYRIGHT(UtilityName, Prefix) \
+    "%s%s\n%s%s version %8.8X%s\n%s\n", \
+    Prefix, ACPICA_NAME, \
+    Prefix, UtilityName, ((UINT32) ACPI_CA_VERSION), ACPI_WIDTH, \
+    Prefix
+
 #define ACPI_COMMON_BUILD_TIME \
     "Build date/time: %s %s\n", __DATE__, __TIME__
 =

-- =

'Guid(CE165669-3EF3-493F-B85D-6190EE5B9759)'



--===============6693786904481322743==--

