Content-Type: multipart/mixed; boundary="===============8248731657751182124=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: [Devel] ACPICA version 20170224 released
Date: Sat, 25 Feb 2017 01:01:01 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37E5678C4@ORSMSX110.amr.corp.intel.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============8248731657751182124==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

24 February 2017. Summary of changes for version 20170224:

This release is available at https://acpica.org/downloads


1) ACPICA kernel-resident subsystem:

Interpreter: Fixed two issues with the control method return value auto-rep=
air feature, where an attempt to double-delete an internal object could res=
ult in an ACPICA warning (for _CID repair and others). No fault occurs, how=
ever, because the attempted deletion (actually a release to an internal cac=
he) is detected and ignored via object poisoning.

Debugger: Fixed an AML interpreter mutex issue during the single stepping o=
f control methods. If certain debugger commands are executed during steppin=
g, a mutex aquire/release error could occur. Lv Zheng.

Fixed some issues generating ACPICA with the Intel C compiler by restoring =
the original behavior and compiler-specific include file in acenv.h. Lv Zhe=
ng.

Example Code and Data Size: These are the sizes for the OS-independent acpi=
ca.lib produced by the Microsoft Visual C++ 9.0 32-bit compiler. The debug =
version of the code includes the debug output trace mechanism and has a muc=
h larger code and data size.

  Current Release:
    Non-Debug Version: 141.7K Code, 58.5K Data, 200.2K Total
    Debug Version:     207.5K Code, 82.7K Data, 290.2K Total
  Previous Release:
    Non-Debug Version: 137.4K Code, 52.6K Data, 190.0K Total
    Debug Version:     201.5K Code, 82.2K Data, 283.7K Total


2) iASL Compiler/Disassembler and Tools:

iASL/Disassembler: A preliminary version of a new ASL-to-ASL+ conversion to=
ol has been designed, implemented, and included in this release. The key fe=
ature of this utility is that the original comments within the input ASL fi=
le are preserved during the conversion process, and included within the con=
verted ASL+ file -- thus creating a transparent conversion of existing ASL =
files to ASL+ (ASL 2.0). Erik Schmauss.

    Usage: iasl -ca <ASL-filename>  // Output is a .dsl file with converted=
 code

iASL/Disassembler: Improved the detection and correct disassembly of Switch=
/Case operators. This feature detects sequences of if/elseif/else operators=
 that originated from ASL Switch/Case/Default operators and emits the origi=
nal operators. David Box.

iASL: Improved the IORT ACPI table support in the following areas. Lv Zheng:
    Clear MappingOffset if the MappingCount is zero.
    Fix the disassembly of the SMMU GSU interrupt offset.
    Update the template file for the IORT table.

Disassembler: Enhanced the detection and disassembly of resource template/d=
escriptor within a Buffer object. An EndTag descriptor is now required to h=
ave a zero second byte, since all known ASL compilers emit this. This helps=
 eliminate incorrect decisions when a buffer is disassembled (false positiv=
es on resource templates).


--===============8248731657751182124==--

