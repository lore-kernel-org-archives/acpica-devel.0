Content-Type: multipart/mixed; boundary="===============2522746799527401099=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: [Devel] ACPICA version 20121114 released
Date: Wed, 14 Nov 2012 17:06:35 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E346BDA649@ORSMSX101.amr.corp.intel.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============2522746799527401099==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

14 November 2012. Summary of changes for version 20121114:

This release is available at https://www.acpica.org/downloads
The ACPI 5.0 specification is available at www.acpi.info

1) ACPICA Kernel-resident Subsystem:

Implemented a performance enhancement for ACPI/AML Package objects. This ch=
ange greatly increases the performance of Package objects within the interp=
reter. It changes the processing of reference counts for packages by optimi=
zing for the most common case where the package sub-objects are either Inte=
gers, Strings, or Buffers. Increases the overall performance of the ASLTS t=
est suite by 1.5X (Increases the Slack Mode performance by 2X.) Chao Guan. =
ACPICA BZ 943.

Implemented and deployed common macros to extract flag bits from resource d=
escriptors. Improves readability and maintainability of the code. Fixes a p=
roblem with the UART serial bus descriptor for the number of data bits flag=
s (was incorrectly 2 bits, should be 3).

Enhanced the ACPI_GETx and ACPI_SETx macros. Improved the implementation of=
 the macros and changed the SETx macros to the style of (destination, sourc=
e). Also added ACPI_CASTx companion macros. Lv Zheng.

Example Code and Data Size: These are the sizes for the OS-independent acpi=
ca.lib produced by the Microsoft Visual C++ 9.0 32-bit compiler. The debug =
version of the code includes the debug output trace mechanism and has a muc=
h larger code and data size.

  Previous Release:
    Non-Debug Version:  93.9K Code, 25.2K Data, 119.1K Total
    Debug Version:     175.5K Code, 74.5K Data, 250.0K Total
  Current Release:
    Non-Debug Version:  94.3K Code, 25.3K Data, 119.6K Total
    Debug Version:     175.5K Code, 74.5K Data, 250.0K Total


2) iASL Compiler/Disassembler and Tools:

Disassembler: Added the new ACPI 5.0 interrupt sharing flags. This change a=
dds the ShareAndWake and ExclusiveAndWake flags which were added to the Irq=
, Interrupt, and Gpio resource descriptors in ACPI 5.0. ACPICA BZ 986.

Disassembler: Fixed a problem with external declaration generation. Fixes a=
 problem where an incorrect pathname could be generated for an external dec=
laration if the original reference to the object includes leading carats (^=
). ACPICA BZ 984.

Debugger: Completed a major update for the Disassemble<method> command. Thi=
s command was out-of-date and did not properly disassemble control methods =
that had any reasonable complexity. This fix brings the command up to the s=
ame level as the rest of the disassembler. Adds one new file, dmdeferred.c,=
 which is existing code that is now common with the main disassembler and t=
he debugger disassemble command. ACPICA MZ 978.

iASL: Moved the parser entry prototype to avoid a duplicate declaration. Ne=
wer versions of Bison emit this prototype, so moved the prototype out of th=
e iASL header to where it is actually used in order to avoid a duplicate de=
claration.

iASL/Tools: Standardized use of the stream I/O functions:
  1) Ensure check for I/O error after every fopen/fread/fwrite
  2) Ensure proper order of size/count arguments for fread/fwrite
  3) Use test of (Actual !=3D Requested) after all fwrite, and most fread
  4) Standardize I/O error messages
Improves reliability and maintainability of the code. Bob Moore, Lv Zheng. =
ACPICA BZ 981.

Disassembler: Prevent duplicate External() statements. During generation of=
 external statements, detect similar pathnames that are actually duplicates=
 such as these:
   External (\ABCD)
   External (ABCD)
Remove all leading '\' characters from pathnames during the external statem=
ent generation so that duplicates will be detected and tossed. ACPICA BZ 98=
5.

Tools: Replace low-level I/O with stream I/O functions. Replace open/read/w=
rite/close with the stream I/O equivalents fopen/fread/fwrite/fclose for po=
rtability and performance. Lv Zheng, Bob Moore.

AcpiBin: Fix for the dump-to-hex function. Now correctly output the table n=
ame header so that AcpiXtract recognizes the output file/table.

iASL: Remove obsolete -2 option flag. Originally intended to force the comp=
iler/disassembler into an ACPI 2.0 mode, this was never implemented and the=
 entire concept is now obsolete.



--===============2522746799527401099==--

