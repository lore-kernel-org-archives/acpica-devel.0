Content-Type: multipart/mixed; boundary="===============2363154188720144356=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: [Devel] ACPICA support for reduced-hardware platforms
Date: Wed, 18 Dec 2013 00:56:23 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37C7BA18B@ORSMSX103.amr.corp.intel.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============2363154188720144356==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

There have been several questions that have come up concerning the ACPICA s=
upport for hardware reduced platforms. Here is an updated/clarified section=
 of the ACPICA reference manual that addresses this (hopefully completely.)

Please forward to any interested parties. The updated document will be rele=
ased to the public this week.

Bob


5.1.1	Reduced Hardware Platforms

Reduced hardware platforms are defined in ACPI 5.0 and refer to ACPI system=
s without the usual ACPI hardware. There are two ways in which the reduced =
hardware platforms are supported by ACPICA:

1) A runtime configuration feature that dynamically disables all ACPI hardw=
are access code whenever the HW_REDUCED_ACPI flag is found to be set in the=
 FADT.

2) A compile-time option to entirely remove the ACPI hardware support code =
from the ACPICA subsystem. This option is primarily intended for custom bui=
lds of host operating systems where the target platform is known to support=
 ACPI in the reduced hardware mode.

5.1.1.1	Runtime Reduced Hardware Support

This feature automatically supports reduced hardware platforms without any =
code changes. The reduced hardware support is dynamically enabled via the H=
W_REDUCED_ACPI flag in the revision 5 FADT. If this flag is set, ACPICA wil=
l not attempt to initialize or use any of the usual ACPI hardware. Note, wh=
en this flag is set, all of the following ACPI hardware is assumed to be no=
t present and is not initialized or accessed:

General Purpose Events (GPEs)
Fixed Events (PM1a/PM1b and PM Control)
Power Management Timer and Console Buttons (power/sleep)
Real-time Clock Alarm
Global Lock
System Control Interrupt (SCI)
The FACS is assumed to be non-existent

5.1.1.2	Compile-Time Reduced Hardware Support

This option is used during the build/compile of the ACPICA subystem. It dis=
ables the compilation of all code related to the hardware in the previous s=
ection. When the ACPI_REDUCED_HARDWARE option is specified during the build=
, all ACPI hardware-related code is omitted from the source code generation=
, resulting in a considerable savings of both code and data. The affected e=
xternal interfaces are stubbed, however, and will return a status value of =
AE_NOT_CONFIGURED. The affected external interfaces are shown below:

AcpiInstallSciHandler
AcpiRemoveSciHandler
AcpiInstallGlobalEventHandler
AcpiInstallFixedEventHandler
AcpiRemoveFixedEventHandler
AcpiInstallGpeHandler
AcpiRemoveGpeHandler
AcpiAcquireGlobalLock
AcpiReleaseGlobalLock
AcpiEnable
AcpiDisable
AcpiEnableEvent
AcpiDisableEvent
AcpiClearEvent
AcpiGetEventStatus
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
AcpiGetTimerResolution
AcpiGetTimer
AcpiGetTimerDuration
AcpiReadBitRegister
AcpiWriteBitRegister
AcpiSetFirmwareWakingVector
AcpiSetFirmwareWakingVector64
AcpiEnterSleepStateS4bios




> -----Original Message-----
> From: acpi-bounces(a)linux.intel.com [mailto:acpi-bounces(a)linux.intel.c=
om]
> On Behalf Of Zhao, Lijian
> Sent: Tuesday, December 17, 2013 4:42 PM
> To: Wysocki, Rafael J; Arjan van de Ven; Van De Ven, Arjan
> Cc: Sheng, Alan; 'acpi(a)linux.intel.com'; 'linux-power-
> mgmt(a)linux.intel.com'; Schlobohm, Bruce; Wang, Brett
> Subject: RE: [ACPI] Re: [Linux-power-mgmt] Linux Power US/China
> Engineering Meeting Minutes - 2013-12-16
> =

> Yes, the byt-t/32 platform is not actual hw-reduced platform. But the
> implementation in fw totally follow the 5.0 spec for HW-reduced mode and
> already PRQ. Now people are working on to gain the same level of quality
> on Android side with ACPI 5.0 and HW-reduced mode.
> =

> =

> The following statement for BYT-T.
> =

> > 	What we prototyped on Clovertrail:
> > 	All HW regs, including, ACPI GPIO support; FADT registers become
> > reserved,
>              ACPI 5.0 interface for GPIO/I2C/UART had been fully
> supported.
> > 	no FACS, and so no global lock;
> 	Correct.
> > 	no FADT reset
> 	Yes, EFI service will do the reset.
> > 	no fixed C-states
> 	We do have C-state and confirmed working.
> > 	no fixed events
> 	Yes.
> > 	no GPEs
> 	Yes.
> > 	no FADT-based S3/S3 entry - new DSDT sleep method required
> 	Yes, only s0i3 supported and which should not cost extra power than
> S3.
> > 	no PM-TIMER
> 	Yes
> > 	no PIC
> 	We do have PIC, but running in IOAPIC mode.
> > 	no HPET
> 	We do have HPET.
> > 	no PIT
> 	We do have PIT, seems no one is using that.
> >
> =

> Best regards,
> Lance
> =

> -----Original Message-----
> From: acpi-bounces(a)linux.intel.com [mailto:acpi-bounces(a)linux.intel.c=
om]
> On Behalf Of Wysocki, Rafael J
> Sent: Wednesday, December 18, 2013 12:28 AM
> To: Arjan van de Ven; Van De Ven, Arjan
> Cc: 'acpi(a)linux.intel.com'; 'linux-power-mgmt(a)linux.intel.com'; Schlo=
bohm,
> Bruce
> Subject: [ACPI] Re: [Linux-power-mgmt] Linux Power US/China Engineering
> Meeting Minutes - 2013-12-16
> =

> On 12/17/2013 5:14 PM, Arjan van de Ven wrote:
> > On 12/17/2013 7:51 AM, Rafael J. Wysocki wrote:
> >> On 12/17/2013 4:40 PM, Van De Ven, Arjan wrote:
> >>> All 64 bit tablets will not be reduced.
> >>
> >> That's a good news.
> >>
> >> It would be awesome if we could simply assume no HW-reduced x86, at
> >> least as far as the mainline is concerned.
> >>
> >>> Also byt-t/32 is not actually reduced... They just set the bit for
> >>> Windows compat.
> >>> I'm working with the Windows folks to get the need for that fixed.
> >>
> >> If the above assumption can be made, we may simply ignore the
> >> HW-reduced bit on x86, I suppose.
> >
> > people are booting linux on a HWred baytrail T today.
> > just google for "asus t100".... that's a baytrail T.
> >
> =

> I know this generally works today, but it may not work any more after the
> changes that the Linaro folks are proposing.
> =

> So if we can assume no HW-reduced x86, then we can ignore that bit on
> x86 entirely and allow the ARM people to do what they want for HW-reduced.
> Otherwise, we have to be very careful about changes related to HW-reduced,
> because they may break something for us inadvertently and it is quite
> difficult to say in advance what that may be.
> =

> I mean I have no good arguments as "this will break that on machine X"
> for rejecting changes being proposed, especially if "machine X" is not on
> the market yet (or it is on the market, but no one has tried to install
> Linux on it yet).
> =

> _______________________________________________
> acpi mailing list
> acpi(a)linux.intel.com
> http://linux.intel.com/mailman/listinfo/acpi
> _______________________________________________
> acpi mailing list
> acpi(a)linux.intel.com
> http://linux.intel.com/mailman/listinfo/acpi

--===============2363154188720144356==--

