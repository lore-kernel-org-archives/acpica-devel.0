Content-Type: multipart/mixed; boundary="===============1389462180436334995=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: [Devel] ACPICA version 20120518 released
Date: Fri, 18 May 2012 21:32:25 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E346AC9C80@ORSMSX101.amr.corp.intel.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============1389462180436334995==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

18 May 2012. Summary of changes for version 20120518:

This release is available at https://www.acpica.org/downloads
The ACPI 5.0 specification is available at www.acpi.info

1) ACPICA Core Subsystem:

Added a new OSL interface, AcpiOsWaitEventsComplete. This interface is defi=
ned to block until asynchronous events such as notifies and GPEs have compl=
eted. Within ACPICA, it is only called before a notify or GPE handler is re=
moved/uninstalled. It also may be useful for the host OS within related dri=
vers such as the Embedded Controller driver. See the ACPICA reference for a=
dditional information. ACPICA BZ 868.

ACPI Tables: Added a new error message for a possible overflow failure duri=
ng the conversion of FADT 32-bit legacy register addresses to internal comm=
on 64-bit GAS structure representation. The GAS has a one-byte "bit length"=
 field, thus limiting the register length to 255 bits. ACPICA BZ 953.

Example Code and Data Size: These are the sizes for the OS-independent acpi=
ca.lib produced by the Microsoft Visual C++ 9.0 32-bit compiler. The debug =
version of the code includes the debug output trace mechanism and has a muc=
h larger code and data size.

  Previous Release:
    Non-Debug Version:  92.9K Code, 25.0K Data, 117.9K Total
    Debug Version:     172.6K Code, 73.4K Data, 246.0K Total
  Current Release:
    Non-Debug Version:  93.0K Code, 25.1K Data, 118.1K Total
    Debug Version:     172.7K Code, 73.6K Data, 246.3K Total


2) iASL Compiler/Disassembler and Tools:

iASL: Added the ACPI 5.0 "PCC" keyword for use in the Register() ASL macro.=
 This keyword was added late in the ACPI 5.0 release cycle and was not impl=
emented until now.

Disassembler: Added support for Operation Region externals. Adds missing su=
pport for operation regions that are defined in another table, and referenc=
ed locally via a Field or BankField ASL operator. Now generates the correct=
 External statement.

Disassembler: Several additional fixes for the External() statement generat=
ion related to some ASL operators. Also, order the External() statements al=
phabetically in the disassembler output. Fixes the External() generation fo=
r the Create* field, Alias, and Scope operators:
 1) Create* buffer field operators - fix type mismatch warning on disassemb=
ly
 2) Alias - implement missing External support
 3) Scope - fix to make sure all necessary externals are emitted.

iASL: Improved pathname support. For include files, merge the prefix pathna=
me with the file pathname and eliminate unnecessary components. Convert bac=
kslashes in all pathnames to forward slashes, for readability. Include file=
 pathname changes affect both #include and Include() type operators.

iASL/DTC/Preprocessor: Gracefully handle early EOF. Handle an EOF at the en=
d of a valid line by inserting a newline and then returning the EOF during =
the next call to GetNextLine. Prevents the line from being ignored due to E=
OF condition.

iASL: Implemented some changes to enhance the IDE support (-vi option.) Err=
or and Warning messages are now correctly recognized for both the source co=
de browser and the global error and warning counts.


--===============1389462180436334995==--

