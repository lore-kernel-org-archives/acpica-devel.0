Content-Type: multipart/mixed; boundary="===============2486007671129200506=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: [Devel] ACPICA version 20100915 released
Date: Wed, 15 Sep 2010 12:56:18 -0700
Message-ID: <4911F71203A09E4D9981D27F9D830858AF1B2C4E@orsmsx503.amr.corp.intel.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============2486007671129200506==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

15 September 2010. Summary of changes for version 20100915:

This release is available at www.acpica.org/downloads

1) ACPI CA Core Subsystem:

Removed the AcpiOsDerivePciId OSL interface. The various host implementatio=
ns of this function were not OS-dependent and are now obsolete and can be r=
emoved from all host OSLs. This function has been replaced by AcpiHwDeriveP=
ciId, which is now part of the ACPICA core code. AcpiHwDerivePciId has been=
 implemented without recursion. Adds one new module, hwpci.c. ACPICA BZ 857.

Implemented a dynamic repair for _HID and _CID strings. The following probl=
ems are now repaired at runtime: 1) Remove a leading asterisk in the string=
, and 2) the entire string is uppercased. Both repairs are in accordance wi=
th the ACPI specification and will simplify host driver code. ACPICA BZ 871.

The ACPI_THREAD_ID type is no longer configurable, internally it is now alw=
ays UINT64. This simplifies the ACPICA code, especially any printf output. =
UINT64 is the only common data type for all thread_id types across all oper=
ating systems. It is now up to the host OSL to cast the native thread_id ty=
pe to UINT64 before returning the value to ACPICA (via AcpiOsGetThreadId). =
Lin Ming, Bob Moore.

Added the ACPI_INLINE type to enhance the ACPICA configuration. The "inline=
" keyword is not standard across compilers, and this type allows inline to =
be configured on a per-compiler basis. Lin Ming.

Made the system global AcpiGbl_SystemAwakeAndRunning publically available. =
Added an extern for this boolean in acpixf.h. Some hosts utilize this value=
 during suspend/restore operations. ACPICA BZ 869.

All code that implements error/warning messages with the "ACPI:" prefix has=
 been moved to a new module, utxferror.c.

The UINT64_OVERLAY was moved to utmath.c, which is the only module where it=
 is used. ACPICA BZ 829. Lin Ming, Bob Moore.

Example Code and Data Size: These are the sizes for the OS-independent acpi=
ca.lib produced by the Microsoft Visual C++ 6.0 32-bit compiler. The debug =
version of the code includes the debug output trace mechanism and has a muc=
h larger code and data size.

  Previous Release:
    Non-Debug Version:  89.1K Code, 19.0K Data, 108.1K Total
    Debug Version:     165.1K Code, 51.9K Data, 217.0K Total
  Current Release:
    Non-Debug Version:  89.9K Code, 19.0K Data, 108.9K Total
    Debug Version:     166.3K Code, 52.1K Data, 218.4K Total

2) iASL Compiler/Disassembler and Tools:

iASL/Disassembler: Write ACPI errors to stderr instead of the output file. =
This keeps the output files free of random error messages that may originat=
e from within the namespace/interpreter code. Used this opportunity to merg=
e all ACPI:-style messages into a single new module, utxferror.c. ACPICA BZ=
 866. Lin Ming, Bob Moore.

Tools: update some printfs for ansi warnings on size_t. Handle width change=
 of size_t on 32-bit versus 64-bit generations. Lin Ming.


--===============2486007671129200506==--

