Content-Type: multipart/mixed; boundary="===============7311516174150811857=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: [Devel] ACPICA version 20180531 released
Date: Thu, 31 May 2018 20:33:31 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E3B94B56EF@ORSMSX110.amr.corp.intel.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============7311516174150811857==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

31 May 2018. Summary of changes for version 20180531:

This release is available at https://acpica.org/downloads


1) ACPICA kernel-resident Subsystem:

Implemented additional support to help ensure that a DSDT or SSDT is fully =
loaded even if errors are incurred during the load. The majority of the pro=
blems that are seen is the failure of individual AML operators that occur d=
uring execution of any module-level code (MLC) existing in the table. This =
support adds a mechanism to abort the current ASL statement (AML opcode), e=
mit an error message, and to simply move on to the next opcode -- instead o=
f aborting the entire table load. This is different than the execution of a=
 control method where the entire method is aborted upon any error. The goal=
 is to perform a very "best effort" to load the ACPI tables. The most commo=
n MLC errors that have been seen in the field are direct references to unre=
solved ASL/AML symbols (referenced directly without the use of the CondRefO=
f operator to validate the symbol). This new ACPICA behavior is now compati=
ble with other ACPI implementations.

Interpreter: The Unload AML operator is no longer supported for the reasons=
 below. An AE_NOT_IMPLEMENTED exception is returned.
    1) A correct implementation on at least some hosts may not be possible.
    2) Other ACPI implementations do not correctly/fully support it.
    3) It requires host device driver support which is not known to exist.
        (To properly support namespace unload out from underneath.)
    4) This AML operator has never been seen in the field.

Parser: Added a debug option to dump AML parse sub-trees as they are being =
executed. Used with ACPI_DEBUG_PRINT, the enabling debug level is ACPI_DB_P=
ARSE_TREES.

Debugger: Reduced the verbosity for errors incurred during table load and m=
odule-level code execution.

Completed an investigation into adding a namespace node "owner list" instea=
d of the current "owner ID" associated with namespace nodes. This list woul=
d link together all nodes that are owned by an individual control method. T=
he purpose would be to enhance control method execution by speeding up clea=
nup during method exit (all namespace nodes created by a method are deleted=
 upon method termination.) Currently, the entire namespace must be searched=
 for matching owner IDs if (and only if) the method creates named objects o=
utside of the local scope. However, by far the most common case is that met=
hods create objects locally, not outside the method scope. There is already=
 an ACPICA optimization in place that only searches the entire namespace in=
 the rare case of a method creating objects elsewhere in the namespace. The=
refore, it is felt that the overhead of adding an additional pointer to eac=
h namespace node to implement the owner list makes this feature unnecessary.


2) iASL Compiler/Disassembler and Tools:

iASL, Disassembler, and Template generator: Implemented support for Revisio=
n D of the IORT table. Adds a new subtable that is used to specify SMMUv3 P=
MCGs. rmurphy-arm.

Disassembler: Restored correct table header validation for the "special" AC=
PI tables -- RSDP and FACS. These tables do not contain a standard ACPI tab=
le header and must be special-cased. This was a regression that has been pr=
esent for apparently a long time.

AcpiExec: Reduced verbosity of the local exception handler implemented with=
in acpiexec. This handler is invoked by ACPICA upon any exceptions generate=
d during control method execution. A new option was added: -vh restores the=
 original verbosity level if desired.

AcpiExec: Changed the default base from decimal to hex for the -x option (s=
et debug level). This simplifies the use of this option and matches the beh=
avior of the corresponding iASL -x option.

AcpiExec: Restored a force-exit on multiple control-c (sigint) interrupts. =
This allows program termination even if other issues cause the control-c to=
 fail.

ASL test suite (ASLTS): Added tests for the recently implemented package el=
ement resolution mechanism that allows forward references to named objects =
from individual package elements (this mechanism provides compatibility wit=
h other ACPI implementations.)



--===============7311516174150811857==--

