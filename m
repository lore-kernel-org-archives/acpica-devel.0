Content-Type: multipart/mixed; boundary="===============4788192204606178048=="
MIME-Version: 1.0
From: Seunghun Han <kkamagui at gmail.com>
Subject: [Devel] [PATCH] acpi: acpica: fix acpi operand cache leak in nseval.c
Date: Wed, 19 Jul 2017 16:07:23 +0900
Message-ID: <1500448043-137615-1-git-send-email-kkamagui@gmail.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============4788192204606178048==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

I found an ACPI cache leak in ACPI early termination and boot continuing ca=
se.

When early termination occurs due to malicious ACPI table, Linux kernel
terminates ACPI function and continues to boot process. While kernel termin=
ates
ACPI function, kmem_cache_destroy() reports Acpi-Operand cache leak.

Boot log of ACPI operand cache leak is as follows:
>[    0.464168] ACPI: Added _OSI(Module Device)
>[    0.467022] ACPI: Added _OSI(Processor Device)
>[    0.469376] ACPI: Added _OSI(3.0 _SCP Extensions)
>[    0.471647] ACPI: Added _OSI(Processor Aggregator Device)
>[    0.477997] ACPI Error: Null stack entry at ffff880215c0aad8 (20170303/=
exresop-174)
>[    0.482706] ACPI Exception: AE_AML_INTERNAL, While resolving operands f=
or [OpcodeName unavailable] (20170303/dswexec-461)
>[    0.487503] ACPI Error: Method parse/execution failed [\DBG] (Node ffff=
88021710ab40), AE_AML_INTERNAL (20170303/psparse-543)
>[    0.492136] ACPI Error: Method parse/execution failed [\_SB._INI] (Node=
 ffff88021710a618), AE_AML_INTERNAL (20170303/psparse-543)
>[    0.497683] ACPI: Interpreter enabled
>[    0.499385] ACPI: (supports S0)
>[    0.501151] ACPI: Using IOAPIC for interrupt routing
>[    0.503342] ACPI Error: Null stack entry at ffff880215c0aad8 (20170303/=
exresop-174)
>[    0.506522] ACPI Exception: AE_AML_INTERNAL, While resolving operands f=
or [OpcodeName unavailable] (20170303/dswexec-461)
>[    0.510463] ACPI Error: Method parse/execution failed [\DBG] (Node ffff=
88021710ab40), AE_AML_INTERNAL (20170303/psparse-543)
>[    0.514477] ACPI Error: Method parse/execution failed [\_PIC] (Node fff=
f88021710ab18), AE_AML_INTERNAL (20170303/psparse-543)
>[    0.518867] ACPI Exception: AE_AML_INTERNAL, Evaluating _PIC (20170303/=
bus-991)
>[    0.522384] kmem_cache_destroy Acpi-Operand: Slab cache still has objec=
ts
>[    0.524597] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 4.12.0-rc5 #26
>[    0.526795] Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS Vir=
tualBox 12/01/2006
>[    0.529668] Call Trace:
>[    0.530811]  ? dump_stack+0x5c/0x81
>[    0.532240]  ? kmem_cache_destroy+0x1aa/0x1c0
>[    0.533905]  ? acpi_os_delete_cache+0xa/0x10
>[    0.535497]  ? acpi_ut_delete_caches+0x3f/0x7b
>[    0.537237]  ? acpi_terminate+0xa/0x14
>[    0.538701]  ? acpi_init+0x2af/0x34f
>[    0.540008]  ? acpi_sleep_proc_init+0x27/0x27
>[    0.541593]  ? do_one_initcall+0x4e/0x1a0
>[    0.543008]  ? kernel_init_freeable+0x19e/0x21f
>[    0.546202]  ? rest_init+0x80/0x80
>[    0.547513]  ? kernel_init+0xa/0x100
>[    0.548817]  ? ret_from_fork+0x25/0x30
>[    0.550587] vgaarb: loaded
>[    0.551716] EDAC MC: Ver: 3.0.0
>[    0.553744] PCI: Probing PCI hardware
>[    0.555038] PCI host bridge to bus 0000:00
> ... Continue to boot and log is omitted ...

I analyzed this memory leak in detail and found acpi_ns_evaluate() function
only removes info->return_object in AE_CTRL_RETURN_VALUE case. But, when er=
rors
occur, the status value is not AE_CTRL_RETURN_VALUE, and info->return_objec=
t is
also not null. Therefore, this causes acpi operand memory leak.

This cache leak causes a security threat because an old kernel (<=3D 4.9) s=
hows
memory locations of kernel functions in stack dump. Some malicious users
could use this information to neutralize kernel ASLR.

I made a patch to fix ACPI operand cache leak.

Signed-off-by: Seunghun Han <kkamagui(a)gmail.com>
---
 drivers/acpi/acpica/nseval.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/acpi/acpica/nseval.c b/drivers/acpi/acpica/nseval.c
index d22167c..f13d3cf 100644
--- a/drivers/acpi/acpica/nseval.c
+++ b/drivers/acpi/acpica/nseval.c
@@ -308,6 +308,14 @@ acpi_status acpi_ns_evaluate(struct acpi_evaluate_info=
 *info)
 		/* Map AE_CTRL_RETURN_VALUE to AE_OK, we are done with it */
 =

 		status =3D AE_OK;
+	} else if (ACPI_FAILURE(status)) {
+
+		/* If return_object exists, delete it */
+
+		if (info->return_object) {
+			acpi_ut_remove_reference(info->return_object);
+			info->return_object =3D NULL;
+		}
 	}
 =

 	ACPI_DEBUG_PRINT((ACPI_DB_NAMES,
-- =

2.1.4


--===============4788192204606178048==--

