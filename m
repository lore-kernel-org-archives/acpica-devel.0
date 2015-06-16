Content-Type: multipart/mixed; boundary="===============6379107774444657283=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: [Devel] ACPICA version 20150616 released
Date: Tue, 16 Jun 2015 19:11:22 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37D300481@ORSMSX112.amr.corp.intel.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============6379107774444657283==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

16 June 2015. Summary of changes for version 20150616:

This release is available at https://acpica.org/downloads

1) ACPICA kernel-resident subsystem:

Across the entire ACPICA source code base, the various macros for the C lib=
rary functions (such as ACPI_STRLEN, etc.) have been removed and replaced b=
y the standard C library names (strlen, etc.) The original purpose for thes=
e macros is no longer applicable. This simplification reduces the number of=
 macros used in the ACPICA source code significantly, improving readability=
 and maintainability.

Implemented support for a new ACPI table, the OSDT. This table, the "overri=
de" SDT, can be loaded directly by the host OS at boot time. It enables the=
 replacement of existing namespace objects that were installed via the DSDT=
 and/or SSDTs. The primary purpose for this is to replace buggy or incorrec=
t ASL/AML code obtained via the BIOS. The OSDT is slated for inclusion in a=
 future version of the ACPI Specification. Lv Zheng/Bob Moore.

Added support for systems with (improperly) two FACS tables -- a "32-bit" t=
able (via FADT 32-bit legacy field) and a "64-bit" table (via the 64-bit X =
field). This change will support both automatically. There continues to be =
systems found with this issue. This support requires a change to the AcpiSe=
tFirmwareWakingVector interface. Also, a public global variable has been ad=
ded to allow the host to select which FACS is desired (AcpiGbl_Use32BitFacs=
Addresses). See the ACPICA reference for more details Lv Zheng.

Added a new feature to allow for systems that do not contain an FACS. Altho=
ugh this is already supported on hardware-reduced platforms, the feature ha=
s been extended for all platforms. The reasoning is that we do not want to =
abort the entire ACPICA initialization just because the system is seriously=
 buggy and has no FACS.

Fixed a problem where the GUID strings for NFIT tables (in acuuid.h) were n=
ot correctly transcribed from the ACPI specification in ACPICA version 2015=
0515.

Implemented support for the _CLS object in the AcpiGetObjectInfo external i=
nterface.

Updated the definitions of the TCPA and TPM2 ACPI tables to the more recent=
 TCG ACPI Specification, December 14, 2014. Table disassembler and compiler=
 also updated. Note: The TCPA "server" table is not supported by the disass=
embler/table-compiler at this time.

ACPI 6.0: Added definitions for the new GIC version field in the MADT.

Example Code and Data Size: These are the sizes for the OS-independent acpi=
ca.lib produced by the Microsoft Visual C++ 9.0 32-bit compiler. The debug =
version of the code includes the debug output trace mechanism and has a muc=
h larger code and data size.

  Current Release:
    Non-Debug Version: 100.6K Code, 27.6K Data, 128.2K Total
    Debug Version:     196.2K Code, 81.0K Data, 277.2K Total
  Previous Release:
    Non-Debug Version:  99.9K Code, 27.5K Data, 127.4K Total
    Debug Version:     195.2K Code, 80.8K Data, 276.0K Total


2) iASL Compiler/Disassembler and Tools:

Disassembler: Fixed a problem with the new symbolic operator disassembler w=
here incorrect ASL code could be emitted in some cases for the "non-commuta=
tive" operators -- Subtract, Divide, Modulo, ShiftLeft, and ShiftRight. The=
 actual problem cases seem to be rather unusual in common ASL code, however=
. David Box.

Modified the linux version of acpidump to obtain ACPI tables from not just =
/dev/mem (which may not exist) and /sys/firmware/acpi/tables. Lv Zheng.

iASL: Fixed a problem where the user preprocessor output file (.i) containe=
d extra data that was not expected. The compiler was using this file as a t=
emporary file and passed through #line directives in order to keep compiler=
 error messages in sync with the input file and line number across multiple=
 include files. The (.i) is no longer a temporary file as the compiler uses=
 a new, different file for the original purpose.

iASL: Fixed a problem where comments within the original ASL source code fi=
le were not passed through to the preprocessor output file, nor any listing=
 files.

iASL: Fixed some issues for the handling of the "#include" preprocessor dir=
ective and the similar (but not the same) "Include" ASL operator.

iASL: Add support for the new OSDT in both the disassembler and compiler.

iASL: Fixed a problem with the constant folding support where a Buffer obje=
ct could be incorrectly generated (incorrectly formed) during a conversion =
to a Store() operator.

AcpiHelp: Updated for new NFIT GUIDs, "External" AML opcode, and new descri=
ption text for the _REV predefined name. _REV now permanently returns 2, as=
 per the ACPI 6.0 specification.

Debugger: Enhanced the output of the Debug ASL object for references produc=
ed by the Index operator. For Buffers and strings, only output the actual b=
yte pointed to by the index. For packages, only print the single package el=
ement decoded by the index. Previously, the entire buffer/string/package wa=
s emitted.

iASL/Table-compiler: Fixed a regression where the "generic" data types were=
 no longer recognized, causing errors.



--===============6379107774444657283==--

