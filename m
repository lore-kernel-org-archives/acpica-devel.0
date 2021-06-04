Content-Type: multipart/mixed; boundary="===============9073152931277465101=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: [Devel] ACPICA version 20210604 released
Date: Fri, 04 Jun 2021 19:33:05 +0000
Message-ID: <BYAPR11MB3256F9C9067344F0AEBE40F4873B9@BYAPR11MB3256.namprd11.prod.outlook.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============9073152931277465101==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

04 June 2021. Summary of changes for version 20210604:

This release is available at https://acpica.org/downloads

1) ACPICA kernel-resident subsystem:

Cleaned up (delete) the context mutex during local address handler object d=
eletion.

Fixed a memory leak caused by the _CID repair function.

Added support for PlatformRtMechanism OperationRegion handler. Adds a new u=
tility function, AcpiUtConvertUuidToString. Writing a buffer to a PlatformR=
tMechanism fieldunit invokes a bidirectional transaction. The input buffer =
contains 26 bytes containing 9 bytes of status, a command byte and a 16-byt=
e UUID. This change will simply pass this incoming buffer to a handler regi=
stered by the OS.

2) iASL Compiler/Disassembler and ACPICA tools:

Added full support for the PRMT ACPI table (Platform Runtime Mechanism Tabl=
e). Includes support in the iASL compiler, the disassembler, and the templa=
te generator.

Added full support for the BDAT (BIOS Data ACPI Table) ACPI table.

Added full support for the RGRT (Regulatory Graphics Resource Table) ACPI t=
able.

Added full support for the SVKL (Storage Volume Key Location Table) ACPI ta=
ble. Header file support from Kuppuswamy Sathyanarayanan <sathyanarayanan.k=
uppuswamy(a)linux.intel.com>.

Completed full support for the IVRS (I/O Virtualization Reporting Structure=
) ACPI table. Added compiler support for IVRS, updated disassembler support=
. Adds a new utility, UtIsIdInteger, to determine if a HID/CID is an intege=
r or a string.

Headers: Added more structs to the CEDT table: CXL fixed memory window stru=
cture.

ACPI 6.4: MADT: added Multiprocessor Wakeup Mailbox Structure.


--===============9073152931277465101==--

