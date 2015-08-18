Content-Type: multipart/mixed; boundary="===============6992782793877957716=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: [Devel] ACPICA version 20150818 released
Date: Tue, 18 Aug 2015 20:27:54 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37D32FD60@ORSMSX112.amr.corp.intel.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============6992782793877957716==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

18 August 2015. Summary of changes for version 20150818:

This release is available at https://acpica.org/downloads

1) ACPICA kernel-resident subsystem:

Fix a regression for AcpiGetTableByIndex interface causing it to fail. Lv Z=
heng. ACPICA BZ 1186.

Completed development to ensure that the ACPICA Disassembler and Debugger a=
re fully standalone components of ACPICA. Removed cross-component dependenc=
es. Lv Zheng.

The max-number-of-AML-loops is now runtime configurable (previously was com=
pile-time only). This is essentially a loop timeout to force-abort infinite=
 AML loops. ACPCIA BZ 1192.

Debugger: Cleanup output to dump ACPI names and namepaths without any trail=
ing underscores. Lv Zheng. ACPICA BZ 1135.

Removed unnecessary conditional compilations across the Debugger and Disass=
embler components where entire modules could be left uncompiled.

The aapits test is deprecated and has been removed from the ACPICA git tree=
. The test has never been completed and has not been maintained, thus becom=
ing rather useless. ACPICA BZ 1015, 794.

A batch of small changes to close bugzilla and other reports:
- Remove duplicate code for _PLD processing. ACPICA BZ 1176.
- Correctly cleanup after a ACPI table load failure. ACPICA BZ 1185.
- iASL: Support POSIX yacc again in makefile. Jung-uk Kim.
- ACPI table support: general cleanup and simplification. Lv Zheng, Bob Moo=
re.
- ACPI table support: fix for a buffer read overrun in AcpiTbFindTable. ACP=
ICA BZ 1184.
- Enhance parameter validation for DataTableRegion and LoadTable ASL/AML op=
erators.
- Debugger: Split debugger initialization/termination interfaces. Lv Zheng.
- AcpiExec: Emit OemTableId for SSDTs during the load phase for table ident=
ification.
- AcpiExec: Add debug message during _REG method phase during table load/in=
it.
- AcpiNames: Fix a regression where some output was missing and no longer e=
mitted.
- Debugger: General cleanup and simplification. Lv Zheng.
- Disassembler: Cleanup use of several global option variables. Lv Zheng.

Example Code and Data Size: These are the sizes for the OS-independent acpi=
ca.lib produced by the Microsoft Visual C++ 9.0 32-bit compiler. The debug =
version of the code includes the debug output trace mechanism and has a muc=
h larger code and data size.

  Current Release:
    Non-Debug Version: 101.3K Code, 27.7K Data, 129.0K Total
    Debug Version:     198.6K Code, 80.9K Data, 279.5K Total
  Previous Release:
    Non-Debug Version: 100.9K Code, 24.5K Data, 125.4K Total
    Debug Version:     197.8K Code, 81.5K Data, 279.3K Total


2) iASL Compiler/Disassembler and Tools:

AcpiExec: Fixed a problem where any more than 32 ACPI tables in the XSDT we=
re not handled properly and caused load errors. Now, properly invoke and us=
e the ACPICA auto-reallocate mechanism for ACPI table data structures. ACPI=
CA BZ 1188

AcpiNames: Add command-line wildcard support for ACPI table files. ACPICA B=
Z 1190.

AcpiExec and AcpiNames: Add -l option to load ACPI tables only. For AcpiExe=
c, this means that no control methods (like _REG/_INI/_STA) are executed du=
ring initialization. ACPICA BZ 1187, 1189.

iASL/Disassembler: Implemented a prototype "listing" mode that emits AML th=
at corresponds to each disassembled ASL statement, to simplify debugging. A=
CPICA BZ 1191.

Debugger: Add option to the "objects" command to display a summary of the c=
urrent namespace objects (Object type and count). This is displayed if the =
command is entered with no arguments.

AcpiNames: Add -x option to specify debug level, similar to AcpiExec.


--===============6992782793877957716==--

