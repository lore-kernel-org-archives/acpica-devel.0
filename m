Content-Type: multipart/mixed; boundary="===============0275307990735894319=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: [Devel] ACPICA version 20170728 released
Date: Fri, 28 Jul 2017 17:07:19 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37E5DA500@ORSMSX110.amr.corp.intel.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============0275307990735894319==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

28 July 2017. Summary of changes for version 20170728:

This release is available at https://acpica.org/downloads


1) ACPICA kernel-resident subsystem:

Fixed a regression seen with small resource descriptors that could cause an=
 inadvertent AE_AML_NO_RESOURCE_END_TAG exception.

AML interpreter: Implemented a new feature that allows forward references f=
rom individual named references within package objects that are contained w=
ithin blocks of "module-level code". This provides compatibility with other=
 ACPI implementations and supports existing firmware that depends on this f=
eature. Example:

    Name (ABCD, 1)
    If (ABCD)                       /* An If() at module-level */
    {
        Name (PKG1, Package()
        {
            INT1                    /* Forward reference to object INT1 */
        })
        Name (INT1, 0x1234)
    }

AML Interpreter: Fixed a problem with the Alias() operator where aliases to=
 some ASL objects were not handled properly. Objects affected are: Mutex, E=
vent, and OperationRegion.

AML Debugger: Enhanced to properly handle AML Alias objects. These objects =
have one level of indirection which was not fully supported by the debugger.

Table Manager: Added support to detect and ignore duplicate SSDTs within th=
e XSDT/RSDT. This error in the XSDT has been seen in the field.

EFI and EDK2 support:
    Enabled /WX flag for MSVC builds
    Added support for AcpiOsStall, AcpiOsSleep, and AcpiOsGetTimer
    Added local support for 64-bit multiply and shift operations
    Added support to compile acpidump.efi on Windows
    Added OSL function stubs for interfaces not used under EFI

Added additional support for the _DMA predefined name. _DMA returns a buffe=
r containing a resource template. This change add support within the resour=
ce manager (AcpiWalkResourceBuffer) to walk and parse this list of resource=
 descriptors. Lorenzo Pieralisi <lorenzo.pieralisi(a)arm.com>


2) iASL Compiler/Disassembler and Tools:

iASL: Fixed a problem where the internal input line buffer(s) could overflo=
w if there are very long lines in the input ASL source code file. Implement=
ed buffer management that automatically increases the size of the buffers a=
s necessary.

iASL: Added an option (-vx) to "expect" particular remarks, warnings and er=
rors. If the specified exception is not raised during compilation, the comp=
iler emits an error. This is intended to support the ASL test suite, but ma=
y be useful in other contexts.

iASL: Implemented a new predefined macro, __METHOD__, which returns a strin=
g containing the name of the current control method that is being compiled.

iASL: Implemented debugger and table compiler support for the SDEI ACPI tab=
le (Software Delegated Exception Interface). James Morse <james.morse(a)arm=
.com>

Unix/Linux makefiles: Added an option to disable compile optimizations. The=
 disable occurs when the NOOPT flag is set to TRUE. theracermaster(a)gmail.=
com

Acpidump: Added support for multiple DSDT and FACS tables. This can occur w=
hen there are different tables for 32-bit versus 64-bit.

Enhanced error reporting for the ASL test suite (ASLTS) by removing unneces=
sary/verbose text, and emit the actual line number where an error has occur=
red. These changes are intended to improve the usefulness of the test suite.


--===============0275307990735894319==--

