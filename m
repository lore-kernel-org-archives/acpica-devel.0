Content-Type: multipart/mixed; boundary="===============6019617942198788940=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: [Devel] ACPICA version 20120111 released
Date: Wed, 11 Jan 2012 20:06:36 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E3256D0749@ORSMSX101.amr.corp.intel.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============6019617942198788940==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

11 January 2012. Summary of changes for version 20120111:

This release is available at www.acpica.org/downloads.
The ACPI 5.0 specification is available at www.acpi.info.

1) ACPICA Core Subsystem:

Implemented a new mechanism to allow host device drivers to check for addre=
ss range conflicts with ACPI Operation Regions. Both SystemMemory and Syste=
mIO address spaces are supported. A new external interface, AcpiCheckAddres=
sRange, allows drivers to check an address range against the ACPI namespace=
. See the ACPICA reference for additional details. Adds one new file, utili=
ties/utaddress.c. Lin Ming, Bob Moore.

Fixed several issues with the ACPI 5.0 FADT support: Add the sleep Control =
and Status registers, update the ACPI 5.0 flags, and update internal data s=
tructures to handle an FADT larger than 256 bytes. The size of the ACPI 5.0=
 FADT is 268 bytes.

Updated all ACPICA copyrights and signons to 2012. Added the 2012 copyright=
 to all module headers and signons, including the standard Linux header. Th=
is affects virtually every file in the ACPICA core subsystem, iASL compiler=
, and all ACPICA utilities.

Example Code and Data Size: These are the sizes for the OS-independent acpi=
ca.lib produced by the Microsoft Visual C++ 9.0 32-bit compiler. The debug =
version of the code includes the debug output trace mechanism and has a muc=
h larger code and data size.

  Previous Release:
    Non-Debug Version:  92.3K Code, 24.9K Data, 117.2K Total
    Debug Version:     170.8K Code, 72.6K Data, 243.4K Total
  Current Release:
    Non-Debug Version:  92.8K Code, 24.9K Data, 117.7K Total
    Debug Version:     171.7K Code, 72.9K Data, 244.5K Total


2) iASL Compiler/Disassembler and Tools:

Disassembler: fixed a problem with the automatic resource tag generation su=
pport. Fixes a problem where the resource tags are inadvertently not constr=
ucted if the table being disassembled contains external references to contr=
ol methods. Moved the actual construction of the tags to after the final na=
mespace is constructed (after 2nd parse is invoked due to external control =
method references.) ACPICA BZ 941.

Table Compiler: Make all "generic" operators caseless. These are the operat=
ors like UINT8, String, etc. Making these caseless improves ease-of-use. AC=
PICA BZ 934.


--===============6019617942198788940==--

