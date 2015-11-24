Content-Type: multipart/mixed; boundary="===============8085977348537557178=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: [Devel] ACPICA version 20151124 released
Date: Tue, 24 Nov 2015 15:40:18 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37D999057@ORSMSX112.amr.corp.intel.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============8085977348537557178==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

24 November 2015. Summary of changes for version 20151124:

This release is available at https://acpica.org/downloads


1) ACPICA kernel-resident subsystem:

Fixed a possible regression for a previous update to FADT handling. The FAD=
T no longer has a fixed table ID, causing some issues with code that was ha=
rdwired to a specific ID. Lv Zheng.

Fixed a problem where the method auto-serialization could interfere with th=
e current SyncLevel. This change makes the auto-serialization support trans=
parent to the SyncLevel support and management.

Removed support for the _SUB predefined name in AcpiGetObjectInfo. This int=
erface is intended for early access to the namespace during the initial nam=
espace device discovery walk. The _SUB method has been seen to access opera=
tion regions in some cases, causing errors because the operation regions ar=
e not fully initialized.

AML Debugger: Fixed some issues with the terminate/quit/exit commands that =
can cause faults. Lv Zheng.

AML Debugger: Add thread ID support so that single-step mode only applies t=
o the AML Debugger thread. This prevents runtime errors within some kernels=
. Lv Zheng. =


Eliminated extraneous warnings from AcpiGetSleepTypeData. Since the _Sx met=
hods that are invoked by this interface are optional, removed warnings emit=
ted for the case where one or more of these methods do not exist. ACPICA BZ=
 1208, original change by Prarit Bhargava.

Made a major pass through the entire ACPICA source code base to standardize=
 formatting that has diverged a bit over time. There are no functional chan=
ges, but this will of course cause quite a few code differences from the pr=
evious ACPICA release.

Example Code and Data Size: These are the sizes for the OS-independent acpi=
ca.lib produced by the Microsoft Visual C++ 9.0 32-bit compiler. The debug =
version of the code includes the debug output trace mechanism and has a muc=
h larger code and data size.

  Current Release:
    Non-Debug Version: 102.0K Code, 28.3K Data, 130.3K Total
    Debug Version:     199.6K Code, 81.8K Data, 281.4K Total
  Previous Release:
    Non-Debug Version: 101.7K Code, 27.9K Data, 129.6K Total
    Debug Version:     199.3K Code, 81.4K Data, 280.7K Total


2) iASL Compiler/Disassembler and Tools:

iASL/acpiexec/acpixtract/disassembler: Added support to allow multiple defi=
nition blocks within a single ASL file and the resulting AML file. Support =
for this type of file was also added to the various tools that use binary A=
ML files: acpiexec, acpixtract, and the AML disassembler. The example code =
below shows two definition blocks within the same file:

    DefinitionBlock ("dsdt.aml", "DSDT", 2, "Intel", "Template", 0x12345678)
    {
    }
    DefinitionBlock ("", "SSDT", 2, "Intel", "Template", 0xABCDEF01)
    {
    }

iASL: Enhanced typechecking for the Name() operator. All expressions for th=
e value of the named object must be reduced/folded to a single constant at =
compile time, as per the ACPI specification (the AML definition of Name()).

iASL: Fixed some code indentation issues for the -ic and -ia options (C and=
 assembly headers). Now all emitted code correctly begins in column 1.

iASL: Added an error message for an attempt to open a Scope() on an object =
defined in an SSDT. The DSDT is always loaded into the namespace first, so =
any attempt to open a Scope on an SSDT object will fail at runtime.


--===============8085977348537557178==--

