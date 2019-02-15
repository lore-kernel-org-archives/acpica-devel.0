Content-Type: multipart/mixed; boundary="===============3232666108812977727=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: [Devel] ACPICA version 20190215 released
Date: Fri, 15 Feb 2019 18:31:20 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E3B955DC97@ORSMSX110.amr.corp.intel.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============3232666108812977727==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

15 February 2019. Summary of changes for version 20190215:

This release is available at https://acpica.org/downloads


0) Support for ACPI specification version 6.3:

Add PCC operation region support for the AML interpreter. This adds PCC =

operation region support in the AML interpreter and a default handler for =

acpiexec. The change also renames the PCC region address space keyword to =

PlatformCommChannel.

Support for new predefined methods _NBS, _NCH, _NIC, _NIH, and _NIG. =

These methods provide OSPM with health information and device boot =

status.

PDTT: Add TriggerOrder to the PCC Identifier structure. The field value =

defines if the trigger needs to be invoked by OSPM before or at the end =

of kernel crash dump processing/handling operation.

SRAT: Add Generic Affinity Structure subtable. This subtable in the SRAT =

is used for describing devices such as heterogeneous processors, =

accelerators, GPUs, and IO devices with integrated compute or DMA =

engines.

MADT: Add support for statistical profiling in GICC. Statistical =

profiling extension (SPE) is an architecture-specific feature for ARM.

MADT: Add online capable flag. If this bit is set, system hardware =

supports enabling this processor during OS runtime.

New Error Disconnect Recover Notification value. There are a number of =

scenarios where system Firmware in collaboration with hardware may =

disconnect one or more devices from the rest of the system for purposes =

of error containment. Firmware can use this new notification value to =

alert OSPM of such a removal.

PPTT: New additional fields in Processor Structure Flags. These flags =

provide more information about processor topology.

NFIT/Disassembler: Change a field name from "Address Range" to "Region =

Type".

HMAT updates: make several existing fields to be reserved as well as =

rename subtable 0 to "memory proximity domain attributes".

GTDT: Add support for new GTDT Revision 3. This revision adds information =

for the EL2 timer.

iASL: Update the HMAT example template for new fields.

iASL: Add support for the new revision of the GTDT (Rev 3).


1) ACPICA kernel-resident subsystem:

AML Parser: fix the main AML parse loop to correctly skip erroneous =

extended opcodes. AML opcodes come in two lengths: 1-byte opcodes and 2-
byte extended opcodes. If an error occurs during an AML table load, the =

AML parser will continue loading the table by skipping the offending =

opcode. This implements a "load table at any cost" philosophy.


2) iASL Compiler/Disassembler and Tools:

iASL: Add checks for illegal object references, such as a reference =

outside of method to an object within a method. Such an object is only =

temporary.

iASL: Emit error for creation of a zero-length operation region. Such a =

region is rather pointless. If encountered, a runtime error is also =

implemented in the interpeter.

Debugger: Fix a possible fault with the "test objects" command.

iASL: Makefile: support parent directory filenames containing embedded =

spaces.

iASL: Update the TPM2 template to revision 4.

iASL: Add the ability to report specific warnings or remarks as errors.

Disassembler: Disassemble OEMx tables as actual AML byte code. =

Previously, these tables were treated as "unknown table".

iASL: Add definition and disassembly for TPM2 revision 3.

iASL: Add support for TPM2 rev 3 compilation.



--===============3232666108812977727==--

