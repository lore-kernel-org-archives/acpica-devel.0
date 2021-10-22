Content-Type: multipart/mixed; boundary="===============5632975224021829758=="
MIME-Version: 1.0
From: Sudeep Holla <sudeep.holla at arm.com>
Subject: [Devel] [BUG REPORT][ACPICA] PCC Opregion: Wrong interpretation of
 channel index as table subtype
Date: Fri, 22 Oct 2021 19:36:12 +0100
Message-ID: <20211022183612.jxhou2pzge6xkv2u@bogus>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============5632975224021829758==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

I am trying to add PCC Opregion support in the kernel and am hitting a
kernel crash when I add PCC Opregion in the ACPI ASL. Below is the
snippet of the crash:
-->8

Unable to handle kernel NULL pointer dereference at virtual address 0000000=
000000010
 Workqueue: pm pm_runtime_work
 pstate: 80000005 (Nzcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=3D--)
 pc : __memcpy+0x54/0x260
 lr : acpi_ex_write_data_to_field+0xb8/0x194
 Call trace:
  __memcpy+0x54/0x260
  acpi_ex_store_object_to_node+0xa4/0x1d4
  acpi_ex_store+0x44/0x164
  acpi_ex_opcode_1A_1T_1R+0x25c/0x508
  acpi_ds_exec_end_op+0x1b4/0x44c
  acpi_ps_parse_loop+0x3a8/0x614
  acpi_ps_parse_aml+0x90/0x2f4
  acpi_ps_execute_method+0x11c/0x19c
  acpi_ns_evaluate+0x1ec/0x2b0
  acpi_evaluate_object+0x170/0x2b0
  acpi_device_set_power+0x118/0x310
  acpi_dev_suspend+0xd4/0x180
  acpi_subsys_runtime_suspend+0x28/0x38
  __rpm_callback+0x74/0x328
  rpm_suspend+0x2d8/0x624
  pm_runtime_work+0xa4/0xb8
  process_one_work+0x194/0x25c
  worker_thread+0x260/0x49c
  kthread+0x14c/0x30c
  ret_from_fork+0x10/0x20
 Code: f9000006 f81f80a7 d65f03c0 361000c2 (b9400026)
 ---[ end trace 24d8a032fa77b68a ]---

On debugging, I figured out that PCC channel index passed via region.address
in acpi_ex_store_object_to_node is interpreted as the channel subtype.

To confirm, I just hacked assuming we don't need to support type 1/2 PCC
with the change as below:

-->8

diff --git i/drivers/acpi/acpica/exfield.c w/drivers/acpi/acpica/exfield.c
index 06f3c9df1e22..8618500f23b3 100644
--- i/drivers/acpi/acpica/exfield.c
+++ w/drivers/acpi/acpica/exfield.c
@@ -330,12 +330,7 @@ acpi_ex_write_data_to_field(union acpi_operand_object =
*source_desc,
                       obj_desc->field.base_byte_offset,
                       source_desc->buffer.pointer, data_length);

-               if ((obj_desc->field.region_obj->region.address =3D=3D
-                    PCC_MASTER_SUBSPACE
-                    && MASTER_SUBSPACE_COMMAND(obj_desc->field.
-                                               base_byte_offset))
-                   || GENERIC_SUBSPACE_COMMAND(obj_desc->field.
-                                               base_byte_offset)) {
+               if (MASTER_SUBSPACE_COMMAND(obj_desc->field.base_byte_offse=
t)) {

                        /* Perform the write */


With the above change, the crash disappears and correctly complains about
missing PCC Opregion handler(I have more questions on setting up one, will
follow that up separately).

-->8

ACPI Error: No handler for Region [PFRM] ((____ptrval____)) [PCC] (20210730=
/evregion-130)
ACPI Error: Region PCC (ID=3D10) has no handler (20210730/exfldio-261)
ACPI Error: Aborting method \_SB.ETH0._PS3 due to previous error (AE_NOT_EX=
IST) (20210730/psparse-531)

Not sure if my interpretation of the spec is incorrect or indeed this is
a bug. IIUC only _REG has both PCC channel index/address + the subtable type
embedded in the argument. The actual declaration of PCC Opregion just needs
the channel index as the address.

--
Regards,
Sudeep
--===============5632975224021829758==--

