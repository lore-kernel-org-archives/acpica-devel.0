Content-Type: multipart/mixed; boundary="===============5155077449562414388=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: [Devel] ACPICA version 20110316 released
Date: Wed, 16 Mar 2011 10:11:00 -0700
Message-ID: <4911F71203A09E4D9981D27F9D830858CAD03071@orsmsx503.amr.corp.intel.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============5155077449562414388==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

16 March 2011. Summary of changes for version 20110316:

This release is available at www.acpica.org/downloads

1) ACPI CA Core Subsystem:

Fixed a problem caused by a _PRW method appearing at the namespace root sco=
pe during the setup of wake GPEs. A fault could occur if a _PRW directly un=
der the root object was passed to the AcpiSetupGpeForWake interface. Lin Mi=
ng.

Implemented support for "spurious" Global Lock interrupts. On some systems,=
 a global lock interrupt can occur without the pending flag being set. Upon=
 a GL interrupt, we now ensure that a thread is actually waiting for the lo=
ck before signaling GL availability. Rafael Wysocki, Bob Moore.

Example Code and Data Size: These are the sizes for the OS-independent acpi=
ca.lib produced by the Microsoft Visual C++ 9.0 32-bit compiler. The debug =
version of the code includes the debug output trace mechanism and has a muc=
h larger code and data size.

  Previous Release (VC 9.0):
    Non-Debug Version:  89.7K Code, 23.7K Data, 113.4K Total
    Debug Version:     163.9K Code, 67.5K Data, 231.4K Total
  Current Release (VC 9.0):
    Non-Debug Version:  89.8K Code, 23.8K Data, 113.6K Total
    Debug Version:     164.2K Code, 67.9K Data, 232.1K Total

2) iASL Compiler/Disassembler and Tools:

Implemented full support for the "SLIC" ACPI table. Includes support in the=
 header files, disassembler, table compiler, and template generator. Bob Mo=
ore, Lin Ming.

AcpiXtract: Correctly handle embedded comments and messages from AcpiDump. =
Apparently some or all versions of acpidump will occasionally emit a commen=
t like "Wrong checksum", etc., into the dump file. This was causing problem=
s for AcpiXtract. ACPICA BZ 905.

iASL: Fix the Linux makefile by removing an inadvertent double file inclusi=
on. ACPICA BZ 913.

AcpiExec: Update installation of operation region handlers. Install one han=
dler for a user-defined address space. This is used by the ASL test suite (=
ASLTS).


--===============5155077449562414388==--

