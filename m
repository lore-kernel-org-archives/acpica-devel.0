Content-Type: multipart/mixed; boundary="===============5025774654147031337=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: [Devel] ACPICA version 20160318 released
Date: Fri, 18 Mar 2016 16:59:55 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37E452909@ORSMSX110.amr.corp.intel.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============5025774654147031337==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

18 March 2016. Summary of changes for version 20160318:

This release is available at https://acpica.org/downloads

1) ACPICA kernel-resident subsystem:

Added support for arbitrary bit lengths and bit offsets for registers defin=
ed by the Generic Address Structure. Previously, only aligned bit lengths o=
f 8/16/32/64 were supported. This was sufficient for many years, but recent=
ly some machines have been seen that require arbitrary bit-level support. A=
CPICA BZ 1240. Lv Zheng.

Fixed an issue where the \_SB._INI method sometimes must be evaluated befor=
e any _REG methods are evaluated. Lv Zheng.

Implemented several changes related to ACPI table support (Headers/Disassem=
bler/TableCompiler):
NFIT: For ACPI 6.1, updated to add some additional new fields and constants.
FADT: Updated a warning message and set compliance to ACPI 6.1 (Version 6).
DMAR: Added new constants per the 10/2014 DMAR spec.
IORT: Added new subtable per the 10/2015 IORT spec.
HEST: For ACPI 6.1, added new constants and new subtable.
DBG2: Added new constants per the 12/2015 DBG2 spec.
FPDT: Fixed several incorrect fields, add the FPDT boot record structure. A=
CPICA BZ 1249.
ERST/EINJ: Updated disassembler with new "Execute Timings" actions.

Updated header support for the DMAR table to match the current version of t=
he related spec.

Added extensions to the ASL Concatenate operator to allow any ACPI object t=
o be passed as an operand. Any object other than Integer/String/Buffer simp=
ly returns a string containing the object type. This extends the usefulness=
 of the Printf macros. Previously, Concatenate would abort the control meth=
od if a non-data object was encountered.

ACPICA source code: Deployed the C "const" keyword across the source code w=
here appropriate. ACPICA BZ 732. Joerg Sonnenberger (NetBSD).

Example Code and Data Size: These are the sizes for the OS-independent acpi=
ca.lib produced by the Microsoft Visual C++ 9.0 32-bit compiler. The debug =
version of the code includes the debug output trace mechanism and has a muc=
h larger code and data size.

  Current Release:
    Non-Debug Version: 137.1K Code, 51.5K Data, 188.6K Total
    Debug Version:     201.0K Code, 82.0K Data, 283.0K Total
  Previous Release:
    Non-Debug Version: 136.2K Code, 51.5K Data, 187.7K Total
    Debug Version:     200.4K Code, 82.0K Data, 282.4K Total


2) iASL Compiler/Disassembler and Tools:

iASL/Disassembler: Improved the heuristic used to determine the number of a=
rguments for an externally defined control method (a method in another tabl=
e). Although this is an improvement, there is no deterministic way to "gues=
s" the number of method arguments. Only the ACPI 6.0 External opcode will c=
ompletely solve this problem as it is deployed (automatically) in newer BIO=
S code.

iASL/Disassembler: Fixed an ordering issue for emitted External() ASL state=
ments that could cause errors when the disassembled file is compiled. ACPIC=
A BZ 1243. David Box.

iASL: Fixed a regression caused by the merger of the two versions of the lo=
cal strtoul64. Because of a dependency on a global variable, strtoul64 coul=
d return an error for integers greater than a 32-bit value. ACPICA BZ 1260.

iASL: Fixed a regression where a fault could occur for an ASL Return statem=
ent if it invokes a control method that is not resolved. ACPICA BZ 1264.

AcpiXtract: Improved input file validation: detection of binary files and n=
on-acpidump text files.
d

--===============5025774654147031337==--

