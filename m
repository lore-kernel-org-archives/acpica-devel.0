Content-Type: multipart/mixed; boundary="===============1397792389011933447=="
MIME-Version: 1.0
From: Anthony Jenkins <Anthony.B.Jenkins at att.net>
Subject: [Devel] [PATCH] Naive implementation of AcpiExCmosSpaceHandler()
Date: Sat, 07 Jun 2014 10:28:11 -0400
Message-ID: <5393217B.2010101@att.net>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============1397792389011933447==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

I'm testing on FreeBSD 11.0-CURRENT #18 r266756M on an HP Envy Sleekbook 6z=
-1100 (AMD A-10).  This is a naive implementation of AcpiExCmosSpaceHandler=
(), it simply uses I/O ports 0x70 and 0x71 to read/write CMOS registers usi=
ng AcpiHwWritePort()/AcpiHwReadPort() calls. I'm new(ish) to the ACPICA sub=
system and I'm probably not going about this the right way - I think I shou=
ld implement an actual FreeBSD CMOS RTC device which handles the three PNP =
IDs that represent those hardware devices, but this was good enough for wha=
t I was trying to do.

This fixes my HP Envy 6z-1100 laptop's suspend/resume (except video fails t=
o resume, but I believe that's due to backlight handling from my research).=
 Before, initiating a suspend (zzz(8)) caused the laptop to suspend and imm=
ediately resume. Now trying to track down the backlight issue. I implemente=
d a missing _BQC method which returns a single value from the _BCL listj; I=
 think Linux does some kind of vendor backlight control method if this meth=
od is missing.

Suggestions on the patch or backlight issue welcome.
Anthony Jenkins

diff --git a/source/components/events/evhandler.c b/source/components/event=
s/evhandler.c
index d17411e..4f341ca 100644
--- a/source/components/events/evhandler.c
+++ b/source/components/events/evhandler.c
@@ -142,6 +142,7 @@ UINT8        AcpiGbl_DefaultAddressSpaces[ACPI_NUM_DEFA=
ULT_SPACES] =3D
     ACPI_ADR_SPACE_SYSTEM_MEMORY,
     ACPI_ADR_SPACE_SYSTEM_IO,
     ACPI_ADR_SPACE_PCI_CONFIG,
+    ACPI_ADR_SPACE_CMOS,
     ACPI_ADR_SPACE_DATA_TABLE
 };
 =

@@ -451,9 +452,12 @@ AcpiEvInstallSpaceHandler (
      */
     if ((Node->Type !=3D ACPI_TYPE_DEVICE)     &&
         (Node->Type !=3D ACPI_TYPE_PROCESSOR)  &&
+        (Node->Type !=3D ACPI_TYPE_REGION)     &&
         (Node->Type !=3D ACPI_TYPE_THERMAL)    &&
         (Node !=3D AcpiGbl_RootNode))
     {
+        ACPI_DEBUG_PRINT ((ACPI_DB_OPREGION,
+            "Device %p not a DEVICE, PROCESSOR, REGION, THERMAL type or ro=
ot node.\n", Node));
         Status =3D AE_BAD_PARAMETER;
         goto UnlockAndExit;
     }
diff --git a/source/components/executer/exregion.c b/source/components/exec=
uter/exregion.c
index ea10a01..bfdd721 100644
--- a/source/components/executer/exregion.c
+++ b/source/components/executer/exregion.c
@@ -521,6 +521,20 @@ AcpiExPciConfigSpaceHandler (
     return_ACPI_STATUS (Status);
 }
 =

+static UINT8 AcpiExCmosRead(ACPI_PHYSICAL_ADDRESS Address)
+{
+    UINT32 Value32;
+
+    AcpiHwWritePort((ACPI_IO_ADDRESS) 0x70, (UINT32) Address, 8);
+    AcpiHwReadPort ((ACPI_IO_ADDRESS) 0x71, &Value32, 8);
+    return Value32 & 0xFF;
+}
+
+static void AcpiExCmosWrite(ACPI_PHYSICAL_ADDRESS Address, UINT8 Value)
+{
+    AcpiHwWritePort((ACPI_IO_ADDRESS) 0x70, (UINT32) Address, 8);
+    AcpiHwWritePort((ACPI_IO_ADDRESS) 0x71, (UINT32) Value, 8);
+}
 =

 /*************************************************************************=
******
  *
@@ -545,7 +559,7 @@ AcpiExCmosSpaceHandler (
     UINT32                  Function,
     ACPI_PHYSICAL_ADDRESS   Address,
     UINT32                  BitWidth,
-    UINT64                  *Value,
+    UINT64                  *Value64,
     void                    *HandlerContext,
     void                    *RegionContext)
 {
@@ -554,7 +568,23 @@ AcpiExCmosSpaceHandler (
 =

     ACPI_FUNCTION_TRACE (ExCmosSpaceHandler);
 =

-
+    if (Address < 0x80 &&
+        (Function =3D=3D ACPI_READ || Function =3D=3D ACPI_WRITE) &&
+        BitWidth <=3D 64)
+    {
+        UINT32 i;
+        UINT8 *Value =3D (UINT8 *)Value64;
+
+        for (i =3D 0; i < (BitWidth + 7) / 8; ++i, ++Address, ++Value) {
+            if (Function =3D=3D ACPI_READ) {
+                *Value =3D AcpiExCmosRead(Address);
+            } else {
+                AcpiExCmosWrite(Address, *Value);
+            }
+        }
+    } else {
+        Status =3D AE_BAD_PARAMETER;
+    }
     return_ACPI_STATUS (Status);
 }
 =

diff --git a/source/include/acconfig.h b/source/include/acconfig.h
index 6b34484..7fe2eac 100644
--- a/source/include/acconfig.h
+++ b/source/include/acconfig.h
@@ -270,7 +270,7 @@
 /* Maximum SpaceIds for Operation Regions */
 =

 #define ACPI_MAX_ADDRESS_SPACE          255
-#define ACPI_NUM_DEFAULT_SPACES         4
+#define ACPI_NUM_DEFAULT_SPACES         5
 =

 /* Array sizes. Used for range checking also */
=20

--===============1397792389011933447==--

