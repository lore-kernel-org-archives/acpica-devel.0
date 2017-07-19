Content-Type: multipart/mixed; boundary="===============1375000537573948097=="
MIME-Version: 1.0
From: Seunghun Han <kkamagui at gmail.com>
Subject: [Devel] [PATCH] acpi: acpica: fix acpi operand cache leak in
 dswstate.c
Date: Wed, 19 Jul 2017 15:37:17 +0900
Message-ID: <1500446237-113706-1-git-send-email-kkamagui@gmail.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============1375000537573948097==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

I found an ACPI cache leak in ACPI early termination and boot continuing ca=
se.

When early termination is occurred due to malicious ACPI table, Linux kernel
terminates ACPI function and continues to boot process. While kernel termin=
ates
ACPI function, kmem_cache_destroy() reports Acpi-Operand cache leak.

Boot log of ACPI operand cache leak is as follows:
>[    0.585957] ACPI: Added _OSI(Module Device)
>[    0.587218] ACPI: Added _OSI(Processor Device)
>[    0.588530] ACPI: Added _OSI(3.0 _SCP Extensions)
>[    0.589790] ACPI: Added _OSI(Processor Aggregator Device)
>[    0.591534] ACPI Error: Illegal I/O port address/length above 64K: C806=
E00000004002/0x2 (20170303/hwvalid-155)
>[    0.594351] ACPI Exception: AE_LIMIT, Unable to initialize fixed events=
 (20170303/evevent-88)
>[    0.597858] ACPI: Unable to start the ACPI Interpreter
>[    0.599162] ACPI Error: Could not remove SCI handler (20170303/evmisc-2=
81)
>[    0.601836] kmem_cache_destroy Acpi-Operand: Slab cache still has objec=
ts
>[    0.603556] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.12.0-rc5 #26
>[    0.605159] Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS Vir=
tualBox 12/01/2006
>[    0.609177] Call Trace:
>[    0.610063]  ? dump_stack+0x5c/0x81
>[    0.611118]  ? kmem_cache_destroy+0x1aa/0x1c0
>[    0.612632]  ? acpi_sleep_proc_init+0x27/0x27
>[    0.613906]  ? acpi_os_delete_cache+0xa/0x10
>[    0.617986]  ? acpi_ut_delete_caches+0x3f/0x7b
>[    0.619293]  ? acpi_terminate+0xa/0x14
>[    0.620394]  ? acpi_init+0x2af/0x34f
>[    0.621616]  ? __class_create+0x4c/0x80
>[    0.623412]  ? video_setup+0x7f/0x7f
>[    0.624585]  ? acpi_sleep_proc_init+0x27/0x27
>[    0.625861]  ? do_one_initcall+0x4e/0x1a0
>[    0.627513]  ? kernel_init_freeable+0x19e/0x21f
>[    0.628972]  ? rest_init+0x80/0x80
>[    0.630043]  ? kernel_init+0xa/0x100
>[    0.631084]  ? ret_from_fork+0x25/0x30
>[    0.633343] vgaarb: loaded
>[    0.635036] EDAC MC: Ver: 3.0.0
>[    0.638601] PCI: Probing PCI hardware
>[    0.639833] PCI host bridge to bus 0000:00
>[    0.641031] pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
> ... Continue to boot and log is omitted ...

I analyzed this memory leak in detail and found acpi_ds_obj_stack_pop_and_
delete() function miscalculated the top of the stack. acpi_ds_obj_stack_pus=
h()
function uses walk_state->operand_index for start position of the top, but
acpi_ds_obj_stack_pop_and_delete() function considers index 0 for it.
Therefore, this causes acpi operand memory leak.

This cache leak causes a security threat because an old kernel (<=3D 4.9) s=
hows
memory locations of kernel functions in stack dump. Some malicious users
could use this information to neutralize kernel ASLR.

I made a patch to fix ACPI operand cache leak.

Signed-off-by: Seunghun Han <kkamagui(a)gmail.com>
---
 drivers/acpi/acpica/dswstate.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/dswstate.c b/drivers/acpi/acpica/dswstate.c
index da111a1..fde6d78 100644
--- a/drivers/acpi/acpica/dswstate.c
+++ b/drivers/acpi/acpica/dswstate.c
@@ -403,6 +403,7 @@ acpi_ds_obj_stack_pop_and_delete(u32 pop_count,
 				 struct acpi_walk_state *walk_state)
 {
 	s32 i;
+	s32 stack_top;
 	union acpi_operand_object *obj_desc;
 =

 	ACPI_FUNCTION_NAME(ds_obj_stack_pop_and_delete);
@@ -411,7 +412,11 @@ acpi_ds_obj_stack_pop_and_delete(u32 pop_count,
 		return;
 	}
 =

-	for (i =3D (s32)pop_count - 1; i >=3D 0; i--) {
+	/* Calculate curruent top of the stack */
+
+	stack_top =3D (s32)walk_state->num_operands + walk_state->operand_index -=
 1;
+
+	for (i =3D stack_top; i >=3D 0; i--) {
 		if (walk_state->num_operands =3D=3D 0) {
 			return;
 		}
-- =

2.1.4


--===============1375000537573948097==--

