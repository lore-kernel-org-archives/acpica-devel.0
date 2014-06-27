Content-Type: multipart/mixed; boundary="===============5955746531509071160=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: [Devel] ACPICA version 20140627 released
Date: Fri, 27 Jun 2014 16:13:24 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37D1BD921@ORSMSX112.amr.corp.intel.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============5955746531509071160==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

27 June 2014. Summary of changes for version 20140627:

This release is available at https://acpica.org/downloads

1) ACPICA kernel-resident subsystem:

Formatted Output: Implemented local versions of standard formatted output u=
tilities such as printf, etc. Over time, it has been discovered that there =
are in fact many portability issues with printf, and the addition of this f=
eature will fix/prevent these issues once and for all. Some known issues ar=
e summarized below:

1) Output of 64-bit values is not portable. For example, UINT64 is %ull for=
 the Linux kernel and is %uI64 for some MSVC versions.
2) Invoking printf consistently in a manner that is portable across both 32=
-bit and 64-bit platforms is difficult at best in many situations.
3) The output format for pointers varies from system to system (leading zer=
os especially), and leads to inconsistent output from ACPICA across platfor=
ms.
4) Certain platform-specific printf formats may conflict with ACPICA use.
5) If there is no local C library available, ACPICA now has local support f=
or printf.

-- To address these printf issues in a complete manner, ACPICA now directly=
 implements a small subset of printf format specifiers, only those that it =
requires. Adds a new file, utilities/utprint.c. Lv Zheng.

Implemented support for ACPICA generation within the EFI environment. Initi=
ally, the AcpiDump utility is supported in the UEFI shell environment. Lv Z=
heng.

Added a new external interface, AcpiLogError, to improve ACPICA portability=
. This allows the host to redirect error messages from the ACPICA utilities=
. Lv Zheng.

Added and deployed new OSL file I/O interfaces to improve ACPICA portabilit=
y:
  AcpiOsOpenFile
  AcpiOsCloseFile
  AcpiOsReadFile
  AcpiOsWriteFile
  AcpiOsGetFileOffset
  AcpiOsSetFileOffset
There are C library implementations of these functions in the new file serv=
ice_layers/oslibcfs.c -- however, the functions can be implemented by the l=
ocal host in any way necessary. Lv Zheng.

Implemented a mechanism to disable/enable ACPI table checksum validation at=
 runtime. This can be useful when loading tables very early during OS initi=
alization when it may not be possible to map the entire table in order to c=
ompute the checksum. Lv Zheng.

Fixed a buffer allocation issue for the Generic Serial Bus support. Origina=
lly, a fixed buffer length was used. This change allows for variable-length=
 buffers based upon the protocol indicated by the field access attributes. =
Reported by Lan Tianyu. Lv Zheng.

Fixed a problem where an object detached from a namespace node was not prop=
erly terminated/cleared and could cause a circular list problem if reattach=
ed. ACPICA BZ 1063. David Box.

Fixed a possible recursive lock acquisition in hwregs.c. Rakib Mullick.

Fixed a possible memory leak in an error return path within the function Ac=
piUtCopyIobjectToIobject. ACPICA BZ 1087. Colin Ian King.

Example Code and Data Size: These are the sizes for the OS-independent acpi=
ca.lib produced by the Microsoft Visual C++ 9.0 32-bit compiler. The debug =
version of the code includes the debug output trace mechanism and has a muc=
h larger code and data size.

  Current Release:
    Non-Debug Version:  98.7K Code, 27.2K Data, 125.9K Total
    Debug Version:     191.7K Code, 79.6K Data, 271.3K Total
  Previous Release:
    Non-Debug Version:  96.8K Code, 27.2K Data, 124.0K Total
    Debug Version:     189.5K Code, 79.7K Data, 269.2K Total


2) iASL Compiler/Disassembler and Tools:

Disassembler: Add dump of ASCII equivalent text within a comment at the end=
 of each line of the output for the Buffer() ASL operator.

AcpiDump: Miscellaneous changes:
  Fixed repetitive table dump in -n mode.
  For older EFI platforms, use the ACPI 1.0 GUID during RSDP search if the =
ACPI 2.0 GUID fails.

iASL: Fixed a problem where the compiler could fault if incorrectly given a=
n acpidump output file as input. ACPICA BZ 1088. David Box.

AcpiExec/AcpiNames: Fixed a problem where these utilities could fault if th=
ey are invoked without any arguments.

Debugger: Fixed a possible memory leak in an error return path. ACPICA BZ 1=
086. Colin Ian King.

Disassembler: Cleaned up a block of code that extracts a parent Op object. =
Added a comment that explains that the parent is guaranteed to be valid in =
this case. ACPICA BZ 1069.


--===============5955746531509071160==--

