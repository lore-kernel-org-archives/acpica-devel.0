Return-Path: <3W9PnZAsKAM43ECD27CD2DD08805y.w86@flex--justinstitt.bounces.google.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 030AA613E1
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5D56660B99
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20221208; t=1692914523; x=1693519323;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=+ByfN+noqMCVkVscBGCrI7pkixl0yY22EjKSAxd2EZU=;
 b=FW2erCnLQgKayhTZ1wVW9bz0T67VsUF1CK5WHkoQqQxEE2KF0iRsarlccu1dyv2SGL
 eA5k6PLHdgB12BXIe/KZnfbdPEBplyPPBvqW++IQobq0vl+oNXUqJKppFVULGZE0DPnC
 3g+eS1qmuWPjegyzhjMFmsWzLgz+J37nt9Y1w+/fkP/AfLH0uuQSmtZSTzRu03AVWhzi
 nvnlRsplZuLFpnfFEhJX4YNJvBIYgECemDv+4hLueCKlO7oOHdPWI1udE7+FQ/8KyH/u
 0AUi8XQn2oZxt6Wmd6BVMmraFxPvWZR+Qkw/7gvYq1ZLMS3wWBWAu3u2jN2YuAPK1GWT
 BPdg==
Mime-Version: 1.0
X-Developer-Key: i=justinstitt@google.com; a=ed25519;
 pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1692914522; l=3684;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=a9UsameJpI592QOpENgrhz3IgrWL7+TLPCUljbg60hc=;
 b=e3Pv4SmVInFuVIbTKSQXxLeqrBg7t0W4yh/+B4IXTVUNIyarAJtZGQqiq8TM2ro117RoQHQoX
 BrU6DwJ/4dmBFk6SNWPePeKezFEJP6lF76aWDrBPbEHYmyL328c6yOk
Message-ID: <20230824-strncpy-drivers-acpi-acpica-v1-1-d027ba183b66@google.com>
From: Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
Subject: [Acpica-devel] [PATCH RFC] ACPICA: remove acpi_ut_safe_strncpy in
	favor of strscpy
List-Id: "This is the central place for ACPICA developer discussions and
 issues." <acpica-devel.lists.linuxfoundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/acpica-devel/>
List-Post: <mailto:acpica-devel@lists.linuxfoundation.org>
List-Help: <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=subscribe>
Date: Thu, 24 Aug 2023 22:02:07 -0000
To: Robert Moore <robert.moore@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>
Cc: Kees Cook <keescook@chromium.org>, Nick Desaulniers <ndesaulniers@google.com>, linux-kernel@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>, linux-acpi@vger.kernel.org, Justin Stitt <justinstitt@google.com>, acpica-devel@lists.linuxfoundation.org

I wanted to gather some thoughts on removing `acpi_ut_safe_strncpy` (and
potentially other `acpi...safe...()` interfaces) in favor of
pre-existing interfaces in the kernel (like strscpy).

Running a git blame shows these functions were implemented 10 years ago
and their implementations generally mirror the _newer_ and more robust
stuff in lib/string.h -- Let's just use these, right?

I appreciate any comments and whether or not I should stop at just
`strncpy`.

Thanks

Signed-off-by: Justin Stitt <justinstitt@google.com>
---
 drivers/acpi/acpica/acutils.h   | 2 --
 drivers/acpi/acpica/dbfileio.c  | 2 +-
 drivers/acpi/acpica/psutils.c   | 2 +-
 drivers/acpi/acpica/utnonansi.c | 8 --------
 drivers/acpi/acpica/uttrack.c   | 2 +-
 5 files changed, 3 insertions(+), 13 deletions(-)

diff --git a/drivers/acpi/acpica/acutils.h b/drivers/acpi/acpica/acutils.h
index edfdbbef81c1..4d5c401a14b4 100644
--- a/drivers/acpi/acpica/acutils.h
+++ b/drivers/acpi/acpica/acutils.h
@@ -626,8 +626,6 @@ void acpi_ut_repair_name(char *name);
 #if defined (ACPI_DEBUGGER) || defined (ACPI_APPLICATION) || defined (ACPI_DEBUG_OUTPUT)
 u8 acpi_ut_safe_strcpy(char *dest, acpi_size dest_size, char *source);
 
-void acpi_ut_safe_strncpy(char *dest, char *source, acpi_size dest_size);
-
 u8 acpi_ut_safe_strcat(char *dest, acpi_size dest_size, char *source);
 
 u8
diff --git a/drivers/acpi/acpica/dbfileio.c b/drivers/acpi/acpica/dbfileio.c
index e1b6e54a96ac..197e1ff1f72c 100644
--- a/drivers/acpi/acpica/dbfileio.c
+++ b/drivers/acpi/acpica/dbfileio.c
@@ -63,7 +63,7 @@ void acpi_db_open_debug_file(char *name)
 	}
 
 	acpi_os_printf("Debug output file %s opened\n", name);
-	acpi_ut_safe_strncpy(acpi_gbl_db_debug_filename, name,
+	strscpy(acpi_gbl_db_debug_filename, name,
 			     sizeof(acpi_gbl_db_debug_filename));
 	acpi_gbl_db_output_to_file = TRUE;
 }
diff --git a/drivers/acpi/acpica/psutils.c b/drivers/acpi/acpica/psutils.c
index d550c4af4702..95af2c74e00b 100644
--- a/drivers/acpi/acpica/psutils.c
+++ b/drivers/acpi/acpica/psutils.c
@@ -60,7 +60,7 @@ void acpi_ps_init_op(union acpi_parse_object *op, u16 opcode)
 	op->common.descriptor_type = ACPI_DESC_TYPE_PARSER;
 	op->common.aml_opcode = opcode;
 
-	ACPI_DISASM_ONLY_MEMBERS(acpi_ut_safe_strncpy(op->common.aml_op_name,
+	ACPI_DISASM_ONLY_MEMBERS(strscpy(op->common.aml_op_name,
 						      (acpi_ps_get_opcode_info
 						       (opcode))->name,
 						      sizeof(op->common.
diff --git a/drivers/acpi/acpica/utnonansi.c b/drivers/acpi/acpica/utnonansi.c
index ff0802ace19b..a465e5a1d309 100644
--- a/drivers/acpi/acpica/utnonansi.c
+++ b/drivers/acpi/acpica/utnonansi.c
@@ -164,12 +164,4 @@ acpi_ut_safe_strncat(char *dest,
 	return (FALSE);
 }
 
-void acpi_ut_safe_strncpy(char *dest, char *source, acpi_size dest_size)
-{
-	/* Always terminate destination string */
-
-	strncpy(dest, source, dest_size);
-	dest[dest_size - 1] = 0;
-}
-
 #endif
diff --git a/drivers/acpi/acpica/uttrack.c b/drivers/acpi/acpica/uttrack.c
index f5f5da441458..a96a86bc5781 100644
--- a/drivers/acpi/acpica/uttrack.c
+++ b/drivers/acpi/acpica/uttrack.c
@@ -368,7 +368,7 @@ acpi_ut_track_allocation(struct acpi_debug_mem_block *allocation,
 	allocation->component = component;
 	allocation->line = line;
 
-	acpi_ut_safe_strncpy(allocation->module, (char *)module,
+	strscpy(allocation->module, (char *)module,
 			     ACPI_MAX_MODULE_NAME);
 
 	if (!element) {

---
base-commit: f9604036a3fb6149badf346994b46b03f9292db7
change-id: 20230824-strncpy-drivers-acpi-acpica-321af3eb414e

Best regards,
--
Justin Stitt <justinstitt@google.com>

