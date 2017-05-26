Content-Type: multipart/mixed; boundary="===============6597612541432853578=="
MIME-Version: 1.0
From: Devin Steffler <devinsteffler at gmail.com>
Subject: Re: [Devel] Help needed for "ACPI Error: No handler for Region
 [ECOR]" (using my own OSL)
Date: Fri, 26 May 2017 08:41:48 -0400
Message-ID: <CAAuRk_hHQDnEMFg0CA41Vv1KaGdiVNLQdeRA8ideZS=zFNJwEg@mail.gmail.com>
In-Reply-To: CAAuRk_gutpzw+ZsSA4GZw+ceGE53YYLS-LUHoK0+aTq5Jtq8Vw@mail.gmail.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============6597612541432853578==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

I have not yet heard back from Will but I did find the following section in
the Programmer Reference:
3.2.7.1 Installation of Address Space Handlers

So I'll try using the function AcpiInstallAddressSpaceHandler to install a
handler for the EC operation region.

Thanks,
Devin


On Thu, May 25, 2017 at 4:42 PM, Devin Steffler <devinsteffler(a)gmail.com>
wrote:

> I agree with you. It should be supported by QNX but I don't think that it
> is supported "out of the box". I searched their website/forums and couldn=
't
> find anything related to this. I will ask around here and see if I can get
> a formal QNX support contact to find out for certain (but I was told not =
to
> hold my breath when contacting QNX for support).
>
> As far as I can tell, QNX only has "barebones" support for ACPI, i.e. only
> what is needed to get a system to boot.
>
> I saw that the ACPICA already has code for QNX and found that it was added
> by Will Miles:
> https://github.com/acpica/acpica/commit/37a1dec2
>
> I'll try emailing Will to see if he can shed some light on this. If he had
> to write his own OSL for QNX then I suspect that he would not be able to
> share it (as it's likely owned by his company).
>
> If the EC driver that I need is the same as this one for Linux, then I
> should be able to write one myself for QNX:
> http://elixir.free-electrons.com/linux/latest/source/drivers/acpi/ec.c
>
> However, at this time I'm not sure how I would inform ACPICA to use my
> custom QNX EC driver. How would I go about registering the driver with
> ACPICA so that it knows what functions to call? I don't see anything in t=
he
> ACPICA User Guide and Programmer Reference for this. The only Acpi* metho=
ds
> from the ACPICA with "register" in them are AcpiReadBitRegister and
> AcpiWriteBitRegister. Should there be something for registering a driver
> for an operation region?
>
> Thanks again,
> Devin
>
>
>
>
>
>
> On Thu, May 25, 2017 at 3:47 PM, Moore, Robert <robert.moore(a)intel.com>
> wrote:
>
>> I just looked into the ACPICA source, and yes, it appears that QNX uses
>> ACPICA:
>>
>>
>>
>> #ifndef __ACQNX_H__
>>
>> #define __ACQNX_H__
>>
>>
>>
>> #define ACPI_USE_STANDARD_HEADERS
>>
>> #define ACPI_USE_SYSTEM_CLIBRARY
>>
>>
>>
>> #define ACPI_UINTPTR_T          uintptr_t
>>
>> #define ACPI_USE_LOCAL_CACHE
>>
>> #define ACPI_CAST_PTHREAD_T(x)  ((ACPI_THREAD_ID) ACPI_TO_INTEGER (x))
>>
>>
>>
>> /* At present time (QNX 6.6) all supported architectures are 32 bits. */
>>
>> #define ACPI_MACHINE_WIDTH      32
>>
>>
>>
>> Which means that the ACPICA-to-QNX OSL interface layer already exists.
>>
>>
>>
>> *From:* Devel [mailto:devel-bounces(a)acpica.org] *On Behalf Of *Moore,
>> Robert
>> *Sent:* Thursday, May 25, 2017 12:41 PM
>> *To:* Devin Steffler <devinsteffler(a)gmail.com>
>>
>> *Cc:* devel(a)acpica.org
>> *Subject:* Re: [Devel] Help needed for "ACPI Error: No handler for
>> Region [ECOR]" (using my own OSL)
>>
>>
>>
>> I can=E2=80=99t speak for QNX, but the EC driver would be part of it. It=
 has
>> nothing to do with your OSL.
>>
>>
>>
>> I=E2=80=99m not sure why you have to write your own OSL, this should alr=
eady be
>> part of QNX, assuming that it has ACPI support, and uses ACPICA as the
>> underlying ACPI software.
>>
>>
>>
>> To put this more succinctly:  ACPICA provides the underlying
>> infrastructure for ACPI support in an OS. But, the OS must provide its o=
wn
>> ACPI-related drivers and other ACPI support. The EC driver is one of the=
se
>> ACPI-related drivers.
>>
>>
>>
>> Bob
>>
>>
>>
>>
>>
>> *From:* Devin Steffler [mailto:devinsteffler(a)gmail.com
>> <devinsteffler(a)gmail.com>]
>> *Sent:* Thursday, May 25, 2017 7:48 AM
>> *To:* Moore, Robert <robert.moore(a)intel.com>
>> *Cc:* devel(a)acpica.org
>> *Subject:* Re: [Devel] Help needed for "ACPI Error: No handler for
>> Region [ECOR]" (using my own OSL)
>>
>>
>>
>> Hi Robert,
>>
>>
>>
>> Thanks for your insight.
>>
>>
>>
>> How can I find out whether is it a missing EC driver or the EC driver
>> is failing to install a handler for the EC operation region?
>>
>>
>>
>> Is the EC driver some C code that I would be expected to write as part of
>> the OSL or is it expected to be included with the OS (QNX in this case)?
>>
>>
>>
>> I suspect that the problem is somewhere in my OSL (since I'm very new to
>> ACPI). Do you think this is likely the case? What should I focus on to
>> debug my OSL if this is the case?
>>
>>
>>
>> Here's an excerpt from the Lenovo's DSDT.dsl (hoping it helps):
>>
>> ------------------------------------------------------------
>> -----------------------------------
>>
>>                 Device (EC)
>>                 {
>>                     Name (_HID, EisaId ("PNP0C09") /* Embedded Controller
>> Device */)  // _HID: Hardware ID
>>                     Name (_UID, 0x00)  // _UID: Unique ID
>>                     Name (_GPE, 0x20)  // _GPE: General Purpose Events
>>                     Method (_REG, 2, NotSerialized)  // _REG: Region
>> Availability
>>                     {
>>                         If ((Arg0 =3D=3D 0x03))
>>                         {
>>                             \H8DR =3D Arg1
>>                         }
>>                     }
>>
>>                     OperationRegion (ECOR, EmbeddedControl, 0x00, 0x0100)
>>                     Field (ECOR, ByteAcc, NoLock, Preserve)
>>                     {
>>                         HDBM,   1,
>>                             ,   1,
>>                         HKLK,   1,
>>                         HFNE,   1,
>>                             ,   1,
>>                             ,   1,
>>                         HLDM,   1,
>>                         Offset (0x01),
>>                         BBLS,   1,
>>                         BTCM,   1,
>>                             ,   1,
>>                             ,   1,
>>                             ,   1,
>>                         HBPR,   1,
>>                         BTPC,   1,
>>                         Offset (0x02),
>>                         HDUE,   1,
>>                             ,   4,
>>                         SNLK,   1,
>>                         Offset (0x03),
>>                             ,   5,
>>                         HAUM,   2,
>>                         Offset (0x05),
>>                         HSPA,   1,
>>                         Offset (0x06),
>>                         HSUN,   8,
>>                         HSRP,   8,
>>                         Offset (0x09),
>>                             ,   6,
>>                         FNKS,   1,
>>                         Offset (0x0C),
>>                         HLCL,   8,
>>                             ,   4,
>>                         CALM,   1,
>>                         Offset (0x0E),
>>                         HFNS,   2,
>>                         Offset (0x0F),
>>                             ,   6,
>>                         NULS,   1,
>>                         Offset (0x10),
>>                         HAM0,   8,
>>                         HAM1,   8,
>>                         HAM2,   8,
>>                         HAM3,   8,
>>                         HAM4,   8,
>>                         HAM5,   8,
>>                         HAM6,   8,
>>                         HAM7,   8,
>>                         HAM8,   8,
>>                         HAM9,   8,
>>                         HAMA,   8,
>>                         HAMB,   8,
>>                         HAMC,   8,
>>                         HAMD,   8,
>>                         HAME,   8,
>>                         HAMF,   8,
>>                         Offset (0x23),
>>                         HANT,   8,
>>                         Offset (0x26),
>>                             ,   2,
>>                         HANA,   2,
>>                         Offset (0x27),
>>                         Offset (0x28),
>>                             ,   1,
>>                         SKEM,   1,
>>                         Offset (0x29),
>>                         Offset (0x2A),
>>                         HATR,   8,
>>                         HT0H,   8,
>>                         HT0L,   8,
>>                         HT1H,   8,
>>                         HT1L,   8,
>>                         HFSP,   8,
>>                             ,   6,
>>                         HMUT,   1,
>>                         Offset (0x31),
>>                             ,   2,
>>                         HUWB,   1,
>>                             ,   3,
>>                         VPON,   1,
>>                         VRST,   1,
>>                         HWPM,   1,
>>                         HWLB,   1,
>>                         HWLO,   1,
>>                         HWDK,   1,
>>                         HWFN,   1,
>>                         HWBT,   1,
>>                         HWRI,   1,
>>                         HWBU,   1,
>>                         HWLU,   1,
>>                         Offset (0x34),
>>                             ,   3,
>>                         PIBS,   1,
>>                             ,   3,
>>                         HPLO,   1,
>>                         Offset (0x36),
>>                         HWAC,   16,
>>                         HB0S,   7,
>>                         HB0A,   1,
>>                         HB1S,   7,
>>                         HB1A,   1,
>>                         HCMU,   1,
>>                             ,   2,
>>                         OVRQ,   1,
>>                         DCBD,   1,
>>                         DCWL,   1,
>>                         DCWW,   1,
>>                         HB1I,   1,
>>                             ,   1,
>>                         KBLT,   1,
>>                         BTPW,   1,
>>                         FNKC,   1,
>>                         HUBS,   1,
>>                         BDPW,   1,
>>                         BDDT,   1,
>>                         HUBB,   1,
>>                         Offset (0x46),
>>                             ,   1,
>>                         BTWK,   1,
>>                         HPLD,   1,
>>                             ,   1,
>>                         HPAC,   1,
>>                         BTST,   1,
>>                         Offset (0x47),
>>                         HPBU,   1,
>>                             ,   1,
>>                         HBID,   1,
>>                             ,   3,
>>                         HBCS,   1,
>>                         HPNF,   1,
>>                             ,   1,
>>                         GSTS,   1,
>>                             ,   2,
>>                         HLBU,   1,
>>                         DOCD,   1,
>>                         HCBL,   1,
>>                         Offset (0x49),
>>                         SLUL,   1,
>>                         Offset (0x4C),
>>                         HTMH,   8,
>>                         HTML,   8,
>>                         HWAK,   16,
>>                         HMPR,   8,
>>                             ,   7,
>>                         HMDN,   1,
>>                         Offset (0x78),
>>                         TMP0,   8,
>>                         Offset (0x80),
>>                         Offset (0x81),
>>                         HIID,   8,
>>                         Offset (0x83),
>>                         HFNI,   8,
>>                         HSPD,   16,
>>                         Offset (0x88),
>>                         TSL0,   7,
>>                         TSR0,   1,
>>                         TSL1,   7,
>>                         TSR1,   1,
>>                         TSL2,   7,
>>                         TSR2,   1,
>>                         TSL3,   7,
>>                         TSR3,   1,
>>                         Offset (0x8D),
>>                         HDAA,   3,
>>                         HDAB,   3,
>>                         HDAC,   2,
>>                         RCBD,   1,
>>                         RCWL,   1,
>>                         RCWW,   1,
>>                         Offset (0xB0),
>>                         HDEN,   32,
>>                         HDEP,   32,
>>                         HDEM,   8,
>>                         HDES,   8,
>>                         Offset (0xC8),
>>                         ATMX,   8,
>>                         HWAT,   8,
>>                         Offset (0xCC),
>>                         PWMH,   8,
>>                         PWML,   8,
>>                         Offset (0xED),
>>                             ,   4,
>>                         HDDD,   1
>>                     }
>>
>> ------------------------------------------------------------
>> -----------------------------------
>>
>>
>>
>> Many thanks,
>> Devin
>>
>>
>>
>>
>>
>> On Thu, May 25, 2017 at 10:15 AM, Moore, Robert <robert.moore(a)intel.co=
m>
>> wrote:
>>
>> ACPI Error: Region EmbeddedControl (ID=3D3) has no handler
>> (20170303/exfldio-431)
>>
>>
>>
>> You either don=E2=80=99t have a driver for the EC, or your EC driver has=
 not
>> installed a handler for the EC operation region.
>>
>>
>>
>> I would guess.
>>
>>
>>
>>
>>
>>
>>
>>
>>
>> *From:* Devel [mailto:devel-bounces(a)acpica.org] *On Behalf Of *Devin
>> Steffler
>> *Sent:* Thursday, May 25, 2017 6:15 AM
>> *To:* devel(a)acpica.org
>> *Subject:* [Devel] Help needed for "ACPI Error: No handler for Region
>> [ECOR]" (using my own OSL)
>>
>>
>>
>> Hello,
>>
>>
>>
>> I am working on an OSL for QNX. I am getting some errors printed out
>> during AcpiInitializeObjects but only in one out of three laptops that I=
 am
>> testing. A Dell and ASUS laptop do not have the errors but a Lenovo lapt=
op
>> does. I am able to read battery status (_BST) on the Dell and ASUS lapto=
ps
>> but not on the Lenovo laptop.
>>
>>
>>
>> The ACPICA version I am using is 20170303.
>>
>>
>>
>> Some questions I have are:
>>
>> - Is this the correct mailing list for this email?
>>
>> - Does this appear to be a bug in ACPICA, in my OSL, or somewhere else
>> (maybe the laptop BIOS)?
>>
>> - Should I raise a bug for this?
>>
>> - Would you provide any recommendations to help me troubleshoot this?
>>
>> - What other information should I provide?
>>
>>
>>
>> This is the output during ACPI initialization on the problematic laptop
>> (from my OSL):
>>
>> ------------------------------------------------------------
>> ------------------------------------
>>
>> ACPI: RSDP 0x00000000000F0120 000024 (v02 LENOVO)
>>
>> ACPI: XSDT 0x00000000D7FD2188 0000CC (v01 LENOVO TP-R00   00000000 PTEC
>> 00000002)
>>
>> ACPI: FACP 0x00000000D7FF7000 0000F4 (v05 LENOVO TP-R00   00000420 PTEC
>> 00000002)
>>
>> ACPI: DSDT 0x00000000D7FDE000 011451 (v02 LENOVO TP-R00   00000420 INTL
>> 20141107)
>>
>> ACPI: FACS 0x00000000D7FA2000 000040
>>
>> ACPI: UEFI 0x00000000D7FB9000 000042 (v01 LENOVO TP-R00   00000420 PTEC
>> 00000002)
>>
>> ACPI: SSDT 0x00000000D7FF8000 004E0A (v02 LENOVO SaSsdt   00003000 INTL
>> 20141107)
>>
>> ACPI: ASF! 0x00000000D7FF6000 0000A5 (v32 LENOVO TP-R00   00000420 PTEC
>> 00000002)
>>
>> ACPI: ECDT 0x00000000D7FF5000 000052 (v01 LENOVO TP-R00   00000420 PTEC
>> 00000002)
>>
>> ACPI: HPET 0x00000000D7FF4000 000038 (v01 LENOVO TP-R00   00000420 PTEC
>> 00000002)
>>
>> ACPI: LPIT 0x00000000D7FF3000 000094 (v01 LENOVO TP-R00   00000420 PTEC
>> 00000002)
>>
>> ACPI: APIC 0x00000000D7FF2000 0000BC (v03 LENOVO TP-R00   00000420 PTEC
>> 00000002)
>>
>> ACPI: MCFG 0x00000000D7FF1000 00003C (v01 LENOVO TP-R00   00000420 PTEC
>> 00000002)
>>
>> ACPI: WDAT 0x00000000D7FF0000 000134 (v01 LENOVO TP-R00   00000420 PTEC
>> 00000002)
>>
>> ACPI: SSDT 0x00000000D7FDC000 001AFC (v01 LENOVO SataAhci 00001000 INTL
>> 20141107)
>>
>> ACPI: DBGP 0x00000000D7FDB000 000034 (v01 LENOVO TP-R00   00000420 PTEC
>> 00000002)
>>
>> ACPI: DBG2 0x00000000D7FDA000 000054 (v00 LENOVO TP-R00   00000420 PTEC
>> 00000002)
>>
>> ACPI: BOOT 0x00000000D7FD9000 000028 (v01 LENOVO TP-R00   00000420 PTEC
>> 00000002)
>>
>> ACPI: BATB 0x00000000D7FD8000 000046 (v01 LENOVO TP-R00   00000420 PTEC
>> 00000002)
>>
>> ACPI: SLIC 0x00000000D7FD7000 000176 (v01 LENOVO TP-R00   00000420 PTEC
>> 00000002)
>>
>> ACPI: SSDT 0x00000000D7FD6000 000E58 (v02 LENOVO CpuSsdt  00003000 INTL
>> 20141107)
>>
>> ACPI: SSDT 0x00000000D7FD5000 0003D9 (v02 LENOVO CtdpB    00001000 INTL
>> 20141107)
>>
>> ACPI: MSDM 0x00000000D7FD4000 000055 (v03 LENOVO TP-R00   00000420 PTEC
>> 00000002)
>>
>> ACPI: FPDT 0x00000000D7FD3000 000044 (v01 LENOVO TP-R00   00000420 PTEC
>> 00000002)
>>
>> ACPI: UEFI 0x00000000D7FA0000 00012A (v01 LENOVO TP-R00   00000420 PTEC
>> 00000002)
>>
>>
>>
>> Initializing Namespace objects:
>>
>> Table [DSDT: TP-R00  ] (id 01) - 2757 Objects with  76 Devices,  40
>> Regions,  510 Methods (140/370/24 Serial/Non/Cvt)
>>
>> Table [SSDT: SaSsdt  ] (id 02) -  552 Objects with  18 Devices,  20
>> Regions,  131 Methods (41/90/7 Serial/Non/Cvt)
>>
>> Table [SSDT: SataAhci] (id 03) -  183 Objects with   8 Devices,   0
>> Regions,   34 Methods (25/9/5 Serial/Non/Cvt)
>>
>> Table [SSDT: CpuSsdt ] (id 04) -  114 Objects with   0 Devices,   3
>> Regions,   29 Methods (13/16/13 Serial/Non/Cvt)
>>
>> Table [SSDT: CtdpB   ] (id 05) -   33 Objects with   0 Devices,   1
>> Regions,    5 Methods (2/3/1 Serial/Non/Cvt)
>>
>> ACPI: 5 ACPI AML tables successfully acquired and loaded
>>
>> Completing Region/Field/Buffer/Package initialization:
>>
>>     Initialized 63/64 Regions 71/71 Fields 88/88 Buffers 83/83 Packages
>> (3648 nodes)
>>
>>  evxfevnt-0218 Enable                : Transition to ACPI mode successful
>>
>> Initializing General Purpose Events (GPEs):
>>
>>     Initialized GPE 00 to 7F [_GPE] 16 regs on interrupt 0x9 (SCI)
>>
>> Initializing Device/Processor/Thermal objects and executing _INI/_STA
>> methods:
>>
>> ACPI Error: No handler for Region [ECOR] (80da130) [EmbeddedControl]
>> (20170303/evregion-291)
>>
>> ACPI Error: Region EmbeddedControl (ID=3D3) has no handler
>> (20170303/exfldio-431)
>>
>> ACPI Error: Method parse/execution failed [\_SB.PCI0.LPC.EC.AC._PSR]
>> (Node 80d0c30), AE_NOT_EXIST (20170303/psparse-668)
>>
>> ACPI Error: Method parse/execution failed [\_SB._INI] (Node 80e4f50),
>> AE_NOT_EXIST (20170303/psparse-668)
>>
>> ACPI Error: No handler for Region [ECOR] (80da130) [EmbeddedControl]
>> (20170303/evregion-291)
>>
>> ACPI Error: Region EmbeddedControl (ID=3D3) has no handler
>> (20170303/exfldio-431)
>>
>> ACPI Error: Method parse/execution failed [\_SB.PCI0.LPC.EC._INI] (Node
>> 80d00d0), AE_NOT_EXIST (20170303/psparse-668)
>>
>> ACPI Exception: AE_NOT_EXIST, during \_SB.PCI0.LPC.EC._INI execution
>> (20170303/nsinit-807)
>>
>>     Executed 13 _INI methods requiring 1 _STA executions (examined 113
>> objects)
>>
>> ------------------------------------------------------------
>> ------------------------------------
>>
>>
>>
>> This is the output from calling AcpiEvaluateObject for the control method
>> "\_SB.PCI0.LPC.EC.BAT0._BST", which returns with AE_NOT_EXIST:
>>
>> ------------------------------------------------------------
>> ------------------------------------
>>
>> ACPI Error: No handler for Region [ECOR] (80da130) [EmbeddedControl]
>> (20170303/evregion-291)
>>
>> ACPI Error: Region EmbeddedControl (ID=3D3) has no handler
>> (20170303/exfldio-431)
>>
>> ACPI Error: Method parse/execution failed [\_SB.PCI0.LPC.EC.BAT0._BST]
>> (Node 80d0b70), AE_NOT_EXIST (20170303/psparse-668)
>>
>> ------------------------------------------------------------
>> ------------------------------------
>>
>>
>>
>> This is the output from executing the control method using acpiexec:
>>
>> ------------------------------------------------------------
>> ------------------------------------
>>
>> # ./acpiexec *.dat
>>
>>
>>
>>
>>
>> Intel ACPI Component Architecture
>>
>> AML Execution/Debug Utility version 20170303
>>
>> Copyright (c) 2000 - 2017 Intel Corporation
>>
>>
>>
>> Input file apic.dat, Length 0xBC (188) bytes
>>
>> Input file asf!.dat, Length 0xA5 (165) bytes
>>
>> Input file batb.dat, Length 0x46 (70) bytes
>>
>> Input file boot.dat, Length 0x28 (40) bytes
>>
>> Input file dbg2.dat, Length 0x54 (84) bytes
>>
>> Input file dbgp.dat, Length 0x34 (52) bytes
>>
>> Input file dsdt.dat, Length 0x11451 (70737) bytes
>>
>> Input file ecdt.dat, Length 0x52 (82) bytes
>>
>> Input file facp.dat, Length 0xF4 (244) bytes
>>
>> Input file facs.dat, Length 0x40 (64) bytes
>>
>> Input file fpdt.dat, Length 0x44 (68) bytes
>>
>> Input file hpet.dat, Length 0x38 (56) bytes
>>
>> Input file lpit.dat, Length 0x94 (148) bytes
>>
>> Input file mcfg.dat, Length 0x3C (60) bytes
>>
>> Input file msdm.dat, Length 0x55 (85) bytes
>>
>> Input file slic.dat, Length 0x176 (374) bytes
>>
>> Input file ssdt1.dat, Length 0x4E0A (19978) bytes
>>
>> Input file ssdt2.dat, Length 0x1AFC (6908) bytes
>>
>> Input file ssdt3.dat, Length 0xE58 (3672) bytes
>>
>> Input file ssdt4.dat, Length 0x3D9 (985) bytes
>>
>> Input file uefi1.dat, Length 0x42 (66) bytes
>>
>> Input file uefi2.dat, Length 0x12A (298) bytes
>>
>> Input file wdat.dat, Length 0x134 (308) bytes
>>
>> Input file xsdt.dat, Length 0xCC (204) bytes
>>
>>
>>
>> ACPI: RSDP 0x00000000080DBCE0 000024 (v02 Intel )
>>
>> ACPI: XSDT 0x00000000080E78C8 0000E4 (v00 Intel  AcpiExec 00001001 INTL
>> 20170303)
>>
>> ACPI: FACP 0x00000000080EA550 0000F4 (v05 LENOVO TP-R00   00000420 PTEC
>> 00000002)
>>
>> ACPI: DSDT 0x00000000080EF020 011451 (v02 LENOVO TP-R00   00000420 INTL
>> 20141107)
>>
>> ACPI: FACS 0x00000000080DBD20 000040
>>
>> ACPI: APIC 0x00000000080EA708 0000BC (v03 LENOVO TP-R00   00000420 PTEC
>> 00000002)
>>
>> ACPI: ASF! 0x00000000080EA650 0000A5 (v32 LENOVO TP-R00   00000420 PTEC
>> 00000002)
>>
>> ACPI: BATB 0x00000000080E30A8 000046 (v01 LENOVO TP-R00   00000420 PTEC
>> 00000002)
>>
>> ACPI: BOOT 0x00000000080E01D8 000028 (v01 LENOVO TP-R00   00000420 PTEC
>> 00000002)
>>
>> ACPI: DBG2 0x00000000080E21F0 000054 (v00 LENOVO TP-R00   00000420 PTEC
>> 00000002)
>>
>> ACPI: DBGP 0x00000000080E12D8 000034 (v01 LENOVO TP-R00   00000420 PTEC
>> 00000002)
>>
>> ACPI: ECDT 0x00000000080E2258 000052 (v01 LENOVO TP-R00   00000420 PTEC
>> 00000002)
>>
>> ACPI: FACS 0x00000000080E1320 000040
>>
>> ACPI: FPDT 0x00000000080E3100 000044 (v01 LENOVO TP-R00   00000420 PTEC
>> 00000002)
>>
>> ACPI: HPET 0x00000000080E1368 000038 (v01 LENOVO TP-R00   00000420 PTEC
>> 00000002)
>>
>> ACPI: LPIT 0x00000000080EA4B0 000094 (v01 LENOVO TP-R00   00000420 PTEC
>> 00000002)
>>
>> ACPI: MCFG 0x00000000080E13B0 00003C (v01 LENOVO TP-R00   00000420 PTEC
>> 00000002)
>>
>> ACPI: MSDM 0x00000000080E22C0 000055 (v03 LENOVO TP-R00   00000420 PTEC
>> 00000002)
>>
>> ACPI: SLIC 0x00000000080EA328 000176 (v01 LENOVO TP-R00   00000420 PTEC
>> 00000002)
>>
>> ACPI: SSDT 0x0000000008101020 004E0A (v02 LENOVO SaSsdt   00003000 INTL
>> 20141107)
>>
>> ACPI: SSDT 0x00000000080E8820 001AFC (v01 LENOVO SataAhci 00001000 INTL
>> 20141107)
>>
>> ACPI: SSDT 0x00000000080E79B8 000E58 (v02 LENOVO CpuSsdt  00003000 INTL
>> 20141107)
>>
>> ACPI: SSDT 0x00000000080EA7D0 0003D9 (v02 LENOVO CtdpB    00001000 INTL
>> 20141107)
>>
>> ACPI: UEFI 0x00000000080E3158 000042 (v01 LENOVO TP-R00   00000420 PTEC
>> 00000002)
>>
>> ACPI: UEFI 0x00000000080E7470 00012A (v01 LENOVO TP-R00   00000420 PTEC
>> 00000002)
>>
>> ACPI: WDAT 0x00000000080E7330 000134 (v01 LENOVO TP-R00   00000420 PTEC
>> 00000002)
>>
>> ACPI: XSDT 0x00000000080E7230 0000CC (v01 LENOVO TP-R00   00000000 PTEC
>> 00000002)
>>
>> Initializing General Purpose Events (GPEs):
>>
>>     Initialized GPE 00 to 7F [_GPE] 16 regs on interrupt 0x9 (SCI)
>>
>>
>>
>> Initializing Namespace objects:
>>
>> Table [DSDT: TP-R00  ] (id 01) - 2757 Objects with  76 Devices,  40
>> Regions,  510 Methods (140/370/24 Serial/Non/Cvt)
>>
>> Table [SSDT: SaSsdt  ] (id 02) -  552 Objects with  18 Devices,  20
>> Regions,  131 Methods (41/90/7 Serial/Non/Cvt)
>>
>> Table [SSDT: SataAhci] (id 03) -  183 Objects with   8 Devices,   0
>> Regions,   34 Methods (25/9/5 Serial/Non/Cvt)
>>
>> Table [SSDT: CpuSsdt ] (id 04) -  114 Objects with   0 Devices,   3
>> Regions,   29 Methods (13/16/13 Serial/Non/Cvt)
>>
>> Table [SSDT: CtdpB   ] (id 05) -   33 Objects with   0 Devices,   1
>> Regions,    5 Methods (2/3/1 Serial/Non/Cvt)
>>
>> ACPI: 5 ACPI AML tables successfully acquired and loaded
>>
>>
>>
>> Completing Region/Field/Buffer/Package initialization:
>>
>>     Initialized 63/64 Regions 71/71 Fields 88/88 Buffers 83/83 Packages
>> (3648 nodes)
>>
>> Initializing Device/Processor/Thermal objects and executing _INI/_STA
>> methods:
>>
>> [AcpiExec] Exception AE_AML_INFINITE_LOOP during execution of method
>> [SMI_] Opcode [While] @44
>>
>> [SMI_] @00034 #00A2:  While (
>>
>> No Local Variables are initialized for method [SMI_]
>>
>>
>>
>> Initialized Arguments for Method [SMI_]:  (0 arguments defined for method
>> invocation)
>>
>>     Arg0:   81ecc40 <Obj>             Integer 0000000000000009
>>
>>     Arg1:   81eca38 <Obj>             Integer 0000000000000001
>>
>>     Arg2:   81ecbd8 <Obj>             Integer 0000000000000000
>>
>>     Arg3:   81ec9d0 <Obj>             Integer 0000000000000000
>>
>>     Arg4:   81ecb08 <Obj>             Integer 0000000000000000
>>
>>
>>
>> ACPI Error: Method parse/execution failed [\SMI] (Node 814de40),
>> AE_AML_INFINITE_LOOP (20170303/psparse-668)
>>
>> ACPI Error: Method parse/execution failed [\WGSV] (Node 814e978),
>> AE_AML_INFINITE_LOOP (20170303/psparse-668)
>>
>> ACPI Error: Method parse/execution failed [\_SB.PCI0.LPC.EC.HKEY.WGIN]
>> (Node 8143810), AE_AML_INFINITE_LOOP (20170303/psparse-668)
>>
>> ACPI Error: Method parse/execution failed [\_SB.PCI0.LPC.EC._INI] (Node
>> 8121ae0), AE_AML_INFINITE_LOOP (20170303/psparse-668)
>>
>> ACPI Exception: AE_AML_INFINITE_LOOP, during \_SB.PCI0.LPC.EC._INI
>> execution (20170303/nsinit-807)
>>
>>     Executed 14 _INI methods requiring 1 _STA executions (examined 113
>> objects)
>>
>> - execute \_SB.PCI0.LPC.EC.BAT0._BST
>>
>> Evaluating \_SB.PCI0.LPC.EC.BAT0._BST
>>
>> 0x4 Outstanding allocations after evaluation of \_SB.PCI0.LPC.EC.BAT0._B=
ST
>>
>> Evaluation of \_SB.PCI0.LPC.EC.BAT0._BST returned object 80eaff0,
>> external buffer length 78
>>
>>   [Package] Contains 4 Elements:
>>
>>     [Integer] =3D 0000000000000004
>>
>>     [Integer] =3D 0000000000000000
>>
>>     [Integer] =3D 0000000000000000
>>
>>     [Integer] =3D 0000000000000000
>>
>> - q
>>
>> ------------------------------------------------------------
>> ------------------------------------
>>
>>
>>
>> Note: I tried running Linux on the Lenovo laptop and it can read the
>> battery status ok.
>>
>>
>>
>> Thank you,
>>
>> Devin
>>
>>
>>
>>
>>
>
>

--===============6597612541432853578==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+SSBoYXZlIG5vdCB5ZXQgaGVhcmQgYmFjayBmcm9tIFdpbGwgYnV0IEkg
ZGlkIGZpbmQgdGhlIGZvbGxvd2luZyBzZWN0aW9uIGluIHRoZSBQcm9ncmFtbWVyIFJlZmVyZW5j
ZTo8ZGl2PjMuMi43LjEgSW5zdGFsbGF0aW9uIG9mIEFkZHJlc3MgU3BhY2UgSGFuZGxlcnM8YnI+
PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5TbyBJJiMzOTtsbCB0cnkgdXNpbmcgdGhlIGZ1bmN0
aW9uwqBBY3BpSW5zdGFsbEFkZHJlc3NTcGFjZUhhbmRsZXIgdG8gaW5zdGFsbCBhIGhhbmRsZXIg
Zm9yIHRoZSBFQyBvcGVyYXRpb24gcmVnaW9uLjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+VGhh
bmtzLDwvZGl2PjxkaXY+RGV2aW48L2Rpdj48ZGl2Pjxicj48L2Rpdj48L2Rpdj48ZGl2IGNsYXNz
PSJnbWFpbF9leHRyYSI+PGJyPjxkaXYgY2xhc3M9ImdtYWlsX3F1b3RlIj5PbiBUaHUsIE1heSAy
NSwgMjAxNyBhdCA0OjQyIFBNLCBEZXZpbiBTdGVmZmxlciA8c3BhbiBkaXI9Imx0ciI+Jmx0Ozxh
IGhyZWY9Im1haWx0bzpkZXZpbnN0ZWZmbGVyQGdtYWlsLmNvbSIgdGFyZ2V0PSJfYmxhbmsiPmRl
dmluc3RlZmZsZXJAZ21haWwuY29tPC9hPiZndDs8L3NwYW4+IHdyb3RlOjxicj48YmxvY2txdW90
ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MCAwIDAgLjhleDtib3JkZXItbGVm
dDoxcHggI2NjYyBzb2xpZDtwYWRkaW5nLWxlZnQ6MWV4Ij48ZGl2IGRpcj0ibHRyIj48ZGl2Pkkg
YWdyZWUgd2l0aCB5b3UuIEl0IHNob3VsZCBiZSBzdXBwb3J0ZWQgYnkgUU5YIGJ1dCBJIGRvbiYj
Mzk7dCB0aGluayB0aGF0IGl0IGlzIHN1cHBvcnRlZCAmcXVvdDtvdXQgb2YgdGhlIGJveCZxdW90
Oy4gSSBzZWFyY2hlZCB0aGVpciB3ZWJzaXRlL2ZvcnVtcyBhbmQgY291bGRuJiMzOTt0IGZpbmQg
YW55dGhpbmcgcmVsYXRlZCB0byB0aGlzLiBJIHdpbGwgYXNrIGFyb3VuZCBoZXJlIGFuZCBzZWUg
aWYgSSBjYW4gZ2V0IGEgZm9ybWFsIFFOWCBzdXBwb3J0IGNvbnRhY3QgdG8gZmluZCBvdXQgZm9y
IGNlcnRhaW4gKGJ1dCBJIHdhcyB0b2xkIG5vdCB0byBob2xkIG15IGJyZWF0aCB3aGVuIGNvbnRh
Y3RpbmcgUU5YIGZvciBzdXBwb3J0KS48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PkFzIGZhciBh
cyBJIGNhbiB0ZWxsLCBRTlggb25seSBoYXMgJnF1b3Q7YmFyZWJvbmVzJnF1b3Q7IHN1cHBvcnQg
Zm9yIEFDUEksIGkuZS4gb25seSB3aGF0IGlzIG5lZWRlZCB0byBnZXQgYSBzeXN0ZW0gdG8gYm9v
dC48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2Pkkgc2F3IHRoYXQgdGhlIEFDUElDQSBhbHJlYWR5
IGhhcyBjb2RlIGZvciBRTlggYW5kIGZvdW5kIHRoYXQgaXQgd2FzIGFkZGVkIGJ5IFdpbGwgTWls
ZXM6PC9kaXY+PGRpdj48YSBocmVmPSJodHRwczovL2dpdGh1Yi5jb20vYWNwaWNhL2FjcGljYS9j
b21taXQvMzdhMWRlYzIiIHRhcmdldD0iX2JsYW5rIj5odHRwczovL2dpdGh1Yi5jb20vYWNwaWNh
Lzx3YnI+YWNwaWNhL2NvbW1pdC8zN2ExZGVjMjwvYT48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2
PkkmIzM5O2xsIHRyeSBlbWFpbGluZyBXaWxsIHRvIHNlZSBpZiBoZSBjYW4gc2hlZCBzb21lIGxp
Z2h0IG9uIHRoaXMuIElmIGhlIGhhZCB0byB3cml0ZSBoaXMgb3duIE9TTCBmb3IgUU5YIHRoZW4g
SSBzdXNwZWN0IHRoYXQgaGUgd291bGQgbm90IGJlIGFibGUgdG8gc2hhcmUgaXQgKGFzIGl0JiMz
OTtzIGxpa2VseSBvd25lZCBieSBoaXMgY29tcGFueSkuPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRp
dj5JZiB0aGUgRUMgZHJpdmVyIHRoYXQgSSBuZWVkIGlzIHRoZSBzYW1lIGFzIHRoaXMgb25lIGZv
ciBMaW51eCwgdGhlbiBJIHNob3VsZCBiZSBhYmxlIHRvIHdyaXRlIG9uZSBteXNlbGYgZm9yIFFO
WDo8L2Rpdj48ZGl2PjxhIGhyZWY9Imh0dHA6Ly9lbGl4aXIuZnJlZS1lbGVjdHJvbnMuY29tL2xp
bnV4L2xhdGVzdC9zb3VyY2UvZHJpdmVycy9hY3BpL2VjLmMiIHRhcmdldD0iX2JsYW5rIj5odHRw
Oi8vZWxpeGlyLmZyZWUtZWxlY3Ryb25zLjx3YnI+Y29tL2xpbnV4L2xhdGVzdC9zb3VyY2UvPHdi
cj5kcml2ZXJzL2FjcGkvZWMuYzwvYT48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2Pkhvd2V2ZXIs
IGF0IHRoaXMgdGltZSBJJiMzOTttIG5vdCBzdXJlIGhvdyBJIHdvdWxkIGluZm9ybSBBQ1BJQ0Eg
dG8gdXNlIG15IGN1c3RvbSBRTlggRUMgZHJpdmVyLiBIb3cgd291bGQgSSBnbyBhYm91dCByZWdp
c3RlcmluZyB0aGUgZHJpdmVyIHdpdGggQUNQSUNBIHNvIHRoYXQgaXQga25vd3Mgd2hhdCBmdW5j
dGlvbnMgdG8gY2FsbD8gSSBkb24mIzM5O3Qgc2VlIGFueXRoaW5nIGluIHRoZSBBQ1BJQ0EgVXNl
ciBHdWlkZSBhbmQgUHJvZ3JhbW1lciBSZWZlcmVuY2UgZm9yIHRoaXMuIFRoZSBvbmx5IEFjcGkq
IG1ldGhvZHMgZnJvbSB0aGUgQUNQSUNBIHdpdGggJnF1b3Q7cmVnaXN0ZXImcXVvdDsgaW4gdGhl
bSBhcmUgQWNwaVJlYWRCaXRSZWdpc3RlciBhbmQgQWNwaVdyaXRlQml0UmVnaXN0ZXIuIFNob3Vs
ZCB0aGVyZSBiZSBzb21ldGhpbmcgZm9yIHJlZ2lzdGVyaW5nIGEgZHJpdmVyIGZvciBhbiBvcGVy
YXRpb24gcmVnaW9uPzwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+VGhhbmtzIGFnYWluLDwvZGl2
PjxkaXY+RGV2aW48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2Pjxicj48
L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2Pjxicj48L2Rpdj48L2Rpdj48ZGl2IGNsYXNzPSJIT0Vu
WmIiPjxkaXYgY2xhc3M9Img1Ij48ZGl2IGNsYXNzPSJnbWFpbF9leHRyYSI+PGJyPjxkaXYgY2xh
c3M9ImdtYWlsX3F1b3RlIj5PbiBUaHUsIE1heSAyNSwgMjAxNyBhdCAzOjQ3IFBNLCBNb29yZSwg
Um9iZXJ0IDxzcGFuIGRpcj0ibHRyIj4mbHQ7PGEgaHJlZj0ibWFpbHRvOnJvYmVydC5tb29yZUBp
bnRlbC5jb20iIHRhcmdldD0iX2JsYW5rIj5yb2JlcnQubW9vcmVAaW50ZWwuY29tPC9hPiZndDs8
L3NwYW4+IHdyb3RlOjxicj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJt
YXJnaW46MCAwIDAgLjhleDtib3JkZXItbGVmdDoxcHggI2NjYyBzb2xpZDtwYWRkaW5nLWxlZnQ6
MWV4Ij4NCg0KDQoNCg0KDQo8ZGl2IGxhbmc9IkVOLVVTIiB2bGluaz0icHVycGxlIiBsaW5rPSJi
bHVlIj4NCjxkaXYgY2xhc3M9Im1fLTE0ODk0OTYxMDkyNTk2NjgzNDNtXzU2NjIwNzY4MDY1MzQ2
NTMwODVXb3JkU2VjdGlvbjEiPg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+PHNwYW4gc3R5bGU9ImNv
bG9yOnJnYigzMSw3MywxMjUpO2ZvbnQtZmFtaWx5OiZxdW90O0NhbGlicmkmcXVvdDssc2Fucy1z
ZXJpZjtmb250LXNpemU6MTFwdCI+SSBqdXN0IGxvb2tlZCBpbnRvIHRoZSBBQ1BJQ0Egc291cmNl
LCBhbmQgeWVzLCBpdCBhcHBlYXJzIHRoYXQgUU5YIHVzZXMgQUNQSUNBOjx1PjwvdT48dT48L3U+
PC9zcGFuPjwvcD4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPjxzcGFuIHN0eWxlPSJjb2xvcjpyZ2Io
MzEsNzMsMTI1KTtmb250LWZhbWlseTomcXVvdDtDYWxpYnJpJnF1b3Q7LHNhbnMtc2VyaWY7Zm9u
dC1zaXplOjExcHQiPjx1PjwvdT7CoDx1PjwvdT48L3NwYW4+PC9wPg0KPHAgY2xhc3M9Ik1zb05v
cm1hbCI+PHNwYW4gc3R5bGU9ImNvbG9yOmJsdWU7Zm9udC1mYW1pbHk6JnF1b3Q7Q291cmllciBO
ZXcmcXVvdDs7Zm9udC1zaXplOjEwcHQiPiNpZm5kZWY8L3NwYW4+PHNwYW4gc3R5bGU9ImZvbnQt
ZmFtaWx5OiZxdW90O0NvdXJpZXIgTmV3JnF1b3Q7O2ZvbnQtc2l6ZToxMHB0Ij4gX19BQ1FOWF9I
X188dT48L3U+PHU+PC91Pjwvc3Bhbj48L3A+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj48c3BhbiBz
dHlsZT0iY29sb3I6Ymx1ZTtmb250LWZhbWlseTomcXVvdDtDb3VyaWVyIE5ldyZxdW90Oztmb250
LXNpemU6MTBwdCI+I2RlZmluZTwvc3Bhbj48c3BhbiBzdHlsZT0iZm9udC1mYW1pbHk6JnF1b3Q7
Q291cmllciBOZXcmcXVvdDs7Zm9udC1zaXplOjEwcHQiPiBfX0FDUU5YX0hfXzx1PjwvdT48dT48
L3U+PC9zcGFuPjwvcD4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPjxzcGFuIHN0eWxlPSJmb250LWZh
bWlseTomcXVvdDtDb3VyaWVyIE5ldyZxdW90Oztmb250LXNpemU6MTBwdCI+PHU+PC91PsKgPHU+
PC91Pjwvc3Bhbj48L3A+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj48c3BhbiBzdHlsZT0iY29sb3I6
Ymx1ZTtmb250LWZhbWlseTomcXVvdDtDb3VyaWVyIE5ldyZxdW90Oztmb250LXNpemU6MTBwdCI+
I2RlZmluZTwvc3Bhbj48c3BhbiBzdHlsZT0iZm9udC1mYW1pbHk6JnF1b3Q7Q291cmllciBOZXcm
cXVvdDs7Zm9udC1zaXplOjEwcHQiPiBBQ1BJX1VTRV9TVEFOREFSRF9IRUFERVJTPHU+PC91Pjx1
PjwvdT48L3NwYW4+PC9wPg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+PHNwYW4gc3R5bGU9ImNvbG9y
OmJsdWU7Zm9udC1mYW1pbHk6JnF1b3Q7Q291cmllciBOZXcmcXVvdDs7Zm9udC1zaXplOjEwcHQi
PiNkZWZpbmU8L3NwYW4+PHNwYW4gc3R5bGU9ImZvbnQtZmFtaWx5OiZxdW90O0NvdXJpZXIgTmV3
JnF1b3Q7O2ZvbnQtc2l6ZToxMHB0Ij4gQUNQSV9VU0VfU1lTVEVNX0NMSUJSQVJZPHU+PC91Pjx1
PjwvdT48L3NwYW4+PC9wPg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+PHNwYW4gc3R5bGU9ImZvbnQt
ZmFtaWx5OiZxdW90O0NvdXJpZXIgTmV3JnF1b3Q7O2ZvbnQtc2l6ZToxMHB0Ij48dT48L3U+wqA8
dT48L3U+PC9zcGFuPjwvcD4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPjxzcGFuIHN0eWxlPSJjb2xv
cjpibHVlO2ZvbnQtZmFtaWx5OiZxdW90O0NvdXJpZXIgTmV3JnF1b3Q7O2ZvbnQtc2l6ZToxMHB0
Ij4jZGVmaW5lPC9zcGFuPjxzcGFuIHN0eWxlPSJmb250LWZhbWlseTomcXVvdDtDb3VyaWVyIE5l
dyZxdW90Oztmb250LXNpemU6MTBwdCI+IEFDUElfVUlOVFBUUl9UwqDCoMKgwqDCoMKgwqDCoMKg
IHVpbnRwdHJfdDx1PjwvdT48dT48L3U+PC9zcGFuPjwvcD4NCjxwIGNsYXNzPSJNc29Ob3JtYWwi
PjxzcGFuIHN0eWxlPSJjb2xvcjpibHVlO2ZvbnQtZmFtaWx5OiZxdW90O0NvdXJpZXIgTmV3JnF1
b3Q7O2ZvbnQtc2l6ZToxMHB0Ij4jZGVmaW5lPC9zcGFuPjxzcGFuIHN0eWxlPSJmb250LWZhbWls
eTomcXVvdDtDb3VyaWVyIE5ldyZxdW90Oztmb250LXNpemU6MTBwdCI+IEFDUElfVVNFX0xPQ0FM
X0NBQ0hFPHU+PC91Pjx1PjwvdT48L3NwYW4+PC9wPg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+PHNw
YW4gc3R5bGU9ImNvbG9yOmJsdWU7Zm9udC1mYW1pbHk6JnF1b3Q7Q291cmllciBOZXcmcXVvdDs7
Zm9udC1zaXplOjEwcHQiPiNkZWZpbmU8L3NwYW4+PHNwYW4gc3R5bGU9ImZvbnQtZmFtaWx5OiZx
dW90O0NvdXJpZXIgTmV3JnF1b3Q7O2ZvbnQtc2l6ZToxMHB0Ij4gQUNQSV9DQVNUX1BUSFJFQURf
VCh4KcKgICgoQUNQSV9USFJFQURfSUQpIEFDUElfVE9fSU5URUdFUiAoeCkpPHU+PC91Pjx1Pjwv
dT48L3NwYW4+PC9wPg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+PHNwYW4gc3R5bGU9ImZvbnQtZmFt
aWx5OiZxdW90O0NvdXJpZXIgTmV3JnF1b3Q7O2ZvbnQtc2l6ZToxMHB0Ij48dT48L3U+wqA8dT48
L3U+PC9zcGFuPjwvcD4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPjxzcGFuIHN0eWxlPSJjb2xvcjpn
cmVlbjtmb250LWZhbWlseTomcXVvdDtDb3VyaWVyIE5ldyZxdW90Oztmb250LXNpemU6MTBwdCI+
LyogQXQgcHJlc2VudCB0aW1lIChRTlggNi42KSBhbGwgc3VwcG9ydGVkIGFyY2hpdGVjdHVyZXMg
YXJlIDMyIGJpdHMuICovPHU+PC91Pjx1PjwvdT48L3NwYW4+PC9wPg0KPHAgY2xhc3M9Ik1zb05v
cm1hbCI+PHNwYW4gc3R5bGU9ImNvbG9yOmJsdWU7Zm9udC1mYW1pbHk6JnF1b3Q7Q291cmllciBO
ZXcmcXVvdDs7Zm9udC1zaXplOjEwcHQiPiNkZWZpbmU8L3NwYW4+PHNwYW4gc3R5bGU9ImZvbnQt
ZmFtaWx5OiZxdW90O0NvdXJpZXIgTmV3JnF1b3Q7O2ZvbnQtc2l6ZToxMHB0Ij4gQUNQSV9NQUNI
SU5FX1dJRFRIwqDCoMKgwqDCoCAzMjx1PjwvdT48dT48L3U+PC9zcGFuPjwvcD4NCjxwIGNsYXNz
PSJNc29Ob3JtYWwiPjxzcGFuIHN0eWxlPSJjb2xvcjpyZ2IoMzEsNzMsMTI1KTtmb250LWZhbWls
eTomcXVvdDtDYWxpYnJpJnF1b3Q7LHNhbnMtc2VyaWY7Zm9udC1zaXplOjExcHQiPjx1PjwvdT7C
oDx1PjwvdT48L3NwYW4+PC9wPg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+PHNwYW4gc3R5bGU9ImNv
bG9yOnJnYigzMSw3MywxMjUpO2ZvbnQtZmFtaWx5OiZxdW90O0NhbGlicmkmcXVvdDssc2Fucy1z
ZXJpZjtmb250LXNpemU6MTFwdCI+V2hpY2ggbWVhbnMgdGhhdCB0aGUgQUNQSUNBLXRvLVFOWCBP
U0wgaW50ZXJmYWNlIGxheWVyIGFscmVhZHkgZXhpc3RzLjx1PjwvdT48dT48L3U+PC9zcGFuPjwv
cD4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPjxzcGFuIHN0eWxlPSJjb2xvcjpyZ2IoMzEsNzMsMTI1
KTtmb250LWZhbWlseTomcXVvdDtDYWxpYnJpJnF1b3Q7LHNhbnMtc2VyaWY7Zm9udC1zaXplOjEx
cHQiPjx1PjwvdT7CoDx1PjwvdT48L3NwYW4+PC9wPg0KPGRpdiBzdHlsZT0iYm9yZGVyLXdpZHRo
Om1lZGl1bSBtZWRpdW0gbWVkaXVtIDEuNXB0O2JvcmRlci1zdHlsZTpub25lIG5vbmUgbm9uZSBz
b2xpZDtib3JkZXItY29sb3I6Y3VycmVudENvbG9yIGN1cnJlbnRDb2xvciBjdXJyZW50Q29sb3Ig
Ymx1ZTtwYWRkaW5nOjBpbiAwaW4gMGluIDRwdCI+DQo8ZGl2Pg0KPGRpdiBzdHlsZT0iYm9yZGVy
LXdpZHRoOjFwdCBtZWRpdW0gbWVkaXVtO2JvcmRlci1zdHlsZTpzb2xpZCBub25lIG5vbmU7Ym9y
ZGVyLWNvbG9yOnJnYigyMjUsMjI1LDIyNSkgY3VycmVudENvbG9yIGN1cnJlbnRDb2xvcjtwYWRk
aW5nOjNwdCAwaW4gMGluIj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPjxiPjxzcGFuIHN0eWxlPSJm
b250LWZhbWlseTomcXVvdDtDYWxpYnJpJnF1b3Q7LHNhbnMtc2VyaWY7Zm9udC1zaXplOjExcHQi
PkZyb206PC9zcGFuPjwvYj48c3BhbiBzdHlsZT0iZm9udC1mYW1pbHk6JnF1b3Q7Q2FsaWJyaSZx
dW90OyxzYW5zLXNlcmlmO2ZvbnQtc2l6ZToxMXB0Ij4gRGV2ZWwgW21haWx0bzo8YSBocmVmPSJt
YWlsdG86ZGV2ZWwtYm91bmNlc0BhY3BpY2Eub3JnIiB0YXJnZXQ9Il9ibGFuayI+ZGV2ZWwtYm91
bmNlc0BhY3BpY2Eubzx3YnI+cmc8L2E+XQ0KPGI+T24gQmVoYWxmIE9mIDwvYj5Nb29yZSwgUm9i
ZXJ0PGJyPg0KPGI+U2VudDo8L2I+IFRodXJzZGF5LCBNYXkgMjUsIDIwMTcgMTI6NDEgUE08YnI+
DQo8Yj5Ubzo8L2I+IERldmluIFN0ZWZmbGVyICZsdDs8YSBocmVmPSJtYWlsdG86ZGV2aW5zdGVm
ZmxlckBnbWFpbC5jb20iIHRhcmdldD0iX2JsYW5rIj5kZXZpbnN0ZWZmbGVyQGdtYWlsLmNvbTwv
YT4mZ3Q7PC9zcGFuPjwvcD48ZGl2PjxkaXYgY2xhc3M9Im1fLTE0ODk0OTYxMDkyNTk2NjgzNDNo
NSI+PGJyPg0KPGI+Q2M6PC9iPiA8YSBocmVmPSJtYWlsdG86ZGV2ZWxAYWNwaWNhLm9yZyIgdGFy
Z2V0PSJfYmxhbmsiPmRldmVsQGFjcGljYS5vcmc8L2E+PGJyPg0KPGI+U3ViamVjdDo8L2I+IFJl
OiBbRGV2ZWxdIEhlbHAgbmVlZGVkIGZvciAmcXVvdDtBQ1BJIEVycm9yOiBObyBoYW5kbGVyIGZv
ciBSZWdpb24gW0VDT1JdJnF1b3Q7ICh1c2luZyBteSBvd24gT1NMKTx1PjwvdT48dT48L3U+PC9k
aXY+PC9kaXY+PHA+PC9wPg0KPHA+PC9wPjwvZGl2Pg0KPC9kaXY+PGRpdj48ZGl2IGNsYXNzPSJt
Xy0xNDg5NDk2MTA5MjU5NjY4MzQzaDUiPg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+PHU+PC91PsKg
PHU+PC91PjwvcD4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPjxzcGFuIHN0eWxlPSJjb2xvcjpyZ2Io
MzEsNzMsMTI1KTtmb250LWZhbWlseTomcXVvdDtDYWxpYnJpJnF1b3Q7LHNhbnMtc2VyaWY7Zm9u
dC1zaXplOjExcHQiPkkgY2Fu4oCZdCBzcGVhayBmb3IgUU5YLCBidXQgdGhlIEVDIGRyaXZlciB3
b3VsZCBiZSBwYXJ0IG9mIGl0LiBJdCBoYXMgbm90aGluZyB0byBkbyB3aXRoIHlvdXIgT1NMLjx1
PjwvdT48dT48L3U+PC9zcGFuPjwvcD4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPjxzcGFuIHN0eWxl
PSJjb2xvcjpyZ2IoMzEsNzMsMTI1KTtmb250LWZhbWlseTomcXVvdDtDYWxpYnJpJnF1b3Q7LHNh
bnMtc2VyaWY7Zm9udC1zaXplOjExcHQiPjx1PjwvdT7CoDx1PjwvdT48L3NwYW4+PC9wPg0KPHAg
Y2xhc3M9Ik1zb05vcm1hbCI+PHNwYW4gc3R5bGU9ImNvbG9yOnJnYigzMSw3MywxMjUpO2ZvbnQt
ZmFtaWx5OiZxdW90O0NhbGlicmkmcXVvdDssc2Fucy1zZXJpZjtmb250LXNpemU6MTFwdCI+SeKA
mW0gbm90IHN1cmUgd2h5IHlvdSBoYXZlIHRvIHdyaXRlIHlvdXIgb3duIE9TTCwgdGhpcyBzaG91
bGQgYWxyZWFkeSBiZSBwYXJ0IG9mIFFOWCwgYXNzdW1pbmcgdGhhdCBpdCBoYXMgQUNQSSBzdXBw
b3J0LCBhbmQgdXNlcyBBQ1BJQ0EgYXMgdGhlIHVuZGVybHlpbmcgQUNQSQ0KIHNvZnR3YXJlLjx1
PjwvdT48dT48L3U+PC9zcGFuPjwvcD4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPjxzcGFuIHN0eWxl
PSJjb2xvcjpyZ2IoMzEsNzMsMTI1KTtmb250LWZhbWlseTomcXVvdDtDYWxpYnJpJnF1b3Q7LHNh
bnMtc2VyaWY7Zm9udC1zaXplOjExcHQiPjx1PjwvdT7CoDx1PjwvdT48L3NwYW4+PC9wPg0KPHAg
Y2xhc3M9Ik1zb05vcm1hbCI+PHNwYW4gc3R5bGU9ImNvbG9yOnJnYigzMSw3MywxMjUpO2ZvbnQt
ZmFtaWx5OiZxdW90O0NhbGlicmkmcXVvdDssc2Fucy1zZXJpZjtmb250LXNpemU6MTFwdCI+VG8g
cHV0IHRoaXMgbW9yZSBzdWNjaW5jdGx5OsKgIEFDUElDQSBwcm92aWRlcyB0aGUgdW5kZXJseWlu
ZyBpbmZyYXN0cnVjdHVyZSBmb3IgQUNQSSBzdXBwb3J0IGluIGFuIE9TLiBCdXQsIHRoZSBPUyBt
dXN0IHByb3ZpZGUgaXRzIG93biBBQ1BJLXJlbGF0ZWQgZHJpdmVycyBhbmQNCiBvdGhlciBBQ1BJ
IHN1cHBvcnQuIFRoZSBFQyBkcml2ZXIgaXMgb25lIG9mIHRoZXNlIEFDUEktcmVsYXRlZCBkcml2
ZXJzLjx1PjwvdT48dT48L3U+PC9zcGFuPjwvcD4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPjxzcGFu
IHN0eWxlPSJjb2xvcjpyZ2IoMzEsNzMsMTI1KTtmb250LWZhbWlseTomcXVvdDtDYWxpYnJpJnF1
b3Q7LHNhbnMtc2VyaWY7Zm9udC1zaXplOjExcHQiPjx1PjwvdT7CoDx1PjwvdT48L3NwYW4+PC9w
Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+PHNwYW4gc3R5bGU9ImNvbG9yOnJnYigzMSw3MywxMjUp
O2ZvbnQtZmFtaWx5OiZxdW90O0NhbGlicmkmcXVvdDssc2Fucy1zZXJpZjtmb250LXNpemU6MTFw
dCI+Qm9iPHU+PC91Pjx1PjwvdT48L3NwYW4+PC9wPg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+PHNw
YW4gc3R5bGU9ImNvbG9yOnJnYigzMSw3MywxMjUpO2ZvbnQtZmFtaWx5OiZxdW90O0NhbGlicmkm
cXVvdDssc2Fucy1zZXJpZjtmb250LXNpemU6MTFwdCI+PHU+PC91PsKgPHU+PC91Pjwvc3Bhbj48
L3A+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj48c3BhbiBzdHlsZT0iY29sb3I6cmdiKDMxLDczLDEy
NSk7Zm9udC1mYW1pbHk6JnF1b3Q7Q2FsaWJyaSZxdW90OyxzYW5zLXNlcmlmO2ZvbnQtc2l6ZTox
MXB0Ij48dT48L3U+wqA8dT48L3U+PC9zcGFuPjwvcD4NCjxkaXYgc3R5bGU9ImJvcmRlci13aWR0
aDptZWRpdW0gbWVkaXVtIG1lZGl1bSAxLjVwdDtib3JkZXItc3R5bGU6bm9uZSBub25lIG5vbmUg
c29saWQ7Ym9yZGVyLWNvbG9yOmN1cnJlbnRDb2xvciBjdXJyZW50Q29sb3IgY3VycmVudENvbG9y
IGJsdWU7cGFkZGluZzowaW4gMGluIDBpbiA0cHQiPg0KPGRpdj4NCjxkaXYgc3R5bGU9ImJvcmRl
ci13aWR0aDoxcHQgbWVkaXVtIG1lZGl1bTtib3JkZXItc3R5bGU6c29saWQgbm9uZSBub25lO2Jv
cmRlci1jb2xvcjpyZ2IoMjI1LDIyNSwyMjUpIGN1cnJlbnRDb2xvciBjdXJyZW50Q29sb3I7cGFk
ZGluZzozcHQgMGluIDBpbiI+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj48Yj48c3BhbiBzdHlsZT0i
Zm9udC1mYW1pbHk6JnF1b3Q7Q2FsaWJyaSZxdW90OyxzYW5zLXNlcmlmO2ZvbnQtc2l6ZToxMXB0
Ij5Gcm9tOjwvc3Bhbj48L2I+PHNwYW4gc3R5bGU9ImZvbnQtZmFtaWx5OiZxdW90O0NhbGlicmkm
cXVvdDssc2Fucy1zZXJpZjtmb250LXNpemU6MTFwdCI+IERldmluIFN0ZWZmbGVyIFs8YSBocmVm
PSJtYWlsdG86ZGV2aW5zdGVmZmxlckBnbWFpbC5jb20iIHRhcmdldD0iX2JsYW5rIj5tYWlsdG86
ZGV2aW5zdGVmZmxlckBnbWFpbC5jbzx3YnI+bTwvYT5dDQo8YnI+DQo8Yj5TZW50OjwvYj4gVGh1
cnNkYXksIE1heSAyNSwgMjAxNyA3OjQ4IEFNPGJyPg0KPGI+VG86PC9iPiBNb29yZSwgUm9iZXJ0
ICZsdDs8YSBocmVmPSJtYWlsdG86cm9iZXJ0Lm1vb3JlQGludGVsLmNvbSIgdGFyZ2V0PSJfYmxh
bmsiPnJvYmVydC5tb29yZUBpbnRlbC5jb208L2E+Jmd0Ozxicj4NCjxiPkNjOjwvYj4gPGEgaHJl
Zj0ibWFpbHRvOmRldmVsQGFjcGljYS5vcmciIHRhcmdldD0iX2JsYW5rIj5kZXZlbEBhY3BpY2Eu
b3JnPC9hPjxicj4NCjxiPlN1YmplY3Q6PC9iPiBSZTogW0RldmVsXSBIZWxwIG5lZWRlZCBmb3Ig
JnF1b3Q7QUNQSSBFcnJvcjogTm8gaGFuZGxlciBmb3IgUmVnaW9uIFtFQ09SXSZxdW90OyAodXNp
bmcgbXkgb3duIE9TTCk8dT48L3U+PHU+PC91Pjwvc3Bhbj48L3A+DQo8L2Rpdj4NCjwvZGl2Pg0K
PHAgY2xhc3M9Ik1zb05vcm1hbCI+PHU+PC91PsKgPHU+PC91PjwvcD4NCjxkaXY+DQo8ZGl2Pg0K
PHAgY2xhc3M9Ik1zb05vcm1hbCI+SGkgUm9iZXJ0LDx1PjwvdT48dT48L3U+PC9wPg0KPC9kaXY+
DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+PHU+PC91PsKgPHU+PC91PjwvcD4NCjwvZGl2
Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPlRoYW5rcyBmb3IgeW91ciBpbnNpZ2h0Ljx1
PjwvdT48dT48L3U+PC9wPg0KPC9kaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+PHU+
PC91PsKgPHU+PC91PjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPkhv
dyBjYW4gSSBmaW5kIG91dCB3aGV0aGVyIGlzIGl0IGEgbWlzc2luZyBFQyBkcml2ZXIgb3IgdGhl
IEVDIGRyaXZlciBpc8KgZmFpbGluZyB0byBpbnN0YWxsIGEgaGFuZGxlciBmb3IgdGhlIEVDIG9w
ZXJhdGlvbiByZWdpb24/PHU+PC91Pjx1PjwvdT48L3A+DQo8L2Rpdj4NCjxkaXY+DQo8cCBjbGFz
cz0iTXNvTm9ybWFsIj48dT48L3U+wqA8dT48L3U+PC9wPg0KPC9kaXY+DQo8ZGl2Pg0KPHAgY2xh
c3M9Ik1zb05vcm1hbCI+SXMgdGhlIEVDIGRyaXZlciBzb21lIEMgY29kZSB0aGF0IEkgd291bGQg
YmUgZXhwZWN0ZWQgdG8gd3JpdGUgYXMgcGFydCBvZiB0aGUgT1NMIG9yIGlzIGl0IGV4cGVjdGVk
IHRvIGJlIGluY2x1ZGVkIHdpdGggdGhlIE9TIChRTlggaW4gdGhpcyBjYXNlKT88dT48L3U+PHU+
PC91PjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPjx1PjwvdT7CoDx1
PjwvdT48L3A+DQo8L2Rpdj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj5JIHN1c3BlY3Qg
dGhhdCB0aGUgcHJvYmxlbSBpcyBzb21ld2hlcmUgaW7CoG15IE9TTCAoc2luY2UgSSYjMzk7bSB2
ZXJ5IG5ldyB0byBBQ1BJKS4gRG8geW91IHRoaW5rIHRoaXMgaXMgbGlrZWx5IHRoZSBjYXNlPyBX
aGF0IHNob3VsZCBJIGZvY3VzIG9uIHRvIGRlYnVnIG15IE9TTCBpZiB0aGlzIGlzIHRoZSBjYXNl
Pzx1PjwvdT48dT48L3U+PC9wPg0KPC9kaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+
PHU+PC91PsKgPHU+PC91PjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwi
PkhlcmUmIzM5O3MgYW4gZXhjZXJwdCBmcm9tIHRoZSBMZW5vdm8mIzM5O3MgRFNEVC5kc2wgKGhv
cGluZyBpdCBoZWxwcyk6PHU+PC91Pjx1PjwvdT48L3A+DQo8L2Rpdj4NCjxkaXY+DQo8cCBjbGFz
cz0iTXNvTm9ybWFsIj4tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS08d2JyPi0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLTx3YnI+LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
PHdicj4tLS0tLTx1PjwvdT48dT48L3U+PC9wPg0KPC9kaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1z
b05vcm1hbCI+wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIERldmljZSAoRUMpPGJyPg0K
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHs8YnI+DQrCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBOYW1lIChfSElELCBFaXNhSWQgKCZxdW90O1BOUDBDMDkmcXVv
dDspIC8qIEVtYmVkZGVkIENvbnRyb2xsZXIgRGV2aWNlICovKcKgIC8vIF9ISUQ6IEhhcmR3YXJl
IElEPGJyPg0KwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgTmFtZSAoX1VJ
RCwgMHgwMCnCoCAvLyBfVUlEOiBVbmlxdWUgSUQ8YnI+DQrCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBOYW1lIChfR1BFLCAweDIwKcKgIC8vIF9HUEU6IEdlbmVyYWwgUHVy
cG9zZSBFdmVudHM8YnI+DQrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBN
ZXRob2QgKF9SRUcsIDIsIE5vdFNlcmlhbGl6ZWQpwqAgLy8gX1JFRzogUmVnaW9uIEF2YWlsYWJp
bGl0eTxicj4NCsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHs8YnI+DQrC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIElmICgoQXJnMCA9
PSAweDAzKSk8YnI+DQrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIHs8YnI+DQrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgXEg4RFIgPSBBcmcxPGJyPg0KwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCB9PGJyPg0KwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgfTx1PjwvdT48dT48L3U+PC9wPg0KPC9kaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05v
cm1hbCI+wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgT3BlcmF0aW9uUmVn
aW9uIChFQ09SLCBFbWJlZGRlZENvbnRyb2wsIDB4MDAsIDB4MDEwMCk8YnI+DQrCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBGaWVsZCAoRUNPUiwgQnl0ZUFjYywgTm9Mb2Nr
LCBQcmVzZXJ2ZSk8YnI+DQrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB7
PGJyPg0KwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBIREJN
LMKgwqAgMSwgPGJyPg0KwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgICzCoMKgIDEsIDxicj4NCsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgSEtMSyzCoMKgIDEsIDxicj4NCsKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgSEZORSzCoMKgIDEsIDxicj4NCsKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAswqDCoCAxLCA8YnI+
DQrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
LMKgwqAgMSwgPGJyPg0KwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBITERNLMKgwqAgMSwgPGJyPg0KwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBPZmZzZXQgKDB4MDEpLCA8YnI+DQrCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEJCTFMswqDCoCAxLCA8YnI+DQrCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEJUQ00swqDCoCAxLCA8YnI+DQrCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLMKgwqAg
MSwgPGJyPg0KwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgICzCoMKgIDEsIDxicj4NCsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCAswqDCoCAxLCA8YnI+DQrCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEhCUFIswqDCoCAxLCA8YnI+DQrCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEJUUEMswqDCoCAxLCA8YnI+DQrCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIE9mZnNldCAoMHgwMiks
IDxicj4NCsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgSERV
RSzCoMKgIDEsIDxicj4NCsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCAswqDCoCA0LCA8YnI+DQrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIFNOTEsswqDCoCAxLCA8YnI+DQrCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIE9mZnNldCAoMHgwMyksIDxicj4NCsKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAswqDCoCA1LCA8
YnI+DQrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEhBVU0s
wqDCoCAyLCA8YnI+DQrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIE9mZnNldCAoMHgwNSksIDxicj4NCsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgSFNQQSzCoMKgIDEsIDxicj4NCsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgT2Zmc2V0ICgweDA2KSwgPGJyPg0KwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBIU1VOLMKgwqAgOCwgPGJyPg0KwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBIU1JQLMKgwqAgOCwg
PGJyPg0KwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBPZmZz
ZXQgKDB4MDkpLCA8YnI+DQrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgLMKgwqAgNiwgPGJyPg0KwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBGTktTLMKgwqAgMSwgPGJyPg0KwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBPZmZzZXQgKDB4MEMpLCA8YnI+DQrCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEhMQ0wswqDCoCA4LCA8YnI+
DQrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
LMKgwqAgNCwgPGJyPg0KwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBDQUxNLMKgwqAgMSwgPGJyPg0KwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBPZmZzZXQgKDB4MEUpLCA8YnI+DQrCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEhGTlMswqDCoCAyLCA8YnI+DQrCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIE9mZnNldCAoMHgwRiksIDxicj4NCsKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAswqDC
oCA2LCA8YnI+DQrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IE5VTFMswqDCoCAxLCA8YnI+DQrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIE9mZnNldCAoMHgxMCksIDxicj4NCsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgSEFNMCzCoMKgIDgsIDxicj4NCsKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgSEFNMSzCoMKgIDgsIDxicj4NCsKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgSEFNMizCoMKgIDgsIDxicj4N
CsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgSEFNMyzCoMKg
IDgsIDxicj4NCsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
SEFNNCzCoMKgIDgsIDxicj4NCsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgSEFNNSzCoMKgIDgsIDxicj4NCsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgSEFNNizCoMKgIDgsIDxicj4NCsKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgSEFNNyzCoMKgIDgsIDxicj4NCsKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgSEFNOCzCoMKgIDgsIDxicj4NCsKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgSEFNOSzCoMKgIDgs
IDxicj4NCsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgSEFN
QSzCoMKgIDgsIDxicj4NCsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgSEFNQizCoMKgIDgsIDxicj4NCsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgSEFNQyzCoMKgIDgsIDxicj4NCsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgSEFNRCzCoMKgIDgsIDxicj4NCsKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgSEFNRSzCoMKgIDgsIDxicj4NCsKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgSEFNRizCoMKgIDgsIDxi
cj4NCsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgT2Zmc2V0
ICgweDIzKSwgPGJyPg0KwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBIQU5ULMKgwqAgOCwgPGJyPg0KwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBPZmZzZXQgKDB4MjYpLCA8YnI+DQrCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLMKgwqAgMiwgPGJyPg0KwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBIQU5BLMKgwqAgMiwgPGJyPg0K
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBPZmZzZXQgKDB4
MjcpLCA8YnI+DQrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IE9mZnNldCAoMHgyOCksIDxicj4NCsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCAswqDCoCAxLCA8YnI+DQrCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFNLRU0swqDCoCAxLCA8YnI+DQrCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIE9mZnNldCAoMHgyOSksIDxicj4NCsKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgT2Zmc2V0ICgweDJB
KSwgPGJyPg0KwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBI
QVRSLMKgwqAgOCwgPGJyPg0KwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBIVDBILMKgwqAgOCwgPGJyPg0KwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBIVDBMLMKgwqAgOCwgPGJyPg0KwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBIVDFILMKgwqAgOCwgPGJyPg0KwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBIVDFMLMKgwqAgOCwgPGJyPg0KwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBIRlNQLMKgwqAgOCwg
PGJyPg0KwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgICzCoMKgIDYsIDxicj4NCsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgSE1VVCzCoMKgIDEsIDxicj4NCsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgT2Zmc2V0ICgweDMxKSwgPGJyPg0KwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICzCoMKgIDIsIDxicj4NCsKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgSFVXQizCoMKgIDEsIDxi
cj4NCsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCAswqDCoCAzLCA8YnI+DQrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIFZQT04swqDCoCAxLCA8YnI+DQrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIFZSU1QswqDCoCAxLCA8YnI+DQrCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEhXUE0swqDCoCAxLCA8YnI+DQrCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEhXTEIswqDCoCAxLCA8YnI+DQrCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEhXTE8swqDCoCAxLCA8
YnI+DQrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEhXREss
wqDCoCAxLCA8YnI+DQrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIEhXRk4swqDCoCAxLCA8YnI+DQrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIEhXQlQswqDCoCAxLCA8YnI+DQrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIEhXUkkswqDCoCAxLCA8YnI+DQrCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEhXQlUswqDCoCAxLCA8YnI+DQrCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEhXTFUswqDCoCAxLCA8YnI+
DQrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIE9mZnNldCAo
MHgzNCksIDxicj4NCsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCAswqDCoCAzLCA8YnI+DQrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIFBJQlMswqDCoCAxLCA8YnI+DQrCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLMKgwqAgMywgPGJyPg0KwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBIUExPLMKgwqAgMSwgPGJyPg0K
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBPZmZzZXQgKDB4
MzYpLCA8YnI+DQrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IEhXQUMswqDCoCAxNiwgPGJyPg0KwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBIQjBTLMKgwqAgNywgPGJyPg0KwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBIQjBBLMKgwqAgMSwgPGJyPg0KwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBIQjFTLMKgwqAgNywgPGJyPg0KwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBIQjFBLMKgwqAgMSwgPGJyPg0K
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBIQ01VLMKgwqAg
MSwgPGJyPg0KwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgICzCoMKgIDIsIDxicj4NCsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgT1ZSUSzCoMKgIDEsIDxicj4NCsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgRENCRCzCoMKgIDEsIDxicj4NCsKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgRENXTCzCoMKgIDEsIDxicj4NCsKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgRENXVyzCoMKgIDEsIDxicj4N
CsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgSEIxSSzCoMKg
IDEsIDxicj4NCsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCAswqDCoCAxLCA8YnI+DQrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIEtCTFQswqDCoCAxLCA8YnI+DQrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIEJUUFcswqDCoCAxLCA8YnI+DQrCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEZOS0MswqDCoCAxLCA8YnI+DQrCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEhVQlMswqDCoCAxLCA8YnI+
DQrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEJEUFcswqDC
oCAxLCA8YnI+DQrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IEJERFQswqDCoCAxLCA8YnI+DQrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIEhVQkIswqDCoCAxLCA8YnI+DQrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIE9mZnNldCAoMHg0NiksIDxicj4NCsKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAswqDCoCAxLCA8YnI+DQrCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEJUV0sswqDCoCAxLCA8
YnI+DQrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEhQTEQs
wqDCoCAxLCA8YnI+DQrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgLMKgwqAgMSwgPGJyPg0KwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBIUEFDLMKgwqAgMSwgPGJyPg0KwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBCVFNULMKgwqAgMSwgPGJyPg0KwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBPZmZzZXQgKDB4NDcpLCA8YnI+DQrC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEhQQlUswqDCoCAx
LCA8YnI+DQrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgLMKgwqAgMSwgPGJyPg0KwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBIQklELMKgwqAgMSwgPGJyPg0KwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICzCoMKgIDMsIDxicj4NCsKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgSEJDUyzCoMKgIDEsIDxicj4NCsKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgSFBORizCoMKgIDEsIDxi
cj4NCsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCAswqDCoCAxLCA8YnI+DQrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIEdTVFMswqDCoCAxLCA8YnI+DQrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLMKgwqAgMiwgPGJyPg0KwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBITEJVLMKgwqAgMSwgPGJyPg0KwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBET0NELMKgwqAgMSwgPGJyPg0K
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBIQ0JMLMKgwqAg
MSwgPGJyPg0KwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBP
ZmZzZXQgKDB4NDkpLCA8YnI+DQrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIFNMVUwswqDCoCAxLCA8YnI+DQrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIE9mZnNldCAoMHg0QyksIDxicj4NCsKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgSFRNSCzCoMKgIDgsIDxicj4NCsKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgSFRNTCzCoMKgIDgsIDxicj4N
CsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgSFdBSyzCoMKg
IDE2LCA8YnI+DQrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IEhNUFIswqDCoCA4LCA8YnI+DQrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgLMKgwqAgNywgPGJyPg0KwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBITUROLMKgwqAgMSwgPGJyPg0KwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBPZmZzZXQgKDB4NzgpLCA8YnI+DQrCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFRNUDAswqDCoCA4LCA8
YnI+DQrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIE9mZnNl
dCAoMHg4MCksIDxicj4NCsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgT2Zmc2V0ICgweDgxKSwgPGJyPg0KwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBISUlELMKgwqAgOCwgPGJyPg0KwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBPZmZzZXQgKDB4ODMpLCA8YnI+DQrCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEhGTkkswqDCoCA4LCA8YnI+DQrC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEhTUEQswqDCoCAx
NiwgPGJyPg0KwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBP
ZmZzZXQgKDB4ODgpLCA8YnI+DQrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIFRTTDAswqDCoCA3LCA8YnI+DQrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIFRTUjAswqDCoCAxLCA8YnI+DQrCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFRTTDEswqDCoCA3LCA8YnI+DQrCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFRTUjEswqDCoCAxLCA8YnI+DQrC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFRTTDIswqDCoCA3
LCA8YnI+DQrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFRT
UjIswqDCoCAxLCA8YnI+DQrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIFRTTDMswqDCoCA3LCA8YnI+DQrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIFRTUjMswqDCoCAxLCA8YnI+DQrCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIE9mZnNldCAoMHg4RCksIDxicj4NCsKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgSERBQSzCoMKgIDMsIDxicj4NCsKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgSERBQizCoMKgIDMs
IDxicj4NCsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgSERB
QyzCoMKgIDIsIDxicj4NCsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgUkNCRCzCoMKgIDEsIDxicj4NCsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgUkNXTCzCoMKgIDEsIDxicj4NCsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgUkNXVyzCoMKgIDEsIDxicj4NCsKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgT2Zmc2V0ICgweEIwKSwgPGJyPg0KwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBIREVOLMKgwqAgMzIs
IDxicj4NCsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgSERF
UCzCoMKgIDMyLCA8YnI+DQrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIEhERU0swqDCoCA4LCA8YnI+DQrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIEhERVMswqDCoCA4LCA8YnI+DQrCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIE9mZnNldCAoMHhDOCksIDxicj4NCsKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgQVRNWCzCoMKgIDgsIDxicj4NCsKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgSFdBVCzCoMKgIDgs
IDxicj4NCsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgT2Zm
c2V0ICgweENDKSwgPGJyPg0KwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBQV01ILMKgwqAgOCwgPGJyPg0KwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBQV01MLMKgwqAgOCwgPGJyPg0KwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBPZmZzZXQgKDB4RUQpLCA8YnI+DQrCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLMKgwqAgNCwgPGJy
Pg0KwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBIRERELMKg
wqAgMTxicj4NCsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIH08dT48L3U+
PHU+PC91PjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj4t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS08d2JyPi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLTx3YnI+LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tPHdicj4tLS0tLTx1Pjwv
dT48dT48L3U+PC9wPg0KPC9kaXY+DQo8L2Rpdj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFs
Ij48dT48L3U+wqA8dT48L3U+PC9wPg0KPC9kaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1h
bCI+TWFueSB0aGFua3MsPGJyPg0KRGV2aW48dT48L3U+PHU+PC91PjwvcD4NCjwvZGl2Pg0KPGRp
dj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPjx1PjwvdT7CoDx1PjwvdT48L3A+DQo8L2Rpdj4NCjwv
ZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPjx1PjwvdT7CoDx1PjwvdT48L3A+DQo8
ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+T24gVGh1LCBNYXkgMjUsIDIwMTcgYXQgMTA6MTUg
QU0sIE1vb3JlLCBSb2JlcnQgJmx0OzxhIGhyZWY9Im1haWx0bzpyb2JlcnQubW9vcmVAaW50ZWwu
Y29tIiB0YXJnZXQ9Il9ibGFuayI+cm9iZXJ0Lm1vb3JlQGludGVsLmNvbTwvYT4mZ3Q7IHdyb3Rl
Ojx1PjwvdT48dT48L3U+PC9wPg0KPGJsb2NrcXVvdGUgc3R5bGU9ImJvcmRlci13aWR0aDptZWRp
dW0gbWVkaXVtIG1lZGl1bSAxcHQ7Ym9yZGVyLXN0eWxlOm5vbmUgbm9uZSBub25lIHNvbGlkO2Jv
cmRlci1jb2xvcjpjdXJyZW50Q29sb3IgY3VycmVudENvbG9yIGN1cnJlbnRDb2xvciByZ2IoMjA0
LDIwNCwyMDQpO21hcmdpbjo1cHQgMGluIDVwdCA0LjhwdDtwYWRkaW5nOjBpbiAwaW4gMGluIDZw
dCI+DQo8ZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPkFDUEkgRXJyb3I6IFJlZ2lv
biBFbWJlZGRlZENvbnRyb2wgKElEPTMpIGhhcyBubyBoYW5kbGVyICgyMDE3MDMwMy9leGZsZGlv
LTQzMSk8dT48L3U+PHU+PC91PjwvcD4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPjxzcGFuIHN0eWxl
PSJjb2xvcjpyZ2IoMzEsNzMsMTI1KTtmb250LWZhbWlseTomcXVvdDtDYWxpYnJpJnF1b3Q7LHNh
bnMtc2VyaWY7Zm9udC1zaXplOjExcHQiPsKgPC9zcGFuPjx1PjwvdT48dT48L3U+PC9wPg0KPHAg
Y2xhc3M9Ik1zb05vcm1hbCI+PHNwYW4gc3R5bGU9ImNvbG9yOnJnYigzMSw3MywxMjUpO2ZvbnQt
ZmFtaWx5OiZxdW90O0NhbGlicmkmcXVvdDssc2Fucy1zZXJpZjtmb250LXNpemU6MTFwdCI+WW91
IGVpdGhlciBkb27igJl0IGhhdmUgYSBkcml2ZXIgZm9yIHRoZSBFQywgb3IgeW91ciBFQyBkcml2
ZXIgaGFzIG5vdCBpbnN0YWxsZWQgYSBoYW5kbGVyIGZvciB0aGUgRUMNCiBvcGVyYXRpb24gcmVn
aW9uLjwvc3Bhbj48dT48L3U+PHU+PC91PjwvcD4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPjxzcGFu
IHN0eWxlPSJjb2xvcjpyZ2IoMzEsNzMsMTI1KTtmb250LWZhbWlseTomcXVvdDtDYWxpYnJpJnF1
b3Q7LHNhbnMtc2VyaWY7Zm9udC1zaXplOjExcHQiPsKgPC9zcGFuPjx1PjwvdT48dT48L3U+PC9w
Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+PHNwYW4gc3R5bGU9ImNvbG9yOnJnYigzMSw3MywxMjUp
O2ZvbnQtZmFtaWx5OiZxdW90O0NhbGlicmkmcXVvdDssc2Fucy1zZXJpZjtmb250LXNpemU6MTFw
dCI+SSB3b3VsZCBndWVzcy48L3NwYW4+PHU+PC91Pjx1PjwvdT48L3A+DQo8cCBjbGFzcz0iTXNv
Tm9ybWFsIj48c3BhbiBzdHlsZT0iY29sb3I6cmdiKDMxLDczLDEyNSk7Zm9udC1mYW1pbHk6JnF1
b3Q7Q2FsaWJyaSZxdW90OyxzYW5zLXNlcmlmO2ZvbnQtc2l6ZToxMXB0Ij7CoDwvc3Bhbj48dT48
L3U+PHU+PC91PjwvcD4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPjxzcGFuIHN0eWxlPSJjb2xvcjpy
Z2IoMzEsNzMsMTI1KTtmb250LWZhbWlseTomcXVvdDtDYWxpYnJpJnF1b3Q7LHNhbnMtc2VyaWY7
Zm9udC1zaXplOjExcHQiPsKgPC9zcGFuPjx1PjwvdT48dT48L3U+PC9wPg0KPHAgY2xhc3M9Ik1z
b05vcm1hbCI+PHNwYW4gc3R5bGU9ImNvbG9yOnJnYigzMSw3MywxMjUpO2ZvbnQtZmFtaWx5OiZx
dW90O0NhbGlicmkmcXVvdDssc2Fucy1zZXJpZjtmb250LXNpemU6MTFwdCI+wqA8L3NwYW4+PHU+
PC91Pjx1PjwvdT48L3A+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj48c3BhbiBzdHlsZT0iY29sb3I6
cmdiKDMxLDczLDEyNSk7Zm9udC1mYW1pbHk6JnF1b3Q7Q2FsaWJyaSZxdW90OyxzYW5zLXNlcmlm
O2ZvbnQtc2l6ZToxMXB0Ij7CoDwvc3Bhbj48dT48L3U+PHU+PC91PjwvcD4NCjxkaXYgc3R5bGU9
ImJvcmRlci13aWR0aDptZWRpdW0gbWVkaXVtIG1lZGl1bSAxLjVwdDtib3JkZXItc3R5bGU6bm9u
ZSBub25lIG5vbmUgc29saWQ7Ym9yZGVyLWNvbG9yOmN1cnJlbnRDb2xvciBjdXJyZW50Q29sb3Ig
Y3VycmVudENvbG9yIGJsdWU7cGFkZGluZzowaW4gMGluIDBpbiA0cHQiPg0KPGRpdj4NCjxkaXYg
c3R5bGU9ImJvcmRlci13aWR0aDoxcHQgbWVkaXVtIG1lZGl1bTtib3JkZXItc3R5bGU6c29saWQg
bm9uZSBub25lO2JvcmRlci1jb2xvcjpjdXJyZW50Q29sb3I7cGFkZGluZzozcHQgMGluIDBpbiI+
DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj48Yj48c3BhbiBzdHlsZT0iZm9udC1mYW1pbHk6JnF1b3Q7
Q2FsaWJyaSZxdW90OyxzYW5zLXNlcmlmO2ZvbnQtc2l6ZToxMXB0Ij5Gcm9tOjwvc3Bhbj48L2I+
PHNwYW4gc3R5bGU9ImZvbnQtZmFtaWx5OiZxdW90O0NhbGlicmkmcXVvdDssc2Fucy1zZXJpZjtm
b250LXNpemU6MTFwdCI+IERldmVsIFttYWlsdG86PGEgaHJlZj0ibWFpbHRvOmRldmVsLWJvdW5j
ZXNAYWNwaWNhLm9yZyIgdGFyZ2V0PSJfYmxhbmsiPmRldmVsLWJvdW5jZXNAYWNwaWNhLm88d2Jy
PnJnPC9hPl0NCjxiPk9uIEJlaGFsZiBPZiA8L2I+RGV2aW4gU3RlZmZsZXI8YnI+DQo8Yj5TZW50
OjwvYj4gVGh1cnNkYXksIE1heSAyNSwgMjAxNyA2OjE1IEFNPGJyPg0KPGI+VG86PC9iPiA8YSBo
cmVmPSJtYWlsdG86ZGV2ZWxAYWNwaWNhLm9yZyIgdGFyZ2V0PSJfYmxhbmsiPmRldmVsQGFjcGlj
YS5vcmc8L2E+PGJyPg0KPGI+U3ViamVjdDo8L2I+IFtEZXZlbF0gSGVscCBuZWVkZWQgZm9yICZx
dW90O0FDUEkgRXJyb3I6IE5vIGhhbmRsZXIgZm9yIFJlZ2lvbiBbRUNPUl0mcXVvdDsgKHVzaW5n
IG15IG93biBPU0wpPC9zcGFuPjx1PjwvdT48dT48L3U+PC9wPg0KPC9kaXY+DQo8L2Rpdj4NCjxk
aXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+wqA8dT48L3U+PHU+PC91PjwvcD4NCjxk
aXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj5IZWxsbyw8dT48L3U+PHU+PC91PjwvcD4NCjxkaXY+
DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj7CoDx1PjwvdT48dT48L3U+PC9wPg0KPC9kaXY+DQo8ZGl2
Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+SSBhbSB3b3JraW5nIG9uIGFuIE9TTCBmb3IgUU5YLiBJ
IGFtIGdldHRpbmcgc29tZSBlcnJvcnMgcHJpbnRlZCBvdXQgZHVyaW5nwqBBY3BpSW5pdGlhbGl6
ZU9iamVjdHMgYnV0IG9ubHkgaW4gb25lIG91dCBvZiB0aHJlZSBsYXB0b3BzIHRoYXQgSSBhbSB0
ZXN0aW5nLiBBIERlbGwgYW5kIEFTVVMgbGFwdG9wDQogZG8gbm90IGhhdmUgdGhlIGVycm9ycyBi
dXQgYSBMZW5vdm8gbGFwdG9wIGRvZXMuIEkgYW0gYWJsZSB0byByZWFkIGJhdHRlcnkgc3RhdHVz
IChfQlNUKSBvbiB0aGUgRGVsbCBhbmQgQVNVUyBsYXB0b3BzIGJ1dCBub3Qgb24gdGhlIExlbm92
byBsYXB0b3AuPHU+PC91Pjx1PjwvdT48L3A+DQo8L2Rpdj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNv
Tm9ybWFsIj7CoDx1PjwvdT48dT48L3U+PC9wPg0KPC9kaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1z
b05vcm1hbCI+VGhlIEFDUElDQSB2ZXJzaW9uIEkgYW0gdXNpbmcgaXMgMjAxNzAzMDMuPHU+PC91
Pjx1PjwvdT48L3A+DQo8L2Rpdj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj7CoDx1Pjwv
dT48dT48L3U+PC9wPg0KPC9kaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+U29tZSBx
dWVzdGlvbnMgSSBoYXZlIGFyZTo8dT48L3U+PHU+PC91PjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxw
IGNsYXNzPSJNc29Ob3JtYWwiPi0gSXMgdGhpcyB0aGUgY29ycmVjdCBtYWlsaW5nIGxpc3QgZm9y
IHRoaXMgZW1haWw/PHU+PC91Pjx1PjwvdT48L3A+DQo8L2Rpdj4NCjxkaXY+DQo8cCBjbGFzcz0i
TXNvTm9ybWFsIj4tIERvZXMgdGhpcyBhcHBlYXIgdG8gYmUgYSBidWcgaW4gQUNQSUNBLCBpbiBt
eSBPU0wsIG9yIHNvbWV3aGVyZSBlbHNlIChtYXliZSB0aGUgbGFwdG9wIEJJT1MpPzx1PjwvdT48
dT48L3U+PC9wPg0KPC9kaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+LSBTaG91bGQg
SSByYWlzZSBhIGJ1ZyBmb3IgdGhpcz88dT48L3U+PHU+PC91PjwvcD4NCjwvZGl2Pg0KPGRpdj4N
CjxwIGNsYXNzPSJNc29Ob3JtYWwiPi0gV291bGQgeW91IHByb3ZpZGUgYW55IHJlY29tbWVuZGF0
aW9ucyB0byBoZWxwIG1lIHRyb3VibGVzaG9vdCB0aGlzPzx1PjwvdT48dT48L3U+PC9wPg0KPC9k
aXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+LSBXaGF0IG90aGVyIGluZm9ybWF0aW9u
IHNob3VsZCBJIHByb3ZpZGU/PHU+PC91Pjx1PjwvdT48L3A+DQo8L2Rpdj4NCjxkaXY+DQo8cCBj
bGFzcz0iTXNvTm9ybWFsIj7CoDx1PjwvdT48dT48L3U+PC9wPg0KPC9kaXY+DQo8ZGl2Pg0KPHAg
Y2xhc3M9Ik1zb05vcm1hbCI+VGhpcyBpcyB0aGUgb3V0cHV0IGR1cmluZyBBQ1BJIGluaXRpYWxp
emF0aW9uIG9uIHRoZSBwcm9ibGVtYXRpYyBsYXB0b3AgKGZyb20gbXkgT1NMKTo8dT48L3U+PHU+
PC91PjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj4tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS08d2JyPi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLTx3YnI+LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tPHdicj4tLS0tLS08dT48L3U+
PHU+PC91PjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPkFDUEk6IFJT
RFAgMHgwMDAwMDAwMDAwMEYwMTIwIDAwMDAyNCAodjAyIExFTk9WTyk8dT48L3U+PHU+PC91Pjwv
cD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPkFDUEk6IFhTRFQgMHgwMDAw
MDAwMEQ3RkQyMTg4IDAwMDBDQyAodjAxIExFTk9WTyBUUC1SMDAgwqAgMDAwMDAwMDAgUFRFQyAw
MDAwMDAwMik8dT48L3U+PHU+PC91PjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29O
b3JtYWwiPkFDUEk6IEZBQ1AgMHgwMDAwMDAwMEQ3RkY3MDAwIDAwMDBGNCAodjA1IExFTk9WTyBU
UC1SMDAgwqAgMDAwMDA0MjAgUFRFQyAwMDAwMDAwMik8dT48L3U+PHU+PC91PjwvcD4NCjwvZGl2
Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPkFDUEk6IERTRFQgMHgwMDAwMDAwMEQ3RkRF
MDAwIDAxMTQ1MSAodjAyIExFTk9WTyBUUC1SMDAgwqAgMDAwMDA0MjAgSU5UTCAyMDE0MTEwNyk8
dT48L3U+PHU+PC91PjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPkFD
UEk6IEZBQ1MgMHgwMDAwMDAwMEQ3RkEyMDAwIDAwMDA0MDx1PjwvdT48dT48L3U+PC9wPg0KPC9k
aXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+QUNQSTogVUVGSSAweDAwMDAwMDAwRDdG
QjkwMDAgMDAwMDQyICh2MDEgTEVOT1ZPIFRQLVIwMCDCoCAwMDAwMDQyMCBQVEVDIDAwMDAwMDAy
KTx1PjwvdT48dT48L3U+PC9wPg0KPC9kaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+
QUNQSTogU1NEVCAweDAwMDAwMDAwRDdGRjgwMDAgMDA0RTBBICh2MDIgTEVOT1ZPIFNhU3NkdCDC
oCAwMDAwMzAwMCBJTlRMIDIwMTQxMTA3KTx1PjwvdT48dT48L3U+PC9wPg0KPC9kaXY+DQo8ZGl2
Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+QUNQSTogQVNGISAweDAwMDAwMDAwRDdGRjYwMDAgMDAw
MEE1ICh2MzIgTEVOT1ZPIFRQLVIwMCDCoCAwMDAwMDQyMCBQVEVDIDAwMDAwMDAyKTx1PjwvdT48
dT48L3U+PC9wPg0KPC9kaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+QUNQSTogRUNE
VCAweDAwMDAwMDAwRDdGRjUwMDAgMDAwMDUyICh2MDEgTEVOT1ZPIFRQLVIwMCDCoCAwMDAwMDQy
MCBQVEVDIDAwMDAwMDAyKTx1PjwvdT48dT48L3U+PC9wPg0KPC9kaXY+DQo8ZGl2Pg0KPHAgY2xh
c3M9Ik1zb05vcm1hbCI+QUNQSTogSFBFVCAweDAwMDAwMDAwRDdGRjQwMDAgMDAwMDM4ICh2MDEg
TEVOT1ZPIFRQLVIwMCDCoCAwMDAwMDQyMCBQVEVDIDAwMDAwMDAyKTx1PjwvdT48dT48L3U+PC9w
Pg0KPC9kaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+QUNQSTogTFBJVCAweDAwMDAw
MDAwRDdGRjMwMDAgMDAwMDk0ICh2MDEgTEVOT1ZPIFRQLVIwMCDCoCAwMDAwMDQyMCBQVEVDIDAw
MDAwMDAyKTx1PjwvdT48dT48L3U+PC9wPg0KPC9kaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05v
cm1hbCI+QUNQSTogQVBJQyAweDAwMDAwMDAwRDdGRjIwMDAgMDAwMEJDICh2MDMgTEVOT1ZPIFRQ
LVIwMCDCoCAwMDAwMDQyMCBQVEVDIDAwMDAwMDAyKTx1PjwvdT48dT48L3U+PC9wPg0KPC9kaXY+
DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+QUNQSTogTUNGRyAweDAwMDAwMDAwRDdGRjEw
MDAgMDAwMDNDICh2MDEgTEVOT1ZPIFRQLVIwMCDCoCAwMDAwMDQyMCBQVEVDIDAwMDAwMDAyKTx1
PjwvdT48dT48L3U+PC9wPg0KPC9kaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+QUNQ
STogV0RBVCAweDAwMDAwMDAwRDdGRjAwMDAgMDAwMTM0ICh2MDEgTEVOT1ZPIFRQLVIwMCDCoCAw
MDAwMDQyMCBQVEVDIDAwMDAwMDAyKTx1PjwvdT48dT48L3U+PC9wPg0KPC9kaXY+DQo8ZGl2Pg0K
PHAgY2xhc3M9Ik1zb05vcm1hbCI+QUNQSTogU1NEVCAweDAwMDAwMDAwRDdGREMwMDAgMDAxQUZD
ICh2MDEgTEVOT1ZPIFNhdGFBaGNpIDAwMDAxMDAwIElOVEwgMjAxNDExMDcpPHU+PC91Pjx1Pjwv
dT48L3A+DQo8L2Rpdj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj5BQ1BJOiBEQkdQIDB4
MDAwMDAwMDBEN0ZEQjAwMCAwMDAwMzQgKHYwMSBMRU5PVk8gVFAtUjAwIMKgIDAwMDAwNDIwIFBU
RUMgMDAwMDAwMDIpPHU+PC91Pjx1PjwvdT48L3A+DQo8L2Rpdj4NCjxkaXY+DQo8cCBjbGFzcz0i
TXNvTm9ybWFsIj5BQ1BJOiBEQkcyIDB4MDAwMDAwMDBEN0ZEQTAwMCAwMDAwNTQgKHYwMCBMRU5P
Vk8gVFAtUjAwIMKgIDAwMDAwNDIwIFBURUMgMDAwMDAwMDIpPHU+PC91Pjx1PjwvdT48L3A+DQo8
L2Rpdj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj5BQ1BJOiBCT09UIDB4MDAwMDAwMDBE
N0ZEOTAwMCAwMDAwMjggKHYwMSBMRU5PVk8gVFAtUjAwIMKgIDAwMDAwNDIwIFBURUMgMDAwMDAw
MDIpPHU+PC91Pjx1PjwvdT48L3A+DQo8L2Rpdj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFs
Ij5BQ1BJOiBCQVRCIDB4MDAwMDAwMDBEN0ZEODAwMCAwMDAwNDYgKHYwMSBMRU5PVk8gVFAtUjAw
IMKgIDAwMDAwNDIwIFBURUMgMDAwMDAwMDIpPHU+PC91Pjx1PjwvdT48L3A+DQo8L2Rpdj4NCjxk
aXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj5BQ1BJOiBTTElDIDB4MDAwMDAwMDBEN0ZENzAwMCAw
MDAxNzYgKHYwMSBMRU5PVk8gVFAtUjAwIMKgIDAwMDAwNDIwIFBURUMgMDAwMDAwMDIpPHU+PC91
Pjx1PjwvdT48L3A+DQo8L2Rpdj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj5BQ1BJOiBT
U0RUIDB4MDAwMDAwMDBEN0ZENjAwMCAwMDBFNTggKHYwMiBMRU5PVk8gQ3B1U3NkdCDCoDAwMDAz
MDAwIElOVEwgMjAxNDExMDcpPHU+PC91Pjx1PjwvdT48L3A+DQo8L2Rpdj4NCjxkaXY+DQo8cCBj
bGFzcz0iTXNvTm9ybWFsIj5BQ1BJOiBTU0RUIDB4MDAwMDAwMDBEN0ZENTAwMCAwMDAzRDkgKHYw
MiBMRU5PVk8gQ3RkcEIgwqAgwqAwMDAwMTAwMCBJTlRMIDIwMTQxMTA3KTx1PjwvdT48dT48L3U+
PC9wPg0KPC9kaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+QUNQSTogTVNETSAweDAw
MDAwMDAwRDdGRDQwMDAgMDAwMDU1ICh2MDMgTEVOT1ZPIFRQLVIwMCDCoCAwMDAwMDQyMCBQVEVD
IDAwMDAwMDAyKTx1PjwvdT48dT48L3U+PC9wPg0KPC9kaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1z
b05vcm1hbCI+QUNQSTogRlBEVCAweDAwMDAwMDAwRDdGRDMwMDAgMDAwMDQ0ICh2MDEgTEVOT1ZP
IFRQLVIwMCDCoCAwMDAwMDQyMCBQVEVDIDAwMDAwMDAyKTx1PjwvdT48dT48L3U+PC9wPg0KPC9k
aXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+QUNQSTogVUVGSSAweDAwMDAwMDAwRDdG
QTAwMDAgMDAwMTJBICh2MDEgTEVOT1ZPIFRQLVIwMCDCoCAwMDAwMDQyMCBQVEVDIDAwMDAwMDAy
KTx1PjwvdT48dT48L3U+PC9wPg0KPC9kaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+
wqA8dT48L3U+PHU+PC91PjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwi
PkluaXRpYWxpemluZyBOYW1lc3BhY2Ugb2JqZWN0czo8dT48L3U+PHU+PC91PjwvcD4NCjwvZGl2
Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPlRhYmxlIFtEU0RUOiBUUC1SMDAgwqBdIChp
ZCAwMSkgLSAyNzU3IE9iamVjdHMgd2l0aCDCoDc2IERldmljZXMsIMKgNDAgUmVnaW9ucywgwqA1
MTAgTWV0aG9kcyAoMTQwLzM3MC8yNCBTZXJpYWwvTm9uL0N2dCk8dT48L3U+PHU+PC91PjwvcD4N
CjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPlRhYmxlIFtTU0RUOiBTYVNzZHQg
wqBdIChpZCAwMikgLSDCoDU1MiBPYmplY3RzIHdpdGggwqAxOCBEZXZpY2VzLCDCoDIwIFJlZ2lv
bnMsIMKgMTMxIE1ldGhvZHMgKDQxLzkwLzcgU2VyaWFsL05vbi9DdnQpPHU+PC91Pjx1PjwvdT48
L3A+DQo8L2Rpdj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj5UYWJsZSBbU1NEVDogU2F0
YUFoY2ldIChpZCAwMykgLSDCoDE4MyBPYmplY3RzIHdpdGggwqAgOCBEZXZpY2VzLCDCoCAwIFJl
Z2lvbnMsIMKgIDM0IE1ldGhvZHMgKDI1LzkvNSBTZXJpYWwvTm9uL0N2dCk8dT48L3U+PHU+PC91
PjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPlRhYmxlIFtTU0RUOiBD
cHVTc2R0IF0gKGlkIDA0KSAtIMKgMTE0IE9iamVjdHMgd2l0aCDCoCAwIERldmljZXMsIMKgIDMg
UmVnaW9ucywgwqAgMjkgTWV0aG9kcyAoMTMvMTYvMTMgU2VyaWFsL05vbi9DdnQpPHU+PC91Pjx1
PjwvdT48L3A+DQo8L2Rpdj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj5UYWJsZSBbU1NE
VDogQ3RkcEIgwqAgXSAoaWQgMDUpIC0gwqAgMzMgT2JqZWN0cyB3aXRoIMKgIDAgRGV2aWNlcywg
wqAgMSBSZWdpb25zLCDCoCDCoDUgTWV0aG9kcyAoMi8zLzEgU2VyaWFsL05vbi9DdnQpPHU+PC91
Pjx1PjwvdT48L3A+DQo8L2Rpdj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj5BQ1BJOiA1
IEFDUEkgQU1MIHRhYmxlcyBzdWNjZXNzZnVsbHkgYWNxdWlyZWQgYW5kIGxvYWRlZDx1PjwvdT48
dT48L3U+PC9wPg0KPC9kaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+Q29tcGxldGlu
ZyBSZWdpb24vRmllbGQvQnVmZmVyL1BhY2thZ2UgaW5pdGlhbGl6YXRpb246PHU+PC91Pjx1Pjwv
dT48L3A+DQo8L2Rpdj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj7CoCDCoCBJbml0aWFs
aXplZCA2My82NCBSZWdpb25zIDcxLzcxIEZpZWxkcyA4OC84OCBCdWZmZXJzIDgzLzgzIFBhY2th
Z2VzICgzNjQ4IG5vZGVzKTx1PjwvdT48dT48L3U+PC9wPg0KPC9kaXY+DQo8ZGl2Pg0KPHAgY2xh
c3M9Ik1zb05vcm1hbCI+wqBldnhmZXZudC0wMjE4IEVuYWJsZSDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoDogVHJhbnNpdGlvbiB0byBBQ1BJIG1vZGUgc3VjY2Vzc2Z1bDx1PjwvdT48dT48L3U+PC9w
Pg0KPC9kaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+SW5pdGlhbGl6aW5nIEdlbmVy
YWwgUHVycG9zZSBFdmVudHMgKEdQRXMpOjx1PjwvdT48dT48L3U+PC9wPg0KPC9kaXY+DQo8ZGl2
Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+wqAgwqAgSW5pdGlhbGl6ZWQgR1BFIDAwIHRvIDdGIFtf
R1BFXSAxNiByZWdzIG9uIGludGVycnVwdCAweDkgKFNDSSk8dT48L3U+PHU+PC91PjwvcD4NCjwv
ZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPkluaXRpYWxpemluZyBEZXZpY2UvUHJv
Y2Vzc29yL1RoZXJtYWwgb2JqZWN0cyBhbmQgZXhlY3V0aW5nIF9JTkkvX1NUQSBtZXRob2RzOjx1
PjwvdT48dT48L3U+PC9wPg0KPC9kaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+QUNQ
SSBFcnJvcjogTm8gaGFuZGxlciBmb3IgUmVnaW9uIFtFQ09SXSAoODBkYTEzMCkgW0VtYmVkZGVk
Q29udHJvbF0gKDIwMTcwMzAzL2V2cmVnaW9uLTI5MSk8dT48L3U+PHU+PC91PjwvcD4NCjwvZGl2
Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPkFDUEkgRXJyb3I6IFJlZ2lvbiBFbWJlZGRl
ZENvbnRyb2wgKElEPTMpIGhhcyBubyBoYW5kbGVyICgyMDE3MDMwMy9leGZsZGlvLTQzMSk8dT48
L3U+PHU+PC91PjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPkFDUEkg
RXJyb3I6IE1ldGhvZCBwYXJzZS9leGVjdXRpb24gZmFpbGVkIFtcX1NCLlBDSTAuTFBDLkVDLkFD
Ll9QU1JdIChOb2RlIDgwZDBjMzApLCBBRV9OT1RfRVhJU1QgKDIwMTcwMzAzL3BzcGFyc2UtNjY4
KTx1PjwvdT48dT48L3U+PC9wPg0KPC9kaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+
QUNQSSBFcnJvcjogTWV0aG9kIHBhcnNlL2V4ZWN1dGlvbiBmYWlsZWQgW1xfU0IuX0lOSV0gKE5v
ZGUgODBlNGY1MCksIEFFX05PVF9FWElTVCAoMjAxNzAzMDMvcHNwYXJzZS02NjgpPHU+PC91Pjx1
PjwvdT48L3A+DQo8L2Rpdj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj5BQ1BJIEVycm9y
OiBObyBoYW5kbGVyIGZvciBSZWdpb24gW0VDT1JdICg4MGRhMTMwKSBbRW1iZWRkZWRDb250cm9s
XSAoMjAxNzAzMDMvZXZyZWdpb24tMjkxKTx1PjwvdT48dT48L3U+PC9wPg0KPC9kaXY+DQo8ZGl2
Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+QUNQSSBFcnJvcjogUmVnaW9uIEVtYmVkZGVkQ29udHJv
bCAoSUQ9MykgaGFzIG5vIGhhbmRsZXIgKDIwMTcwMzAzL2V4ZmxkaW8tNDMxKTx1PjwvdT48dT48
L3U+PC9wPg0KPC9kaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+QUNQSSBFcnJvcjog
TWV0aG9kIHBhcnNlL2V4ZWN1dGlvbiBmYWlsZWQgW1xfU0IuUENJMC5MUEMuRUMuX0lOSV0gKE5v
ZGUgODBkMDBkMCksIEFFX05PVF9FWElTVCAoMjAxNzAzMDMvcHNwYXJzZS02NjgpPHU+PC91Pjx1
PjwvdT48L3A+DQo8L2Rpdj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj5BQ1BJIEV4Y2Vw
dGlvbjogQUVfTk9UX0VYSVNULCBkdXJpbmcgXF9TQi5QQ0kwLkxQQy5FQy5fSU5JIGV4ZWN1dGlv
biAoMjAxNzAzMDMvbnNpbml0LTgwNyk8dT48L3U+PHU+PC91PjwvcD4NCjwvZGl2Pg0KPGRpdj4N
CjxwIGNsYXNzPSJNc29Ob3JtYWwiPsKgIMKgIEV4ZWN1dGVkIDEzIF9JTkkgbWV0aG9kcyByZXF1
aXJpbmcgMSBfU1RBIGV4ZWN1dGlvbnMgKGV4YW1pbmVkIDExMyBvYmplY3RzKTx1PjwvdT48dT48
L3U+PC9wPg0KPC9kaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+LS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tPHdicj4tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS08d2Jy
Pi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLTx3YnI+LS0tLS0tPHU+PC91Pjx1PjwvdT48
L3A+DQo8L2Rpdj4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPsKgPHU+PC91
Pjx1PjwvdT48L3A+DQo8L2Rpdj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj5UaGlzIGlz
IHRoZSBvdXRwdXQgZnJvbSBjYWxsaW5nIEFjcGlFdmFsdWF0ZU9iamVjdCBmb3IgdGhlIGNvbnRy
b2wgbWV0aG9kICZxdW90O1xfU0IuUENJMC5MUEMuRUMuQkFUMC5fQlNUJnF1b3Q7LCB3aGljaCBy
ZXR1cm5zIHdpdGggQUVfTk9UX0VYSVNUOjx1PjwvdT48dT48L3U+PC9wPg0KPC9kaXY+DQo8ZGl2
Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLTx3YnI+LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tPHdicj4tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS08d2JyPi0tLS0tLTx1PjwvdT48dT48L3U+PC9wPg0KPC9kaXY+DQo8
L2Rpdj4NCjxkaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+QUNQSSBFcnJvcjogTm8g
aGFuZGxlciBmb3IgUmVnaW9uIFtFQ09SXSAoODBkYTEzMCkgW0VtYmVkZGVkQ29udHJvbF0gKDIw
MTcwMzAzL2V2cmVnaW9uLTI5MSk8dT48L3U+PHU+PC91PjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxw
IGNsYXNzPSJNc29Ob3JtYWwiPkFDUEkgRXJyb3I6IFJlZ2lvbiBFbWJlZGRlZENvbnRyb2wgKElE
PTMpIGhhcyBubyBoYW5kbGVyICgyMDE3MDMwMy9leGZsZGlvLTQzMSk8dT48L3U+PHU+PC91Pjwv
cD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPkFDUEkgRXJyb3I6IE1ldGhv
ZCBwYXJzZS9leGVjdXRpb24gZmFpbGVkIFtcX1NCLlBDSTAuTFBDLkVDLkJBVDAuX0JTVF0gKE5v
ZGUgODBkMGI3MCksIEFFX05PVF9FWElTVCAoMjAxNzAzMDMvcHNwYXJzZS02NjgpPHU+PC91Pjx1
PjwvdT48L3A+DQo8L2Rpdj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj4tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS08d2JyPi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLTx3
YnI+LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tPHdicj4tLS0tLS08dT48L3U+PHU+PC91
PjwvcD4NCjwvZGl2Pg0KPC9kaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+wqA8dT48
L3U+PHU+PC91PjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPlRoaXMg
aXMgdGhlIG91dHB1dCBmcm9tIGV4ZWN1dGluZyB0aGUgY29udHJvbCBtZXRob2QgdXNpbmcgYWNw
aWV4ZWM6PHU+PC91Pjx1PjwvdT48L3A+DQo8L2Rpdj4NCjxkaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9
Ik1zb05vcm1hbCI+LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tPHdicj4tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS08d2JyPi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLTx3
YnI+LS0tLS0tPHU+PC91Pjx1PjwvdT48L3A+DQo8L2Rpdj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNv
Tm9ybWFsIj4jIC4vYWNwaWV4ZWMgKi5kYXQ8dT48L3U+PHU+PC91PjwvcD4NCjwvZGl2Pg0KPGRp
dj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPsKgPHU+PC91Pjx1PjwvdT48L3A+DQo8L2Rpdj4NCjxk
aXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj7CoDx1PjwvdT48dT48L3U+PC9wPg0KPC9kaXY+DQo8
ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+SW50ZWwgQUNQSSBDb21wb25lbnQgQXJjaGl0ZWN0
dXJlPHU+PC91Pjx1PjwvdT48L3A+DQo8L2Rpdj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFs
Ij5BTUwgRXhlY3V0aW9uL0RlYnVnIFV0aWxpdHkgdmVyc2lvbiAyMDE3MDMwMzx1PjwvdT48dT48
L3U+PC9wPg0KPC9kaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+Q29weXJpZ2h0IChj
KSAyMDAwIC0gMjAxNyBJbnRlbCBDb3Jwb3JhdGlvbjx1PjwvdT48dT48L3U+PC9wPg0KPC9kaXY+
DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+wqA8dT48L3U+PHU+PC91PjwvcD4NCjwvZGl2
Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPklucHV0IGZpbGUgYXBpYy5kYXQsIExlbmd0
aCAweEJDICgxODgpIGJ5dGVzPHU+PC91Pjx1PjwvdT48L3A+DQo8L2Rpdj4NCjxkaXY+DQo8cCBj
bGFzcz0iTXNvTm9ybWFsIj5JbnB1dCBmaWxlIGFzZiEuZGF0LCBMZW5ndGggMHhBNSAoMTY1KSBi
eXRlczx1PjwvdT48dT48L3U+PC9wPg0KPC9kaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1h
bCI+SW5wdXQgZmlsZSBiYXRiLmRhdCwgTGVuZ3RoIDB4NDYgKDcwKSBieXRlczx1PjwvdT48dT48
L3U+PC9wPg0KPC9kaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+SW5wdXQgZmlsZSBi
b290LmRhdCwgTGVuZ3RoIDB4MjggKDQwKSBieXRlczx1PjwvdT48dT48L3U+PC9wPg0KPC9kaXY+
DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+SW5wdXQgZmlsZSBkYmcyLmRhdCwgTGVuZ3Ro
IDB4NTQgKDg0KSBieXRlczx1PjwvdT48dT48L3U+PC9wPg0KPC9kaXY+DQo8ZGl2Pg0KPHAgY2xh
c3M9Ik1zb05vcm1hbCI+SW5wdXQgZmlsZSBkYmdwLmRhdCwgTGVuZ3RoIDB4MzQgKDUyKSBieXRl
czx1PjwvdT48dT48L3U+PC9wPg0KPC9kaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+
SW5wdXQgZmlsZSBkc2R0LmRhdCwgTGVuZ3RoIDB4MTE0NTEgKDcwNzM3KSBieXRlczx1PjwvdT48
dT48L3U+PC9wPg0KPC9kaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+SW5wdXQgZmls
ZSBlY2R0LmRhdCwgTGVuZ3RoIDB4NTIgKDgyKSBieXRlczx1PjwvdT48dT48L3U+PC9wPg0KPC9k
aXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+SW5wdXQgZmlsZSBmYWNwLmRhdCwgTGVu
Z3RoIDB4RjQgKDI0NCkgYnl0ZXM8dT48L3U+PHU+PC91PjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxw
IGNsYXNzPSJNc29Ob3JtYWwiPklucHV0IGZpbGUgZmFjcy5kYXQsIExlbmd0aCAweDQwICg2NCkg
Ynl0ZXM8dT48L3U+PHU+PC91PjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3Jt
YWwiPklucHV0IGZpbGUgZnBkdC5kYXQsIExlbmd0aCAweDQ0ICg2OCkgYnl0ZXM8dT48L3U+PHU+
PC91PjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPklucHV0IGZpbGUg
aHBldC5kYXQsIExlbmd0aCAweDM4ICg1NikgYnl0ZXM8dT48L3U+PHU+PC91PjwvcD4NCjwvZGl2
Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPklucHV0IGZpbGUgbHBpdC5kYXQsIExlbmd0
aCAweDk0ICgxNDgpIGJ5dGVzPHU+PC91Pjx1PjwvdT48L3A+DQo8L2Rpdj4NCjxkaXY+DQo8cCBj
bGFzcz0iTXNvTm9ybWFsIj5JbnB1dCBmaWxlIG1jZmcuZGF0LCBMZW5ndGggMHgzQyAoNjApIGJ5
dGVzPHU+PC91Pjx1PjwvdT48L3A+DQo8L2Rpdj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFs
Ij5JbnB1dCBmaWxlIG1zZG0uZGF0LCBMZW5ndGggMHg1NSAoODUpIGJ5dGVzPHU+PC91Pjx1Pjwv
dT48L3A+DQo8L2Rpdj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj5JbnB1dCBmaWxlIHNs
aWMuZGF0LCBMZW5ndGggMHgxNzYgKDM3NCkgYnl0ZXM8dT48L3U+PHU+PC91PjwvcD4NCjwvZGl2
Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPklucHV0IGZpbGUgc3NkdDEuZGF0LCBMZW5n
dGggMHg0RTBBICgxOTk3OCkgYnl0ZXM8dT48L3U+PHU+PC91PjwvcD4NCjwvZGl2Pg0KPGRpdj4N
CjxwIGNsYXNzPSJNc29Ob3JtYWwiPklucHV0IGZpbGUgc3NkdDIuZGF0LCBMZW5ndGggMHgxQUZD
ICg2OTA4KSBieXRlczx1PjwvdT48dT48L3U+PC9wPg0KPC9kaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9
Ik1zb05vcm1hbCI+SW5wdXQgZmlsZSBzc2R0My5kYXQsIExlbmd0aCAweEU1OCAoMzY3MikgYnl0
ZXM8dT48L3U+PHU+PC91PjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwi
PklucHV0IGZpbGUgc3NkdDQuZGF0LCBMZW5ndGggMHgzRDkgKDk4NSkgYnl0ZXM8dT48L3U+PHU+
PC91PjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPklucHV0IGZpbGUg
dWVmaTEuZGF0LCBMZW5ndGggMHg0MiAoNjYpIGJ5dGVzPHU+PC91Pjx1PjwvdT48L3A+DQo8L2Rp
dj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj5JbnB1dCBmaWxlIHVlZmkyLmRhdCwgTGVu
Z3RoIDB4MTJBICgyOTgpIGJ5dGVzPHU+PC91Pjx1PjwvdT48L3A+DQo8L2Rpdj4NCjxkaXY+DQo8
cCBjbGFzcz0iTXNvTm9ybWFsIj5JbnB1dCBmaWxlIHdkYXQuZGF0LCBMZW5ndGggMHgxMzQgKDMw
OCkgYnl0ZXM8dT48L3U+PHU+PC91PjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29O
b3JtYWwiPklucHV0IGZpbGUgeHNkdC5kYXQsIExlbmd0aCAweENDICgyMDQpIGJ5dGVzPHU+PC91
Pjx1PjwvdT48L3A+DQo8L2Rpdj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj7CoDx1Pjwv
dT48dT48L3U+PC9wPg0KPC9kaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+QUNQSTog
UlNEUCAweDAwMDAwMDAwMDgwREJDRTAgMDAwMDI0ICh2MDIgSW50ZWwgKTx1PjwvdT48dT48L3U+
PC9wPg0KPC9kaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+QUNQSTogWFNEVCAweDAw
MDAwMDAwMDgwRTc4QzggMDAwMEU0ICh2MDAgSW50ZWwgwqBBY3BpRXhlYyAwMDAwMTAwMSBJTlRM
IDIwMTcwMzAzKTx1PjwvdT48dT48L3U+PC9wPg0KPC9kaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1z
b05vcm1hbCI+QUNQSTogRkFDUCAweDAwMDAwMDAwMDgwRUE1NTAgMDAwMEY0ICh2MDUgTEVOT1ZP
IFRQLVIwMCDCoCAwMDAwMDQyMCBQVEVDIDAwMDAwMDAyKTx1PjwvdT48dT48L3U+PC9wPg0KPC9k
aXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+QUNQSTogRFNEVCAweDAwMDAwMDAwMDgw
RUYwMjAgMDExNDUxICh2MDIgTEVOT1ZPIFRQLVIwMCDCoCAwMDAwMDQyMCBJTlRMIDIwMTQxMTA3
KTx1PjwvdT48dT48L3U+PC9wPg0KPC9kaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+
QUNQSTogRkFDUyAweDAwMDAwMDAwMDgwREJEMjAgMDAwMDQwPHU+PC91Pjx1PjwvdT48L3A+DQo8
L2Rpdj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj5BQ1BJOiBBUElDIDB4MDAwMDAwMDAw
ODBFQTcwOCAwMDAwQkMgKHYwMyBMRU5PVk8gVFAtUjAwIMKgIDAwMDAwNDIwIFBURUMgMDAwMDAw
MDIpPHU+PC91Pjx1PjwvdT48L3A+DQo8L2Rpdj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFs
Ij5BQ1BJOiBBU0YhIDB4MDAwMDAwMDAwODBFQTY1MCAwMDAwQTUgKHYzMiBMRU5PVk8gVFAtUjAw
IMKgIDAwMDAwNDIwIFBURUMgMDAwMDAwMDIpPHU+PC91Pjx1PjwvdT48L3A+DQo8L2Rpdj4NCjxk
aXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj5BQ1BJOiBCQVRCIDB4MDAwMDAwMDAwODBFMzBBOCAw
MDAwNDYgKHYwMSBMRU5PVk8gVFAtUjAwIMKgIDAwMDAwNDIwIFBURUMgMDAwMDAwMDIpPHU+PC91
Pjx1PjwvdT48L3A+DQo8L2Rpdj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj5BQ1BJOiBC
T09UIDB4MDAwMDAwMDAwODBFMDFEOCAwMDAwMjggKHYwMSBMRU5PVk8gVFAtUjAwIMKgIDAwMDAw
NDIwIFBURUMgMDAwMDAwMDIpPHU+PC91Pjx1PjwvdT48L3A+DQo8L2Rpdj4NCjxkaXY+DQo8cCBj
bGFzcz0iTXNvTm9ybWFsIj5BQ1BJOiBEQkcyIDB4MDAwMDAwMDAwODBFMjFGMCAwMDAwNTQgKHYw
MCBMRU5PVk8gVFAtUjAwIMKgIDAwMDAwNDIwIFBURUMgMDAwMDAwMDIpPHU+PC91Pjx1PjwvdT48
L3A+DQo8L2Rpdj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj5BQ1BJOiBEQkdQIDB4MDAw
MDAwMDAwODBFMTJEOCAwMDAwMzQgKHYwMSBMRU5PVk8gVFAtUjAwIMKgIDAwMDAwNDIwIFBURUMg
MDAwMDAwMDIpPHU+PC91Pjx1PjwvdT48L3A+DQo8L2Rpdj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNv
Tm9ybWFsIj5BQ1BJOiBFQ0RUIDB4MDAwMDAwMDAwODBFMjI1OCAwMDAwNTIgKHYwMSBMRU5PVk8g
VFAtUjAwIMKgIDAwMDAwNDIwIFBURUMgMDAwMDAwMDIpPHU+PC91Pjx1PjwvdT48L3A+DQo8L2Rp
dj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj5BQ1BJOiBGQUNTIDB4MDAwMDAwMDAwODBF
MTMyMCAwMDAwNDA8dT48L3U+PHU+PC91PjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJN
c29Ob3JtYWwiPkFDUEk6IEZQRFQgMHgwMDAwMDAwMDA4MEUzMTAwIDAwMDA0NCAodjAxIExFTk9W
TyBUUC1SMDAgwqAgMDAwMDA0MjAgUFRFQyAwMDAwMDAwMik8dT48L3U+PHU+PC91PjwvcD4NCjwv
ZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPkFDUEk6IEhQRVQgMHgwMDAwMDAwMDA4
MEUxMzY4IDAwMDAzOCAodjAxIExFTk9WTyBUUC1SMDAgwqAgMDAwMDA0MjAgUFRFQyAwMDAwMDAw
Mik8dT48L3U+PHU+PC91PjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwi
PkFDUEk6IExQSVQgMHgwMDAwMDAwMDA4MEVBNEIwIDAwMDA5NCAodjAxIExFTk9WTyBUUC1SMDAg
wqAgMDAwMDA0MjAgUFRFQyAwMDAwMDAwMik8dT48L3U+PHU+PC91PjwvcD4NCjwvZGl2Pg0KPGRp
dj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPkFDUEk6IE1DRkcgMHgwMDAwMDAwMDA4MEUxM0IwIDAw
MDAzQyAodjAxIExFTk9WTyBUUC1SMDAgwqAgMDAwMDA0MjAgUFRFQyAwMDAwMDAwMik8dT48L3U+
PHU+PC91PjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPkFDUEk6IE1T
RE0gMHgwMDAwMDAwMDA4MEUyMkMwIDAwMDA1NSAodjAzIExFTk9WTyBUUC1SMDAgwqAgMDAwMDA0
MjAgUFRFQyAwMDAwMDAwMik8dT48L3U+PHU+PC91PjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNs
YXNzPSJNc29Ob3JtYWwiPkFDUEk6IFNMSUMgMHgwMDAwMDAwMDA4MEVBMzI4IDAwMDE3NiAodjAx
IExFTk9WTyBUUC1SMDAgwqAgMDAwMDA0MjAgUFRFQyAwMDAwMDAwMik8dT48L3U+PHU+PC91Pjwv
cD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPkFDUEk6IFNTRFQgMHgwMDAw
MDAwMDA4MTAxMDIwIDAwNEUwQSAodjAyIExFTk9WTyBTYVNzZHQgwqAgMDAwMDMwMDAgSU5UTCAy
MDE0MTEwNyk8dT48L3U+PHU+PC91PjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29O
b3JtYWwiPkFDUEk6IFNTRFQgMHgwMDAwMDAwMDA4MEU4ODIwIDAwMUFGQyAodjAxIExFTk9WTyBT
YXRhQWhjaSAwMDAwMTAwMCBJTlRMIDIwMTQxMTA3KTx1PjwvdT48dT48L3U+PC9wPg0KPC9kaXY+
DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+QUNQSTogU1NEVCAweDAwMDAwMDAwMDgwRTc5
QjggMDAwRTU4ICh2MDIgTEVOT1ZPIENwdVNzZHQgwqAwMDAwMzAwMCBJTlRMIDIwMTQxMTA3KTx1
PjwvdT48dT48L3U+PC9wPg0KPC9kaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+QUNQ
STogU1NEVCAweDAwMDAwMDAwMDgwRUE3RDAgMDAwM0Q5ICh2MDIgTEVOT1ZPIEN0ZHBCIMKgIMKg
MDAwMDEwMDAgSU5UTCAyMDE0MTEwNyk8dT48L3U+PHU+PC91PjwvcD4NCjwvZGl2Pg0KPGRpdj4N
CjxwIGNsYXNzPSJNc29Ob3JtYWwiPkFDUEk6IFVFRkkgMHgwMDAwMDAwMDA4MEUzMTU4IDAwMDA0
MiAodjAxIExFTk9WTyBUUC1SMDAgwqAgMDAwMDA0MjAgUFRFQyAwMDAwMDAwMik8dT48L3U+PHU+
PC91PjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPkFDUEk6IFVFRkkg
MHgwMDAwMDAwMDA4MEU3NDcwIDAwMDEyQSAodjAxIExFTk9WTyBUUC1SMDAgwqAgMDAwMDA0MjAg
UFRFQyAwMDAwMDAwMik8dT48L3U+PHU+PC91PjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNz
PSJNc29Ob3JtYWwiPkFDUEk6IFdEQVQgMHgwMDAwMDAwMDA4MEU3MzMwIDAwMDEzNCAodjAxIExF
Tk9WTyBUUC1SMDAgwqAgMDAwMDA0MjAgUFRFQyAwMDAwMDAwMik8dT48L3U+PHU+PC91PjwvcD4N
CjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPkFDUEk6IFhTRFQgMHgwMDAwMDAw
MDA4MEU3MjMwIDAwMDBDQyAodjAxIExFTk9WTyBUUC1SMDAgwqAgMDAwMDAwMDAgUFRFQyAwMDAw
MDAwMik8dT48L3U+PHU+PC91PjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3Jt
YWwiPkluaXRpYWxpemluZyBHZW5lcmFsIFB1cnBvc2UgRXZlbnRzIChHUEVzKTo8dT48L3U+PHU+
PC91PjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPsKgIMKgIEluaXRp
YWxpemVkIEdQRSAwMCB0byA3RiBbX0dQRV0gMTYgcmVncyBvbiBpbnRlcnJ1cHQgMHg5IChTQ0kp
PHU+PC91Pjx1PjwvdT48L3A+DQo8L2Rpdj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj7C
oDx1PjwvdT48dT48L3U+PC9wPg0KPC9kaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+
SW5pdGlhbGl6aW5nIE5hbWVzcGFjZSBvYmplY3RzOjx1PjwvdT48dT48L3U+PC9wPg0KPC9kaXY+
DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+VGFibGUgW0RTRFQ6IFRQLVIwMCDCoF0gKGlk
IDAxKSAtIDI3NTcgT2JqZWN0cyB3aXRoIMKgNzYgRGV2aWNlcywgwqA0MCBSZWdpb25zLCDCoDUx
MCBNZXRob2RzICgxNDAvMzcwLzI0IFNlcmlhbC9Ob24vQ3Z0KTx1PjwvdT48dT48L3U+PC9wPg0K
PC9kaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+VGFibGUgW1NTRFQ6IFNhU3NkdCDC
oF0gKGlkIDAyKSAtIMKgNTUyIE9iamVjdHMgd2l0aCDCoDE4IERldmljZXMsIMKgMjAgUmVnaW9u
cywgwqAxMzEgTWV0aG9kcyAoNDEvOTAvNyBTZXJpYWwvTm9uL0N2dCk8dT48L3U+PHU+PC91Pjwv
cD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPlRhYmxlIFtTU0RUOiBTYXRh
QWhjaV0gKGlkIDAzKSAtIMKgMTgzIE9iamVjdHMgd2l0aCDCoCA4IERldmljZXMsIMKgIDAgUmVn
aW9ucywgwqAgMzQgTWV0aG9kcyAoMjUvOS81IFNlcmlhbC9Ob24vQ3Z0KTx1PjwvdT48dT48L3U+
PC9wPg0KPC9kaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+VGFibGUgW1NTRFQ6IENw
dVNzZHQgXSAoaWQgMDQpIC0gwqAxMTQgT2JqZWN0cyB3aXRoIMKgIDAgRGV2aWNlcywgwqAgMyBS
ZWdpb25zLCDCoCAyOSBNZXRob2RzICgxMy8xNi8xMyBTZXJpYWwvTm9uL0N2dCk8dT48L3U+PHU+
PC91PjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPlRhYmxlIFtTU0RU
OiBDdGRwQiDCoCBdIChpZCAwNSkgLSDCoCAzMyBPYmplY3RzIHdpdGggwqAgMCBEZXZpY2VzLCDC
oCAxIFJlZ2lvbnMsIMKgIMKgNSBNZXRob2RzICgyLzMvMSBTZXJpYWwvTm9uL0N2dCk8dT48L3U+
PHU+PC91PjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPkFDUEk6IDUg
QUNQSSBBTUwgdGFibGVzIHN1Y2Nlc3NmdWxseSBhY3F1aXJlZCBhbmQgbG9hZGVkPHU+PC91Pjx1
PjwvdT48L3A+DQo8L2Rpdj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj7CoDx1PjwvdT48
dT48L3U+PC9wPg0KPC9kaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+Q29tcGxldGlu
ZyBSZWdpb24vRmllbGQvQnVmZmVyL1BhY2thZ2UgaW5pdGlhbGl6YXRpb246PHU+PC91Pjx1Pjwv
dT48L3A+DQo8L2Rpdj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj7CoCDCoCBJbml0aWFs
aXplZCA2My82NCBSZWdpb25zIDcxLzcxIEZpZWxkcyA4OC84OCBCdWZmZXJzIDgzLzgzIFBhY2th
Z2VzICgzNjQ4IG5vZGVzKTx1PjwvdT48dT48L3U+PC9wPg0KPC9kaXY+DQo8ZGl2Pg0KPHAgY2xh
c3M9Ik1zb05vcm1hbCI+SW5pdGlhbGl6aW5nIERldmljZS9Qcm9jZXNzb3IvVGhlcm1hbCBvYmpl
Y3RzIGFuZCBleGVjdXRpbmcgX0lOSS9fU1RBIG1ldGhvZHM6PHU+PC91Pjx1PjwvdT48L3A+DQo8
L2Rpdj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj5bQWNwaUV4ZWNdIEV4Y2VwdGlvbiBB
RV9BTUxfSU5GSU5JVEVfTE9PUCBkdXJpbmcgZXhlY3V0aW9uIG9mIG1ldGhvZCBbU01JX10gT3Bj
b2RlIFtXaGlsZV0gQDQ0PHU+PC91Pjx1PjwvdT48L3A+DQo8L2Rpdj4NCjxkaXY+DQo8cCBjbGFz
cz0iTXNvTm9ybWFsIj5bU01JX10gQDAwMDM0ICMwMEEyOiDCoFdoaWxlICg8dT48L3U+PHU+PC91
PjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPk5vIExvY2FsIFZhcmlh
YmxlcyBhcmUgaW5pdGlhbGl6ZWQgZm9yIG1ldGhvZCBbU01JX108dT48L3U+PHU+PC91PjwvcD4N
CjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPsKgPHU+PC91Pjx1PjwvdT48L3A+
DQo8L2Rpdj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj5Jbml0aWFsaXplZCBBcmd1bWVu
dHMgZm9yIE1ldGhvZCBbU01JX106IMKgKDAgYXJndW1lbnRzIGRlZmluZWQgZm9yIG1ldGhvZCBp
bnZvY2F0aW9uKTx1PjwvdT48dT48L3U+PC9wPg0KPC9kaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1z
b05vcm1hbCI+wqAgwqAgQXJnMDogwqAgODFlY2M0MCAmbHQ7T2JqJmd0OyDCoCDCoCDCoCDCoCDC
oCDCoCBJbnRlZ2VyIDAwMDAwMDAwMDAwMDAwMDk8dT48L3U+PHU+PC91PjwvcD4NCjwvZGl2Pg0K
PGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPsKgIMKgIEFyZzE6IMKgIDgxZWNhMzggJmx0O09i
aiZndDsgwqAgwqAgwqAgwqAgwqAgwqAgSW50ZWdlciAwMDAwMDAwMDAwMDAwMDAxPHU+PC91Pjx1
PjwvdT48L3A+DQo8L2Rpdj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj7CoCDCoCBBcmcy
OiDCoCA4MWVjYmQ4ICZsdDtPYmomZ3Q7IMKgIMKgIMKgIMKgIMKgIMKgIEludGVnZXIgMDAwMDAw
MDAwMDAwMDAwMDx1PjwvdT48dT48L3U+PC9wPg0KPC9kaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1z
b05vcm1hbCI+wqAgwqAgQXJnMzogwqAgODFlYzlkMCAmbHQ7T2JqJmd0OyDCoCDCoCDCoCDCoCDC
oCDCoCBJbnRlZ2VyIDAwMDAwMDAwMDAwMDAwMDA8dT48L3U+PHU+PC91PjwvcD4NCjwvZGl2Pg0K
PGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPsKgIMKgIEFyZzQ6IMKgIDgxZWNiMDggJmx0O09i
aiZndDsgwqAgwqAgwqAgwqAgwqAgwqAgSW50ZWdlciAwMDAwMDAwMDAwMDAwMDAwPHU+PC91Pjx1
PjwvdT48L3A+DQo8L2Rpdj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj7CoDx1PjwvdT48
dT48L3U+PC9wPg0KPC9kaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+QUNQSSBFcnJv
cjogTWV0aG9kIHBhcnNlL2V4ZWN1dGlvbiBmYWlsZWQgW1xTTUldIChOb2RlIDgxNGRlNDApLCBB
RV9BTUxfSU5GSU5JVEVfTE9PUCAoMjAxNzAzMDMvcHNwYXJzZS02NjgpPHU+PC91Pjx1PjwvdT48
L3A+DQo8L2Rpdj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj5BQ1BJIEVycm9yOiBNZXRo
b2QgcGFyc2UvZXhlY3V0aW9uIGZhaWxlZCBbXFdHU1ZdIChOb2RlIDgxNGU5NzgpLCBBRV9BTUxf
SU5GSU5JVEVfTE9PUCAoMjAxNzAzMDMvcHNwYXJzZS02NjgpPHU+PC91Pjx1PjwvdT48L3A+DQo8
L2Rpdj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj5BQ1BJIEVycm9yOiBNZXRob2QgcGFy
c2UvZXhlY3V0aW9uIGZhaWxlZCBbXF9TQi5QQ0kwLkxQQy5FQy5IS0VZLldHSU5dIChOb2RlIDgx
NDM4MTApLCBBRV9BTUxfSU5GSU5JVEVfTE9PUCAoMjAxNzAzMDMvcHNwYXJzZS02NjgpPHU+PC91
Pjx1PjwvdT48L3A+DQo8L2Rpdj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj5BQ1BJIEVy
cm9yOiBNZXRob2QgcGFyc2UvZXhlY3V0aW9uIGZhaWxlZCBbXF9TQi5QQ0kwLkxQQy5FQy5fSU5J
XSAoTm9kZSA4MTIxYWUwKSwgQUVfQU1MX0lORklOSVRFX0xPT1AgKDIwMTcwMzAzL3BzcGFyc2Ut
NjY4KTx1PjwvdT48dT48L3U+PC9wPg0KPC9kaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1h
bCI+QUNQSSBFeGNlcHRpb246IEFFX0FNTF9JTkZJTklURV9MT09QLCBkdXJpbmcgXF9TQi5QQ0kw
LkxQQy5FQy5fSU5JIGV4ZWN1dGlvbiAoMjAxNzAzMDMvbnNpbml0LTgwNyk8dT48L3U+PHU+PC91
PjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPsKgIMKgIEV4ZWN1dGVk
IDE0IF9JTkkgbWV0aG9kcyByZXF1aXJpbmcgMSBfU1RBIGV4ZWN1dGlvbnMgKGV4YW1pbmVkIDEx
MyBvYmplY3RzKTx1PjwvdT48dT48L3U+PC9wPg0KPC9kaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1z
b05vcm1hbCI+LSBleGVjdXRlIFxfU0IuUENJMC5MUEMuRUMuQkFUMC5fQlNUPHU+PC91Pjx1Pjwv
dT48L3A+DQo8L2Rpdj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj5FdmFsdWF0aW5nIFxf
U0IuUENJMC5MUEMuRUMuQkFUMC5fQlNUPHU+PC91Pjx1PjwvdT48L3A+DQo8L2Rpdj4NCjxkaXY+
DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj4weDQgT3V0c3RhbmRpbmcgYWxsb2NhdGlvbnMgYWZ0ZXIg
ZXZhbHVhdGlvbiBvZiBcX1NCLlBDSTAuTFBDLkVDLkJBVDAuX0JTVDx1PjwvdT48dT48L3U+PC9w
Pg0KPC9kaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+RXZhbHVhdGlvbiBvZiBcX1NC
LlBDSTAuTFBDLkVDLkJBVDAuX0JTVCByZXR1cm5lZCBvYmplY3QgODBlYWZmMCwgZXh0ZXJuYWwg
YnVmZmVyIGxlbmd0aCA3ODx1PjwvdT48dT48L3U+PC9wPg0KPC9kaXY+DQo8ZGl2Pg0KPHAgY2xh
c3M9Ik1zb05vcm1hbCI+wqAgW1BhY2thZ2VdIENvbnRhaW5zIDQgRWxlbWVudHM6PHU+PC91Pjx1
PjwvdT48L3A+DQo8L2Rpdj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj7CoCDCoCBbSW50
ZWdlcl0gPSAwMDAwMDAwMDAwMDAwMDA0PHU+PC91Pjx1PjwvdT48L3A+DQo8L2Rpdj4NCjxkaXY+
DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj7CoCDCoCBbSW50ZWdlcl0gPSAwMDAwMDAwMDAwMDAwMDAw
PHU+PC91Pjx1PjwvdT48L3A+DQo8L2Rpdj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj7C
oCDCoCBbSW50ZWdlcl0gPSAwMDAwMDAwMDAwMDAwMDAwPHU+PC91Pjx1PjwvdT48L3A+DQo8L2Rp
dj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj7CoCDCoCBbSW50ZWdlcl0gPSAwMDAwMDAw
MDAwMDAwMDAwPHU+PC91Pjx1PjwvdT48L3A+DQo8L2Rpdj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNv
Tm9ybWFsIj4tIHE8dT48L3U+PHU+PC91PjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJN
c29Ob3JtYWwiPi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLTx3YnI+LS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tPHdicj4tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS08d2Jy
Pi0tLS0tLTx1PjwvdT48dT48L3U+PC9wPg0KPC9kaXY+DQo8L2Rpdj4NCjxkaXY+DQo8cCBjbGFz
cz0iTXNvTm9ybWFsIj7CoDx1PjwvdT48dT48L3U+PC9wPg0KPC9kaXY+DQo8ZGl2Pg0KPHAgY2xh
c3M9Ik1zb05vcm1hbCI+Tm90ZTogSSB0cmllZCBydW5uaW5nIExpbnV4IG9uIHRoZSBMZW5vdm8g
bGFwdG9wIGFuZCBpdCBjYW4gcmVhZCB0aGUgYmF0dGVyeSBzdGF0dXMgb2suPHU+PC91Pjx1Pjwv
dT48L3A+DQo8L2Rpdj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj7CoDx1PjwvdT48dT48
L3U+PC9wPg0KPC9kaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+VGhhbmsgeW91LDx1
PjwvdT48dT48L3U+PC9wPg0KPC9kaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+RGV2
aW48dT48L3U+PHU+PC91PjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwi
PsKgPHU+PC91Pjx1PjwvdT48L3A+DQo8L2Rpdj4NCjwvZGl2Pg0KPC9kaXY+DQo8L2Rpdj4NCjwv
ZGl2Pg0KPC9kaXY+DQo8L2Rpdj4NCjwvYmxvY2txdW90ZT4NCjwvZGl2Pg0KPHAgY2xhc3M9Ik1z
b05vcm1hbCI+PHU+PC91PsKgPHU+PC91PjwvcD4NCjwvZGl2Pg0KPC9kaXY+DQo8L2Rpdj48L2Rp
dj48L2Rpdj4NCjwvZGl2Pg0KPC9kaXY+DQoNCjwvYmxvY2txdW90ZT48L2Rpdj48YnI+PC9kaXY+
DQo8L2Rpdj48L2Rpdj48L2Jsb2NrcXVvdGU+PC9kaXY+PGJyPjwvZGl2Pg0K

--===============6597612541432853578==--

