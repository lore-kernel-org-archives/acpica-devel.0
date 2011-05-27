Content-Type: multipart/mixed; boundary="===============1418007712738532165=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: [Devel] ACPICA version 20110527 released
Date: Fri, 27 May 2011 16:03:45 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E3BC2F@ORSMSX101.amr.corp.intel.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============1418007712738532165==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

27 May 2011. Summary of changes for version 20110527:

This release is available at www.acpica.org/downloads

1) ACPI CA Core Subsystem:

ASL Load() operator: Reinstate most restrictions on the incoming ACPI table=
 signature. Now, only allow SSDT, OEMx, and a null signature. History:
    1) Originally, we checked the table signature for "SSDT" or "PSDT".
       (PSDT is now obsolete.)
    2) We added support for OEMx tables, signature "OEM" plus a fourth
       "don't care" character.
    3) Valid tables were encountered with a null signature, so we just
       gave up on validating the signature, (05/2008).
    4) We encountered non-AML tables such as the MADT, which caused
       interpreter errors and kernel faults. So now, we once again allow
       only SSDT, OEMx, and now, also a null signature. (05/2011).

Added the missing _TDL predefined name to the global name list in order to =
enable validation. Affects both the core ACPICA code and the iASL compiler.

Example Code and Data Size: These are the sizes for the OS-independent acpi=
ca.lib produced by the Microsoft Visual C++ 9.0 32-bit compiler. The debug =
version of the code includes the debug output trace mechanism and has a muc=
h larger code and data size.

  Previous Release (VC 9.0):
    Non-Debug Version:  90.0K Code, 23.8K Data, 113.8K Total
    Debug Version:     164.5K Code, 68.0K Data, 232.5K Total
  Current Release (VC 9.0):
    Non-Debug Version:  90.1K Code, 23.9K Data, 114.0K Total
    Debug Version:     165.6K Code, 68.4K Data, 234.0K Total

2) iASL Compiler/Disassembler and Tools:

Debugger/AcpiExec: Implemented support for "complex" method arguments on th=
e debugger command line. This adds support beyond simple integers -- includ=
ing Strings, Buffers, and Packages. Includes support for nested packages. I=
ncreased the default command line buffer size to accommodate these argument=
s. See the ACPICA reference for details and syntax. ACPICA BZ 917.
 =

Debugger/AcpiExec: Implemented support for "default" method arguments for t=
he Execute/Debug command. Now, the debugger will always invoke a control me=
thod with the required number of arguments -- even if the command line spec=
ifies none or insufficient arguments. It uses default integer values for an=
y missing arguments. Also fixes a bug where only six method arguments maxim=
um were supported instead of the required seven.

Debugger/AcpiExec: Add a maximum buffer length parameter to AcpiOsGetLine a=
nd also return status in order to prevent buffer overruns. See the ACPICA r=
eference for details and syntax. ACPICA BZ 921

iASL: Cleaned up support for Berkeley yacc. A general cleanup of code and m=
akefiles to simplify support for the two different but similar parser gener=
ators, bison and yacc.

Updated the generic unix makefile for gcc 4. The default gcc version is now=
 expected to be 4 or greater, since options specific to gcc 4 are used.


--===============1418007712738532165==--

