Content-Type: multipart/mixed; boundary="===============4074927474773691510=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: [Devel] ACPICA version 20161117 released
Date: Thu, 17 Nov 2016 17:42:39 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37E52E0B6@ORSMSX110.amr.corp.intel.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============4074927474773691510==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

17 November 2016. Summary of changes for version 20161117:

This release is available at https://acpica.org/downloads


1) ACPICA kernel-resident subsystem:

Table Manager: Fixed a regression introduced in 20160729, "FADT support cle=
anup". This was an attempt to remove all references in the source to the FA=
DT version 2, which never was a legal version number. It was skipped becaus=
e it was an early version of 64-bit support that was eventually abandoned f=
or the current 64-bit support.

Interpreter: Fixed a problem where runtime implicit conversion was incorrec=
tly disabled for the ASL operators below. This brings the behavior into com=
pliance with the ACPI specification:
    FromBCD
    ToBCD
    ToDecimalString
    ToHexString
    ToInteger
    ToBuffer

Table Manager: Added a new public interface, AcpiPutTable, used to release =
and free an ACPI table returned by AcpiGetTable and related interfaces. Lv =
Zheng.

Example Code and Data Size: These are the sizes for the OS-independent acpi=
ca.lib produced by the Microsoft Visual C++ 9.0 32-bit compiler. The debug =
version of the code includes the debug output trace mechanism and has a muc=
h larger code and data size.

  Current Release:
    Non-Debug Version: 140.5K Code, 58.5K Data, 198.9K Total
    Debug Version:     201.3K Code, 82.7K Data, 284.0K Total
  Previous Release:
    Non-Debug Version: 140.4K Code, 58.1K Data, 198.5K Total
    Debug Version:     200.7K Code, 82.1K Data, 282.8K Total


2) iASL Compiler/Disassembler and Tools:

Disassembler: Fixed a regression for disassembly of Resource Template. Dete=
ction of templates in the AML stream missed some types of templates.

iASL: Fixed a problem where an Access Size error was returned for the PCC a=
ddress space when the AccessSize of the GAS register is greater than a DWOR=
D. Hoan Tran.

iASL: Implemented several grammar changes for the operators below. These ch=
anges are slated for the next version of the ACPI specification:
    RefOf        - Disallow method invocation as an operand
    CondRefOf    - Disallow method invocation as an operand
    DerefOf      - Disallow operands that use the result from operators that
                   do not return a reference (Changed TermArg to SuperName).

iASL: Control method invocations are now allowed for Target operands, as pe=
r the ACPI specification. Removed error for using a control method invocati=
on as a Target operand.

Disassembler: Improved detection of Resource Templates, Unicode, and String=
s within Buffer objects. These subtypes do not contain a specific opcode to=
 indicate the originating ASL code, and they must be detected by other mean=
s within the disassembler.

iASL: Implemented an optimization improvement for 32-bit ACPI tables (DSDT/=
SSDT). For the 32-bit case only, compute the optimum integer opcode only af=
ter 64-bit to 32-bit truncation. A truncation warning message is still emit=
ted, however.

AcpiXtract: Implemented handling for both types of line terminators (LF or =
CR/LF) so that it can accept AcpiDump output files from any system. Peter W=
u.

AcpiBin: Added two new options for comparing AML files:
    -a: compare and display ALL mismatches
    -o: start compare at this offset into the second file


--===============4074927474773691510==--

