Content-Type: multipart/mixed; boundary="===============2917297078645680826=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: [Devel] ACPICA version 20110922 released
Date: Thu, 22 Sep 2011 16:17:49 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E316E9BF4B@ORSMSX101.amr.corp.intel.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============2917297078645680826==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

22 September 2011. Summary of changes for version 20110922:

This release is available at www.acpica.org/downloads

0) ACPI 5.0 News:

Support for ACPI 5.0 in ACPICA has been underway for several months and wil=
l be released at the same time that ACPI 5.0 is officially released.

The ACPI 5.0 specification is on track for release in the next few months.
 =

1) ACPICA Core Subsystem:

Fixed a problem where the maximum sleep time for the Sleep() operator was i=
ntended to be limited to two seconds, but was inadvertently limited to 20 s=
econds instead.

Linux and Unix makefiles: Added header file dependencies to ensure correct =
generation of ACPICA core code and utilities. Also simplified the makefiles=
 considerably through the use of the vpath variable to specify search paths=
. ACPICA BZ 924.

2) iASL Compiler/Disassembler and Tools:

iASL: Implemented support to check the access length for all fields created=
 to access named Resource Descriptor fields. For example, if a resource fie=
ld is defined to be two bits, a warning is issued if a CreateXxxxField() is=
 used with an incorrect bit length. This is implemented for all current res=
ource descriptor names. ACPICA BZ 930.
  =

Disassembler: Fixed a byte ordering problem with the output of 24-bit and 5=
6-bit integers.

iASL: Fixed a couple of issues associated with variable-length package obje=
cts. 1) properly handle constants like One, Ones, Zero -- do not make a VAR=
_PACKAGE when these are used as a package length. 2) Allow the VAR_PACKAGE =
opcode (in addition to PACKAGE) when validating object types for predefined=
 names.

iASL: Emit statistics for all output files (instead of just the ASL input a=
nd AML output). Includes listings, hex files, etc.

iASL: Added -G option to the table compiler to allow the compilation of cus=
tom ACPI tables. The only part of a table that is required is the standard =
36-byte ACPI header.

AcpiXtract: Ported to the standard ACPICA environment (with ACPICA headers)=
, which also adds correct 64-bit support. Also, now all output filenames ar=
e completely lower case.

AcpiExec: Ignore any non-AML tables (tables other than DSDT or SSDT) when l=
oading table files. A warning is issued for any such tables. The only excep=
tion is an FADT. This also fixes a possible fault when attempting to load n=
on-AML tables. ACPICA BZ 932.

AcpiHelp: Added the AccessAs and Offset operators. Fixed a problem where a =
missing table terminator could cause a fault when using the -p option.

AcpiSrc: Fixed a possible divide-by-zero fault when generating file statist=
ics.

3) Example Code and Data Size

These are the sizes for the OS-independent acpica.lib produced by the Micro=
soft Visual C++ 9.0 32-bit compiler. The debug version of the code includes=
 the debug output trace mechanism and has a much larger code and data size.

  Previous Release (VC 9.0):
    Non-Debug Version:  90.2K Code, 23.9K Data, 114.1K Total
    Debug Version:     165.6K Code, 68.4K Data, 234.0K Total
  Current Release (VC 9.0):
    Non-Debug Version:  90.2K Code, 23.9K Data, 114.1K Total
    Debug Version:     165.6K Code, 68.4K Data, 234.0K Total



--===============2917297078645680826==--

