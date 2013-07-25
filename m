Content-Type: multipart/mixed; boundary="===============8157793638174211371=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: [Devel] ACPICA version 20130725 released
Date: Thu, 25 Jul 2013 17:21:08 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E36FEA90E5@ORSMSX103.amr.corp.intel.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============8157793638174211371==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

25 July 2013. Summary of changes for version 20130725:

This release is available at https://acpica.org/downloads


1) ACPICA kernel-resident subsystem:

Fixed a problem with the DerefOf operator where references to FieldUnits an=
d BufferFields incorrectly returned the parent object, not the actual value=
 of the object. After this change, a dereference of a FieldUnit reference r=
esults in a read operation on the field to get the value, and likewise, the=
 appropriate BufferField value is extracted from the target buffer.

Fixed a problem where the _WAK method could cause a fault under these circu=
mstances: 1) Interpreter slack mode was not enabled, and 2) the _WAK method=
 returned no value. The problem is rarely seen because most kernels run ACP=
ICA in slack mode.

For the DerefOf operator, a fatal error now results if an attempt is made t=
o dereference a reference (created by the Index operator) to a NULL package=
 element. Provides compatibility with other ACPI implementations, and this =
behavior will be added to a future version of the ACPI specification.

The ACPI Power Management Timer (defined in the FADT) is now optional. This=
 provides compatibility with other ACPI implementations and will appear in =
the next version of the ACPI specification. If there is no PM Timer on the =
platform, AcpiGetTimer returns AE_SUPPORT. An address of zero in the FADT i=
ndicates no PM timer.

Implemented a new interface for _OSI support, AcpiUpdateInterfaces. This al=
lows the host to globally enable/disable all vendor strings, all feature st=
rings, or both. Intended to be primarily used for debugging purposes only. =
Lv Zheng.

Expose the collected _OSI data to the host via a global variable. This data=
 tracks the highest level vendor ID that has been invoked by the BIOS so th=
at the host (and potentially ACPICA itself) can change behaviors based upon=
 the age of the BIOS.

Example Code and Data Size: These are the sizes for the OS-independent acpi=
ca.lib produced by the Microsoft Visual C++ 9.0 32-bit compiler. The debug =
version of the code includes the debug output trace mechanism and has a muc=
h larger code and data size.

  Current Release:
    Non-Debug Version:  96.2K Code, 27.1K Data, 123.3K Total
    Debug Version:     184.4K Code, 76.8K Data, 261.2K Total
  Previous Release:
    Non-Debug Version:  95.9K Code, 26.9K Data, 122.8K Total
    Debug Version:     184.1K Code, 76.7K Data, 260.8K Total


2) iASL Compiler/Disassembler and Tools:

iASL: Created the following enhancements for the -so option (create offset =
table):
1)Add offsets for the last nameseg in each namepath for every supported obj=
ect type
2)Add support for Processor, Device, Thermal Zone, and Scope objects
3)Add the actual AML opcode for the parent object of every supported object=
 type
4)Add support for the ZERO/ONE/ONES AML opcodes for integer objects

Disassembler: Emit all unresolved external symbols in a single block. These=
 are external references to control methods that could not be resolved, and=
 thus, the disassembler had to make a guess at the number of arguments to p=
arse.

iASL: The argument to the -T option (create table template) is now optional=
. If not specified, the default table is a DSDT, typically the most common =
case.


--===============8157793638174211371==--

