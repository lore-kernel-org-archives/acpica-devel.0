Content-Type: multipart/mixed; boundary="===============2228563223515157349=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: [Devel] ACPICA version 20130117 released
Date: Thu, 17 Jan 2013 20:48:04 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E357E5248D@ORSMSX101.amr.corp.intel.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============2228563223515157349==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

17 January 2013. Summary of changes for version 20130117:

This release is available at https://www.acpica.org/downloads
The ACPI 5.0 specification is available at www.acpi.info

1) ACPICA Kernel-resident Subsystem:

Updated the AcpiGetSleepTypeData interface: Allow the \_Sx methods to retur=
n either 1 or 2 integers. Although the ACPI spec defines the \_Sx objects t=
o return a package containing one integer, most BIOS code returns two integ=
ers and the previous code reflects that. However, we also need to support B=
IOS code that actually implements to the ACPI spec, and this change reflect=
s this.

Fixed two issues with the ACPI_DEBUG_PRINT macros:
1) Added the ACPI_DO_WHILE macro to the main DEBUG_PRINT helper macro for C=
 compilers that require this support.
2) Renamed the internal ACPI_DEBUG macro to ACPI_DO_DEBUG_PRINT since ACPI_=
DEBUG is already used by many of the various hosts.

Updated all ACPICA copyrights and signons to 2013. Added the 2013 copyright=
 to all module headers and signons, including the standard Linux header. Th=
is affects virtually every file in the ACPICA core subsystem, iASL compiler=
, all ACPICA utilities, and the test suites.

Example Code and Data Size: These are the sizes for the OS-independent acpi=
ca.lib produced by the Microsoft Visual C++ 9.0 32-bit compiler. The debug =
version of the code includes the debug output trace mechanism and has a muc=
h larger code and data size.

  Previous Release:
    Non-Debug Version:  94.5K Code, 25.5K Data, 120.0K Total
    Debug Version:     182.2K Code, 74.9K Data, 257.1K Total
  Current Release:
    Non-Debug Version:  94.5K Code, 25.4K Data, 119.9K Total
    Debug Version:     182.3K Code, 75.0K Data, 257.3K Total


2) iASL Compiler/Disassembler and Tools:

Generic Unix OSL: Use a buffer to eliminate multiple vfprintf()s and preven=
t a possible fault on some hosts. Some C libraries modify the arg pointer p=
arameter to vfprintf making it difficult to call it twice in the AcpiOsVpri=
ntf function. Use a local buffer to workaround this issue. This does not af=
fect the Windows OSL since the Win C library does not modify the arg pointe=
r. Chao Guan, Bob Moore.

iASL: Fixed a possible infinite loop when the maximum error count is reache=
d. If an output file other than the .AML file is specified (such as a listi=
ng file), and the maximum number of errors is reached, do not attempt to fl=
ush data to the output file(s) as the compiler is aborting. This can cause =
an infinite loop as the max error count code essentially keeps calling itse=
lf.

iASL/Disassembler: Added an option (-in) to ignore NOOP opcodes/operators. =
Implemented for both the compiler and the disassembler. Often, the NOOP opc=
ode is used as padding for packages that are changed dynamically by the BIO=
S. When disassembled and recompiled, these NOOPs will cause syntax errors. =
This option causes the disassembler to ignore all NOOP opcodes (0xA3), and =
it also causes the compiler to ignore all ASL source code NOOP statements a=
s well.

Debugger: Enhanced the Sleep command to execute all sleep states. This chan=
ge allows Sleep to be invoked with no arguments and causes the debugger to =
execute all of the sleep states, 0-5, automatically.


--===============2228563223515157349==--

