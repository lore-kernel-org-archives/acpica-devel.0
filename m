Content-Type: multipart/mixed; boundary="===============4390091155225465232=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: [Devel] ACPICA version 20151218 released
Date: Fri, 18 Dec 2015 18:08:14 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37DA721E2@ORSMSX112.amr.corp.intel.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============4390091155225465232==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

18 December 2015. Summary of changes for version 20151218:

This release is available at https://acpica.org/downloads


1) ACPICA kernel-resident subsystem:

Implemented per-AML-table execution of "module-level code" as individual AC=
PI tables are loaded into the namespace during ACPICA initialization. In ot=
her words, any module-level code within an AML table is executed immediatel=
y after the table is loaded, instead of batched and executed after all of t=
he tables have been loaded. This provides compatibility with other ACPI imp=
lementations. ACPICA BZ 1219. Bob Moore, Lv Zheng, David Box.

To fully support the feature above, the default operation region handlers f=
or the SystemMemory, SystemIO, and PCI_Config address spaces are now instal=
led before any ACPI tables are loaded. This enables module-level code to ac=
cess these address spaces during the table load and module-level code execu=
tion phase. ACPICA BZ 1220. Bob Moore, Lv Zheng, David Box.

Implemented several changes to the internal _REG support in conjunction wit=
h the changes above. Also, changes to the AcpiExec/AcpiNames/Examples utili=
ties for the changes above. Although these tools were changed, host operati=
ng systems that simply use the default handlers for SystemMemory, SystemIO,=
 and PCI_Config spaces should not require any update. Lv Zheng.

For example, in the code below, DEV1 is conditionally added to the namespac=
e by the DSDT via module-level code that accesses an operation region. The =
SSDT references DEV1 via the Scope operator. DEV1 must be created immediate=
ly after the DSDT is loaded in order for the SSDT to successfully reference=
 DEV1. Previously, this code would cause an AE_NOT_EXIST exception during t=
he load of the SSDT. Now, this code is fully supported by ACPICA.

    DefinitionBlock ("", "DSDT", 2, "Intel", "DSDT1", 1)
    {
        OperationRegion (OPR1, SystemMemory, 0x400, 32)
        Field (OPR1, AnyAcc, NoLock, Preserve)
        {
            FLD1, 1
        }
        If (FLD1)
        {
            Device (\DEV1)
            {
            }
        }
    }
    DefinitionBlock ("", "SSDT", 2, "Intel", "SSDT1", 1)
    {
        External (\DEV1, DeviceObj)
        Scope (\DEV1)
        {
        }
    }

Fixed an AML interpreter problem where control method invocations were not =
handled correctly when the invocation was itself a SuperName argument to an=
other ASL operator. In these cases, the method was not invoked. ACPICA BZ 1=
002. Affects the following ASL operators that have a SuperName argument:
    Store
    Acquire, Wait
    CondRefOf, RefOf
    Decrement, Increment
    Load, Unload
    Notify
    Signal, Release, Reset
    SizeOf

Implemented automatic String-to-ObjectReference conversion support for pack=
ages returned by predefined names (such as _DEP). A common BIOS error is to=
 add double quotes around an ObjectReference namepath, which turns the refe=
rence into an unexpected string object. This support detects the problem an=
d corrects it before the package is returned to the caller that invoked the=
 method. Lv Zheng.

Implemented extensions to the Concatenate operator. Concatenate now accepts=
 any type of object, it is not restricted to simply Integer/String/Buffer. =
For objects other than these 3 basic data types, the argument is treated as=
 a string containing the name of the object type. This expands the utility =
of Concatenate and the Printf/Fprintf macros. ACPICA BZ 1222.

Cleaned up the output of the ASL Debug object. The timer() value is now opt=
ional and no longer emitted by default. Also, the basic data types of Integ=
er/String/Buffer are simply emitted as their values, without a data type st=
ring -- since the data type is obvious from the output. ACPICA BZ 1221.

Example Code and Data Size: These are the sizes for the OS-independent acpi=
ca.lib produced by the Microsoft Visual C++ 9.0 32-bit compiler. The debug =
version of the code includes the debug output trace mechanism and has a muc=
h larger code and data size.

  Current Release:
    Non-Debug Version: 102.6K Code, 28.4K Data, 131.0K Total
    Debug Version:     200.3K Code, 81.9K Data, 282.3K Total
  Previous Release:
    Non-Debug Version: 102.0K Code, 28.3K Data, 130.3K Total
    Debug Version:     199.6K Code, 81.8K Data, 281.4K Total


2) iASL Compiler/Disassembler and Tools:

iASL: Fixed some issues with the ASL Include() operator. This operator was =
incorrectly defined in the iASL parser rules, causing a new scope to be ope=
ned for the code within the include file. This could lead to several issues=
, including allowing ASL code that is technically illegal and not supported=
 by AML interpreters. Note, this does not affect the related #include prepr=
ocessor operator. ACPICA BZ 1212.

iASL/Disassembler: Implemented support for the ASL ElseIf operator. This op=
erator is essentially an ASL macro since there is no AML opcode associated =
with it. The code emitted by the iASL compiler for ElseIf is an Else opcode=
 followed immediately by an If opcode. The disassembler will now emit an El=
seIf if it finds an Else immediately followed by an If. This simplifies the=
 decoded ASL, especially for deeply nested If..Else and large Switch constr=
ucts. Thus, the disassembled code more closely follows the original source =
ASL. ACPICA BZ 1211. Example:

    Old disassembly:
        Else
        {
            If (Arg0 =3D=3D 0x02)
            {
                Local0 =3D 0x05
            }
        }

    New disassembly:
        ElseIf (Arg0 =3D=3D 0x02)
        {
            Local0 =3D 0x05
        }

AcpiExec: Added support for the new module level code behavior and the earl=
y region installation. This required a small change to the initialization, =
since AcpiExec must install its own operation region handlers.

AcpiExec: Added support to make the debug object timer optional. Default is=
 timer disabled. This cleans up the debug object output -- the timer data i=
s rarely used.

AcpiExec: Multiple ACPI tables are now loaded in the order that they appear=
 on the command line. This can be important when there are interdependencie=
s/references between the tables.

iASL/Templates. Add support to generate template files with multiple SSDTs =
within a single output file. Also added ommand line support to specify the =
number of SSDTs (in addition to a single DSDT). ACPICA BZ 1223, 1225.


--===============4390091155225465232==--

