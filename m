Content-Type: multipart/mixed; boundary="===============3308675838921054850=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: [Devel] ACPICA version 20120620 released
Date: Wed, 20 Jun 2012 16:58:16 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E346AEE2D7@ORSMSX101.amr.corp.intel.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============3308675838921054850==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

20 June 2012. Summary of changes for version 20120620:

This release is available at https://www.acpica.org/downloads
The ACPI 5.0 specification is available at www.acpi.info

1) ACPICA Kernel-resident Subsystem:

Implemented support to expand the "implicit notify" feature to allow multip=
le devices to be notified by a single GPE. This feature automatically gener=
ates a runtime device notification in the absence of a BIOS-provided GPE co=
ntrol method (_Lxx/_Exx) or a host-installed handler for the GPE. Implicit =
notify is provided by ACPICA for Windows compatibility, and is a workaround=
 for BIOS AML code errors. See the description of the AcpiSetupGpeForWake i=
nterface in the APCICA reference. Bob Moore, Rafael Wysocki. ACPICA BZ 918.

Changed some comments and internal function names to simplify and ensure co=
rrectness of the Linux code translation. No functional changes.

Example Code and Data Size: These are the sizes for the OS-independent acpi=
ca.lib produced by the Microsoft Visual C++ 9.0 32-bit compiler. The debug =
version of the code includes the debug output trace mechanism and has a muc=
h larger code and data size.

  Previous Release:
    Non-Debug Version:  93.0K Code, 25.1K Data, 118.1K Total
    Debug Version:     172.7K Code, 73.6K Data, 246.3K Total
  Current Release:
    Non-Debug Version:  93.1K Code, 25.1K Data, 118.2K Total
    Debug Version:     172.9K Code, 73.6K Data, 246.5K Total


2) iASL Compiler/Disassembler and Tools:

Disassembler: Added support to emit short, commented descriptions for the A=
CPI predefined names in order to improve the readability of the disassemble=
d output. ACPICA BZ 959. Changes include:
  1) Emit descriptions for all standard predefined names (_INI, _STA, _PRW,=
 etc.)
  2) Emit generic descriptions for the special names (_Exx, _Qxx, etc.)
  3) Emit descriptions for the resource descriptor names (_MIN, _LEN, etc.)

AcpiSrc: Fixed several long-standing Linux code translation issues. Argumen=
t descriptions in function headers are now translated properly to lower cas=
e and underscores. ACPICA BZ 961. Also fixes translation problems such as t=
hese: (old -> new)
  i_aSL -> iASL
  00-7_f -> 00-7F
  16_k -> 16K
  local_fADT -> local_FADT
  execute_oSI -> execute_OSI

iASL: Fixed a problem where null bytes were inadvertently emitted into some=
 listing files.

iASL: Added the existing debug options to the standard help screen. There a=
re no longer two different help screens. ACPICA BZ 957.

AcpiHelp: Fixed some typos in the various predefined name descriptions. Als=
o expand some of the descriptions where appropriate.

iASL: Fixed the -ot option (display compile times/statistics). Was not work=
ing properly for standard output; only worked for the debug file case.


--===============3308675838921054850==--

