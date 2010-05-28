Content-Type: multipart/mixed; boundary="===============2341817610843345896=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: [Devel] ACPICA version 20100528 released
Date: Fri, 28 May 2010 10:32:11 -0700
Message-ID: <4911F71203A09E4D9981D27F9D83085870AD0FD8@orsmsx503.amr.corp.intel.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============2341817610843345896==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

28 May 2010. Summary of changes for version 20100528:

This release is available at www.acpica.org/downloads

Note: The ACPI 4.0a specification was released on April 5, 2010 and is avai=
lable at www.acpi.info. This is primarily an errata release.

1) ACPI CA Core Subsystem:

Undefined ACPI tables: We are looking for the definitions for the following=
 ACPI tables that have been seen in the field: ATKG, IEIT, GSCI.

Implemented support to enable multi-byte transfers for Embedded Controller =
(EC) operation regions. Previously, the maximum data size passed to the EC =
operation region handler was a single byte. There are often EC Fields large=
r than one byte that need to be transferred, and it is useful for the EC dr=
iver to lock these as a single transaction. This change enables single tran=
sfers larger than 8 bits. This effectively changes the access to the EC spa=
ce from ByteAcc to AnyAcc, and will probably require changes to the host OS=
 Embedded Controller driver to enable 16/32/64/256-bit transfers in additio=
n to 8-bit transfers. Alexey Starikovskiy, Lin Ming

Implemented a performance enhancement for namespace search and access. This=
 change enhances the performance of namespace searches and walks by adding =
a backpointer to the parent in each namespace node. On large namespaces, th=
is change can improve overall ACPI performance by up to 9X. Adding a pointe=
r to each namespace node increases the overall size of the internal namespa=
ce by about 5%, since each namespace entry usually consists of both a names=
pace node and an ACPI operand object. However, this is the first growth of =
the namespace in ten years. ACPICA bugzilla 817. Alexey Starikovskiy.

Implemented a performance optimization that reduces the number of namespace=
 walks. On control method exit, only walk the namespace if the method is kn=
own to have created namespace objects outside of its local scope. Previousl=
y, the entire namespace was traversed on each control method exit. This cha=
nge can improve overall ACPI performance by up to 3X. Alexey Starikovskiy, =
Bob Moore.

Added support to truncate I/O addresses to 16 bits for Windows compatibilit=
y. Some ASL code has been seen in the field that inadvertently has bits set=
 above bit 15. This feature is optional and is enabled if the BIOS requests=
 any Windows OSI strings. It can also be enabled by the host OS. Matthew Ga=
rrett, Bob Moore.

Added support to limit the maximum time for the ASL Sleep() operator. To pr=
event accidental deep sleeps, limit the maximum time that Sleep() will actu=
ally sleep. Configurable, the default maximum is two seconds. ACPICA bugzil=
la 854.

Added run-time validation support for the _WDG and_WED Microsoft predefined=
 methods. These objects are defined by "Windows Instrumentation", and are n=
ot part of the ACPI spec. ACPICA BZ 860.

Expanded all statistic counters used during namespace and device initializa=
tion from 16 to 32 bits in order to support very large namespaces.

Replaced all instances of %d in printf format specifiers with %u since near=
ly all integers in ACPICA are unsigned.

Fixed the exception namestring for AE_WAKE_ONLY_GPE. Was incorrectly return=
ed as AE_NO_HANDLER.

Example Code and Data Size: These are the sizes for the OS-independent acpi=
ca.lib produced by the Microsoft Visual C++ 6.0 32-bit compiler. The debug =
version of the code includes the debug output trace mechanism and has a muc=
h larger code and data size.

  Previous Release:
    Non-Debug Version:  88.4K Code, 18.8K Data, 107.2K Total
    Debug Version:     164.2K Code, 51.5K Data, 215.7K Total
  Current Release:
    Non-Debug Version:  88.3K Code, 18.8K Data, 107.1K Total
    Debug Version:     164.1K Code, 51.5K Data, 215.6K Total

2) iASL Compiler/Disassembler and Tools:

iASL: Added compiler support for the _WDG and_WED Microsoft predefined meth=
ods. These objects are defined by "Windows Instrumentation", and are not pa=
rt of the ACPI spec. ACPICA BZ 860.

AcpiExec: added option to disable the memory tracking mechanism. The -dt op=
tion will disable the tracking mechanism, which improves performance consid=
erably.

AcpiExec: Restructured the command line options into -d (disable) and -e (e=
nable) options.


--===============2341817610843345896==--

