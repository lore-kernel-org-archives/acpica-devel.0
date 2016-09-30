Content-Type: multipart/mixed; boundary="===============4560101119251435067=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: [Devel] ACPICA version 20160930 released
Date: Fri, 30 Sep 2016 17:01:03 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37E5042EC@ORSMSX110.amr.corp.intel.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============4560101119251435067==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

30 September 2016. Summary of changes for version 20160930:

This release is available at https://acpica.org/downloads


1) ACPICA kernel-resident subsystem:

Fixed a regression in the internal AcpiTbFindTable function where a non AE_=
OK exception could inadvertently be returned even if the function did not f=
ail. This problem affects the following operators:
    DataTableRegion
    LoadTable

Fixed a regression in the LoadTable operator where a load to any namespace =
location other than the root no longer worked properly.

Increased the maximum loop count value that will result in the AE_AML_INFIN=
ITE_LOOP exception. This is a mechanism that is intended to prevent infinit=
e loops within the AML interpreter and thus the host OS kernel. The value i=
s increased from 0xFFFF to 0xFFFFF loops (65,535 to 1,048,575).

Moved the AcpiGbl_MaxLoopIterations configuration variable to the public ac=
pixf.h file. This allows hosts to easily configure the maximum loop count a=
t runtime.

Removed an illegal character in the strtoul64.c file. This character caused=
 errors with some C compilers.

Example Code and Data Size: These are the sizes for the OS-independent acpi=
ca.lib produced by the Microsoft Visual C++ 9.0 32-bit compiler. The debug =
version of the code includes the debug output trace mechanism and has a muc=
h larger code and data size.

  Current Release:
    Non-Debug Version: 140.4K Code, 58.1K Data, 198.5K Total
    Debug Version:     200.7K Code, 82.1K Data, 282.8K Total
  Previous Release:
    Non-Debug Version: 140.0K Code, 58.1K Data, 198.1K Total
    Debug Version:     200.3K Code, 82.1K Data, 282.4K Total


2) iASL Compiler/Disassembler and Tools:

Disassembler: Fixed a problem with the conversion of Else{If{ blocks into t=
he simpler ASL ElseIf keyword. During the conversion, a trailing If block c=
ould be lost and missing from the disassembled output.

iASL: Fixed a missing parser rule for the ObjectType operator. For ASL+, th=
e missing rule caused a parse error when using the Index operator as an ope=
rand to ObjectType. This construct now compiles properly. Example:
    ObjectType(PKG1[4]).

iASL: Correctly handle unresolved symbols in the hardware map file (-lm opt=
ion). Previously, unresolved symbols could cause a protection fault. Such s=
ymbols are now marked as unresolved in the map file.

iASL: Implemented support to allow control method invocations as an operand=
 to the ASL DeRefOf operator. Example:
    DeRefOf(MTH1(Local0))

Disassembler: Improved support for the ToPLD ASL macro. Detection of a poss=
ible _PLD buffer now includes examination of both the normal buffer length =
(16 or 20) as well as the surrounding AML package length.

Disassembler: Fixed a problem with the decoding of complex expressions with=
in the Divide operator for ASL+. For the case where both the quotient and r=
emainder targets are specified, the entire statement cannot be disassembled=
. Previously, the output incorrectly contained a mix of ASL- and ASL+ opera=
tors. This mixed statement causes a syntax error when compiled. Example:
    Divide (Add (INT1, 6), 128, RSLT, QUOT)  // was incorrectly disassemble=
d to:
    Divide (INT1 + 6, 128, RSLT, QUOT)

iASL/Tools: Added support to process AML and non-AML ACPI tables consistent=
ly. For the disassembler and AcpiExec, allow all types of ACPI tables (AML =
and data tables). For the iASL -e option, allow only AML tables (DSDT/SSDT).




--===============4560101119251435067==--

