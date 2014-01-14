Content-Type: multipart/mixed; boundary="===============2374642491442480478=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: [Devel] ACPICA version 20140114 released
Date: Tue, 14 Jan 2014 22:35:51 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37C7BF3B0@ORSMSX103.amr.corp.intel.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============2374642491442480478==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

14 January 2014. Summary of changes for version 20140114:

This release is available at https://acpica.org/downloads

1) ACPICA kernel-resident subsystem:

Updated all ACPICA copyrights and signons to 2014. Added the 2014 copyright=
 to all module headers and signons, including the standard Linux header. Th=
is affects virtually every file in the ACPICA core subsystem, iASL compiler=
, all ACPICA utilities, and the test suites.

Improved parameter validation for AcpiInstallGpeBlock. Added the following =
checks:
1) The incoming device handle refers to type ACPI_TYPE_DEVICE.
2) There is not already a GPE block attached to the device.
Likewise, with AcpiRemoveGpeBlock, ensure that the incoming object is a dev=
ice.

Correctly support "references" in the ACPI_OBJECT. This change fixes the su=
pport to allow references (namespace nodes) to be passed as arguments to co=
ntrol methods via the evaluate object interface. This is probably most usef=
ul for testing purposes, however.

Improved support for 32/64 bit physical addresses in printf()-like output. =
This change improves the support for physical addresses in printf debug sta=
tements and other output on both 32-bit and 64-bit hosts. It consistently o=
utputs the appropriate number of bytes for each host. The %p specifier is u=
nsatisfactory since it does not emit uniform output on all hosts/clib imple=
mentations (on some, leading zeros are not supported, leading to difficult-=
to-read output).

Example Code and Data Size: These are the sizes for the OS-independent acpi=
ca.lib produced by the Microsoft Visual C++ 9.0 32-bit compiler. The debug =
version of the code includes the debug output trace mechanism and has a muc=
h larger code and data size.

  Current Release:
    Non-Debug Version:  96.2K Code, 27.0K Data, 123.2K Total
    Debug Version:     187.5K Code, 78.3K Data, 265.8K Total
  Previous Release:
    Non-Debug Version:  96.1K Code, 27.0K Data, 123.1K Total
    Debug Version:     185.6K Code, 77.3K Data, 262.9K Total


2) iASL Compiler/Disassembler and Tools:

iASL: Fix a possible fault when using the Connection() operator. Fixes a pr=
oblem if the parent Field definition for the Connection operator refers to =
an operation region that does not exist. ACPICA BZ 1064.

AcpiExec: Load of local test tables is now optional. The utility has the ca=
pability to load some various tables to test features of ACPICA. However, t=
here are enough of them that the output of the utility became confusing. Wi=
th this change, only the required local tables are displayed (RSDP, XSDT, e=
tc.) along with the actual tables loaded via the command line specification=
. This makes the default output simler and easier to understand. The -el co=
mmand line option restores the original behavior for testing purposes.

AcpiExec: Added support for overlapping operation regions. This change expa=
nds the simulation of operation regions by supporting regions that overlap =
within the given address space. Supports SystemMemory and SystemIO. ASLTS t=
est suite updated also. David Box. ACPICA BZ 1031.

AcpiExec: Added region handler support for PCI_Config and EC spaces. This a=
llows AcpiExec to simulate these address spaces, similar to the current sup=
port for SystemMemory and SystemIO.

Debugger: Added new command to read/write/compare all namespace objects. Th=
e command "test objects" will exercise the entire namespace by writing new =
values to each data object, and ensuring that the write was successful. The=
 original value is then restored and verified.

Debugger: Added the "test predefined" command. This change makes this test =
public and puts it under the new "test" command. The test executes each and=
 every predefined name within the current namespace.


--===============2374642491442480478==--

