Content-Type: multipart/mixed; boundary="===============0519541714309952519=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: [Devel] ACPICA version 20160422 released
Date: Fri, 22 Apr 2016 15:23:18 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37E476914@ORSMSX110.amr.corp.intel.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============0519541714309952519==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

22 April 2016. Summary of changes for version 20160422:

This release is available at https://acpica.org/downloads


1) ACPICA kernel-resident subsystem:

Fixed a regression in the GAS (generic address structure) arbitrary bit sup=
port in AcpiHwRead/AcpiHwWrite. Problem could cause incorrect behavior and =
incorrect return values. Lv Zheng. ACPICA BZ 1270.

ACPI 6.0: Added support for new/renamed resource macros. One new argument w=
as added to each of these macros, and the original name has been deprecated=
. The AML disassembler will always disassemble to the new names. Support fo=
r the new macros was added to iASL, disassembler, resource manager, and the=
 acpihelp utility. ACPICA BZ 1274.

    I2cSerialBus  -> I2cSerialBusV2
    SpiSerialBus  -> SpiSerialBusV2
    UartSerialBus -> UartSerialBusV2

ACPI 6.0: Added support for a new integer field that was appended to the pa=
ckage object returned by the _BIX method. This adds iASL compile-time and A=
ML runtime error checking. ACPICA BZ 1273.

ACPI 6.1: Added support for a new PCCT subtable, "HW-Reduced Comm Subspace =
Type2" (Headers, Disassembler, and data table compiler).

Example Code and Data Size: These are the sizes for the OS-independent acpi=
ca.lib produced by the Microsoft Visual C++ 9.0 32-bit compiler. The debug =
version of the code includes the debug output trace mechanism and has a muc=
h larger code and data size.

  Current Release:
    Non-Debug Version: 137.4K Code, 52.6K Data, 190.0K Total
    Debug Version:     201.5K Code, 82.2K Data, 283.7K Total
  Previous Release:
    Non-Debug Version: 137.1K Code, 51.5K Data, 188.6K Total
    Debug Version:     201.0K Code, 82.0K Data, 283.0K Total


2) iASL Compiler/Disassembler and Tools:

iASL: Implemented an ASL grammar extension to allow/enable executable "modu=
le-level code" to be created and executed under the various operators that =
create new scopes. This type of AML code is already supported in all known =
AML interpreters, and the grammar change will appear in the next version of=
 the ACPI specification. Simplifies the conditional runtime creation of nam=
ed objects under these object types: =


    Device
    PowerResource
    Processor
    Scope
    ThermalZone

iASL: Implemented a new ASL extension, a "For" loop macro to add greater ea=
se-of-use to the ASL language. The syntax is similar to the corresponding C=
 operator, and is implemented with the existing AML While opcode -- thus re=
quiring no changes to existing AML interpreters.

    For (Initialize, Predicate, Update) {TermList}

Grammar:
    ForTerm :=3D
        For (
            Initializer    // Nothing | TermArg =3D> ComputationalData
            Predicate      // Nothing | TermArg =3D> ComputationalData
            Update         // Nothing | TermArg =3D> ComputationalData
        ) {TermList}


iASL: The _HID/_ADR detection and validation has been enhanced to search un=
der conditionals in order to allow these objects to be conditionally create=
d at runtime.

iASL: Fixed several issues with the constant folding feature. The improveme=
nt allows better detection and resolution of statements that can be folded =
at compile time. ACPICA BZ 1266. =


iASL/Disassembler: Fixed a couple issues with the Else{If{}...} conversion =
to the ASL ElseIf operator where incorrect ASL code could be generated.

iASL/Disassembler: Fixed a problem with the ASL+ code disassembly where som=
etimes an extra (and extraneous) set of parentheses were emitted for some c=
ombinations of operators. Although this did not cause any problems with rec=
ompilation of the disassembled code, it made the code more difficult to rea=
d. David Box. ACPICA BZ 1231.

iASL: Changed to ignore the unreferenced detection for predefined names of =
resource descriptor elements, when the resource descriptor is created/defin=
ed within a control method.

iASL: Disassembler: Fix a possible fault with externally declared Buffer ob=
jects.


--===============0519541714309952519==--

