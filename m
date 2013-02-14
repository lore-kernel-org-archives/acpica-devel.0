Content-Type: multipart/mixed; boundary="===============3781151050393230382=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: [Devel] ACPICA version 20130214 released
Date: Thu, 14 Feb 2013 20:41:36 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E368CB4CB8@ORSMSX101.amr.corp.intel.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============3781151050393230382==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

14 February 2013. Summary of changes for version 20130214:

This release is available at https://www.acpica.org/downloads
The ACPI 5.0 specification is available at www.acpi.info

1) ACPICA kernel-resident subsystem:

Fixed a possible regression on some hosts: Reinstated the safe return macro=
s (return_ACPI_STATUS, etc.) that ensure that the macro argument is only ev=
aluated once. Although these macros are not needed for the ACPICA code itse=
lf, they are often used by ACPI-related host device drivers where the safe =
feature may be necessary.

Fixed several issues related to the ACPI 5.0 reduced hardware support (SOC)=
: Now ensure that if the platform declares itself as hardware-reduced via t=
he FADT, the following functions become NOOPs (and always return AE_OK) bec=
ause ACPI is always enabled by definition on these machines:
  AcpiEnable
  AcpiDisable
  AcpiHwGetMode
  AcpiHwSetMode

Dynamic Object Repair: Implemented additional runtime repairs for predefine=
d name return values. Both of these repairs can simplify code in the relate=
d device drivers that invoke these methods:
1) For the _STR and _MLS names, automatically repair/convert an ASCII strin=
g to a Unicode buffer. =

2) For the _CRS, _PRS, and _DMA names, return a resource descriptor with a =
lone end tag descriptor in the following cases: A Return(0) was executed, a=
 null buffer was returned, or no object at all was returned (non-slack mode=
 only). Adds a new file, nsconvert.c
ACPICA BZ 998. Bob Moore, Lv Zheng.

Resource Manager: Added additional code to prevent possible infinite loops =
while traversing corrupted or ill-formed resource template buffers. Check f=
or zero-length resource descriptors in all code that loops through resource=
 templates (the length field is used to index through the template). This c=
hange also hardens the external AcpiWalkResources and AcpiWalkResourceBuffe=
r interfaces.

Local Cache Manager: Enhanced the main data structure to eliminate an unnec=
essary mechanism to access the next object in the list. Actually provides a=
 small performance enhancement for hosts that use the local ACPICA cache ma=
nager. Jung-uk Kim.

Example Code and Data Size: These are the sizes for the OS-independent acpi=
ca.lib produced by the Microsoft Visual C++ 9.0 32-bit compiler. The debug =
version of the code includes the debug output trace mechanism and has a muc=
h larger code and data size.

  Previous Release:
    Non-Debug Version:  94.5K Code, 25.4K Data, 119.9K Total
    Debug Version:     182.3K Code, 75.0K Data, 257.3K Total
  Current Release:
    Non-Debug Version:  95.0K Code, 25.9K Data, 120.9K Total
    Debug Version:     182.9K Code, 75.6K Data, 258.5K Total


2) iASL Compiler/Disassembler and Tools:

iASL/Disassembler: Fixed several issues with the definition of the ACPI 5.0=
 RASF table (RAS Feature Table). This change incorporates late changes that=
 were made to the ACPI 5.0 specification.

iASL/Disassembler: Added full support for the following new ACPI tables:
  1) The MTMR table (MID Timer Table)
  2) The VRTC table (Virtual Real Time Clock Table).
Includes header file, disassembler, table compiler, and template support fo=
r both tables.

iASL: Implemented compile-time validation of package objects returned by pr=
edefined names. This new feature validates static package objects returned =
by the various predefined names defined to return packages. Both object typ=
es and package lengths are validated, for both parent packages and sub-pack=
ages, if any. The code is similar in structure and behavior to the runtime =
repair mechanism within the AML interpreter and uses the existing predefine=
d name information table. Adds a new file, aslprepkg.c. ACPICA BZ 938.

iASL: Implemented auto-detection of binary ACPI tables for disassembly. Thi=
s feature detects a binary file with a valid ACPI table header and invokes =
the disassembler automatically. Eliminates the need to specifically invoke =
the disassembler with the -d option. ACPICA BZ 862.

iASL/Disassembler: Added several warnings for the case where there are unre=
solved control methods during the disassembly. This can potentially cause e=
rrors when the output file is compiled, because the disassembler assumes ze=
ro method arguments in these cases (it cannot determine the actual number o=
f arguments without resolution/definition of the method).

Debugger: Added support to display all resources with a single command. Inv=
ocation of the resources command with no arguments will now display all res=
ources within the current namespace.

AcpiHelp: Added descriptive text for each ACPICA exception code displayed v=
ia the -e option.


--===============3781151050393230382==--

