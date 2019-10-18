Content-Type: multipart/mixed; boundary="===============4742943381301497054=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: [Devel] ACPICA version 20191018 released
Date: Fri, 18 Oct 2019 16:32:37 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E3B969E4CF@ORSMSX110.amr.corp.intel.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============4742943381301497054==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

18 October 2019. Summary of changes for version 20191018:

This release is available at https://acpica.org/downloads


1) ACPICA kernel-resident subsystem:

Debugger: added a new command: "Fields [address space ID]". This command du=
mps the contents of all field units that are defined within the namespace w=
ith a particular address space ID.

Modified the external interface AcpiLoadTable() to return a table index. Th=
is table index can be used for unloading a table for debugging.
    ACPI_STATUS
    AcpiLoadTable (
        ACPI_TABLE_HEADER       *Table,
        UINT32                  *TableIndex))

Implemented a new external interface: AcpiUnloadTable() This new function t=
akes a table index as an argument and unloads the table. Useful for debuggi=
ng only.
    ACPI_STATUS
    AcpiUnloadTable (
        UINT32                  TableIndex))

Ported the AcpiNames utility to use the new table initialization sequence. =
The utility was broken before this change. Also, it was required to include=
 most of the AML interpreter into the utility in order to process table ini=
tialization (module-level code execution.)

Update for results from running Clang V8.0.1. This fixes all "dead assignme=
nt" warnings. There are still several "Dereference of NULL pointer" warning=
s, but these have been found to be false positive warnings.


2) iASL Compiler/Disassembler and ACPICA tools:

iASL: numerous table compiler changes to ensure that the usage of yacc/biso=
n syntax is POSIX-compliant.

iASL/disassembler: several simple bug fixes in the data table disassembler.

Acpiexec: expand the initialization file (the -fi option) to initialize str=
ings, buffers, packages, and field units.


--===============4742943381301497054==--

