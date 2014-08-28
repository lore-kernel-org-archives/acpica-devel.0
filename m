Content-Type: multipart/mixed; boundary="===============8534012232381934744=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: [Devel] ACPICA version 20140828 released
Date: Thu, 28 Aug 2014 17:27:01 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37D1EAA3D@ORSMSX112.amr.corp.intel.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============8534012232381934744==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

28 August 2014. Summary of changes for version 20140828:

This release is available at https://acpica.org/downloads


1) ACPICA kernel-resident subsystem:

Fixed a problem related to the internal use of the Timer() operator where a=
 64-bit divide could cause an attempted link to a double-precision math lib=
rary. This divide is not actually necessary, so the code was restructured t=
o eliminate it. Lv Zheng.

ACPI 5.1: Added support for the runtime validation of the _DSD package (sim=
ilar to the iASL support).

ACPI 5.1/Headers: Added support for the GICC affinity subtable to the SRAT =
table. Hanjun Guo <hanjun.guo(a)linaro.org>.

Example Code and Data Size: These are the sizes for the OS-independent acpi=
ca.lib produced by the Microsoft Visual C++ 9.0 32-bit compiler. The debug =
version of the code includes the debug output trace mechanism and has a muc=
h larger code and data size.

  Current Release:
    Non-Debug Version:  98.8K Code, 27.3K Data, 126.1K Total
    Debug Version:     192.1K Code, 79.8K Data, 271.9K Total
  Previous Release:
    Non-Debug Version:  98.7K Code, 27.3K Data, 126.0K Total1
    Debug Version:     192.0K Code, 79.7K Data, 271.7K Total

2) iASL Compiler/Disassembler and Tools:

AcpiExec: Fixed a problem on unix systems where the original terminal state=
 was not always properly restored upon exit. Seen when using the -v option.=
 ACPICA BZ 1104.

iASL: Fixed a problem with the validation of the ranges/length within the M=
emory24 resource descriptor. There was a boundary condition when the range =
was equal to the (length -1) caused by the fact that these values are defin=
ed in 256-byte blocks, not bytes. ACPICA BZ 1098

Disassembler: Fixed a problem with the GpioInt descriptor interrupt polarit=
y flags. The flags are actually 2 bits, not 1, and the "ActiveBoth" keyword=
 is now supported properly.

ACPI 5.1: Added the GICC affinity subtable to the SRAT table. Supported in =
the disassembler, data table compiler, and table template generator.

iASL: Added a requirement for Device() objects that one of either a _HID or=
 _ADR must exist within the scope of a Device, as per the ACPI specificatio=
n. Remove a similar requirement that was incorrectly in place for the _DSD =
object.

iASL: Added error detection for illegal named references within control met=
hods that would cause runtime failures. Now trapped as errors are: 1) Refer=
ences to objects within a non-parent control method. 2) Forward references =
(within a method) -- for control methods, AML interpreters use a one-pass p=
arse of control methods. ACPICA BZ 1008.

iASL: Added error checking for dependencies related to the _PSx power metho=
ds. ACPICA BZ 1029.
1) For _PS0, one of these must exist within the same scope: _PS1, _PS2, _PS=
3.
2) For _PS1, _PS2, and PS3: A _PS0 object must exist within the same scope.

iASL and table compiler: Cleanup miscellaneous memory leaks by fully deploy=
ing the existing object and string caches and adding new caches for the tab=
le compiler.

iASL: Split the huge parser source file into multiple subfiles to improve m=
anageability. Generation now requires the M4 macro preprocessor, which is p=
art of the Bison distribution on both unix and windows platforms.

AcpiSrc: Fixed and removed all extraneous warnings generated during entire =
ACPICA source code scan and/or conversion.



--===============8534012232381934744==--

