Content-Type: multipart/mixed; boundary="===============2982061126617310527=="
MIME-Version: 1.0
From: Devin Steffler <devinsteffler at gmail.com>
Subject: Re: [Devel] Help needed for "ACPI Error: No handler for Region
 [ECOR]" (using my own OSL)
Date: Thu, 25 May 2017 16:42:02 -0400
Message-ID: <CAAuRk_gutpzw+ZsSA4GZw+ceGE53YYLS-LUHoK0+aTq5Jtq8Vw@mail.gmail.com>
In-Reply-To: 94F2FBAB4432B54E8AACC7DFDE6C92E37E59B64B@ORSMSX110.amr.corp.intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============2982061126617310527==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

I agree with you. It should be supported by QNX but I don't think that it
is supported "out of the box". I searched their website/forums and couldn't
find anything related to this. I will ask around here and see if I can get
a formal QNX support contact to find out for certain (but I was told not to
hold my breath when contacting QNX for support).

As far as I can tell, QNX only has "barebones" support for ACPI, i.e. only
what is needed to get a system to boot.

I saw that the ACPICA already has code for QNX and found that it was added
by Will Miles:
https://github.com/acpica/acpica/commit/37a1dec2

I'll try emailing Will to see if he can shed some light on this. If he had
to write his own OSL for QNX then I suspect that he would not be able to
share it (as it's likely owned by his company).

If the EC driver that I need is the same as this one for Linux, then I
should be able to write one myself for QNX:
http://elixir.free-electrons.com/linux/latest/source/drivers/acpi/ec.c

However, at this time I'm not sure how I would inform ACPICA to use my
custom QNX EC driver. How would I go about registering the driver with
ACPICA so that it knows what functions to call? I don't see anything in the
ACPICA User Guide and Programmer Reference for this. The only Acpi* methods
from the ACPICA with "register" in them are AcpiReadBitRegister and
AcpiWriteBitRegister. Should there be something for registering a driver
for an operation region?

Thanks again,
Devin






On Thu, May 25, 2017 at 3:47 PM, Moore, Robert <robert.moore(a)intel.com>
wrote:

> I just looked into the ACPICA source, and yes, it appears that QNX uses
> ACPICA:
>
>
>
> #ifndef __ACQNX_H__
>
> #define __ACQNX_H__
>
>
>
> #define ACPI_USE_STANDARD_HEADERS
>
> #define ACPI_USE_SYSTEM_CLIBRARY
>
>
>
> #define ACPI_UINTPTR_T          uintptr_t
>
> #define ACPI_USE_LOCAL_CACHE
>
> #define ACPI_CAST_PTHREAD_T(x)  ((ACPI_THREAD_ID) ACPI_TO_INTEGER (x))
>
>
>
> /* At present time (QNX 6.6) all supported architectures are 32 bits. */
>
> #define ACPI_MACHINE_WIDTH      32
>
>
>
> Which means that the ACPICA-to-QNX OSL interface layer already exists.
>
>
>
> *From:* Devel [mailto:devel-bounces(a)acpica.org] *On Behalf Of *Moore,
> Robert
> *Sent:* Thursday, May 25, 2017 12:41 PM
> *To:* Devin Steffler <devinsteffler(a)gmail.com>
>
> *Cc:* devel(a)acpica.org
> *Subject:* Re: [Devel] Help needed for "ACPI Error: No handler for Region
> [ECOR]" (using my own OSL)
>
>
>
> I can=E2=80=99t speak for QNX, but the EC driver would be part of it. It =
has
> nothing to do with your OSL.
>
>
>
> I=E2=80=99m not sure why you have to write your own OSL, this should alre=
ady be
> part of QNX, assuming that it has ACPI support, and uses ACPICA as the
> underlying ACPI software.
>
>
>
> To put this more succinctly:  ACPICA provides the underlying
> infrastructure for ACPI support in an OS. But, the OS must provide its own
> ACPI-related drivers and other ACPI support. The EC driver is one of these
> ACPI-related drivers.
>
>
>
> Bob
>
>
>
>
>
> *From:* Devin Steffler [mailto:devinsteffler(a)gmail.com
> <devinsteffler(a)gmail.com>]
> *Sent:* Thursday, May 25, 2017 7:48 AM
> *To:* Moore, Robert <robert.moore(a)intel.com>
> *Cc:* devel(a)acpica.org
> *Subject:* Re: [Devel] Help needed for "ACPI Error: No handler for Region
> [ECOR]" (using my own OSL)
>
>
>
> Hi Robert,
>
>
>
> Thanks for your insight.
>
>
>
> How can I find out whether is it a missing EC driver or the EC driver
> is failing to install a handler for the EC operation region?
>
>
>
> Is the EC driver some C code that I would be expected to write as part of
> the OSL or is it expected to be included with the OS (QNX in this case)?
>
>
>
> I suspect that the problem is somewhere in my OSL (since I'm very new to
> ACPI). Do you think this is likely the case? What should I focus on to
> debug my OSL if this is the case?
>
>
>
> Here's an excerpt from the Lenovo's DSDT.dsl (hoping it helps):
>
> ------------------------------------------------------------
> -----------------------------------
>
>                 Device (EC)
>                 {
>                     Name (_HID, EisaId ("PNP0C09") /* Embedded Controller
> Device */)  // _HID: Hardware ID
>                     Name (_UID, 0x00)  // _UID: Unique ID
>                     Name (_GPE, 0x20)  // _GPE: General Purpose Events
>                     Method (_REG, 2, NotSerialized)  // _REG: Region
> Availability
>                     {
>                         If ((Arg0 =3D=3D 0x03))
>                         {
>                             \H8DR =3D Arg1
>                         }
>                     }
>
>                     OperationRegion (ECOR, EmbeddedControl, 0x00, 0x0100)
>                     Field (ECOR, ByteAcc, NoLock, Preserve)
>                     {
>                         HDBM,   1,
>                             ,   1,
>                         HKLK,   1,
>                         HFNE,   1,
>                             ,   1,
>                             ,   1,
>                         HLDM,   1,
>                         Offset (0x01),
>                         BBLS,   1,
>                         BTCM,   1,
>                             ,   1,
>                             ,   1,
>                             ,   1,
>                         HBPR,   1,
>                         BTPC,   1,
>                         Offset (0x02),
>                         HDUE,   1,
>                             ,   4,
>                         SNLK,   1,
>                         Offset (0x03),
>                             ,   5,
>                         HAUM,   2,
>                         Offset (0x05),
>                         HSPA,   1,
>                         Offset (0x06),
>                         HSUN,   8,
>                         HSRP,   8,
>                         Offset (0x09),
>                             ,   6,
>                         FNKS,   1,
>                         Offset (0x0C),
>                         HLCL,   8,
>                             ,   4,
>                         CALM,   1,
>                         Offset (0x0E),
>                         HFNS,   2,
>                         Offset (0x0F),
>                             ,   6,
>                         NULS,   1,
>                         Offset (0x10),
>                         HAM0,   8,
>                         HAM1,   8,
>                         HAM2,   8,
>                         HAM3,   8,
>                         HAM4,   8,
>                         HAM5,   8,
>                         HAM6,   8,
>                         HAM7,   8,
>                         HAM8,   8,
>                         HAM9,   8,
>                         HAMA,   8,
>                         HAMB,   8,
>                         HAMC,   8,
>                         HAMD,   8,
>                         HAME,   8,
>                         HAMF,   8,
>                         Offset (0x23),
>                         HANT,   8,
>                         Offset (0x26),
>                             ,   2,
>                         HANA,   2,
>                         Offset (0x27),
>                         Offset (0x28),
>                             ,   1,
>                         SKEM,   1,
>                         Offset (0x29),
>                         Offset (0x2A),
>                         HATR,   8,
>                         HT0H,   8,
>                         HT0L,   8,
>                         HT1H,   8,
>                         HT1L,   8,
>                         HFSP,   8,
>                             ,   6,
>                         HMUT,   1,
>                         Offset (0x31),
>                             ,   2,
>                         HUWB,   1,
>                             ,   3,
>                         VPON,   1,
>                         VRST,   1,
>                         HWPM,   1,
>                         HWLB,   1,
>                         HWLO,   1,
>                         HWDK,   1,
>                         HWFN,   1,
>                         HWBT,   1,
>                         HWRI,   1,
>                         HWBU,   1,
>                         HWLU,   1,
>                         Offset (0x34),
>                             ,   3,
>                         PIBS,   1,
>                             ,   3,
>                         HPLO,   1,
>                         Offset (0x36),
>                         HWAC,   16,
>                         HB0S,   7,
>                         HB0A,   1,
>                         HB1S,   7,
>                         HB1A,   1,
>                         HCMU,   1,
>                             ,   2,
>                         OVRQ,   1,
>                         DCBD,   1,
>                         DCWL,   1,
>                         DCWW,   1,
>                         HB1I,   1,
>                             ,   1,
>                         KBLT,   1,
>                         BTPW,   1,
>                         FNKC,   1,
>                         HUBS,   1,
>                         BDPW,   1,
>                         BDDT,   1,
>                         HUBB,   1,
>                         Offset (0x46),
>                             ,   1,
>                         BTWK,   1,
>                         HPLD,   1,
>                             ,   1,
>                         HPAC,   1,
>                         BTST,   1,
>                         Offset (0x47),
>                         HPBU,   1,
>                             ,   1,
>                         HBID,   1,
>                             ,   3,
>                         HBCS,   1,
>                         HPNF,   1,
>                             ,   1,
>                         GSTS,   1,
>                             ,   2,
>                         HLBU,   1,
>                         DOCD,   1,
>                         HCBL,   1,
>                         Offset (0x49),
>                         SLUL,   1,
>                         Offset (0x4C),
>                         HTMH,   8,
>                         HTML,   8,
>                         HWAK,   16,
>                         HMPR,   8,
>                             ,   7,
>                         HMDN,   1,
>                         Offset (0x78),
>                         TMP0,   8,
>                         Offset (0x80),
>                         Offset (0x81),
>                         HIID,   8,
>                         Offset (0x83),
>                         HFNI,   8,
>                         HSPD,   16,
>                         Offset (0x88),
>                         TSL0,   7,
>                         TSR0,   1,
>                         TSL1,   7,
>                         TSR1,   1,
>                         TSL2,   7,
>                         TSR2,   1,
>                         TSL3,   7,
>                         TSR3,   1,
>                         Offset (0x8D),
>                         HDAA,   3,
>                         HDAB,   3,
>                         HDAC,   2,
>                         RCBD,   1,
>                         RCWL,   1,
>                         RCWW,   1,
>                         Offset (0xB0),
>                         HDEN,   32,
>                         HDEP,   32,
>                         HDEM,   8,
>                         HDES,   8,
>                         Offset (0xC8),
>                         ATMX,   8,
>                         HWAT,   8,
>                         Offset (0xCC),
>                         PWMH,   8,
>                         PWML,   8,
>                         Offset (0xED),
>                             ,   4,
>                         HDDD,   1
>                     }
>
> ------------------------------------------------------------
> -----------------------------------
>
>
>
> Many thanks,
> Devin
>
>
>
>
>
> On Thu, May 25, 2017 at 10:15 AM, Moore, Robert <robert.moore(a)intel.com>
> wrote:
>
> ACPI Error: Region EmbeddedControl (ID=3D3) has no handler
> (20170303/exfldio-431)
>
>
>
> You either don=E2=80=99t have a driver for the EC, or your EC driver has =
not
> installed a handler for the EC operation region.
>
>
>
> I would guess.
>
>
>
>
>
>
>
>
>
> *From:* Devel [mailto:devel-bounces(a)acpica.org] *On Behalf Of *Devin
> Steffler
> *Sent:* Thursday, May 25, 2017 6:15 AM
> *To:* devel(a)acpica.org
> *Subject:* [Devel] Help needed for "ACPI Error: No handler for Region
> [ECOR]" (using my own OSL)
>
>
>
> Hello,
>
>
>
> I am working on an OSL for QNX. I am getting some errors printed out
> during AcpiInitializeObjects but only in one out of three laptops that I =
am
> testing. A Dell and ASUS laptop do not have the errors but a Lenovo laptop
> does. I am able to read battery status (_BST) on the Dell and ASUS laptops
> but not on the Lenovo laptop.
>
>
>
> The ACPICA version I am using is 20170303.
>
>
>
> Some questions I have are:
>
> - Is this the correct mailing list for this email?
>
> - Does this appear to be a bug in ACPICA, in my OSL, or somewhere else
> (maybe the laptop BIOS)?
>
> - Should I raise a bug for this?
>
> - Would you provide any recommendations to help me troubleshoot this?
>
> - What other information should I provide?
>
>
>
> This is the output during ACPI initialization on the problematic laptop
> (from my OSL):
>
> ------------------------------------------------------------
> ------------------------------------
>
> ACPI: RSDP 0x00000000000F0120 000024 (v02 LENOVO)
>
> ACPI: XSDT 0x00000000D7FD2188 0000CC (v01 LENOVO TP-R00   00000000 PTEC
> 00000002)
>
> ACPI: FACP 0x00000000D7FF7000 0000F4 (v05 LENOVO TP-R00   00000420 PTEC
> 00000002)
>
> ACPI: DSDT 0x00000000D7FDE000 011451 (v02 LENOVO TP-R00   00000420 INTL
> 20141107)
>
> ACPI: FACS 0x00000000D7FA2000 000040
>
> ACPI: UEFI 0x00000000D7FB9000 000042 (v01 LENOVO TP-R00   00000420 PTEC
> 00000002)
>
> ACPI: SSDT 0x00000000D7FF8000 004E0A (v02 LENOVO SaSsdt   00003000 INTL
> 20141107)
>
> ACPI: ASF! 0x00000000D7FF6000 0000A5 (v32 LENOVO TP-R00   00000420 PTEC
> 00000002)
>
> ACPI: ECDT 0x00000000D7FF5000 000052 (v01 LENOVO TP-R00   00000420 PTEC
> 00000002)
>
> ACPI: HPET 0x00000000D7FF4000 000038 (v01 LENOVO TP-R00   00000420 PTEC
> 00000002)
>
> ACPI: LPIT 0x00000000D7FF3000 000094 (v01 LENOVO TP-R00   00000420 PTEC
> 00000002)
>
> ACPI: APIC 0x00000000D7FF2000 0000BC (v03 LENOVO TP-R00   00000420 PTEC
> 00000002)
>
> ACPI: MCFG 0x00000000D7FF1000 00003C (v01 LENOVO TP-R00   00000420 PTEC
> 00000002)
>
> ACPI: WDAT 0x00000000D7FF0000 000134 (v01 LENOVO TP-R00   00000420 PTEC
> 00000002)
>
> ACPI: SSDT 0x00000000D7FDC000 001AFC (v01 LENOVO SataAhci 00001000 INTL
> 20141107)
>
> ACPI: DBGP 0x00000000D7FDB000 000034 (v01 LENOVO TP-R00   00000420 PTEC
> 00000002)
>
> ACPI: DBG2 0x00000000D7FDA000 000054 (v00 LENOVO TP-R00   00000420 PTEC
> 00000002)
>
> ACPI: BOOT 0x00000000D7FD9000 000028 (v01 LENOVO TP-R00   00000420 PTEC
> 00000002)
>
> ACPI: BATB 0x00000000D7FD8000 000046 (v01 LENOVO TP-R00   00000420 PTEC
> 00000002)
>
> ACPI: SLIC 0x00000000D7FD7000 000176 (v01 LENOVO TP-R00   00000420 PTEC
> 00000002)
>
> ACPI: SSDT 0x00000000D7FD6000 000E58 (v02 LENOVO CpuSsdt  00003000 INTL
> 20141107)
>
> ACPI: SSDT 0x00000000D7FD5000 0003D9 (v02 LENOVO CtdpB    00001000 INTL
> 20141107)
>
> ACPI: MSDM 0x00000000D7FD4000 000055 (v03 LENOVO TP-R00   00000420 PTEC
> 00000002)
>
> ACPI: FPDT 0x00000000D7FD3000 000044 (v01 LENOVO TP-R00   00000420 PTEC
> 00000002)
>
> ACPI: UEFI 0x00000000D7FA0000 00012A (v01 LENOVO TP-R00   00000420 PTEC
> 00000002)
>
>
>
> Initializing Namespace objects:
>
> Table [DSDT: TP-R00  ] (id 01) - 2757 Objects with  76 Devices,  40
> Regions,  510 Methods (140/370/24 Serial/Non/Cvt)
>
> Table [SSDT: SaSsdt  ] (id 02) -  552 Objects with  18 Devices,  20
> Regions,  131 Methods (41/90/7 Serial/Non/Cvt)
>
> Table [SSDT: SataAhci] (id 03) -  183 Objects with   8 Devices,   0
> Regions,   34 Methods (25/9/5 Serial/Non/Cvt)
>
> Table [SSDT: CpuSsdt ] (id 04) -  114 Objects with   0 Devices,   3
> Regions,   29 Methods (13/16/13 Serial/Non/Cvt)
>
> Table [SSDT: CtdpB   ] (id 05) -   33 Objects with   0 Devices,   1
> Regions,    5 Methods (2/3/1 Serial/Non/Cvt)
>
> ACPI: 5 ACPI AML tables successfully acquired and loaded
>
> Completing Region/Field/Buffer/Package initialization:
>
>     Initialized 63/64 Regions 71/71 Fields 88/88 Buffers 83/83 Packages
> (3648 nodes)
>
>  evxfevnt-0218 Enable                : Transition to ACPI mode successful
>
> Initializing General Purpose Events (GPEs):
>
>     Initialized GPE 00 to 7F [_GPE] 16 regs on interrupt 0x9 (SCI)
>
> Initializing Device/Processor/Thermal objects and executing _INI/_STA
> methods:
>
> ACPI Error: No handler for Region [ECOR] (80da130) [EmbeddedControl]
> (20170303/evregion-291)
>
> ACPI Error: Region EmbeddedControl (ID=3D3) has no handler
> (20170303/exfldio-431)
>
> ACPI Error: Method parse/execution failed [\_SB.PCI0.LPC.EC.AC._PSR] (Node
> 80d0c30), AE_NOT_EXIST (20170303/psparse-668)
>
> ACPI Error: Method parse/execution failed [\_SB._INI] (Node 80e4f50),
> AE_NOT_EXIST (20170303/psparse-668)
>
> ACPI Error: No handler for Region [ECOR] (80da130) [EmbeddedControl]
> (20170303/evregion-291)
>
> ACPI Error: Region EmbeddedControl (ID=3D3) has no handler
> (20170303/exfldio-431)
>
> ACPI Error: Method parse/execution failed [\_SB.PCI0.LPC.EC._INI] (Node
> 80d00d0), AE_NOT_EXIST (20170303/psparse-668)
>
> ACPI Exception: AE_NOT_EXIST, during \_SB.PCI0.LPC.EC._INI execution
> (20170303/nsinit-807)
>
>     Executed 13 _INI methods requiring 1 _STA executions (examined 113
> objects)
>
> ------------------------------------------------------------
> ------------------------------------
>
>
>
> This is the output from calling AcpiEvaluateObject for the control method
> "\_SB.PCI0.LPC.EC.BAT0._BST", which returns with AE_NOT_EXIST:
>
> ------------------------------------------------------------
> ------------------------------------
>
> ACPI Error: No handler for Region [ECOR] (80da130) [EmbeddedControl]
> (20170303/evregion-291)
>
> ACPI Error: Region EmbeddedControl (ID=3D3) has no handler
> (20170303/exfldio-431)
>
> ACPI Error: Method parse/execution failed [\_SB.PCI0.LPC.EC.BAT0._BST]
> (Node 80d0b70), AE_NOT_EXIST (20170303/psparse-668)
>
> ------------------------------------------------------------
> ------------------------------------
>
>
>
> This is the output from executing the control method using acpiexec:
>
> ------------------------------------------------------------
> ------------------------------------
>
> # ./acpiexec *.dat
>
>
>
>
>
> Intel ACPI Component Architecture
>
> AML Execution/Debug Utility version 20170303
>
> Copyright (c) 2000 - 2017 Intel Corporation
>
>
>
> Input file apic.dat, Length 0xBC (188) bytes
>
> Input file asf!.dat, Length 0xA5 (165) bytes
>
> Input file batb.dat, Length 0x46 (70) bytes
>
> Input file boot.dat, Length 0x28 (40) bytes
>
> Input file dbg2.dat, Length 0x54 (84) bytes
>
> Input file dbgp.dat, Length 0x34 (52) bytes
>
> Input file dsdt.dat, Length 0x11451 (70737) bytes
>
> Input file ecdt.dat, Length 0x52 (82) bytes
>
> Input file facp.dat, Length 0xF4 (244) bytes
>
> Input file facs.dat, Length 0x40 (64) bytes
>
> Input file fpdt.dat, Length 0x44 (68) bytes
>
> Input file hpet.dat, Length 0x38 (56) bytes
>
> Input file lpit.dat, Length 0x94 (148) bytes
>
> Input file mcfg.dat, Length 0x3C (60) bytes
>
> Input file msdm.dat, Length 0x55 (85) bytes
>
> Input file slic.dat, Length 0x176 (374) bytes
>
> Input file ssdt1.dat, Length 0x4E0A (19978) bytes
>
> Input file ssdt2.dat, Length 0x1AFC (6908) bytes
>
> Input file ssdt3.dat, Length 0xE58 (3672) bytes
>
> Input file ssdt4.dat, Length 0x3D9 (985) bytes
>
> Input file uefi1.dat, Length 0x42 (66) bytes
>
> Input file uefi2.dat, Length 0x12A (298) bytes
>
> Input file wdat.dat, Length 0x134 (308) bytes
>
> Input file xsdt.dat, Length 0xCC (204) bytes
>
>
>
> ACPI: RSDP 0x00000000080DBCE0 000024 (v02 Intel )
>
> ACPI: XSDT 0x00000000080E78C8 0000E4 (v00 Intel  AcpiExec 00001001 INTL
> 20170303)
>
> ACPI: FACP 0x00000000080EA550 0000F4 (v05 LENOVO TP-R00   00000420 PTEC
> 00000002)
>
> ACPI: DSDT 0x00000000080EF020 011451 (v02 LENOVO TP-R00   00000420 INTL
> 20141107)
>
> ACPI: FACS 0x00000000080DBD20 000040
>
> ACPI: APIC 0x00000000080EA708 0000BC (v03 LENOVO TP-R00   00000420 PTEC
> 00000002)
>
> ACPI: ASF! 0x00000000080EA650 0000A5 (v32 LENOVO TP-R00   00000420 PTEC
> 00000002)
>
> ACPI: BATB 0x00000000080E30A8 000046 (v01 LENOVO TP-R00   00000420 PTEC
> 00000002)
>
> ACPI: BOOT 0x00000000080E01D8 000028 (v01 LENOVO TP-R00   00000420 PTEC
> 00000002)
>
> ACPI: DBG2 0x00000000080E21F0 000054 (v00 LENOVO TP-R00   00000420 PTEC
> 00000002)
>
> ACPI: DBGP 0x00000000080E12D8 000034 (v01 LENOVO TP-R00   00000420 PTEC
> 00000002)
>
> ACPI: ECDT 0x00000000080E2258 000052 (v01 LENOVO TP-R00   00000420 PTEC
> 00000002)
>
> ACPI: FACS 0x00000000080E1320 000040
>
> ACPI: FPDT 0x00000000080E3100 000044 (v01 LENOVO TP-R00   00000420 PTEC
> 00000002)
>
> ACPI: HPET 0x00000000080E1368 000038 (v01 LENOVO TP-R00   00000420 PTEC
> 00000002)
>
> ACPI: LPIT 0x00000000080EA4B0 000094 (v01 LENOVO TP-R00   00000420 PTEC
> 00000002)
>
> ACPI: MCFG 0x00000000080E13B0 00003C (v01 LENOVO TP-R00   00000420 PTEC
> 00000002)
>
> ACPI: MSDM 0x00000000080E22C0 000055 (v03 LENOVO TP-R00   00000420 PTEC
> 00000002)
>
> ACPI: SLIC 0x00000000080EA328 000176 (v01 LENOVO TP-R00   00000420 PTEC
> 00000002)
>
> ACPI: SSDT 0x0000000008101020 004E0A (v02 LENOVO SaSsdt   00003000 INTL
> 20141107)
>
> ACPI: SSDT 0x00000000080E8820 001AFC (v01 LENOVO SataAhci 00001000 INTL
> 20141107)
>
> ACPI: SSDT 0x00000000080E79B8 000E58 (v02 LENOVO CpuSsdt  00003000 INTL
> 20141107)
>
> ACPI: SSDT 0x00000000080EA7D0 0003D9 (v02 LENOVO CtdpB    00001000 INTL
> 20141107)
>
> ACPI: UEFI 0x00000000080E3158 000042 (v01 LENOVO TP-R00   00000420 PTEC
> 00000002)
>
> ACPI: UEFI 0x00000000080E7470 00012A (v01 LENOVO TP-R00   00000420 PTEC
> 00000002)
>
> ACPI: WDAT 0x00000000080E7330 000134 (v01 LENOVO TP-R00   00000420 PTEC
> 00000002)
>
> ACPI: XSDT 0x00000000080E7230 0000CC (v01 LENOVO TP-R00   00000000 PTEC
> 00000002)
>
> Initializing General Purpose Events (GPEs):
>
>     Initialized GPE 00 to 7F [_GPE] 16 regs on interrupt 0x9 (SCI)
>
>
>
> Initializing Namespace objects:
>
> Table [DSDT: TP-R00  ] (id 01) - 2757 Objects with  76 Devices,  40
> Regions,  510 Methods (140/370/24 Serial/Non/Cvt)
>
> Table [SSDT: SaSsdt  ] (id 02) -  552 Objects with  18 Devices,  20
> Regions,  131 Methods (41/90/7 Serial/Non/Cvt)
>
> Table [SSDT: SataAhci] (id 03) -  183 Objects with   8 Devices,   0
> Regions,   34 Methods (25/9/5 Serial/Non/Cvt)
>
> Table [SSDT: CpuSsdt ] (id 04) -  114 Objects with   0 Devices,   3
> Regions,   29 Methods (13/16/13 Serial/Non/Cvt)
>
> Table [SSDT: CtdpB   ] (id 05) -   33 Objects with   0 Devices,   1
> Regions,    5 Methods (2/3/1 Serial/Non/Cvt)
>
> ACPI: 5 ACPI AML tables successfully acquired and loaded
>
>
>
> Completing Region/Field/Buffer/Package initialization:
>
>     Initialized 63/64 Regions 71/71 Fields 88/88 Buffers 83/83 Packages
> (3648 nodes)
>
> Initializing Device/Processor/Thermal objects and executing _INI/_STA
> methods:
>
> [AcpiExec] Exception AE_AML_INFINITE_LOOP during execution of method
> [SMI_] Opcode [While] @44
>
> [SMI_] @00034 #00A2:  While (
>
> No Local Variables are initialized for method [SMI_]
>
>
>
> Initialized Arguments for Method [SMI_]:  (0 arguments defined for method
> invocation)
>
>     Arg0:   81ecc40 <Obj>             Integer 0000000000000009
>
>     Arg1:   81eca38 <Obj>             Integer 0000000000000001
>
>     Arg2:   81ecbd8 <Obj>             Integer 0000000000000000
>
>     Arg3:   81ec9d0 <Obj>             Integer 0000000000000000
>
>     Arg4:   81ecb08 <Obj>             Integer 0000000000000000
>
>
>
> ACPI Error: Method parse/execution failed [\SMI] (Node 814de40),
> AE_AML_INFINITE_LOOP (20170303/psparse-668)
>
> ACPI Error: Method parse/execution failed [\WGSV] (Node 814e978),
> AE_AML_INFINITE_LOOP (20170303/psparse-668)
>
> ACPI Error: Method parse/execution failed [\_SB.PCI0.LPC.EC.HKEY.WGIN]
> (Node 8143810), AE_AML_INFINITE_LOOP (20170303/psparse-668)
>
> ACPI Error: Method parse/execution failed [\_SB.PCI0.LPC.EC._INI] (Node
> 8121ae0), AE_AML_INFINITE_LOOP (20170303/psparse-668)
>
> ACPI Exception: AE_AML_INFINITE_LOOP, during \_SB.PCI0.LPC.EC._INI
> execution (20170303/nsinit-807)
>
>     Executed 14 _INI methods requiring 1 _STA executions (examined 113
> objects)
>
> - execute \_SB.PCI0.LPC.EC.BAT0._BST
>
> Evaluating \_SB.PCI0.LPC.EC.BAT0._BST
>
> 0x4 Outstanding allocations after evaluation of \_SB.PCI0.LPC.EC.BAT0._BST
>
> Evaluation of \_SB.PCI0.LPC.EC.BAT0._BST returned object 80eaff0, external
> buffer length 78
>
>   [Package] Contains 4 Elements:
>
>     [Integer] =3D 0000000000000004
>
>     [Integer] =3D 0000000000000000
>
>     [Integer] =3D 0000000000000000
>
>     [Integer] =3D 0000000000000000
>
> - q
>
> ------------------------------------------------------------
> ------------------------------------
>
>
>
> Note: I tried running Linux on the Lenovo laptop and it can read the
> battery status ok.
>
>
>
> Thank you,
>
> Devin
>
>
>
>
>

--===============2982061126617310527==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+PGRpdj5JIGFncmVlIHdpdGggeW91LiBJdCBzaG91bGQgYmUgc3VwcG9y
dGVkIGJ5IFFOWCBidXQgSSBkb24mIzM5O3QgdGhpbmsgdGhhdCBpdCBpcyBzdXBwb3J0ZWQgJnF1
b3Q7b3V0IG9mIHRoZSBib3gmcXVvdDsuIEkgc2VhcmNoZWQgdGhlaXIgd2Vic2l0ZS9mb3J1bXMg
YW5kIGNvdWxkbiYjMzk7dCBmaW5kIGFueXRoaW5nIHJlbGF0ZWQgdG8gdGhpcy4gSSB3aWxsIGFz
ayBhcm91bmQgaGVyZSBhbmQgc2VlIGlmIEkgY2FuIGdldCBhIGZvcm1hbCBRTlggc3VwcG9ydCBj
b250YWN0IHRvIGZpbmQgb3V0IGZvciBjZXJ0YWluIChidXQgSSB3YXMgdG9sZCBub3QgdG8gaG9s
ZCBteSBicmVhdGggd2hlbiBjb250YWN0aW5nIFFOWCBmb3Igc3VwcG9ydCkuPC9kaXY+PGRpdj48
YnI+PC9kaXY+PGRpdj5BcyBmYXIgYXMgSSBjYW4gdGVsbCwgUU5YIG9ubHkgaGFzICZxdW90O2Jh
cmVib25lcyZxdW90OyBzdXBwb3J0IGZvciBBQ1BJLCBpLmUuIG9ubHkgd2hhdCBpcyBuZWVkZWQg
dG8gZ2V0IGEgc3lzdGVtIHRvIGJvb3QuPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5JIHNhdyB0
aGF0IHRoZSBBQ1BJQ0EgYWxyZWFkeSBoYXMgY29kZSBmb3IgUU5YIGFuZCBmb3VuZCB0aGF0IGl0
IHdhcyBhZGRlZCBieSBXaWxsIE1pbGVzOjwvZGl2PjxkaXY+PGEgaHJlZj0iaHR0cHM6Ly9naXRo
dWIuY29tL2FjcGljYS9hY3BpY2EvY29tbWl0LzM3YTFkZWMyIj5odHRwczovL2dpdGh1Yi5jb20v
YWNwaWNhL2FjcGljYS9jb21taXQvMzdhMWRlYzI8L2E+PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRp
dj5JJiMzOTtsbCB0cnkgZW1haWxpbmcgV2lsbCB0byBzZWUgaWYgaGUgY2FuIHNoZWQgc29tZSBs
aWdodCBvbiB0aGlzLiBJZiBoZSBoYWQgdG8gd3JpdGUgaGlzIG93biBPU0wgZm9yIFFOWCB0aGVu
IEkgc3VzcGVjdCB0aGF0IGhlIHdvdWxkIG5vdCBiZSBhYmxlIHRvIHNoYXJlIGl0IChhcyBpdCYj
Mzk7cyBsaWtlbHkgb3duZWQgYnkgaGlzIGNvbXBhbnkpLjwvZGl2PjxkaXY+PGJyPjwvZGl2Pjxk
aXY+SWYgdGhlIEVDIGRyaXZlciB0aGF0IEkgbmVlZCBpcyB0aGUgc2FtZSBhcyB0aGlzIG9uZSBm
b3IgTGludXgsIHRoZW4gSSBzaG91bGQgYmUgYWJsZSB0byB3cml0ZSBvbmUgbXlzZWxmIGZvciBR
Tlg6PC9kaXY+PGRpdj48YSBocmVmPSJodHRwOi8vZWxpeGlyLmZyZWUtZWxlY3Ryb25zLmNvbS9s
aW51eC9sYXRlc3Qvc291cmNlL2RyaXZlcnMvYWNwaS9lYy5jIj5odHRwOi8vZWxpeGlyLmZyZWUt
ZWxlY3Ryb25zLmNvbS9saW51eC9sYXRlc3Qvc291cmNlL2RyaXZlcnMvYWNwaS9lYy5jPC9hPjwv
ZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+SG93ZXZlciwgYXQgdGhpcyB0aW1lIEkmIzM5O20gbm90
IHN1cmUgaG93IEkgd291bGQgaW5mb3JtIEFDUElDQSB0byB1c2UgbXkgY3VzdG9tIFFOWCBFQyBk
cml2ZXIuIEhvdyB3b3VsZCBJIGdvIGFib3V0IHJlZ2lzdGVyaW5nIHRoZSBkcml2ZXIgd2l0aCBB
Q1BJQ0Egc28gdGhhdCBpdCBrbm93cyB3aGF0IGZ1bmN0aW9ucyB0byBjYWxsPyBJIGRvbiYjMzk7
dCBzZWUgYW55dGhpbmcgaW4gdGhlIEFDUElDQSBVc2VyIEd1aWRlIGFuZCBQcm9ncmFtbWVyIFJl
ZmVyZW5jZSBmb3IgdGhpcy4gVGhlIG9ubHkgQWNwaSogbWV0aG9kcyBmcm9tIHRoZSBBQ1BJQ0Eg
d2l0aCAmcXVvdDtyZWdpc3RlciZxdW90OyBpbiB0aGVtIGFyZSBBY3BpUmVhZEJpdFJlZ2lzdGVy
IGFuZCBBY3BpV3JpdGVCaXRSZWdpc3Rlci4gU2hvdWxkIHRoZXJlIGJlIHNvbWV0aGluZyBmb3Ig
cmVnaXN0ZXJpbmcgYSBkcml2ZXIgZm9yIGFuIG9wZXJhdGlvbiByZWdpb24/PC9kaXY+PGRpdj48
YnI+PC9kaXY+PGRpdj5UaGFua3MgYWdhaW4sPC9kaXY+PGRpdj5EZXZpbjwvZGl2PjxkaXY+PGJy
PjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+
PGJyPjwvZGl2PjwvZGl2PjxkaXYgY2xhc3M9ImdtYWlsX2V4dHJhIj48YnI+PGRpdiBjbGFzcz0i
Z21haWxfcXVvdGUiPk9uIFRodSwgTWF5IDI1LCAyMDE3IGF0IDM6NDcgUE0sIE1vb3JlLCBSb2Jl
cnQgPHNwYW4gZGlyPSJsdHIiPiZsdDs8YSBocmVmPSJtYWlsdG86cm9iZXJ0Lm1vb3JlQGludGVs
LmNvbSIgdGFyZ2V0PSJfYmxhbmsiPnJvYmVydC5tb29yZUBpbnRlbC5jb208L2E+Jmd0Ozwvc3Bh
bj4gd3JvdGU6PGJyPjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdp
bjowIDAgMCAuOGV4O2JvcmRlci1sZWZ0OjFweCAjY2NjIHNvbGlkO3BhZGRpbmctbGVmdDoxZXgi
Pg0KDQoNCg0KDQoNCjxkaXYgbGFuZz0iRU4tVVMiIHZsaW5rPSJwdXJwbGUiIGxpbms9ImJsdWUi
Pg0KPGRpdiBjbGFzcz0ibV81NjYyMDc2ODA2NTM0NjUzMDg1V29yZFNlY3Rpb24xIj4NCjxwIGNs
YXNzPSJNc29Ob3JtYWwiPjxzcGFuIHN0eWxlPSJjb2xvcjpyZ2IoMzEsNzMsMTI1KTtmb250LWZh
bWlseTomcXVvdDtDYWxpYnJpJnF1b3Q7LHNhbnMtc2VyaWY7Zm9udC1zaXplOjExcHQiPkkganVz
dCBsb29rZWQgaW50byB0aGUgQUNQSUNBIHNvdXJjZSwgYW5kIHllcywgaXQgYXBwZWFycyB0aGF0
IFFOWCB1c2VzIEFDUElDQTo8dT48L3U+PHU+PC91Pjwvc3Bhbj48L3A+DQo8cCBjbGFzcz0iTXNv
Tm9ybWFsIj48c3BhbiBzdHlsZT0iY29sb3I6cmdiKDMxLDczLDEyNSk7Zm9udC1mYW1pbHk6JnF1
b3Q7Q2FsaWJyaSZxdW90OyxzYW5zLXNlcmlmO2ZvbnQtc2l6ZToxMXB0Ij48dT48L3U+wqA8dT48
L3U+PC9zcGFuPjwvcD4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiIHN0eWxlPSItbXMtdGV4dC1hdXRv
c3BhY2U6OyI+PHNwYW4gc3R5bGU9ImNvbG9yOmJsdWU7Zm9udC1mYW1pbHk6JnF1b3Q7Q291cmll
ciBOZXcmcXVvdDs7Zm9udC1zaXplOjEwcHQiPiNpZm5kZWY8L3NwYW4+PHNwYW4gc3R5bGU9ImZv
bnQtZmFtaWx5OiZxdW90O0NvdXJpZXIgTmV3JnF1b3Q7O2ZvbnQtc2l6ZToxMHB0Ij4gX19BQ1FO
WF9IX188dT48L3U+PHU+PC91Pjwvc3Bhbj48L3A+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIiBzdHls
ZT0iLW1zLXRleHQtYXV0b3NwYWNlOjsiPjxzcGFuIHN0eWxlPSJjb2xvcjpibHVlO2ZvbnQtZmFt
aWx5OiZxdW90O0NvdXJpZXIgTmV3JnF1b3Q7O2ZvbnQtc2l6ZToxMHB0Ij4jZGVmaW5lPC9zcGFu
PjxzcGFuIHN0eWxlPSJmb250LWZhbWlseTomcXVvdDtDb3VyaWVyIE5ldyZxdW90Oztmb250LXNp
emU6MTBwdCI+IF9fQUNRTlhfSF9fPHU+PC91Pjx1PjwvdT48L3NwYW4+PC9wPg0KPHAgY2xhc3M9
Ik1zb05vcm1hbCIgc3R5bGU9Ii1tcy10ZXh0LWF1dG9zcGFjZTo7Ij48c3BhbiBzdHlsZT0iZm9u
dC1mYW1pbHk6JnF1b3Q7Q291cmllciBOZXcmcXVvdDs7Zm9udC1zaXplOjEwcHQiPjx1PjwvdT7C
oDx1PjwvdT48L3NwYW4+PC9wPg0KPHAgY2xhc3M9Ik1zb05vcm1hbCIgc3R5bGU9Ii1tcy10ZXh0
LWF1dG9zcGFjZTo7Ij48c3BhbiBzdHlsZT0iY29sb3I6Ymx1ZTtmb250LWZhbWlseTomcXVvdDtD
b3VyaWVyIE5ldyZxdW90Oztmb250LXNpemU6MTBwdCI+I2RlZmluZTwvc3Bhbj48c3BhbiBzdHls
ZT0iZm9udC1mYW1pbHk6JnF1b3Q7Q291cmllciBOZXcmcXVvdDs7Zm9udC1zaXplOjEwcHQiPiBB
Q1BJX1VTRV9TVEFOREFSRF9IRUFERVJTPHU+PC91Pjx1PjwvdT48L3NwYW4+PC9wPg0KPHAgY2xh
c3M9Ik1zb05vcm1hbCIgc3R5bGU9Ii1tcy10ZXh0LWF1dG9zcGFjZTo7Ij48c3BhbiBzdHlsZT0i
Y29sb3I6Ymx1ZTtmb250LWZhbWlseTomcXVvdDtDb3VyaWVyIE5ldyZxdW90Oztmb250LXNpemU6
MTBwdCI+I2RlZmluZTwvc3Bhbj48c3BhbiBzdHlsZT0iZm9udC1mYW1pbHk6JnF1b3Q7Q291cmll
ciBOZXcmcXVvdDs7Zm9udC1zaXplOjEwcHQiPiBBQ1BJX1VTRV9TWVNURU1fQ0xJQlJBUlk8dT48
L3U+PHU+PC91Pjwvc3Bhbj48L3A+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIiBzdHlsZT0iLW1zLXRl
eHQtYXV0b3NwYWNlOjsiPjxzcGFuIHN0eWxlPSJmb250LWZhbWlseTomcXVvdDtDb3VyaWVyIE5l
dyZxdW90Oztmb250LXNpemU6MTBwdCI+PHU+PC91PsKgPHU+PC91Pjwvc3Bhbj48L3A+DQo8cCBj
bGFzcz0iTXNvTm9ybWFsIiBzdHlsZT0iLW1zLXRleHQtYXV0b3NwYWNlOjsiPjxzcGFuIHN0eWxl
PSJjb2xvcjpibHVlO2ZvbnQtZmFtaWx5OiZxdW90O0NvdXJpZXIgTmV3JnF1b3Q7O2ZvbnQtc2l6
ZToxMHB0Ij4jZGVmaW5lPC9zcGFuPjxzcGFuIHN0eWxlPSJmb250LWZhbWlseTomcXVvdDtDb3Vy
aWVyIE5ldyZxdW90Oztmb250LXNpemU6MTBwdCI+IEFDUElfVUlOVFBUUl9UwqDCoMKgwqDCoMKg
wqDCoMKgIHVpbnRwdHJfdDx1PjwvdT48dT48L3U+PC9zcGFuPjwvcD4NCjxwIGNsYXNzPSJNc29O
b3JtYWwiIHN0eWxlPSItbXMtdGV4dC1hdXRvc3BhY2U6OyI+PHNwYW4gc3R5bGU9ImNvbG9yOmJs
dWU7Zm9udC1mYW1pbHk6JnF1b3Q7Q291cmllciBOZXcmcXVvdDs7Zm9udC1zaXplOjEwcHQiPiNk
ZWZpbmU8L3NwYW4+PHNwYW4gc3R5bGU9ImZvbnQtZmFtaWx5OiZxdW90O0NvdXJpZXIgTmV3JnF1
b3Q7O2ZvbnQtc2l6ZToxMHB0Ij4gQUNQSV9VU0VfTE9DQUxfQ0FDSEU8dT48L3U+PHU+PC91Pjwv
c3Bhbj48L3A+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIiBzdHlsZT0iLW1zLXRleHQtYXV0b3NwYWNl
OjsiPjxzcGFuIHN0eWxlPSJjb2xvcjpibHVlO2ZvbnQtZmFtaWx5OiZxdW90O0NvdXJpZXIgTmV3
JnF1b3Q7O2ZvbnQtc2l6ZToxMHB0Ij4jZGVmaW5lPC9zcGFuPjxzcGFuIHN0eWxlPSJmb250LWZh
bWlseTomcXVvdDtDb3VyaWVyIE5ldyZxdW90Oztmb250LXNpemU6MTBwdCI+IEFDUElfQ0FTVF9Q
VEhSRUFEX1QoeCnCoCAoKEFDUElfVEhSRUFEX0lEKSBBQ1BJX1RPX0lOVEVHRVIgKHgpKTx1Pjwv
dT48dT48L3U+PC9zcGFuPjwvcD4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiIHN0eWxlPSItbXMtdGV4
dC1hdXRvc3BhY2U6OyI+PHNwYW4gc3R5bGU9ImZvbnQtZmFtaWx5OiZxdW90O0NvdXJpZXIgTmV3
JnF1b3Q7O2ZvbnQtc2l6ZToxMHB0Ij48dT48L3U+wqA8dT48L3U+PC9zcGFuPjwvcD4NCjxwIGNs
YXNzPSJNc29Ob3JtYWwiIHN0eWxlPSItbXMtdGV4dC1hdXRvc3BhY2U6OyI+PHNwYW4gc3R5bGU9
ImNvbG9yOmdyZWVuO2ZvbnQtZmFtaWx5OiZxdW90O0NvdXJpZXIgTmV3JnF1b3Q7O2ZvbnQtc2l6
ZToxMHB0Ij4vKiBBdCBwcmVzZW50IHRpbWUgKFFOWCA2LjYpIGFsbCBzdXBwb3J0ZWQgYXJjaGl0
ZWN0dXJlcyBhcmUgMzIgYml0cy4gKi88dT48L3U+PHU+PC91Pjwvc3Bhbj48L3A+DQo8cCBjbGFz
cz0iTXNvTm9ybWFsIiBzdHlsZT0iLW1zLXRleHQtYXV0b3NwYWNlOjsiPjxzcGFuIHN0eWxlPSJj
b2xvcjpibHVlO2ZvbnQtZmFtaWx5OiZxdW90O0NvdXJpZXIgTmV3JnF1b3Q7O2ZvbnQtc2l6ZTox
MHB0Ij4jZGVmaW5lPC9zcGFuPjxzcGFuIHN0eWxlPSJmb250LWZhbWlseTomcXVvdDtDb3VyaWVy
IE5ldyZxdW90Oztmb250LXNpemU6MTBwdCI+IEFDUElfTUFDSElORV9XSURUSMKgwqDCoMKgwqAg
MzI8dT48L3U+PHU+PC91Pjwvc3Bhbj48L3A+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj48c3BhbiBz
dHlsZT0iY29sb3I6cmdiKDMxLDczLDEyNSk7Zm9udC1mYW1pbHk6JnF1b3Q7Q2FsaWJyaSZxdW90
OyxzYW5zLXNlcmlmO2ZvbnQtc2l6ZToxMXB0Ij48dT48L3U+wqA8dT48L3U+PC9zcGFuPjwvcD4N
CjxwIGNsYXNzPSJNc29Ob3JtYWwiPjxzcGFuIHN0eWxlPSJjb2xvcjpyZ2IoMzEsNzMsMTI1KTtm
b250LWZhbWlseTomcXVvdDtDYWxpYnJpJnF1b3Q7LHNhbnMtc2VyaWY7Zm9udC1zaXplOjExcHQi
PldoaWNoIG1lYW5zIHRoYXQgdGhlIEFDUElDQS10by1RTlggT1NMIGludGVyZmFjZSBsYXllciBh
bHJlYWR5IGV4aXN0cy48dT48L3U+PHU+PC91Pjwvc3Bhbj48L3A+DQo8cCBjbGFzcz0iTXNvTm9y
bWFsIj48c3BhbiBzdHlsZT0iY29sb3I6cmdiKDMxLDczLDEyNSk7Zm9udC1mYW1pbHk6JnF1b3Q7
Q2FsaWJyaSZxdW90OyxzYW5zLXNlcmlmO2ZvbnQtc2l6ZToxMXB0Ij48dT48L3U+wqA8dT48L3U+
PC9zcGFuPjwvcD4NCjxkaXYgc3R5bGU9ImJvcmRlci13aWR0aDptZWRpdW0gbWVkaXVtIG1lZGl1
bSAxLjVwdDtib3JkZXItc3R5bGU6bm9uZSBub25lIG5vbmUgc29saWQ7Ym9yZGVyLWNvbG9yOmN1
cnJlbnRDb2xvciBjdXJyZW50Q29sb3IgY3VycmVudENvbG9yIGJsdWU7cGFkZGluZzowaW4gMGlu
IDBpbiA0cHQiPg0KPGRpdj4NCjxkaXYgc3R5bGU9ImJvcmRlci13aWR0aDoxcHQgbWVkaXVtIG1l
ZGl1bTtib3JkZXItc3R5bGU6c29saWQgbm9uZSBub25lO2JvcmRlci1jb2xvcjpyZ2IoMjI1LDIy
NSwyMjUpIGN1cnJlbnRDb2xvciBjdXJyZW50Q29sb3I7cGFkZGluZzozcHQgMGluIDBpbiI+DQo8
cCBjbGFzcz0iTXNvTm9ybWFsIj48Yj48c3BhbiBzdHlsZT0iZm9udC1mYW1pbHk6JnF1b3Q7Q2Fs
aWJyaSZxdW90OyxzYW5zLXNlcmlmO2ZvbnQtc2l6ZToxMXB0Ij5Gcm9tOjwvc3Bhbj48L2I+PHNw
YW4gc3R5bGU9ImZvbnQtZmFtaWx5OiZxdW90O0NhbGlicmkmcXVvdDssc2Fucy1zZXJpZjtmb250
LXNpemU6MTFwdCI+IERldmVsIFttYWlsdG86PGEgaHJlZj0ibWFpbHRvOmRldmVsLWJvdW5jZXNA
YWNwaWNhLm9yZyIgdGFyZ2V0PSJfYmxhbmsiPmRldmVsLWJvdW5jZXNAYWNwaWNhLjx3YnI+b3Jn
PC9hPl0NCjxiPk9uIEJlaGFsZiBPZiA8L2I+TW9vcmUsIFJvYmVydDxicj4NCjxiPlNlbnQ6PC9i
PiBUaHVyc2RheSwgTWF5IDI1LCAyMDE3IDEyOjQxIFBNPGJyPg0KPGI+VG86PC9iPiBEZXZpbiBT
dGVmZmxlciAmbHQ7PGEgaHJlZj0ibWFpbHRvOmRldmluc3RlZmZsZXJAZ21haWwuY29tIiB0YXJn
ZXQ9Il9ibGFuayI+ZGV2aW5zdGVmZmxlckBnbWFpbC5jb208L2E+Jmd0Ozwvc3Bhbj48ZGl2Pjxk
aXYgY2xhc3M9Img1Ij48YnI+DQo8Yj5DYzo8L2I+IDxhIGhyZWY9Im1haWx0bzpkZXZlbEBhY3Bp
Y2Eub3JnIiB0YXJnZXQ9Il9ibGFuayI+ZGV2ZWxAYWNwaWNhLm9yZzwvYT48YnI+DQo8Yj5TdWJq
ZWN0OjwvYj4gUmU6IFtEZXZlbF0gSGVscCBuZWVkZWQgZm9yICZxdW90O0FDUEkgRXJyb3I6IE5v
IGhhbmRsZXIgZm9yIFJlZ2lvbiBbRUNPUl0mcXVvdDsgKHVzaW5nIG15IG93biBPU0wpPHU+PC91
Pjx1PjwvdT48L2Rpdj48L2Rpdj48cD48L3A+DQo8L3A+PC9kaXY+DQo8L2Rpdj48ZGl2PjxkaXYg
Y2xhc3M9Img1Ij4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPjx1PjwvdT7CoDx1PjwvdT48L3A+DQo8
cCBjbGFzcz0iTXNvTm9ybWFsIj48c3BhbiBzdHlsZT0iY29sb3I6cmdiKDMxLDczLDEyNSk7Zm9u
dC1mYW1pbHk6JnF1b3Q7Q2FsaWJyaSZxdW90OyxzYW5zLXNlcmlmO2ZvbnQtc2l6ZToxMXB0Ij5J
IGNhbuKAmXQgc3BlYWsgZm9yIFFOWCwgYnV0IHRoZSBFQyBkcml2ZXIgd291bGQgYmUgcGFydCBv
ZiBpdC4gSXQgaGFzIG5vdGhpbmcgdG8gZG8gd2l0aCB5b3VyIE9TTC48dT48L3U+PHU+PC91Pjwv
c3Bhbj48L3A+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj48c3BhbiBzdHlsZT0iY29sb3I6cmdiKDMx
LDczLDEyNSk7Zm9udC1mYW1pbHk6JnF1b3Q7Q2FsaWJyaSZxdW90OyxzYW5zLXNlcmlmO2ZvbnQt
c2l6ZToxMXB0Ij48dT48L3U+wqA8dT48L3U+PC9zcGFuPjwvcD4NCjxwIGNsYXNzPSJNc29Ob3Jt
YWwiPjxzcGFuIHN0eWxlPSJjb2xvcjpyZ2IoMzEsNzMsMTI1KTtmb250LWZhbWlseTomcXVvdDtD
YWxpYnJpJnF1b3Q7LHNhbnMtc2VyaWY7Zm9udC1zaXplOjExcHQiPknigJltIG5vdCBzdXJlIHdo
eSB5b3UgaGF2ZSB0byB3cml0ZSB5b3VyIG93biBPU0wsIHRoaXMgc2hvdWxkIGFscmVhZHkgYmUg
cGFydCBvZiBRTlgsIGFzc3VtaW5nIHRoYXQgaXQgaGFzIEFDUEkgc3VwcG9ydCwgYW5kIHVzZXMg
QUNQSUNBIGFzIHRoZSB1bmRlcmx5aW5nIEFDUEkNCiBzb2Z0d2FyZS48dT48L3U+PHU+PC91Pjwv
c3Bhbj48L3A+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj48c3BhbiBzdHlsZT0iY29sb3I6cmdiKDMx
LDczLDEyNSk7Zm9udC1mYW1pbHk6JnF1b3Q7Q2FsaWJyaSZxdW90OyxzYW5zLXNlcmlmO2ZvbnQt
c2l6ZToxMXB0Ij48dT48L3U+wqA8dT48L3U+PC9zcGFuPjwvcD4NCjxwIGNsYXNzPSJNc29Ob3Jt
YWwiPjxzcGFuIHN0eWxlPSJjb2xvcjpyZ2IoMzEsNzMsMTI1KTtmb250LWZhbWlseTomcXVvdDtD
YWxpYnJpJnF1b3Q7LHNhbnMtc2VyaWY7Zm9udC1zaXplOjExcHQiPlRvIHB1dCB0aGlzIG1vcmUg
c3VjY2luY3RseTrCoCBBQ1BJQ0EgcHJvdmlkZXMgdGhlIHVuZGVybHlpbmcgaW5mcmFzdHJ1Y3R1
cmUgZm9yIEFDUEkgc3VwcG9ydCBpbiBhbiBPUy4gQnV0LCB0aGUgT1MgbXVzdCBwcm92aWRlIGl0
cyBvd24gQUNQSS1yZWxhdGVkIGRyaXZlcnMgYW5kDQogb3RoZXIgQUNQSSBzdXBwb3J0LiBUaGUg
RUMgZHJpdmVyIGlzIG9uZSBvZiB0aGVzZSBBQ1BJLXJlbGF0ZWQgZHJpdmVycy48dT48L3U+PHU+
PC91Pjwvc3Bhbj48L3A+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj48c3BhbiBzdHlsZT0iY29sb3I6
cmdiKDMxLDczLDEyNSk7Zm9udC1mYW1pbHk6JnF1b3Q7Q2FsaWJyaSZxdW90OyxzYW5zLXNlcmlm
O2ZvbnQtc2l6ZToxMXB0Ij48dT48L3U+wqA8dT48L3U+PC9zcGFuPjwvcD4NCjxwIGNsYXNzPSJN
c29Ob3JtYWwiPjxzcGFuIHN0eWxlPSJjb2xvcjpyZ2IoMzEsNzMsMTI1KTtmb250LWZhbWlseTom
cXVvdDtDYWxpYnJpJnF1b3Q7LHNhbnMtc2VyaWY7Zm9udC1zaXplOjExcHQiPkJvYjx1PjwvdT48
dT48L3U+PC9zcGFuPjwvcD4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPjxzcGFuIHN0eWxlPSJjb2xv
cjpyZ2IoMzEsNzMsMTI1KTtmb250LWZhbWlseTomcXVvdDtDYWxpYnJpJnF1b3Q7LHNhbnMtc2Vy
aWY7Zm9udC1zaXplOjExcHQiPjx1PjwvdT7CoDx1PjwvdT48L3NwYW4+PC9wPg0KPHAgY2xhc3M9
Ik1zb05vcm1hbCI+PHNwYW4gc3R5bGU9ImNvbG9yOnJnYigzMSw3MywxMjUpO2ZvbnQtZmFtaWx5
OiZxdW90O0NhbGlicmkmcXVvdDssc2Fucy1zZXJpZjtmb250LXNpemU6MTFwdCI+PHU+PC91PsKg
PHU+PC91Pjwvc3Bhbj48L3A+DQo8ZGl2IHN0eWxlPSJib3JkZXItd2lkdGg6bWVkaXVtIG1lZGl1
bSBtZWRpdW0gMS41cHQ7Ym9yZGVyLXN0eWxlOm5vbmUgbm9uZSBub25lIHNvbGlkO2JvcmRlci1j
b2xvcjpjdXJyZW50Q29sb3IgY3VycmVudENvbG9yIGN1cnJlbnRDb2xvciBibHVlO3BhZGRpbmc6
MGluIDBpbiAwaW4gNHB0Ij4NCjxkaXY+DQo8ZGl2IHN0eWxlPSJib3JkZXItd2lkdGg6MXB0IG1l
ZGl1bSBtZWRpdW07Ym9yZGVyLXN0eWxlOnNvbGlkIG5vbmUgbm9uZTtib3JkZXItY29sb3I6cmdi
KDIyNSwyMjUsMjI1KSBjdXJyZW50Q29sb3IgY3VycmVudENvbG9yO3BhZGRpbmc6M3B0IDBpbiAw
aW4iPg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+PGI+PHNwYW4gc3R5bGU9ImZvbnQtZmFtaWx5OiZx
dW90O0NhbGlicmkmcXVvdDssc2Fucy1zZXJpZjtmb250LXNpemU6MTFwdCI+RnJvbTo8L3NwYW4+
PC9iPjxzcGFuIHN0eWxlPSJmb250LWZhbWlseTomcXVvdDtDYWxpYnJpJnF1b3Q7LHNhbnMtc2Vy
aWY7Zm9udC1zaXplOjExcHQiPiBEZXZpbiBTdGVmZmxlciBbPGEgaHJlZj0ibWFpbHRvOmRldmlu
c3RlZmZsZXJAZ21haWwuY29tIiB0YXJnZXQ9Il9ibGFuayI+bWFpbHRvOmRldmluc3RlZmZsZXJA
Z21haWwuPHdicj5jb208L2E+XQ0KPGJyPg0KPGI+U2VudDo8L2I+IFRodXJzZGF5LCBNYXkgMjUs
IDIwMTcgNzo0OCBBTTxicj4NCjxiPlRvOjwvYj4gTW9vcmUsIFJvYmVydCAmbHQ7PGEgaHJlZj0i
bWFpbHRvOnJvYmVydC5tb29yZUBpbnRlbC5jb20iIHRhcmdldD0iX2JsYW5rIj5yb2JlcnQubW9v
cmVAaW50ZWwuY29tPC9hPiZndDs8YnI+DQo8Yj5DYzo8L2I+IDxhIGhyZWY9Im1haWx0bzpkZXZl
bEBhY3BpY2Eub3JnIiB0YXJnZXQ9Il9ibGFuayI+ZGV2ZWxAYWNwaWNhLm9yZzwvYT48YnI+DQo8
Yj5TdWJqZWN0OjwvYj4gUmU6IFtEZXZlbF0gSGVscCBuZWVkZWQgZm9yICZxdW90O0FDUEkgRXJy
b3I6IE5vIGhhbmRsZXIgZm9yIFJlZ2lvbiBbRUNPUl0mcXVvdDsgKHVzaW5nIG15IG93biBPU0wp
PHU+PC91Pjx1PjwvdT48L3NwYW4+PC9wPg0KPC9kaXY+DQo8L2Rpdj4NCjxwIGNsYXNzPSJNc29O
b3JtYWwiPjx1PjwvdT7CoDx1PjwvdT48L3A+DQo8ZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29O
b3JtYWwiPkhpIFJvYmVydCw8dT48L3U+PHU+PC91PjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNs
YXNzPSJNc29Ob3JtYWwiPjx1PjwvdT7CoDx1PjwvdT48L3A+DQo8L2Rpdj4NCjxkaXY+DQo8cCBj
bGFzcz0iTXNvTm9ybWFsIj5UaGFua3MgZm9yIHlvdXIgaW5zaWdodC48dT48L3U+PHU+PC91Pjwv
cD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPjx1PjwvdT7CoDx1PjwvdT48
L3A+DQo8L2Rpdj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj5Ib3cgY2FuIEkgZmluZCBv
dXQgd2hldGhlciBpcyBpdCBhIG1pc3NpbmcgRUMgZHJpdmVyIG9yIHRoZSBFQyBkcml2ZXIgaXPC
oGZhaWxpbmcgdG8gaW5zdGFsbCBhIGhhbmRsZXIgZm9yIHRoZSBFQyBvcGVyYXRpb24gcmVnaW9u
Pzx1PjwvdT48dT48L3U+PC9wPg0KPC9kaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+
PHU+PC91PsKgPHU+PC91PjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwi
PklzIHRoZSBFQyBkcml2ZXIgc29tZSBDIGNvZGUgdGhhdCBJIHdvdWxkIGJlIGV4cGVjdGVkIHRv
IHdyaXRlIGFzIHBhcnQgb2YgdGhlIE9TTCBvciBpcyBpdCBleHBlY3RlZCB0byBiZSBpbmNsdWRl
ZCB3aXRoIHRoZSBPUyAoUU5YIGluIHRoaXMgY2FzZSk/PHU+PC91Pjx1PjwvdT48L3A+DQo8L2Rp
dj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj48dT48L3U+wqA8dT48L3U+PC9wPg0KPC9k
aXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+SSBzdXNwZWN0IHRoYXQgdGhlIHByb2Js
ZW0gaXMgc29tZXdoZXJlIGluwqBteSBPU0wgKHNpbmNlIEkmIzM5O20gdmVyeSBuZXcgdG8gQUNQ
SSkuIERvIHlvdSB0aGluayB0aGlzIGlzIGxpa2VseSB0aGUgY2FzZT8gV2hhdCBzaG91bGQgSSBm
b2N1cyBvbiB0byBkZWJ1ZyBteSBPU0wgaWYgdGhpcyBpcyB0aGUgY2FzZT88dT48L3U+PHU+PC91
PjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPjx1PjwvdT7CoDx1Pjwv
dT48L3A+DQo8L2Rpdj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj5IZXJlJiMzOTtzIGFu
IGV4Y2VycHQgZnJvbSB0aGUgTGVub3ZvJiMzOTtzIERTRFQuZHNsIChob3BpbmcgaXQgaGVscHMp
Ojx1PjwvdT48dT48L3U+PC9wPg0KPC9kaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tPHdicj4tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS08d2JyPi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLTx3YnI+LS0tLS08dT48
L3U+PHU+PC91PjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPsKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBEZXZpY2UgKEVDKTxicj4NCsKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCB7PGJyPg0KwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgTmFtZSAoX0hJRCwgRWlzYUlkICgmcXVvdDtQTlAwQzA5JnF1b3Q7KSAvKiBFbWJlZGRl
ZCBDb250cm9sbGVyIERldmljZSAqLynCoCAvLyBfSElEOiBIYXJkd2FyZSBJRDxicj4NCsKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIE5hbWUgKF9VSUQsIDB4MDApwqAgLy8g
X1VJRDogVW5pcXVlIElEPGJyPg0KwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgTmFtZSAoX0dQRSwgMHgyMCnCoCAvLyBfR1BFOiBHZW5lcmFsIFB1cnBvc2UgRXZlbnRzPGJy
Pg0KwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgTWV0aG9kIChfUkVHLCAy
LCBOb3RTZXJpYWxpemVkKcKgIC8vIF9SRUc6IFJlZ2lvbiBBdmFpbGFiaWxpdHk8YnI+DQrCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB7PGJyPg0KwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBJZiAoKEFyZzAgPT0gMHgwMykpPGJyPg0K
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB7PGJyPg0KwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFxIOERS
ID0gQXJnMTxicj4NCsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgfTxicj4NCsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIH08dT48L3U+
PHU+PC91PjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPsKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIE9wZXJhdGlvblJlZ2lvbiAoRUNPUiwgRW1i
ZWRkZWRDb250cm9sLCAweDAwLCAweDAxMDApPGJyPg0KwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgRmllbGQgKEVDT1IsIEJ5dGVBY2MsIE5vTG9jaywgUHJlc2VydmUpPGJy
Pg0KwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgezxicj4NCsKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgSERCTSzCoMKgIDEsIDxicj4N
CsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAs
wqDCoCAxLCA8YnI+DQrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIEhLTEsswqDCoCAxLCA8YnI+DQrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIEhGTkUswqDCoCAxLCA8YnI+DQrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLMKgwqAgMSwgPGJyPg0KwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICzCoMKgIDEsIDxicj4N
CsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgSExETSzCoMKg
IDEsIDxicj4NCsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
T2Zmc2V0ICgweDAxKSwgPGJyPg0KwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBCQkxTLMKgwqAgMSwgPGJyPg0KwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBCVENNLMKgwqAgMSwgPGJyPg0KwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICzCoMKgIDEsIDxicj4NCsKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAswqDCoCAx
LCA8YnI+DQrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgLMKgwqAgMSwgPGJyPg0KwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBIQlBSLMKgwqAgMSwgPGJyPg0KwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBCVFBDLMKgwqAgMSwgPGJyPg0KwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBPZmZzZXQgKDB4MDIpLCA8YnI+DQrCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEhEVUUswqDCoCAxLCA8YnI+
DQrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
LMKgwqAgNCwgPGJyPg0KwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBTTkxLLMKgwqAgMSwgPGJyPg0KwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBPZmZzZXQgKDB4MDMpLCA8YnI+DQrCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLMKgwqAgNSwgPGJyPg0KwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBIQVVNLMKgwqAgMiwgPGJyPg0K
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBPZmZzZXQgKDB4
MDUpLCA8YnI+DQrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IEhTUEEswqDCoCAxLCA8YnI+DQrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIE9mZnNldCAoMHgwNiksIDxicj4NCsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgSFNVTizCoMKgIDgsIDxicj4NCsKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgSFNSUCzCoMKgIDgsIDxicj4NCsKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgT2Zmc2V0ICgweDA5KSwgPGJy
Pg0KwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
ICzCoMKgIDYsIDxicj4NCsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgRk5LUyzCoMKgIDEsIDxicj4NCsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgT2Zmc2V0ICgweDBDKSwgPGJyPg0KwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBITENMLMKgwqAgOCwgPGJyPg0KwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICzCoMKgIDQsIDxicj4N
CsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgQ0FMTSzCoMKg
IDEsIDxicj4NCsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
T2Zmc2V0ICgweDBFKSwgPGJyPg0KwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBIRk5TLMKgwqAgMiwgPGJyPg0KwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBPZmZzZXQgKDB4MEYpLCA8YnI+DQrCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLMKgwqAgNiwgPGJyPg0KwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBOVUxTLMKgwqAgMSwg
PGJyPg0KwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBPZmZz
ZXQgKDB4MTApLCA8YnI+DQrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIEhBTTAswqDCoCA4LCA8YnI+DQrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIEhBTTEswqDCoCA4LCA8YnI+DQrCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEhBTTIswqDCoCA4LCA8YnI+DQrCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEhBTTMswqDCoCA4LCA8YnI+DQrCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEhBTTQswqDCoCA4LCA8
YnI+DQrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEhBTTUs
wqDCoCA4LCA8YnI+DQrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIEhBTTYswqDCoCA4LCA8YnI+DQrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIEhBTTcswqDCoCA4LCA8YnI+DQrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIEhBTTgswqDCoCA4LCA8YnI+DQrCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEhBTTkswqDCoCA4LCA8YnI+DQrCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEhBTUEswqDCoCA4LCA8YnI+
DQrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEhBTUIswqDC
oCA4LCA8YnI+DQrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IEhBTUMswqDCoCA4LCA8YnI+DQrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIEhBTUQswqDCoCA4LCA8YnI+DQrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIEhBTUUswqDCoCA4LCA8YnI+DQrCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEhBTUYswqDCoCA4LCA8YnI+DQrCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIE9mZnNldCAoMHgyMyksIDxicj4N
CsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgSEFOVCzCoMKg
IDgsIDxicj4NCsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
T2Zmc2V0ICgweDI2KSwgPGJyPg0KwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgICzCoMKgIDIsIDxicj4NCsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgSEFOQSzCoMKgIDIsIDxicj4NCsKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgT2Zmc2V0ICgweDI3KSwgPGJyPg0KwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBPZmZzZXQgKDB4Mjgp
LCA8YnI+DQrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgLMKgwqAgMSwgPGJyPg0KwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBTS0VNLMKgwqAgMSwgPGJyPg0KwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBPZmZzZXQgKDB4MjkpLCA8YnI+DQrCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIE9mZnNldCAoMHgyQSksIDxicj4NCsKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgSEFUUizCoMKgIDgsIDxi
cj4NCsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgSFQwSCzC
oMKgIDgsIDxicj4NCsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgSFQwTCzCoMKgIDgsIDxicj4NCsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgSFQxSCzCoMKgIDgsIDxicj4NCsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgSFQxTCzCoMKgIDgsIDxicj4NCsKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgSEZTUCzCoMKgIDgsIDxicj4NCsKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAswqDCoCA2LCA8
YnI+DQrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEhNVVQs
wqDCoCAxLCA8YnI+DQrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIE9mZnNldCAoMHgzMSksIDxicj4NCsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAswqDCoCAyLCA8YnI+DQrCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEhVV0IswqDCoCAxLCA8YnI+DQrCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLMKgwqAgMywgPGJy
Pg0KwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBWUE9OLMKg
wqAgMSwgPGJyPg0KwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBWUlNULMKgwqAgMSwgPGJyPg0KwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBIV1BNLMKgwqAgMSwgPGJyPg0KwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBIV0xCLMKgwqAgMSwgPGJyPg0KwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBIV0xPLMKgwqAgMSwgPGJyPg0KwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBIV0RLLMKgwqAgMSwgPGJyPg0K
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBIV0ZOLMKgwqAg
MSwgPGJyPg0KwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBI
V0JULMKgwqAgMSwgPGJyPg0KwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBIV1JJLMKgwqAgMSwgPGJyPg0KwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBIV0JVLMKgwqAgMSwgPGJyPg0KwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBIV0xVLMKgwqAgMSwgPGJyPg0KwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBPZmZzZXQgKDB4MzQpLCA8YnI+DQrC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLMKg
wqAgMywgPGJyPg0KwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBQSUJTLMKgwqAgMSwgPGJyPg0KwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgICzCoMKgIDMsIDxicj4NCsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgSFBMTyzCoMKgIDEsIDxicj4NCsKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgT2Zmc2V0ICgweDM2KSwgPGJyPg0KwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBIV0FDLMKgwqAgMTYs
IDxicj4NCsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgSEIw
UyzCoMKgIDcsIDxicj4NCsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgSEIwQSzCoMKgIDEsIDxicj4NCsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgSEIxUyzCoMKgIDcsIDxicj4NCsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgSEIxQSzCoMKgIDEsIDxicj4NCsKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgSENNVSzCoMKgIDEsIDxicj4NCsKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAswqDCoCAy
LCA8YnI+DQrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIE9W
UlEswqDCoCAxLCA8YnI+DQrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIERDQkQswqDCoCAxLCA8YnI+DQrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIERDV0wswqDCoCAxLCA8YnI+DQrCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIERDV1cswqDCoCAxLCA8YnI+DQrCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEhCMUkswqDCoCAxLCA8YnI+DQrCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLMKgwqAg
MSwgPGJyPg0KwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBL
QkxULMKgwqAgMSwgPGJyPg0KwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBCVFBXLMKgwqAgMSwgPGJyPg0KwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBGTktDLMKgwqAgMSwgPGJyPg0KwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBIVUJTLMKgwqAgMSwgPGJyPg0KwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBCRFBXLMKgwqAgMSwgPGJyPg0KwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBCRERULMKgwqAgMSwg
PGJyPg0KwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBIVUJC
LMKgwqAgMSwgPGJyPg0KwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBPZmZzZXQgKDB4NDYpLCA8YnI+DQrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLMKgwqAgMSwgPGJyPg0KwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBCVFdLLMKgwqAgMSwgPGJyPg0KwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBIUExELMKgwqAgMSwgPGJyPg0K
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICzC
oMKgIDEsIDxicj4NCsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgSFBBQyzCoMKgIDEsIDxicj4NCsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgQlRTVCzCoMKgIDEsIDxicj4NCsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgT2Zmc2V0ICgweDQ3KSwgPGJyPg0KwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBIUEJVLMKgwqAgMSwgPGJyPg0KwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICzCoMKgIDEs
IDxicj4NCsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgSEJJ
RCzCoMKgIDEsIDxicj4NCsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCAswqDCoCAzLCA8YnI+DQrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIEhCQ1MswqDCoCAxLCA8YnI+DQrCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEhQTkYswqDCoCAxLCA8YnI+DQrCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLMKgwqAgMSwgPGJy
Pg0KwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBHU1RTLMKg
wqAgMSwgPGJyPg0KwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgICzCoMKgIDIsIDxicj4NCsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgSExCVSzCoMKgIDEsIDxicj4NCsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgRE9DRCzCoMKgIDEsIDxicj4NCsKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgSENCTCzCoMKgIDEsIDxicj4NCsKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgT2Zmc2V0ICgweDQ5KSwg
PGJyPg0KwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBTTFVM
LMKgwqAgMSwgPGJyPg0KwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBPZmZzZXQgKDB4NEMpLCA8YnI+DQrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIEhUTUgswqDCoCA4LCA8YnI+DQrCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEhUTUwswqDCoCA4LCA8YnI+DQrCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEhXQUsswqDCoCAxNiwgPGJyPg0KwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBITVBSLMKgwqAgOCwg
PGJyPg0KwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgICzCoMKgIDcsIDxicj4NCsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgSE1ETizCoMKgIDEsIDxicj4NCsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgT2Zmc2V0ICgweDc4KSwgPGJyPg0KwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBUTVAwLMKgwqAgOCwgPGJyPg0KwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBPZmZzZXQgKDB4ODApLCA8YnI+
DQrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIE9mZnNldCAo
MHg4MSksIDxicj4NCsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgSElJRCzCoMKgIDgsIDxicj4NCsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgT2Zmc2V0ICgweDgzKSwgPGJyPg0KwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBIRk5JLMKgwqAgOCwgPGJyPg0KwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBIU1BELMKgwqAgMTYsIDxicj4NCsKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgT2Zmc2V0ICgweDg4KSwg
PGJyPg0KwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBUU0ww
LMKgwqAgNywgPGJyPg0KwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBUU1IwLMKgwqAgMSwgPGJyPg0KwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBUU0wxLMKgwqAgNywgPGJyPg0KwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBUU1IxLMKgwqAgMSwgPGJyPg0KwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBUU0wyLMKgwqAgNywgPGJyPg0KwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBUU1IyLMKgwqAgMSwgPGJy
Pg0KwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBUU0wzLMKg
wqAgNywgPGJyPg0KwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBUU1IzLMKgwqAgMSwgPGJyPg0KwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBPZmZzZXQgKDB4OEQpLCA8YnI+DQrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIEhEQUEswqDCoCAzLCA8YnI+DQrCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEhEQUIswqDCoCAzLCA8YnI+DQrCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEhEQUMswqDCoCAyLCA8YnI+
DQrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFJDQkQswqDC
oCAxLCA8YnI+DQrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IFJDV0wswqDCoCAxLCA8YnI+DQrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIFJDV1cswqDCoCAxLCA8YnI+DQrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIE9mZnNldCAoMHhCMCksIDxicj4NCsKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgSERFTizCoMKgIDMyLCA8YnI+DQrCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEhERVAswqDCoCAzMiwgPGJy
Pg0KwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBIREVNLMKg
wqAgOCwgPGJyPg0KwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBIREVTLMKgwqAgOCwgPGJyPg0KwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBPZmZzZXQgKDB4QzgpLCA8YnI+DQrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIEFUTVgswqDCoCA4LCA8YnI+DQrCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEhXQVQswqDCoCA4LCA8YnI+DQrCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIE9mZnNldCAoMHhDQyksIDxi
cj4NCsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgUFdNSCzC
oMKgIDgsIDxicj4NCsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgUFdNTCzCoMKgIDgsIDxicj4NCsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgT2Zmc2V0ICgweEVEKSwgPGJyPg0KwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICzCoMKgIDQsIDxicj4NCsKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgSERERCzCoMKgIDE8YnI+DQrCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB9PHU+PC91Pjx1PjwvdT48L3A+DQo8
L2Rpdj4NCjxkaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+LS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tPHdicj4tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS08d2JyPi0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLTx3YnI+LS0tLS08dT48L3U+PHU+PC91PjwvcD4N
CjwvZGl2Pg0KPC9kaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+PHU+PC91PsKgPHU+
PC91PjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPk1hbnkgdGhhbmtz
LDxicj4NCkRldmluPHU+PC91Pjx1PjwvdT48L3A+DQo8L2Rpdj4NCjxkaXY+DQo8cCBjbGFzcz0i
TXNvTm9ybWFsIj48dT48L3U+wqA8dT48L3U+PC9wPg0KPC9kaXY+DQo8L2Rpdj4NCjxkaXY+DQo8
cCBjbGFzcz0iTXNvTm9ybWFsIj48dT48L3U+wqA8dT48L3U+PC9wPg0KPGRpdj4NCjxwIGNsYXNz
PSJNc29Ob3JtYWwiPk9uIFRodSwgTWF5IDI1LCAyMDE3IGF0IDEwOjE1IEFNLCBNb29yZSwgUm9i
ZXJ0ICZsdDs8YSBocmVmPSJtYWlsdG86cm9iZXJ0Lm1vb3JlQGludGVsLmNvbSIgdGFyZ2V0PSJf
YmxhbmsiPnJvYmVydC5tb29yZUBpbnRlbC5jb208L2E+Jmd0OyB3cm90ZTo8dT48L3U+PHU+PC91
PjwvcD4NCjxibG9ja3F1b3RlIHN0eWxlPSJib3JkZXItd2lkdGg6bWVkaXVtIG1lZGl1bSBtZWRp
dW0gMXB0O2JvcmRlci1zdHlsZTpub25lIG5vbmUgbm9uZSBzb2xpZDtib3JkZXItY29sb3I6Y3Vy
cmVudENvbG9yIGN1cnJlbnRDb2xvciBjdXJyZW50Q29sb3IgcmdiKDIwNCwyMDQsMjA0KTttYXJn
aW46NXB0IDBpbiA1cHQgNC44cHQ7cGFkZGluZzowaW4gMGluIDBpbiA2cHQiPg0KPGRpdj4NCjxk
aXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj5BQ1BJIEVycm9yOiBSZWdpb24gRW1iZWRkZWRDb250
cm9sIChJRD0zKSBoYXMgbm8gaGFuZGxlciAoMjAxNzAzMDMvZXhmbGRpby00MzEpPHU+PC91Pjx1
PjwvdT48L3A+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj48c3BhbiBzdHlsZT0iY29sb3I6cmdiKDMx
LDczLDEyNSk7Zm9udC1mYW1pbHk6JnF1b3Q7Q2FsaWJyaSZxdW90OyxzYW5zLXNlcmlmO2ZvbnQt
c2l6ZToxMXB0Ij7CoDwvc3Bhbj48dT48L3U+PHU+PC91PjwvcD4NCjxwIGNsYXNzPSJNc29Ob3Jt
YWwiPjxzcGFuIHN0eWxlPSJjb2xvcjpyZ2IoMzEsNzMsMTI1KTtmb250LWZhbWlseTomcXVvdDtD
YWxpYnJpJnF1b3Q7LHNhbnMtc2VyaWY7Zm9udC1zaXplOjExcHQiPllvdSBlaXRoZXIgZG9u4oCZ
dCBoYXZlIGEgZHJpdmVyIGZvciB0aGUgRUMsIG9yIHlvdXIgRUMgZHJpdmVyIGhhcyBub3QgaW5z
dGFsbGVkIGEgaGFuZGxlciBmb3IgdGhlIEVDDQogb3BlcmF0aW9uIHJlZ2lvbi48L3NwYW4+PHU+
PC91Pjx1PjwvdT48L3A+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj48c3BhbiBzdHlsZT0iY29sb3I6
cmdiKDMxLDczLDEyNSk7Zm9udC1mYW1pbHk6JnF1b3Q7Q2FsaWJyaSZxdW90OyxzYW5zLXNlcmlm
O2ZvbnQtc2l6ZToxMXB0Ij7CoDwvc3Bhbj48dT48L3U+PHU+PC91PjwvcD4NCjxwIGNsYXNzPSJN
c29Ob3JtYWwiPjxzcGFuIHN0eWxlPSJjb2xvcjpyZ2IoMzEsNzMsMTI1KTtmb250LWZhbWlseTom
cXVvdDtDYWxpYnJpJnF1b3Q7LHNhbnMtc2VyaWY7Zm9udC1zaXplOjExcHQiPkkgd291bGQgZ3Vl
c3MuPC9zcGFuPjx1PjwvdT48dT48L3U+PC9wPg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+PHNwYW4g
c3R5bGU9ImNvbG9yOnJnYigzMSw3MywxMjUpO2ZvbnQtZmFtaWx5OiZxdW90O0NhbGlicmkmcXVv
dDssc2Fucy1zZXJpZjtmb250LXNpemU6MTFwdCI+wqA8L3NwYW4+PHU+PC91Pjx1PjwvdT48L3A+
DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj48c3BhbiBzdHlsZT0iY29sb3I6cmdiKDMxLDczLDEyNSk7
Zm9udC1mYW1pbHk6JnF1b3Q7Q2FsaWJyaSZxdW90OyxzYW5zLXNlcmlmO2ZvbnQtc2l6ZToxMXB0
Ij7CoDwvc3Bhbj48dT48L3U+PHU+PC91PjwvcD4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPjxzcGFu
IHN0eWxlPSJjb2xvcjpyZ2IoMzEsNzMsMTI1KTtmb250LWZhbWlseTomcXVvdDtDYWxpYnJpJnF1
b3Q7LHNhbnMtc2VyaWY7Zm9udC1zaXplOjExcHQiPsKgPC9zcGFuPjx1PjwvdT48dT48L3U+PC9w
Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+PHNwYW4gc3R5bGU9ImNvbG9yOnJnYigzMSw3MywxMjUp
O2ZvbnQtZmFtaWx5OiZxdW90O0NhbGlicmkmcXVvdDssc2Fucy1zZXJpZjtmb250LXNpemU6MTFw
dCI+wqA8L3NwYW4+PHU+PC91Pjx1PjwvdT48L3A+DQo8ZGl2IHN0eWxlPSJib3JkZXItd2lkdGg6
bWVkaXVtIG1lZGl1bSBtZWRpdW0gMS41cHQ7Ym9yZGVyLXN0eWxlOm5vbmUgbm9uZSBub25lIHNv
bGlkO2JvcmRlci1jb2xvcjpjdXJyZW50Q29sb3IgY3VycmVudENvbG9yIGN1cnJlbnRDb2xvciBi
bHVlO3BhZGRpbmc6MGluIDBpbiAwaW4gNHB0Ij4NCjxkaXY+DQo8ZGl2IHN0eWxlPSJib3JkZXIt
d2lkdGg6MXB0IG1lZGl1bSBtZWRpdW07Ym9yZGVyLXN0eWxlOnNvbGlkIG5vbmUgbm9uZTtib3Jk
ZXItY29sb3I6Y3VycmVudENvbG9yO3BhZGRpbmc6M3B0IDBpbiAwaW4iPg0KPHAgY2xhc3M9Ik1z
b05vcm1hbCI+PGI+PHNwYW4gc3R5bGU9ImZvbnQtZmFtaWx5OiZxdW90O0NhbGlicmkmcXVvdDss
c2Fucy1zZXJpZjtmb250LXNpemU6MTFwdCI+RnJvbTo8L3NwYW4+PC9iPjxzcGFuIHN0eWxlPSJm
b250LWZhbWlseTomcXVvdDtDYWxpYnJpJnF1b3Q7LHNhbnMtc2VyaWY7Zm9udC1zaXplOjExcHQi
PiBEZXZlbCBbbWFpbHRvOjxhIGhyZWY9Im1haWx0bzpkZXZlbC1ib3VuY2VzQGFjcGljYS5vcmci
IHRhcmdldD0iX2JsYW5rIj5kZXZlbC1ib3VuY2VzQGFjcGljYS48d2JyPm9yZzwvYT5dDQo8Yj5P
biBCZWhhbGYgT2YgPC9iPkRldmluIFN0ZWZmbGVyPGJyPg0KPGI+U2VudDo8L2I+IFRodXJzZGF5
LCBNYXkgMjUsIDIwMTcgNjoxNSBBTTxicj4NCjxiPlRvOjwvYj4gPGEgaHJlZj0ibWFpbHRvOmRl
dmVsQGFjcGljYS5vcmciIHRhcmdldD0iX2JsYW5rIj5kZXZlbEBhY3BpY2Eub3JnPC9hPjxicj4N
CjxiPlN1YmplY3Q6PC9iPiBbRGV2ZWxdIEhlbHAgbmVlZGVkIGZvciAmcXVvdDtBQ1BJIEVycm9y
OiBObyBoYW5kbGVyIGZvciBSZWdpb24gW0VDT1JdJnF1b3Q7ICh1c2luZyBteSBvd24gT1NMKTwv
c3Bhbj48dT48L3U+PHU+PC91PjwvcD4NCjwvZGl2Pg0KPC9kaXY+DQo8ZGl2Pg0KPGRpdj4NCjxw
IGNsYXNzPSJNc29Ob3JtYWwiPsKgPHU+PC91Pjx1PjwvdT48L3A+DQo8ZGl2Pg0KPHAgY2xhc3M9
Ik1zb05vcm1hbCI+SGVsbG8sPHU+PC91Pjx1PjwvdT48L3A+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1z
b05vcm1hbCI+wqA8dT48L3U+PHU+PC91PjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJN
c29Ob3JtYWwiPkkgYW0gd29ya2luZyBvbiBhbiBPU0wgZm9yIFFOWC4gSSBhbSBnZXR0aW5nIHNv
bWUgZXJyb3JzIHByaW50ZWQgb3V0IGR1cmluZ8KgQWNwaUluaXRpYWxpemVPYmplY3RzIGJ1dCBv
bmx5IGluIG9uZSBvdXQgb2YgdGhyZWUgbGFwdG9wcyB0aGF0IEkgYW0gdGVzdGluZy4gQSBEZWxs
IGFuZCBBU1VTIGxhcHRvcA0KIGRvIG5vdCBoYXZlIHRoZSBlcnJvcnMgYnV0IGEgTGVub3ZvIGxh
cHRvcCBkb2VzLiBJIGFtIGFibGUgdG8gcmVhZCBiYXR0ZXJ5IHN0YXR1cyAoX0JTVCkgb24gdGhl
IERlbGwgYW5kIEFTVVMgbGFwdG9wcyBidXQgbm90IG9uIHRoZSBMZW5vdm8gbGFwdG9wLjx1Pjwv
dT48dT48L3U+PC9wPg0KPC9kaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+wqA8dT48
L3U+PHU+PC91PjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPlRoZSBB
Q1BJQ0EgdmVyc2lvbiBJIGFtIHVzaW5nIGlzIDIwMTcwMzAzLjx1PjwvdT48dT48L3U+PC9wPg0K
PC9kaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+wqA8dT48L3U+PHU+PC91PjwvcD4N
CjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPlNvbWUgcXVlc3Rpb25zIEkgaGF2
ZSBhcmU6PHU+PC91Pjx1PjwvdT48L3A+DQo8L2Rpdj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9y
bWFsIj4tIElzIHRoaXMgdGhlIGNvcnJlY3QgbWFpbGluZyBsaXN0IGZvciB0aGlzIGVtYWlsPzx1
PjwvdT48dT48L3U+PC9wPg0KPC9kaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+LSBE
b2VzIHRoaXMgYXBwZWFyIHRvIGJlIGEgYnVnIGluIEFDUElDQSwgaW4gbXkgT1NMLCBvciBzb21l
d2hlcmUgZWxzZSAobWF5YmUgdGhlIGxhcHRvcCBCSU9TKT88dT48L3U+PHU+PC91PjwvcD4NCjwv
ZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPi0gU2hvdWxkIEkgcmFpc2UgYSBidWcg
Zm9yIHRoaXM/PHU+PC91Pjx1PjwvdT48L3A+DQo8L2Rpdj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNv
Tm9ybWFsIj4tIFdvdWxkIHlvdSBwcm92aWRlIGFueSByZWNvbW1lbmRhdGlvbnMgdG8gaGVscCBt
ZSB0cm91Ymxlc2hvb3QgdGhpcz88dT48L3U+PHU+PC91PjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxw
IGNsYXNzPSJNc29Ob3JtYWwiPi0gV2hhdCBvdGhlciBpbmZvcm1hdGlvbiBzaG91bGQgSSBwcm92
aWRlPzx1PjwvdT48dT48L3U+PC9wPg0KPC9kaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1h
bCI+wqA8dT48L3U+PHU+PC91PjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3Jt
YWwiPlRoaXMgaXMgdGhlIG91dHB1dCBkdXJpbmcgQUNQSSBpbml0aWFsaXphdGlvbiBvbiB0aGUg
cHJvYmxlbWF0aWMgbGFwdG9wIChmcm9tIG15IE9TTCk6PHU+PC91Pjx1PjwvdT48L3A+DQo8L2Rp
dj4NCjxkaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+LS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tPHdicj4tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS08d2JyPi0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLTx3YnI+LS0tLS0tPHU+PC91Pjx1PjwvdT48L3A+DQo8
L2Rpdj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj5BQ1BJOiBSU0RQIDB4MDAwMDAwMDAw
MDBGMDEyMCAwMDAwMjQgKHYwMiBMRU5PVk8pPHU+PC91Pjx1PjwvdT48L3A+DQo8L2Rpdj4NCjxk
aXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj5BQ1BJOiBYU0RUIDB4MDAwMDAwMDBEN0ZEMjE4OCAw
MDAwQ0MgKHYwMSBMRU5PVk8gVFAtUjAwIMKgIDAwMDAwMDAwIFBURUMgMDAwMDAwMDIpPHU+PC91
Pjx1PjwvdT48L3A+DQo8L2Rpdj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj5BQ1BJOiBG
QUNQIDB4MDAwMDAwMDBEN0ZGNzAwMCAwMDAwRjQgKHYwNSBMRU5PVk8gVFAtUjAwIMKgIDAwMDAw
NDIwIFBURUMgMDAwMDAwMDIpPHU+PC91Pjx1PjwvdT48L3A+DQo8L2Rpdj4NCjxkaXY+DQo8cCBj
bGFzcz0iTXNvTm9ybWFsIj5BQ1BJOiBEU0RUIDB4MDAwMDAwMDBEN0ZERTAwMCAwMTE0NTEgKHYw
MiBMRU5PVk8gVFAtUjAwIMKgIDAwMDAwNDIwIElOVEwgMjAxNDExMDcpPHU+PC91Pjx1PjwvdT48
L3A+DQo8L2Rpdj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj5BQ1BJOiBGQUNTIDB4MDAw
MDAwMDBEN0ZBMjAwMCAwMDAwNDA8dT48L3U+PHU+PC91PjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxw
IGNsYXNzPSJNc29Ob3JtYWwiPkFDUEk6IFVFRkkgMHgwMDAwMDAwMEQ3RkI5MDAwIDAwMDA0MiAo
djAxIExFTk9WTyBUUC1SMDAgwqAgMDAwMDA0MjAgUFRFQyAwMDAwMDAwMik8dT48L3U+PHU+PC91
PjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPkFDUEk6IFNTRFQgMHgw
MDAwMDAwMEQ3RkY4MDAwIDAwNEUwQSAodjAyIExFTk9WTyBTYVNzZHQgwqAgMDAwMDMwMDAgSU5U
TCAyMDE0MTEwNyk8dT48L3U+PHU+PC91PjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJN
c29Ob3JtYWwiPkFDUEk6IEFTRiEgMHgwMDAwMDAwMEQ3RkY2MDAwIDAwMDBBNSAodjMyIExFTk9W
TyBUUC1SMDAgwqAgMDAwMDA0MjAgUFRFQyAwMDAwMDAwMik8dT48L3U+PHU+PC91PjwvcD4NCjwv
ZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPkFDUEk6IEVDRFQgMHgwMDAwMDAwMEQ3
RkY1MDAwIDAwMDA1MiAodjAxIExFTk9WTyBUUC1SMDAgwqAgMDAwMDA0MjAgUFRFQyAwMDAwMDAw
Mik8dT48L3U+PHU+PC91PjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwi
PkFDUEk6IEhQRVQgMHgwMDAwMDAwMEQ3RkY0MDAwIDAwMDAzOCAodjAxIExFTk9WTyBUUC1SMDAg
wqAgMDAwMDA0MjAgUFRFQyAwMDAwMDAwMik8dT48L3U+PHU+PC91PjwvcD4NCjwvZGl2Pg0KPGRp
dj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPkFDUEk6IExQSVQgMHgwMDAwMDAwMEQ3RkYzMDAwIDAw
MDA5NCAodjAxIExFTk9WTyBUUC1SMDAgwqAgMDAwMDA0MjAgUFRFQyAwMDAwMDAwMik8dT48L3U+
PHU+PC91PjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPkFDUEk6IEFQ
SUMgMHgwMDAwMDAwMEQ3RkYyMDAwIDAwMDBCQyAodjAzIExFTk9WTyBUUC1SMDAgwqAgMDAwMDA0
MjAgUFRFQyAwMDAwMDAwMik8dT48L3U+PHU+PC91PjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNs
YXNzPSJNc29Ob3JtYWwiPkFDUEk6IE1DRkcgMHgwMDAwMDAwMEQ3RkYxMDAwIDAwMDAzQyAodjAx
IExFTk9WTyBUUC1SMDAgwqAgMDAwMDA0MjAgUFRFQyAwMDAwMDAwMik8dT48L3U+PHU+PC91Pjwv
cD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPkFDUEk6IFdEQVQgMHgwMDAw
MDAwMEQ3RkYwMDAwIDAwMDEzNCAodjAxIExFTk9WTyBUUC1SMDAgwqAgMDAwMDA0MjAgUFRFQyAw
MDAwMDAwMik8dT48L3U+PHU+PC91PjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29O
b3JtYWwiPkFDUEk6IFNTRFQgMHgwMDAwMDAwMEQ3RkRDMDAwIDAwMUFGQyAodjAxIExFTk9WTyBT
YXRhQWhjaSAwMDAwMTAwMCBJTlRMIDIwMTQxMTA3KTx1PjwvdT48dT48L3U+PC9wPg0KPC9kaXY+
DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+QUNQSTogREJHUCAweDAwMDAwMDAwRDdGREIw
MDAgMDAwMDM0ICh2MDEgTEVOT1ZPIFRQLVIwMCDCoCAwMDAwMDQyMCBQVEVDIDAwMDAwMDAyKTx1
PjwvdT48dT48L3U+PC9wPg0KPC9kaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+QUNQ
STogREJHMiAweDAwMDAwMDAwRDdGREEwMDAgMDAwMDU0ICh2MDAgTEVOT1ZPIFRQLVIwMCDCoCAw
MDAwMDQyMCBQVEVDIDAwMDAwMDAyKTx1PjwvdT48dT48L3U+PC9wPg0KPC9kaXY+DQo8ZGl2Pg0K
PHAgY2xhc3M9Ik1zb05vcm1hbCI+QUNQSTogQk9PVCAweDAwMDAwMDAwRDdGRDkwMDAgMDAwMDI4
ICh2MDEgTEVOT1ZPIFRQLVIwMCDCoCAwMDAwMDQyMCBQVEVDIDAwMDAwMDAyKTx1PjwvdT48dT48
L3U+PC9wPg0KPC9kaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+QUNQSTogQkFUQiAw
eDAwMDAwMDAwRDdGRDgwMDAgMDAwMDQ2ICh2MDEgTEVOT1ZPIFRQLVIwMCDCoCAwMDAwMDQyMCBQ
VEVDIDAwMDAwMDAyKTx1PjwvdT48dT48L3U+PC9wPg0KPC9kaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9
Ik1zb05vcm1hbCI+QUNQSTogU0xJQyAweDAwMDAwMDAwRDdGRDcwMDAgMDAwMTc2ICh2MDEgTEVO
T1ZPIFRQLVIwMCDCoCAwMDAwMDQyMCBQVEVDIDAwMDAwMDAyKTx1PjwvdT48dT48L3U+PC9wPg0K
PC9kaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+QUNQSTogU1NEVCAweDAwMDAwMDAw
RDdGRDYwMDAgMDAwRTU4ICh2MDIgTEVOT1ZPIENwdVNzZHQgwqAwMDAwMzAwMCBJTlRMIDIwMTQx
MTA3KTx1PjwvdT48dT48L3U+PC9wPg0KPC9kaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1h
bCI+QUNQSTogU1NEVCAweDAwMDAwMDAwRDdGRDUwMDAgMDAwM0Q5ICh2MDIgTEVOT1ZPIEN0ZHBC
IMKgIMKgMDAwMDEwMDAgSU5UTCAyMDE0MTEwNyk8dT48L3U+PHU+PC91PjwvcD4NCjwvZGl2Pg0K
PGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPkFDUEk6IE1TRE0gMHgwMDAwMDAwMEQ3RkQ0MDAw
IDAwMDA1NSAodjAzIExFTk9WTyBUUC1SMDAgwqAgMDAwMDA0MjAgUFRFQyAwMDAwMDAwMik8dT48
L3U+PHU+PC91PjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPkFDUEk6
IEZQRFQgMHgwMDAwMDAwMEQ3RkQzMDAwIDAwMDA0NCAodjAxIExFTk9WTyBUUC1SMDAgwqAgMDAw
MDA0MjAgUFRFQyAwMDAwMDAwMik8dT48L3U+PHU+PC91PjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxw
IGNsYXNzPSJNc29Ob3JtYWwiPkFDUEk6IFVFRkkgMHgwMDAwMDAwMEQ3RkEwMDAwIDAwMDEyQSAo
djAxIExFTk9WTyBUUC1SMDAgwqAgMDAwMDA0MjAgUFRFQyAwMDAwMDAwMik8dT48L3U+PHU+PC91
PjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPsKgPHU+PC91Pjx1Pjwv
dT48L3A+DQo8L2Rpdj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj5Jbml0aWFsaXppbmcg
TmFtZXNwYWNlIG9iamVjdHM6PHU+PC91Pjx1PjwvdT48L3A+DQo8L2Rpdj4NCjxkaXY+DQo8cCBj
bGFzcz0iTXNvTm9ybWFsIj5UYWJsZSBbRFNEVDogVFAtUjAwIMKgXSAoaWQgMDEpIC0gMjc1NyBP
YmplY3RzIHdpdGggwqA3NiBEZXZpY2VzLCDCoDQwIFJlZ2lvbnMsIMKgNTEwIE1ldGhvZHMgKDE0
MC8zNzAvMjQgU2VyaWFsL05vbi9DdnQpPHU+PC91Pjx1PjwvdT48L3A+DQo8L2Rpdj4NCjxkaXY+
DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj5UYWJsZSBbU1NEVDogU2FTc2R0IMKgXSAoaWQgMDIpIC0g
wqA1NTIgT2JqZWN0cyB3aXRoIMKgMTggRGV2aWNlcywgwqAyMCBSZWdpb25zLCDCoDEzMSBNZXRo
b2RzICg0MS85MC83IFNlcmlhbC9Ob24vQ3Z0KTx1PjwvdT48dT48L3U+PC9wPg0KPC9kaXY+DQo8
ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+VGFibGUgW1NTRFQ6IFNhdGFBaGNpXSAoaWQgMDMp
IC0gwqAxODMgT2JqZWN0cyB3aXRoIMKgIDggRGV2aWNlcywgwqAgMCBSZWdpb25zLCDCoCAzNCBN
ZXRob2RzICgyNS85LzUgU2VyaWFsL05vbi9DdnQpPHU+PC91Pjx1PjwvdT48L3A+DQo8L2Rpdj4N
CjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj5UYWJsZSBbU1NEVDogQ3B1U3NkdCBdIChpZCAw
NCkgLSDCoDExNCBPYmplY3RzIHdpdGggwqAgMCBEZXZpY2VzLCDCoCAzIFJlZ2lvbnMsIMKgIDI5
IE1ldGhvZHMgKDEzLzE2LzEzIFNlcmlhbC9Ob24vQ3Z0KTx1PjwvdT48dT48L3U+PC9wPg0KPC9k
aXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+VGFibGUgW1NTRFQ6IEN0ZHBCIMKgIF0g
KGlkIDA1KSAtIMKgIDMzIE9iamVjdHMgd2l0aCDCoCAwIERldmljZXMsIMKgIDEgUmVnaW9ucywg
wqAgwqA1IE1ldGhvZHMgKDIvMy8xIFNlcmlhbC9Ob24vQ3Z0KTx1PjwvdT48dT48L3U+PC9wPg0K
PC9kaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+QUNQSTogNSBBQ1BJIEFNTCB0YWJs
ZXMgc3VjY2Vzc2Z1bGx5IGFjcXVpcmVkIGFuZCBsb2FkZWQ8dT48L3U+PHU+PC91PjwvcD4NCjwv
ZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPkNvbXBsZXRpbmcgUmVnaW9uL0ZpZWxk
L0J1ZmZlci9QYWNrYWdlIGluaXRpYWxpemF0aW9uOjx1PjwvdT48dT48L3U+PC9wPg0KPC9kaXY+
DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+wqAgwqAgSW5pdGlhbGl6ZWQgNjMvNjQgUmVn
aW9ucyA3MS83MSBGaWVsZHMgODgvODggQnVmZmVycyA4My84MyBQYWNrYWdlcyAoMzY0OCBub2Rl
cyk8dT48L3U+PHU+PC91PjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwi
PsKgZXZ4ZmV2bnQtMDIxOCBFbmFibGUgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA6IFRyYW5zaXRp
b24gdG8gQUNQSSBtb2RlIHN1Y2Nlc3NmdWw8dT48L3U+PHU+PC91PjwvcD4NCjwvZGl2Pg0KPGRp
dj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPkluaXRpYWxpemluZyBHZW5lcmFsIFB1cnBvc2UgRXZl
bnRzIChHUEVzKTo8dT48L3U+PHU+PC91PjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJN
c29Ob3JtYWwiPsKgIMKgIEluaXRpYWxpemVkIEdQRSAwMCB0byA3RiBbX0dQRV0gMTYgcmVncyBv
biBpbnRlcnJ1cHQgMHg5IChTQ0kpPHU+PC91Pjx1PjwvdT48L3A+DQo8L2Rpdj4NCjxkaXY+DQo8
cCBjbGFzcz0iTXNvTm9ybWFsIj5Jbml0aWFsaXppbmcgRGV2aWNlL1Byb2Nlc3Nvci9UaGVybWFs
IG9iamVjdHMgYW5kIGV4ZWN1dGluZyBfSU5JL19TVEEgbWV0aG9kczo8dT48L3U+PHU+PC91Pjwv
cD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPkFDUEkgRXJyb3I6IE5vIGhh
bmRsZXIgZm9yIFJlZ2lvbiBbRUNPUl0gKDgwZGExMzApIFtFbWJlZGRlZENvbnRyb2xdICgyMDE3
MDMwMy9ldnJlZ2lvbi0yOTEpPHU+PC91Pjx1PjwvdT48L3A+DQo8L2Rpdj4NCjxkaXY+DQo8cCBj
bGFzcz0iTXNvTm9ybWFsIj5BQ1BJIEVycm9yOiBSZWdpb24gRW1iZWRkZWRDb250cm9sIChJRD0z
KSBoYXMgbm8gaGFuZGxlciAoMjAxNzAzMDMvZXhmbGRpby00MzEpPHU+PC91Pjx1PjwvdT48L3A+
DQo8L2Rpdj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj5BQ1BJIEVycm9yOiBNZXRob2Qg
cGFyc2UvZXhlY3V0aW9uIGZhaWxlZCBbXF9TQi5QQ0kwLkxQQy5FQy5BQy5fUFNSXSAoTm9kZSA4
MGQwYzMwKSwgQUVfTk9UX0VYSVNUICgyMDE3MDMwMy9wc3BhcnNlLTY2OCk8dT48L3U+PHU+PC91
PjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPkFDUEkgRXJyb3I6IE1l
dGhvZCBwYXJzZS9leGVjdXRpb24gZmFpbGVkIFtcX1NCLl9JTkldIChOb2RlIDgwZTRmNTApLCBB
RV9OT1RfRVhJU1QgKDIwMTcwMzAzL3BzcGFyc2UtNjY4KTx1PjwvdT48dT48L3U+PC9wPg0KPC9k
aXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+QUNQSSBFcnJvcjogTm8gaGFuZGxlciBm
b3IgUmVnaW9uIFtFQ09SXSAoODBkYTEzMCkgW0VtYmVkZGVkQ29udHJvbF0gKDIwMTcwMzAzL2V2
cmVnaW9uLTI5MSk8dT48L3U+PHU+PC91PjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJN
c29Ob3JtYWwiPkFDUEkgRXJyb3I6IFJlZ2lvbiBFbWJlZGRlZENvbnRyb2wgKElEPTMpIGhhcyBu
byBoYW5kbGVyICgyMDE3MDMwMy9leGZsZGlvLTQzMSk8dT48L3U+PHU+PC91PjwvcD4NCjwvZGl2
Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPkFDUEkgRXJyb3I6IE1ldGhvZCBwYXJzZS9l
eGVjdXRpb24gZmFpbGVkIFtcX1NCLlBDSTAuTFBDLkVDLl9JTkldIChOb2RlIDgwZDAwZDApLCBB
RV9OT1RfRVhJU1QgKDIwMTcwMzAzL3BzcGFyc2UtNjY4KTx1PjwvdT48dT48L3U+PC9wPg0KPC9k
aXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+QUNQSSBFeGNlcHRpb246IEFFX05PVF9F
WElTVCwgZHVyaW5nIFxfU0IuUENJMC5MUEMuRUMuX0lOSSBleGVjdXRpb24gKDIwMTcwMzAzL25z
aW5pdC04MDcpPHU+PC91Pjx1PjwvdT48L3A+DQo8L2Rpdj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNv
Tm9ybWFsIj7CoCDCoCBFeGVjdXRlZCAxMyBfSU5JIG1ldGhvZHMgcmVxdWlyaW5nIDEgX1NUQSBl
eGVjdXRpb25zIChleGFtaW5lZCAxMTMgb2JqZWN0cyk8dT48L3U+PHU+PC91PjwvcD4NCjwvZGl2
Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLTx3YnI+LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tPHdicj4tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS08d2JyPi0tLS0tLTx1PjwvdT48dT48L3U+PC9wPg0KPC9kaXY+DQo8
L2Rpdj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj7CoDx1PjwvdT48dT48L3U+PC9wPg0K
PC9kaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+VGhpcyBpcyB0aGUgb3V0cHV0IGZy
b20gY2FsbGluZyBBY3BpRXZhbHVhdGVPYmplY3QgZm9yIHRoZSBjb250cm9sIG1ldGhvZCAmcXVv
dDtcX1NCLlBDSTAuTFBDLkVDLkJBVDAuX0JTVCZxdW90Oywgd2hpY2ggcmV0dXJucyB3aXRoIEFF
X05PVF9FWElTVDo8dT48L3U+PHU+PC91PjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxkaXY+DQo8cCBj
bGFzcz0iTXNvTm9ybWFsIj4tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS08d2JyPi0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLTx3YnI+LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tPHdicj4tLS0tLS08dT48L3U+PHU+PC91PjwvcD4NCjwvZGl2Pg0KPC9kaXY+DQo8ZGl2Pg0K
PGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPkFDUEkgRXJyb3I6IE5vIGhhbmRsZXIgZm9yIFJl
Z2lvbiBbRUNPUl0gKDgwZGExMzApIFtFbWJlZGRlZENvbnRyb2xdICgyMDE3MDMwMy9ldnJlZ2lv
bi0yOTEpPHU+PC91Pjx1PjwvdT48L3A+DQo8L2Rpdj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9y
bWFsIj5BQ1BJIEVycm9yOiBSZWdpb24gRW1iZWRkZWRDb250cm9sIChJRD0zKSBoYXMgbm8gaGFu
ZGxlciAoMjAxNzAzMDMvZXhmbGRpby00MzEpPHU+PC91Pjx1PjwvdT48L3A+DQo8L2Rpdj4NCjxk
aXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj5BQ1BJIEVycm9yOiBNZXRob2QgcGFyc2UvZXhlY3V0
aW9uIGZhaWxlZCBbXF9TQi5QQ0kwLkxQQy5FQy5CQVQwLl9CU1RdIChOb2RlIDgwZDBiNzApLCBB
RV9OT1RfRVhJU1QgKDIwMTcwMzAzL3BzcGFyc2UtNjY4KTx1PjwvdT48dT48L3U+PC9wPg0KPC9k
aXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tPHdicj4tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS08d2JyPi0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLTx3YnI+LS0tLS0tPHU+PC91Pjx1PjwvdT48L3A+DQo8L2Rpdj4N
CjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPsKgPHU+PC91Pjx1PjwvdT48L3A+
DQo8L2Rpdj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj5UaGlzIGlzIHRoZSBvdXRwdXQg
ZnJvbSBleGVjdXRpbmcgdGhlIGNvbnRyb2wgbWV0aG9kIHVzaW5nIGFjcGlleGVjOjx1PjwvdT48
dT48L3U+PC9wPg0KPC9kaXY+DQo8ZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPi0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLTx3YnI+LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tPHdicj4tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS08d2JyPi0tLS0tLTx1Pjwv
dT48dT48L3U+PC9wPg0KPC9kaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+IyAuL2Fj
cGlleGVjICouZGF0PHU+PC91Pjx1PjwvdT48L3A+DQo8L2Rpdj4NCjxkaXY+DQo8cCBjbGFzcz0i
TXNvTm9ybWFsIj7CoDx1PjwvdT48dT48L3U+PC9wPg0KPC9kaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9
Ik1zb05vcm1hbCI+wqA8dT48L3U+PHU+PC91PjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNz
PSJNc29Ob3JtYWwiPkludGVsIEFDUEkgQ29tcG9uZW50IEFyY2hpdGVjdHVyZTx1PjwvdT48dT48
L3U+PC9wPg0KPC9kaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+QU1MIEV4ZWN1dGlv
bi9EZWJ1ZyBVdGlsaXR5IHZlcnNpb24gMjAxNzAzMDM8dT48L3U+PHU+PC91PjwvcD4NCjwvZGl2
Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPkNvcHlyaWdodCAoYykgMjAwMCAtIDIwMTcg
SW50ZWwgQ29ycG9yYXRpb248dT48L3U+PHU+PC91PjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNs
YXNzPSJNc29Ob3JtYWwiPsKgPHU+PC91Pjx1PjwvdT48L3A+DQo8L2Rpdj4NCjxkaXY+DQo8cCBj
bGFzcz0iTXNvTm9ybWFsIj5JbnB1dCBmaWxlIGFwaWMuZGF0LCBMZW5ndGggMHhCQyAoMTg4KSBi
eXRlczx1PjwvdT48dT48L3U+PC9wPg0KPC9kaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1h
bCI+SW5wdXQgZmlsZSBhc2YhLmRhdCwgTGVuZ3RoIDB4QTUgKDE2NSkgYnl0ZXM8dT48L3U+PHU+
PC91PjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPklucHV0IGZpbGUg
YmF0Yi5kYXQsIExlbmd0aCAweDQ2ICg3MCkgYnl0ZXM8dT48L3U+PHU+PC91PjwvcD4NCjwvZGl2
Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPklucHV0IGZpbGUgYm9vdC5kYXQsIExlbmd0
aCAweDI4ICg0MCkgYnl0ZXM8dT48L3U+PHU+PC91PjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNs
YXNzPSJNc29Ob3JtYWwiPklucHV0IGZpbGUgZGJnMi5kYXQsIExlbmd0aCAweDU0ICg4NCkgYnl0
ZXM8dT48L3U+PHU+PC91PjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwi
PklucHV0IGZpbGUgZGJncC5kYXQsIExlbmd0aCAweDM0ICg1MikgYnl0ZXM8dT48L3U+PHU+PC91
PjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPklucHV0IGZpbGUgZHNk
dC5kYXQsIExlbmd0aCAweDExNDUxICg3MDczNykgYnl0ZXM8dT48L3U+PHU+PC91PjwvcD4NCjwv
ZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPklucHV0IGZpbGUgZWNkdC5kYXQsIExl
bmd0aCAweDUyICg4MikgYnl0ZXM8dT48L3U+PHU+PC91PjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxw
IGNsYXNzPSJNc29Ob3JtYWwiPklucHV0IGZpbGUgZmFjcC5kYXQsIExlbmd0aCAweEY0ICgyNDQp
IGJ5dGVzPHU+PC91Pjx1PjwvdT48L3A+DQo8L2Rpdj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9y
bWFsIj5JbnB1dCBmaWxlIGZhY3MuZGF0LCBMZW5ndGggMHg0MCAoNjQpIGJ5dGVzPHU+PC91Pjx1
PjwvdT48L3A+DQo8L2Rpdj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj5JbnB1dCBmaWxl
IGZwZHQuZGF0LCBMZW5ndGggMHg0NCAoNjgpIGJ5dGVzPHU+PC91Pjx1PjwvdT48L3A+DQo8L2Rp
dj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj5JbnB1dCBmaWxlIGhwZXQuZGF0LCBMZW5n
dGggMHgzOCAoNTYpIGJ5dGVzPHU+PC91Pjx1PjwvdT48L3A+DQo8L2Rpdj4NCjxkaXY+DQo8cCBj
bGFzcz0iTXNvTm9ybWFsIj5JbnB1dCBmaWxlIGxwaXQuZGF0LCBMZW5ndGggMHg5NCAoMTQ4KSBi
eXRlczx1PjwvdT48dT48L3U+PC9wPg0KPC9kaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1h
bCI+SW5wdXQgZmlsZSBtY2ZnLmRhdCwgTGVuZ3RoIDB4M0MgKDYwKSBieXRlczx1PjwvdT48dT48
L3U+PC9wPg0KPC9kaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+SW5wdXQgZmlsZSBt
c2RtLmRhdCwgTGVuZ3RoIDB4NTUgKDg1KSBieXRlczx1PjwvdT48dT48L3U+PC9wPg0KPC9kaXY+
DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+SW5wdXQgZmlsZSBzbGljLmRhdCwgTGVuZ3Ro
IDB4MTc2ICgzNzQpIGJ5dGVzPHU+PC91Pjx1PjwvdT48L3A+DQo8L2Rpdj4NCjxkaXY+DQo8cCBj
bGFzcz0iTXNvTm9ybWFsIj5JbnB1dCBmaWxlIHNzZHQxLmRhdCwgTGVuZ3RoIDB4NEUwQSAoMTk5
NzgpIGJ5dGVzPHU+PC91Pjx1PjwvdT48L3A+DQo8L2Rpdj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNv
Tm9ybWFsIj5JbnB1dCBmaWxlIHNzZHQyLmRhdCwgTGVuZ3RoIDB4MUFGQyAoNjkwOCkgYnl0ZXM8
dT48L3U+PHU+PC91PjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPklu
cHV0IGZpbGUgc3NkdDMuZGF0LCBMZW5ndGggMHhFNTggKDM2NzIpIGJ5dGVzPHU+PC91Pjx1Pjwv
dT48L3A+DQo8L2Rpdj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj5JbnB1dCBmaWxlIHNz
ZHQ0LmRhdCwgTGVuZ3RoIDB4M0Q5ICg5ODUpIGJ5dGVzPHU+PC91Pjx1PjwvdT48L3A+DQo8L2Rp
dj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj5JbnB1dCBmaWxlIHVlZmkxLmRhdCwgTGVu
Z3RoIDB4NDIgKDY2KSBieXRlczx1PjwvdT48dT48L3U+PC9wPg0KPC9kaXY+DQo8ZGl2Pg0KPHAg
Y2xhc3M9Ik1zb05vcm1hbCI+SW5wdXQgZmlsZSB1ZWZpMi5kYXQsIExlbmd0aCAweDEyQSAoMjk4
KSBieXRlczx1PjwvdT48dT48L3U+PC9wPg0KPC9kaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05v
cm1hbCI+SW5wdXQgZmlsZSB3ZGF0LmRhdCwgTGVuZ3RoIDB4MTM0ICgzMDgpIGJ5dGVzPHU+PC91
Pjx1PjwvdT48L3A+DQo8L2Rpdj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj5JbnB1dCBm
aWxlIHhzZHQuZGF0LCBMZW5ndGggMHhDQyAoMjA0KSBieXRlczx1PjwvdT48dT48L3U+PC9wPg0K
PC9kaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+wqA8dT48L3U+PHU+PC91PjwvcD4N
CjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPkFDUEk6IFJTRFAgMHgwMDAwMDAw
MDA4MERCQ0UwIDAwMDAyNCAodjAyIEludGVsICk8dT48L3U+PHU+PC91PjwvcD4NCjwvZGl2Pg0K
PGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPkFDUEk6IFhTRFQgMHgwMDAwMDAwMDA4MEU3OEM4
IDAwMDBFNCAodjAwIEludGVsIMKgQWNwaUV4ZWMgMDAwMDEwMDEgSU5UTCAyMDE3MDMwMyk8dT48
L3U+PHU+PC91PjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPkFDUEk6
IEZBQ1AgMHgwMDAwMDAwMDA4MEVBNTUwIDAwMDBGNCAodjA1IExFTk9WTyBUUC1SMDAgwqAgMDAw
MDA0MjAgUFRFQyAwMDAwMDAwMik8dT48L3U+PHU+PC91PjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxw
IGNsYXNzPSJNc29Ob3JtYWwiPkFDUEk6IERTRFQgMHgwMDAwMDAwMDA4MEVGMDIwIDAxMTQ1MSAo
djAyIExFTk9WTyBUUC1SMDAgwqAgMDAwMDA0MjAgSU5UTCAyMDE0MTEwNyk8dT48L3U+PHU+PC91
PjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPkFDUEk6IEZBQ1MgMHgw
MDAwMDAwMDA4MERCRDIwIDAwMDA0MDx1PjwvdT48dT48L3U+PC9wPg0KPC9kaXY+DQo8ZGl2Pg0K
PHAgY2xhc3M9Ik1zb05vcm1hbCI+QUNQSTogQVBJQyAweDAwMDAwMDAwMDgwRUE3MDggMDAwMEJD
ICh2MDMgTEVOT1ZPIFRQLVIwMCDCoCAwMDAwMDQyMCBQVEVDIDAwMDAwMDAyKTx1PjwvdT48dT48
L3U+PC9wPg0KPC9kaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+QUNQSTogQVNGISAw
eDAwMDAwMDAwMDgwRUE2NTAgMDAwMEE1ICh2MzIgTEVOT1ZPIFRQLVIwMCDCoCAwMDAwMDQyMCBQ
VEVDIDAwMDAwMDAyKTx1PjwvdT48dT48L3U+PC9wPg0KPC9kaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9
Ik1zb05vcm1hbCI+QUNQSTogQkFUQiAweDAwMDAwMDAwMDgwRTMwQTggMDAwMDQ2ICh2MDEgTEVO
T1ZPIFRQLVIwMCDCoCAwMDAwMDQyMCBQVEVDIDAwMDAwMDAyKTx1PjwvdT48dT48L3U+PC9wPg0K
PC9kaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+QUNQSTogQk9PVCAweDAwMDAwMDAw
MDgwRTAxRDggMDAwMDI4ICh2MDEgTEVOT1ZPIFRQLVIwMCDCoCAwMDAwMDQyMCBQVEVDIDAwMDAw
MDAyKTx1PjwvdT48dT48L3U+PC9wPg0KPC9kaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1h
bCI+QUNQSTogREJHMiAweDAwMDAwMDAwMDgwRTIxRjAgMDAwMDU0ICh2MDAgTEVOT1ZPIFRQLVIw
MCDCoCAwMDAwMDQyMCBQVEVDIDAwMDAwMDAyKTx1PjwvdT48dT48L3U+PC9wPg0KPC9kaXY+DQo8
ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+QUNQSTogREJHUCAweDAwMDAwMDAwMDgwRTEyRDgg
MDAwMDM0ICh2MDEgTEVOT1ZPIFRQLVIwMCDCoCAwMDAwMDQyMCBQVEVDIDAwMDAwMDAyKTx1Pjwv
dT48dT48L3U+PC9wPg0KPC9kaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+QUNQSTog
RUNEVCAweDAwMDAwMDAwMDgwRTIyNTggMDAwMDUyICh2MDEgTEVOT1ZPIFRQLVIwMCDCoCAwMDAw
MDQyMCBQVEVDIDAwMDAwMDAyKTx1PjwvdT48dT48L3U+PC9wPg0KPC9kaXY+DQo8ZGl2Pg0KPHAg
Y2xhc3M9Ik1zb05vcm1hbCI+QUNQSTogRkFDUyAweDAwMDAwMDAwMDgwRTEzMjAgMDAwMDQwPHU+
PC91Pjx1PjwvdT48L3A+DQo8L2Rpdj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj5BQ1BJ
OiBGUERUIDB4MDAwMDAwMDAwODBFMzEwMCAwMDAwNDQgKHYwMSBMRU5PVk8gVFAtUjAwIMKgIDAw
MDAwNDIwIFBURUMgMDAwMDAwMDIpPHU+PC91Pjx1PjwvdT48L3A+DQo8L2Rpdj4NCjxkaXY+DQo8
cCBjbGFzcz0iTXNvTm9ybWFsIj5BQ1BJOiBIUEVUIDB4MDAwMDAwMDAwODBFMTM2OCAwMDAwMzgg
KHYwMSBMRU5PVk8gVFAtUjAwIMKgIDAwMDAwNDIwIFBURUMgMDAwMDAwMDIpPHU+PC91Pjx1Pjwv
dT48L3A+DQo8L2Rpdj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj5BQ1BJOiBMUElUIDB4
MDAwMDAwMDAwODBFQTRCMCAwMDAwOTQgKHYwMSBMRU5PVk8gVFAtUjAwIMKgIDAwMDAwNDIwIFBU
RUMgMDAwMDAwMDIpPHU+PC91Pjx1PjwvdT48L3A+DQo8L2Rpdj4NCjxkaXY+DQo8cCBjbGFzcz0i
TXNvTm9ybWFsIj5BQ1BJOiBNQ0ZHIDB4MDAwMDAwMDAwODBFMTNCMCAwMDAwM0MgKHYwMSBMRU5P
Vk8gVFAtUjAwIMKgIDAwMDAwNDIwIFBURUMgMDAwMDAwMDIpPHU+PC91Pjx1PjwvdT48L3A+DQo8
L2Rpdj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj5BQ1BJOiBNU0RNIDB4MDAwMDAwMDAw
ODBFMjJDMCAwMDAwNTUgKHYwMyBMRU5PVk8gVFAtUjAwIMKgIDAwMDAwNDIwIFBURUMgMDAwMDAw
MDIpPHU+PC91Pjx1PjwvdT48L3A+DQo8L2Rpdj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFs
Ij5BQ1BJOiBTTElDIDB4MDAwMDAwMDAwODBFQTMyOCAwMDAxNzYgKHYwMSBMRU5PVk8gVFAtUjAw
IMKgIDAwMDAwNDIwIFBURUMgMDAwMDAwMDIpPHU+PC91Pjx1PjwvdT48L3A+DQo8L2Rpdj4NCjxk
aXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj5BQ1BJOiBTU0RUIDB4MDAwMDAwMDAwODEwMTAyMCAw
MDRFMEEgKHYwMiBMRU5PVk8gU2FTc2R0IMKgIDAwMDAzMDAwIElOVEwgMjAxNDExMDcpPHU+PC91
Pjx1PjwvdT48L3A+DQo8L2Rpdj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj5BQ1BJOiBT
U0RUIDB4MDAwMDAwMDAwODBFODgyMCAwMDFBRkMgKHYwMSBMRU5PVk8gU2F0YUFoY2kgMDAwMDEw
MDAgSU5UTCAyMDE0MTEwNyk8dT48L3U+PHU+PC91PjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNs
YXNzPSJNc29Ob3JtYWwiPkFDUEk6IFNTRFQgMHgwMDAwMDAwMDA4MEU3OUI4IDAwMEU1OCAodjAy
IExFTk9WTyBDcHVTc2R0IMKgMDAwMDMwMDAgSU5UTCAyMDE0MTEwNyk8dT48L3U+PHU+PC91Pjwv
cD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPkFDUEk6IFNTRFQgMHgwMDAw
MDAwMDA4MEVBN0QwIDAwMDNEOSAodjAyIExFTk9WTyBDdGRwQiDCoCDCoDAwMDAxMDAwIElOVEwg
MjAxNDExMDcpPHU+PC91Pjx1PjwvdT48L3A+DQo8L2Rpdj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNv
Tm9ybWFsIj5BQ1BJOiBVRUZJIDB4MDAwMDAwMDAwODBFMzE1OCAwMDAwNDIgKHYwMSBMRU5PVk8g
VFAtUjAwIMKgIDAwMDAwNDIwIFBURUMgMDAwMDAwMDIpPHU+PC91Pjx1PjwvdT48L3A+DQo8L2Rp
dj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj5BQ1BJOiBVRUZJIDB4MDAwMDAwMDAwODBF
NzQ3MCAwMDAxMkEgKHYwMSBMRU5PVk8gVFAtUjAwIMKgIDAwMDAwNDIwIFBURUMgMDAwMDAwMDIp
PHU+PC91Pjx1PjwvdT48L3A+DQo8L2Rpdj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj5B
Q1BJOiBXREFUIDB4MDAwMDAwMDAwODBFNzMzMCAwMDAxMzQgKHYwMSBMRU5PVk8gVFAtUjAwIMKg
IDAwMDAwNDIwIFBURUMgMDAwMDAwMDIpPHU+PC91Pjx1PjwvdT48L3A+DQo8L2Rpdj4NCjxkaXY+
DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj5BQ1BJOiBYU0RUIDB4MDAwMDAwMDAwODBFNzIzMCAwMDAw
Q0MgKHYwMSBMRU5PVk8gVFAtUjAwIMKgIDAwMDAwMDAwIFBURUMgMDAwMDAwMDIpPHU+PC91Pjx1
PjwvdT48L3A+DQo8L2Rpdj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj5Jbml0aWFsaXpp
bmcgR2VuZXJhbCBQdXJwb3NlIEV2ZW50cyAoR1BFcyk6PHU+PC91Pjx1PjwvdT48L3A+DQo8L2Rp
dj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj7CoCDCoCBJbml0aWFsaXplZCBHUEUgMDAg
dG8gN0YgW19HUEVdIDE2IHJlZ3Mgb24gaW50ZXJydXB0IDB4OSAoU0NJKTx1PjwvdT48dT48L3U+
PC9wPg0KPC9kaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+wqA8dT48L3U+PHU+PC91
PjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPkluaXRpYWxpemluZyBO
YW1lc3BhY2Ugb2JqZWN0czo8dT48L3U+PHU+PC91PjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNs
YXNzPSJNc29Ob3JtYWwiPlRhYmxlIFtEU0RUOiBUUC1SMDAgwqBdIChpZCAwMSkgLSAyNzU3IE9i
amVjdHMgd2l0aCDCoDc2IERldmljZXMsIMKgNDAgUmVnaW9ucywgwqA1MTAgTWV0aG9kcyAoMTQw
LzM3MC8yNCBTZXJpYWwvTm9uL0N2dCk8dT48L3U+PHU+PC91PjwvcD4NCjwvZGl2Pg0KPGRpdj4N
CjxwIGNsYXNzPSJNc29Ob3JtYWwiPlRhYmxlIFtTU0RUOiBTYVNzZHQgwqBdIChpZCAwMikgLSDC
oDU1MiBPYmplY3RzIHdpdGggwqAxOCBEZXZpY2VzLCDCoDIwIFJlZ2lvbnMsIMKgMTMxIE1ldGhv
ZHMgKDQxLzkwLzcgU2VyaWFsL05vbi9DdnQpPHU+PC91Pjx1PjwvdT48L3A+DQo8L2Rpdj4NCjxk
aXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj5UYWJsZSBbU1NEVDogU2F0YUFoY2ldIChpZCAwMykg
LSDCoDE4MyBPYmplY3RzIHdpdGggwqAgOCBEZXZpY2VzLCDCoCAwIFJlZ2lvbnMsIMKgIDM0IE1l
dGhvZHMgKDI1LzkvNSBTZXJpYWwvTm9uL0N2dCk8dT48L3U+PHU+PC91PjwvcD4NCjwvZGl2Pg0K
PGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPlRhYmxlIFtTU0RUOiBDcHVTc2R0IF0gKGlkIDA0
KSAtIMKgMTE0IE9iamVjdHMgd2l0aCDCoCAwIERldmljZXMsIMKgIDMgUmVnaW9ucywgwqAgMjkg
TWV0aG9kcyAoMTMvMTYvMTMgU2VyaWFsL05vbi9DdnQpPHU+PC91Pjx1PjwvdT48L3A+DQo8L2Rp
dj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj5UYWJsZSBbU1NEVDogQ3RkcEIgwqAgXSAo
aWQgMDUpIC0gwqAgMzMgT2JqZWN0cyB3aXRoIMKgIDAgRGV2aWNlcywgwqAgMSBSZWdpb25zLCDC
oCDCoDUgTWV0aG9kcyAoMi8zLzEgU2VyaWFsL05vbi9DdnQpPHU+PC91Pjx1PjwvdT48L3A+DQo8
L2Rpdj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj5BQ1BJOiA1IEFDUEkgQU1MIHRhYmxl
cyBzdWNjZXNzZnVsbHkgYWNxdWlyZWQgYW5kIGxvYWRlZDx1PjwvdT48dT48L3U+PC9wPg0KPC9k
aXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+wqA8dT48L3U+PHU+PC91PjwvcD4NCjwv
ZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPkNvbXBsZXRpbmcgUmVnaW9uL0ZpZWxk
L0J1ZmZlci9QYWNrYWdlIGluaXRpYWxpemF0aW9uOjx1PjwvdT48dT48L3U+PC9wPg0KPC9kaXY+
DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+wqAgwqAgSW5pdGlhbGl6ZWQgNjMvNjQgUmVn
aW9ucyA3MS83MSBGaWVsZHMgODgvODggQnVmZmVycyA4My84MyBQYWNrYWdlcyAoMzY0OCBub2Rl
cyk8dT48L3U+PHU+PC91PjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwi
PkluaXRpYWxpemluZyBEZXZpY2UvUHJvY2Vzc29yL1RoZXJtYWwgb2JqZWN0cyBhbmQgZXhlY3V0
aW5nIF9JTkkvX1NUQSBtZXRob2RzOjx1PjwvdT48dT48L3U+PC9wPg0KPC9kaXY+DQo8ZGl2Pg0K
PHAgY2xhc3M9Ik1zb05vcm1hbCI+W0FjcGlFeGVjXSBFeGNlcHRpb24gQUVfQU1MX0lORklOSVRF
X0xPT1AgZHVyaW5nIGV4ZWN1dGlvbiBvZiBtZXRob2QgW1NNSV9dIE9wY29kZSBbV2hpbGVdIEA0
NDx1PjwvdT48dT48L3U+PC9wPg0KPC9kaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+
W1NNSV9dIEAwMDAzNCAjMDBBMjogwqBXaGlsZSAoPHU+PC91Pjx1PjwvdT48L3A+DQo8L2Rpdj4N
CjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj5ObyBMb2NhbCBWYXJpYWJsZXMgYXJlIGluaXRp
YWxpemVkIGZvciBtZXRob2QgW1NNSV9dPHU+PC91Pjx1PjwvdT48L3A+DQo8L2Rpdj4NCjxkaXY+
DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj7CoDx1PjwvdT48dT48L3U+PC9wPg0KPC9kaXY+DQo8ZGl2
Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+SW5pdGlhbGl6ZWQgQXJndW1lbnRzIGZvciBNZXRob2Qg
W1NNSV9dOiDCoCgwIGFyZ3VtZW50cyBkZWZpbmVkIGZvciBtZXRob2QgaW52b2NhdGlvbik8dT48
L3U+PHU+PC91PjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPsKgIMKg
IEFyZzA6IMKgIDgxZWNjNDAgJmx0O09iaiZndDsgwqAgwqAgwqAgwqAgwqAgwqAgSW50ZWdlciAw
MDAwMDAwMDAwMDAwMDA5PHU+PC91Pjx1PjwvdT48L3A+DQo8L2Rpdj4NCjxkaXY+DQo8cCBjbGFz
cz0iTXNvTm9ybWFsIj7CoCDCoCBBcmcxOiDCoCA4MWVjYTM4ICZsdDtPYmomZ3Q7IMKgIMKgIMKg
IMKgIMKgIMKgIEludGVnZXIgMDAwMDAwMDAwMDAwMDAwMTx1PjwvdT48dT48L3U+PC9wPg0KPC9k
aXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+wqAgwqAgQXJnMjogwqAgODFlY2JkOCAm
bHQ7T2JqJmd0OyDCoCDCoCDCoCDCoCDCoCDCoCBJbnRlZ2VyIDAwMDAwMDAwMDAwMDAwMDA8dT48
L3U+PHU+PC91PjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPsKgIMKg
IEFyZzM6IMKgIDgxZWM5ZDAgJmx0O09iaiZndDsgwqAgwqAgwqAgwqAgwqAgwqAgSW50ZWdlciAw
MDAwMDAwMDAwMDAwMDAwPHU+PC91Pjx1PjwvdT48L3A+DQo8L2Rpdj4NCjxkaXY+DQo8cCBjbGFz
cz0iTXNvTm9ybWFsIj7CoCDCoCBBcmc0OiDCoCA4MWVjYjA4ICZsdDtPYmomZ3Q7IMKgIMKgIMKg
IMKgIMKgIMKgIEludGVnZXIgMDAwMDAwMDAwMDAwMDAwMDx1PjwvdT48dT48L3U+PC9wPg0KPC9k
aXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+wqA8dT48L3U+PHU+PC91PjwvcD4NCjwv
ZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPkFDUEkgRXJyb3I6IE1ldGhvZCBwYXJz
ZS9leGVjdXRpb24gZmFpbGVkIFtcU01JXSAoTm9kZSA4MTRkZTQwKSwgQUVfQU1MX0lORklOSVRF
X0xPT1AgKDIwMTcwMzAzL3BzcGFyc2UtNjY4KTx1PjwvdT48dT48L3U+PC9wPg0KPC9kaXY+DQo8
ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+QUNQSSBFcnJvcjogTWV0aG9kIHBhcnNlL2V4ZWN1
dGlvbiBmYWlsZWQgW1xXR1NWXSAoTm9kZSA4MTRlOTc4KSwgQUVfQU1MX0lORklOSVRFX0xPT1Ag
KDIwMTcwMzAzL3BzcGFyc2UtNjY4KTx1PjwvdT48dT48L3U+PC9wPg0KPC9kaXY+DQo8ZGl2Pg0K
PHAgY2xhc3M9Ik1zb05vcm1hbCI+QUNQSSBFcnJvcjogTWV0aG9kIHBhcnNlL2V4ZWN1dGlvbiBm
YWlsZWQgW1xfU0IuUENJMC5MUEMuRUMuSEtFWS5XR0lOXSAoTm9kZSA4MTQzODEwKSwgQUVfQU1M
X0lORklOSVRFX0xPT1AgKDIwMTcwMzAzL3BzcGFyc2UtNjY4KTx1PjwvdT48dT48L3U+PC9wPg0K
PC9kaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+QUNQSSBFcnJvcjogTWV0aG9kIHBh
cnNlL2V4ZWN1dGlvbiBmYWlsZWQgW1xfU0IuUENJMC5MUEMuRUMuX0lOSV0gKE5vZGUgODEyMWFl
MCksIEFFX0FNTF9JTkZJTklURV9MT09QICgyMDE3MDMwMy9wc3BhcnNlLTY2OCk8dT48L3U+PHU+
PC91PjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPkFDUEkgRXhjZXB0
aW9uOiBBRV9BTUxfSU5GSU5JVEVfTE9PUCwgZHVyaW5nIFxfU0IuUENJMC5MUEMuRUMuX0lOSSBl
eGVjdXRpb24gKDIwMTcwMzAzL25zaW5pdC04MDcpPHU+PC91Pjx1PjwvdT48L3A+DQo8L2Rpdj4N
CjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj7CoCDCoCBFeGVjdXRlZCAxNCBfSU5JIG1ldGhv
ZHMgcmVxdWlyaW5nIDEgX1NUQSBleGVjdXRpb25zIChleGFtaW5lZCAxMTMgb2JqZWN0cyk8dT48
L3U+PHU+PC91PjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPi0gZXhl
Y3V0ZSBcX1NCLlBDSTAuTFBDLkVDLkJBVDAuX0JTVDx1PjwvdT48dT48L3U+PC9wPg0KPC9kaXY+
DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+RXZhbHVhdGluZyBcX1NCLlBDSTAuTFBDLkVD
LkJBVDAuX0JTVDx1PjwvdT48dT48L3U+PC9wPg0KPC9kaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1z
b05vcm1hbCI+MHg0IE91dHN0YW5kaW5nIGFsbG9jYXRpb25zIGFmdGVyIGV2YWx1YXRpb24gb2Yg
XF9TQi5QQ0kwLkxQQy5FQy5CQVQwLl9CU1Q8dT48L3U+PHU+PC91PjwvcD4NCjwvZGl2Pg0KPGRp
dj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPkV2YWx1YXRpb24gb2YgXF9TQi5QQ0kwLkxQQy5FQy5C
QVQwLl9CU1QgcmV0dXJuZWQgb2JqZWN0IDgwZWFmZjAsIGV4dGVybmFsIGJ1ZmZlciBsZW5ndGgg
Nzg8dT48L3U+PHU+PC91PjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwi
PsKgIFtQYWNrYWdlXSBDb250YWlucyA0IEVsZW1lbnRzOjx1PjwvdT48dT48L3U+PC9wPg0KPC9k
aXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+wqAgwqAgW0ludGVnZXJdID0gMDAwMDAw
MDAwMDAwMDAwNDx1PjwvdT48dT48L3U+PC9wPg0KPC9kaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1z
b05vcm1hbCI+wqAgwqAgW0ludGVnZXJdID0gMDAwMDAwMDAwMDAwMDAwMDx1PjwvdT48dT48L3U+
PC9wPg0KPC9kaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+wqAgwqAgW0ludGVnZXJd
ID0gMDAwMDAwMDAwMDAwMDAwMDx1PjwvdT48dT48L3U+PC9wPg0KPC9kaXY+DQo8ZGl2Pg0KPHAg
Y2xhc3M9Ik1zb05vcm1hbCI+wqAgwqAgW0ludGVnZXJdID0gMDAwMDAwMDAwMDAwMDAwMDx1Pjwv
dT48dT48L3U+PC9wPg0KPC9kaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+LSBxPHU+
PC91Pjx1PjwvdT48L3A+DQo8L2Rpdj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj4tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS08d2JyPi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLTx3YnI+LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tPHdicj4tLS0tLS08dT48L3U+
PHU+PC91PjwvcD4NCjwvZGl2Pg0KPC9kaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+
wqA8dT48L3U+PHU+PC91PjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwi
Pk5vdGU6IEkgdHJpZWQgcnVubmluZyBMaW51eCBvbiB0aGUgTGVub3ZvIGxhcHRvcCBhbmQgaXQg
Y2FuIHJlYWQgdGhlIGJhdHRlcnkgc3RhdHVzIG9rLjx1PjwvdT48dT48L3U+PC9wPg0KPC9kaXY+
DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+wqA8dT48L3U+PHU+PC91PjwvcD4NCjwvZGl2
Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPlRoYW5rIHlvdSw8dT48L3U+PHU+PC91Pjwv
cD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPkRldmluPHU+PC91Pjx1Pjwv
dT48L3A+DQo8L2Rpdj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj7CoDx1PjwvdT48dT48
L3U+PC9wPg0KPC9kaXY+DQo8L2Rpdj4NCjwvZGl2Pg0KPC9kaXY+DQo8L2Rpdj4NCjwvZGl2Pg0K
PC9kaXY+DQo8L2Jsb2NrcXVvdGU+DQo8L2Rpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPjx1Pjwv
dT7CoDx1PjwvdT48L3A+DQo8L2Rpdj4NCjwvZGl2Pg0KPC9kaXY+PC9kaXY+PC9kaXY+DQo8L2Rp
dj4NCjwvZGl2Pg0KDQo8L2Jsb2NrcXVvdGU+PC9kaXY+PGJyPjwvZGl2Pg0K

--===============2982061126617310527==--

