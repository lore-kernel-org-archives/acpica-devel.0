Content-Type: multipart/mixed; boundary="===============4761687455943000979=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: [Devel] ACPICA version 20120711 released
Date: Wed, 11 Jul 2012 16:29:37 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E346B0D3B4@ORSMSX101.amr.corp.intel.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============4761687455943000979==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

11 July 2012. Summary of changes for version 20120711:

This release is available at https://www.acpica.org/downloads The ACPI 5.0 =
specification is available at www.acpi.info

1) ACPICA Kernel-resident Subsystem:

Fixed a possible fault in the return package object repair code. Fixes a pr=
oblem that can occur when a lone package object is wrapped with an outer pa=
ckage object in order to force conformance to the ACPI specification. Can a=
ffect these predefined names: _ALR, _MLS, _PSS, _TRT, _TSS, _PRT, _HPX, _DL=
M, _CSD, _PSD, _TSD.

Removed code to disable/enable bus master arbitration (ARB_DIS bit in the P=
M2_CNT register) in the ACPICA sleep/wake interfaces. Management of the ARB=
_DIS bit must be implemented in the host-dependent C3 processor power state=
 support. Note, ARB_DIS is obsolete and only applies to older chipsets, bot=
h Intel and other vendors. (for Intel: ICH4-M and earlier)

This change removes the code to disable/enable bus master arbitration durin=
g suspend/resume. Use of the ARB_DIS bit in the optional PM2_CNT register c=
auses resume problems on some machines. The change has been in use for over=
 seven years within Linux.

Implemented two new external interfaces to support host-directed dynamic AC=
PI table load and unload. They are intended to simplify the host implementa=
tion of hot-plug support:
  AcpiLoadTable: Load an SSDT from a buffer into the namespace.
  AcpiUnloadParentTable: Unload an SSDT via a named object owned by the tab=
le.
See the ACPICA reference for additional details. Adds one new file, compone=
nts/tables/tbxfload.c

Implemented and deployed two new interfaces for errors and warnings that ar=
e known to be caused by BIOS/firmware issues:
  AcpiBiosError: Prints "ACPI Firmware Error" message.
  AcpiBiosWarning: Prints "ACPI Firmware Warning" message.
Deployed these new interfaces in the ACPICA Table Manager code for ACPI tab=
le and FADT errors. Additional deployment to be completed as appropriate in=
 the future. The associated conditional macros are ACPI_BIOS_ERROR and ACPI=
_BIOS_WARNING. See the ACPICA reference for additional details. ACPICA BZ 8=
43.

Implicit notify support: ensure that no memory allocation occurs within a c=
ritical region. This fix moves a memory allocation outside of the time that=
 a spinlock is held. Fixes issues on systems that do not allow this behavio=
r. Jung-uk Kim.

Split exception code utilities and tables into a new file, utilities/utexce=
p.c

Example Code and Data Size: These are the sizes for the OS-independent acpi=
ca.lib produced by the Microsoft Visual C++ 9.0 32-bit compiler. The debug =
version of the code includes the debug output trace mechanism and has a muc=
h larger code and data size.

  Previous Release:
    Non-Debug Version:  93.1K Code, 25.1K Data, 118.2K Total
    Debug Version:     172.9K Code, 73.6K Data, 246.5K Total
  Current Release:
    Non-Debug Version:  93.5K Code, 25.3K Data, 118.8K Total
    Debug Version:     173.7K Code, 74.0K Data, 247.7K Total


2) iASL Compiler/Disassembler and Tools:

iASL: Fixed a parser problem for hosts where EOF is defined as -1 instead o=
f 0. Jung-uk Kim.

Debugger: Enhanced the "tables" command to emit additional information abou=
t the current set of ACPI tables, including the owner ID and flags decode.

Debugger: Reimplemented the "unload" command to use the new AcpiUnloadParen=
tTable external interface. This command was disable previously due to need =
for an unload interface.

AcpiHelp: Added a new option to decode ACPICA exception codes. The -e optio=
n will decode 16-bit hex status codes (ACPI_STATUS) to name strings.


--===============4761687455943000979==--

