Content-Type: multipart/mixed; boundary="===============6262112470463204461=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: [Devel] ACPICA version 20220331 released
Date: Thu, 31 Mar 2022 17:21:24 +0000
Message-ID: <BYAPR11MB3256AA36C4639664A881831687E19@BYAPR11MB3256.namprd11.prod.outlook.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============6262112470463204461==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

31 March 2022. Summary of changes for version 20220331:

This release is available at https://acpica.org/downloads

0) Global changes:

Update all copyright notices to the year 2022. This effects all source modu=
les, as well as utility signons.


1) ACPICA kernel-resident subsystem:

For the ASL Sleep() operator, issue a warning if the sleep value is greater=
 than 10 Milliseconds. Quick boottime is important, so warn about sleeps gr=
eater than 10 ms. Distribution Linux kernels reach initrd in 350 ms, so exc=
essive delays should be called out. 10 ms is chosen randomly, but three of =
such delays would already make up ten percent of the boottime.

Namespace: Avoid attempting to walk the Namespace if the Namespace does not=
 exist.

AML interpreter/iASL compiler: Add new Acpi 6.4 semantics for the LoadTable=
 and Load operators. DDB_HANDLE is gone, now loadtable returns a pass/fail =
integer. Now load returns a pass/fail integer, as well as storing the retur=
n value in an optional 2nd argument.

Headers: Use uintptr_t and offsetof() in Linux kernel builds. To avoid "per=
forming pointer subtraction with a null pointer has undefined behavior" com=
piler warnings, use uintptr_t and offsetof() that are always available duri=
ng Linux kernel builds to define ACPI_UINTPTR_T and the ACPI_TO_INTEGER() a=
nd ACPI_OFFSET() macros when building the ACPICA code in the Linux kernel.

Added support for the Windows 11 _OSI string ("Windows 2021"). Submitted by=
 superm1.

executer/exsystem: Inform users about ACPI spec violation for the Stall() o=
perator. Values greater than 100 microseconds violate the ACPI specificatio=
n, so warn users about it. From the ACPI Specification version 6.2 Errata A=
, 19.6.128 *Stall (Stall for a Short Time)*:
> The implementation of Stall is OS-specific, but must not relinquish
> control of the processor. Because of this, delays longer than 100
> microseconds must use Sleep instead of Stall.


2) iASL Compiler/Disassembler and ACPICA tools:

Data Table Compiler/Disassembler: Add support for the APMT table - ARM Perf=
ormance Monitoring Unit table. Submitted by @bwicaksononv.

Data Table Compiler/Disassembler: For MADT, add support for the OEM-defined=
 subtables (Types 0x80-0x7F).

Data Table Compiler: Fixed a problem with support for the SDEV table, where=
 a subtable Length was not computed correctly.

Data Table Compiler/Disassembler: Add/fix the CFMWS subtable to the CEDT Ac=
pi table support.

Data Table Compiler/Disassembler: Fix a compile issue with the CEDT and add=
 template. Submitted by MasterDrogo.

Data Table Compiler/Disassembler: NHLT Changes provided by Piotr Maziarz:
iASL/NHLT: Rename linux specific structures to DeviceInfo to improve readab=
ility of the code.
iASL/NHLT: Fix parsing undocumented bytes at the end of Endpoint. Undocumen=
ted bytes at the end of Endpoint Descriptor can be present independently of=
 Linux-specific structures. Their size can also vary.
iASL/NHLT: Treat TableTerminator as SpecificConfig. SpecificConfig has 4 by=
tes of size and then an amount of bytes specified by size. All of the termi=
nators that I've seen had a size equal to 4, but theoretically it can vary.

iASL/AcpiExec: Use _exit instead of exit in signal handers (ctrl-C).

iASL: Remove a remark due to excessive output. Removed a remark for duplica=
te Offset() operators, due to a user complaint.

--===============6262112470463204461==--

