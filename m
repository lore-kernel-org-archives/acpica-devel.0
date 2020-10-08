Content-Type: multipart/mixed; boundary="===============9068580508809334088=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: [Devel] ACPICA version 20200925 released
Date: Thu, 08 Oct 2020 15:34:24 +0000
Message-ID: <BYAPR11MB325657C5753F6466D6BC48C1870B0@BYAPR11MB3256.namprd11.prod.outlook.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============9068580508809334088==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

25 September 2020. Summary of changes for version 20200925:

This release is available at https://acpica.org/downloads


1) ACPICA kernel-resident subsystem:

Preserve memory opregion mappings. The ACPICA's strategy with respect to th=
e handling of memory mappings associated with memory operation regions is t=
o avoid mapping the entire region at once which may be problematic at least=
 in principle (for example, it may lead to conflicts with overlapping mappi=
ngs having different attributes created by drivers).  It may also be wastef=
ul, because memory opregions on some systems take up vastchunks of address =
space while the fields in those regions actually accessed by AML are sparse=
ly distributed.

For this reason, a one-page "window" is mapped for a given opregion on the =
first memory access through it and if that "window" does not cover an addre=
ss range accessed through that opregion subsequently, it is unmapped and a =
new "window" is mapped to replace it.  Next, if the new "window" is not suf=
ficient to access memory through the opregion in question in the future, it=
 will be replaced with yet another "window" and so on.  That may lead to a =
suboptimal sequence of memory mapping and unmapping operations, for example=
 if two fields in one opregion separated from each other by a sufficiently =
wide chunk of unused address space are accessed in an alternating pattern.

Added support for 64 bit risc-v compilation.  Useful for acpica tools and i=
ncorporating ACPICA into the Firmware Test Suite. Colin Ian King <colin.kin=
g(a)canonical.com>.

Added support for SMBus predefined names (from SMBus Control Method Interfa=
ce Specification, Version 1.0, December 10, 1999. New predefined names:
    _SBA
    _SBI
    _SBR
    _SBT
    _SBW

AML Disassembler: Added a new command, "All <NameSeg". This command will ev=
aluate all objects in the current namespace whose NameString contains the i=
nput NameSeg as the last element of the NameString. Useful for debugging.


2) iASL Compiler/Disassembler and ACPICA tools: =


iASL: fixed a crash that occurred when predefined objects return packages w=
ith lengths that exceed the initializer list.

iASL: added more detail to external resolution error message when compiling=
 multiple definition blocks.

iASL: improve alias analysis by saving object type. If the alias is a metho=
d type, the parameter count is also recorded.

AcpiExec: Increase the default loop timeout value. Was 1 second, is now 10 =
seconds. Prevents unnecessary timeouts when executing control methods from =
the command line.

AcpiHelp/disassembler: Added a bunch of "known" UUIDs to the internal list.=
 Includes:
    Memory Device
    Generic Buttons Device
    NVDIMM Root Device
    Control Method Battery
    Device Graphs for _DSD method
    Hierarchical Data Extension
....ARM CoreSight Graph

--===============9068580508809334088==--

