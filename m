Content-Type: multipart/mixed; boundary="===============1585943324917436265=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: [Devel] ACPICA version 20111123 released with full ACPI 5.0 support
Date: Wed, 23 Nov 2011 16:49:56 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E316EE1BCC@ORSMSX101.amr.corp.intel.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============1585943324917436265==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

23 November 2011. Summary of changes for version 20111123:

This release is available at www.acpica.org/downloads
The ACPI 5.0 specification is available at www.acpi.info

0) ACPI 5.0 Support:

This release contains full support for the ACPI 5.0 specification, as summa=
rized below.

Reduced Hardware Support:
-------------------------

This support allows for ACPI systems without the usual ACPI hardware. This =
support is enabled by a flag in the revision 5 FADT. If it is set, ACPICA w=
ill not attempt to initialize or use any of the usual ACPI hardware. Note, =
when this flag is set, all of the following ACPI hardware is assumed to be =
not present and is not initialized or accessed:

    General Purpose Events (GPEs)
    Fixed Events (PM1a/PM1b and PM Control)
    Power Management Timer and Console Buttons (power/sleep)
    Real-time Clock Alarm
    Global Lock
    System Control Interrupt (SCI)
    The FACS is assumed to be non-existent

ACPI Tables:
------------

All new tables and updates to existing tables are fully supported in the AC=
PICA headers (for use by device drivers), the disassembler, and the iASL Da=
ta Table Compiler. ACPI 5.0 defines these new tables:

    BGRT        /* Boot Graphics Resource Table */
    DRTM        /* Dynamic Root of Trust for Measurement table */
    FPDT        /* Firmware Performance Data Table */
    GTDT        /* Generic Timer Description Table */
    MPST        /* Memory Power State Table */
    PCCT        /* Platform Communications Channel Table */
    PMTT        /* Platform Memory Topology Table */
    RASF        /* RAS Feature table */

Operation Regions/SpaceIDs:
---------------------------

All new operation regions are fully supported by the iASL compiler, the dis=
assembler, and the ACPICA runtime code (for dispatch to region handlers.) T=
he new operation region Space IDs are:

    GeneralPurposeIo
    GenericSerialBus

Resource Descriptors:
---------------------

All new ASL resource descriptors are fully supported by the iASL compiler, =
the ASL/AML disassembler, and the ACPICA runtime Resource Manager code (inc=
luding all new predefined resource tags). New descriptors are:

    FixedDma
    GpioIo
    GpioInt
    I2cSerialBus
    SpiSerialBus
    UartSerialBus

ASL/AML Operators, New and Modified:
------------------------------------

One new operator is added, the Connection operator, which is used to associ=
ate a GeneralPurposeIo or GenericSerialBus resource descriptor with individ=
ual field objects within an operation region. Several new protocols are ass=
ociated with the AccessAs operator. All are fully supported by the iASL com=
piler, disassembler, and runtime ACPICA AML interpreter:

    Connection                      // Declare Field Connection attributes
    AccessAs: AttribBytes (n)           // Read/Write N-Bytes Protocol
    AccessAs: AttribRawBytes (n)        // Raw Read/Write N-Bytes Protocol
    AccessAs: AttribRawProcessBytes (n) // Raw Process Call Protocol
    RawDataBuffer                       // Data type for Vendor Data fields

Predefined ASL/AML Objects:
---------------------------

All new predefined objects/control-methods are supported by the iASL compil=
er and the ACPICA runtime validation/repair (arguments and return values.) =
New predefined names include the following:

Standard Predefined Names (Objects or Control Methods):
    _AEI, _CLS, _CPC, _CWS, _DEP,
    _DLM, _EVT, _GCP, _CRT, _GWS,
    _HRV, _PRE, _PSE, _SRT, _SUB.

Resource Tags (Names used to access individual fields within resource descr=
iptors):
    _DBT, _DPL, _DRS, _END, _FLC,
    _IOR, _LIN, _MOD, _PAR, _PHA,
    _PIN, _PPI, _POL, _RXL, _SLV,
    _SPE, _STB, _TXL, _VEN.

ACPICA External Interfaces:
---------------------------

Several new interfaces have been defined for use by ACPI-related device dri=
vers and other host OS services:

AcpiAcquireMutex and AcpiReleaseMutex: These interfaces allow the host OS t=
o acquire and release AML mutexes that are defined in the DSDT/SSDT tables =
provided by the BIOS. They are intended to be used in conjunction with the =
ACPI 5.0 _DLM (Device Lock Method) in order to provide transaction-level mu=
tual exclusion with the AML code/interpreter.

AcpiGetEventResources: Returns the (formatted) resource descriptors as defi=
ned by the ACPI 5.0 _AEI object (ACPI Event Information).  This object prov=
ides resource descriptors associated with hardware-reduced platform events,=
 similar to the AcpiGetCurrentResources interface.

Operation Region Handlers: For General Purpose IO and Generic Serial Bus op=
eration regions, information about the Connection() object and any optional=
 length information is passed to the region handler within the Context para=
meter.

AcpiBufferToResource: This interface converts a raw AML buffer containing a=
 resource template or resource descriptor to the ACPI_RESOURCE internal for=
mat suitable for use by device drivers. Can be used by an operation region =
handler to convert the Connection() buffer object into a ACPI_RESOURCE.

Miscellaneous/Tools/TestSuites: =

-------------------------------

Support for extended _HID names (Four alpha characters instead of three).
Support for ACPI 5.0 features in the AcpiExec and AcpiHelp utilities.
Support for ACPI 5.0 features in the ASLTS test suite.
Fully updated documentation (ACPICA and iASL reference documents.)

ACPI Table Definition Language:
-------------------------------

Support for this language was implemented and released as a subsystem of th=
e iASL compiler in 2010. (See the iASL compiler User Guide.)


Non-ACPI 5.0 changes for this release:
--------------------------------------

1) ACPICA Core Subsystem:

Fix a problem with operation region declarations where a failure can occur =
if the region name and an argument that evaluates to an object (such as the=
 region address) are in different namespace scopes. Lin Ming, ACPICA BZ 937.

Do not abort an ACPI table load if an invalid space ID is found within. Thi=
s will be caught later if the offending method is executed. ACPICA BZ 925.

Fixed an issue with the FFixedHW space ID where the ID was not always recog=
nized properly (Both ACPICA and iASL). ACPICA BZ 926.

Fixed a problem with the 32-bit generation of the unix-specific OSL (osunix=
xf.c). Lin Ming, ACPICA BZ 936.

Several changes made to enable generation with the GCC 4.6 compiler. ACPICA=
 BZ 935.

New error messages: Unsupported I/O requests (not 8/16/32 bit), and Index/B=
ank field registers out-of-range.

2) iASL Compiler/Disassembler and Tools:

iASL: Implemented the __PATH__ operator, which returns the full pathname of=
 the current source file.

AcpiHelp: Automatically display expanded keyword information for all ASL op=
erators.

Debugger: Add "Template" command to disassemble/dump resource template buff=
ers.

Added a new master script to generate and execute the ASLTS test suite. Aut=
omatically handles 32- and 64-bit generation. See tests/aslts.sh

iASL: Fix problem with listing generation during processing of the Switch()=
 operator where AML listing was disabled until the entire Switch block was =
completed.

iASL: Improve support for semicolon statement terminators. Fix "invalid cha=
racter" message for some cases when the semicolon is used. Semicolons are n=
ow allowed after every <Term> grammar element. ACPICA BZ 927.

iASL: Fixed some possible aliasing warnings during generation. ACPICA BZ 92=
3.

Disassembler: Fix problem with disassembly of the DataTableRegion operator =
where an inadvertent "Unhandled deferred opcode" message could be generated.

3) Example Code and Data Size

These are the sizes for the OS-independent acpica.lib produced by the Micro=
soft Visual C++ 9.0 32-bit compiler. The debug version of the code includes=
 the debug output trace mechanism and has a much larger code and data size.

  Previous Release:
    Non-Debug Version:  90.2K Code, 23.9K Data, 114.1K Total
    Debug Version:     165.6K Code, 68.4K Data, 234.0K Total
  Current Release:
    Non-Debug Version:  92.3K Code, 24.9K Data, 117.2K Total
    Debug Version:     170.8K Code, 72.6K Data, 243.4K Total



--===============1585943324917436265==--

