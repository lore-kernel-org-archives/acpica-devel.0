Content-Type: multipart/mixed; boundary="===============6212425733010424956=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: [Devel] ACPICA version 20160108 released
Date: Fri, 08 Jan 2016 16:15:07 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37DA83A77@ORSMSX112.amr.corp.intel.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============6212425733010424956==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

8 January 2016. Summary of changes for version 20160108:

This release is available at https://acpica.org/downloads


1) ACPICA kernel-resident subsystem:

Updated all ACPICA copyrights and signons to 2016: Added the 2016 copyright=
 to all source code module headers and utility/tool signons. This includes =
the standard Linux dual-license header. This affects virtually every file i=
n the ACPICA core subsystem, iASL compiler, all ACPICA utilities, and the A=
CPICA test suite.

Fixed a regression introduced in version 20151218 concerning the execution =
of so-called module-level ASL/AML code. Namespace objects created under a m=
odule-level If() construct were not properly/fully entered into the namespa=
ce and could cause an interpreter fault when accessed.

Example Code and Data Size: These are the sizes for the OS-independent acpi=
ca.lib produced by the Microsoft Visual C++ 9.0 32-bit compiler. The debug =
version of the code includes the debug output trace mechanism and has a muc=
h larger code and data size.

Current Release:
    Non-Debug Version: 102.7K Code, 28.4K Data, 131.1K Total
    Debug Version:     200.4K Code, 81.9K Data, 282.4K Total
  Previous Release:
    Non-Debug Version: 102.6K Code, 28.4K Data, 131.0K Total
    Debug Version:     200.3K Code, 81.9K Data, 282.3K Total


2) iASL Compiler/Disassembler and Tools:

Fixed a problem with the compilation of the GpioIo and GpioInt resource des=
criptors. The _PIN field name was incorrectly defined to be an array of 32-=
bit values, but the _PIN values are in fact 16 bits each. This would cause =
incorrect bit width warnings when using Word (16-bit) fields to access the =
descriptors.


--===============6212425733010424956==--

