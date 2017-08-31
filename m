Content-Type: multipart/mixed; boundary="===============6838905478367177845=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: [Devel] ACPICA version 20170831 released
Date: Thu, 31 Aug 2017 16:31:59 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37E609ADB@ORSMSX110.amr.corp.intel.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============6838905478367177845==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

31 August 2017. Summary of changes for version 20170831:

This release is available at https://acpica.org/downloads


1) ACPICA kernel-resident subsystem:

Implemented internal support for full 64-bit addresses that appear in all G=
eneric Address Structure (GAS) structures. Previously, only the lower 32 bi=
ts were used. Affects the use of GAS structures in the FADT and other table=
s, as well as the GAS structures passed to the AcpiRead and AcpiWrite publi=
c external interfaces that are used by drivers. Lv Zheng.

Added header support for the PDTT ACPI table (Processor Debug Trigger Table=
). Full support in the iASL Data Table Compiler and disassembler is forthco=
ming.


2) iASL Compiler/Disassembler and Tools:

iASL/Disassembler: Fixed a problem with the PPTT ACPI table (Processor Prop=
erties Topology Table) where a flag bit was specified in the wrong bit posi=
tion ("Line Size Valid", bit 6).

iASL: Implemented support for Octal integer constants as defined by the ASL=
 language grammar, per the ACPI specification. Any integer constant that st=
arts with a zero is an octal constant. For example,
    Store (037777, Local0) /* Octal constant */
    Store (0x3FFF, Local0) /* Hex equivalent */
    Store (16383,  Local0) /* Decimal equivalent */

iASL: Improved overflow detection for 64-bit string conversions during comp=
ilation of integer constants. "Overflow" in this case means a string that r=
epresents an integer that is too large to fit into a 64-bit value. Any 64-b=
it constants within a 32-bit DSDT or SSDT are still truncated to the low-or=
der 32 bits with a warning, as previously implemented. Several new exceptio=
ns are defined that indicate a 64-bit overflow, as well as the base (radix)=
 that was used during the attempted conversion. Examples:
    Local0 =3D 0xAAAABBBBCCCCDDDDEEEEFFFF        // AE_HEX_OVERFLOW
    Local0 =3D 01111222233334444555566667777     // AE_OCTAL_OVERFLOW
    Local0 =3D 11112222333344445555666677778888  // AE_DECIMAL_OVERFLOW

iASL: Added a warning for the case where a ResourceTemplate is declared wit=
h no ResourceDescriptor entries (coded as "ResourceTemplate(){}"). In this =
case, the resulting template is created with a single END_TAG descriptor, w=
hich is essentially useless.

iASL: Expanded the -vw option (ignore specific warnings/remarks) to include=
 compilation error codes as well.


--===============6838905478367177845==--

