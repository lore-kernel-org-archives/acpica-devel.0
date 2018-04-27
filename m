Content-Type: multipart/mixed; boundary="===============4175079505453222849=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: [Devel] ACPICA version 20180427 released
Date: Fri, 27 Apr 2018 20:03:02 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E3B75D0A96@ORSMSX110.amr.corp.intel.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============4175079505453222849==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

27 April 2018. Summary of changes for version 20180427:

This release is available at https://acpica.org/downloads


1) ACPICA kernel-resident subsystem:

Debugger: Added support for Package objects in the "Test Objects" command. =
This command walks the entire namespace and evaluates all named data object=
s (Integers, Strings, Buffers, and now Packages).

Improved error messages for the namespace root node. Originally, the root w=
as referred to by the confusing string "\___". This has been replaced by "N=
amespace Root" for clarification.

Fixed a potential infinite loop in the AcpiRsDumpByteList function. Colin I=
an King <colin.king(a)canonical.com>.


2) iASL Compiler/Disassembler and Tools:

iASL: Implemented support to detect and flag illegal forward references. Fo=
r compatibility with other ACPI implementations, these references are now i=
llegal at the root level of the DSDT or SSDTs. Forward references have alwa=
ys been illegal within control methods. This change should not affect exist=
ing ASL/AML code because of the fact that these references have always been=
 illegal in the other ACPI implementation.

iASL: Added error messages for the case where a table OEM ID and OEM TABLE =
ID strings are longer than the ACPI-defined length. Previously, these strin=
gs were simply silently truncated.

iASL: Enhanced the -tc option (which creates an AML hex file in C, suitable=
 for import into a firmware project):
  1) Create a unique name for the table, to simplify use of multiple SSDTs.
  2) Add a protection #ifdef in the file, similar to a .h header file.
With assistance from Sami Mujawar, sami.mujawar(a)arm.com and Evan Lloyd, e=
van.lloyd(a)arm.com

AcpiExec: Added a new option, -df, to disable the local fault handler. This=
 is useful during debugging, where it may be desired to drop into a debugge=
r on a fault.



--===============4175079505453222849==--

