Content-Type: multipart/mixed; boundary="===============7663561768397748418=="
MIME-Version: 1.0
From: Lv Zheng <lv.zheng at intel.com>
Subject: [Devel] [RFC PATCH] ACPICA: Resources: Provide common part for struct
 acpi_resource_address structures.
Date: Thu, 22 Jan 2015 10:46:00 +0800
Message-ID: <568a2ece839d4fc1df6f466494c5ff110112eee0.1421894417.git.lv.zheng@intel.com>
In-Reply-To: 1420684386-5975-6-git-send-email-jiang.liu@linux.intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============7663561768397748418==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

struct acpi_resource_address and struct acpi_resource_extended_address64 sh=
are substracts
just at different offsets. To unify the parsing functions, OSPMs like Linux
need a new ACPI_ADDRESS64_ATTRIBUTE as their substructs, so they can
extract the shared data.

Original-by: Thomas Gleixner <tglx(a)linutronix.de>
Original-by: Jiang Liu <jiang.liu(a)linux.intel.com>
Signed-off-by: Lv Zheng <lv.zheng(a)intel.com>
---
 drivers/acpi/acpica/rsaddr.c     |    9 +++---
 drivers/acpi/acpica/rsdumpinfo.c |   59 +++++++++++++++++++---------------=
----
 drivers/acpi/acpica/rsxface.c    |   10 +++----
 include/acpi/acrestyp.h          |   40 +++++++++++++++-----------
 4 files changed, 64 insertions(+), 54 deletions(-)

diff --git a/drivers/acpi/acpica/rsaddr.c b/drivers/acpi/acpica/rsaddr.c
index 916fd09..94a3a05 100644
--- a/drivers/acpi/acpica/rsaddr.c
+++ b/drivers/acpi/acpica/rsaddr.c
@@ -74,7 +74,7 @@ struct acpi_rsconvert_info acpi_rs_convert_address16[5] =
=3D {
 	 * Address Translation Offset
 	 * Address Length
 	 */
-	{ACPI_RSC_MOVE16, ACPI_RS_OFFSET(data.address16.granularity),
+	{ACPI_RSC_MOVE16, ACPI_RS_OFFSET(data.address16.address.granularity),
 	 AML_OFFSET(address16.granularity),
 	 5},
 =

@@ -112,7 +112,7 @@ struct acpi_rsconvert_info acpi_rs_convert_address32[5]=
 =3D {
 	 * Address Translation Offset
 	 * Address Length
 	 */
-	{ACPI_RSC_MOVE32, ACPI_RS_OFFSET(data.address32.granularity),
+	{ACPI_RSC_MOVE32, ACPI_RS_OFFSET(data.address32.address.granularity),
 	 AML_OFFSET(address32.granularity),
 	 5},
 =

@@ -150,7 +150,7 @@ struct acpi_rsconvert_info acpi_rs_convert_address64[5]=
 =3D {
 	 * Address Translation Offset
 	 * Address Length
 	 */
-	{ACPI_RSC_MOVE64, ACPI_RS_OFFSET(data.address64.granularity),
+	{ACPI_RSC_MOVE64, ACPI_RS_OFFSET(data.address64.address.granularity),
 	 AML_OFFSET(address64.granularity),
 	 5},
 =

@@ -194,7 +194,8 @@ struct acpi_rsconvert_info acpi_rs_convert_ext_address6=
4[5] =3D {
 	 * Address Length
 	 * Type-Specific Attribute
 	 */
-	{ACPI_RSC_MOVE64, ACPI_RS_OFFSET(data.ext_address64.granularity),
+	{ACPI_RSC_MOVE64,
+	 ACPI_RS_OFFSET(data.ext_address64.address.granularity),
 	 AML_OFFSET(ext_address64.granularity),
 	 6}
 };
diff --git a/drivers/acpi/acpica/rsdumpinfo.c b/drivers/acpi/acpica/rsdumpi=
nfo.c
index 2f9332d..6ba7ad5 100644
--- a/drivers/acpi/acpica/rsdumpinfo.c
+++ b/drivers/acpi/acpica/rsdumpinfo.c
@@ -183,15 +183,15 @@ struct acpi_rsdump_info acpi_rs_dump_address16[8] =3D=
 {
 	{ACPI_RSD_TITLE, ACPI_RSD_TABLE_SIZE(acpi_rs_dump_address16),
 	 "16-Bit WORD Address Space", NULL},
 	{ACPI_RSD_ADDRESS, 0, NULL, NULL},
-	{ACPI_RSD_UINT16, ACPI_RSD_OFFSET(address16.granularity), "Granularity",
-	 NULL},
-	{ACPI_RSD_UINT16, ACPI_RSD_OFFSET(address16.minimum), "Address Minimum",
-	 NULL},
-	{ACPI_RSD_UINT16, ACPI_RSD_OFFSET(address16.maximum), "Address Maximum",
-	 NULL},
-	{ACPI_RSD_UINT16, ACPI_RSD_OFFSET(address16.translation_offset),
+	{ACPI_RSD_UINT16, ACPI_RSD_OFFSET(address16.address.granularity),
+	 "Granularity", NULL},
+	{ACPI_RSD_UINT16, ACPI_RSD_OFFSET(address16.address.minimum),
+	 "Address Minimum", NULL},
+	{ACPI_RSD_UINT16, ACPI_RSD_OFFSET(address16.address.maximum),
+	 "Address Maximum", NULL},
+	{ACPI_RSD_UINT16, ACPI_RSD_OFFSET(address16.address.translation_offset),
 	 "Translation Offset", NULL},
-	{ACPI_RSD_UINT16, ACPI_RSD_OFFSET(address16.address_length),
+	{ACPI_RSD_UINT16, ACPI_RSD_OFFSET(address16.address.address_length),
 	 "Address Length", NULL},
 	{ACPI_RSD_SOURCE, ACPI_RSD_OFFSET(address16.resource_source), NULL, NULL}
 };
@@ -200,15 +200,15 @@ struct acpi_rsdump_info acpi_rs_dump_address32[8] =3D=
 {
 	{ACPI_RSD_TITLE, ACPI_RSD_TABLE_SIZE(acpi_rs_dump_address32),
 	 "32-Bit DWORD Address Space", NULL},
 	{ACPI_RSD_ADDRESS, 0, NULL, NULL},
-	{ACPI_RSD_UINT32, ACPI_RSD_OFFSET(address32.granularity), "Granularity",
-	 NULL},
-	{ACPI_RSD_UINT32, ACPI_RSD_OFFSET(address32.minimum), "Address Minimum",
-	 NULL},
-	{ACPI_RSD_UINT32, ACPI_RSD_OFFSET(address32.maximum), "Address Maximum",
-	 NULL},
-	{ACPI_RSD_UINT32, ACPI_RSD_OFFSET(address32.translation_offset),
+	{ACPI_RSD_UINT32, ACPI_RSD_OFFSET(address32.address.granularity),
+	 "Granularity", NULL},
+	{ACPI_RSD_UINT32, ACPI_RSD_OFFSET(address32.address.minimum),
+	 "Address Minimum", NULL},
+	{ACPI_RSD_UINT32, ACPI_RSD_OFFSET(address32.address.maximum),
+	 "Address Maximum", NULL},
+	{ACPI_RSD_UINT32, ACPI_RSD_OFFSET(address32.address.translation_offset),
 	 "Translation Offset", NULL},
-	{ACPI_RSD_UINT32, ACPI_RSD_OFFSET(address32.address_length),
+	{ACPI_RSD_UINT32, ACPI_RSD_OFFSET(address32.address.address_length),
 	 "Address Length", NULL},
 	{ACPI_RSD_SOURCE, ACPI_RSD_OFFSET(address32.resource_source), NULL, NULL}
 };
@@ -217,15 +217,15 @@ struct acpi_rsdump_info acpi_rs_dump_address64[8] =3D=
 {
 	{ACPI_RSD_TITLE, ACPI_RSD_TABLE_SIZE(acpi_rs_dump_address64),
 	 "64-Bit QWORD Address Space", NULL},
 	{ACPI_RSD_ADDRESS, 0, NULL, NULL},
-	{ACPI_RSD_UINT64, ACPI_RSD_OFFSET(address64.granularity), "Granularity",
-	 NULL},
-	{ACPI_RSD_UINT64, ACPI_RSD_OFFSET(address64.minimum), "Address Minimum",
-	 NULL},
-	{ACPI_RSD_UINT64, ACPI_RSD_OFFSET(address64.maximum), "Address Maximum",
-	 NULL},
-	{ACPI_RSD_UINT64, ACPI_RSD_OFFSET(address64.translation_offset),
+	{ACPI_RSD_UINT64, ACPI_RSD_OFFSET(address64.address.granularity),
+	 "Granularity", NULL},
+	{ACPI_RSD_UINT64, ACPI_RSD_OFFSET(address64.address.minimum),
+	 "Address Minimum", NULL},
+	{ACPI_RSD_UINT64, ACPI_RSD_OFFSET(address64.address.maximum),
+	 "Address Maximum", NULL},
+	{ACPI_RSD_UINT64, ACPI_RSD_OFFSET(address64.address.translation_offset),
 	 "Translation Offset", NULL},
-	{ACPI_RSD_UINT64, ACPI_RSD_OFFSET(address64.address_length),
+	{ACPI_RSD_UINT64, ACPI_RSD_OFFSET(address64.address.address_length),
 	 "Address Length", NULL},
 	{ACPI_RSD_SOURCE, ACPI_RSD_OFFSET(address64.resource_source), NULL, NULL}
 };
@@ -234,15 +234,16 @@ struct acpi_rsdump_info acpi_rs_dump_ext_address64[8]=
 =3D {
 	{ACPI_RSD_TITLE, ACPI_RSD_TABLE_SIZE(acpi_rs_dump_ext_address64),
 	 "64-Bit Extended Address Space", NULL},
 	{ACPI_RSD_ADDRESS, 0, NULL, NULL},
-	{ACPI_RSD_UINT64, ACPI_RSD_OFFSET(ext_address64.granularity),
+	{ACPI_RSD_UINT64, ACPI_RSD_OFFSET(ext_address64.address.granularity),
 	 "Granularity", NULL},
-	{ACPI_RSD_UINT64, ACPI_RSD_OFFSET(ext_address64.minimum),
+	{ACPI_RSD_UINT64, ACPI_RSD_OFFSET(ext_address64.address.minimum),
 	 "Address Minimum", NULL},
-	{ACPI_RSD_UINT64, ACPI_RSD_OFFSET(ext_address64.maximum),
+	{ACPI_RSD_UINT64, ACPI_RSD_OFFSET(ext_address64.address.maximum),
 	 "Address Maximum", NULL},
-	{ACPI_RSD_UINT64, ACPI_RSD_OFFSET(ext_address64.translation_offset),
+	{ACPI_RSD_UINT64,
+	 ACPI_RSD_OFFSET(ext_address64.address.translation_offset),
 	 "Translation Offset", NULL},
-	{ACPI_RSD_UINT64, ACPI_RSD_OFFSET(ext_address64.address_length),
+	{ACPI_RSD_UINT64, ACPI_RSD_OFFSET(ext_address64.address.address_length),
 	 "Address Length", NULL},
 	{ACPI_RSD_UINT64, ACPI_RSD_OFFSET(ext_address64.type_specific),
 	 "Type-Specific Attribute", NULL}
diff --git a/drivers/acpi/acpica/rsxface.c b/drivers/acpi/acpica/rsxface.c
index 877ab92..2952878 100644
--- a/drivers/acpi/acpica/rsxface.c
+++ b/drivers/acpi/acpica/rsxface.c
@@ -60,11 +60,11 @@ ACPI_MODULE_NAME("rsxface")
 	ACPI_COPY_FIELD(out, in, min_address_fixed);         \
 	ACPI_COPY_FIELD(out, in, max_address_fixed);         \
 	ACPI_COPY_FIELD(out, in, info);                      \
-	ACPI_COPY_FIELD(out, in, granularity);               \
-	ACPI_COPY_FIELD(out, in, minimum);                   \
-	ACPI_COPY_FIELD(out, in, maximum);                   \
-	ACPI_COPY_FIELD(out, in, translation_offset);        \
-	ACPI_COPY_FIELD(out, in, address_length);            \
+	ACPI_COPY_FIELD(out, in, address.granularity);       \
+	ACPI_COPY_FIELD(out, in, address.minimum);           \
+	ACPI_COPY_FIELD(out, in, address.maximum);           \
+	ACPI_COPY_FIELD(out, in, address.translation_offset); \
+	ACPI_COPY_FIELD(out, in, address.address_length);    \
 	ACPI_COPY_FIELD(out, in, resource_source);
 /* Local prototypes */
 static acpi_status
diff --git a/include/acpi/acrestyp.h b/include/acpi/acrestyp.h
index eb760ca..023959d 100644
--- a/include/acpi/acrestyp.h
+++ b/include/acpi/acrestyp.h
@@ -305,43 +305,51 @@ struct acpi_resource_source {
 	u8                                      max_address_fixed; \
 	union acpi_resource_attribute           info;
 =

-struct acpi_resource_address {
-ACPI_RESOURCE_ADDRESS_COMMON};
-
-struct acpi_resource_address16 {
-	ACPI_RESOURCE_ADDRESS_COMMON u16 granularity;
+struct acpi_address16_attribute {
+	u16 granularity;
 	u16 minimum;
 	u16 maximum;
 	u16 translation_offset;
 	u16 address_length;
-	struct acpi_resource_source resource_source;
 };
 =

-struct acpi_resource_address32 {
-	ACPI_RESOURCE_ADDRESS_COMMON u32 granularity;
+struct acpi_address32_attribute {
+	u32 granularity;
 	u32 minimum;
 	u32 maximum;
 	u32 translation_offset;
 	u32 address_length;
-	struct acpi_resource_source resource_source;
 };
 =

-struct acpi_resource_address64 {
-	ACPI_RESOURCE_ADDRESS_COMMON u64 granularity;
+struct acpi_address64_attribute {
+	u64 granularity;
 	u64 minimum;
 	u64 maximum;
 	u64 translation_offset;
 	u64 address_length;
+};
+
+struct acpi_resource_address {
+ACPI_RESOURCE_ADDRESS_COMMON};
+
+struct acpi_resource_address16 {
+	ACPI_RESOURCE_ADDRESS_COMMON ACPI_ADDRESS16_ATTRIBUTE address;
+	struct acpi_resource_source resource_source;
+};
+
+struct acpi_resource_address32 {
+	ACPI_RESOURCE_ADDRESS_COMMON ACPI_ADDRESS32_ATTRIBUTE address;
+	struct acpi_resource_source resource_source;
+};
+
+struct acpi_resource_address64 {
+	ACPI_RESOURCE_ADDRESS_COMMON ACPI_ADDRESS64_ATTRIBUTE address;
 	struct acpi_resource_source resource_source;
 };
 =

 struct acpi_resource_extended_address64 {
 	ACPI_RESOURCE_ADDRESS_COMMON u8 revision_ID;
-	u64 granularity;
-	u64 minimum;
-	u64 maximum;
-	u64 translation_offset;
-	u64 address_length;
+	ACPI_ADDRESS64_ATTRIBUTE address;
 	u64 type_specific;
 };
 =

-- =

1.7.10


--===============7663561768397748418==--

