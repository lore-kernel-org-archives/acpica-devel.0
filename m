Content-Type: multipart/mixed; boundary="===============5234226094286799931=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: [Devel] ACPICA version 20140325 released
Date: Tue, 25 Mar 2014 17:04:33 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37C7FD3D9@ORSMSX103.amr.corp.intel.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============5234226094286799931==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

25 March 2014. Summary of changes for version 20140325:

This release is available at https://acpica.org/downloads

1) ACPICA kernel-resident subsystem:

Updated the auto-serialize feature for control methods. This feature automa=
tically serializes all methods that create named objects in order to preven=
t runtime errors. The update adds support to ignore the currently executing=
 AML SyncLevel when invoking such a method, in order to prevent disruption =
of any existing SyncLevel priorities that may exist in the AML code. Althou=
gh the use of SyncLevels is relatively rare, this change fixes a regression=
 where an AE_AML_MUTEX_ORDER exception can appear on some machines starting=
 with the 20140214 release.

Added a new external interface to allow the host to install ACPI tables ver=
y early, before the namespace is even created. AcpiInstallTable gives the h=
ost additional flexibility for ACPI table management. Tables can be install=
ed directly by the host as if they had originally appeared in the XSDT/RSDT=
. Installed tables can be SSDTs or other ACPI data tables (anything except =
the DSDT and FACS). Adds a new file, tbdata.c, along with additional intern=
al restructuring and cleanup. See the ACPICA Reference for interface detail=
s. Lv Zheng.

Added validation of the checksum for all incoming dynamically loaded tables=
 (via external interfaces or via AML Load/LoadTable operators). Lv Zheng.

Updated the use of the AcpiOsWaitEventsComplete interface during Notify and=
 GPE handler removal. Restructured calls to eliminate possible race conditi=
ons. Lv Zheng.

Added a warning for the use/execution of the ASL/AML Unload (table) operato=
r. This will help detect and identify machines that use this operator if an=
d when it is ever used. This operator has never been seen in the field and =
the usage model and possible side-effects of the drastic runtime action of =
a full table removal are unknown.

Reverted the use of #pragma push/pop which was introduced in the 20140214 r=
elease. It appears that push and pop are not implemented by enough compiler=
s to make the use of this feature feasible for ACPICA at this time. However=
, these operators may be deployed in a future ACPICA release.

Added the missing EXPORT_SYMBOL macros for the install and remove SCI handl=
er interfaces.

Source code generation:
1) Disabled the use of the "strchr" macro for the gcc-specific generation. =
For some versions of gcc, this macro can periodically expose a compiler bug=
 which in turn causes compile-time error(s).
2) Added support for PPC64 compilation. Colin Ian King.

Example Code and Data Size: These are the sizes for the OS-independent acpi=
ca.lib produced by the Microsoft Visual C++ 9.0 32-bit compiler. The debug =
version of the code includes the debug output trace mechanism and has a muc=
h larger code and data size.

  Current Release:
    Non-Debug Version:  97.0K Code, 27.2K Data, 124.2K Total
    Debug Version:     189.7K Code, 79.5K Data, 269.2K Total
  Previous Release:
    Non-Debug Version:  96.5K Code, 27.2K Data, 123.7K Total
    Debug Version:     188.6K Code, 79.0K Data, 267.6K Total


2) iASL Compiler/Disassembler and Tools:

Disassembler: Added several new features to improve the readability of the =
resulting ASL code. Extra information is emitted within comment fields in t=
he ASL code:
1) Known _HID/_CID values are decoded to descriptive text.
2) Standard values for the Notify() operator are decoded to descriptive tex=
t.
3) Target operands are expanded to full pathnames (in a comment) when possi=
ble.

Disassembler: Miscellaneous updates for extern() handling:
1) Abort compiler if file specified by -fe option does not exist.
2) Silence unnecessary warnings about argument count mismatches.
3) Update warning messages concerning unresolved method externals.
4) Emit "UnknownObj" keyword for externals whose type cannot be determined.

AcpiHelp utility:
1) Added the -a option to display both the ASL syntax and the AML encoding =
for an input ASL operator. This effectively displays all known information =
about an ASL operator with one AcpiHelp invocation.
2) Added substring match support (similar to a wildcard) for the -i (_HID/P=
NP IDs) option.

iASL/Disassembler: Since this tool does not yet support execution on big-en=
dian machines, added detection of endianness and an error message if execut=
ion is attempted on big-endian. Support for big-endian within iASL is a fea=
ture that is on the ACPICA to-be-done list.

AcpiBin utility:
1) Remove option to extract binary files from an acpidump; this function is=
 made obsolete by the AcpiXtract utility.
2) General cleanup of open files and allocated buffers.


--===============5234226094286799931==--

