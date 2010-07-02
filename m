Content-Type: multipart/mixed; boundary="===============1242555955752628560=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: [Devel] ACPICA version 20100702 released
Date: Fri, 02 Jul 2010 09:48:16 -0700
Message-ID: <4911F71203A09E4D9981D27F9D830858A103CDBB@orsmsx503.amr.corp.intel.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============1242555955752628560==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

02 July 2010. Summary of changes for version 20100702:

This release is available at www.acpica.org/downloads

1) ACPI CA Core Subsystem:

Implemented several updates to the recently added GPE reference count suppo=
rt. The model for "wake" GPEs is changing to give the host OS complete cont=
rol of these GPEs. Eventually, the ACPICA core will not execute any _PRW me=
thods, since the host already must execute them. Also, additional changes w=
ere made to help ensure that the reference counts are kept in proper synchr=
onization with reality. Rafael J. Wysocki.

1) Ensure that GPEs are not enabled twice during initialization.
2) Ensure that GPE enable masks stay in sync with the reference count.
3) Do not inadvertently enable GPEs when writing GPE registers.
4) Remove the internal wake reference counter and add new AcpiGpeWakeup int=
erface. This interface will set or clear individual GPEs for wakeup.
5) Remove GpeType argument from AcpiEnable and AcpiDisable. These interface=
s are now used for "runtime" GPEs only.

Changed the behavior of the GPE install/remove handler interfaces. The GPE =
is no longer disabled during this process, as it was found to cause problem=
s on some machines. Rafael J. Wysocki.

Reverted a change introduced in version 20100528 to enable Embedded Control=
ler multi-byte transfers. This change was found to cause problems with Inde=
x Fields and possibly Bank Fields. It will be reintroduced when these probl=
ems have been resolved.

Fixed a problem with references to Alias objects within Package Objects. A =
reference to an Alias within the definition of a Package was not always res=
olved properly. Aliases to objects like Processors, Thermal zones, etc. wer=
e resolved to the actual object instead of a reference to the object as it =
should be. Package objects are only allowed to contain integer, string, buf=
fer, package, and reference objects. Redhat bugzilla 608648.

Example Code and Data Size: These are the sizes for the OS-independent acpi=
ca.lib produced by the Microsoft Visual C++ 6.0 32-bit compiler. The debug =
version of the code includes the debug output trace mechanism and has a muc=
h larger code and data size.

  Previous Release:
    Non-Debug Version:  88.3K Code, 18.8K Data, 107.1K Total
    Debug Version:     164.1K Code, 51.5K Data, 215.6K Total
  Current Release:
    Non-Debug Version:  88.3K Code, 18.8K Data, 107.1K Total
    Debug Version:     164.0K Code, 51.5K Data, 215.5K Total

2) iASL Compiler/Disassembler and Tools:

iASL: Implemented a new compiler subsystem to allow definition and compilat=
ion of the non-AML ACPI tables such as FADT, MADT, SRAT, etc. These are cal=
led "ACPI Data Tables", and the new compiler is the "Data Table Compiler". =
This compiler is intended to simplify the existing error-prone process of c=
reating these tables for the BIOS, as well as allowing the disassembly, mod=
ification, recompilation, and override of existing ACPI data tables. See th=
e iASL User Guide for detailed information.

iASL: Implemented a new Template Generator option in support of the new Dat=
a Table Compiler. This option will create examples of all known ACPI tables=
 that can be used as the basis for table development. See the iASL document=
ation and the -T option.

Disassembler and headers: Added support for the WDDT ACPI table (Watchdog D=
escriptor Table).

Updated the Linux makefiles for iASL and AcpiExec to place the generated ob=
ject files in the local directory so that there can be no collisions betwee=
n the shared files between them that are generated with different options.

Added support for Mac OS X in the Unix OSL used for iASL and AcpiExec. Use =
the #define __APPLE__ to enable this support.


--===============1242555955752628560==--

