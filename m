Content-Type: multipart/mixed; boundary="===============0919988619070276607=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: [Devel] ACPICA version 20150717 released
Date: Fri, 17 Jul 2015 16:46:14 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37D30D327@ORSMSX112.amr.corp.intel.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============0919988619070276607==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

17 July 2015. Summary of changes for version 20150717:

This release is available at https://acpica.org/downloads

1) ACPICA kernel-resident subsystem:

Improved the partitioning between the Debugger and Disassembler components.=
 This allows the Debugger to be used standalone within kernel code without =
the Disassembler (which is used for single stepping also). This renames and=
 moves one file, dmobject.c to dbobject.c. Lv Zheng.

Debugger: Implemented a new command to trace the execution of control metho=
ds (Trace). This is especially useful for the in-kernel version of the debu=
gger when file I/O may not be available for method trace output. See the AC=
PICA reference for more information. Lv Zheng.

Moved all C library prototypes (used for the local versions of these functi=
ons when requested) to a new header, acclib.h

Cleaned up the use of non-ANSI C library functions. These functions are imp=
lemented locally in ACPICA. Moved all such functions to a common source fil=
e, utnonansi.c

Debugger: Fixed a problem with the "!!" command (get last command executed)=
 where the debugger could enter an infinite loop and eventually crash.

Removed the use of local macros that were used for some of the standard C l=
ibrary functions to automatically cast input parameters. This mostly affect=
ed the is* functions where the input parameter is defined to be an int. Thi=
s required a few modifications to the main ACPICA source code to provide ca=
sting for these functions and eliminate possible compiler warnings for thes=
e parameters.

Across the source code, added additional status/error checking to resolve i=
ssues discovered by static source code analysis tools such as Coverity.

Example Code and Data Size: These are the sizes for the OS-independent acpi=
ca.lib produced by the Microsoft Visual C++ 9.0 32-bit compiler. The debug =
version of the code includes the debug output trace mechanism and has a muc=
h larger code and data size.

  Current Release:
    Non-Debug Version: 100.9K Code, 24.5K Data, 125.4K Total
    Debug Version:     197.8K Code, 81.5K Data, 279.3K Total
  Previous Release:
    Non-Debug Version: 100.6K Code, 27.6K Data, 128.2K Total
    Debug Version:     196.2K Code, 81.0K Data, 277.2K Total


2) iASL Compiler/Disassembler and Tools:

iASL: Fixed a regression where the device map file feature no longer worked=
 properly when used in conjunction with the disassembler. It only worked pr=
operly with the compiler itself.

iASL: Implemented a new warning for method LocalX variables that are set bu=
t never used (similar to a C compiler such as gcc). This also applies to Ar=
gX variables that are not defined by the parent method, and are instead (le=
gally) used as local variables.

iASL/Preprocessor: Finished the pass-through of line numbers from the prepr=
ocessor to the compiler. This ensures that compiler errors/warnings have th=
e correct original line numbers and filenames, regardless of any #include f=
iles.

iASL/Preprocessor: Fixed a couple of issues with comment handling and the p=
ass-through of comments to the preprocessor output file (which becomes the =
compiler input file). Also fixed a problem with // comments that appear aft=
er a math expression.

iASL: Added support for the TCPA server table to the table compiler and tem=
plate generator. (The client table was already previously supported)

iASL/Preprocessor: Added a permanent #define of the symbol "__IASL__" to id=
entify the iASL compiler.

Cleaned up the use of the macros NEGATIVE and POSITIVE which were defined m=
ultiple times. The new names are ACPI_SIGN_NEGATIVE and ACPI_SIGN_POSITIVE.

AcpiHelp: Update to expand help messages for the iASL preprocessor directiv=
es.


--===============0919988619070276607==--

