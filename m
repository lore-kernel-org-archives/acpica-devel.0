Content-Type: multipart/mixed; boundary="===============6045358283996320913=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: [Devel] ACPICA version 20091013 released
Date: Tue, 13 Oct 2009 13:48:13 -0700
Message-ID: <4911F71203A09E4D9981D27F9D8308583B31AFCB@orsmsx503.amr.corp.intel.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============6045358283996320913==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

13 October 2009. Summary of changes for version 20091013:

This release is available at www.acpica.org/downloads

1) ACPI CA Core Subsystem:

Fixed a problem where an Operation Region _REG method could be executed mor=
e than once. If a custom address space handler is installed by the host bef=
ore the "initialize operation regions" phase of the ACPICA initialization, =
any _REG methods for that address space could be executed twice. This chang=
e fixes the problem. ACPICA BZ 427. Lin Ming.

Fixed a possible memory leak for the Scope() ASL operator. When the exact i=
nvocation of "Scope(\)" is executed (change scope to root), one internal op=
erand object was leaked. Lin Ming.

Implemented a run-time repair for the _MAT predefined method. If the _MAT r=
eturn value is defined as a Field object in the AML, and the field
size is less than or equal to the default width of an integer (32 or 64),_M=
AT can incorrectly return an Integer instead of a Buffer. ACPICA now automa=
tically repairs this problem. ACPICA BZ 810.

Implemented a run-time repair for the _BIF and _BIX predefined methods. The=
 "OEM Information" field is often incorrectly returned as an Integer with v=
alue zero if the field is not supported by the platform. This is due to an =
ambiguity in the ACPI specification. The field should always be a string. A=
CPICA now automatically repairs this problem by returning a NULL string wit=
hin the returned Package. ACPICA BZ 807.

Example Code and Data Size: These are the sizes for the OS-independent acpi=
ca.lib produced by the Microsoft Visual C++ 6.0 32-bit compiler. The debug =
version of the code includes the debug output trace mechanism and has a muc=
h larger code and data size.

  Previous Release:
    Non-Debug Version:  85.6K Code, 18.0K Data, 103.6K Total
    Debug Version:     161.7K Code, 50.9K Data, 212.6K Total
  Current Release:
    Non-Debug Version:  85.8K Code, 18.0K Data, 103.8K Total
    Debug Version:     161.8K Code, 50.6K Data, 212.4K Total

2) iASL Compiler/Disassembler and Tools:

Disassembler: Fixed a problem where references to external symbols that con=
tained one or more parent-prefixes (carats) were not handled correctly, pos=
sibly causing a fault. ACPICA BZ 806. Lin Ming.

Disassembler: Restructured the code so that all functions that handle exter=
nal symbols are in a single module. One new file is added, common/dmextern.=
c.

AML Debugger: Added a max count argument for the Batch command (which execu=
tes multiple predefined methods within the namespace.)

iASL: Updated the compiler documentation (User Reference.) Available at htt=
p://www.acpica.org/documentation/. ACPICA BZ 750.

AcpiXtract: Updated for Lint and other formatting changes. Close all open f=
iles.


--===============6045358283996320913==--

