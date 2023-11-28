Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB782E3F2
	for <acpica-devel@lists.linux.dev>; Tue, 28 Nov 2023 09:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gxJuGN2+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDE85C433C7;
	Tue, 28 Nov 2023 09:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701164470;
	bh=ufTzQK9uhG2oRXDf5dWh0OAGMGXgeFCQ09CLKrbmbXA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gxJuGN2+rYRtFPPbY6zfBwI2laXPVse2c35/m7NU7aZIcVhsdQjlvI92U2NeQgl58
	 QiJr1zk2cJ39GnwcDA+Rw0SMhh5mCm24RoSAvRgtXPIv0bQLJzJ55Tp2dfdV2Gj5Pl
	 FKjEaXDdXXvau9Kp/kCBhKCbS1B0yNdlnPJ9y2JBaSeBjzDgZZPM4/2ibndRWBBHRg
	 VpGD1ZNov5U/i5Sty6OiT4UNlZXnYu/DCJRUTftrNhuuBMtUAc1qRy0PCBtN0Ps9ms
	 WxOT4I8qMCRJ9wX9zJ09tOrM6S8F4szzjYODYy0UQ1F277PoBjKmhbr/45lJ2SHrm3
	 EDRxhDadpKC+A==
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: acpica-devel@lists.linux.dev
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
Subject: [PATCH 1/2] MADT: Add GICC online capable bit handling
Date: Tue, 28 Nov 2023 10:41:01 +0100
Message-Id: <20231128094102.37662-2-lpieralisi@kernel.org>
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

Implement code to handle the GICC online capable bit management
added into ACPI v6.5.

Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
---
 source/common/dmtbdump2.c  |  6 +++++-
 source/common/dmtbinfo2.c  | 28 ++++++++++++++++++++++++++++
 source/compiler/dttable2.c |  8 +++++++-
 source/include/acdisasm.h  |  1 +
 source/include/actbl2.h    |  2 +-
 5 files changed, 42 insertions(+), 3 deletions(-)

diff --git a/source/common/dmtbdump2.c b/source/common/dmtbdump2.c
index 81172b79f..9fa8ef216 100644
--- a/source/common/dmtbdump2.c
+++ b/source/common/dmtbdump2.c
@@ -875,6 +875,7 @@ AcpiDmDumpMadt (
     UINT32                  Length = Table->Length;
     UINT32                  Offset = sizeof (ACPI_TABLE_MADT);
     ACPI_DMTABLE_INFO       *InfoTable;
+    UINT8                   Revision;
 
 
     /* Main table */
@@ -885,6 +886,8 @@ AcpiDmDumpMadt (
         return;
     }
 
+    Revision = Table->Revision;
+
     /* Subtables */
 
     Subtable = ACPI_ADD_PTR (ACPI_SUBTABLE_HEADER, Table, Offset);
@@ -962,7 +965,8 @@ AcpiDmDumpMadt (
 
         case ACPI_MADT_TYPE_GENERIC_INTERRUPT:
 
-            InfoTable = AcpiDmTableInfoMadt11;
+            InfoTable = Revision > 5 ? AcpiDmTableInfoMadt11a :
+				AcpiDmTableInfoMadt11;
             break;
 
         case ACPI_MADT_TYPE_GENERIC_DISTRIBUTOR:
diff --git a/source/common/dmtbinfo2.c b/source/common/dmtbinfo2.c
index afcfcdc14..6f606d99f 100644
--- a/source/common/dmtbinfo2.c
+++ b/source/common/dmtbinfo2.c
@@ -866,6 +866,34 @@ ACPI_DMTABLE_INFO           AcpiDmTableInfoMadt11[] =
     ACPI_DMT_TERMINATOR
 };
 
+/* 11: Generic Interrupt Controller (ACPI 5.0) - MADT revision 6 */
+
+ACPI_DMTABLE_INFO           AcpiDmTableInfoMadt11a[] =
+{
+    {ACPI_DMT_UINT16,   ACPI_MADT11_OFFSET (Reserved),              "Reserved", 0},
+    {ACPI_DMT_UINT32,   ACPI_MADT11_OFFSET (CpuInterfaceNumber),    "CPU Interface Number", 0},
+    {ACPI_DMT_UINT32,   ACPI_MADT11_OFFSET (Uid),                   "Processor UID", 0},
+    {ACPI_DMT_UINT32,   ACPI_MADT11_OFFSET (Flags),                 "Flags (decoded below)", DT_FLAG},
+    {ACPI_DMT_FLAG0,    ACPI_MADT11_FLAG_OFFSET (Flags,0),          "Processor Enabled", 0},
+    {ACPI_DMT_FLAG1,    ACPI_MADT11_FLAG_OFFSET (Flags,0),          "Performance Interrupt Trigger Mode", 0},
+    {ACPI_DMT_FLAG2,    ACPI_MADT11_FLAG_OFFSET (Flags,0),          "Virtual GIC Interrupt Trigger Mode", 0},
+    {ACPI_DMT_FLAG3,    ACPI_MADT11_FLAG_OFFSET (Flags,0),          "Online Capable", 0},
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
diff --git a/source/compiler/dttable2.c b/source/compiler/dttable2.c
index ec01dceae..6b791532e 100644
--- a/source/compiler/dttable2.c
+++ b/source/compiler/dttable2.c
@@ -254,8 +254,10 @@ DtCompileMadt (
     DT_SUBTABLE             *ParentTable;
     DT_FIELD                **PFieldList = (DT_FIELD **) List;
     DT_FIELD                *SubtableStart;
+    ACPI_TABLE_HEADER       *Table;
     ACPI_SUBTABLE_HEADER    *MadtHeader;
     ACPI_DMTABLE_INFO       *InfoTable;
+    UINT8                   Revision;
 
 
     Status = DtCompileTable (PFieldList, AcpiDmTableInfoMadt,
@@ -268,6 +270,9 @@ DtCompileMadt (
     ParentTable = DtPeekSubtable ();
     DtInsertSubtable (ParentTable, Subtable);
 
+    Table = ACPI_CAST_PTR (ACPI_TABLE_HEADER, ParentTable->Buffer);
+    Revision = Table->Revision;
+
     while (*PFieldList)
     {
         SubtableStart = *PFieldList;
@@ -343,7 +348,8 @@ DtCompileMadt (
 
         case ACPI_MADT_TYPE_GENERIC_INTERRUPT:
 
-            InfoTable = AcpiDmTableInfoMadt11;
+            InfoTable = Revision > 5 ? AcpiDmTableInfoMadt11a
+                                     : AcpiDmTableInfoMadt11;
             break;
 
         case ACPI_MADT_TYPE_GENERIC_DISTRIBUTOR:
diff --git a/source/include/acdisasm.h b/source/include/acdisasm.h
index 467209428..9b8749a92 100644
--- a/source/include/acdisasm.h
+++ b/source/include/acdisasm.h
@@ -541,6 +541,7 @@ extern ACPI_DMTABLE_INFO        AcpiDmTableInfoMadt8[];
 extern ACPI_DMTABLE_INFO        AcpiDmTableInfoMadt9[];
 extern ACPI_DMTABLE_INFO        AcpiDmTableInfoMadt10[];
 extern ACPI_DMTABLE_INFO        AcpiDmTableInfoMadt11[];
+extern ACPI_DMTABLE_INFO        AcpiDmTableInfoMadt11a[];
 extern ACPI_DMTABLE_INFO        AcpiDmTableInfoMadt12[];
 extern ACPI_DMTABLE_INFO        AcpiDmTableInfoMadt13[];
 extern ACPI_DMTABLE_INFO        AcpiDmTableInfoMadt14[];
diff --git a/source/include/actbl2.h b/source/include/actbl2.h
index 3d1d91e9e..cf674c4ac 100644
--- a/source/include/actbl2.h
+++ b/source/include/actbl2.h
@@ -1326,7 +1326,7 @@ typedef struct acpi_madt_generic_interrupt
 /* ACPI_MADT_ENABLED                    (1)      Processor is usable if set */
 #define ACPI_MADT_PERFORMANCE_IRQ_MODE  (1<<1)  /* 01: Performance Interrupt Mode */
 #define ACPI_MADT_VGIC_IRQ_MODE         (1<<2)  /* 02: VGIC Maintenance Interrupt mode */
-
+#define ACPI_MADT_GICC_ONLINE_CAPABLE   (1<<3)  /* 03: Processor is online capable  */
 
 /* 12: Generic Distributor (ACPI 5.0 + ACPI 6.0 changes) */
 
-- 
2.34.1

