Content-Type: multipart/mixed; boundary="===============0842092246205770676=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: [Devel] ACPICA version 20130626 released
Date: Wed, 26 Jun 2013 19:03:40 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E36FE96282@ORSMSX103.amr.corp.intel.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============0842092246205770676==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

26 June 2013. Summary of changes for version 20130626:

This release is available at https://acpica.org/downloads


1) ACPICA kernel-resident subsystem:

Fixed an issue with runtime repair of the _CST object. Null or invalid elem=
ents were not always removed properly. Lv Zheng.

Removed an arbitrary restriction of 256 GPEs per GPE block (such as the FAD=
T-defined GPE0 and GPE1). For GPE0, GPE1, and each GPE Block Device, the ma=
ximum number of GPEs is 1016. Use of multiple GPE block devices makes the s=
ystem-wide number of GPEs essentially unlimited.

Example Code and Data Size: These are the sizes for the OS-independent acpi=
ca.lib produced by the Microsoft Visual C++ 9.0 32-bit compiler. The debug =
version of the code includes the debug output trace mechanism and has a muc=
h larger code and data size.

  Current Release:
    Non-Debug Version:  95.9K Code, 26.9K Data, 122.8K Total
    Debug Version:     184.1K Code, 76.7K Data, 260.8K Total
  Previous Release:
    Non-Debug Version:  96.0K Code, 27.0K Data, 123.0K Total
    Debug Version:     184.1K Code, 76.8K Data, 260.9K Total


2) iASL Compiler/Disassembler and Tools:

Portable AcpiDump: Implemented full support for the Linux and FreeBSD hosts=
. Now supports Linux, FreeBSD, and Windows.

Disassembler: Added some missing types for the HEST and EINJ tables: "Set E=
rror Type With Address", "CMCI", "MCE", and "Flush Cacheline".

iASL/Preprocessor: Implemented full support for nested #if/#else/#elif/#end=
if blocks. Allows arbitrary depth of nested blocks.

Disassembler: Expanded maximum output string length to 64K. Was 256 bytes m=
ax. The original purpose of this constraint was to limit the amount of debu=
g output. However, the string function in question (UtPrintString) is now u=
sed for the disassembler also, where 256 bytes is insufficient. Reported by=
 RehabMan(a)GitHub.

iASL/DataTables: Fixed some problems and issues with compilation of DMAR ta=
bles. ACPICA BZ 999. Lv Zheng.

iASL: Fixed a couple of error exit issues that could result in a "Could not=
 delete <file>" message during ASL compilation.

AcpiDump: Allow "FADT" and "MADT" as valid table signatures, even though th=
e actual signatures for these tables are "FACP" and "APIC", respectively.

AcpiDump: Added support for multiple UEFI tables. Only SSDT and UEFI tables=
 are allowed to have multiple instances.


--===============0842092246205770676==--

