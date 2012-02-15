Content-Type: multipart/mixed; boundary="===============6732385895274122520=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: [Devel] ACPICA version 20120215 released
Date: Wed, 15 Feb 2012 18:31:20 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E33754F154@ORSMSX101.amr.corp.intel.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============6732385895274122520==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

15 February 2012. Summary of changes for version 20120215:

This release is available at www.acpica.org/downloads.
The ACPI 5.0 specification is available at www.acpi.info.

1) ACPICA Core Subsystem:

There have been some major changes to the sleep/wake support code, as descr=
ibed below (a - e).

a) The AcpiLeaveSleepState has been split into two interfaces, similar to A=
cpiEnterSleepStatePrep and AcpiEnterSleepState. The new interface is AcpiLe=
aveSleepStatePrep. This allows the host to perform actions between the time=
 the _BFS method is called and the _WAK method is called. NOTE: all hosts m=
ust update their wake/resume code or else sleep/wake will not work properly=
. Rafael Wysocki.

b) In AcpiLeaveSleepState, now enable all runtime GPEs before calling the _=
WAK method. Some machines require that the GPEs are enabled before the _WAK=
 method is executed. Thomas Renninger.

c) In AcpiLeaveSleepState, now always clear the WAK_STS (wake status) bit. =
Some BIOS code assumes that WAK_STS will be cleared on resume and use it to=
 determine whether the system is rebooting or resuming. Matthew Garrett.

d) Move the invocations of _GTS (Going To Sleep) and _BFS (Back From Sleep)=
 to match the ACPI specification requirement. Rafael Wysocki.

e) Implemented full support for the ACPI 5.0 SleepStatus and SleepControl r=
egisters within the V5 FADT. This support adds two new files: hardware/hwes=
leep.c implements the support for the new registers. Moved all sleep/wake e=
xternal interfaces to hardware/hwxfsleep.c.


Added a new OSL interface for ACPI table overrides, AcpiOsPhysicalTableOver=
ride. This interface allows the host to override a table via a physical add=
ress, instead of the logical address required by AcpiOsTableOverride. This =
simplifies the host implementation. Initial implementation by Thomas Rennin=
ger. The ACPICA implementation creates a single shared function for table o=
verrides that attempts both a logical and a physical override.

Expanded the OSL memory read/write interfaces to 64-bit data (AcpiOsReadMem=
ory, AcpiOsWriteMemory.) This enables full 64-bit memory transfer support f=
or GAS register structures passed to AcpiRead and AcpiWrite.

Implemented the ACPI_REDUCED_HARDWARE option to allow the creation of a cus=
tom build of ACPICA that supports only the ACPI 5.0 reduced hardware (SoC) =
model. See the ACPICA reference for details. See section (3) below for a li=
st of external interfaces that are configured out. ACPICA BZ 942. This opti=
on removes about 10% of the code and 5% of the static data, and the followi=
ng hardware ACPI features become unavailable:
    PM Event and Control registers
    SCI interrupt (and handler)
    Fixed Events
    General Purpose Events (GPEs)
    Global Lock
    ACPI PM timer
    FACS table (Waking vectors and Global Lock)

Updated the unix tarball directory structure to match the ACPICA git source=
 tree. This ensures that the generic unix makefiles work properly (in gener=
ate/unix).  Also updated the Linux makefiles to match. ACPICA BZ 867.

Updated the return value of the _REV predefined method to integer value 5 t=
o reflect ACPI 5.0 support.

Moved the external ACPI PM timer interface prototypes to the public acpixf.=
h file where they belong.

Example Code and Data Size: These are the sizes for the OS-independent acpi=
ca.lib produced by the Microsoft Visual C++ 9.0 32-bit compiler. The debug =
version of the code includes the debug output trace mechanism and has a muc=
h larger code and data size.

  Previous Release:
    Non-Debug Version:  92.8K Code, 24.9K Data, 117.7K Total
    Debug Version:     171.7K Code, 72.9K Data, 244.5K Total
  Current Release:
    Non-Debug Version:  93.0K Code, 25.0K Data, 118.0K Total
    Debug Version:     172.5K Code, 73.2K Data, 245.7K Total


2) iASL Compiler/Disassembler and Tools:

Disassembler: Fixed a problem with the new ACPI 5.0 serial resource descrip=
tors (I2C, SPI, UART) where the resource produce/consumer bit was incorrect=
ly displayed.

AcpiHelp: Add display of ACPI/PNP device IDs that are defined in the ACPI s=
pecification.


3) External ACPICA interfaces that are removed by ACPI_REDUCED_HARDWARE opt=
ion.
They remain defined, but return the AE_NOT_CONFIGURED status:

Handlers
	AcpiInstallGlobalEventHandler
	AcpiInstallFixedEventHandler
	AcpiRemoveFixedEventHandler
	AcpiInstallGpeHandler
	AcpiRemoveGpeHandler

Global Lock
	AcpiAcquireGlobalLock
	AcpiReleaseGlobalLock

Fixed Events
	AcpiEnable
	AcpiDisable
	AcpiEnableEvent
	AcpiDisableEvent
	AcpiClearEvent
	AcpiGetEventStatus

General Purpose Events (GPEs)
	AcpiUpdateAllGpes
	AcpiEnableGpe
	AcpiDisableGpe
	AcpiSetGpe
	AcpiSetupGpeForWake
	AcpiSetGpeWakeMask
	AcpiClearGpe
	AcpiGetGpeStatus
	AcpiFinishGpe
	AcpiDisableAllGpes
	AcpiEnableAllRuntimeGpes
	AcpiInstallGpeBlock
	AcpiRemoveGpeBlock
	AcpiGetGpeDevice

PM Timer
	AcpiGetTimerResolution
	AcpiGetTimer
	AcpiGetTimerDuration

ACPI Registers
	AcpiReadBitRegister
	AcpiWriteBitRegister

Sleep/Wake
	AcpiSetFirmwareWakingVector
	AcpiSetFirmwareWakingVector64
	AcpiEnterSleepStateS4bios


--===============6732385895274122520==--

