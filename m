Content-Type: multipart/mixed; boundary="===============1720796777989355979=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: [Devel] ACPICA version 20150515 released
Date: Sat, 16 May 2015 00:09:35 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37D2ECD7B@ORSMSX112.amr.corp.intel.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============1720796777989355979==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

15 May 2015. Summary of changes for version 20150515:

This release is available at https://acpica.org/downloads

This release implements most of ACPI 6.0 as described below.

1) ACPICA kernel-resident subsystem:

Implemented runtime argument checking and return value checking for all new=
 ACPI 6.0 predefined names. This includes: _BTH, _CR3, _DSD, _LPI, _MTL, _P=
RR, _RDI, _RST, _TFP, _TSN.

Example Code and Data Size: These are the sizes for the OS-independent acpi=
ca.lib produced by the Microsoft Visual C++ 9.0 32-bit compiler. The debug =
version of the code includes the debug output trace mechanism and has a muc=
h larger code and data size.

  Current Release:
    Non-Debug Version:  99.9K Code, 27.5K Data, 127.4K Total
    Debug Version:     195.2K Code, 80.8K Data, 276.0K Total
  Previous Release:
    Non-Debug Version:  99.1K Code, 27.3K Data, 126.4K Total
    Debug Version:     192.8K Code, 79.9K Data, 272.7K Total


2) iASL Compiler/Disassembler and Tools:

iASL compiler: Added compile-time support for all new ACPI 6.0 predefined n=
ames (argument count validation and return value typechecking.)

iASL disassembler and table compiler: implemented support for all new ACPI =
6.0 tables. This includes: DRTM, IORT, LPIT, NFIT, STAO, WPBT, XENV. =


iASL disassembler and table compiler: Added ACPI 6.0 changes to existing ta=
bles: FADT, MADT.

iASL preprocessor: Added a new directive to enable inclusion of binary blob=
s into ASL code. The new directive is #includebinary. It takes a binary fil=
e as input and emits a named ascii buffer object into the ASL code.

AcpiHelp: Added support for all new ACPI 6.0 predefined names.

AcpiHelp: Added a new option, -d, to display all iASL preprocessor directiv=
es.

AcpiHelp: Added a new option, -t, to display all known/supported ACPI table=
s.


--===============1720796777989355979==--

