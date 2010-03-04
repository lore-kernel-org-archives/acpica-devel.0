Content-Type: multipart/mixed; boundary="===============4048063968398004298=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: [Devel] ACPICA version 20100304 released
Date: Thu, 04 Mar 2010 10:18:35 -0800
Message-ID: <4911F71203A09E4D9981D27F9D83085859DCCCE8@orsmsx503.amr.corp.intel.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============4048063968398004298==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

04 March 2010. Summary of changes for version 20100304:

This release is available at www.acpica.org/downloads

1) ACPI CA Core Subsystem:

Fixed a possible problem with the AML Mutex handling function AcpiExRelease=
Mutex where the function could fault under the very rare condition when the=
 interpreter has blocked, the interpreter lock is released, the interpreter=
 is then reentered via the same thread, and attempts to acquire an AML mute=
x that was previously acquired. FreeBSD report 140979. Lin Ming.

Implemented additional configuration support for the AML "Debug Object". Ou=
tput from the debug object can now be enabled via a global variable, AcpiGb=
l_EnableAmlDebugObject. This will assist with remote machine debugging. Thi=
s debug output is now available in the release version of ACPICA instead of=
 just the debug version. Also, the entire debug output module can now be co=
nfigured out of the ACPICA build if desired. One new file added, executer/e=
xdebug.c. Lin Ming, Bob Moore.

Added header support for the ACPI MCHI table (Management Controller Host In=
terface Table). This table was added in ACPI 4.0, but the defining document=
 has only recently become available.

Standardized output of integer values for ACPICA warnings/errors. Always us=
e 0x prefix for hex output, always use %u for unsigned integer decimal outp=
ut. Affects ACPI_INFO, ACPI_ERROR, ACPI_EXCEPTION, and ACPI_WARNING (about =
400 invocations.) These invocations were converted from the original ACPI_D=
EBUG_PRINT invocations and were not consistent. ACPICA BZ 835.

Example Code and Data Size: These are the sizes for the OS-independent acpi=
ca.lib produced by the Microsoft Visual C++ 6.0 32-bit compiler. The debug =
version of the code includes the debug output trace mechanism and has a muc=
h larger code and data size.

  Previous Release:
    Non-Debug Version:  87.1K Code, 18.0K Data, 105.1K Total
    Debug Version:     163.5K Code, 50.9K Data, 214.4K Total
  Current Release:
    Non-Debug Version:  87.5K Code, 18.4K Data, 105.9K Total
    Debug Version:     163.4K Code, 51.1K Data, 214.5K Total

2) iASL Compiler/Disassembler and Tools:

iASL: Implemented typechecking support for static (non-control method) pred=
efined named objects that are declared with the Name() operator. For exampl=
e, the type of this object is now validated to be of type Integer: Name(_BB=
N, 1). This change migrates the compiler to using the core predefined name =
table instead of maintaining a local version. Added a new file, aslpredef.c=
. ACPICA BZ 832.

Disassembler: Added support for the ACPI 4.0 MCHI table.


--===============4048063968398004298==--

