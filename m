Content-Type: multipart/mixed; boundary="===============1763489853303538512=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: [Devel] ACPICA version 20150930 released
Date: Wed, 30 Sep 2015 19:33:34 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37D357C41@ORSMSX112.amr.corp.intel.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============1763489853303538512==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

30 September 2015. Summary of changes for version 20150930:

This release is available at https://acpica.org/downloads

1) ACPICA kernel-resident subsystem:

Debugger: Implemented several changes and bug fixes to assist support for t=
he in-kernel version of the AML debugger. Lv Zheng.
- Fix the "predefined" command for in-kernel debugger.
- Do not enter debug command loop for the help and version commands.
- Disallow "execute" command during execution/single-step of a method.

Interpreter: Updated runtime typechecking for all operators that have targe=
t operands. The operand is resolved and validated that it is legal. For exa=
mple, the target cannot be a non-data object such as a Device, Mutex, Therm=
alZone, etc., as per the ACPI specification.

Debugger: Fixed the double-mutex user I/O handshake to work when local dead=
lock detection is enabled.

Debugger: limited display of method locals and arguments (LocalX and ArgX) =
to only those that have actually been initialized. This prevents lines of e=
xtraneous output.

Updated the definition of the NFIT table to correct the bit polarity of one=
 flag: ACPI_NFIT_MEM_ARMED --> ACPI_NFIT_MEM_NOT_ARMED

Example Code and Data Size: These are the sizes for the OS-independent acpi=
ca.lib produced by the Microsoft Visual C++ 9.0 32-bit compiler. The debug =
version of the code includes the debug output trace mechanism and has a muc=
h larger code and data size.

  Current Release:
    Non-Debug Version: 101.7K Code, 27.9K Data, 129.6K Total
    Debug Version:     199.3K Code, 81.4K Data, 280.7K Total
  Previous Release:
    Non-Debug Version: 101.3K Code, 27.7K Data, 129.0K Total
    Debug Version:     198.6K Code, 80.9K Data, 279.5K Total


2) iASL Compiler/Disassembler and Tools:

iASL: Improved the compile-time typechecking for operands of many of the AS=
L operators:

-- Added an option to disable compiler operand/operator typechecking (-ot).

-- For the following operators, the TermArg operands are now validated when=
 possible to be Integer data objects: BankField, OperationRegion, DataTable=
Region, Buffer, and Package.

-- Store (Source, Target): Both the source and target operands are resolved=
 and checked that the operands are both legal. For example, neither operand=
 can be a non-data object such as a Device, Mutex, ThermalZone, etc. Note, =
as per the ACPI specification, the CopyObject operator can be used to store=
 an object to any type of target object.

-- Store (Source, Target): If the source is a Package object, the target mu=
st be a Package object, LocalX, ArgX, or Debug. Likewise, if the target is =
a Package, the source must also be a Package.

-- Store (Source, Target): A warning is issued if the source and target res=
olve to the identical named object.

-- Store (Source, <method invocation>): An error is generated for the targe=
t method invocation, as this construct is not supported by the AML interpre=
ter.

-- For all ASL math and logic operators, the target operand must be a data =
object (Integer, String, Buffer, LocalX, ArgX, or Debug). This includes the=
 function return value also.

-- External declarations are also included in the typechecking where possib=
le. External objects defined using the UnknownObj keyword cannot be typeche=
cked, however.

iASL and Disassembler: Added symbolic (ASL+) support for the ASL Index oper=
ator:
- Legacy code: Index(PKG1, 3)
- New ASL+ code: PKG1[3]
This completes the ACPI 6.0 ASL+ support as it was the only operator not su=
pported.

iASL: Fixed the file suffix for the preprocessor output file (.i). Two spac=
es were inadvertently appended to the filename, causing file access and del=
etion problems on some systems.

ASL Test Suite (ASLTS): Updated the master makefile to generate all possibl=
e compiler output files when building the test suite -- thus exercising the=
se features of the compiler. These files are automatically deleted when the=
 test suite exits.


--===============1763489853303538512==--

