Content-Type: multipart/mixed; boundary="===============8208881254881554252=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: [Devel] ACPICA version 20120816 released
Date: Thu, 16 Aug 2012 16:47:09 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E346B5913E@ORSMSX101.amr.corp.intel.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============8208881254881554252==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

16 August 2012. Summary of changes for version 20120816:

This release is available at https://www.acpica.org/downloads
The ACPI 5.0 specification is available at www.acpi.info

1) ACPICA Kernel-resident Subsystem:

Removed all use of the deprecated _GTS and _BFS predefined methods. The _GT=
S (Going To Sleep) and _BFS (Back From Sleep) methods are essentially depre=
cated and will probably be removed from the ACPI specification. Windows doe=
s not invoke them, and reportedly never will. The final nail in the coffin =
is that the ACPI specification states that these methods must be run with i=
nterrupts off, which is not going to happen in a kernel interpreter. Note: =
Linux has removed all use of the methods also. It was discovered that invok=
ing these functions caused failures on some machines, probably because they=
 were never tested since Windows does not call them. Affects two external i=
nterfaces, AcpiEnterSleepState and AcpiLeaveSleepStatePrep. Tang Feng. ACPI=
CA BZ 969.

Implemented support for complex bit-packed buffers returned from the _PLD (=
Physical Location of Device) predefined method. Adds a new external interfa=
ce, AcpiDecodePldBuffer that parses the buffer into a more usable C structu=
re. Note: C Bitfields cannot be used for this type of predefined structure =
since the memory layout of individual bitfields is not defined by the C lan=
guage. In addition, there are endian concerns where a compiler will change =
the bitfield ordering based on the machine type. The new ACPICA interface e=
liminates these issues, and should be called after _PLD is executed. ACPICA=
 BZ 954.

Implemented a change to allow a scope change to root (via "Scope (\)") duri=
ng execution of module-level ASL code (code that is executed at table load =
time.) Lin Ming.

Added the Windows8/Server2012 string for the _OSI method. This change adds =
a new _OSI string, "Windows 2012" for both Windows 8 and Windows Server 201=
2.

Added header support for the new ACPI tables DBG2 (Debug Port Table Type 2)=
 and CSRT (Core System Resource Table).

Added struct header support for the _FDE, _GRT, _GTM, and _SRT predefined n=
ames. This simplifies access to the buffers returned by these predefined na=
mes. Adds a new file, include/acbuffer.h. ACPICA BZ 956.

GPE support: Removed an extraneous parameter from the various low-level int=
ernal GPE functions. Tang Feng.

Removed the linux makefiles from the unix packages. The generate/linux make=
files are obsolete and have been removed from the unix tarball release pack=
ages. The replacement makefiles are under generate/unix, and there is a top=
-level makefile under the main acpica directory. ACPICA BZ 967, 912.

Updates for Unix makefiles:
1) Add -D_FORTIFY_SOURCE=3D2 for gcc generation. Arjan van de Ven.
2) Update linker flags (move to end of command line) for AcpiExec utility. =
Guan Chao.

Split ACPICA initialization functions to new file, utxfinit.c. Split from u=
txface.c to improve modularity and reduce file size.

Example Code and Data Size: These are the sizes for the OS-independent acpi=
ca.lib produced by the Microsoft Visual C++ 9.0 32-bit compiler. The debug =
version of the code includes the debug output trace mechanism and has a muc=
h larger code and data size.

  Previous Release:
    Non-Debug Version:  93.5K Code, 25.3K Data, 118.8K Total
    Debug Version:     173.7K Code, 74.0K Data, 247.7K Total
  Current Release:
    Non-Debug Version:  93.8K Code, 25.3K Data, 119.1K Total
    Debug Version:     175.7K Code, 74.8K Data, 250.5K Total


2) iASL Compiler/Disassembler and Tools:

iASL: Fixed a problem with constant folding for fixed-length constant expre=
ssions. The constant-folding code was not being invoked for constant expres=
sions that allow the use of type 3/4/5 opcodes to generate constants for ex=
pressions such as ByteConstExpr, WordConstExpr, etc. This could result in t=
he generation of invalid AML bytecode. ACPICA BZ 970.

iASL: Fixed a generation issue on newer versions of Bison. Newer versions a=
pparently automatically emit some of the necessary externals. This change h=
andles these versions in order to eliminate generation warnings.

Disassembler: Added support to decode the DBG2 and CSRT ACPI tables.

Disassembler: Add support to decode _PLD buffers. The decoded buffer appear=
s within comments in the output file.

Debugger: Fixed a regression with the "Threads" command where AE_BAD_PARAME=
TER was always returned.


--===============8208881254881554252==--

