Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43442E3F2
	for <acpica-devel@lists.linux.dev>; Tue, 28 Nov 2023 09:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SG5CucDj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DB92C433C8;
	Tue, 28 Nov 2023 09:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701164472;
	bh=FA1LBxH1j+97p40+TU9f7Ia7qV+X80etxNQPNyQGWUM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SG5CucDjOChcKlYeZDe8xNGQKx0K7rww45Mgb77+oLSM9oFPxjjltBR6LS79KwV1x
	 BU+r60/i8+u2XWtgxv1qgKokgRX1gigQ+dHmDsDULF7BVs+NYBwggdnSIGYHsBnDcS
	 uE3odrXHipDbzctVpTgi2neSaACCXn3F1gjKpZkVx+bnvu/WVmIAh7cBHDm2pp9HhO
	 H1woVqpwEKeNrzZQk74T7cQeoywfoHjOi3znCADuB2a+ykiY7wIM9z4UP5ikqjYivw
	 BgF1YX8mmb8AL0lci46pDZRbKmf+dIwHf4Ryg8ANzWkixyglNwXdtL/cxn+7BLaFuj
	 TmmVibIiBWSaw==
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: acpica-devel@lists.linux.dev
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
Subject: [PATCH 2/2] MADT: Add new MADT GICC/GICR/ITS non-coherent flags handling
Date: Tue, 28 Nov 2023 10:41:02 +0100
Message-Id: <20231128094102.37662-3-lpieralisi@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231128094102.37662-1-lpieralisi@kernel.org>
References: <20231128094102.37662-1-lpieralisi@kernel.org>
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add new flags and related fields to the MADT GICC/GICR/ITS
structures according to the code first ECR:

https://bugzilla.tianocore.org/show_bug.cgi?id=4557

Update the MADT template to the latest MADT revision.

Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
---
 source/common/dmtbdump2.c    | 14 ++++--
 source/common/dmtbinfo2.c    | 52 ++++++++++++++++++++++
 source/compiler/dttable2.c   | 15 +++++--
 source/compiler/dttemplate.h | 85 ++++++++++++++++++------------------
 source/include/acdisasm.h    |  3 ++
 source/include/actbinfo.h    |  2 +
 source/include/actbl2.h      | 10 ++++-
 7 files changed, 129 insertions(+), 52 deletions(-)

diff --git a/source/common/dmtbdump2.c b/source/common/dmtbdump2.c
index 9fa8ef216..e9af48513 100644
--- a/source/common/dmtbdump2.c
+++ b/source/common/dmtbdump2.c
@@ -965,8 +965,12 @@ AcpiDmDumpMadt (
 
         case ACPI_MADT_TYPE_GENERIC_INTERRUPT:
 
-            InfoTable = Revision > 5 ? AcpiDmTableInfoMadt11a :
-				AcpiDmTableInfoMadt11;
+	    if (Revision > 6)
+                    InfoTable = AcpiDmTableInfoMadt11b;
+	    else if (Revision == 6)
+                    InfoTable = AcpiDmTableInfoMadt11a;
+	    else
+                    InfoTable = AcpiDmTableInfoMadt11;
             break;
 
         case ACPI_MADT_TYPE_GENERIC_DISTRIBUTOR:
@@ -981,12 +985,14 @@ AcpiDmDumpMadt (
 
         case ACPI_MADT_TYPE_GENERIC_REDISTRIBUTOR:
 
-            InfoTable = AcpiDmTableInfoMadt14;
+            InfoTable = Revision > 6 ? AcpiDmTableInfoMadt14a :
+				AcpiDmTableInfoMadt14;
             break;
 
         case ACPI_MADT_TYPE_GENERIC_TRANSLATOR:
 
-            InfoTable = AcpiDmTableInfoMadt15;
+            InfoTable = Revision > 6 ? AcpiDmTableInfoMadt15a :
+				AcpiDmTableInfoMadt15;
             break;
 
         case ACPI_MADT_TYPE_MULTIPROC_WAKEUP:
diff --git a/source/common/dmtbinfo2.c b/source/common/dmtbinfo2.c
index 6f606d99f..91c783188 100644
--- a/source/common/dmtbinfo2.c
+++ b/source/common/dmtbinfo2.c
@@ -894,6 +894,35 @@ ACPI_DMTABLE_INFO           AcpiDmTableInfoMadt11a[] =
     ACPI_DMT_TERMINATOR
 };
 
+/* 11: Generic Interrupt Controller (ACPI 5.0) - MADT revision 7 */
+
+ACPI_DMTABLE_INFO           AcpiDmTableInfoMadt11b[] =
+{
+    {ACPI_DMT_UINT16,   ACPI_MADT11_OFFSET (Reserved),              "Reserved", 0},
+    {ACPI_DMT_UINT32,   ACPI_MADT11_OFFSET (CpuInterfaceNumber),    "CPU Interface Number", 0},
+    {ACPI_DMT_UINT32,   ACPI_MADT11_OFFSET (Uid),                   "Processor UID", 0},
+    {ACPI_DMT_UINT32,   ACPI_MADT11_OFFSET (Flags),                 "Flags (decoded below)", DT_FLAG},
+    {ACPI_DMT_FLAG0,    ACPI_MADT11_FLAG_OFFSET (Flags,0),          "Processor Enabled", 0},
+    {ACPI_DMT_FLAG1,    ACPI_MADT11_FLAG_OFFSET (Flags,0),          "Performance Interrupt Trigger Mode", 0},
+    {ACPI_DMT_FLAG2,    ACPI_MADT11_FLAG_OFFSET (Flags,0),          "Virtual GIC Interrupt Trigger Mode", 0},
+    {ACPI_DMT_FLAG3,    ACPI_MADT11_FLAG_OFFSET (Flags,0),          "Online Capable", 0},
+    {ACPI_DMT_FLAG4,    ACPI_MADT11_FLAG_OFFSET (Flags,0),          "GICR non-coherent", 0},
+    {ACPI_DMT_UINT32,   ACPI_MADT11_OFFSET (ParkingVersion),        "Parking Protocol Version", 0},
+    {ACPI_DMT_UINT32,   ACPI_MADT11_OFFSET (PerformanceInterrupt),  "Performance Interrupt", 0},
+    {ACPI_DMT_UINT64,   ACPI_MADT11_OFFSET (ParkedAddress),         "Parked Address", 0},
+    {ACPI_DMT_UINT64,   ACPI_MADT11_OFFSET (BaseAddress),           "Base Address", 0},
+    {ACPI_DMT_UINT64,   ACPI_MADT11_OFFSET (GicvBaseAddress),       "Virtual GIC Base Address", 0},
+    {ACPI_DMT_UINT64,   ACPI_MADT11_OFFSET (GichBaseAddress),       "Hypervisor GIC Base Address", 0},
+    {ACPI_DMT_UINT32,   ACPI_MADT11_OFFSET (VgicInterrupt),         "Virtual GIC Interrupt", 0},
+    {ACPI_DMT_UINT64,   ACPI_MADT11_OFFSET (GicrBaseAddress),       "Redistributor Base Address", 0},
+    {ACPI_DMT_UINT64,   ACPI_MADT11_OFFSET (ArmMpidr),              "ARM MPIDR", 0},
+    {ACPI_DMT_UINT8,    ACPI_MADT11_OFFSET (EfficiencyClass),       "Efficiency Class", 0},
+    {ACPI_DMT_UINT8,    ACPI_MADT11_OFFSET (Reserved2[0]),          "Reserved", 0},
+    {ACPI_DMT_UINT16,   ACPI_MADT11_OFFSET (SpeInterrupt),          "SPE Overflow Interrupt", 0},
+    {ACPI_DMT_UINT16,   ACPI_MADT11_OFFSET (TrbeInterrupt),         "TRBE Interrupt", 0},
+    ACPI_DMT_TERMINATOR
+};
+
 /* 12: Generic Interrupt Distributor (ACPI 5.0) */
 
 ACPI_DMTABLE_INFO           AcpiDmTableInfoMadt12[] =
@@ -931,6 +960,18 @@ ACPI_DMTABLE_INFO           AcpiDmTableInfoMadt14[] =
    ACPI_DMT_TERMINATOR
 };
 
+/* 14: Generic Redistributor (ACPI 5.1) */
+
+ACPI_DMTABLE_INFO           AcpiDmTableInfoMadt14a[] =
+{
+    {ACPI_DMT_UINT8,    ACPI_MADT14_OFFSET (Flags),                 "Flags (decoded below)", DT_FLAG},
+    {ACPI_DMT_FLAG0,    ACPI_MADT14_FLAG_OFFSET (Flags,0),          "GICR non-coherent", 0},
+    {ACPI_DMT_UINT8,    ACPI_MADT14_OFFSET (Reserved),              "Reserved", 0},
+    {ACPI_DMT_UINT64,   ACPI_MADT14_OFFSET (BaseAddress),           "Base Address", 0},
+    {ACPI_DMT_UINT32,   ACPI_MADT14_OFFSET (Length),                "Length", 0},
+   ACPI_DMT_TERMINATOR
+};
+
 /* 15: Generic Translator (ACPI 6.0) */
 
 ACPI_DMTABLE_INFO           AcpiDmTableInfoMadt15[] =
@@ -942,6 +983,17 @@ ACPI_DMTABLE_INFO           AcpiDmTableInfoMadt15[] =
    ACPI_DMT_TERMINATOR
 };
 
+ACPI_DMTABLE_INFO           AcpiDmTableInfoMadt15a[] =
+{
+    {ACPI_DMT_UINT8,    ACPI_MADT15_OFFSET (Flags),                 "Flags (decoded below)", DT_FLAG},
+    {ACPI_DMT_FLAG0,    ACPI_MADT15_FLAG_OFFSET (Flags,0),          "GIC ITS non-coherent", 0},
+    {ACPI_DMT_UINT8,    ACPI_MADT15_OFFSET (Reserved),              "Reserved", 0},
+    {ACPI_DMT_UINT32,   ACPI_MADT15_OFFSET (TranslationId),         "Translation ID", 0},
+    {ACPI_DMT_UINT64,   ACPI_MADT15_OFFSET (BaseAddress),           "Base Address", 0},
+    {ACPI_DMT_UINT32,   ACPI_MADT15_OFFSET (Reserved2),             "Reserved", 0},
+   ACPI_DMT_TERMINATOR
+};
+
 /* 16: Multiprocessor wakeup structure (ACPI 6.4) */
 
 ACPI_DMTABLE_INFO           AcpiDmTableInfoMadt16[] =
diff --git a/source/compiler/dttable2.c b/source/compiler/dttable2.c
index 6b791532e..2aeea5b07 100644
--- a/source/compiler/dttable2.c
+++ b/source/compiler/dttable2.c
@@ -348,8 +348,12 @@ DtCompileMadt (
 
         case ACPI_MADT_TYPE_GENERIC_INTERRUPT:
 
-            InfoTable = Revision > 5 ? AcpiDmTableInfoMadt11a
-                                     : AcpiDmTableInfoMadt11;
+            if (Revision > 6)
+                    InfoTable = AcpiDmTableInfoMadt11b;
+            else if (Revision == 6)
+                    InfoTable = AcpiDmTableInfoMadt11a;
+            else
+                    InfoTable = AcpiDmTableInfoMadt11;
             break;
 
         case ACPI_MADT_TYPE_GENERIC_DISTRIBUTOR:
@@ -364,12 +368,15 @@ DtCompileMadt (
 
         case ACPI_MADT_TYPE_GENERIC_REDISTRIBUTOR:
 
-            InfoTable = AcpiDmTableInfoMadt14;
+            InfoTable = Revision > 6 ? AcpiDmTableInfoMadt14a
+                                     : AcpiDmTableInfoMadt14;
             break;
 
         case ACPI_MADT_TYPE_GENERIC_TRANSLATOR:
 
-            InfoTable = AcpiDmTableInfoMadt15;
+            InfoTable = Revision > 6 ? AcpiDmTableInfoMadt15a
+                                     : AcpiDmTableInfoMadt15;
+
             break;
 
         case ACPI_MADT_TYPE_MULTIPROC_WAKEUP:
diff --git a/source/compiler/dttemplate.h b/source/compiler/dttemplate.h
index d124e9c64..37b600431 100644
--- a/source/compiler/dttemplate.h
+++ b/source/compiler/dttemplate.h
@@ -1128,11 +1128,11 @@ const unsigned char TemplateLpit[] =
 
 const unsigned char TemplateMadt[] =
 {
-    0x41,0x50,0x49,0x43,0x60,0x02,0x00,0x00,  /* 00000000    "APIC...." */
-    0x05,0x69,0x49,0x4E,0x54,0x45,0x4C,0x20,  /* 00000008    "..INTEL " */
+    0x41,0x50,0x49,0x43,0x62,0x02,0x00,0x00,  /* 00000000    "APICb..." */
+    0x07,0x44,0x49,0x4E,0x54,0x45,0x4C,0x20,  /* 00000008    ".DINTEL " */
     0x54,0x65,0x6D,0x70,0x6C,0x61,0x74,0x65,  /* 00000010    "Template" */
     0x01,0x00,0x00,0x00,0x49,0x4E,0x54,0x4C,  /* 00000018    "....INTL" */
-    0x31,0x03,0x22,0x20,0x00,0x00,0x00,0x00,  /* 00000020    "1." ...." */
+    0x28,0x06,0x23,0x20,0x00,0x00,0x00,0x00,  /* 00000020    "(.# ...." */
     0x01,0x00,0x00,0x00,0x00,0x08,0x00,0x00,  /* 00000028    "........" */
     0x01,0x00,0x00,0x00,0x01,0x0C,0x01,0x00,  /* 00000030    "........" */
     0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,  /* 00000038    "........" */
@@ -1150,7 +1150,7 @@ const unsigned char TemplateMadt[] =
     0x00,0x00,0x09,0x10,0x00,0x00,0x00,0x00,  /* 00000098    "........" */
     0x00,0x00,0x01,0x00,0x00,0x00,0x00,0x00,  /* 000000A0    "........" */
     0x00,0x00,0x0A,0x0C,0x05,0x00,0x00,0x00,  /* 000000A8    "........" */
-    0x00,0x00,0x00,0x00,0x00,0x00,0x0B,0x50,  /* 000000B0    ".......P" */
+    0x00,0x00,0x00,0x00,0x00,0x00,0x0B,0x52,  /* 000000B0    ".......R" */
     0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,  /* 000000B8    "........" */
     0x00,0x00,0x01,0x00,0x00,0x00,0x00,0x00,  /* 000000C0    "........" */
     0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,  /* 000000C8    "........" */
@@ -1161,49 +1161,50 @@ const unsigned char TemplateMadt[] =
     0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,  /* 000000F0    "........" */
     0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,  /* 000000F8    "........" */
     0x00,0x00,0x00,0x00,0x00,0x00,0x0C,0x18,  /* 00000100    "........" */
-    0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,  /* 00000108    "........" */
+    0x0C,0x18,0x00,0x00,0x00,0x00,0x00,0x00,  /* 00000108    "........" */
     0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,  /* 00000110    "........" */
-    0x00,0x00,0x01,0x00,0x00,0x00,0x0D,0x18,  /* 00000118    "........" */
-    0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,  /* 00000120    "........" */
-    0x00,0x00,0x00,0x00,0x00,0x00,0x01,0x00,  /* 00000128    "........" */
-    0x00,0x00,0x00,0x00,0x00,0x00,0x0E,0x10,  /* 00000130    "........" */
-    0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,  /* 00000138    "........" */
-    0x00,0x00,0x00,0x00,0x00,0x00,0x0F,0x14,  /* 00000140    "........" */
-    0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,  /* 00000148    "........" */
+    0x00,0x00,0x00,0x00,0x01,0x00,0x00,0x00,  /* 00000118    "........" */
+    0x0D,0x18,0x00,0x00,0x00,0x00,0x00,0x00,  /* 00000120    "........" */
+    0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,  /* 00000128    "........" */
+    0x01,0x00,0x00,0x00,0x00,0x00,0x00,0x00,  /* 00000130    "........" */
+    0x0E,0x10,0x00,0x00,0x00,0x00,0x00,0x00,  /* 00000138    "........" */
+    0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,  /* 00000140    "........" */
+    0x0F,0x14,0x00,0x00,0x00,0x00,0x00,0x00,  /* 00000148    "........" */
     0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,  /* 00000150    "........" */
-    0x00,0x00,0x10,0x10,0x00,0x00,0x00,0x00,  /* 00000158    "........" */
+    0x00,0x00,0x00,0x00,0x10,0x10,0x00,0x00,  /* 00000158    "........" */
     0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,  /* 00000160    "........" */
-    0x00,0x00,0x11,0x0F,0x01,0x01,0x00,0x00,  /* 00000168    "........" */
-    0x00,0x00,0x00,0x00,0x00,0x01,0x00,0x00,  /* 00000170    "........" */
-    0x00,0x12,0x17,0x01,0x00,0x14,0xE0,0x1F,  /* 00000178    "........" */
-    0x00,0x00,0x00,0x00,0x80,0x00,0x02,0x03,  /* 00000180    "........" */
-    0xFF,0xFF,0xFF,0x00,0x00,0x00,0x00,0xFF,  /* 00000188    "........" */
-    0x13,0x15,0x01,0x80,0x00,0x00,0xFB,0xFD,  /* 00000190    "........" */
-    0x0E,0x00,0x00,0x40,0x00,0x00,0x00,0x00,  /* 00000198    "...@...." */
-    0xFF,0x00,0x00,0x00,0x00,0x14,0x0D,0x01,  /* 000001A0    "........" */
-    0x03,0x00,0x00,0x00,0x00,0x00,0x00,0x00,  /* 000001A8    "........" */
-    0x00,0x00,0x15,0x13,0x01,0x00,0x00,0xF0,  /* 000001B0    "........" */
-    0x2F,0x00,0x00,0x00,0x00,0x40,0x00,0x00,  /* 000001B8    "/....@.." */
-    0x00,0xC0,0x00,0x00,0x00,0x16,0x11,0x01,  /* 000001C0    "........" */
-    0x00,0x00,0x00,0x10,0x00,0x00,0x00,0x00,  /* 000001C8    "........" */
-    0x00,0x10,0x00,0x00,0x40,0x00,0x17,0x0E,  /* 000001D0    "....@..." */
-    0x01,0x00,0x20,0x00,0x10,0x00,0x00,0x00,  /* 000001D8    ".. ....." */
-    0x00,0x00,0x10,0x13,0x18,0x24,0x01,0x00,  /* 000001E0    "........" */
-    0x01,0x00,0x00,0x00,0x00,0x00,0x00,0x00,  /* 000001E8    "........" */
+    0x00,0x00,0x00,0x00,0x11,0x0F,0x01,0x01,  /* 00000168    "........" */
+    0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x01,  /* 00000170    "........" */
+    0x00,0x00,0x00,0x12,0x17,0x01,0x00,0x14,  /* 00000178    "........" */
+    0xE0,0x1F,0x00,0x00,0x00,0x00,0x80,0x00,  /* 00000180    "........" */
+    0x02,0x03,0xFF,0xFF,0xFF,0x00,0x00,0x00,  /* 00000188    "........" */
+    0x00,0xFF,0x13,0x15,0x01,0x80,0x00,0x00,  /* 00000190    "........" */
+    0xFB,0xFD,0x0E,0x00,0x00,0x40,0x00,0x00,  /* 00000198    ".....@.." */
+    0x00,0x00,0xFF,0x00,0x00,0x00,0x00,0x14,  /* 000001A0    "........" */
+    0x0D,0x01,0x03,0x00,0x00,0x00,0x00,0x00,  /* 000001A8    "........" */
+    0x00,0x00,0x00,0x00,0x15,0x13,0x01,0x00,  /* 000001B0    "........" */
+    0x00,0xF0,0x2F,0x00,0x00,0x00,0x00,0x40,  /* 000001B8    "../....@" */
+    0x00,0x00,0x00,0xC0,0x00,0x00,0x00,0x16,  /* 000001C0    "........" */
+    0x11,0x01,0x00,0x00,0x00,0x10,0x00,0x00,  /* 000001C8    "........" */
+    0x00,0x00,0x00,0x10,0x00,0x00,0x40,0x00,  /* 000001D0    "......@." */
+    0x17,0x0E,0x01,0x00,0x20,0x00,0x10,0x00,  /* 000001D8    ".... ..." */
+    0x00,0x00,0x00,0x00,0x10,0x13,0x18,0x24,  /* 000001E0    ".......$" */
+    0x01,0x00,0x01,0x00,0x00,0x00,0x00,0x00,  /* 000001E8    "........" */
     0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,  /* 000001F0    "........" */
-    0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x28,  /* 000001F8    ".......(" */
-    0x00,0x00,0x00,0x00,0x00,0x10,0x00,0x00,  /* 00000200    "........" */
-    0x19,0x10,0x01,0x00,0x00,0x00,0x00,0x00,  /* 00000208    "........" */
-    0xFF,0x00,0xFF,0x00,0x00,0x00,0x00,0x18,  /* 00000210    "........" */
-    0x1A,0x24,0x01,0x00,0x00,0x00,0x00,0x00,  /* 00000218    ".$......" */
+    0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,  /* 000001F8    "........" */
+    0x00,0x28,0x00,0x00,0x00,0x00,0x00,0x10,  /* 00000200    ".(......" */
+    0x00,0x00,0x19,0x10,0x01,0x00,0x00,0x00,  /* 00000208    "........" */
+    0x00,0x00,0xFF,0x00,0xFF,0x00,0x00,0x00,  /* 00000210    "........" */
+    0x00,0x18,0x1A,0x24,0x01,0x00,0x00,0x00,  /* 00000218    "...$...." */
     0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,  /* 00000220    "........" */
-    0x00,0x00,0x60,0x00,0x00,0x00,0x00,0x00,  /* 00000228    "..`....." */
-    0x00,0x00,0x00,0x0D,0x00,0x00,0x00,0x00,  /* 00000230    "........" */
-    0x00,0x80,0x00,0x00,0x1B,0x24,0x01,0x00,  /* 00000238    ".....$.." */
-    0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,  /* 00000240    "........" */
-    0x60,0x00,0x00,0x00,0x00,0x00,0x00,0x00,  /* 00000248    "`.....`." */
-    0x00,0x00,0x60,0x00,0x00,0x00,0x00,0x0C,  /* 00000250    "..`....." */
-    0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00   /* 00000258    "........" */
+    0x00,0x00,0x00,0x00,0x60,0x00,0x00,0x00,  /* 00000228    "....`..." */
+    0x00,0x00,0x00,0x00,0x00,0x0D,0x00,0x00,  /* 00000230    "........" */
+    0x00,0x00,0x00,0x80,0x00,0x00,0x1B,0x24,  /* 00000238    ".......$" */
+    0x01,0x00,0x00,0x00,0x00,0x00,0x00,0x00,  /* 00000240    "........" */
+    0x00,0x00,0x60,0x00,0x00,0x00,0x00,0x00,  /* 00000248    "..`....." */
+    0x00,0x00,0x00,0x00,0x60,0x00,0x00,0x00,  /* 00000250    "....`..." */
+    0x00,0x0C,0x00,0x00,0x00,0x00,0x00,0x00,  /* 00000258    "........" */
+    0x00,0x00                                 /* 00000260    ".."       */
 };
 
 const unsigned char TemplateMcfg[] =
diff --git a/source/include/acdisasm.h b/source/include/acdisasm.h
index 9b8749a92..b0464b756 100644
--- a/source/include/acdisasm.h
+++ b/source/include/acdisasm.h
@@ -542,10 +542,13 @@ extern ACPI_DMTABLE_INFO        AcpiDmTableInfoMadt9[];
 extern ACPI_DMTABLE_INFO        AcpiDmTableInfoMadt10[];
 extern ACPI_DMTABLE_INFO        AcpiDmTableInfoMadt11[];
 extern ACPI_DMTABLE_INFO        AcpiDmTableInfoMadt11a[];
+extern ACPI_DMTABLE_INFO        AcpiDmTableInfoMadt11b[];
 extern ACPI_DMTABLE_INFO        AcpiDmTableInfoMadt12[];
 extern ACPI_DMTABLE_INFO        AcpiDmTableInfoMadt13[];
 extern ACPI_DMTABLE_INFO        AcpiDmTableInfoMadt14[];
+extern ACPI_DMTABLE_INFO        AcpiDmTableInfoMadt14a[];
 extern ACPI_DMTABLE_INFO        AcpiDmTableInfoMadt15[];
+extern ACPI_DMTABLE_INFO        AcpiDmTableInfoMadt15a[];
 extern ACPI_DMTABLE_INFO        AcpiDmTableInfoMadt16[];
 extern ACPI_DMTABLE_INFO        AcpiDmTableInfoMadt17[];
 extern ACPI_DMTABLE_INFO        AcpiDmTableInfoMadt18[];
diff --git a/source/include/actbinfo.h b/source/include/actbinfo.h
index 55e9dd0ba..973b27722 100644
--- a/source/include/actbinfo.h
+++ b/source/include/actbinfo.h
@@ -487,6 +487,8 @@
 #define ACPI_MADT10_FLAG_OFFSET(f,o)    ACPI_FLAG_OFFSET (ACPI_MADT_LOCAL_X2APIC_NMI,f,o)
 #define ACPI_MADT11_FLAG_OFFSET(f,o)    ACPI_FLAG_OFFSET (ACPI_MADT_GENERIC_INTERRUPT,f,o)
 #define ACPI_MADT13_FLAG_OFFSET(f,o)    ACPI_FLAG_OFFSET (ACPI_MADT_GENERIC_MSI_FRAME,f,o)
+#define ACPI_MADT14_FLAG_OFFSET(f,o)    ACPI_FLAG_OFFSET (ACPI_MADT_GENERIC_REDISTRIBUTOR,f,o)
+#define ACPI_MADT15_FLAG_OFFSET(f,o)    ACPI_FLAG_OFFSET (ACPI_MADT_GENERIC_TRANSLATOR,f,o)
 #define ACPI_MPST0_FLAG_OFFSET(f,o)     ACPI_FLAG_OFFSET (ACPI_MPST_POWER_NODE,f,o)
 #define ACPI_MPST2_FLAG_OFFSET(f,o)     ACPI_FLAG_OFFSET (ACPI_MPST_POWER_DATA,f,o)
 #define ACPI_NFIT0_FLAG_OFFSET(f,o)     ACPI_FLAG_OFFSET (ACPI_NFIT_SYSTEM_ADDRESS,f,o)
diff --git a/source/include/actbl2.h b/source/include/actbl2.h
index cf674c4ac..1d5696d08 100644
--- a/source/include/actbl2.h
+++ b/source/include/actbl2.h
@@ -1327,6 +1327,7 @@ typedef struct acpi_madt_generic_interrupt
 #define ACPI_MADT_PERFORMANCE_IRQ_MODE  (1<<1)  /* 01: Performance Interrupt Mode */
 #define ACPI_MADT_VGIC_IRQ_MODE         (1<<2)  /* 02: VGIC Maintenance Interrupt mode */
 #define ACPI_MADT_GICC_ONLINE_CAPABLE   (1<<3)  /* 03: Processor is online capable  */
+#define ACPI_MADT_GICC_NON_COHERENT     (1<<4)  /* 04: GIC redistributor is not coherent */
 
 /* 12: Generic Distributor (ACPI 5.0 + ACPI 6.0 changes) */
 
@@ -1379,25 +1380,30 @@ typedef struct acpi_madt_generic_msi_frame
 typedef struct acpi_madt_generic_redistributor
 {
     ACPI_SUBTABLE_HEADER    Header;
-    UINT16                  Reserved;           /* reserved - must be zero */
+    UINT8                   Flags;
+    UINT8                   Reserved;           /* reserved - must be zero */
     UINT64                  BaseAddress;
     UINT32                  Length;
 
 } ACPI_MADT_GENERIC_REDISTRIBUTOR;
 
+#define ACPI_MADT_GICR_NON_COHERENT     (1)
 
 /* 15: Generic Translator (ACPI 6.0) */
 
 typedef struct acpi_madt_generic_translator
 {
     ACPI_SUBTABLE_HEADER    Header;
-    UINT16                  Reserved;           /* reserved - must be zero */
+    UINT8                   Flags;
+    UINT8                   Reserved;           /* reserved - must be zero */
     UINT32                  TranslationId;
     UINT64                  BaseAddress;
     UINT32                  Reserved2;
 
 } ACPI_MADT_GENERIC_TRANSLATOR;
 
+#define ACPI_MADT_ITS_NON_COHERENT      (1)
+
 /* 16: Multiprocessor wakeup (ACPI 6.4) */
 
 typedef struct acpi_madt_multiproc_wakeup
-- 
2.34.1

