Content-Type: multipart/mixed; boundary="===============1503239885886356436=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: [Devel] ACPICA version 20160831 released
Date: Wed, 31 Aug 2016 20:06:30 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37E4F02C4@ORSMSX110.amr.corp.intel.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============1503239885886356436==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

31 August 2016. Summary of changes for version 20160831:

This release is available at https://acpica.org/downloads


1) ACPICA kernel-resident subsystem:

Improve support for the so-called "module-level code", which is defined to =
be math, logical and control AML opcodes that appear outside of any control=
 method. This change improves the support by adding more opcodes that can b=
e executed in the manner. Some other issues have been solved, and the ASL g=
rammar changes to support such code under all scope operators (Device, etc.=
) are complete. Lv Zheng.

UEFI support: these OSL functions have been implemented. This is an additio=
nal step toward supporting the AcpiExec utility natively (with full hardwar=
e access) under UEFI. Marcelo Ferreira.
    AcpiOsReadPciConfiguration
    AcpiOsWritePciConfiguration

Fixed a possible mutex error during control method auto-serialization. Lv Z=
heng.

Updated support for the Generic Address Structure by fully implementing all=
 GAS fields when a 32-bit address is expanded to a 64-bit GAS. Lv Zheng.

Updated the return value for the internal _OSI method. Instead of 0xFFFFFFF=
F, the "Ones" value is now returned, which is 0xFFFFFFFFFFFFFFFF for 64-bit=
 ACPI tables. This fixes an incompatibility with other ACPI implementations=
, and will be reflected and clarified in the next version of the ACPI speci=
fication.

Implemented two new table events that can be passed to an ACPICA table hand=
ler. These events are used to indicate a table installation or uninstallati=
on. These events are used in addition to existed table load and unload even=
ts. Lv Zheng.

Implemented a cleanup for all internal string-to-integer conversions. Conso=
lidate multiple versions of this functionality and limit possible bases to =
either 10 or 16 to simplify the code. Adds a new file, utstrtoul64.

Cleanup the inclusion order of the various compiler-specific headers. This =
simplifies build configuration management. The compiler-specific headers ar=
e now split out from the host-specific headers. Lv Zheng.

Example Code and Data Size: These are the sizes for the OS-independent acpi=
ca.lib produced by the Microsoft Visual C++ 9.0 32-bit compiler. The debug =
version of the code includes the debug output trace mechanism and has a muc=
h larger code and data size.

  Current Release:
    Non-Debug Version: 140.1K Code, 58.1K Data, 198.1K Total
    Debug Version:     200.3K Code, 82.1K Data, 282.4K Total


2) iASL Compiler/Disassembler and Tools:

iASL/AcpiExec: Added a command line option to display the build date/time o=
f the tool (-vd). This can be useful to verify that the correct version of =
the tools are being used.

AML Debugger: Implemented a new subcommand ("execute predef") to execute al=
l predefined control methods and names within the current namespace. This c=
an be useful for debugging problems with ACPI tables and the ACPI namespace.



--===============1503239885886356436==--

