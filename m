Content-Type: multipart/mixed; boundary="===============8056758116738845577=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: [Devel] Re: [PATCH 3/3] ACPICA: Events: Support fixed pcie wake event
Date: Wed, 14 Jul 2021 14:51:40 +0000
Message-ID: <BYAPR11MB3256FDB80037FF91B35B2A2587139@BYAPR11MB3256.namprd11.prod.outlook.com>
In-Reply-To: 20210705130549.1232418-1-chenhuacai@loongson.cn
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============8056758116738845577==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

We'll probably take this patch.

Rafael, does this look OK?
thanks,
Bob


-----Original Message-----
From: Huacai Chen <chenhuacai(a)loongson.cn> =

Sent: Monday, July 05, 2021 6:06 AM
To: Rafael J . Wysocki <rjw(a)rjwysocki.net>; Len Brown <lenb(a)kernel.org>=
; Moore, Robert <robert.moore(a)intel.com>; Erik Kaneda <erik.kaneda(a)inte=
l.com>
Cc: linux-acpi(a)vger.kernel.org; devel(a)acpica.org; Xuefeng Li <lixuefeng=
(a)loongson.cn>; Jiaxun Yang <jiaxun.yang(a)flygoat.com>; Huacai Chen <chen=
huacai(a)loongson.cn>; Jianmin Lv <lvjianmin(a)loongson.cn>
Subject: [PATCH 3/3] ACPICA: Events: Support fixed pcie wake event

Some chipsets (such as Loongson's LS7A) support fixed pcie wake event which=
 is defined in the PM1 block(related description can be found in
4.8.4.1.1 PM1 Status Registers, 4.8.4.2.1 PM1 Control Registers and
5.2.9 Fixed ACPI Description Table (FADT)), so we add code to handle it.

ACPI Spec 6.4 link:
https://uefi.org/specifications/ACPI/6.4/

Signed-off-by: Jianmin Lv <lvjianmin(a)loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai(a)loongson.cn>
---
 drivers/acpi/acpica/evevent.c  | 17 +++++++++++------  drivers/acpi/acpica=
/hwsleep.c  | 12 ++++++++++++  drivers/acpi/acpica/utglobal.c |  4 ++++
 include/acpi/actypes.h         |  3 ++-
 4 files changed, 29 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/acpica/evevent.c b/drivers/acpi/acpica/evevent.c =
index 35385148fedb..2340986de37b 100644
--- a/drivers/acpi/acpica/evevent.c
+++ b/drivers/acpi/acpica/evevent.c
@@ -140,9 +140,9 @@ static acpi_status acpi_ev_fixed_event_initialize(void)
 =

 		if (acpi_gbl_fixed_event_info[i].enable_register_id !=3D 0xFF) {
 			status =3D
-			    acpi_write_bit_register(acpi_gbl_fixed_event_info
-						    [i].enable_register_id,
-						    ACPI_DISABLE_EVENT);
+			    acpi_write_bit_register(acpi_gbl_fixed_event_info[i].enable_registe=
r_id,
+						    (i =3D=3D ACPI_EVENT_PCIE_WAKE) ?
+						    ACPI_ENABLE_EVENT : ACPI_DISABLE_EVENT);
 			if (ACPI_FAILURE(status)) {
 				return (status);
 			}
@@ -185,6 +185,11 @@ u32 acpi_ev_fixed_event_detect(void)
 		return (int_status);
 	}
 =

+	if (fixed_enable & ACPI_BITMASK_PCIEXP_WAKE_DISABLE)
+		fixed_enable &=3D ~ACPI_BITMASK_PCIEXP_WAKE_DISABLE;
+	else
+		fixed_enable |=3D ACPI_BITMASK_PCIEXP_WAKE_DISABLE;
+
 	ACPI_DEBUG_PRINT((ACPI_DB_INTERRUPTS,
 			  "Fixed Event Block: Enable %08X Status %08X\n",
 			  fixed_enable, fixed_status));
@@ -248,9 +253,9 @@ static u32 acpi_ev_fixed_event_dispatch(u32 event)
 	 * and disable the event to prevent further interrupts.
 	 */
 	if (!acpi_gbl_fixed_event_handlers[event].handler) {
-		(void)acpi_write_bit_register(acpi_gbl_fixed_event_info[event].
-					      enable_register_id,
-					      ACPI_DISABLE_EVENT);
+		(void)acpi_write_bit_register(acpi_gbl_fixed_event_info[event].enable_re=
gister_id,
+					      event =3D=3D ACPI_EVENT_PCIE_WAKE ?
+					      ACPI_ENABLE_EVENT : ACPI_DISABLE_EVENT);
 =

 		ACPI_ERROR((AE_INFO,
 			    "No installed handler for fixed event - %s (%u), disabling", diff -=
-git a/drivers/acpi/acpica/hwsleep.c b/drivers/acpi/acpica/hwsleep.c index =
14baa13bf848..7e7ea4c2e914 100644
--- a/drivers/acpi/acpica/hwsleep.c
+++ b/drivers/acpi/acpica/hwsleep.c
@@ -312,6 +312,18 @@ acpi_status acpi_hw_legacy_wake(u8 sleep_state)
 				    [ACPI_EVENT_SLEEP_BUTTON].
 				    status_register_id, ACPI_CLEAR_STATUS);
 =

+	/* Enable pcie wake event if support */
+	if ((acpi_gbl_FADT.flags & ACPI_FADT_PCI_EXPRESS_WAKE)) {
+		(void)
+		acpi_write_bit_register(acpi_gbl_fixed_event_info
+				[ACPI_EVENT_PCIE_WAKE].
+				enable_register_id, ACPI_DISABLE_EVENT);
+		(void)
+		acpi_write_bit_register(acpi_gbl_fixed_event_info
+				[ACPI_EVENT_PCIE_WAKE].
+				status_register_id, ACPI_CLEAR_STATUS);
+	}
+
 	acpi_hw_execute_sleep_method(METHOD_PATHNAME__SST, ACPI_SST_WORKING);
 	return_ACPI_STATUS(status);
 }
diff --git a/drivers/acpi/acpica/utglobal.c b/drivers/acpi/acpica/utglobal.=
c index 59a48371a7bc..16f7a206fc6d 100644
--- a/drivers/acpi/acpica/utglobal.c
+++ b/drivers/acpi/acpica/utglobal.c
@@ -186,6 +186,10 @@ struct acpi_fixed_event_info acpi_gbl_fixed_event_info=
[ACPI_NUM_FIXED_EVENTS] =3D
 					ACPI_BITREG_RT_CLOCK_ENABLE,
 					ACPI_BITMASK_RT_CLOCK_STATUS,
 					ACPI_BITMASK_RT_CLOCK_ENABLE},
+	/* ACPI_EVENT_PCIE_WAKE	    */ {ACPI_BITREG_PCIEXP_WAKE_STATUS,
+					ACPI_BITREG_PCIEXP_WAKE_DISABLE,
+					ACPI_BITMASK_PCIEXP_WAKE_STATUS,
+					ACPI_BITMASK_PCIEXP_WAKE_DISABLE},
 };
 #endif				/* !ACPI_REDUCED_HARDWARE */
 =

diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h index 92c71dfc=
e0d5..0b6c72033487 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -714,7 +714,8 @@ typedef u32 acpi_event_type;
 #define ACPI_EVENT_POWER_BUTTON         2
 #define ACPI_EVENT_SLEEP_BUTTON         3
 #define ACPI_EVENT_RTC                  4
-#define ACPI_EVENT_MAX                  4
+#define ACPI_EVENT_PCIE_WAKE            5
+#define ACPI_EVENT_MAX                  5
 #define ACPI_NUM_FIXED_EVENTS           ACPI_EVENT_MAX + 1
 =

 /*
--
2.27.0

--===============8056758116738845577==--

