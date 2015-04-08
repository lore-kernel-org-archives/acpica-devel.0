Content-Type: multipart/mixed; boundary="===============7639003210418891428=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: [Devel] ACPICA version 20150408 released
Date: Wed, 08 Apr 2015 17:40:33 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37D2BBF61@ORSMSX112.amr.corp.intel.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============7639003210418891428==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

08 April 2015. Summary of changes for version 20150408:

This release is available at https://acpica.org/downloads


1) ACPICA kernel-resident subsystem:

Permanently set the return value for the _REV predefined name. It now retur=
ns 2 (was 5). This matches other ACPI implementations. _REV will be depreca=
ted in the future, and is now defined to be 1 for ACPI 1.0, and 2 for ACPI =
2.0 and later.

Added the "Windows 2015" string to the _OSI support. ACPICA will now return=
 TRUE to a query with this string.

Fixed several issues with the local version of the printf function.

Added the C99 compiler option (-std=3Dc99) to the Unix makefiles.

  Current Release:
    Non-Debug Version:  99.1K Code, 27.3K Data, 126.4K Total
    Debug Version:     192.8K Code, 79.9K Data, 272.7K Total
  Previous Release:
    Non-Debug Version:  98.8K Code, 27.3K Data, 126.1K Total
    Debug Version:     192.1K Code, 79.8K Data, 271.9K Total


2) iASL Compiler/Disassembler and Tools:

Implemented an enhancement to the constant folding feature to transform the=
 parse tree to a simple Store operation whenever possible:
    Add (2, 3, X) =3D=3D> Store (5, X)
    X =3D 2 + 3 =3D=3D> X =3D 5 =3D=3D> Store (5, X)

Updated support for the SLIC table (Software Licensing Description Table) i=
n both the Data Table compiler and the disassembler. The SLIC table support=
 now conforms to "Microsoft Software Licensing Tables (SLIC and MSDM). Nove=
mber 29, 2011. Copyright 2011 Microsoft". Note: The SLIC data following the=
 ACPI header is now defined to be "Proprietary Data", and as such, can only=
 be displayed as a hex data block.

Implemented full support for the MSDM table as described in the document ab=
ove. Note: The MSDM data following the ACPI header is defined to be "Propri=
etary Data", and as such, can only be displayed as a hex data block.

Changes for the EFI version of the tools:
1) Fixed a build error/issue
2) Fixed a cast warning

Implemented the -Pn option for the Table Compiler (in addition to the ASL c=
ompiler). This option disables the preprocessor.

Fixed some problems with the local version of the strstr function.

Disassembler: For disassembly of Data Tables, added a comment field around =
the Ascii equivalent data that is emitted as part of the "Raw Table Data" b=
lock. This prevents the iASL Preprocessor from possible confusion if/when t=
he table is compiled.

Disassembler: Added an option (-df) to force the disassembler to assume tha=
t the table being disassembled contains valid AML. This feature is useful f=
or disassembling AML files that contain ACPI signatures other than DSDT or =
SSDT (such as OEMx or other signatures).

iASL: Fixed a path issue with the __FILE__ operator by making the directory=
 prefix optional within the internal SplitInputFilename function.

Debugger: Remove some unused global variables.

Tests: Updated the makefile for the AAPITS suite.


--===============7639003210418891428==--

