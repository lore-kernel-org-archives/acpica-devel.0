Content-Type: multipart/mixed; boundary="===============5905901712882099667=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: [Devel] ACPICA version 20120913 released
Date: Thu, 13 Sep 2012 20:14:56 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E346B60A57@ORSMSX101.amr.corp.intel.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============5905901712882099667==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

13 September 2012. Summary of changes for version 20120913:

This release is available at https://www.acpica.org/downloads
The ACPI 5.0 specification is available at www.acpi.info

1) ACPICA Kernel-resident Subsystem:

ACPI 5.0: Added two new notify types for the Hardware Error Notification St=
ructure within the Hardware Error Source Table (HEST) table -- CMCI(5) and =
MCE(6).

Table Manager: Merged/removed duplicate code in the root table resize funct=
ions. One function is external, the other is internal. Lv Zheng, ACPICA BZ =
846.

Makefiles: Completely removed the obsolete "Linux" makefiles under acpica/g=
enerate/linux. These makefiles are obsolete and have been replaced by the g=
eneric unix makefiles under acpica/generate/unix.

Makefiles: Ensure that binary files always copied properly. Minor rule chan=
ge to ensure that the final binary output files are always copied up to the=
 appropriate binary directory (bin32 or bin64.)

Example Code and Data Size: These are the sizes for the OS-independent acpi=
ca.lib produced by the Microsoft Visual C++ 9.0 32-bit compiler. The debug =
version of the code includes the debug output trace mechanism and has a muc=
h larger code and data size.

  Previous Release:
    Non-Debug Version:  93.8K Code, 25.3K Data, 119.1K Total
    Debug Version:     175.7K Code, 74.8K Data, 250.5K Total
  Current Release:
    Non-Debug Version:  93.7K Code, 25.3K Data, 119.0K Total
    Debug Version:     175.0K Code, 74.4K Data, 249.4K Total


2) iASL Compiler/Disassembler and Tools:

Disassembler: Fixed a possible fault during the disassembly of resource des=
criptors when a second parse is required because of the invocation of exter=
nal control methods within the table. With assistance from adq(a)lidskialf.=
net. ACPICA BZ 976.

iASL: Fixed a namepath optimization problem. An error can occur if the pars=
e node that contains the namepath to be optimized does not have a parent no=
de that is a named object. This change fixes the problem.

iASL: Fixed a regression where the AML file is not deleted on errors. The A=
ML output file should be deleted if there are any errors during the compile=
r. The only exception is if the -f (force output) option is used. ACPICA BZ=
 974.

iASL: Added a feature to automatically increase internal line buffer sizes.=
 Via realloc(), automatically increase the internal line buffer sizes as ne=
cessary to support very long source code lines. The current version of the =
preprocessor requires a buffer long enough to contain full source code line=
s. This change increases the line buffer(s) if the input lines go beyond th=
e current buffer size. This eliminates errors that occurred when a source c=
ode line was longer than the buffer.

iASL: Fixed a problem with constant folding in method declarations. The Syn=
cLevel term is a ByteConstExpr, and incorrect code would be generated if a =
Type3 opcode was used.

Debugger: Improved command help support. For incorrect argument count, disp=
lay full help for the command. For help command itself, allow an argument t=
o specify a command.

Test Suites: Several bug fixes for the ASLTS suite reduces the number of er=
rors during execution of the suite. Guan Chao.


--===============5905901712882099667==--

