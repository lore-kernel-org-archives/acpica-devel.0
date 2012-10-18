Content-Type: multipart/mixed; boundary="===============5572930807526463565=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: [Devel] ACPICA version 20121018 released
Date: Thu, 18 Oct 2012 20:07:18 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E346BA4F38@ORSMSX101.amr.corp.intel.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============5572930807526463565==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

18 October 2012. Summary of changes for version 20121018:

This release is available at https://www.acpica.org/downloads
The ACPI 5.0 specification is available at www.acpi.info

1) ACPICA Kernel-resident Subsystem:

Updated support for the ACPI 5.0 MPST table. Fixes some problems introduced=
 by late changes to the table as it was added to the ACPI 5.0 specification=
. Includes header, disassembler, and data table compiler support as well as=
 a new version of the MPST template.

AcpiGetObjectInfo: Enhanced the device object support to include the ACPI 5=
.0 _SUB method. Now calls _SUB in addition to the other PNP-related ID meth=
ods: _HID, _CID, and _UID.

Changed ACPI_DEVICE_ID to ACPI_PNP_DEVICE_ID. Also changed ACPI_DEVICE_ID_L=
IST to ACPI_PNP_DEVICE_ID_LIST. These changes prevent name collisions on ho=
sts that reserve the *_DEVICE_ID (or *DeviceId) names for their various dri=
vers. Affects the AcpiGetObjectInfo external interface, and other internal =
interfaces as well.

Added and deployed a new macro for ACPI_NAME management: ACPI_MOVE_NAME. Th=
is macro resolves to a simple 32-bit move of the 4-character ACPI_NAME on m=
achines that support non-aligned transfers. Optimizes for this case rather =
than using a strncpy. With assistance from Zheng Lv.

Resource Manager: Small fix for buffer size calculation. Fixed a one byte e=
rror in the output buffer calculation. Feng Tang. ACPICA BZ 849.

Added a new debug print message for AML mutex objects that are force-releas=
ed. At control method termination, any currently acquired mutex objects are=
 force-released. Adds a new debug-only message for each one that is release=
d.

Audited/updated all ACPICA return macros and the function debug depth count=
er: 1) Ensure that all functions that use the various TRACE macros also use=
 the appropriate ACPICA return macros. 2) Ensure that all normal return sta=
tements surround the return expression (value) with parens to ensure consis=
tency across the ACPICA code base. Guan Chao, Tang Feng, Zheng Lv, Bob Moor=
e. ACPICA Bugzilla 972.

Global source code changes/maintenance: All extra lines at the start and en=
d of each source file have been removed for consistency. Also, within comme=
nts, all new sentences start with a single space instead of a double space,=
 again for consistency across the code base.

Example Code and Data Size: These are the sizes for the OS-independent acpi=
ca.lib produced by the Microsoft Visual C++ 9.0 32-bit compiler. The debug =
version of the code includes the debug output trace mechanism and has a muc=
h larger code and data size.

  Previous Release:
    Non-Debug Version:  93.7K Code, 25.3K Data, 119.0K Total
    Debug Version:     175.0K Code, 74.4K Data, 249.4K Total
  Current Release:
    Non-Debug Version:  93.9K Code, 25.2K Data, 119.1K Total
    Debug Version:     175.5K Code, 74.5K Data, 250.0K Total


2) iASL Compiler/Disassembler and Tools:

AcpiExec: Improved the algorithm used for memory leak/corruption detection.=
 Added some intelligence to the code that maintains the global list of allo=
cated memory. The list is now ordered by allocated memory address, signific=
antly improving performance. When running AcpiExec on the ASLTS test suite,=
 speed improvements of 3X to 5X are seen, depending on the platform and/or =
the environment. Note, this performance enhancement affects the AcpiExec ut=
ility only, not the kernel-resident ACPICA code.

Enhanced error reporting for invalid AML opcodes and bad ACPI_NAMEs. For th=
e disassembler, dump the 48 bytes surrounding the invalid opcode. Fix incor=
rect table offset reported for invalid opcodes. Report the original 32-bit =
value for bad ACPI_NAMEs (as well as the repaired name.)

Disassembler: Enhanced the -vt option to emit the binary table data in hex =
format to assist with debugging.

Fixed a potential filename buffer overflow in osunixdir.c. Increased the si=
ze of file structure. Colin Ian King.


--===============5572930807526463565==--

