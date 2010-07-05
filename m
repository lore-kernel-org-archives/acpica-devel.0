Content-Type: multipart/mixed; boundary="===============8428561925110519125=="
MIME-Version: 1.0
From: malattia at linux.it
Subject: [Devel] [patch 3/5] Support compiling DSDT tables on big endian
 architectures
Date: Mon, 05 Jul 2010 21:03:27 +0900
Message-ID: <20100705120818.022043072@linux.it>
In-Reply-To: 20100705120324.581857151@linux.it
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============8428561925110519125==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

use the ACPI_MOVE_<N>_TO_<M> macros to swap the data written to the AML fil=
e on
big endian architectures (the macros themselves required a few fixes to work
correctly).
In some areas the use of temporary variables was necessary to be able to pe=
rform
sanity checks on the data before actually swapping the bytes.

Signed-off-by: Mattia Dongili <malattia(a)linux.it>
---
 compiler/aslcodegen.c      |  107 +++++++++++++++++++++--------------
 compiler/aslopcodes.c      |    4 +
 compiler/aslrestype1.c     |   68 +++++++++++++++-------
 compiler/aslrestype1i.c    |   29 +++++----
 compiler/aslrestype2.c     |   25 +++++---
 compiler/aslrestype2d.c    |  134 +++++++++++++++++++++++++---------------=
-----
 compiler/aslrestype2e.c    |  117 +++++++++++++++++++++++++++------------
 compiler/aslrestype2q.c    |  117 +++++++++++++++++++++++++--------------
 compiler/aslrestype2w.c    |  127 +++++++++++++++++++++++++---------------=
--
 include/acmacros.h         |   15 +++--
 include/platform/aclinux.h |    7 ++
 11 files changed, 470 insertions(+), 280 deletions(-)

Index: b/include/platform/aclinux.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/include/platform/aclinux.h	2010-07-02 21:42:26.833348957 +0900
+++ b/include/platform/aclinux.h	2010-07-04 11:18:19.486018564 +0900
@@ -156,13 +156,14 @@
 #include <stdlib.h>
 #include <ctype.h>
 #include <unistd.h>
+#include <endian.h>
 =

 /* Host-dependent types and defines for user-space ACPICA */
 =

 #define ACPI_FLUSH_CPU_CACHE()
 #define ACPI_THREAD_ID              pthread_t
 =

-#if defined(__ia64__) || defined(__x86_64__)
+#if defined(__ia64__) || defined(__x86_64__) || defined(__alpha__)
 #define ACPI_MACHINE_WIDTH          64
 #define COMPILER_DEPENDENT_INT64    long
 #define COMPILER_DEPENDENT_UINT64   unsigned long
@@ -173,6 +174,10 @@
 #define ACPI_USE_NATIVE_DIVIDE
 #endif
 =

+#if __BYTE_ORDER =3D=3D __BIG_ENDIAN
+#define ACPI_BIG_ENDIAN
+#endif
+
 #ifndef __cdecl
 #define __cdecl
 #endif
Index: b/compiler/aslcodegen.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/compiler/aslcodegen.c	2010-07-02 21:42:26.601348618 +0900
+++ b/compiler/aslcodegen.c	2010-07-04 11:18:19.490018083 +0900
@@ -311,16 +311,12 @@
     ACPI_PARSE_OBJECT       *Op)
 {
     UINT8                   PkgLenFirstByte;
-    UINT32                  i;
-    union {
-        UINT16                  Opcode;
-        UINT8                   OpcodeBytes[2];
-    } Aml;
-    union {
-        UINT32                  Len;
-        UINT8                   LenBytes[4];
-    } PkgLen;
-
+    UINT8                   Byte;
+    UINT16                  Word;
+    UINT32                  DWord;
+    UINT64                  QWord;
+    UINT16                  AmlOpcode;
+    UINT32                  PkgLen;
 =

     /* We expect some DEFAULT_ARGs, just ignore them */
 =

@@ -343,45 +339,46 @@
 =

         /* Special opcodes for within a field definition */
 =

-        Aml.Opcode =3D 0x00;
+        AmlOpcode =3D 0x00;
         break;
 =

     case AML_INT_ACCESSFIELD_OP:
 =

-        Aml.Opcode =3D 0x01;
+        AmlOpcode =3D 0x01;
         break;
 =

     default:
-        Aml.Opcode =3D Op->Asl.AmlOpcode;
+        AmlOpcode =3D Op->Asl.AmlOpcode;
         break;
     }
 =

 =

-    switch (Aml.Opcode)
+    switch (AmlOpcode)
     {
     case AML_PACKAGE_LENGTH:
 =

         /* Value is the length to be encoded (Used in field definitions) */
 =

-        PkgLen.Len =3D (UINT32) Op->Asl.Value.Integer;
+        PkgLen =3D (UINT32) Op->Asl.Value.Integer;
         break;
 =

     default:
 =

         /* Check for two-byte opcode */
 =

-        if (Aml.Opcode > 0x00FF)
+        if (AmlOpcode > 0x00FF)
         {
             /* Write the high byte first */
-
-            CgLocalWriteAmlData (Op, &Aml.OpcodeBytes[1], 1);
+            Byte =3D ACPI_HIBYTE(AmlOpcode);
+            CgLocalWriteAmlData (Op, &Byte, 1);
         }
 =

-        CgLocalWriteAmlData (Op, &Aml.OpcodeBytes[0], 1);
+        Byte =3D ACPI_LOBYTE(AmlOpcode);
+        CgLocalWriteAmlData (Op, &Byte, 1);
 =

         /* Subtreelength doesn't include length of package length bytes */
 =

-        PkgLen.Len =3D Op->Asl.AmlSubtreeLength + Op->Asl.AmlPkgLenBytes;
+        PkgLen =3D Op->Asl.AmlSubtreeLength + Op->Asl.AmlPkgLenBytes;
         break;
     }
 =

@@ -392,8 +389,8 @@
         if (Op->Asl.AmlPkgLenBytes =3D=3D 1)
         {
             /* Simplest case -- no bytes to follow, just write the count */
-
-            CgLocalWriteAmlData (Op, &PkgLen.LenBytes[0], 1);
+            Byte =3D ACPI_LOBYTE(PkgLen);
+            CgLocalWriteAmlData (Op, &Byte, 1);
         }
         else if (Op->Asl.AmlPkgLenBytes !=3D 0)
         {
@@ -403,7 +400,7 @@
              */
             PkgLenFirstByte =3D (UINT8)
                 (((UINT32) (Op->Asl.AmlPkgLenBytes - 1) << 6) |
-                (PkgLen.LenBytes[0] & 0x0F));
+                (PkgLen & 0x0F));
 =

             CgLocalWriteAmlData (Op, &PkgLenFirstByte, 1);
 =

@@ -411,37 +408,44 @@
              * Shift the length over by the 4 bits we just stuffed
              * in the first byte
              */
-            PkgLen.Len >>=3D 4;
+            PkgLen >>=3D 4;
 =

             /* Now we can write the remaining bytes - either 1, 2, or 3 by=
tes */
-
-            for (i =3D 0; i < (UINT32) (Op->Asl.AmlPkgLenBytes - 1); i++)
+            Byte =3D ACPI_LOBYTE(PkgLen);
+            CgLocalWriteAmlData (Op, &Byte, 1);
+            if (Op->Asl.AmlPkgLenBytes >=3D 3)
+            {
+                Byte =3D ACPI_HIBYTE(PkgLen);
+                CgLocalWriteAmlData (Op, &Byte, 1);
+            }
+            if (Op->Asl.AmlPkgLenBytes >=3D 4)
             {
-                CgLocalWriteAmlData (Op, &PkgLen.LenBytes[i], 1);
+                Byte =3D ACPI_LOBYTE(ACPI_HIWORD(PkgLen));
+                CgLocalWriteAmlData (Op, &Byte, 1);
             }
         }
     }
 =

-    switch (Aml.Opcode)
+    switch (AmlOpcode)
     {
     case AML_BYTE_OP:
-
-        CgLocalWriteAmlData (Op, &Op->Asl.Value.Integer, 1);
+        Byte =3D (UINT8) Op->Asl.Value.Integer;
+        CgLocalWriteAmlData (Op, &Byte, 1);
         break;
 =

     case AML_WORD_OP:
-
-        CgLocalWriteAmlData (Op, &Op->Asl.Value.Integer, 2);
+        ACPI_MOVE_64_TO_16(&Word, &Op->Asl.Value.Integer);
+        CgLocalWriteAmlData (Op, &Word, 2);
        break;
 =

     case AML_DWORD_OP:
-
-        CgLocalWriteAmlData (Op, &Op->Asl.Value.Integer, 4);
+        ACPI_MOVE_64_TO_32(&DWord, &Op->Asl.Value.Integer);
+        CgLocalWriteAmlData (Op, &DWord, 4);
         break;
 =

     case AML_QWORD_OP:
-
-        CgLocalWriteAmlData (Op, &Op->Asl.Value.Integer, 8);
+        ACPI_MOVE_64_TO_64(&QWord, &Op->Asl.Value.Integer);
+        CgLocalWriteAmlData (Op, &QWord, 8);
         break;
 =

     case AML_STRING_OP:
@@ -473,6 +477,7 @@
     ACPI_PARSE_OBJECT       *Op)
 {
     ACPI_PARSE_OBJECT       *Child;
+    UINT32 DWord;
 =

 =

     /* AML filename */
@@ -509,19 +514,19 @@
     /* OEM Revision */
 =

     Child =3D Child->Asl.Next;
-    TableHeader.OemRevision =3D (UINT32) Child->Asl.Value.Integer;
+    ACPI_MOVE_64_TO_32(&TableHeader.OemRevision, &Child->Asl.Value.Integer=
);
 =

     /* Compiler ID */
 =

     strncpy (TableHeader.AslCompilerId, CompilerCreatorId, 4);
 =

     /* Compiler version */
-
-    TableHeader.AslCompilerRevision =3D CompilerCreatorRevision;
+    DWord =3D CompilerCreatorRevision;
+    ACPI_MOVE_32_TO_32(&TableHeader.AslCompilerRevision, &DWord);
 =

     /* Table length. Checksum zero for now, will rewrite later */
 =

-    TableHeader.Length   =3D Gbl_TableLength;
+    ACPI_MOVE_32_TO_32(&TableHeader.Length, &Gbl_TableLength);
     TableHeader.Checksum =3D 0;
 =

     CgLocalWriteAmlData (Op, &TableHeader, sizeof (ACPI_TABLE_HEADER));
@@ -585,7 +590,10 @@
     ACPI_PARSE_OBJECT       *Op)
 {
     ASL_RESOURCE_NODE       *Rnode;
-
+    UINT8                   Byte;
+    UINT16                  Word;
+    UINT32                  DWord;
+    UINT64                  QWord;
 =

     /* Always check for DEFAULT_ARG and other "Noop" nodes */
     /* TBD: this may not be the best place for this check */
@@ -603,13 +611,24 @@
     switch (Op->Asl.AmlOpcode)
     {
     case AML_RAW_DATA_BYTE:
+        Byte =3D (UINT8) Op->Asl.Value.Integer;
+        CgLocalWriteAmlData (Op, &Byte, 1);
+        return;
+
     case AML_RAW_DATA_WORD:
-    case AML_RAW_DATA_DWORD:
-    case AML_RAW_DATA_QWORD:
+        ACPI_MOVE_64_TO_16(&Word, &Op->Asl.Value.Integer);
+        CgLocalWriteAmlData (Op, &Word, 2);
+        return;
 =

-        CgLocalWriteAmlData (Op, &Op->Asl.Value.Integer, Op->Asl.AmlLength=
);
+    case AML_RAW_DATA_DWORD:
+        ACPI_MOVE_64_TO_32(&DWord, &Op->Asl.Value.Integer);
+        CgLocalWriteAmlData (Op, &DWord, 4);
         return;
 =

+    case AML_RAW_DATA_QWORD:
+        ACPI_MOVE_64_TO_64(&QWord, &Op->Asl.Value.Integer);
+        CgLocalWriteAmlData (Op, &QWord, 8);
+        return;
 =

     case AML_RAW_DATA_BUFFER:
 =

Index: b/compiler/aslopcodes.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/compiler/aslopcodes.c	2010-07-02 21:42:26.613360661 +0900
+++ b/compiler/aslopcodes.c	2010-07-04 11:18:19.490018083 +0900
@@ -449,6 +449,7 @@
     UINT32                  i;
     UINT8                   *AsciiString;
     UINT16                  *UnicodeString;
+    UINT16                  UChar;
     ACPI_PARSE_OBJECT       *BufferLengthOp;
 =

 =

@@ -475,7 +476,8 @@
 =

     for (i =3D 0; i < Count; i++)
     {
-        UnicodeString[i] =3D (UINT16) AsciiString[i];
+        UChar =3D (UINT16) AsciiString[i];
+        ACPI_MOVE_16_TO_16(&UnicodeString[i], &UChar);
     }
 =

     /*
Index: b/compiler/aslrestype1.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/compiler/aslrestype1.c	2010-07-02 21:42:26.661349406 +0900
+++ b/compiler/aslrestype1.c	2010-07-04 11:18:19.490018083 +0900
@@ -226,6 +226,11 @@
     ACPI_PARSE_OBJECT       *LengthOp =3D NULL;
     ACPI_PARSE_OBJECT       *AlignOp =3D NULL;
     ASL_RESOURCE_NODE       *Rnode;
+    UINT16                  Minimum =3D 0;
+    UINT16                  Maximum =3D 0;
+    UINT16                  AddressLength =3D 0;
+    UINT16                  Alignment =3D 0;
+    UINT16                  ResourceLength;
     UINT32                  i;
 =

 =

@@ -234,7 +239,8 @@
 =

     Descriptor =3D Rnode->Buffer;
     Descriptor->Memory24.DescriptorType  =3D ACPI_RESOURCE_NAME_MEMORY24;
-    Descriptor->Memory24.ResourceLength =3D 9;
+    ResourceLength =3D 9;
+    ACPI_MOVE_16_TO_16(&Descriptor->Memory24.ResourceLength, &ResourceLeng=
th);
 =

     /* Process all child initialization nodes */
 =

@@ -251,7 +257,7 @@
 =

         case 1: /* Min Address */
 =

-            Descriptor->Memory24.Minimum =3D (UINT16) InitializerOp->Asl.V=
alue.Integer;
+            Minimum =3D InitializerOp->Asl.Value.Integer;
             RsCreateByteField (InitializerOp, ACPI_RESTAG_MINADDR,
                 CurrentByteOffset + ASL_RESDESC_OFFSET (Memory24.Minimum));
             MinOp =3D InitializerOp;
@@ -259,7 +265,7 @@
 =

         case 2: /* Max Address */
 =

-            Descriptor->Memory24.Maximum =3D (UINT16) InitializerOp->Asl.V=
alue.Integer;
+            Maximum =3D InitializerOp->Asl.Value.Integer;
             RsCreateByteField (InitializerOp, ACPI_RESTAG_MAXADDR,
                 CurrentByteOffset + ASL_RESDESC_OFFSET (Memory24.Maximum));
             MaxOp =3D InitializerOp;
@@ -267,7 +273,7 @@
 =

         case 3: /* Alignment */
 =

-            Descriptor->Memory24.Alignment =3D (UINT16) InitializerOp->Asl=
.Value.Integer;
+            Alignment =3D InitializerOp->Asl.Value.Integer;
             RsCreateByteField (InitializerOp, ACPI_RESTAG_ALIGNMENT,
                 CurrentByteOffset + ASL_RESDESC_OFFSET (Memory24.Alignment=
));
             AlignOp =3D InitializerOp;
@@ -275,7 +281,7 @@
 =

         case 4: /* Length */
 =

-            Descriptor->Memory24.AddressLength =3D (UINT16) InitializerOp-=
>Asl.Value.Integer;
+            AddressLength =3D InitializerOp->Asl.Value.Integer;
             RsCreateByteField (InitializerOp, ACPI_RESTAG_LENGTH,
                 CurrentByteOffset + ASL_RESDESC_OFFSET (Memory24.AddressLe=
ngth));
             LengthOp =3D InitializerOp;
@@ -298,12 +304,17 @@
     /* Validate the Min/Max/Len/Align values (Alignment=3D=3D0 means 64K) =
*/
 =

     RsSmallAddressCheck (ACPI_RESOURCE_NAME_MEMORY24,
-        Descriptor->Memory24.Minimum,
-        Descriptor->Memory24.Maximum,
-        Descriptor->Memory24.AddressLength,
-        Descriptor->Memory24.Alignment,
+        Minimum,
+        Maximum,
+        AddressLength,
+        Alignment,
         MinOp, MaxOp, LengthOp, NULL);
 =

+    ACPI_MOVE_16_TO_16(&Descriptor->Memory24.Minimum, &Minimum);
+    ACPI_MOVE_16_TO_16(&Descriptor->Memory24.Maximum, &Maximum);
+    ACPI_MOVE_16_TO_16(&Descriptor->Memory24.AddressLength, &AddressLength=
);
+    ACPI_MOVE_16_TO_16(&Descriptor->Memory24.Alignment, &Alignment);
+
     return (Rnode);
 }
 =

@@ -334,6 +345,11 @@
     ACPI_PARSE_OBJECT       *LengthOp =3D NULL;
     ACPI_PARSE_OBJECT       *AlignOp =3D NULL;
     ASL_RESOURCE_NODE       *Rnode;
+    UINT32                  Minimum =3D 0;
+    UINT32                  Maximum =3D 0;
+    UINT32                  AddressLength =3D 0;
+    UINT32                  Alignment =3D 0;
+    UINT16                  ResourceLength;
     UINT32                  i;
 =

 =

@@ -342,7 +358,8 @@
 =

     Descriptor =3D Rnode->Buffer;
     Descriptor->Memory32.DescriptorType  =3D ACPI_RESOURCE_NAME_MEMORY32;
-    Descriptor->Memory32.ResourceLength =3D 17;
+    ResourceLength =3D 17;
+    ACPI_MOVE_16_TO_16(&Descriptor->Memory32.ResourceLength, &ResourceLeng=
th);
 =

     /* Process all child initialization nodes */
 =

@@ -359,7 +376,7 @@
 =

         case 1:  /* Min Address */
 =

-            Descriptor->Memory32.Minimum =3D (UINT32) InitializerOp->Asl.V=
alue.Integer;
+            Minimum =3D InitializerOp->Asl.Value.Integer;
             RsCreateByteField (InitializerOp, ACPI_RESTAG_MINADDR,
                 CurrentByteOffset + ASL_RESDESC_OFFSET (Memory32.Minimum));
             MinOp =3D InitializerOp;
@@ -367,7 +384,7 @@
 =

         case 2: /* Max Address */
 =

-            Descriptor->Memory32.Maximum =3D (UINT32) InitializerOp->Asl.V=
alue.Integer;
+            Maximum =3D InitializerOp->Asl.Value.Integer;
             RsCreateByteField (InitializerOp, ACPI_RESTAG_MAXADDR,
                 CurrentByteOffset + ASL_RESDESC_OFFSET (Memory32.Maximum));
             MaxOp =3D InitializerOp;
@@ -375,7 +392,7 @@
 =

         case 3: /* Alignment */
 =

-            Descriptor->Memory32.Alignment =3D (UINT32) InitializerOp->Asl=
.Value.Integer;
+            Alignment =3D InitializerOp->Asl.Value.Integer;
             RsCreateByteField (InitializerOp, ACPI_RESTAG_ALIGNMENT,
                 CurrentByteOffset + ASL_RESDESC_OFFSET (Memory32.Alignment=
));
             AlignOp =3D InitializerOp;
@@ -383,7 +400,7 @@
 =

         case 4: /* Length */
 =

-            Descriptor->Memory32.AddressLength =3D (UINT32) InitializerOp-=
>Asl.Value.Integer;
+            AddressLength =3D InitializerOp->Asl.Value.Integer;
             RsCreateByteField (InitializerOp, ACPI_RESTAG_LENGTH,
                 CurrentByteOffset + ASL_RESDESC_OFFSET (Memory32.AddressLe=
ngth));
             LengthOp =3D InitializerOp;
@@ -406,12 +423,17 @@
     /* Validate the Min/Max/Len/Align values */
 =

     RsSmallAddressCheck (ACPI_RESOURCE_NAME_MEMORY32,
-        Descriptor->Memory32.Minimum,
-        Descriptor->Memory32.Maximum,
-        Descriptor->Memory32.AddressLength,
-        Descriptor->Memory32.Alignment,
+        Minimum,
+        Maximum,
+        AddressLength,
+        Alignment,
         MinOp, MaxOp, LengthOp, AlignOp);
 =

+    ACPI_MOVE_32_TO_32(&Descriptor->Memory32.Minimum, &Minimum);
+    ACPI_MOVE_32_TO_32(&Descriptor->Memory32.Maximum, &Maximum);
+    ACPI_MOVE_32_TO_32(&Descriptor->Memory32.AddressLength, &AddressLength=
);
+    ACPI_MOVE_32_TO_32(&Descriptor->Memory32.Alignment, &Alignment);
+
     return (Rnode);
 }
 =

@@ -438,6 +460,7 @@
     AML_RESOURCE            *Descriptor;
     ACPI_PARSE_OBJECT       *InitializerOp;
     ASL_RESOURCE_NODE       *Rnode;
+    UINT16                  ResourceLength;
     UINT32                  i;
 =

 =

@@ -446,7 +469,8 @@
 =

     Descriptor =3D Rnode->Buffer;
     Descriptor->FixedMemory32.DescriptorType  =3D ACPI_RESOURCE_NAME_FIXED=
_MEMORY32;
-    Descriptor->FixedMemory32.ResourceLength =3D 9;
+    ResourceLength =3D 9;
+    ACPI_MOVE_16_TO_16(&Descriptor->FixedMemory32.ResourceLength, &Resourc=
eLength);
 =

     /* Process all child initialization nodes */
 =

@@ -463,14 +487,16 @@
 =

         case 1: /* Address */
 =

-            Descriptor->FixedMemory32.Address =3D (UINT32) InitializerOp->=
Asl.Value.Integer;
+            ACPI_MOVE_64_TO_32(&Descriptor->FixedMemory32.Address,
+                &InitializerOp->Asl.Value.Integer);
             RsCreateByteField (InitializerOp, ACPI_RESTAG_BASEADDRESS,
                 CurrentByteOffset + ASL_RESDESC_OFFSET (FixedMemory32.Addr=
ess));
             break;
 =

         case 2: /* Length */
 =

-            Descriptor->FixedMemory32.AddressLength =3D (UINT32) Initializ=
erOp->Asl.Value.Integer;
+            ACPI_MOVE_64_TO_32(&Descriptor->FixedMemory32.AddressLength,
+                &InitializerOp->Asl.Value.Integer);
             RsCreateByteField (InitializerOp, ACPI_RESTAG_LENGTH,
                 CurrentByteOffset + ASL_RESDESC_OFFSET (FixedMemory32.Addr=
essLength));
             break;
Index: b/compiler/aslrestype1i.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/compiler/aslrestype1i.c	2010-07-02 21:42:26.649349305 +0900
+++ b/compiler/aslrestype1i.c	2010-07-04 11:18:19.494017882 +0900
@@ -275,6 +275,7 @@
     ACPI_PARSE_OBJECT       *InitializerOp;
     ACPI_PARSE_OBJECT       *AddressOp =3D NULL;
     ASL_RESOURCE_NODE       *Rnode;
+    UINT16                  Address =3D 0;
     UINT32                  i;
 =

 =

@@ -293,8 +294,7 @@
         {
         case 0: /* Base Address */
 =

-            Descriptor->FixedIo.Address =3D
-                (UINT16) InitializerOp->Asl.Value.Integer;
+            Address =3D InitializerOp->Asl.Value.Integer;
             RsCreateByteField (InitializerOp, ACPI_RESTAG_BASEADDRESS,
                 CurrentByteOffset + ASL_RESDESC_OFFSET (FixedIo.Address));
             AddressOp =3D InitializerOp;
@@ -324,11 +324,13 @@
 =

     /* Error checks */
 =

-    if (Descriptor->FixedIo.Address > 0x03FF)
+    if (Address > 0x03FF)
     {
         AslError (ASL_WARNING, ASL_MSG_ISA_ADDRESS, AddressOp, NULL);
     }
 =

+    ACPI_MOVE_16_TO_16(&Descriptor->FixedIo.Address, &Address);
+
     return (Rnode);
 }
 =

@@ -359,6 +361,8 @@
     ACPI_PARSE_OBJECT       *LengthOp =3D NULL;
     ACPI_PARSE_OBJECT       *AlignOp =3D NULL;
     ASL_RESOURCE_NODE       *Rnode;
+    UINT16                  Minimum =3D 0;
+    UINT16                  Maximum =3D 0;
     UINT32                  i;
 =

 =

@@ -384,8 +388,7 @@
 =

         case 1:  /* Min Address */
 =

-            Descriptor->Io.Minimum =3D
-                (UINT16) InitializerOp->Asl.Value.Integer;
+            Minimum =3D InitializerOp->Asl.Value.Integer;
             RsCreateByteField (InitializerOp, ACPI_RESTAG_MINADDR,
                 CurrentByteOffset + ASL_RESDESC_OFFSET (Io.Minimum));
             MinOp =3D InitializerOp;
@@ -393,8 +396,7 @@
 =

         case 2: /* Max Address */
 =

-            Descriptor->Io.Maximum =3D
-                (UINT16) InitializerOp->Asl.Value.Integer;
+            Maximum =3D InitializerOp->Asl.Value.Integer;
             RsCreateByteField (InitializerOp, ACPI_RESTAG_MAXADDR,
                 CurrentByteOffset + ASL_RESDESC_OFFSET (Io.Maximum));
             MaxOp =3D InitializerOp;
@@ -435,12 +437,15 @@
     /* Validate the Min/Max/Len/Align values */
 =

     RsSmallAddressCheck (ACPI_RESOURCE_NAME_IO,
-        Descriptor->Io.Minimum,
-        Descriptor->Io.Maximum,
+        Minimum,
+        Maximum,
         Descriptor->Io.AddressLength,
         Descriptor->Io.Alignment,
         MinOp, MaxOp, LengthOp, AlignOp);
 =

+    ACPI_MOVE_16_TO_16(&Descriptor->Io.Minimum, &Minimum);
+    ACPI_MOVE_16_TO_16(&Descriptor->Io.Maximum, &Maximum);
+
     return (Rnode);
 }
 =

@@ -561,9 +566,9 @@
         InitializerOp =3D RsCompleteNodeAndGetNext (InitializerOp);
     }
 =

-    /* Now we can set the channel mask */
+    /* Now we can set the interrupt mask */
 =

-    Descriptor->Irq.IrqMask =3D IrqMask;
+    ACPI_MOVE_16_TO_16(&Descriptor->Irq.IrqMask, &IrqMask);
     return (Rnode);
 }
 =

@@ -663,6 +668,6 @@
 =

     /* Now we can set the interrupt mask */
 =

-    Descriptor->Irq.IrqMask =3D IrqMask;
+    ACPI_MOVE_16_TO_16(&Descriptor->Irq.IrqMask, &IrqMask);
     return (Rnode);
 }
Index: b/compiler/aslrestype2.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/compiler/aslrestype2.c	2010-07-02 21:42:26.625349241 +0900
+++ b/compiler/aslrestype2.c	2010-07-04 11:18:19.494017882 +0900
@@ -152,6 +152,7 @@
     AML_RESOURCE            *Descriptor;
     ACPI_PARSE_OBJECT       *InitializerOp;
     ASL_RESOURCE_NODE       *Rnode;
+    UINT16                  ResourceLength;
     UINT32                  i;
 =

 =

@@ -160,7 +161,9 @@
 =

     Descriptor =3D Rnode->Buffer;
     Descriptor->GenericReg.DescriptorType =3D ACPI_RESOURCE_NAME_GENERIC_R=
EGISTER;
-    Descriptor->GenericReg.ResourceLength =3D 12;
+    ResourceLength =3D 12;
+    ACPI_MOVE_16_TO_16(&Descriptor->GenericReg.ResourceLength,
+		    &ResourceLength);
 =

     /* Process all child initialization nodes */
 =

@@ -191,7 +194,8 @@
 =

         case 3: /* Register Address */
 =

-            Descriptor->GenericReg.Address =3D InitializerOp->Asl.Value.In=
teger;
+	    ACPI_MOVE_64_TO_64(&Descriptor->GenericReg.Address,
+			    &InitializerOp->Asl.Value.Integer);
             RsCreateByteField (InitializerOp, ACPI_RESTAG_ADDRESS,
                 CurrentByteOffset + ASL_RESDESC_OFFSET (GenericReg.Address=
));
             break;
@@ -249,6 +253,7 @@
     AML_RESOURCE            *Rover =3D NULL;
     ACPI_PARSE_OBJECT       *InitializerOp;
     ASL_RESOURCE_NODE       *Rnode;
+    UINT16                  ResourceLength =3D 0;
     UINT16                  StringLength =3D 0;
     UINT32                  OptionIndex =3D 0;
     UINT32                  i;
@@ -295,7 +300,7 @@
      * Initial descriptor length -- may be enlarged if there are
      * optional fields present
      */
-    Descriptor->ExtendedIrq.ResourceLength  =3D 2;  /* Flags and table len=
gth byte */
+    ResourceLength  =3D 2;  /* Flags and table length byte */
     Descriptor->ExtendedIrq.InterruptCount  =3D 0;
 =

     Rover =3D ACPI_CAST_PTR (AML_RESOURCE,
@@ -403,10 +408,11 @@
 =

             /* Save the integer and move pointer to the next one */
 =

-            Rover->DwordItem =3D (UINT32) InitializerOp->Asl.Value.Integer;
+            ACPI_MOVE_64_TO_32(&Rover->DwordItem,
+                &InitializerOp->Asl.Value.Integer);
             Rover =3D ACPI_ADD_PTR (AML_RESOURCE, &(Rover->DwordItem), 4);
             Descriptor->ExtendedIrq.InterruptCount++;
-            Descriptor->ExtendedIrq.ResourceLength +=3D 4;
+            ResourceLength +=3D 4;
 =

             /* Case 7: First interrupt number in list */
 =

@@ -442,7 +448,7 @@
     {
         Rover->ByteItem =3D ResSourceIndex;
         Rover =3D ACPI_ADD_PTR (AML_RESOURCE, &(Rover->ByteItem), 1);
-        Descriptor->ExtendedIrq.ResourceLength +=3D 1;
+        ResourceLength +=3D 1;
     }
 =

     /* Add optional ResSource string if present */
@@ -454,13 +460,14 @@
         Rover =3D ACPI_ADD_PTR (
                     AML_RESOURCE, &(Rover->ByteItem), StringLength);
 =

-        Descriptor->ExtendedIrq.ResourceLength =3D (UINT16)
-            (Descriptor->ExtendedIrq.ResourceLength + StringLength);
+        ResourceLength =3D (UINT16) (ResourceLength + StringLength);
     }
 =

     Rnode->BufferLength =3D (ASL_RESDESC_OFFSET (ExtendedIrq.Interrupts[0]=
) -
                            ASL_RESDESC_OFFSET (ExtendedIrq.DescriptorType))
                            + OptionIndex + StringLength;
+    ACPI_MOVE_16_TO_16(&Descriptor->ExtendedIrq.ResourceLength,
+		    &ResourceLength);
     return (Rnode);
 }
 =

@@ -511,7 +518,7 @@
 =

     Descriptor =3D Rnode->Buffer;
     Descriptor->VendorLarge.DescriptorType  =3D ACPI_RESOURCE_NAME_VENDOR_=
LARGE;
-    Descriptor->VendorLarge.ResourceLength =3D (UINT16) i;
+    ACPI_MOVE_32_TO_16(&Descriptor->VendorLarge.ResourceLength, &i);
 =

     /* Point to end-of-descriptor for vendor data */
 =

Index: b/compiler/aslrestype2d.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/compiler/aslrestype2d.c	2010-07-02 21:42:26.585349064 +0900
+++ b/compiler/aslrestype2d.c	2010-07-04 11:18:19.494017882 +0900
@@ -156,7 +156,13 @@
     ACPI_PARSE_OBJECT       *GranOp =3D NULL;
     ASL_RESOURCE_NODE       *Rnode;
     UINT16                  StringLength =3D 0;
+    UINT16                  ResourceLength =3D 0;
     UINT32                  OptionIndex =3D 0;
+    UINT32                  Minimum =3D 0;
+    UINT32                  Maximum =3D 0;
+    UINT32                  AddressLength =3D 0;
+    UINT32                  Granularity =3D 0;
+    UINT32                  TranslationOffset =3D 0;
     UINT8                   *OptionalFields;
     UINT32                  i;
     BOOLEAN                 ResSourceIndex =3D FALSE;
@@ -177,8 +183,7 @@
      * optional fields present
      */
     OptionalFields =3D ((UINT8 *) Descriptor) + sizeof (AML_RESOURCE_ADDRE=
SS32);
-    Descriptor->Address32.ResourceLength =3D (UINT16)
-        (sizeof (AML_RESOURCE_ADDRESS32) -
+    ResourceLength =3D (UINT16) (sizeof (AML_RESOURCE_ADDRESS32) -
          sizeof (AML_RESOURCE_LARGE_HEADER));
 =

     /* Process all child initialization nodes */
@@ -222,8 +227,7 @@
 =

         case 5: /* Address Granularity */
 =

-            Descriptor->Address32.Granularity =3D
-                (UINT32) InitializerOp->Asl.Value.Integer;
+            Granularity =3D InitializerOp->Asl.Value.Integer;
             RsCreateByteField (InitializerOp, ACPI_RESTAG_GRANULARITY,
                 CurrentByteOffset + ASL_RESDESC_OFFSET (Address32.Granular=
ity));
             GranOp =3D InitializerOp;
@@ -231,8 +235,7 @@
 =

         case 6: /* Address Min */
 =

-            Descriptor->Address32.Minimum =3D
-                (UINT32) InitializerOp->Asl.Value.Integer;
+            Minimum =3D InitializerOp->Asl.Value.Integer;
             RsCreateByteField (InitializerOp, ACPI_RESTAG_MINADDR,
                 CurrentByteOffset + ASL_RESDESC_OFFSET (Address32.Minimum)=
);
             MinOp =3D InitializerOp;
@@ -240,8 +243,7 @@
 =

         case 7: /* Address Max */
 =

-            Descriptor->Address32.Maximum =3D
-                (UINT32) InitializerOp->Asl.Value.Integer;
+            Maximum =3D InitializerOp->Asl.Value.Integer;
             RsCreateByteField (InitializerOp, ACPI_RESTAG_MAXADDR,
                 CurrentByteOffset + ASL_RESDESC_OFFSET (Address32.Maximum)=
);
             MaxOp =3D InitializerOp;
@@ -249,16 +251,14 @@
 =

         case 8: /* Translation Offset */
 =

-            Descriptor->Address32.TranslationOffset =3D
-                (UINT32) InitializerOp->Asl.Value.Integer;
+            TranslationOffset =3D InitializerOp->Asl.Value.Integer;
             RsCreateByteField (InitializerOp, ACPI_RESTAG_TRANSLATION,
                 CurrentByteOffset + ASL_RESDESC_OFFSET (Address32.Translat=
ionOffset));
             break;
 =

         case 9: /* Address Length */
 =

-            Descriptor->Address32.AddressLength =3D
-                (UINT32) InitializerOp->Asl.Value.Integer;
+            AddressLength =3D InitializerOp->Asl.Value.Integer;
             RsCreateByteField (InitializerOp, ACPI_RESTAG_LENGTH,
                 CurrentByteOffset + ASL_RESDESC_OFFSET (Address32.AddressL=
ength));
             LengthOp =3D InitializerOp;
@@ -272,7 +272,7 @@
 =

                 OptionalFields[0] =3D (UINT8) InitializerOp->Asl.Value.Int=
eger;
                 OptionIndex++;
-                Descriptor->Address32.ResourceLength++;
+                ResourceLength++;
                 ResSourceIndex =3D TRUE;
             }
             break;
@@ -286,8 +286,7 @@
                 {
                     /* Found a valid ResourceSource */
 =

-                    Descriptor->Address32.ResourceLength =3D (UINT16)
-                        (Descriptor->Address32.ResourceLength + StringLeng=
th);
+                    ResourceLength =3D (UINT16) (ResourceLength + StringLe=
ngth);
 =

                     strcpy ((char *)
                         &OptionalFields[OptionIndex],
@@ -347,13 +346,20 @@
     /* Validate the Min/Max/Len/Gran values */
 =

     RsLargeAddressCheck (
-        Descriptor->Address32.Minimum,
-        Descriptor->Address32.Maximum,
-        Descriptor->Address32.AddressLength,
-        Descriptor->Address32.Granularity,
+        Minimum,
+        Maximum,
+        AddressLength,
+        Granularity,
         Descriptor->Address32.Flags,
         MinOp, MaxOp, LengthOp, GranOp);
 =

+    ACPI_MOVE_16_TO_16(&Descriptor->Address32.ResourceLength, &ResourceLen=
gth);
+    ACPI_MOVE_32_TO_32(&Descriptor->Address32.Minimum, &Minimum);
+    ACPI_MOVE_32_TO_32(&Descriptor->Address32.Maximum, &Maximum);
+    ACPI_MOVE_32_TO_32(&Descriptor->Address32.AddressLength, &AddressLengt=
h);
+    ACPI_MOVE_32_TO_32(&Descriptor->Address32.Granularity, &Granularity);
+    ACPI_MOVE_32_TO_32(&Descriptor->Address32.TranslationOffset, &Translat=
ionOffset);
+
     Rnode->BufferLength =3D sizeof (AML_RESOURCE_ADDRESS32) +
                             OptionIndex + StringLength;
     return (Rnode);
@@ -388,7 +394,13 @@
     ASL_RESOURCE_NODE       *Rnode;
     UINT8                   *OptionalFields;
     UINT16                  StringLength =3D 0;
+    UINT16                  ResourceLength =3D 0;
     UINT32                  OptionIndex =3D 0;
+    UINT32                  Minimum =3D 0;
+    UINT32                  Maximum =3D 0;
+    UINT32                  AddressLength =3D 0;
+    UINT32                  Granularity =3D 0;
+    UINT32                  TranslationOffset =3D 0;
     UINT32                  i;
     BOOLEAN                 ResSourceIndex =3D FALSE;
 =

@@ -408,11 +420,9 @@
      * optional fields present
      */
     OptionalFields =3D ((UINT8 *) Descriptor) + sizeof (AML_RESOURCE_ADDRE=
SS32);
-    Descriptor->Address32.ResourceLength =3D (UINT16)
-        (sizeof (AML_RESOURCE_ADDRESS32) -
+    ResourceLength =3D (UINT16) (sizeof (AML_RESOURCE_ADDRESS32) -
          sizeof (AML_RESOURCE_LARGE_HEADER));
 =

-
     /* Process all child initialization nodes */
 =

     for (i =3D 0; InitializerOp; i++)
@@ -461,8 +471,7 @@
 =

         case 6: /* Address Granularity */
 =

-            Descriptor->Address32.Granularity =3D
-                (UINT32) InitializerOp->Asl.Value.Integer;
+            Granularity =3D InitializerOp->Asl.Value.Integer;
             RsCreateByteField (InitializerOp, ACPI_RESTAG_GRANULARITY,
                 CurrentByteOffset + ASL_RESDESC_OFFSET (Address32.Granular=
ity));
             GranOp =3D InitializerOp;
@@ -470,8 +479,7 @@
 =

         case 7: /* Min Address */
 =

-            Descriptor->Address32.Minimum =3D
-                (UINT32) InitializerOp->Asl.Value.Integer;
+            Minimum =3D InitializerOp->Asl.Value.Integer;
             RsCreateByteField (InitializerOp, ACPI_RESTAG_MINADDR,
                 CurrentByteOffset + ASL_RESDESC_OFFSET (Address32.Minimum)=
);
             MinOp =3D InitializerOp;
@@ -479,8 +487,7 @@
 =

         case 8: /* Max Address */
 =

-            Descriptor->Address32.Maximum =3D
-                (UINT32) InitializerOp->Asl.Value.Integer;
+            Maximum =3D InitializerOp->Asl.Value.Integer;
             RsCreateByteField (InitializerOp, ACPI_RESTAG_MAXADDR,
                 CurrentByteOffset + ASL_RESDESC_OFFSET (Address32.Maximum)=
);
             MaxOp =3D InitializerOp;
@@ -488,16 +495,14 @@
 =

         case 9: /* Translation Offset */
 =

-            Descriptor->Address32.TranslationOffset =3D
-                (UINT32) InitializerOp->Asl.Value.Integer;
+            TranslationOffset =3D InitializerOp->Asl.Value.Integer;
             RsCreateByteField (InitializerOp, ACPI_RESTAG_TRANSLATION,
                 CurrentByteOffset + ASL_RESDESC_OFFSET (Address32.Translat=
ionOffset));
             break;
 =

         case 10: /* Address Length */
 =

-            Descriptor->Address32.AddressLength =3D
-                (UINT32) InitializerOp->Asl.Value.Integer;
+            AddressLength =3D InitializerOp->Asl.Value.Integer;
             RsCreateByteField (InitializerOp, ACPI_RESTAG_LENGTH,
                 CurrentByteOffset + ASL_RESDESC_OFFSET (Address32.AddressL=
ength));
             LengthOp =3D InitializerOp;
@@ -509,7 +514,7 @@
             {
                 OptionalFields[0] =3D (UINT8) InitializerOp->Asl.Value.Int=
eger;
                 OptionIndex++;
-                Descriptor->Address32.ResourceLength++;
+                ResourceLength++;
                 ResSourceIndex =3D TRUE;
             }
             break;
@@ -521,8 +526,8 @@
             {
                 if (StringLength)
                 {
-                    Descriptor->Address32.ResourceLength =3D (UINT16)
-                        (Descriptor->Address32.ResourceLength + StringLeng=
th);
+
+                    ResourceLength =3D (UINT16) (ResourceLength + StringLe=
ngth);
 =

                     strcpy ((char *)
                         &OptionalFields[OptionIndex],
@@ -583,13 +588,20 @@
     /* Validate the Min/Max/Len/Gran values */
 =

     RsLargeAddressCheck (
-        Descriptor->Address32.Minimum,
-        Descriptor->Address32.Maximum,
-        Descriptor->Address32.AddressLength,
-        Descriptor->Address32.Granularity,
+        Minimum,
+        Maximum,
+        AddressLength,
+        Granularity,
         Descriptor->Address32.Flags,
         MinOp, MaxOp, LengthOp, GranOp);
 =

+    ACPI_MOVE_16_TO_16(&Descriptor->Address32.ResourceLength, &ResourceLen=
gth);
+    ACPI_MOVE_32_TO_32(&Descriptor->Address32.Minimum, &Minimum);
+    ACPI_MOVE_32_TO_32(&Descriptor->Address32.Maximum, &Maximum);
+    ACPI_MOVE_32_TO_32(&Descriptor->Address32.AddressLength, &AddressLengt=
h);
+    ACPI_MOVE_32_TO_32(&Descriptor->Address32.Granularity, &Granularity);
+    ACPI_MOVE_32_TO_32(&Descriptor->Address32.TranslationOffset, &Translat=
ionOffset);
+
     Rnode->BufferLength =3D sizeof (AML_RESOURCE_ADDRESS32) +
                             OptionIndex + StringLength;
     return (Rnode);
@@ -624,7 +636,13 @@
     ASL_RESOURCE_NODE       *Rnode;
     UINT8                   *OptionalFields;
     UINT16                  StringLength =3D 0;
+    UINT16                  ResourceLength =3D 0;
     UINT32                  OptionIndex =3D 0;
+    UINT32                  Minimum =3D 0;
+    UINT32                  Maximum =3D 0;
+    UINT32                  AddressLength =3D 0;
+    UINT32                  Granularity =3D 0;
+    UINT32                  TranslationOffset =3D 0;
     UINT32                  i;
     BOOLEAN                 ResSourceIndex =3D FALSE;
 =

@@ -643,8 +661,7 @@
      * optional fields present
      */
     OptionalFields =3D ((UINT8 *) Descriptor) + sizeof (AML_RESOURCE_ADDRE=
SS32);
-    Descriptor->Address32.ResourceLength =3D (UINT16)
-        (sizeof (AML_RESOURCE_ADDRESS32) -
+    ResourceLength =3D (UINT16) (sizeof (AML_RESOURCE_ADDRESS32) -
          sizeof (AML_RESOURCE_LARGE_HEADER));
 =

     /* Process all child initialization nodes */
@@ -693,8 +710,7 @@
 =

         case 6: /* Address Granularity */
 =

-            Descriptor->Address32.Granularity =3D
-                (UINT32) InitializerOp->Asl.Value.Integer;
+            Granularity =3D InitializerOp->Asl.Value.Integer;
             RsCreateByteField (InitializerOp, ACPI_RESTAG_GRANULARITY,
                 CurrentByteOffset + ASL_RESDESC_OFFSET (Address32.Granular=
ity));
             GranOp =3D InitializerOp;
@@ -702,8 +718,7 @@
 =

         case 7: /* Min Address */
 =

-            Descriptor->Address32.Minimum =3D
-                (UINT32) InitializerOp->Asl.Value.Integer;
+            Minimum =3D InitializerOp->Asl.Value.Integer;
             RsCreateByteField (InitializerOp, ACPI_RESTAG_MINADDR,
                 CurrentByteOffset + ASL_RESDESC_OFFSET (Address32.Minimum)=
);
             MinOp =3D InitializerOp;
@@ -711,8 +726,7 @@
 =

         case 8: /* Max Address */
 =

-            Descriptor->Address32.Maximum =3D
-                (UINT32) InitializerOp->Asl.Value.Integer;
+            Maximum =3D InitializerOp->Asl.Value.Integer;
             RsCreateByteField (InitializerOp, ACPI_RESTAG_MAXADDR,
                 CurrentByteOffset + ASL_RESDESC_OFFSET (Address32.Maximum)=
);
             MaxOp =3D InitializerOp;
@@ -720,16 +734,14 @@
 =

         case 9: /* Translation Offset */
 =

-            Descriptor->Address32.TranslationOffset =3D
-                (UINT32) InitializerOp->Asl.Value.Integer;
+            TranslationOffset =3D InitializerOp->Asl.Value.Integer;
             RsCreateByteField (InitializerOp, ACPI_RESTAG_TRANSLATION,
                 CurrentByteOffset + ASL_RESDESC_OFFSET (Address32.Translat=
ionOffset));
             break;
 =

         case 10: /* Address Length */
 =

-            Descriptor->Address32.AddressLength =3D
-                (UINT32) InitializerOp->Asl.Value.Integer;
+            AddressLength =3D InitializerOp->Asl.Value.Integer;
             RsCreateByteField (InitializerOp, ACPI_RESTAG_LENGTH,
                 CurrentByteOffset + ASL_RESDESC_OFFSET (Address32.AddressL=
ength));
             LengthOp =3D InitializerOp;
@@ -741,7 +753,7 @@
             {
                 OptionalFields[0] =3D (UINT8) InitializerOp->Asl.Value.Int=
eger;
                 OptionIndex++;
-                Descriptor->Address32.ResourceLength++;
+                ResourceLength++;
                 ResSourceIndex =3D TRUE;
             }
             break;
@@ -753,8 +765,7 @@
             {
                 if (StringLength)
                 {
-                    Descriptor->Address32.ResourceLength =3D (UINT16)
-                        (Descriptor->Address32.ResourceLength + StringLeng=
th);
+                    ResourceLength =3D (UINT16) (ResourceLength + StringLe=
ngth);
 =

                     strcpy ((char *)
                         &OptionalFields[OptionIndex],
@@ -801,13 +812,20 @@
     /* Validate the Min/Max/Len/Gran values */
 =

     RsLargeAddressCheck (
-        Descriptor->Address32.Minimum,
-        Descriptor->Address32.Maximum,
-        Descriptor->Address32.AddressLength,
-        Descriptor->Address32.Granularity,
+        Minimum,
+        Maximum,
+        AddressLength,
+        Granularity,
         Descriptor->Address32.Flags,
         MinOp, MaxOp, LengthOp, GranOp);
 =

+    ACPI_MOVE_16_TO_16(&Descriptor->Address32.ResourceLength, &ResourceLen=
gth);
+    ACPI_MOVE_32_TO_32(&Descriptor->Address32.Minimum, &Minimum);
+    ACPI_MOVE_32_TO_32(&Descriptor->Address32.Maximum, &Maximum);
+    ACPI_MOVE_32_TO_32(&Descriptor->Address32.AddressLength, &AddressLengt=
h);
+    ACPI_MOVE_32_TO_32(&Descriptor->Address32.Granularity, &Granularity);
+    ACPI_MOVE_32_TO_32(&Descriptor->Address32.TranslationOffset, &Translat=
ionOffset);
+
     Rnode->BufferLength =3D sizeof (AML_RESOURCE_ADDRESS32) +
                             OptionIndex + StringLength;
     return (Rnode);
Index: b/compiler/aslrestype2e.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/compiler/aslrestype2e.c	2010-07-02 21:42:26.637349971 +0900
+++ b/compiler/aslrestype2e.c	2010-07-04 11:18:19.498018099 +0900
@@ -156,6 +156,13 @@
     ACPI_PARSE_OBJECT       *GranOp =3D NULL;
     ASL_RESOURCE_NODE       *Rnode;
     UINT16                  StringLength =3D 0;
+    UINT16                  ResourceLength =3D 0;
+    UINT64                  Minimum =3D 0;
+    UINT64                  Maximum =3D 0;
+    UINT64                  AddressLength =3D 0;
+    UINT64                  Granularity =3D 0;
+    UINT64                  TranslationOffset =3D 0;
+    UINT64                  TypeSpecific =3D 0;
     UINT32                  i;
 =

 =

@@ -170,9 +177,10 @@
     Descriptor->ExtAddress64.ResourceType    =3D ACPI_ADDRESS_TYPE_IO_RANG=
E;
     Descriptor->ExtAddress64.RevisionID      =3D AML_RESOURCE_EXTENDED_ADD=
RESS_REVISION;
 =

-    Descriptor->ExtAddress64.ResourceLength  =3D (UINT16)
-        (sizeof (AML_RESOURCE_EXTENDED_ADDRESS64) -
+    ResourceLength  =3D (UINT16) (sizeof (AML_RESOURCE_EXTENDED_ADDRESS64)=
 -
          sizeof (AML_RESOURCE_LARGE_HEADER));
+    ACPI_MOVE_16_TO_16(&Descriptor->ExtAddress64.ResourceLength,
+        &ResourceLength);
 =

     /* Process all child initialization nodes */
 =

@@ -215,7 +223,7 @@
 =

         case 5: /* Address Granularity */
 =

-            Descriptor->ExtAddress64.Granularity =3D InitializerOp->Asl.Va=
lue.Integer;
+            Granularity =3D InitializerOp->Asl.Value.Integer;
             RsCreateByteField (InitializerOp, ACPI_RESTAG_GRANULARITY,
                 CurrentByteOffset + ASL_RESDESC_OFFSET (ExtAddress64.Granu=
larity));
             GranOp =3D InitializerOp;
@@ -223,7 +231,7 @@
 =

         case 6: /* Address Min */
 =

-            Descriptor->ExtAddress64.Minimum =3D InitializerOp->Asl.Value.=
Integer;
+            Minimum =3D InitializerOp->Asl.Value.Integer;
             RsCreateByteField (InitializerOp, ACPI_RESTAG_MINADDR,
                 CurrentByteOffset + ASL_RESDESC_OFFSET (ExtAddress64.Minim=
um));
             MinOp =3D InitializerOp;
@@ -231,7 +239,7 @@
 =

         case 7: /* Address Max */
 =

-            Descriptor->ExtAddress64.Maximum =3D InitializerOp->Asl.Value.=
Integer;
+            Maximum =3D InitializerOp->Asl.Value.Integer;
             RsCreateByteField (InitializerOp, ACPI_RESTAG_MAXADDR,
                 CurrentByteOffset + ASL_RESDESC_OFFSET (ExtAddress64.Maxim=
um));
             MaxOp =3D InitializerOp;
@@ -239,14 +247,14 @@
 =

         case 8: /* Translation Offset */
 =

-            Descriptor->ExtAddress64.TranslationOffset =3D InitializerOp->=
Asl.Value.Integer;
+            TranslationOffset =3D InitializerOp->Asl.Value.Integer;
             RsCreateByteField (InitializerOp, ACPI_RESTAG_TRANSLATION,
                 CurrentByteOffset + ASL_RESDESC_OFFSET (ExtAddress64.Trans=
lationOffset));
             break;
 =

         case 9: /* Address Length */
 =

-            Descriptor->ExtAddress64.AddressLength =3D InitializerOp->Asl.=
Value.Integer;
+            AddressLength =3D InitializerOp->Asl.Value.Integer;
             RsCreateByteField (InitializerOp, ACPI_RESTAG_LENGTH,
                 CurrentByteOffset + ASL_RESDESC_OFFSET (ExtAddress64.Addre=
ssLength));
             LengthOp =3D InitializerOp;
@@ -254,7 +262,7 @@
 =

         case 10: /* Type-Specific Attributes */
 =

-            Descriptor->ExtAddress64.TypeSpecific =3D InitializerOp->Asl.V=
alue.Integer;
+            TypeSpecific =3D InitializerOp->Asl.Value.Integer;
             RsCreateByteField (InitializerOp, ACPI_RESTAG_TYPESPECIFICATTR=
IBUTES,
                 CurrentByteOffset + ASL_RESDESC_OFFSET (ExtAddress64.TypeS=
pecific));
             break;
@@ -290,13 +298,20 @@
     /* Validate the Min/Max/Len/Gran values */
 =

     RsLargeAddressCheck (
-        Descriptor->ExtAddress64.Minimum,
-        Descriptor->ExtAddress64.Maximum,
-        Descriptor->ExtAddress64.AddressLength,
-        Descriptor->ExtAddress64.Granularity,
+        Minimum,
+        Maximum,
+        AddressLength,
+        Granularity,
         Descriptor->ExtAddress64.Flags,
         MinOp, MaxOp, LengthOp, GranOp);
 =

+    ACPI_MOVE_64_TO_64(&Descriptor->ExtAddress64.Minimum, &Minimum);
+    ACPI_MOVE_64_TO_64(&Descriptor->ExtAddress64.Maximum, &Maximum);
+    ACPI_MOVE_64_TO_64(&Descriptor->ExtAddress64.AddressLength, &AddressLe=
ngth);
+    ACPI_MOVE_64_TO_64(&Descriptor->ExtAddress64.Granularity, &Granularity=
);
+    ACPI_MOVE_64_TO_64(&Descriptor->ExtAddress64.TranslationOffset, &Trans=
lationOffset);
+    ACPI_MOVE_64_TO_64(&Descriptor->ExtAddress64.TypeSpecific, &TypeSpecif=
ic);
+
     Rnode->BufferLength =3D sizeof (AML_RESOURCE_EXTENDED_ADDRESS64) + Str=
ingLength;
     return (Rnode);
 }
@@ -329,6 +344,13 @@
     ACPI_PARSE_OBJECT       *GranOp =3D NULL;
     ASL_RESOURCE_NODE       *Rnode;
     UINT16                  StringLength =3D 0;
+    UINT16                  ResourceLength =3D 0;
+    UINT64                  Minimum =3D 0;
+    UINT64                  Maximum =3D 0;
+    UINT64                  AddressLength =3D 0;
+    UINT64                  Granularity =3D 0;
+    UINT64                  TranslationOffset =3D 0;
+    UINT64                  TypeSpecific =3D 0;
     UINT32                  i;
 =

 =

@@ -343,9 +365,10 @@
     Descriptor->ExtAddress64.ResourceType    =3D ACPI_ADDRESS_TYPE_MEMORY_=
RANGE;
     Descriptor->ExtAddress64.RevisionID      =3D AML_RESOURCE_EXTENDED_ADD=
RESS_REVISION;
 =

-    Descriptor->ExtAddress64.ResourceLength  =3D (UINT16)
-        (sizeof (AML_RESOURCE_EXTENDED_ADDRESS64) -
+    ResourceLength  =3D (UINT16) (sizeof (AML_RESOURCE_EXTENDED_ADDRESS64)=
 -
          sizeof (AML_RESOURCE_LARGE_HEADER));
+    ACPI_MOVE_16_TO_16(&Descriptor->ExtAddress64.ResourceLength,
+        &ResourceLength);
 =

     /* Process all child initialization nodes */
 =

@@ -395,7 +418,7 @@
 =

         case 6: /* Address Granularity */
 =

-            Descriptor->ExtAddress64.Granularity =3D InitializerOp->Asl.Va=
lue.Integer;
+            Granularity =3D InitializerOp->Asl.Value.Integer;
             RsCreateByteField (InitializerOp, ACPI_RESTAG_GRANULARITY,
                 CurrentByteOffset + ASL_RESDESC_OFFSET (ExtAddress64.Granu=
larity));
             GranOp =3D InitializerOp;
@@ -403,7 +426,7 @@
 =

         case 7: /* Min Address */
 =

-            Descriptor->ExtAddress64.Minimum =3D InitializerOp->Asl.Value.=
Integer;
+            Minimum =3D InitializerOp->Asl.Value.Integer;
             RsCreateByteField (InitializerOp, ACPI_RESTAG_MINADDR,
                 CurrentByteOffset + ASL_RESDESC_OFFSET (ExtAddress64.Minim=
um));
             MinOp =3D InitializerOp;
@@ -411,7 +434,7 @@
 =

         case 8: /* Max Address */
 =

-            Descriptor->ExtAddress64.Maximum =3D InitializerOp->Asl.Value.=
Integer;
+            Maximum =3D InitializerOp->Asl.Value.Integer;
             RsCreateByteField (InitializerOp, ACPI_RESTAG_MAXADDR,
                 CurrentByteOffset + ASL_RESDESC_OFFSET (ExtAddress64.Maxim=
um));
             MaxOp =3D InitializerOp;
@@ -419,14 +442,14 @@
 =

         case 9: /* Translation Offset */
 =

-            Descriptor->ExtAddress64.TranslationOffset =3D InitializerOp->=
Asl.Value.Integer;
+            TranslationOffset =3D InitializerOp->Asl.Value.Integer;
             RsCreateByteField (InitializerOp, ACPI_RESTAG_TRANSLATION,
                 CurrentByteOffset + ASL_RESDESC_OFFSET (ExtAddress64.Trans=
lationOffset));
             break;
 =

         case 10: /* Address Length */
 =

-            Descriptor->ExtAddress64.AddressLength =3D InitializerOp->Asl.=
Value.Integer;
+            AddressLength =3D InitializerOp->Asl.Value.Integer;
             RsCreateByteField (InitializerOp, ACPI_RESTAG_LENGTH,
                 CurrentByteOffset + ASL_RESDESC_OFFSET (ExtAddress64.Addre=
ssLength));
             LengthOp =3D InitializerOp;
@@ -434,7 +457,7 @@
 =

         case 11: /* Type-Specific Attributes */
 =

-            Descriptor->ExtAddress64.TypeSpecific =3D InitializerOp->Asl.V=
alue.Integer;
+            TypeSpecific =3D InitializerOp->Asl.Value.Integer;
             RsCreateByteField (InitializerOp, ACPI_RESTAG_TYPESPECIFICATTR=
IBUTES,
                 CurrentByteOffset + ASL_RESDESC_OFFSET (ExtAddress64.TypeS=
pecific));
             break;
@@ -471,13 +494,20 @@
     /* Validate the Min/Max/Len/Gran values */
 =

     RsLargeAddressCheck (
-        Descriptor->ExtAddress64.Minimum,
-        Descriptor->ExtAddress64.Maximum,
-        Descriptor->ExtAddress64.AddressLength,
-        Descriptor->ExtAddress64.Granularity,
+        Minimum,
+        Maximum,
+        AddressLength,
+        Granularity,
         Descriptor->ExtAddress64.Flags,
         MinOp, MaxOp, LengthOp, GranOp);
 =

+    ACPI_MOVE_64_TO_64(&Descriptor->ExtAddress64.Minimum, &Minimum);
+    ACPI_MOVE_64_TO_64(&Descriptor->ExtAddress64.Maximum, &Maximum);
+    ACPI_MOVE_64_TO_64(&Descriptor->ExtAddress64.AddressLength, &AddressLe=
ngth);
+    ACPI_MOVE_64_TO_64(&Descriptor->ExtAddress64.Granularity, &Granularity=
);
+    ACPI_MOVE_64_TO_64(&Descriptor->ExtAddress64.TranslationOffset, &Trans=
lationOffset);
+    ACPI_MOVE_64_TO_64(&Descriptor->ExtAddress64.TypeSpecific, &TypeSpecif=
ic);
+
     Rnode->BufferLength =3D sizeof (AML_RESOURCE_EXTENDED_ADDRESS64) + Str=
ingLength;
     return (Rnode);
 }
@@ -510,6 +540,13 @@
     ACPI_PARSE_OBJECT       *GranOp =3D NULL;
     ASL_RESOURCE_NODE       *Rnode;
     UINT16                  StringLength =3D 0;
+    UINT16                  ResourceLength =3D 0;
+    UINT64                  Minimum =3D 0;
+    UINT64                  Maximum =3D 0;
+    UINT64                  AddressLength =3D 0;
+    UINT64                  Granularity =3D 0;
+    UINT64                  TranslationOffset =3D 0;
+    UINT64                  TypeSpecific =3D 0;
     UINT32                  i;
 =

 =

@@ -523,9 +560,10 @@
     Descriptor->ExtAddress64.DescriptorType  =3D ACPI_RESOURCE_NAME_EXTEND=
ED_ADDRESS64;
     Descriptor->ExtAddress64.RevisionID      =3D AML_RESOURCE_EXTENDED_ADD=
RESS_REVISION;
 =

-    Descriptor->ExtAddress64.ResourceLength  =3D (UINT16)
-        (sizeof (AML_RESOURCE_EXTENDED_ADDRESS64) -
+    ResourceLength  =3D (UINT16) (sizeof (AML_RESOURCE_EXTENDED_ADDRESS64)=
 -
          sizeof (AML_RESOURCE_LARGE_HEADER));
+    ACPI_MOVE_16_TO_16(&Descriptor->ExtAddress64.ResourceLength,
+        &ResourceLength);
 =

     /* Process all child initialization nodes */
 =

@@ -573,7 +611,7 @@
 =

         case 6: /* Address Granularity */
 =

-            Descriptor->ExtAddress64.Granularity =3D InitializerOp->Asl.Va=
lue.Integer;
+            Granularity =3D InitializerOp->Asl.Value.Integer;
             RsCreateByteField (InitializerOp, ACPI_RESTAG_GRANULARITY,
                 CurrentByteOffset + ASL_RESDESC_OFFSET (ExtAddress64.Granu=
larity));
             GranOp =3D InitializerOp;
@@ -581,7 +619,7 @@
 =

         case 7: /* Min Address */
 =

-            Descriptor->ExtAddress64.Minimum =3D InitializerOp->Asl.Value.=
Integer;
+            Minimum =3D InitializerOp->Asl.Value.Integer;
             RsCreateByteField (InitializerOp, ACPI_RESTAG_MINADDR,
                 CurrentByteOffset + ASL_RESDESC_OFFSET (ExtAddress64.Minim=
um));
             MinOp =3D InitializerOp;
@@ -589,7 +627,7 @@
 =

         case 8: /* Max Address */
 =

-            Descriptor->ExtAddress64.Maximum =3D InitializerOp->Asl.Value.=
Integer;
+            Maximum =3D InitializerOp->Asl.Value.Integer;
             RsCreateByteField (InitializerOp, ACPI_RESTAG_MAXADDR,
                 CurrentByteOffset + ASL_RESDESC_OFFSET (ExtAddress64.Maxim=
um));
             MaxOp =3D InitializerOp;
@@ -597,14 +635,14 @@
 =

         case 9: /* Translation Offset */
 =

-            Descriptor->ExtAddress64.TranslationOffset =3D InitializerOp->=
Asl.Value.Integer;
+            TranslationOffset =3D InitializerOp->Asl.Value.Integer;
             RsCreateByteField (InitializerOp, ACPI_RESTAG_TRANSLATION,
                 CurrentByteOffset + ASL_RESDESC_OFFSET (ExtAddress64.Trans=
lationOffset));
             break;
 =

         case 10: /* Address Length */
 =

-            Descriptor->ExtAddress64.AddressLength =3D InitializerOp->Asl.=
Value.Integer;
+            AddressLength =3D InitializerOp->Asl.Value.Integer;
             RsCreateByteField (InitializerOp, ACPI_RESTAG_LENGTH,
                 CurrentByteOffset + ASL_RESDESC_OFFSET (ExtAddress64.Addre=
ssLength));
             LengthOp =3D InitializerOp;
@@ -612,7 +650,7 @@
 =

         case 11: /* Type-Specific Attributes */
 =

-            Descriptor->ExtAddress64.TypeSpecific =3D InitializerOp->Asl.V=
alue.Integer;
+            TypeSpecific =3D InitializerOp->Asl.Value.Integer;
             RsCreateByteField (InitializerOp, ACPI_RESTAG_TYPESPECIFICATTR=
IBUTES,
                 CurrentByteOffset + ASL_RESDESC_OFFSET (ExtAddress64.TypeS=
pecific));
             break;
@@ -634,13 +672,20 @@
     /* Validate the Min/Max/Len/Gran values */
 =

     RsLargeAddressCheck (
-        Descriptor->ExtAddress64.Minimum,
-        Descriptor->ExtAddress64.Maximum,
-        Descriptor->ExtAddress64.AddressLength,
-        Descriptor->ExtAddress64.Granularity,
+        Minimum,
+        Maximum,
+        AddressLength,
+        Granularity,
         Descriptor->ExtAddress64.Flags,
         MinOp, MaxOp, LengthOp, GranOp);
 =

+    ACPI_MOVE_64_TO_64(&Descriptor->ExtAddress64.Minimum, &Minimum);
+    ACPI_MOVE_64_TO_64(&Descriptor->ExtAddress64.Maximum, &Maximum);
+    ACPI_MOVE_64_TO_64(&Descriptor->ExtAddress64.AddressLength, &AddressLe=
ngth);
+    ACPI_MOVE_64_TO_64(&Descriptor->ExtAddress64.Granularity, &Granularity=
);
+    ACPI_MOVE_64_TO_64(&Descriptor->ExtAddress64.TranslationOffset, &Trans=
lationOffset);
+    ACPI_MOVE_64_TO_64(&Descriptor->ExtAddress64.TypeSpecific, &TypeSpecif=
ic);
+
     Rnode->BufferLength =3D sizeof (AML_RESOURCE_EXTENDED_ADDRESS64) + Str=
ingLength;
     return (Rnode);
 }
Index: b/compiler/aslrestype2q.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/compiler/aslrestype2q.c	2010-07-02 21:42:26.673349159 +0900
+++ b/compiler/aslrestype2q.c	2010-07-04 11:18:19.498018099 +0900
@@ -157,7 +157,13 @@
     ASL_RESOURCE_NODE       *Rnode;
     UINT8                   *OptionalFields;
     UINT16                  StringLength =3D 0;
+    UINT16                  ResourceLength =3D 0;
     UINT32                  OptionIndex =3D 0;
+    UINT64                  Minimum =3D 0;
+    UINT64                  Maximum =3D 0;
+    UINT64                  AddressLength =3D 0;
+    UINT64                  Granularity =3D 0;
+    UINT64                  TranslationOffset =3D 0;
     UINT32                  i;
     BOOLEAN                 ResSourceIndex =3D FALSE;
 =

@@ -177,8 +183,7 @@
      * optional fields present
      */
     OptionalFields =3D ((UINT8 *) Descriptor) + sizeof (AML_RESOURCE_ADDRE=
SS64);
-    Descriptor->Address64.ResourceLength =3D (UINT16)
-        (sizeof (AML_RESOURCE_ADDRESS64) -
+    ResourceLength =3D (UINT16) (sizeof (AML_RESOURCE_ADDRESS64) -
          sizeof (AML_RESOURCE_LARGE_HEADER));
 =

     /* Process all child initialization nodes */
@@ -222,7 +227,7 @@
 =

         case 5: /* Address Granularity */
 =

-            Descriptor->Address64.Granularity =3D InitializerOp->Asl.Value=
.Integer;
+            Granularity =3D InitializerOp->Asl.Value.Integer;
             RsCreateByteField (InitializerOp, ACPI_RESTAG_GRANULARITY,
                 CurrentByteOffset + ASL_RESDESC_OFFSET (Address64.Granular=
ity));
             GranOp =3D InitializerOp;
@@ -230,7 +235,7 @@
 =

         case 6: /* Address Min */
 =

-            Descriptor->Address64.Minimum =3D InitializerOp->Asl.Value.Int=
eger;
+            Minimum =3D InitializerOp->Asl.Value.Integer;
             RsCreateByteField (InitializerOp, ACPI_RESTAG_MINADDR,
                 CurrentByteOffset + ASL_RESDESC_OFFSET (Address64.Minimum)=
);
             MinOp =3D InitializerOp;
@@ -238,7 +243,7 @@
 =

         case 7: /* Address Max */
 =

-            Descriptor->Address64.Maximum =3D InitializerOp->Asl.Value.Int=
eger;
+            Maximum =3D InitializerOp->Asl.Value.Integer;
             RsCreateByteField (InitializerOp, ACPI_RESTAG_MAXADDR,
                 CurrentByteOffset + ASL_RESDESC_OFFSET (Address64.Maximum)=
);
             MaxOp =3D InitializerOp;
@@ -246,14 +251,14 @@
 =

         case 8: /* Translation Offset */
 =

-            Descriptor->Address64.TranslationOffset =3D InitializerOp->Asl=
.Value.Integer;
+            TranslationOffset =3D InitializerOp->Asl.Value.Integer;
             RsCreateByteField (InitializerOp, ACPI_RESTAG_TRANSLATION,
                 CurrentByteOffset + ASL_RESDESC_OFFSET (Address64.Translat=
ionOffset));
             break;
 =

         case 9: /* Address Length */
 =

-            Descriptor->Address64.AddressLength =3D InitializerOp->Asl.Val=
ue.Integer;
+            AddressLength =3D InitializerOp->Asl.Value.Integer;
             RsCreateByteField (InitializerOp, ACPI_RESTAG_LENGTH,
                 CurrentByteOffset + ASL_RESDESC_OFFSET (Address64.AddressL=
ength));
             LengthOp =3D InitializerOp;
@@ -265,7 +270,7 @@
             {
                 OptionalFields[0] =3D (UINT8) InitializerOp->Asl.Value.Int=
eger;
                 OptionIndex++;
-                Descriptor->Address64.ResourceLength++;
+                ResourceLength++;
                 ResSourceIndex =3D TRUE;
             }
             break;
@@ -277,8 +282,7 @@
             {
                 if (StringLength)
                 {
-                    Descriptor->Address64.ResourceLength =3D (UINT16)
-                        (Descriptor->Address64.ResourceLength + StringLeng=
th);
+                    ResourceLength =3D (UINT16) (ResourceLength + StringLe=
ngth);
 =

                     strcpy ((char *)
                         &OptionalFields[OptionIndex],
@@ -338,13 +342,20 @@
     /* Validate the Min/Max/Len/Gran values */
 =

     RsLargeAddressCheck (
-        Descriptor->Address64.Minimum,
-        Descriptor->Address64.Maximum,
-        Descriptor->Address64.AddressLength,
-        Descriptor->Address64.Granularity,
+        Minimum,
+        Maximum,
+        AddressLength,
+        Granularity,
         Descriptor->Address64.Flags,
         MinOp, MaxOp, LengthOp, GranOp);
 =

+    ACPI_MOVE_16_TO_16(&Descriptor->Address64.ResourceLength, &ResourceLen=
gth);
+    ACPI_MOVE_64_TO_64(&Descriptor->Address64.Minimum, &Minimum);
+    ACPI_MOVE_64_TO_64(&Descriptor->Address64.Maximum, &Maximum);
+    ACPI_MOVE_64_TO_64(&Descriptor->Address64.AddressLength, &AddressLengt=
h);
+    ACPI_MOVE_64_TO_64(&Descriptor->Address64.Granularity, &Granularity);
+    ACPI_MOVE_64_TO_64(&Descriptor->Address64.TranslationOffset, &Translat=
ionOffset);
+
     Rnode->BufferLength =3D sizeof (AML_RESOURCE_ADDRESS64) +
                             OptionIndex + StringLength;
     return (Rnode);
@@ -379,7 +390,13 @@
     ASL_RESOURCE_NODE       *Rnode;
     UINT8                   *OptionalFields;
     UINT16                  StringLength =3D 0;
+    UINT16                  ResourceLength =3D 0;
     UINT32                  OptionIndex =3D 0;
+    UINT64                  Minimum =3D 0;
+    UINT64                  Maximum =3D 0;
+    UINT64                  AddressLength =3D 0;
+    UINT64                  Granularity =3D 0;
+    UINT64                  TranslationOffset =3D 0;
     UINT32                  i;
     BOOLEAN                 ResSourceIndex =3D FALSE;
 =

@@ -399,8 +416,7 @@
      * optional fields present
      */
     OptionalFields =3D ((UINT8 *) Descriptor) + sizeof (AML_RESOURCE_ADDRE=
SS64);
-    Descriptor->Address64.ResourceLength =3D (UINT16)
-        (sizeof (AML_RESOURCE_ADDRESS64) -
+    ResourceLength =3D (UINT16) (sizeof (AML_RESOURCE_ADDRESS64) -
          sizeof (AML_RESOURCE_LARGE_HEADER));
 =

     /* Process all child initialization nodes */
@@ -451,7 +467,7 @@
 =

         case 6: /* Address Granularity */
 =

-            Descriptor->Address64.Granularity =3D InitializerOp->Asl.Value=
.Integer;
+            Granularity =3D InitializerOp->Asl.Value.Integer;
             RsCreateByteField (InitializerOp, ACPI_RESTAG_GRANULARITY,
                 CurrentByteOffset + ASL_RESDESC_OFFSET (Address64.Granular=
ity));
             GranOp =3D InitializerOp;
@@ -459,7 +475,7 @@
 =

         case 7: /* Min Address */
 =

-            Descriptor->Address64.Minimum =3D InitializerOp->Asl.Value.Int=
eger;
+            Minimum =3D InitializerOp->Asl.Value.Integer;
             RsCreateByteField (InitializerOp, ACPI_RESTAG_MINADDR,
                 CurrentByteOffset + ASL_RESDESC_OFFSET (Address64.Minimum)=
);
             MinOp =3D InitializerOp;
@@ -467,7 +483,7 @@
 =

         case 8: /* Max Address */
 =

-            Descriptor->Address64.Maximum =3D InitializerOp->Asl.Value.Int=
eger;
+            Maximum =3D InitializerOp->Asl.Value.Integer;
             RsCreateByteField (InitializerOp, ACPI_RESTAG_MAXADDR,
                 CurrentByteOffset + ASL_RESDESC_OFFSET (Address64.Maximum)=
);
             MaxOp =3D InitializerOp;
@@ -475,14 +491,14 @@
 =

         case 9: /* Translation Offset */
 =

-            Descriptor->Address64.TranslationOffset =3D InitializerOp->Asl=
.Value.Integer;
+            TranslationOffset =3D InitializerOp->Asl.Value.Integer;
             RsCreateByteField (InitializerOp, ACPI_RESTAG_TRANSLATION,
                 CurrentByteOffset + ASL_RESDESC_OFFSET (Address64.Translat=
ionOffset));
             break;
 =

         case 10: /* Address Length */
 =

-            Descriptor->Address64.AddressLength =3D InitializerOp->Asl.Val=
ue.Integer;
+            AddressLength =3D InitializerOp->Asl.Value.Integer;
             RsCreateByteField (InitializerOp, ACPI_RESTAG_LENGTH,
                 CurrentByteOffset + ASL_RESDESC_OFFSET (Address64.AddressL=
ength));
             LengthOp =3D InitializerOp;
@@ -494,7 +510,7 @@
             {
                 OptionalFields[0] =3D (UINT8) InitializerOp->Asl.Value.Int=
eger;
                 OptionIndex++;
-                Descriptor->Address64.ResourceLength++;
+                ResourceLength++;
                 ResSourceIndex =3D TRUE;
             }
             break;
@@ -506,8 +522,7 @@
             {
                 if (StringLength)
                 {
-                    Descriptor->Address64.ResourceLength =3D (UINT16)
-                        (Descriptor->Address64.ResourceLength + StringLeng=
th);
+                    ResourceLength =3D (UINT16) (ResourceLength + StringLe=
ngth);
 =

                     strcpy ((char *)
                         &OptionalFields[OptionIndex],
@@ -568,13 +583,20 @@
     /* Validate the Min/Max/Len/Gran values */
 =

     RsLargeAddressCheck (
-        Descriptor->Address64.Minimum,
-        Descriptor->Address64.Maximum,
-        Descriptor->Address64.AddressLength,
-        Descriptor->Address64.Granularity,
+        Minimum,
+        Maximum,
+        AddressLength,
+        Granularity,
         Descriptor->Address64.Flags,
         MinOp, MaxOp, LengthOp, GranOp);
 =

+    ACPI_MOVE_16_TO_16(&Descriptor->Address64.ResourceLength, &ResourceLen=
gth);
+    ACPI_MOVE_64_TO_64(&Descriptor->Address64.Minimum, &Minimum);
+    ACPI_MOVE_64_TO_64(&Descriptor->Address64.Maximum, &Maximum);
+    ACPI_MOVE_64_TO_64(&Descriptor->Address64.AddressLength, &AddressLengt=
h);
+    ACPI_MOVE_64_TO_64(&Descriptor->Address64.Granularity, &Granularity);
+    ACPI_MOVE_64_TO_64(&Descriptor->Address64.TranslationOffset, &Translat=
ionOffset);
+
     Rnode->BufferLength =3D sizeof (AML_RESOURCE_ADDRESS64) +
                             OptionIndex + StringLength;
     return (Rnode);
@@ -609,8 +631,14 @@
     ASL_RESOURCE_NODE       *Rnode;
     UINT8                   *OptionalFields;
     UINT16                  StringLength =3D 0;
+    UINT16                  ResourceLength =3D 0;
     UINT32                  OptionIndex =3D 0;
     UINT32                  i;
+    UINT64                  Minimum =3D 0;
+    UINT64                  Maximum =3D 0;
+    UINT64                  AddressLength =3D 0;
+    UINT64                  Granularity =3D 0;
+    UINT64                  TranslationOffset =3D 0;
     BOOLEAN                 ResSourceIndex =3D FALSE;
 =

 =

@@ -628,8 +656,7 @@
      * optional fields present
      */
     OptionalFields =3D ((UINT8 *) Descriptor) + sizeof (AML_RESOURCE_ADDRE=
SS64);
-    Descriptor->Address64.ResourceLength =3D (UINT16)
-        (sizeof (AML_RESOURCE_ADDRESS64) -
+    ResourceLength =3D (UINT16) (sizeof (AML_RESOURCE_ADDRESS64) -
          sizeof (AML_RESOURCE_LARGE_HEADER));
 =

     /* Process all child initialization nodes */
@@ -678,7 +705,7 @@
 =

         case 6: /* Address Granularity */
 =

-            Descriptor->Address64.Granularity =3D InitializerOp->Asl.Value=
.Integer;
+            Granularity =3D InitializerOp->Asl.Value.Integer;
             RsCreateByteField (InitializerOp, ACPI_RESTAG_GRANULARITY,
                 CurrentByteOffset + ASL_RESDESC_OFFSET (Address64.Granular=
ity));
             GranOp =3D InitializerOp;
@@ -686,7 +713,7 @@
 =

         case 7: /* Min Address */
 =

-            Descriptor->Address64.Minimum =3D InitializerOp->Asl.Value.Int=
eger;
+            Minimum =3D InitializerOp->Asl.Value.Integer;
             RsCreateByteField (InitializerOp, ACPI_RESTAG_MINADDR,
                 CurrentByteOffset + ASL_RESDESC_OFFSET (Address64.Minimum)=
);
             MinOp =3D InitializerOp;
@@ -694,7 +721,7 @@
 =

         case 8: /* Max Address */
 =

-            Descriptor->Address64.Maximum =3D InitializerOp->Asl.Value.Int=
eger;
+            Maximum =3D InitializerOp->Asl.Value.Integer;
             RsCreateByteField (InitializerOp, ACPI_RESTAG_MAXADDR,
                 CurrentByteOffset + ASL_RESDESC_OFFSET (Address64.Maximum)=
);
             MaxOp =3D InitializerOp;
@@ -702,14 +729,14 @@
 =

         case 9: /* Translation Offset */
 =

-            Descriptor->Address64.TranslationOffset =3D InitializerOp->Asl=
.Value.Integer;
+            TranslationOffset =3D InitializerOp->Asl.Value.Integer;
             RsCreateByteField (InitializerOp, ACPI_RESTAG_TRANSLATION,
                 CurrentByteOffset + ASL_RESDESC_OFFSET (Address64.Translat=
ionOffset));
             break;
 =

         case 10: /* Address Length */
 =

-            Descriptor->Address64.AddressLength =3D InitializerOp->Asl.Val=
ue.Integer;
+            AddressLength =3D InitializerOp->Asl.Value.Integer;
             RsCreateByteField (InitializerOp, ACPI_RESTAG_LENGTH,
                 CurrentByteOffset + ASL_RESDESC_OFFSET (Address64.AddressL=
ength));
             LengthOp =3D InitializerOp;
@@ -721,7 +748,7 @@
             {
                 OptionalFields[0] =3D (UINT8) InitializerOp->Asl.Value.Int=
eger;
                 OptionIndex++;
-                Descriptor->Address64.ResourceLength++;
+                ResourceLength++;
                 ResSourceIndex =3D TRUE;
             }
             break;
@@ -733,8 +760,7 @@
             {
                 if (StringLength)
                 {
-                    Descriptor->Address64.ResourceLength =3D (UINT16)
-                        (Descriptor->Address64.ResourceLength + StringLeng=
th);
+                    ResourceLength =3D (UINT16) (ResourceLength + StringLe=
ngth);
 =

                     strcpy ((char *)
                         &OptionalFields[OptionIndex],
@@ -780,13 +806,20 @@
     /* Validate the Min/Max/Len/Gran values */
 =

     RsLargeAddressCheck (
-        Descriptor->Address64.Minimum,
-        Descriptor->Address64.Maximum,
-        Descriptor->Address64.AddressLength,
-        Descriptor->Address64.Granularity,
+        Minimum,
+        Maximum,
+        AddressLength,
+        Granularity,
         Descriptor->Address64.Flags,
         MinOp, MaxOp, LengthOp, GranOp);
 =

+    ACPI_MOVE_16_TO_16(&Descriptor->Address64.ResourceLength, &ResourceLen=
gth);
+    ACPI_MOVE_64_TO_64(&Descriptor->Address64.Minimum, &Minimum);
+    ACPI_MOVE_64_TO_64(&Descriptor->Address64.Maximum, &Maximum);
+    ACPI_MOVE_64_TO_64(&Descriptor->Address64.AddressLength, &AddressLengt=
h);
+    ACPI_MOVE_64_TO_64(&Descriptor->Address64.Granularity, &Granularity);
+    ACPI_MOVE_64_TO_64(&Descriptor->Address64.TranslationOffset, &Translat=
ionOffset);
+
     Rnode->BufferLength =3D sizeof (AML_RESOURCE_ADDRESS64) +
                             OptionIndex + StringLength;
     return (Rnode);
Index: b/compiler/aslrestype2w.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/compiler/aslrestype2w.c	2010-07-02 21:42:26.689348992 +0900
+++ b/compiler/aslrestype2w.c	2010-07-04 11:18:19.502017898 +0900
@@ -158,6 +158,12 @@
     UINT8                   *OptionalFields;
     UINT16                  StringLength =3D 0;
     UINT32                  OptionIndex =3D 0;
+    UINT16                  ResourceLength =3D 0;
+    UINT16                  Minimum =3D 0;
+    UINT16                  Maximum =3D 0;
+    UINT16                  AddressLength =3D 0;
+    UINT16                  Granularity =3D 0;
+    UINT16                  TranslationOffset =3D 0;
     UINT32                  i;
     BOOLEAN                 ResSourceIndex =3D FALSE;
 =

@@ -177,8 +183,7 @@
      * optional fields present
      */
     OptionalFields =3D ((UINT8 *) Descriptor) + sizeof (AML_RESOURCE_ADDRE=
SS16);
-    Descriptor->Address16.ResourceLength =3D (UINT16)
-        (sizeof (AML_RESOURCE_ADDRESS16) -
+    ResourceLength =3D (UINT16) (sizeof (AML_RESOURCE_ADDRESS16) -
          sizeof (AML_RESOURCE_LARGE_HEADER));
 =

     /* Process all child initialization nodes */
@@ -222,7 +227,7 @@
 =

         case 5: /* Address Granularity */
 =

-            Descriptor->Address16.Granularity =3D (UINT16) InitializerOp->=
Asl.Value.Integer;
+            Granularity =3D InitializerOp->Asl.Value.Integer;
             RsCreateByteField (InitializerOp, ACPI_RESTAG_GRANULARITY,
                 CurrentByteOffset + ASL_RESDESC_OFFSET (Address16.Granular=
ity));
             GranOp =3D InitializerOp;
@@ -230,7 +235,7 @@
 =

         case 6: /* Address Min */
 =

-            Descriptor->Address16.Minimum =3D (UINT16) InitializerOp->Asl.=
Value.Integer;
+            Minimum =3D InitializerOp->Asl.Value.Integer;
             RsCreateByteField (InitializerOp, ACPI_RESTAG_MINADDR,
                 CurrentByteOffset + ASL_RESDESC_OFFSET (Address16.Minimum)=
);
             MinOp =3D InitializerOp;
@@ -238,7 +243,7 @@
 =

         case 7: /* Address Max */
 =

-            Descriptor->Address16.Maximum =3D (UINT16) InitializerOp->Asl.=
Value.Integer;
+            Maximum =3D InitializerOp->Asl.Value.Integer;
             RsCreateByteField (InitializerOp, ACPI_RESTAG_MAXADDR,
                 CurrentByteOffset + ASL_RESDESC_OFFSET (Address16.Maximum)=
);
             MaxOp =3D InitializerOp;
@@ -246,14 +251,14 @@
 =

         case 8: /* Translation Offset */
 =

-            Descriptor->Address16.TranslationOffset =3D (UINT16) Initializ=
erOp->Asl.Value.Integer;
+            TranslationOffset =3D InitializerOp->Asl.Value.Integer;
             RsCreateByteField (InitializerOp, ACPI_RESTAG_TRANSLATION,
                 CurrentByteOffset + ASL_RESDESC_OFFSET (Address16.Translat=
ionOffset));
             break;
 =

         case 9: /* Address Length */
 =

-            Descriptor->Address16.AddressLength =3D (UINT16) InitializerOp=
->Asl.Value.Integer;
+            AddressLength =3D InitializerOp->Asl.Value.Integer;
             RsCreateByteField (InitializerOp, ACPI_RESTAG_LENGTH,
                  CurrentByteOffset + ASL_RESDESC_OFFSET (Address16.Address=
Length));
             LengthOp =3D InitializerOp;
@@ -265,7 +270,7 @@
             {
                 OptionalFields[0] =3D (UINT8) InitializerOp->Asl.Value.Int=
eger;
                 OptionIndex++;
-                Descriptor->Address16.ResourceLength++;
+                ResourceLength++;
                 ResSourceIndex =3D TRUE;
             }
             break;
@@ -277,8 +282,7 @@
             {
                 if (StringLength)
                 {
-                    Descriptor->Address16.ResourceLength =3D (UINT16)
-                        (Descriptor->Address16.ResourceLength + StringLeng=
th);
+                    ResourceLength =3D (UINT16) (ResourceLength + StringLe=
ngth);
 =

                     strcpy ((char *)
                         &OptionalFields[OptionIndex],
@@ -338,13 +342,20 @@
     /* Validate the Min/Max/Len/Gran values */
 =

     RsLargeAddressCheck (
-        Descriptor->Address16.Minimum,
-        Descriptor->Address16.Maximum,
-        Descriptor->Address16.AddressLength,
-        Descriptor->Address16.Granularity,
+        Minimum,
+        Maximum,
+        AddressLength,
+        Granularity,
         Descriptor->Address16.Flags,
         MinOp, MaxOp, LengthOp, GranOp);
 =

+    ACPI_MOVE_16_TO_16(&Descriptor->Address16.ResourceLength, &ResourceLen=
gth);
+    ACPI_MOVE_16_TO_16(&Descriptor->Address16.Minimum, &Minimum);
+    ACPI_MOVE_16_TO_16(&Descriptor->Address16.Maximum, &Maximum);
+    ACPI_MOVE_16_TO_16(&Descriptor->Address16.AddressLength, &AddressLengt=
h);
+    ACPI_MOVE_16_TO_16(&Descriptor->Address16.Granularity, &Granularity);
+    ACPI_MOVE_16_TO_16(&Descriptor->Address16.TranslationOffset, &Translat=
ionOffset);
+
     Rnode->BufferLength =3D sizeof (AML_RESOURCE_ADDRESS16) +
                             OptionIndex + StringLength;
     return (Rnode);
@@ -380,6 +391,12 @@
     UINT8                   *OptionalFields;
     UINT16                  StringLength =3D 0;
     UINT32                  OptionIndex =3D 0;
+    UINT16                  ResourceLength =3D 0;
+    UINT16                  Minimum =3D 0;
+    UINT16                  Maximum =3D 0;
+    UINT16                  AddressLength =3D 0;
+    UINT16                  Granularity =3D 0;
+    UINT16                  TranslationOffset =3D 0;
     UINT32                  i;
     BOOLEAN                 ResSourceIndex =3D FALSE;
 =

@@ -399,8 +416,7 @@
      * optional fields present
      */
     OptionalFields =3D ((UINT8 *) Descriptor) + sizeof (AML_RESOURCE_ADDRE=
SS16);
-    Descriptor->Address16.ResourceLength =3D (UINT16)
-        (sizeof (AML_RESOURCE_ADDRESS16) -
+    ResourceLength =3D (UINT16) (sizeof (AML_RESOURCE_ADDRESS16) -
          sizeof (AML_RESOURCE_LARGE_HEADER));
 =

     /* Process all child initialization nodes */
@@ -437,8 +453,7 @@
 =

         case 4: /* Address Granularity */
 =

-            Descriptor->Address16.Granularity =3D
-                (UINT16) InitializerOp->Asl.Value.Integer;
+            Granularity =3D InitializerOp->Asl.Value.Integer;
             RsCreateByteField (InitializerOp, ACPI_RESTAG_GRANULARITY,
                 CurrentByteOffset + ASL_RESDESC_OFFSET (Address16.Granular=
ity));
             GranOp =3D InitializerOp;
@@ -446,8 +461,7 @@
 =

         case 5: /* Min Address */
 =

-            Descriptor->Address16.Minimum =3D
-                (UINT16) InitializerOp->Asl.Value.Integer;
+            Minimum =3D InitializerOp->Asl.Value.Integer;
             RsCreateByteField (InitializerOp, ACPI_RESTAG_MINADDR,
                 CurrentByteOffset + ASL_RESDESC_OFFSET (Address16.Minimum)=
);
             MinOp =3D InitializerOp;
@@ -455,8 +469,7 @@
 =

         case 6: /* Max Address */
 =

-            Descriptor->Address16.Maximum =3D
-                (UINT16) InitializerOp->Asl.Value.Integer;
+            Maximum =3D InitializerOp->Asl.Value.Integer;
             RsCreateByteField (InitializerOp, ACPI_RESTAG_MAXADDR,
                 CurrentByteOffset + ASL_RESDESC_OFFSET (Address16.Maximum)=
);
             MaxOp =3D InitializerOp;
@@ -464,16 +477,14 @@
 =

         case 7: /* Translation Offset */
 =

-            Descriptor->Address16.TranslationOffset =3D
-                (UINT16) InitializerOp->Asl.Value.Integer;
+            TranslationOffset =3D InitializerOp->Asl.Value.Integer;
             RsCreateByteField (InitializerOp, ACPI_RESTAG_TRANSLATION,
                 CurrentByteOffset + ASL_RESDESC_OFFSET (Address16.Translat=
ionOffset));
             break;
 =

         case 8: /* Address Length */
 =

-            Descriptor->Address16.AddressLength =3D
-                (UINT16) InitializerOp->Asl.Value.Integer;
+            AddressLength =3D InitializerOp->Asl.Value.Integer;
             RsCreateByteField (InitializerOp, ACPI_RESTAG_LENGTH,
                  CurrentByteOffset + ASL_RESDESC_OFFSET (Address16.Address=
Length));
             LengthOp =3D InitializerOp;
@@ -485,7 +496,7 @@
             {
                 OptionalFields[0] =3D (UINT8) InitializerOp->Asl.Value.Int=
eger;
                 OptionIndex++;
-                Descriptor->Address16.ResourceLength++;
+                ResourceLength++;
                 ResSourceIndex =3D TRUE;
             }
             break;
@@ -497,8 +508,7 @@
             {
                 if (StringLength)
                 {
-                    Descriptor->Address16.ResourceLength =3D (UINT16)
-                        (Descriptor->Address16.ResourceLength + StringLeng=
th);
+                    ResourceLength =3D (UINT16) (ResourceLength + StringLe=
ngth);
 =

                     strcpy ((char *)
                         &OptionalFields[OptionIndex],
@@ -544,13 +554,20 @@
     /* Validate the Min/Max/Len/Gran values */
 =

     RsLargeAddressCheck (
-        Descriptor->Address16.Minimum,
-        Descriptor->Address16.Maximum,
-        Descriptor->Address16.AddressLength,
-        Descriptor->Address16.Granularity,
+        Minimum,
+        Maximum,
+        AddressLength,
+        Granularity,
         Descriptor->Address16.Flags,
         MinOp, MaxOp, LengthOp, GranOp);
 =

+    ACPI_MOVE_16_TO_16(&Descriptor->Address16.ResourceLength, &ResourceLen=
gth);
+    ACPI_MOVE_16_TO_16(&Descriptor->Address16.Minimum, &Minimum);
+    ACPI_MOVE_16_TO_16(&Descriptor->Address16.Maximum, &Maximum);
+    ACPI_MOVE_16_TO_16(&Descriptor->Address16.AddressLength, &AddressLengt=
h);
+    ACPI_MOVE_16_TO_16(&Descriptor->Address16.Granularity, &Granularity);
+    ACPI_MOVE_16_TO_16(&Descriptor->Address16.TranslationOffset, &Translat=
ionOffset);
+
     Rnode->BufferLength =3D sizeof (AML_RESOURCE_ADDRESS16) +
                             OptionIndex + StringLength;
     return (Rnode);
@@ -586,6 +603,12 @@
     UINT8                   *OptionalFields;
     UINT16                  StringLength =3D 0;
     UINT32                  OptionIndex =3D 0;
+    UINT16                  Minimum =3D 0;
+    UINT16                  Maximum =3D 0;
+    UINT16                  AddressLength =3D 0;
+    UINT16                  Granularity =3D 0;
+    UINT16                  TranslationOffset =3D 0;
+    UINT16                  ResourceLength =3D 0;
     UINT32                  i;
     BOOLEAN                 ResSourceIndex =3D FALSE;
 =

@@ -604,8 +627,7 @@
      * optional fields present
      */
     OptionalFields =3D ((UINT8 *) Descriptor) + sizeof (AML_RESOURCE_ADDRE=
SS16);
-    Descriptor->Address16.ResourceLength =3D (UINT16)
-        (sizeof (AML_RESOURCE_ADDRESS16) -
+    ResourceLength =3D (UINT16) (sizeof (AML_RESOURCE_ADDRESS16) -
          sizeof (AML_RESOURCE_LARGE_HEADER));
 =

     /* Process all child initialization nodes */
@@ -654,8 +676,7 @@
 =

         case 6: /* Address Granularity */
 =

-            Descriptor->Address16.Granularity =3D
-                (UINT16) InitializerOp->Asl.Value.Integer;
+            Granularity =3D InitializerOp->Asl.Value.Integer;
             RsCreateByteField (InitializerOp, ACPI_RESTAG_GRANULARITY,
                 CurrentByteOffset + ASL_RESDESC_OFFSET (Address16.Granular=
ity));
             GranOp =3D InitializerOp;
@@ -663,8 +684,7 @@
 =

         case 7: /* Min Address */
 =

-            Descriptor->Address16.Minimum =3D
-                (UINT16) InitializerOp->Asl.Value.Integer;
+            Minimum =3D InitializerOp->Asl.Value.Integer;
             RsCreateByteField (InitializerOp, ACPI_RESTAG_MINADDR,
                 CurrentByteOffset + ASL_RESDESC_OFFSET (Address16.Minimum)=
);
             MinOp =3D InitializerOp;
@@ -672,8 +692,7 @@
 =

         case 8: /* Max Address */
 =

-            Descriptor->Address16.Maximum =3D
-                (UINT16) InitializerOp->Asl.Value.Integer;
+            Maximum =3D InitializerOp->Asl.Value.Integer;
             RsCreateByteField (InitializerOp, ACPI_RESTAG_MAXADDR,
                 CurrentByteOffset + ASL_RESDESC_OFFSET (Address16.Maximum)=
);
             MaxOp =3D InitializerOp;
@@ -681,16 +700,14 @@
 =

         case 9: /* Translation Offset */
 =

-            Descriptor->Address16.TranslationOffset =3D
-                (UINT16) InitializerOp->Asl.Value.Integer;
+            TranslationOffset =3D InitializerOp->Asl.Value.Integer;
             RsCreateByteField (InitializerOp, ACPI_RESTAG_TRANSLATION,
                 CurrentByteOffset + ASL_RESDESC_OFFSET (Address16.Translat=
ionOffset));
             break;
 =

         case 10: /* Address Length */
 =

-            Descriptor->Address16.AddressLength =3D
-                (UINT16) InitializerOp->Asl.Value.Integer;
+            AddressLength =3D InitializerOp->Asl.Value.Integer;
             RsCreateByteField (InitializerOp, ACPI_RESTAG_LENGTH,
                 CurrentByteOffset + ASL_RESDESC_OFFSET (Address16.AddressL=
ength));
             LengthOp =3D InitializerOp;
@@ -702,7 +719,7 @@
             {
                 OptionalFields[0] =3D (UINT8) InitializerOp->Asl.Value.Int=
eger;
                 OptionIndex++;
-                Descriptor->Address16.ResourceLength++;
+                ResourceLength++;
                 ResSourceIndex =3D TRUE;
             }
             break;
@@ -714,8 +731,7 @@
             {
                 if (StringLength)
                 {
-                    Descriptor->Address16.ResourceLength =3D (UINT16)
-                        (Descriptor->Address16.ResourceLength + StringLeng=
th);
+                    ResourceLength =3D (UINT16) (ResourceLength + StringLe=
ngth);
 =

                     strcpy ((char *)
                         &OptionalFields[OptionIndex],
@@ -761,13 +777,20 @@
     /* Validate the Min/Max/Len/Gran values */
 =

     RsLargeAddressCheck (
-        Descriptor->Address16.Minimum,
-        Descriptor->Address16.Maximum,
-        Descriptor->Address16.AddressLength,
-        Descriptor->Address16.Granularity,
+        Minimum,
+        Maximum,
+        AddressLength,
+        Granularity,
         Descriptor->Address16.Flags,
         MinOp, MaxOp, LengthOp, GranOp);
 =

+    ACPI_MOVE_16_TO_16(&Descriptor->Address16.ResourceLength, &ResourceLen=
gth);
+    ACPI_MOVE_16_TO_16(&Descriptor->Address16.Minimum, &Minimum);
+    ACPI_MOVE_16_TO_16(&Descriptor->Address16.Maximum, &Maximum);
+    ACPI_MOVE_16_TO_16(&Descriptor->Address16.AddressLength, &AddressLengt=
h);
+    ACPI_MOVE_16_TO_16(&Descriptor->Address16.Granularity, &Granularity);
+    ACPI_MOVE_16_TO_16(&Descriptor->Address16.TranslationOffset, &Translat=
ionOffset);
+
     Rnode->BufferLength =3D sizeof (AML_RESOURCE_ADDRESS16) +
                             OptionIndex + StringLength;
     return (Rnode);
Index: b/include/acmacros.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/include/acmacros.h	2010-07-02 21:42:26.573348963 +0900
+++ b/include/acmacros.h	2010-07-04 11:18:19.502017898 +0900
@@ -175,7 +175,8 @@
 =

 /* 32-bit source, 16/32/64 destination */
 =

-#define ACPI_MOVE_32_TO_16(d, s)        ACPI_MOVE_16_TO_16(d, s)    /* Tru=
ncate to 16 */
+#define ACPI_MOVE_32_TO_16(d, s)        {((  UINT8 *)(void *)(d))[0] =3D (=
(UINT8 *)(void *)(s))[3];\
+                                         ((  UINT8 *)(void *)(d))[1] =3D (=
(UINT8 *)(void *)(s))[2];}
 =

 #define ACPI_MOVE_32_TO_32(d, s)        {((  UINT8 *)(void *)(d))[0] =3D (=
(UINT8 *)(void *)(s))[3];\
                                          ((  UINT8 *)(void *)(d))[1] =3D (=
(UINT8 *)(void *)(s))[2];\
@@ -190,9 +191,13 @@
 =

 /* 64-bit source, 16/32/64 destination */
 =

-#define ACPI_MOVE_64_TO_16(d, s)        ACPI_MOVE_16_TO_16(d, s)    /* Tru=
ncate to 16 */
+#define ACPI_MOVE_64_TO_16(d, s)        {((  UINT8 *)(void *)(d))[0] =3D (=
(UINT8 *)(void *)(s))[7];\
+                                         ((  UINT8 *)(void *)(d))[1] =3D (=
(UINT8 *)(void *)(s))[6];}
 =

-#define ACPI_MOVE_64_TO_32(d, s)        ACPI_MOVE_32_TO_32(d, s)    /* Tru=
ncate to 32 */
+#define ACPI_MOVE_64_TO_32(d, s)        {((  UINT8 *)(void *)(d))[0] =3D (=
(UINT8 *)(void *)(s))[7];\
+                                         ((  UINT8 *)(void *)(d))[1] =3D (=
(UINT8 *)(void *)(s))[6];\
+                                         ((  UINT8 *)(void *)(d))[2] =3D (=
(UINT8 *)(void *)(s))[5];\
+                                         ((  UINT8 *)(void *)(d))[3] =3D (=
(UINT8 *)(void *)(s))[4];}
 =

 #define ACPI_MOVE_64_TO_64(d, s)        {((  UINT8 *)(void *)(d))[0] =3D (=
(UINT8 *)(void *)(s))[7];\
                                          ((  UINT8 *)(void *)(d))[1] =3D (=
(UINT8 *)(void *)(s))[6];\
@@ -219,7 +224,9 @@
 =

 /* 32-bit source, 16/32/64 destination */
 =

-#define ACPI_MOVE_32_TO_16(d, s)        ACPI_MOVE_16_TO_16(d, s)    /* Tru=
ncate to 16 */
+#define ACPI_MOVE_32_TO_16(d, s)        {((  UINT8 *)(void *)(d))[0] =3D (=
(UINT8 *)(void *)(s))[0];\
+                                         ((  UINT8 *)(void *)(d))[1] =3D (=
(UINT8 *)(void *)(s))[1];}
+
 #define ACPI_MOVE_32_TO_32(d, s)        *(UINT32 *)(void *)(d) =3D *(UINT3=
2 *)(void *)(s)
 #define ACPI_MOVE_32_TO_64(d, s)        *(UINT64 *)(void *)(d) =3D *(UINT3=
2 *)(void *)(s)
 =



--===============8428561925110519125==--

