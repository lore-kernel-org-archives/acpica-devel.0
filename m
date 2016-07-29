Content-Type: multipart/mixed; boundary="===============3207560519628366217=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: [Devel] ACPICA version 20160729
Date: Fri, 29 Jul 2016 19:23:14 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37E4CE98F@ORSMSX110.amr.corp.intel.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============3207560519628366217==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

29 July 2016. Summary of changes for version 20160729:

This release is available at https://acpica.org/downloads


1) ACPICA kernel-resident subsystem:

Implemented basic UEFI support for the various ACPICA tools. This includes:
1) An OSL to implement the various AcpiOs* interfaces on UEFI.
2) Support to obtain the ACPI tables on UEFI.
3) Local implementation of required C library functions not available on UE=
FI.
4) A front-end (main) function for the tools for UEFI-related initializatio=
n.

The initial deployment of this support is the AcpiDump utility executing as=
 an UEFI application via EDK2 (EDKII, "UEFI Firmware Development Kit"). Cur=
rent environments supported are Linux/Unix. MSVC generation is not supporte=
d at this time. See the generate/efi/README file for build instructions. Lv=
 Zheng.

Future plans include porting the AcpiExec utility to execute natively on th=
e platform with I/O and memory access. This will allow viewing/dump of the =
platform namespace and native execution of ACPI control methods that access=
 the actual hardware. To fully implement this support, the OSL functions be=
low must be implemented with UEFI interfaces. Any community help in the imp=
lementation of these functions would be appreciated:
    AcpiOsReadPort
    AcpiOsWritePort
    AcpiOsReadMemory
    AcpiOsWriteMemory
    AcpiOsReadPciConfiguration
    AcpiOsWritePciConfiguration


Restructured and standardized the C library configuration for ACPICA, resul=
ting in the various configuration options below. This includes a global res=
tructuring of the compiler-dependent and platform-dependent include files. =
These changes may affect the existing platform-dependent configuration file=
s on some hosts. Lv Zheng.

The current C library configuration options appear below. For any issues, i=
t may be helpful to examine the existing compiler-dependent and platform-de=
pendent files as examples. Lv Zheng.

1) Linux kernel:
    ACPI_USE_STANDARD_HEADERS=3Dn in order not to use system-provided C lib=
rary.
    ACPI_USE_SYSTEM_CLIBRARY=3Dy in order not to use ACPICA mini C library.
2) Unix/Windows/BSD applications:
    ACPI_USE_STANDARD_HEADERS=3Dy in order to use system-provided C library.
    ACPI_USE_SYSTEM_CLIBRARY=3Dy in order not to use ACPICA mini C library.
3) UEFI applications:
    ACPI_USE_STANDARD_HEADERS=3Dn in order not to use system-provided C lib=
rary.
    ACPI_USE_SYSTEM_CLIBRARY=3Dn in order to use ACPICA mini C library.
4) UEFI applications (EDK2/StdLib):
    ACPI_USE_STANDARD_HEADERS=3Dy in order to use EDK2 StdLib C library.
    ACPI_USE_SYSTEM_CLIBRARY=3Dy in order to use EDK2 StdLib C library.


AML interpreter: "module-level code" support. Allows for execution of so-ca=
lled "executable" AML code (math/logical operations, etc.) outside of contr=
ol methods not just at the module level (top level) but also within any sco=
pe declared outside of a control method - Scope{}, Device{}, Processor{}, P=
owerResource{}, and ThermalZone{}. Lv Zheng.

Simplified the configuration of the "maximum AML loops" global option by ad=
ding a global public variable, "AcpiGbl_MaxLoopIterations" which can be mod=
ified at runtime.


Example Code and Data Size: These are the sizes for the OS-independent acpi=
ca.lib produced by the Microsoft Visual C++ 9.0 32-bit compiler. The debug =
version of the code includes the debug output trace mechanism and has a muc=
h larger code and data size.

  Current Release:
    Non-Debug Version: 139.1K Code, 22.9K Data, 162.0K Total
    Debug Version:     199.0K Code, 81.8K Data, 280.8K Total


2) iASL Compiler/Disassembler and Tools:

iASL: Add full support for the RASF ACPI table (RAS Features Table). Includ=
es disassembler, data table compiler, and header support.

iASL Expand "module-level code" support. Allows for compilation/disassembly=
 of so-called "executable" AML code (math/logical operations, etc.) outside=
 of control methods not just at the module level (top level) but also withi=
n any scope declared outside of a control method - Scope{}, Device{}, Proce=
ssor{}, PowerResource{}, and ThermalZone{}.

AcpiDump: Added support for dumping all SSDTs on newer versions of Windows.=
 These tables are now easily available -- SSDTs are not available through t=
he registry on older versions.


--===============3207560519628366217==--

