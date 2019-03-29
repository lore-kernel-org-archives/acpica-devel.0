Content-Type: multipart/mixed; boundary="===============8074104321986595369=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: [Devel] ACPICA version 20190329 released
Date: Fri, 29 Mar 2019 15:41:30 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E3B957657E@ORSMSX110.amr.corp.intel.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============8074104321986595369==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

29 March 2019. Summary of changes for version 20190329:

This release is available at https://acpica.org/downloads


1) ACPICA kernel-resident subsystem:

Namespace support: Remove the address nodes from global list after method t=
ermination. The global address list contains pointers to namespace nodes th=
at represent Operation Regions. This change properly removes Operation Regi=
on namespace nodes that are declared dynamically during method execution.

Linux: Use a different debug default than ACPICA. There was a divergence be=
tween Linux and the ACPICA codebases. In order to resolve this divergence, =
Linux now declares its own debug default in aclinux.h

Renamed some internal macros to improve code understanding and maintenance.=
 The macros below all operate on single 4-character ACPI NameSegs, not gene=
ric strings (old -> new):
    ACPI_NAME_SIZE    -> ACPI_NAMESEG_SIZE
    ACPI_COMPARE_NAME -> ACPI_COMPARE_NAMESEG
    ACPI_MOVE_NAME    -> ACPI_COPY_NAMESEG

Fix for missing comma in array declaration for the AcpiGbl_GenericNotify ta=
ble.

Test suite: Update makefiles, add PCC operation region support


2) iASL Compiler/Disassembler and Tools:

iASL: Implemented additional illegal forward reference detection. Now detec=
t and emit an error upon detection of a forward reference from a Field to a=
n Operation Region. This will fail at runtime if allowed to pass the compil=
er.

AcpiExec: Add an address list check for dynamic Operation Regions. This fea=
ture performs a sanity test for each node the global address list. This is =
done in order to ensure that all dynamic operation regions are properly rem=
oved from the global address list and no dangling pointers are left behind.

Disassembler: Improved generation of resource pathnames. This change improv=
es the code that generates resource descriptor and resource tag pathnames. =
The original code used a bunch of str* C library functions that caused warn=
ings on some compilers.

iASL: Removed some uses of strncpy and replaced with memmove. The strncpy f=
unction can overwrite buffers if the calling code is not very careful. In t=
he case of generating a module/table header, use of memmove is a better imp=
lementation.


3) Status of new features that have not been completed at this time:

iASL: Implementing an enhanced multiple file compilation into a single name=
space feature (Status): This feature will be released soon, and allows mult=
iple ASL files to be compiled into the same single namespace. By doing so, =
any unresolved external declarations as well as duplicate named object decl=
arations can be detected during compilation (rather than later during runti=
me). The following commands are examples that utilize this feature:
    iasl dsdt.asl ssdt.asl
    iasl dsdt.asl ssdt1.asl ssdt2.asl
    iasl dsdt.asl ssdt*.asl

ASL tutorial status: Feedback is being gathered internally and the current =
plan is to publish this tutorial on the ACPICA website after a final review=
 by a tech writer.



--===============8074104321986595369==--

