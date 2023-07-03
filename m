Return-Path: <ben@codethink.co.uk>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 096AC60E0A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1F4D7606F5
From: Ben Dooks <ben.dooks@codethink.co.uk>
Message-Id: <20230703122450.951704-1-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Acpica-devel] [PATCH] ACPI: fix undeclared symbols from saprse
List-Id: "This is the central place for ACPICA developer discussions and
 issues." <acpica-devel.lists.linuxfoundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/acpica-devel/>
List-Post: <mailto:acpica-devel@lists.linuxfoundation.org>
List-Help: <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=subscribe>
Date: Mon, 03 Jul 2023 13:29:12 -0000
To: acpica-devel@lists.linuxfoundation.org
Cc: Ben Dooks <ben.dooks@codethink.co.uk>, linux-acpi@vger.kernel.org, robert.moore@intel.com, lenb@kernel.org

The building of drivers/acpi/acpica/utglobal.o is throwing
a number of sparse warnins about undeclared symbols. This is
due to defining DEFINE_ACPI_GLOBALS then making the macro
ACPI_INIT_GLOBAL() define it but never declaring the fact this
is an extern declared varible.

This is some of the sparse warnings that are being fixed here:

drivers/acpi/acpica/utglobal.c: note: in included file (through include/acpi/acpi.h):
./include/acpi/acpixf.h:104:1: warning: symbol 'acpi_gbl_enable_interpreter_slack' was not declared. Should it be static?
./include/acpi/acpixf.h:113:1: warning: symbol 'acpi_gbl_auto_serialize_methods' was not declared. Should it be static?
./include/acpi/acpixf.h:120:1: warning: symbol 'acpi_gbl_create_osi_method' was not declared. Should it be static?
./include/acpi/acpixf.h:126:1: warning: symbol 'acpi_gbl_use_default_register_widths' was not declared. Should it be static?
./include/acpi/acpixf.h:136:1: warning: symbol 'acpi_gbl_enable_table_validation' was not declared. Should it be static?
./include/acpi/acpixf.h:141:1: warning: symbol 'acpi_gbl_enable_aml_debug_object' was not declared. Should it be static?
./include/acpi/acpixf.h:149:1: warning: symbol 'acpi_gbl_copy_dsdt_locally' was not declared. Should it be static?
./include/acpi/acpixf.h:157:1: warning: symbol 'acpi_gbl_do_not_use_xsdt' was not declared. Should it be static?

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
Note, if this isn't the correct place to fix, where should this be
going?
---
 include/acpi/acpixf.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index 9ffdc0425bc2..8d69d1e39cd9 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -37,6 +37,7 @@
 	type name
 
 #define ACPI_INIT_GLOBAL(type,name,value) \
+	extern type name; \
 	type name=value
 
 #else
-- 
2.40.1

