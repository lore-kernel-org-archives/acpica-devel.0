Content-Type: multipart/mixed; boundary="===============0010730157654490913=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: [Devel] Re: [PATCH] ACPICA: Events: support fixed pcie wake event
Date: Thu, 01 Apr 2021 20:56:32 +0000
Message-ID: <BYAPR11MB3256C7F3C17D14C1DF544430877B9@BYAPR11MB3256.namprd11.prod.outlook.com>
In-Reply-To: 1617278736-7400-1-git-send-email-lvjianmin@loongson.cn
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============0010730157654490913==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Can you send/point us to the spec that this change is based upon?
Thanks,
Bob


-----Original Message-----
From: Jianmin Lv <lvjianmin(a)loongson.cn> =

Sent: Thursday, April 01, 2021 5:06 AM
To: Moore, Robert <robert.moore(a)intel.com>; Kaneda, Erik <erik.kaneda(a)i=
ntel.com>; Wysocki, Rafael J <rafael.j.wysocki(a)intel.com>; Len Brown <len=
b(a)kernel.org>
Cc: linux-acpi(a)vger.kernel.org; devel(a)acpica.org; linux-kernel(a)vger.k=
ernel.org; lvjianmin <lvjianmin(a)loongson.cn>
Subject: [PATCH] ACPICA: Events: support fixed pcie wake event

From: lvjianmin <lvjianmin(a)loongson.cn>

Some chipsets support fixed pcie wake event which is defined in the PM1 blo=
ck, such as LS7A1000 of Loongson company, so we add code to handle it.

Signed-off-by: lvjianmin <lvjianmin(a)loongson.cn>

diff --git a/drivers/acpi/acpica/evevent.c b/drivers/acpi/acpica/evevent.c =
index 35385148fedb..08ba368beb2d 100644
--- a/drivers/acpi/acpica/evevent.c
+++ b/drivers/acpi/acpica/evevent.c
@@ -185,6 +185,10 @@ u32 acpi_ev_fixed_event_detect(void)
 		return (int_status);
 	}
 =

+	if (fixed_enable & ACPI_BITMASK_PCIEXP_WAKE_DISABLE)
+		fixed_enable &=3D ~ACPI_BITMASK_PCIEXP_WAKE_DISABLE;
+	else
+		fixed_enable |=3D ACPI_BITMASK_PCIEXP_WAKE_DISABLE;
 	ACPI_DEBUG_PRINT((ACPI_DB_INTERRUPTS,
 			  "Fixed Event Block: Enable %08X Status %08X\n",
 			  fixed_enable, fixed_status));
@@ -250,8 +254,8 @@ static u32 acpi_ev_fixed_event_dispatch(u32 event)
 	if (!acpi_gbl_fixed_event_handlers[event].handler) {
 		(void)acpi_write_bit_register(acpi_gbl_fixed_event_info[event].
 					      enable_register_id,
-					      ACPI_DISABLE_EVENT);
-
+						event =3D=3D ACPI_EVENT_PCIE_WAKE ?
+						ACPI_ENABLE_EVENT : ACPI_DISABLE_EVENT);
 		ACPI_ERROR((AE_INFO,
 			    "No installed handler for fixed event - %s (%u), disabling",
 			    acpi_ut_get_event_name(event), event)); diff --git a/drivers/acpi/a=
cpica/hwsleep.c b/drivers/acpi/acpica/hwsleep.c index 14baa13bf848..7e7ea4c=
2e914 100644
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
c index 59a48371a7bc..68baf16d8a02 100644
--- a/drivers/acpi/acpica/utglobal.c
+++ b/drivers/acpi/acpica/utglobal.c
@@ -186,6 +186,10 @@ struct acpi_fixed_event_info acpi_gbl_fixed_event_info=
[ACPI_NUM_FIXED_EVENTS] =3D
 					ACPI_BITREG_RT_CLOCK_ENABLE,
 					ACPI_BITMASK_RT_CLOCK_STATUS,
 					ACPI_BITMASK_RT_CLOCK_ENABLE},
+	/* ACPI_EVENT_PCIE_WAKE		*/ {ACPI_BITREG_PCIEXP_WAKE_STATUS,
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

--===============0010730157654490913==--

