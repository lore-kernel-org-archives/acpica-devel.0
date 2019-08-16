Content-Type: multipart/mixed; boundary="===============1759943432227339792=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: [Devel] ACPICA version 20190816 released
Date: Fri, 16 Aug 2019 15:28:10 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E3B96655A9@ORSMSX110.amr.corp.intel.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============1759943432227339792==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

16 August 2019. Summary of changes for version 20190816:

This release is available at https://acpica.org/downloads


1) ACPICA kernel-resident subsystem:

Modified the OwnerId mechanism to allow for more Owner Ids. The previous li=
mit was 256 Ids, now it is 4096 Ids. This prevents OWNER_ID_LIMIT exception=
s on machines with a large number of initialization threads, many CPU cores=
 and nested initialization control methods.

Introduced acpi_dispatch_gpe() as a wrapper around AcpiEvDetectGpe() for ch=
ecking if the given GPE (as represented by a GPE device handle and a GPE nu=
mber) is currently active and dispatching it (if that's the case) outside o=
f interrupt context.

Table load: exit the interpreter before initializing objects within the new=
 table This prevents re-acquiring the interpreter lock when loading tables

Added the "Windows 2019" string to the _OSI support (version 1903).

Macros: removed pointer math on a null pointer. Causes warnings on some com=
pilers and/or tools. Changed ACPI_TO_POINTER to use ACPI_CAST_PTR instead o=
f using arithmetic.

Fully deployed the ACPI_PRINTF_LIKE macro. This macro was not being used ac=
ross all "printf-like" internal functions. Also, cleanup all calls to such =
functions (both in 32-bit mode and 64-bit mode) now that they are analyzed =
by the gcc compiler via ACPI_PRINTF_LIKE.


2) iASL Compiler/Disassembler and ACPICA tools:

iASL: implemented a new data table compiler flex/bison front-end. This chan=
ge is internal and is not intended to result in changes to the compiled cod=
e. This new compiler front-end can be invoked using the -tp option for now,=
 until the old mechanism is removed.

ASLTS: Implemented a new data table compiler test suite. This test suite ge=
nerates all table templates and compile/disassemble/re-compile/binary-compa=
re each file.

iASL: return -1 if AML files were not generated due to compiler errors

iASL: added a warning on use of the now-legacy ASL Processor () keyword.

iASL: added an error on _UID object declaration that returns a String withi=
n a Processor () declaration. A _UID for a processor must be an Integer.

iASL: added a null terminator to name strings that consist only of multiple=
 parent prefixes (^)

iASL: added support to compile both ASL and data table files in a single co=
mmand.

Updated the tool generation project files that were recently migrated to MS=
VC 2017 to eliminate all new warnings. The new project files appear in the =
directory \acpica\generate\msvc2017. This change effectively deprecates the=
 older project files in \acpica\generate\msvc9.


--===============1759943432227339792==--

