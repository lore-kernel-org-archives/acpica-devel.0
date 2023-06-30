Return-Path: <abmainkar@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E719660D4C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9AB6E60B60
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J2VdafCqgjlIjfQcPApAq7OBBT127Sy+bPj65GIDT+4=;
 b=edZyEJJu9EHemWh2Jv9fhvdyOaO3ASDgKTlqL4xfpK1mhIHxgAQ8F9Nf+Djofze4PqVV6xUS36uOutjW7fZRdQ3abkwz2Kw5vUWqO5Yi1wXgmCmYo/54VnN76cGHJU7QSAxWVvbnGhyhWe7tSHFKe08GqdsR759+0NkdcGZVagZ+i4q0txbfHugaVBjfGV31qE+eE294Et9+lKY45MHOyI3opJ1BnOM/u79YtGNwzbpFTKwlPl2U5bbmX8JrFHO1CEujWloaS6Yaatw4k8mnOIC/45iO4rVvva1VewNcO18W4kOrBq+4pzjTUrUMnsQGag2tyaDNGe+h06poVKaVdA==
From: Abhishek Mainkar <abmainkar@nvidia.com>
Message-ID: <20230630042419.1947389-1-abmainkar@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Acpica-devel] [PATCH] acpica: Add AML_NO_OPERAND_RESOLVE flag to
	Timer
List-Id: "This is the central place for ACPICA developer discussions and
 issues." <acpica-devel.lists.linuxfoundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/acpica-devel/>
List-Post: <mailto:acpica-devel@lists.linuxfoundation.org>
List-Help: <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=subscribe>
Date: Fri, 30 Jun 2023 04:24:50 -0000
To: robert.moore@intel.com, rafael.j.wysocki@intel.com, lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, acpica-devel@lists.linuxfoundation.org, abmainkar@nvidia.com, linux-kernel@vger.kernel.org

According to the ACPI specification 19.6.134, no argument is
required to be passed for ASL Timer instruction. For taking
care of no argument, AML_NO_OPERAND_RESOLVE flag is added to
ASL Timer instruction opcode.

When ASL timer instruction interpreted by ACPI interpreter,
getting error. After adding AML_NO_OPERAND_RESOLVE flag to
ASL Timer instruction opcode, issue is not observed.

=============================================================
UBSAN: array-index-out-of-bounds in acpica/dswexec.c:401:12
index -1 is out of range for type 'acpi_operand_object *[9]'
CPU: 37 PID: 1678 Comm: cat Not tainted
6.0.0-dev-th500-6.0.y-1+bcf8c46459e407-generic-64k
HW name: NVIDIA BIOS v1.1.1-d7acbfc-dirty 12/19/2022 Call trace:
 dump_backtrace+0xe0/0x130
 show_stack+0x20/0x60
 dump_stack_lvl+0x68/0x84
 dump_stack+0x18/0x34
 ubsan_epilogue+0x10/0x50
 __ubsan_handle_out_of_bounds+0x80/0x90
 acpi_ds_exec_end_op+0x1bc/0x6d8
 acpi_ps_parse_loop+0x57c/0x618
 acpi_ps_parse_aml+0x1e0/0x4b4
 acpi_ps_execute_method+0x24c/0x2b8
 acpi_ns_evaluate+0x3a8/0x4bc
 acpi_evaluate_object+0x15c/0x37c
 acpi_evaluate_integer+0x54/0x15c
 show_power+0x8c/0x12c [acpi_power_meter]

Link: https://github.com/acpica/acpica/commit/90310989
Signed-off-by: Abhishek Mainkar <abmainkar@nvidia.com>
---
 drivers/acpi/acpica/psopcode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/psopcode.c b/drivers/acpi/acpica/psopcode.c
index bef69e87a0a2..8c34c0ffb1d9 100644
--- a/drivers/acpi/acpica/psopcode.c
+++ b/drivers/acpi/acpica/psopcode.c
@@ -603,7 +603,7 @@ const struct acpi_opcode_info acpi_gbl_aml_op_info[AML_NUM_OPCODES] = {
 
 /* 7E */ ACPI_OP("Timer", ARGP_TIMER_OP, ARGI_TIMER_OP, ACPI_TYPE_ANY,
 			 AML_CLASS_EXECUTE, AML_TYPE_EXEC_0A_0T_1R,
-			 AML_FLAGS_EXEC_0A_0T_1R),
+			 AML_FLAGS_EXEC_0A_0T_1R | AML_NO_OPERAND_RESOLVE),
 
 /* ACPI 5.0 opcodes */
 
-- 
2.17.1

