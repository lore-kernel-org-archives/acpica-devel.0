Content-Type: multipart/mixed; boundary="===============4818893928118937777=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: [Devel] ACPICA version 20160212 released
Date: Fri, 12 Feb 2016 17:46:32 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37DA9B84A@ORSMSX112.amr.corp.intel.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============4818893928118937777==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

12 February 2016. Summary of changes for version 20160212:

This release is available at https://acpica.org/downloads

1) ACPICA kernel-resident subsystem:

Implemented full support for the ACPI 6.1 specification (released in Januar=
y). This version of the specification is available at:  http://www.uefi.org=
/specifications

Only a relatively small number of changes were required in ACPICA to suppor=
t ACPI 6.1, in these areas:
- New predefined names
- New _HID values
- A new subtable for HEST
- A few other header changes for new values

Ensure \_SB_._INI is executed before any _REG methods are executed. There a=
ppears to be existing BIOS code that relies on this behavior. Lv Zheng.

Reverted a change made in version 20151218 which enabled method invocations=
 to be targets of various ASL operators (SuperName and Target grammar eleme=
nts). While the new behavior is supported by the ACPI specification, other =
AML interpreters do not support this behavior and never will. The ACPI spec=
ification will be updated for ACPI 6.2 to remove this support. Therefore, t=
he change was reverted to the original ACPICA behavior.

ACPICA now supports the GCC 6 compiler.

Current Release: (Note: build changes increased sizes)
    Non-Debug Version: 136.2K Code, 51.5K Data, 187.7K Total
    Debug Version:     200.4K Code, 82.0K Data, 282.4K Total
Previous Release:
    Non-Debug Version: 102.7K Code, 28.4K Data, 131.1K Total
    Debug Version:     200.4K Code, 81.9K Data, 282.3K Total


2) iASL Compiler/Disassembler and Tools:

Completed full support for the ACPI 6.0 External() AML opcode. The compiler=
 emits an external AML opcode for each ASL External statement. This opcode =
is used by the disassembler to assist with the disassembly of external cont=
rol methods by specifying the required number of arguments for the method. =
AML interpreters do not use this opcode. To ensure that interpreters do not=
 even see the opcode, a block of one or more external opcodes is surrounded=
 by an "If(0)" construct. As this feature becomes commonly deployed in BIOS=
 code, the ability of disassemblers to correctly disassemble AML code will =
be greatly improved. David Box.

iASL: Implemented support for an optional cross-reference output file. The =
-lx option will create a the cross-reference file with the suffix "xrf". Th=
ree different types of cross-reference are created in this file:
- List of object references made from within each control method
- Invocation (caller) list for each user-defined control method
- List of references to each non-method object in the namespace

iASL: Method invocations as ASL Target operands are now disallowed and flag=
ged as errors in preparation for ACPI 6.2 (see the description of the probl=
em above).



--===============4818893928118937777==--

