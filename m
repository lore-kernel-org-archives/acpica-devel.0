Content-Type: multipart/mixed; boundary="===============8294406596080892150=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: [Devel] ACPICA version 20200717 released
Date: Fri, 17 Jul 2020 20:48:07 +0000
Message-ID: <BYAPR11MB325601E850986788A8D59E12877C0@BYAPR11MB3256.namprd11.prod.outlook.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============8294406596080892150==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

17 July 2020. Summary of changes for version 20200717:

This release is available at https://acpica.org/downloads


1) ACPICA kernel-resident subsystem:

Do not increment OperationRegion reference counts for field units. Recent s=
erver firmware has revealed that this reference count can overflow on large=
 servers that declare many field units (thousands) under the same Operation=
Region. This occurs because each field unit declaration will add a referenc=
e count to the source OperationRegion. This release solves the reference co=
unt overflow for OperationRegion objects by preventing fieldUnits from incr=
ementing their parent OperationRegion's reference count.

Replaced one-element arrays with flexible-arrays, which were introduced in =
C99.

Restored the readme file containing the directions for generation of ACPICA=
 from source on MSVC 2017. Updated the file for MSVC 2017. File is located =
at: generate/msvc2017/readme.txt

2) iASL Compiler/Disassembler and ACPICA tools: =


iASL: Fixed a regression found in version 20200214. Prevent iASL from emitt=
ing an extra byte of garbage data when control methods declared a single pa=
rameter type without using braces. This extra byte is known to cause a blue=
 screen on the Windows AML interpreter.

iASL: Made a change to allow external declarations to specify the type of a=
 named object even when some name segments are not defined.
This change allows the following ASL code to compile (When DEV0 is not defi=
ned or not defined yet):

    External (\_SB.DEV0.OBJ1, IntObj)
    External (\_SB.DEV0, DeviceObj)

iASL: Fixed a problem where method names in "Alias ()" statement could be m=
isinterpreted. They are now interpreted correctly as method invocations.

iASL: capture a method parameter count (Within the Method info segment, as =
well as the argument node) when using parameter type lists.

--===============8294406596080892150==--

