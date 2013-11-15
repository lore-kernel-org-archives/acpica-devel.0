Content-Type: multipart/mixed; boundary="===============8282776697016600098=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: [Devel] ACPICA version 20131115 released
Date: Fri, 15 Nov 2013 18:49:07 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37C79FC19@ORSMSX103.amr.corp.intel.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============8282776697016600098==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

15 November 2013. Summary of changes for version 20131115:

This release is available at https://acpica.org/downloads


1) ACPICA kernel-resident subsystem:

Resource Manager: Fixed loop termination for the "get AML length" function.=
 The loop previously had an error termination on a NULL resource pointer, w=
hich can never happen since the loop simply increments a valid resource poi=
nter. This fix changes the loop to terminate with an error on an invalid en=
d-of-buffer condition. The problem can be seen as an infinite loop by calle=
rs to AcpiSetCurrentResources with an invalid or corrupted resource descrip=
tor, or a resource descriptor that is missing an END_TAG descriptor. Report=
ed by Dan Carpenter <dan.carpenter(a)oracle.com>. Lv Zheng, Bob Moore.

Table unload and ACPICA termination: Delete all attached data objects durin=
g namespace node deletion. This fix updates namespace node deletion to dele=
te the entire list of attached objects (attached via AcpiAttachObject) inst=
ead of just one of the attached items. ACPICA BZ 1024. Tomasz Nowicki (toma=
sz.nowicki(a)linaro.org).

ACPICA termination: Added support to delete all objects attached to the roo=
t namespace node. This fix deletes any and all objects that have been attac=
hed to the root node via AcpiAttachData. Previously, none of these objects =
were deleted. Reported by Tomasz Nowicki. ACPICA BZ 1026.

Debug output: Do not emit the function nesting level for the in-kernel buil=
d. The nesting level is really only useful during a single-thread execution=
. Therefore, only enable this output for the AcpiExec utility. Also, only e=
mit the thread ID when executing under AcpiExec (Context switches are still=
 always detected and a message is emitted). ACPICA BZ 972.

Example Code and Data Size: These are the sizes for the OS-independent acpi=
ca.lib produced by the Microsoft Visual C++ 9.0 32-bit compiler. The debug =
version of the code includes the debug output trace mechanism and has a muc=
h larger code and data size.

  Current Release:
    Non-Debug Version:  95.9K Code, 27.0K Data, 122.9K Total
    Debug Version:     185.1K Code, 77.2K Data, 262.3K Total
  Previous Release:
    Non-Debug Version:  95.8K Code, 27.0K Data, 122.8K Total
    Debug Version:     185.2K Code, 77.2K Data, 262.4K Total


2) iASL Compiler/Disassembler and Tools:

AcpiExec/Unix-OSL: Use <termios.h> instead of <termio.h>. This is the corre=
ct portable POSIX header for terminal control functions.

Disassembler: Fixed control method invocation issues related to the use of =
the CondRefOf() operator. The problem is seen in the disassembly where cont=
rol method invocations may not be disassembled properly if the control meth=
od name has been used previously as an argument to CondRefOf. The solution =
is to not attempt to emit an external declaration for the CondRefOf target =
(it is not necessary in the first place). This prevents disassembler object=
 type confusion. ACPICA BZ 988.

Unix Makefiles: Added an option to disable compiler optimizations and the _=
FORTIFY_SOURCE flag. Some older compilers have problems compiling ACPICA wi=
th optimizations (reportedly, gcc 4.4 for example). This change adds a comm=
and line option for make (NOOPT) that disables all compiler optimizations a=
nd the _FORTIFY_SOURCE compiler flag. The default optimization is -O2 with =
the _FORTIFY_SOURCE flag specified. ACPICA BZ 1034. Lv Zheng, Bob Moore.

Tests/ASLTS: Added options to specify individual test cases and modes. This=
 allows testers running aslts.sh to optionally specify individual test mode=
s and test cases. Also added an option to disable the forced generation of =
the ACPICA tools from source if desired. Lv Zheng.


--===============8282776697016600098==--

