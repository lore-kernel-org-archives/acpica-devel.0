Content-Type: multipart/mixed; boundary="===============8690827294356873912=="
MIME-Version: 1.0
From: Lv Zheng <lv.zheng at intel.com>
Subject: [Devel] [PATCH 1/1] ACPICA: Tables: Update RASF table definitions.
Date: Wed, 09 Jan 2013 08:26:47 +0800
Message-ID: <af8608d1aa6286018c798f6b98d030408a0c529e.1357656519.git.lv.zheng@intel.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============8690827294356873912==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Update RASF table definitions to reflect ACPI 5.0 changes.

Signed-off-by: Lv Zheng <lv.zheng(a)intel.com>
---
 source/include/actbl3.h |   59 +++++++++++++++++++++++++++++++++++++++----=
----
 1 file changed, 49 insertions(+), 10 deletions(-)

diff --git a/source/include/actbl3.h b/source/include/actbl3.h
index 5433bfd..f2fafe0 100644
--- a/source/include/actbl3.h
+++ b/source/include/actbl3.h
@@ -671,28 +671,67 @@ typedef struct acpi_rasf_shared_memory
     UINT32                  Signature;
     UINT16                  Command;
     UINT16                  Status;
-    UINT64                  RequestedAddress;
-    UINT64                  RequestedLength;
-    UINT64                  ActualAddress;
-    UINT64                  ActualLength;
-    UINT16                  Flags;
-    UINT8                   Speed;
+    UINT16                  Version;
+    UINT8                   RASCapabilities[16];
+    UINT8                   SetRASCapabilities[16];
+    UINT16                  NumberOfRASFParameterBlocks;
+    UINT32                  SetRASCapabilitiesStatus;
 =

 } ACPI_RASF_SHARED_MEMORY;
 =

+/* RASF Parameter Block Structure Header */
+
+typedef struct acpi_rasf_parameter_block
+{
+    UINT16                  Type;
+    UINT16                  Version;
+    UINT16                  Length;
+
+} ACPI_RASF_PARAMETER_BLOCK;
+
+/* RASF Parameter Block Structure for PATROL_SCRUB */
+
+typedef struct acpi_rasf_patrol_scrub_parameter
+{
+    ACPI_RASF_PARAMETER_BLOCK   Header;
+    UINT16                      PatrolScrubCommand;
+    UINT64                      RequestedAddressRange[2];
+    UINT64                      ActualAddressRange[2];
+    UINT16                      Flags;
+    UINT8                       RequestedSpeed;
+
+} ACPI_RASF_PATROL_SCRUB_PARAMETER;
+
 /* Masks for Flags and Speed fields above */
 =

 #define ACPI_RASF_SCRUBBER_RUNNING      1
 #define ACPI_RASF_SPEED                 (7<<1)
+#define ACPI_RASF_SPEED_SLOW            (0<<1)
+#define ACPI_RASF_SPEED_MEDIUM          (4<<1)
+#define ACPI_RASF_SPEED_FAST            (7<<1)
 =

 /* Channel Commands */
 =

 enum AcpiRasfCommands
 {
-    ACPI_RASF_GET_RAS_CAPABILITIES      =3D 1,
-    ACPI_RASF_GET_PATROL_PARAMETERS     =3D 2,
-    ACPI_RASF_START_PATROL_SCRUBBER     =3D 3,
-    ACPI_RASF_STOP_PATROL_SCRUBBER      =3D 4
+    ACPI_RASF_EXECUTE_RASF_COMMAND      =3D 1
+};
+
+/* Platform RAS Capabilities */
+
+enum AcpiRasfCapabiliities
+{
+    ACPI_HW_PATROL_SCRUB_SUPPORTED      =3D 0,
+    ACPI_SW_PATROL_SCRUB_EXPOSED        =3D 1
+};
+
+/* Patrol Scrub Commands */
+
+enum AcpiRasfPatrolScrubCommands
+{
+    ACPI_RASF_GET_PATROL_PARAMETERS     =3D 1,
+    ACPI_RASF_START_PATROL_SCRUBBER     =3D 2,
+    ACPI_RASF_STOP_PATROL_SCRUBBER      =3D 3
 };
 =

 /* Channel Command flags */
-- =

1.7.10


--===============8690827294356873912==--

