Return-Path: <cymi20@fudan.edu.cn>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C6B8A417DE
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org AF368404D5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fudan.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
 Message-Id; bh=EqZ69WEViIG68qz/W0eV6BOXBynqyp/2ao5vcAHxPoc=; b=L
 4XKwqwOMMnXlJ/sGtIYoX7nBQWfBcnc0EoTP8IxbgWlH2UFiTsTVi/x1ANapZAnH
 n/UfAvVT3T0Uu3wPwPJ1UflO41Ys/ehz+i7wWC01HN6b6y1ZPuANOFA8Byuibbv9
 Nv/x2sbMjJSBn5bUa3IaKsi1Nr7bKCjHsrpa9qFOAI=
From: Chenyuan Mi <cymi20@fudan.edu.cn>
Date: Wed, 14 Jun 2023 09:21:12 -0700
Message-Id: <20230614162112.122816-1-cymi20@fudan.edu.cn>
Subject: [Acpica-devel] [PATCH] ACPICA: Fix missing check for return value
	of acpi_ns_get_attached_object()
List-Id: "This is the central place for ACPICA developer discussions and
 issues." <acpica-devel.lists.linuxfoundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/acpica-devel/>
List-Post: <mailto:acpica-devel@lists.linuxfoundation.org>
List-Help: <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=subscribe>
To: robert.moore@intel.com, rafael.j.wysocki@intel.com, lenb@kernel.org, linux-acpi@vger.kernel.org, acpica-devel@lists.linuxfoundation.org, linux-kernel@vger.kernel.org
Cc: Chenyuan Mi <cymi20@fudan.edu.cn>

The acpi_ns_get_attached_object() function may return
NULL, which may cause null pointer deference, and most
other callsites of acpi_ns_get_attached_object() do
Null check. Add Null check for return value of
acpi_ns_get_attached_object().

Found by our static analysis tool.

Signed-off-by: Chenyuan Mi <cymi20@fudan.edu.cn>
---
 drivers/acpi/acpica/exprep.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/acpi/acpica/exprep.c b/drivers/acpi/acpica/exprep.c
index 08196fa17080..d9c006ec1ac8 100644
--- a/drivers/acpi/acpica/exprep.c
+++ b/drivers/acpi/acpica/exprep.c
@@ -431,6 +431,13 @@ acpi_status acpi_ex_prep_field_value(struct acpi_create_field_info *info)
 		obj_desc->field.region_obj =
 		    acpi_ns_get_attached_object(info->region_node);
 
+		if (!obj_desc->field.region_obj) {
+			ACPI_ERROR((AE_INFO,
+				    "Null Region Object during field prep"));
+			acpi_ut_delete_object_desc(obj_desc);
+			return_ACPI_STATUS(AE_AML_INTERNAL);
+		}
+
 		/* Fields specific to generic_serial_bus fields */
 
 		obj_desc->field.access_length = info->access_length;
-- 
2.17.1

