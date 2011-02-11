Content-Type: multipart/mixed; boundary="===============6154671398321559843=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: [Devel] ACPICA version 20110211 released
Date: Fri, 11 Feb 2011 14:33:27 -0800
Message-ID: <4911F71203A09E4D9981D27F9D830858CA5E7F7E@orsmsx503.amr.corp.intel.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============6154671398321559843==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

11 February 2011. Summary of changes for version 20110211:

This release is available at www.acpica.org/downloads

1) ACPI CA Core Subsystem:

Added a mechanism to defer _REG methods for some early-installed handlers. =
Most user handlers should be installed before call to AcpiEnableSubsystem. =
However, Event handlers and region handlers should be installed after AcpiI=
nitializeObjects. Override handlers for the "default" regions should be ins=
talled early, however. This change executes all _REG methods for the defaul=
t regions (Memory/IO/PCI/DataTable) simultaneously to prevent any chicken/e=
gg issues between them. ACPICA BZ 848.

Implemented an optimization for GPE detection. This optimization will simpl=
y ignore GPE registers that contain no enabled GPEs -- there is no need to =
read the register since this information is available internally. This beco=
mes more important on machines with a large GPE space. ACPICA bugzilla 884.=
 Lin Ming. Suggestion from Joe Liu.

Removed all use of the highly unreliable FADT revision field. The revision =
number in the FADT has been found to be completely unreliable and cannot be=
 trusted. Only the actual table length can be used to infer the version. Th=
is change updates the ACPICA core and the disassembler so that both no long=
er even look at the FADT version and instead depend solely upon the FADT le=
ngth.

Fix an unresolved name issue for the no-debug and no-error-message source g=
eneration cases. The _AcpiModuleName was left undefined in these cases, but=
 it is actually needed as a parameter to some interfaces. Define _AcpiModul=
eName as a null string in these cases. ACPICA Bugzilla 888.

Split several large files (makefiles and project files updated)
  utglobal.c   -> utdecode.c
  dbcomds.c    -> dbmethod.c dbnames.c
  dsopcode.c   -> dsargs.c dscontrol.c
  dsload.c     -> dsload2.c
  aslanalyze.c -> aslbtypes.c aslwalks.c

Example Code and Data Size: These are the sizes for the OS-independent acpi=
ca.lib produced by the Microsoft Visual C++ 9.0 32-bit compiler. The debug =
version of the code includes the debug output trace mechanism and has a muc=
h larger code and data size.

  Previous Release (VC 9.0):
    Non-Debug Version:  89.7K Code, 23.7K Data, 113.4K Total
    Debug Version:     163.9K Code, 67.5K Data, 231.4K Total
  Current Release (VC 9.0):
    Non-Debug Version:  89.7K Code, 23.7K Data, 113.4K Total
    Debug Version:     163.9K Code, 67.5K Data, 231.4K Total

2) iASL Compiler/Disassembler and Tools:

iASL: Implemented the predefined macros __LINE__, __FILE__, and __DATE__. T=
hese are useful C-style macros with the standard definitions. ACPICA bugzil=
la 898.

iASL/DTC: Added support for integer expressions and labels. Support for ful=
l expressions for all integer fields in all ACPI tables. Support for labels=
 in "generic" portions of tables such as UEFI. See the iASL reference manua=
l.

Debugger: Added a command to display the status of global handlers. The "ha=
ndlers" command will display op region, fixed event, and miscellaneous glob=
al handlers. installation status -- and for op regions, whether default or =
user-installed handler will be used.

iASL: Warn if reserved method incorrectly returns a value. Many predefined =
names are defined such that they do not return a value. If implemented as a=
 method, issue a warning if such a name explicitly returns a value. ACPICA =
Bugzilla 855.

iASL: Added detection of GPE method name conflicts. Detects a conflict wher=
e there are two GPE methods of the form _Lxy and _Exy in the same scope. (F=
or example, _L1D and _E1D in the same scope.) ACPICA bugzilla 848.

iASL/DTC: Fixed a couple input scanner issues with comments and line number=
s. Comment remover could get confused and miss a comment ending. Fixed a pr=
oblem with line counter maintenance.

iASL/DTC: Reduced the severity of some errors from fatal to error. There is=
 no need to abort on simple errors within a field definition.

Debugger: Simplified the output of the help command. All help output now in=
 a single screen, instead of help subcommands. ACPICA Bugzilla 897.



--===============6154671398321559843==--

