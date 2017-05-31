Content-Type: multipart/mixed; boundary="===============7638809000835036157=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: [Devel] ACPICA version 20170531 released
Date: Wed, 31 May 2017 21:50:09 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37E5BB0FA@ORSMSX110.amr.corp.intel.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============7638809000835036157==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

31 May 2017. Summary of changes for version 20170531:

This release is available at https://acpica.org/downloads


0) ACPI 6.2 support:

The ACPI specification version 6.2 has been released and is available at
http://uefi.org/specifications

This version of ACPICA fully supports the ACPI 6.2 specification. Changes a=
re summarized below.

New ACPI tables (Table Compiler/Disassembler/Templates):
    HMAT (Heterogeneous Memory Attributes Table)
    WSMT (Windows SMM Security Mitigation Table)
    PPTT (Processor Properties Topology Table)

New subtables for existing ACPI tables:
    HEST (New subtable, Arch-deferred machine check)
    SRAT (New subtable, Arch-specific affinity structure)
    PCCT (New subtables, Extended PCC subspaces (types 3 and 4))

Simple updates for existing ACPI tables:
    BGRT (two new flag bits)
    HEST (New bit defined for several subtables, GHES_ASSIST)

New Resource Descriptors and Resource macros (Compiler/Disassembler):
    PinConfig()
    PinFunction()
    PinGroup()
    PinGroupConfig()
    PinGroupFunction()
    New type for hardware error notification (section 18.3.2.9)

New predefined names/methods (Compiler/Interpreter):
    _HMA (Heterogeneous Memory Attributes)
    _LSI (Label Storage Information)
    _LSR (Label Storage Read)
    _LSW (Label Storage Write)

ASL grammar/macro changes (Compiler):
    For() ASL macro, implemented with the AML while operator
    Extensions to Concatenate operator
    Support for multiple definition blocks in same ASL file
    Clarification for Buffer operator
    Allow executable AML code underneath all scopes (Devices, etc.)
    Clarification/change for the _OSI return value
    ASL grammar update for reference operators
    Allow a zero-length string for AML filename in DefinitionBlock

Miscellaneous:
    New device object notification value
    Remove a notify value (0x0C) for graceful shutdown
    New UUIDs for processor/cache properties and physical package property
    New _HID, ACPI0014 (Wireless Power Calibration Device)


1) ACPICA kernel-resident subsystem:

Added support to disable ACPI events on hardware-reduced platforms. Elimina=
tes error messages of the form "Could not enable fixed event". Lv Zheng

Fixed a problem using Device/Thermal objects with the ObjectType and DerefO=
f ASL operators. This support had not been fully/properly implemented.

Fixed a problem where if a Buffer object containing a resource template was=
 longer than the actual resource template, an error was generated -- even t=
hough the AML is legal. This case has been seen in the field.

Fixed a problem with the header definition of the MADT PCAT_COMPAT flag. Th=
e values for DUAL_PIC and MULTIPLE_APIC were reversed.

Added header file changes for the TPM2 ACPI table. Update to new version of=
 the TCG specification. Adds a new TPM2 subtable for ARM SMC.

Exported the external interfaces AcpiAcquireMutex and AcpiReleaseMutex. The=
se interfaces are intended to be used only in conjunction with the predefin=
ed _DLM method (Device Lock Method). "This object appears in a device scope=
 when AML access to the device must be synchronized with the OS environment=
".

Example Code and Data Size: These are the sizes for the OS-independent =

acpica.lib produced by the Microsoft Visual C++ 9.0 32-bit compiler. The =

debug version of the code includes the debug output trace mechanism and =

has a much larger code and data size.

  Current Release:
    Non-Debug Version: 143.1K Code, 60.0K Data, 203.1K Total
    Debug Version:     204.0K Code, 84.3K Data, 288.3K Total
  Previous Release:
    Non-Debug Version: 141.7K Code, 58.5K Data, 200.2K Total
    Debug Version:     207.5K Code, 82.7K Data, 290.2K Total


2) iASL Compiler/Disassembler and Tools:

iASL: Fixed a problem where an External() declaration could not refer to a =
Field Unit. Erik Schmauss.

Disassembler: Improved support for the Switch/Case operators. This feature =
will disassemble AML code back to the original Switch operators when possib=
le, instead of an If..Else sequence. David Box

iASL and disassembler: Improved the handling of multiple extraneous parenth=
eses for both ASL input and disassembled ASL output.

Improved the behavior of the iASL compiler and disassembler to detect impro=
per use of external declarations

Disassembler: Now aborts immediately upon detection of an unknown AML opcod=
e. The AML parser has no real way to recover from this, and can result in t=
he creation of an ill-formed parse tree that causes errors later during the=
 disassembly.

All tools: Fixed a problem where the Unix application OSL did not handle co=
ntrol-c correctly. For example, a control-c could incorrectly wake the debu=
gger.

AcpiExec: Improved the Control-C handling and added a handler for segmentat=
ion faults (SIGSEGV). Supports both Windows and Unix-like environments.

Reduced the verbosity of the generic unix makefiles. Previously, each compi=
lation displayed the full set of compiler options. This has been eliminated=
 as the options are easily inspected within the makefiles. Each compilation=
 now results in a single line of output.


--===============7638809000835036157==--

