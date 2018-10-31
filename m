Content-Type: multipart/mixed; boundary="===============7432559232290648015=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: [Devel] ACPICA version 20181031 released
Date: Wed, 31 Oct 2018 19:57:56 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E3B95194FF@ORSMSX110.amr.corp.intel.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============7432559232290648015==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

31 October 2018. Summary of changes for version 20181031:

This release is available at https://acpica.org/downloads


An Operation Region regression was fixed by properly adding address ranges =
to a global list during initialization. This allows OS to accurately check =
for overlapping regions between native devices (such as PCI) and Operation =
regions as well as checking for region conflicts between two Operation Regi=
ons.

Added support for the 2-byte extended opcodes in the code/feature that atte=
mpts to continue parsing during the table load phase. Skip parsing Device d=
eclarations (and other extended opcodes) when an error occurs during parsin=
g. Previously, only single-byte opcodes were supported.

Cleanup: Simplified the module-level code support by eliminating a useless =
global variable (AcpiGbl_GroupModuleLeveCode).


2) iASL Compiler/Disassembler and Tools:

iASL/Preprocessor: Fixed a regression where an incorrect use of ACPI_FREE c=
ould cause a fault in the preprocessor. This was an inadvertent side-effect=
 from moving more allocations/frees to the local cache/memory mechanism.

iASL: Enhanced error detection by validating that all NameSeg elements with=
in a NamePatch actually exist. The previous behavior was spotty at best, an=
d such errors could be improperly ignored at compiler time (never at runtim=
e, however. There are two new error messages, as shown in the examples belo=
w:

dsdt.asl     33:     CreateByteField (TTTT.BXXX, 1, CBF1)
Error    6161 -                              ^ One or more objects within t=
he Pathname do not exist (TTTT.BXXX)

dsdt.asl     34:     CreateByteField (BUF1, UUUU.INT1, BBBB.CBF1)
Error    6160 -        One or more prefix Scopes do not exist ^  (BBBB.CBF1)

iASL: Disassembler/table-compiler: Added support for the static data table =
TPM2 revision 3 (an older version of TPM2). The support has been added for =
the compiler and the disassembler.

Fixed compilation of DOS format data table file on Unix/Linux systems. iASL=
 now properly detects line continuations (\) for DOS format data table defi=
nition language files on when executing on Unix/Linux.



--===============7432559232290648015==--

