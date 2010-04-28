Content-Type: multipart/mixed; boundary="===============6974314445842542300=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: [Devel] ACPICA version 20100428 released
Date: Wed, 28 Apr 2010 13:10:27 -0700
Message-ID: <4911F71203A09E4D9981D27F9D830858624D5CCF@orsmsx503.amr.corp.intel.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============6974314445842542300==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

28 April 2010. Summary of changes for version 20100428:

This release is available at www.acpica.org/downloads
Note: The ACPI 4.0a specification was released on April 5, 2010 and is avai=
lable at www.acpi.info. This is primarily an errata release.


1) ACPI CA Core Subsystem:

Implemented GPE support for dynamically loaded ACPI tables. For all GPEs, i=
ncluding FADT-based and GPE Block Devices, execute any _PRW methods in the =
new table, and process any _Lxx/_Exx GPE methods in the new table. Any runt=
ime GPE that is referenced by an _Lxx/_Exx method in the new table is immed=
iately enabled. Provides compatibility with other ACPI implementations. Two=
 new files added, evgpeinit.c and evgpeutil.c. ACPICA BZ 833. Lin Ming, Bob=
 Moore.

Fixed a regression introduced in version 20100331 within the table manager =
where initial table loading could fail. This was introduced in the fix for =
AcpiReallocateRootTable. Also, renamed some of fields in the table manager =
data structures to clarify their meaning and use.

Fixed a possible allocation overrun during internal object copy in AcpiUtCo=
pySimpleObject. The original code did not correctly handle the case where t=
he object to be copied was a namespace node. Lin Ming. ACPICA BZ 847.

Updated the allocation dump routine, AcpiUtDumpAllocation and fixed a possi=
ble access beyond end-of-allocation. Also, now fully validate descriptor (s=
ize and type) before output. Lin Ming, Bob Moore. ACPICA BZ 847

Example Code and Data Size: These are the sizes for the OS-independent acpi=
ca.lib produced by the Microsoft Visual C++ 6.0 32-bit compiler. The debug =
version of the code includes the debug output trace mechanism and has a muc=
h larger code and data size.

  Previous Release:
    Non-Debug Version:  87.9K Code, 18.6K Data, 106.5K Total
    Debug Version:     163.5K Code, 51.3K Data, 214.8K Total
  Current Release:
    Non-Debug Version:  88.4K Code, 18.8K Data, 107.2K Total
    Debug Version:     164.2K Code, 51.5K Data, 215.7K Total

2) iASL Compiler/Disassembler and Tools:

iASL: Implemented Min/Max/Len/Gran validation for address resource descript=
ors. This change implements validation for the address fields that are comm=
on to all address-type resource descriptors. These checks are implemented: =
Checks for valid Min/Max, length within the Min/Max window, valid granulari=
ty, Min/Max a multiple of granularity, and _MIF/_MAF as per table 6-40 in t=
he ACPI 4.0a specification. Also split the large aslrestype1.c and aslresty=
pe2.c files into five new files. ACPICA BZ 840.

iASL: Added support for the _Wxx predefined names. This support was missing=
 and these names were not recognized by the compiler as valid predefined na=
mes. ACPICA BZ 851.

iASL: Added an error for all predefined names that are defined to return no=
 value and thus must be implemented as Control Methods. These include all o=
f the _Lxx, _Exx, _Wxx, and _Qxx names, as well as some other miscellaneous=
 names such as _DIS, _INI, _IRC, _OFF, _ON, and _PSx. ACPICA BZ 850, 856.

iASL: Implemented the -ts option to emit hex AML data in ASL format, as an =
ASL Buffer. Allows ACPI tables to be easily included within ASL files, to b=
e dynamically loaded via the Load() operator. Also cleaned up output for th=
e -ta and -tc options. ACPICA BZ 853.

Tests: Added a new file with examples of extended iASL error checking. Demo=
nstrates the advanced error checking ability of the iASL compiler. Availabl=
e at tests/misc/badcode.asl.


--===============6974314445842542300==--

