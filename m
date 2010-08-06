Content-Type: multipart/mixed; boundary="===============8548111523945247654=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: [Devel] ACPICA version 20100806 released
Date: Fri, 06 Aug 2010 12:50:39 -0700
Message-ID: <4911F71203A09E4D9981D27F9D830858AC62CC96@orsmsx503.amr.corp.intel.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============8548111523945247654==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

06 August 2010. Summary of changes for version 20100806:

This release is available at www.acpica.org/downloads

1) ACPI CA Core Subsystem:

Designed and implemented a new host interface to the _OSI support code. Thi=
s will allow the host to dynamically add or remove multiple _OSI strings, a=
s well as install an optional handler that is called for each _OSI invocati=
on. Also added a new AML debugger command, 'osi' to display and modify the =
global _OSI string table, and test support in the AcpiExec utility. See the=
 ACPICA reference manual for full details. Lin Ming, Bob Moore. ACPICA BZ 8=
36.
New Functions:
    AcpiInstallInterface - Add an _OSI string.
    AcpiRemoveInterface - Delete an _OSI string.
    AcpiInstallInterfaceHandler - Install optional _OSI handler.
Obsolete Functions:
    AcpiOsValidateInterface - no longer used.
New Files:
    source/components/utilities/utosi.c

Re-introduced the support to enable multi-byte transfers for Embedded Contr=
oller (EC) operation regions. A reported problem was found to be a bug in t=
he host OS, not in the multi-byte support. Previously, the maximum data siz=
e passed to the EC operation region handler was a single byte. There are of=
ten EC Fields larger than one byte that need to be transferred, and it is u=
seful for the EC driver to lock these as a single transaction. This change =
enables single transfers larger than 8 bits. This effectively changes the a=
ccess to the EC space from ByteAcc to AnyAcc, and will probably require cha=
nges to the host OS Embedded Controller driver to enable 16/32/64/256-bit t=
ransfers in addition to 8-bit transfers. Alexey Starikovskiy, Lin Ming.

Fixed a problem with the prototype for AcpiOsReadPciConfiguration. The prot=
otype in acpiosxf.h had the output value pointer as a (void *).
It should be a (UINT64 *). This may affect some host OSL code.

Fixed a couple problems with the recently modified Linux makefiles for iASL=
 and AcpiExec. These new makefiles place the generated object files in the =
local directory so that there can be no collisions between the files that a=
re shared between them that are compiled with different options.

Example Code and Data Size: These are the sizes for the OS-independent acpi=
ca.lib produced by the Microsoft Visual C++ 6.0 32-bit compiler. The debug =
version of the code includes the debug output trace mechanism and has a muc=
h larger code and data size.

  Previous Release:
    Non-Debug Version:  88.3K Code, 18.8K Data, 107.1K Total
    Debug Version:     164.0K Code, 51.5K Data, 215.5K Total
  Current Release:
    Non-Debug Version:  89.1K Code, 19.0K Data, 108.1K Total
    Debug Version:     165.1K Code, 51.9K Data, 217.0K Total

2) iASL Compiler/Disassembler and Tools:

iASL/Disassembler: Added a new option (-da, "disassemble all") to load the =
namespace from and disassemble an entire group of AML files. Useful for loa=
ding all of the AML tables for a given machine (DSDT, SSDT1...SSDTn) and di=
sassembling with one simple command. ACPICA BZ 865. Lin Ming.

iASL: Allow multiple invocations of -e option. This change allows multiple =
uses of -e on the command line: "-e ssdt1.dat -e ssdt2.dat". ACPICA BZ 834.=
 Lin Ming.


--===============8548111523945247654==--

