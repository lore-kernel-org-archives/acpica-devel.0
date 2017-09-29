Content-Type: multipart/mixed; boundary="===============4041176244921978797=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: [Devel] ACPICA version 20170929 released
Date: Fri, 29 Sep 2017 16:14:58 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37E6128FB@ORSMSX110.amr.corp.intel.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============4041176244921978797==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

29 September 2017. Summary of changes for version 20170929:

This release is available at https://acpica.org/downloads


1) ACPICA kernel-resident subsystem:

Redesigned and implemented an improved ASL While() loop timeout mechanism. =
This mechanism is used to prevent infinite loops in the kernel AML interpre=
ter caused by either non-responsive hardware or incorrect AML code. The new=
 implementation uses AcpiOsGetTimer instead of a simple maximum loop count,=
 and is thus more accurate and constant across different machines. The defa=
ult timeout is currently 30 seconds, but this may be adjusted later.

Renamed the ACPI_AML_INFINITE_LOOP exception to AE_AML_LOOP_TIMEOUT to bett=
er reflect the new implementation of the loop timeout mechanism.

Updated the AcpiGetTimerDuration interface to cleanup the 64-bit support an=
d to fix an off-by-one error. Jung-uk Kim.

Fixed an EFI build problem by updating the makefiles to for a new file that=
 was added, utstrsuppt.c


2) iASL Compiler/Disassembler and Tools:

Implemented full support for the PDTT, SDEV, and TPM2 ACPI tables. This inc=
ludes support in the table disassembler, compiler, and template generator.

iASL: Added an exception for an illegal type of recursive method invocation=
. If a method creates named objects, the first recursive call will fail at =
runtime. This change adds an error detection at compile time to catch the p=
roblem up front. Note: Marking such a method as "serialized" will not help =
with this problem, because the same thread can acquire the method mutex mor=
e than once. Example compiler and runtime output:

    Method (MTH1)
    {
        Name (INT1, 1)
        MTH1 ()
    }

    dsdt.asl     22: MTH1 ()
    Error    6152 -  ^ Illegal recursive call to method
                       that creates named objects (MTH1)

Previous runtime exception:
    ACPI Error: [INT1] Namespace lookup failure,
    AE_ALREADY_EXISTS (20170831/dswload2-465)

iASL: Updated support for External() opcodes to improve namespace managemen=
t and error detection. These changes are related to issues seen with multip=
le-segment namespace pathnames within External declarations, such as below:

    External(\_SB.PCI0.GFX0, DeviceObj)
    External(\_SB.PCI0.GFX0.ALSI)

iASL: Implemented support for multi-line error/warning messages. This enabl=
es more detailed and helpful error messages as below, from the initial depl=
oyment for the duplicate names error:

    DSDT.iiii   1692:       Device(PEG2) {
    Error    6074 -                  ^ Name already exists in scope (PEG2)

        Original name creation/declaration below:
        DSDT.iiii     93:   External(\_SB.PCI0.PEG2, DeviceObj)

AcpiXtract: Added additional flexibility to support differing input hex dum=
p formats. Specifically, hex dumps that contain partial disassembly and/or =
comments within the ACPI table data definition. There exist some dump utili=
ties seen in the field that create this type of hex dump (such as Simics). =
For example:

    DSDT @ 0xdfffd0c0 (10999 bytes)
        Signature DSDT
        Length 10999
        Revision 1
        Checksum 0xf3 (Ok)
        OEM_ID BXPC
        OEM_table_id BXDSDT
        OEM_revision 1
        Creator_id 1280593481
        Creator_revision 537399345
      0000: 44 53 44 54 f7 2a 00 00 01 f3 42 58 50 43 00 00
      ...
      2af0: 5f 4c 30 46 00 a4 01

Test suite: Miscellaneous changes/fixes:
    More cleanup and simplification of makefiles
    Continue compilation of test cases after a compile failure
    Do not perform binary compare unless both files actually exist

iASL: Performed some code/module restructuring. Moved all memory allocation=
 functions to new modules. Two new files, aslallocate.c and aslcache.c


--===============4041176244921978797==--

