Content-Type: multipart/mixed; boundary="===============9138448099052555084=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: [Devel] ACPICA version 20100121 released
Date: Thu, 21 Jan 2010 10:41:30 -0800
Message-ID: <4911F71203A09E4D9981D27F9D830858502417DD@orsmsx503.amr.corp.intel.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============9138448099052555084==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

21 January 2010. Summary of changes for version 20100121:

This release is available at www.acpica.org/downloads

1) ACPI CA Core Subsystem:

Added the 2010 copyright to all module headers and signons. This affects vi=
rtually every file in the ACPICA core subsystem, the iASL compiler, the too=
ls/utilities, and the test suites.

Implemented a change to the AcpiGetDevices interface to eliminate unnecessa=
ry invocations of the _STA method. In the case where a specific _HID is req=
uested, do not run _STA until a _HID match is found. This eliminates potent=
ially dozens of _STA calls during a search for a particular device/HID, whi=
ch in turn can improve boot times. ACPICA BZ 828. Lin Ming.

Implemented an additional repair for predefined method return values. Attem=
pt to repair unexpected NULL elements within returned Package objects. Crea=
te an Integer of value zero, a NULL String, or a zero-length Buffer as appr=
opriate. ACPICA BZ 818. Lin Ming, Bob Moore.

Removed the obsolete ACPI_INTEGER data type. This type was introduced as th=
e code was migrated from ACPI 1.0 (with 32-bit AML integers) to ACPI 2.0 (w=
ith 64-bit AML integers). It is now obsolete and this change removes it fro=
m the ACPICA code base, replaced by UINT64. The original typedef has been r=
etained for now for compatibility with existing device driver code. ACPICA =
BZ 824.

Removed the unused UINT32_STRUCT type, and the obsolete Integer64 field in =
the parse tree object.

Added additional warning options for the gcc-4 generation. Updated the sour=
ce accordingly. This includes some code restructuring to eliminate unreacha=
ble code, elimination of some gotos, elimination of unused return values, s=
ome additional casting, and removal of redundant declarations.

Example Code and Data Size: These are the sizes for the OS-independent acpi=
ca.lib produced by the Microsoft Visual C++ 6.0 32-bit compiler. The debug =
version of the code includes the debug output trace mechanism and has a muc=
h larger code and data size.

  Previous Release:
    Non-Debug Version:  87.0K Code, 18.0K Data, 105.0K Total
    Debug Version:     163.4K Code, 50.8K Data, 214.2K Total
  Current Release:
    Non-Debug Version:  87.1K Code, 18.0K Data, 105.1K Total
    Debug Version:     163.5K Code, 50.9K Data, 214.4K Total

2) iASL Compiler/Disassembler and Tools:

No functional changes for this release.


--===============9138448099052555084==--

