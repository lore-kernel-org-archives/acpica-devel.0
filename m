Content-Type: multipart/mixed; boundary="===============8893688727183600420=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: [Devel] ACPICA version 20210730 released
Date: Fri, 30 Jul 2021 15:57:50 +0000
Message-ID: <BYAPR11MB3256B88F2E195AFC3B57837387EC9@BYAPR11MB3256.namprd11.prod.outlook.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============8893688727183600420==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

30 July 2021. Summary of changes for version 20210730:

This release is available at https://acpica.org/downloads

1) ACPICA kernel-resident subsystem:

2) iASL Compiler/Disassembler and ACPICA tools:

iasl: Check usage of _CRS, _DIS, _PRS, and _SRS objects (July 2021).
  Under the Device Object:
  1) If _DIS is present, must have a _CRS and _SRS
  2) If _PRS is present, must have a _CRS, _DIS, and _SRS
  3) If _SRS is present, must have a _CRS and _DIS
A warning will be issued for each of these cases.
Note: For existing ASL/projects, these warnings may be disabled by specifyi=
ng this on the command line:
"-vw 3141"

iASL Table Disassembler/Table compiler: Fix for WPBT table with no
command-line arguments. Handle the case where the Command-line
Arguments table field does not exist (zero).

Headers: Add new DBG2 Serial Port Subtypes
The Microsoft Debug Port Table 2 (DBG2) specification revision
September 21, 2020 comprises additional Serial Port Subtypes [1].
Reflect that in the actbl1.h header file. Submitted by:
semihalf-wojtas-marcin

iASL: Add full support for the AEST table (data compiler)
Includes support in the table compiler and the disassembler.

Add PRMT module header to facilitate parsing.
This structure is used in to parse PRMT in other Operating Systems
that relies on using subtable headers in order to parse ACPI tables.
Although the PRMT doesn't have "subtables" it has a list of module
information structures that act as subtables.

iASL: Table disassembler: Add missing strings to decode subtable types.
Includes the MADT and CEDT tables.

--===============8893688727183600420==--

