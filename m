Content-Type: multipart/mixed; boundary="===============2113611906415474796=="
MIME-Version: 1.0
From: Lv Zheng <lv.zheng at intel.com>
Subject: [Devel] [PATCH 1/1] ACPICA: Utility: Add system sleep transition
 notification support.
Date: Fri, 04 Jan 2013 12:16:54 +0800
Message-ID: <3b5964fe8f66bddbc4bb37a563e55f50c20b4d57.1357272874.git.lv.zheng@intel.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============2113611906415474796==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

An OEM-supplied definition block provides some number of controls
appropriate for system level management.
There are 5 methods defined by ACPI 5.0 specification:
  Mandatory: _TTS, _PTS, _WAK
  Optional: _PTS, _GTS
This patch introduce a new function - AcpiNotifySleepTransition -
which can be invoked by OSPM to evaluate such methods to notify the
system sleep state transitions to the platform firmware.

Signed-off-by: Lv Zheng <lv.zheng(a)intel.com>
---
 source/components/utilities/utxface.c |   97 +++++++++++++++++++++++++++++=
++++
 source/include/acnames.h              |    5 +-
 source/include/acpixf.h               |    5 ++
 source/include/actypes.h              |    8 +++
 4 files changed, 114 insertions(+), 1 deletion(-)

diff --git a/source/components/utilities/utxface.c b/source/components/util=
ities/utxface.c
index 05a975d..20ad100 100644
--- a/source/components/utilities/utxface.c
+++ b/source/components/utilities/utxface.c
@@ -599,6 +599,103 @@ AcpiCheckAddressRange (
 =

 ACPI_EXPORT_SYMBOL (AcpiCheckAddressRange)
 =

+
+/*************************************************************************=
******
+ *
+ * FUNCTION:    AcpiNotifySleepTransition
+ *
+ * PARAMETERS:  State               - Sleep state to be passed to the firm=
ware
+ *              Method              - Sleep transition step
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: OEM-supplied system level control methods are required to =
be
+ *              evaluated to notify the platform firmware of the sleep sta=
te
+ *              transitions. This helper function can be called by OSPM in
+ *              the proper point during the system sleep transitions:
+ *              _TTS - ACPI_SLEEP_SUSPEND_BEGIN/ACPI_SLEEP_RESUME_END:
+ *                    beginning of suspending / end of resuming.
+ *              _PTS - ACPI_SLEEP_SUSPEND_DEVICES:
+ *                    after the readiness of the devices' suspending.
+ *              _GTS - ACPI_SLEEP_SUSPEND_SYSTEM:
+ *                    after the readiness of the system's suspending.
+ *              _BFS - ACPI_SLEEP_RESUME_SYSTEM:
+ *                    before the readiness of the system's resuming.
+ *              _WAK - ACPI_SLEEP_RESUME_DEVICES:
+ *                    before the readiness of the devices' resuming.
+ *
+ *************************************************************************=
*****/
+
+ACPI_STATUS
+AcpiNotifySleepTransition (
+    UINT32                  State,
+    UINT32                  Step)
+{
+    char                    *Method;
+    ACPI_STATUS             Status;
+    ACPI_OBJECT             Arg[1];
+    ACPI_OBJECT_LIST        ArgList;
+
+
+    /* Sanity check for the sleep state */
+
+    if (State > ACPI_STATE_S5)
+    {
+        return (AE_BAD_PARAMETER);
+    }
+
+    /* Sanity check for the sleep step */
+
+    switch (Step)
+    {
+    case ACPI_SLEEP_SUSPEND_BEGIN:
+    case ACPI_SLEEP_RESUME_END:
+        Method =3D METHOD_PATHNAME__TTS;
+        break;
+
+    case ACPI_SLEEP_SUSPEND_DEVICES:
+        Method =3D METHOD_PATHNAME__PTS;
+        break;
+
+    case ACPI_SLEEP_SUSPEND_SYSTEM:
+        Method =3D METHOD_PATHNAME__GTS;
+        break;
+
+    case ACPI_SLEEP_RESUME_SYSTEM:
+        Method =3D METHOD_PATHNAME__BFS;
+        break;
+
+    case ACPI_SLEEP_RESUME_DEVICES:
+        Method =3D METHOD_PATHNAME__WAK;
+        break;
+
+    default:
+        return (AE_BAD_PARAMETER);
+        break;
+    }
+
+    /* Setup input argument */
+
+    ArgList.Count =3D 1;
+    ArgList.Pointer =3D Arg;
+
+    Arg[0].Type =3D ACPI_TYPE_INTEGER;
+    Arg[0].Integer.Value =3D State;
+
+    Status =3D AcpiEvaluateObject (NULL, Method, &ArgList, NULL);
+    if (ACPI_SUCCESS(Status) || Status =3D=3D AE_NOT_FOUND)
+    {
+        /*
+         * Method does not exist, return OK.
+         */
+        return (AE_OK);
+    }
+
+    return (Status);
+}
+
+ACPI_EXPORT_SYMBOL (AcpiNotifySleepTransition)
+
 #endif /* !ACPI_ASL_COMPILER */
 =

 =

diff --git a/source/include/acnames.h b/source/include/acnames.h
index 61d6806..c39d0e4 100644
--- a/source/include/acnames.h
+++ b/source/include/acnames.h
@@ -139,8 +139,11 @@
 =

 /* Method names - these methods must appear at the namespace root */
 =

-#define METHOD_PATHNAME__PTS    "\\_PTS"
 #define METHOD_PATHNAME__SST    "\\_SI._SST"
+#define METHOD_PATHNAME__TTS    "\\_TTS"
+#define METHOD_PATHNAME__PTS    "\\_PTS"
+#define METHOD_PATHNAME__GTS    "\\_GTS"
+#define METHOD_PATHNAME__BFS    "\\_BFS"
 #define METHOD_PATHNAME__WAK    "\\_WAK"
 =

 /* Definitions of the predefined namespace names  */
diff --git a/source/include/acpixf.h b/source/include/acpixf.h
index cb781e5..d42beb4 100644
--- a/source/include/acpixf.h
+++ b/source/include/acpixf.h
@@ -261,6 +261,11 @@ AcpiDecodePldBuffer (
     ACPI_SIZE               Length,
     ACPI_PLD_INFO           **ReturnBuffer);
 =

+ACPI_STATUS
+AcpiNotifySleepTransition (
+    UINT32                  State,
+    UINT32                  Step);
+
 /*
  * ACPI Memory management
  */
diff --git a/source/include/actypes.h b/source/include/actypes.h
index ab26f8d..f470995 100644
--- a/source/include/actypes.h
+++ b/source/include/actypes.h
@@ -1265,6 +1265,14 @@ typedef struct acpi_device_info
 #define ACPI_STA_DEVICE_OK              0x08 /* Synonym */
 #define ACPI_STA_BATTERY_PRESENT        0x10
 =

+/* Steps for system sleep transition */
+
+#define ACPI_SLEEP_SUSPEND_BEGIN	0x00
+#define ACPI_SLEEP_SUSPEND_DEVICES	0x01
+#define ACPI_SLEEP_SUSPEND_SYSTEM	0x02
+#define ACPI_SLEEP_RESUME_SYSTEM	0x03
+#define ACPI_SLEEP_RESUME_DEVICES	0x04
+#define ACPI_SLEEP_RESUME_END		0x05
 =

 /* Context structs for address space handlers */
 =

-- =

1.7.10


--===============2113611906415474796==--

