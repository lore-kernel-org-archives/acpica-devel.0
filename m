Content-Type: multipart/mixed; boundary="===============5999606308385379767=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: [Devel] ACPICA version 20110623 released
Date: Thu, 23 Jun 2011 17:08:11 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E3030E36@ORSMSX101.amr.corp.intel.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============5999606308385379767==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

23 June 2011. Summary of changes for version 20110623:

This release is available at www.acpica.org/downloads

1) ACPI CA Core Subsystem:

Updated the predefined name repair mechanism to not attempt repair of a _TS=
S return object if a _PSS object is present. We can only sort the _TSS retu=
rn package if there is no _PSS within the same scope. This is because if _P=
SS is present, the ACPI specification dictates that the _TSS Power Dissipat=
ion field is to be ignored, and therefore some BIOSs leave garbage values i=
n the _TSS Power field(s). In this case, it is best to just return the _TSS=
 package as-is. Reported by, and fixed with assistance from Fenghua Yu.

Added an option to globally disable the control method return value validat=
ion and repair. This runtime option can be used to disable return value rep=
air if this is causing a problem on a particular machine. Also added an opt=
ion to AcpiExec (-dr) to set this disable flag.

All makefiles and project files: Major changes to improve generation of ACP=
ICA tools. ACPICA BZ 912:
    Reduce default optimization levels to improve compatibility
    For Linux, add strict-aliasing=3D0 for gcc 4
    Cleanup and simplify use of command line defines
    Cleanup multithread library support
    Improve usage messages

Linux-specific header: update handling of THREAD_ID and pthread. For the 32=
-bit case, improve casting to eliminate possible warnings, especially with =
the acpica tools.

Example Code and Data Size: These are the sizes for the OS-independent acpi=
ca.lib produced by the Microsoft Visual C++ 9.0 32-bit compiler. The debug =
version of the code includes the debug output trace mechanism and has a muc=
h larger code and data size.

  Previous Release (VC 9.0):
    Non-Debug Version:  90.1K Code, 23.9K Data, 114.0K Total
    Debug Version:     165.6K Code, 68.4K Data, 234.0K Total
  Current Release (VC 9.0):
    Non-Debug Version:  90.2K Code, 23.9K Data, 114.1K Total
    Debug Version:     165.6K Code, 68.4K Data, 234.0K Total

2) iASL Compiler/Disassembler and Tools:

With this release, a new utility named "acpihelp" has been added to the ACP=
ICA package. This utility summarizes the ACPI specification chapters for th=
e ASL and AML languages. It generates under Linux/Unix as well as Windows, =
and provides the following functionality:
    Find/display ASL operator(s) -- with description and syntax.
    Find/display ASL keyword(s) -- with exact spelling and descriptions.
    Find/display ACPI predefined name(s) -- with description, number
        of arguments, and the return value data type.
    Find/display AML opcode name(s) -- with opcode, arguments, and grammar.
    Decode/display AML opcode -- with opcode name, arguments, and grammar.

Service Layers: Make multi-thread support configurable. Conditionally compi=
le the multi-thread support so that threading libraries will not be linked =
if not necessary. The only tool that requires multi-thread support is AcpiE=
xec.

iASL: Update yyerrror/AslCompilerError for "const" errors. Newer versions o=
f Bison appear to want the interface to yyerror to be a const char * (or at=
 least this is a problem when generating iASL on some systems.) ACPICA BZ 9=
23 Pierre Lejeune.

Tools: Fix for systems where O_BINARY is not defined. Only used for Windows=
 versions of the tools.


--===============5999606308385379767==--

