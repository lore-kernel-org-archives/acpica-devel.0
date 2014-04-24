Content-Type: multipart/mixed; boundary="===============4114826748105224343=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: [Devel] ACPICA version 20140424 released
Date: Thu, 24 Apr 2014 16:11:36 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37D1AE24D@ORSMSX112.amr.corp.intel.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============4114826748105224343==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

24 April 2014. Summary of changes for version 20140424:

This release is available at https://acpica.org/downloads

1) ACPICA kernel-resident subsystem:

Implemented support to skip/ignore NULL address entries in the RSDT/XSDT. S=
ome of these tables are known to contain a trailing NULL entry. Lv Zheng.

Removed an extraneous error message for the case where there are a large nu=
mber of system GPEs (> 124). This was the "32-bit FADT register is too long=
 to convert to GAS struct" message, which is irrelevant for GPEs since the =
GPEx_BLK_LEN fields of the FADT are always used instead of the (limited cap=
acity) GAS bit length. Also, several changes to ensure proper support for G=
PE numbers > 255, where some "GPE number" fields were 8-bits internally.

Implemented and deployed additional configuration support for the public AC=
PICA external interfaces. Entire classes of interfaces can now be easily mo=
dified or configured out, replaced by stubbed inline functions by default. =
Lv Zheng.

Moved all public ACPICA runtime configuration globals to the public ACPICA =
external interface file for convenience. Also, removed some obsolete/unused=
 globals. See the file acpixf.h. Lv Zheng.

Documentation: Added a new section to the ACPICA reference describing the m=
aximum number of GPEs that can be supported by the FADT-defined GPEs in blo=
ck zero and one. About 1200 total. See section 4.4.1 of the ACPICA referenc=
e.

Example Code and Data Size: These are the sizes for the OS-independent acpi=
ca.lib produced by the Microsoft Visual C++ 9.0 32-bit compiler. The debug =
version of the code includes the debug output trace mechanism and has a muc=
h larger code and data size.

  Current Release:
    Non-Debug Version:  96.8K Code, 27.2K Data, 124.0K Total
    Debug Version:     189.5K Code, 79.7K Data, 269.2K Total
  Previous Release:
    Non-Debug Version:  97.0K Code, 27.2K Data, 124.2K Total
    Debug Version:     189.7K Code, 79.5K Data, 269.2K Total


2) iASL Compiler/Disassembler and Tools:

iASL and disassembler: Add full support for the LPIT table (Low Power Idle =
Table). Includes support in the disassembler, data table compiler, and temp=
late generator.

AcpiDump utility:
1) Add option to force the use of the RSDT (over the XSDT).
2) Improve validation of the RSDP signature (use 8 chars instead of 4).

iASL: Add check for predefined packages that are too large.  For predefined=
 names that contain subpackages, check if each subpackage is too large. (Ch=
eck for too small already exists.)

Debugger: Updated the GPE command (which simulates a GPE by executing the G=
PE code paths in ACPICA). The GPE device is now optional, and defaults to t=
he GPE 0/1 FADT-defined blocks.

Unix application OSL: Update line-editing support. Add additional error che=
cking and take care not to reset terminal attributes on exit if they were n=
ever set. This should help guarantee that the terminal is always left in th=
e previous state on program exit.


--===============4114826748105224343==--

