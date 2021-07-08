Content-Type: multipart/mixed; boundary="===============8035933488607930416=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: [Devel] Re: [PATCH 2/3] ACPICA: MADT: Add LoongArch APICs support
Date: Thu, 08 Jul 2021 21:35:28 +0000
Message-ID: <BYAPR11MB3256468A574CA349AB8D1F0087199@BYAPR11MB3256.namprd11.prod.outlook.com>
In-Reply-To: 20210705124206.1228958-3-chenhuacai@loongson.cn
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============8035933488607930416==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

For legal reasons, we can't pre-release any upcoming ACPI spec changes in A=
CPICA.

-----Original Message-----
From: Huacai Chen <chenhuacai(a)loongson.cn> =

Sent: Monday, July 05, 2021 5:42 AM
To: Rafael J . Wysocki <rjw(a)rjwysocki.net>; Len Brown <lenb(a)kernel.org>=
; Moore, Robert <robert.moore(a)intel.com>; Erik Kaneda <erik.kaneda(a)inte=
l.com>
Cc: linux-acpi(a)vger.kernel.org; devel(a)acpica.org; Xuefeng Li <lixuefeng=
(a)loongson.cn>; Jiaxun Yang <jiaxun.yang(a)flygoat.com>; Huacai Chen <chen=
huacai(a)loongson.cn>; Jianmin Lv <lvjianmin(a)loongson.cn>
Subject: [PATCH 2/3] ACPICA: MADT: Add LoongArch APICs support

LoongArch-specific interrupt controllers (similar to APIC) are added in the=
 next revision of ACPI Specification (current revision is 6.4), which inclu=
ding CORE_PIC (CPUINTC), LIO_PIC (LIOINTC), EIO_PIC (EIOINTC), HT_PIC (HTVE=
CINTC), BIO_PIC (PCHINTC), LPC_PIC (PCHLPC) and MSI_PIC (PCHMSI). This patc=
h add their definition and handlings.

Reference: https://mantis.uefi.org/mantis/view.php?id=3D2203
Signed-off-by: Jianmin Lv <lvjianmin(a)loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai(a)loongson.cn>
---
 drivers/acpi/tables.c |  10 ++++
 include/acpi/actbl2.h | 123 +++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 132 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c index a37a1532a5=
75..5943ae4f76bb 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -208,6 +208,16 @@ void acpi_table_print_madt_entry(struct acpi_subtable_=
header *header)
 		}
 		break;
 =

+	case ACPI_MADT_TYPE_CORE_PIC:
+		{
+			struct acpi_madt_core_pic *p =3D
+			    (struct acpi_madt_core_pic *)header;
+			pr_debug("CORE PIC (processor_id[0x%02x] core_id[0x%02x] %s)\n",
+				 p->processor_id, p->core_id,
+				 (p->flags & ACPI_MADT_ENABLED) ? "enabled" : "disabled");
+		}
+		break;
+
 	default:
 		pr_warn("Found unsupported MADT entry (type =3D 0x%x)\n",
 			header->type);
diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h index 2069ac38a4=
e2..fd6d0b440c4b 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -571,7 +571,14 @@ enum acpi_madt_type {
 	ACPI_MADT_TYPE_GENERIC_REDISTRIBUTOR =3D 14,
 	ACPI_MADT_TYPE_GENERIC_TRANSLATOR =3D 15,
 	ACPI_MADT_TYPE_MULTIPROC_WAKEUP =3D 16,
-	ACPI_MADT_TYPE_RESERVED =3D 17	/* 17 and greater are reserved */
+	ACPI_MADT_TYPE_CORE_PIC =3D 17,
+	ACPI_MADT_TYPE_LIO_PIC =3D 18,
+	ACPI_MADT_TYPE_HT_PIC =3D 19,
+	ACPI_MADT_TYPE_EIO_PIC =3D 20,
+	ACPI_MADT_TYPE_MSI_PIC =3D 21,
+	ACPI_MADT_TYPE_BIO_PIC =3D 22,
+	ACPI_MADT_TYPE_LPC_PIC =3D 23,
+	ACPI_MADT_TYPE_RESERVED =3D 24	/* 24 and greater are reserved */
 };
 =

 /*
@@ -801,6 +808,120 @@ struct acpi_madt_multiproc_wakeup_mailbox {
 =

 #define ACPI_MP_WAKE_COMMAND_WAKEUP    1
 =

+/* Values for Version field above */
+
+enum acpi_madt_core_pic_version {
+	ACPI_MADT_CORE_PIC_VERSION_NONE =3D 0,
+	ACPI_MADT_CORE_PIC_VERSION_V1 =3D 1,
+	ACPI_MADT_CORE_PIC_VERSION_RESERVED =3D 2	/* 2 and greater are reserved */
+};
+
+enum acpi_madt_lio_pic_version {
+	ACPI_MADT_LIO_PIC_VERSION_NONE =3D 0,
+	ACPI_MADT_LIO_PIC_VERSION_V1 =3D 1,
+	ACPI_MADT_LIO_PIC_VERSION_RESERVED =3D 2	/* 2 and greater are reserved */
+};
+
+enum acpi_madt_eio_pic_version {
+	ACPI_MADT_EIO_PIC_VERSION_NONE =3D 0,
+	ACPI_MADT_EIO_PIC_VERSION_V1 =3D 1,
+	ACPI_MADT_EIO_PIC_VERSION_RESERVED =3D 2	/* 2 and greater are reserved */
+};
+
+enum acpi_madt_ht_pic_version {
+	ACPI_MADT_HT_PIC_VERSION_NONE =3D 0,
+	ACPI_MADT_HT_PIC_VERSION_V1 =3D 1,
+	ACPI_MADT_HT_PIC_VERSION_RESERVED =3D 2	/* 2 and greater are reserved */
+};
+
+enum acpi_madt_bio_pic_version {
+	ACPI_MADT_BIO_PIC_VERSION_NONE =3D 0,
+	ACPI_MADT_BIO_PIC_VERSION_V1 =3D 1,
+	ACPI_MADT_BIO_PIC_VERSION_RESERVED =3D 2	/* 2 and greater are reserved */
+};
+
+enum acpi_madt_msi_pic_version {
+	ACPI_MADT_MSI_PIC_VERSION_NONE =3D 0,
+	ACPI_MADT_MSI_PIC_VERSION_V1 =3D 1,
+	ACPI_MADT_MSI_PIC_VERSION_RESERVED =3D 2	/* 2 and greater are reserved */
+};
+
+enum acpi_madt_lpc_pic_version {
+	ACPI_MADT_LPC_PIC_VERSION_NONE =3D 0,
+	ACPI_MADT_LPC_PIC_VERSION_V1 =3D 1,
+	ACPI_MADT_LPC_PIC_VERSION_RESERVED =3D 2	/* 2 and greater are reserved */
+};
+
+/* Core Interrupt Controller */
+
+struct acpi_madt_core_pic {
+	struct acpi_subtable_header header;
+	u32 processor_id;
+	u32 core_id;
+	u32 flags;
+	u8 version;
+};
+
+/* Legacy I/O Interrupt Controller */
+
+struct acpi_madt_lio_pic {
+	struct acpi_subtable_header header;
+	u64 address;
+	u16 size;
+	u8 cascade[2];
+	u32 cascade_map[2];
+	u8 version;
+};
+
+/* Extend I/O Interrupt Controller */
+
+struct acpi_madt_eio_pic {
+	struct acpi_subtable_header header;
+	u8 cascade;
+	u8 version;
+};
+
+/* HT Interrupt Controller */
+
+struct acpi_madt_ht_pic {
+	struct acpi_subtable_header header;
+	u64 address;
+	u16 size;
+	u8 cascade[8];
+	u8 version;
+};
+
+/* Bridge I/O Interrupt Controller */
+
+struct acpi_madt_bio_pic {
+	struct acpi_subtable_header header;
+	u64 address;
+	u16 size;
+	u16 id;
+	u16 gsi_base;
+	u8 version;
+};
+
+/* MSI Interrupt Controller */
+
+struct acpi_madt_msi_pic {
+	struct acpi_subtable_header header;
+	u64 msg_address;
+	u32 start;
+	u32 count;
+	u8 version;
+};
+
+/* LPC Interrupt Controller */
+
+struct acpi_madt_lpc_pic {
+	struct acpi_subtable_header header;
+	u64 address;
+	u16 size;
+	u8 cascade;
+	u8 version;
+};
+
 /*
  * Common flags fields for MADT subtables
  */
--
2.27.0

--===============8035933488607930416==--

