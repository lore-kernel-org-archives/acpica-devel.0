Content-Type: multipart/mixed; boundary="===============0739397475273337696=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: [Devel] ACPICA version 20200528 released
Date: Thu, 28 May 2020 20:45:30 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E3D1C25826@ORSMSX110.amr.corp.intel.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============0739397475273337696==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

28 May 2020. Summary of changes for version 20200528:

This release is available at https://acpica.org/downloads


1) ACPICA kernel-resident subsystem:

Removed old/obsolete Visual Studio files which were used to build the Windo=
ws versions of the ACPICA tools. Since we have moved to Visual Studio 2017,=
 we are no longer supporting Visual Studio 2006 and 2009 project files. The=
 new subdirectory and solution file are located at:

    acpica/generate/msvc2017/AcpiComponents.sln


2) iASL Compiler/Disassembler and ACPICA tools: =


iASL: added support for a new OperationRegion Address Space (subtype): Plat=
formRtMechanism. Support for this new keyword is being released for early p=
rototyping. It will appear in the next release of the ACPI specification.

iASL: do not optimize the NameString parameter of the CondRefOf operator. I=
n the previous iASL compiler release, the NameString parameter of the CondR=
efOf was optimized. There is evidence that some implementations of the AML =
interpreter do not perform the recursive search-to-parent search during the=
 execution of the CondRefOf operator. Therefore, the CondRefOf operator beh=
aves differently when the NameString parameter is a single name segment (a =
NameSeg) as opposed to a full NamePath (starting at the root scope) or a Na=
meString containing parent prefixes.

iASL: Prevent an inadvertent remark message. This change prevents a remark =
if within a control method the following exist:
1) An Operation Region is defined, and
2) A Field operator is defined that refers to the region.
This happens because at the top level, the Field operator does not actually=
 create a new named object, it simply references the operation region.

Removed support for the acpinames utility. The acpinames was a simple utili=
ty used to populate and display the ACPI namespace without executing any AM=
L code. However, ACPICA now supports executable opcodes outside of control =
methods. This means that executable AML opcodes such as If and Store opcode=
s need to be executed during table load. Therefore, acpinames would need to=
 be updated to match the same behavior as the acpiexec utility and since ac=
piexec can already dump the entire namespace (via the 'namespace' command),=
 we no longer have the need to maintain acpinames.

    In order to dump the contents of the ACPI namepsace using acpiexec, exe=
cute the following command from the command line:

        acpiexec -b "n" [aml files]

--===============0739397475273337696==--

