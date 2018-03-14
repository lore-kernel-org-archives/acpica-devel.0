Content-Type: multipart/mixed; boundary="===============4047949441639168931=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: Re: [Devel] [PATCH v3] Add support for hex AML C header file
 generation
Date: Wed, 14 Mar 2018 19:50:58 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E3B7575C84@ORSMSX110.amr.corp.intel.com>
In-Reply-To: 20180314092820.44048-1-sami.mujawar@arm.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============4047949441639168931==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


We agree that this is a useful change to the iASL compiler. However, we don=
't necessarily see a need to create a new option, and we would like to impl=
ement this in a manner similar to below:


#ifndef __dsdt_hex__
#define __dsdt_hex__

unsigned char dsdt_AmlCode[] =3D
{
    0x44,0x53,0x44,0x54,0x2B,0x00,0x00,0x00,  /* 00000000    "DSDT+..." */
    0x02,0xC2,0x49,0x6E,0x74,0x65,0x6C,0x00,  /* 00000008    "..Intel." */
    0x5F,0x44,0x53,0x44,0x54,0x5F,0x30,0x31,  /* 00000010    "_DSDT_01" */
    0x01,0x00,0x00,0x00,0x49,0x4E,0x54,0x4C,  /* 00000018    "....INTL" */
    0x13,0x03,0x18,0x20,0x14,0x06,0x44,0x53,  /* 00000020    "... ..DS" */
    0x30,0x31,0x00                            /* 00000028    "01."      */
};

#endif




diff --git a/source/compiler/aslhex.c b/source/compiler/aslhex.c
index fe2d58ada..c42087dbb 100644
--- a/source/compiler/aslhex.c
+++ b/source/compiler/aslhex.c
@@ -150,6 +150,7 @@
  *************************************************************************=
****/
 =

 #include "aslcompiler.h"
+#include "acapps.h"
 =

 #define _COMPONENT          ACPI_COMPILER
         ACPI_MODULE_NAME    ("ashex")
@@ -276,8 +277,13 @@ HxDoHexOutputC (
     UINT32                  Offset =3D 0;
     UINT32                  AmlFileSize;
     UINT32                  i;
+    char                    *FilenamePrefix;
 =

 =

+    FilenamePrefix =3D FlGenerateFilename (Gbl_Files [ASL_FILE_HEX_OUTPUT]=
.Filename, "");
+    FilenamePrefix[strlen (FilenamePrefix) - 1] =3D 0;
+    AcpiUtStrlwr (FilenamePrefix);
+
     /* Get AML size, seek back to start */
 =

     AmlFileSize =3D FlGetFileSize (ASL_FILE_AML_OUTPUT);
@@ -286,7 +292,9 @@ HxDoHexOutputC (
     FlPrintFile (ASL_FILE_HEX_OUTPUT, " * C source code output\n");
     FlPrintFile (ASL_FILE_HEX_OUTPUT, " * AML code block contains 0x%X byt=
es\n *\n */\n",
         AmlFileSize);
-    FlPrintFile (ASL_FILE_HEX_OUTPUT, "unsigned char AmlCode[] =3D\n{\n");
+    FlPrintFile (ASL_FILE_HEX_OUTPUT, "#ifndef __%s_hex__\n", FilenamePref=
ix);
+    FlPrintFile (ASL_FILE_HEX_OUTPUT, "#define __%s_hex__\n\n", FilenamePr=
efix);
+    FlPrintFile (ASL_FILE_HEX_OUTPUT, "unsigned char %s_AmlCode[] =3D\n{\n=
", FilenamePrefix);
 =

     while (Offset < AmlFileSize)
     {
@@ -337,7 +345,8 @@ HxDoHexOutputC (
         Offset +=3D LineLength;
     }
 =

-    FlPrintFile (ASL_FILE_HEX_OUTPUT, "};\n");
+    FlPrintFile (ASL_FILE_HEX_OUTPUT, "};\n\n");
+    FlPrintFile (ASL_FILE_HEX_OUTPUT, "#endif\n");
 }



--===============4047949441639168931==--

