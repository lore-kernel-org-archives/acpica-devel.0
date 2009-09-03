Content-Type: multipart/mixed; boundary="===============5931560901709928731=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: [Devel] ACPICA version 20090903 released
Date: Thu, 03 Sep 2009 12:41:46 -0700
Message-ID: <4911F71203A09E4D9981D27F9D8308583748AFEF@orsmsx503.amr.corp.intel.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============5931560901709928731==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

03 September 2009. Summary of changes for version 20090903:

This release is available at www.acpica.org/downloads

1) ACPI CA Core Subsystem:

For Windows Vista compatibility, added the automatic execution of an _INI m=
ethod located at the namespace root (\_INI). This method is executed at tab=
le load time. This support is in addition to the automatic execution of \_S=
B._INI. Lin Ming.

Fixed a possible memory leak in the interpreter for AML package objects if =
the package initializer list is longer than the defined size of the package=
. This apparently can only happen if the BIOS changes the package size on t=
he fly (seen in a _PSS object), as ASL compilers do not allow this. The int=
erpreter will truncate the package to the defined size (and issue an error =
message), but previously could leave the extra objects undeleted if they we=
re pre-created during the argument processing (such is the case if the pack=
age consists of a number of sub-packages as in the _PSS.) ACPICA BZ 805.

Fixed a problem seen when a Buffer or String is stored to itself via ASL. T=
his has been reported in the field. Previously, ACPICA would zero out the b=
uffer/string. Now, the operation is treated as a noop. Provides Windows com=
patibility. ACPICA BZ 803. Lin Ming.

Removed an extraneous error message for ASL constructs of the form Store(Lo=
calX,LocalX) when LocalX is uninitialized. These curious statements are see=
n in many BIOSs and are once again treated as NOOPs and no error is emitted=
 when they are encountered. ACPICA BZ 785.

Fixed an extraneous warning message if a _DSM reserved method returns a Pac=
kage object. _DSM can return any type of object, so validation on the retur=
n type cannot be performed. ACPICA BZ 802.

Example Code and Data Size: These are the sizes for the OS-independent acpi=
ca.lib produced by the Microsoft Visual C++ 6.0 32-bit compiler. The debug =
version of the code includes the debug output trace mechanism and has a muc=
h larger code and data size.

  Previous Release:
    Non-Debug Version:  85.5K Code, 18.0K Data, 103.5K Total
    Debug Version:     161.6K Code, 50.9K Data, 212.5K Total
  Current Release:
    Non-Debug Version:  85.6K Code, 18.0K Data, 103.6K Total
    Debug Version:     161.7K Code, 50.9K Data, 212.6K Total

2) iASL Compiler/Disassembler and Tools:

iASL: Fixed a problem with the use of the Alias operator and Resource Templ=
ates. The correct alias is now constructed and no error is emitted. ACPICA =
BZ 738.

iASL: Implemented the -I option to specify additional search directories fo=
r include files. Allows multiple additional search paths for include files.=
 Directories are searched in the order specified on the command line (after=
 the local directory is searched.) ACPICA BZ 800.

iASL: Fixed a problem where the full pathname for include files was not emi=
tted for warnings/errors. This caused the IDE support to not work properly.=
 ACPICA BZ 765.

iASL: Implemented the -@ option to specify a Windows-style response file co=
ntaining additional command line options. ACPICA BZ 801.

AcpiExec: Added support to load multiple AML files simultaneously (such as =
a DSDT and multiple SSDTs). Also added support for wildcards within the AML=
 pathname. These features allow all machine tables to be easily loaded and =
debugged together. ACPICA BZ 804.

Disassembler: Added missing support for disassembly of HEST table Error Ban=
k subtables. =



--===============5931560901709928731==--

