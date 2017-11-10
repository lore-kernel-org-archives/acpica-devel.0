Content-Type: multipart/mixed; boundary="===============0518874937156286048=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: [Devel] ACPICA version 20171110 released
Date: Fri, 10 Nov 2017 17:05:34 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37E618D7F@ORSMSX110.amr.corp.intel.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============0518874937156286048==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

10 November 2017. Summary of changes for version 20171110:

This release is available at https://acpica.org/downloads


1) ACPICA kernel-resident subsystem:

This release implements full support for ACPI 6.2A:
    NFIT - Added a new subtable, "Platform Capabilities Structure"
No other changes to ACPICA were required, since ACPI 6.2A is primarily an e=
rrata release of the specification.

Other ACPI table changes:
    IORT: Added the SMMUv3 Device ID mapping index. Hanjun Guo
    PPTT: Added cache attribute flag definitions to actbl1.h. Jeremy Linton

Utilities: Modified the string/integer conversion functions to use internal=
 64-bit divide support instead of a native divide. On 32-bit platforms, a 6=
4-bit divide typically requires a library function which may not be present=
 in the build (kernel or otherwise).

Implemented a targeted error message for timeouts returned from the Embedde=
d Controller device driver. This is seen frequently enough to special-case =
an AE_TIME returned from an EC operation region access:
    "Timeout from EC hardware or EC device driver"

Changed the "ACPI Exception" message prefix to "ACPI Error" so that all run=
time error messages have the identical prefix.


2) iASL Compiler/Disassembler and Tools:

AcpiXtract: Fixed a problem with table header detection within the acpidump=
 file. Processing a table could be ended early if a 0x40 (@) appears in the=
 original binary table, resulting in the @ symbol appearing in the decoded =
ASCII field at the end of the acpidump text line. The symbol caused acpixtr=
act to incorrectly think it had reached the end of the current table and th=
e beginning of a new table.

AcpiXtract: Added an option (-f) to ignore some errors during table extract=
ion. This initial implementation ignores non-ASCII and non-printable charac=
ters found in the acpidump text file.

TestSuite(ASLTS)/AcpiExec: Fixed and restored the memory usage statistics f=
or ASLTS. This feature is used to track memory allocations from different m=
emory caches within the ACPICA code. At the end of an ASLTS run, these memo=
ry statistics are recorded and stored in a log file.

Debugger (user-space version): Implemented a simple "Background" command. C=
reates a new thread to execute a control method in the background, while co=
ntrol returns to the debugger prompt to allow additional commands.
    Syntax: Background <Namepath> [Arguments]


--===============0518874937156286048==--

