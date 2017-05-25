Content-Type: multipart/mixed; boundary="===============1964825023583994666=="
MIME-Version: 1.0
From: Devin Steffler <devinsteffler at gmail.com>
Subject: Re: [Devel] Help needed for "ACPI Error: No handler for Region
 [ECOR]" (using my own OSL)
Date: Thu, 25 May 2017 10:47:54 -0400
Message-ID: <CAAuRk_ixKtzN-UgEwbemcij9x_iJecHs8UUJMzg7pndE=DSvTQ@mail.gmail.com>
In-Reply-To: 94F2FBAB4432B54E8AACC7DFDE6C92E37E59B43E@ORSMSX110.amr.corp.intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============1964825023583994666==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Robert,

Thanks for your insight.

How can I find out whether is it a missing EC driver or the EC driver
is failing to install a handler for the EC operation region?

Is the EC driver some C code that I would be expected to write as part of
the OSL or is it expected to be included with the OS (QNX in this case)?

I suspect that the problem is somewhere in my OSL (since I'm very new to
ACPI). Do you think this is likely the case? What should I focus on to
debug my OSL if this is the case?

Here's an excerpt from the Lenovo's DSDT.dsl (hoping it helps):
---------------------------------------------------------------------------=
--------------------
                Device (EC)
                {
                    Name (_HID, EisaId ("PNP0C09") /* Embedded Controller
Device */)  // _HID: Hardware ID
                    Name (_UID, 0x00)  // _UID: Unique ID
                    Name (_GPE, 0x20)  // _GPE: General Purpose Events
                    Method (_REG, 2, NotSerialized)  // _REG: Region
Availability
                    {
                        If ((Arg0 =3D=3D 0x03))
                        {
                            \H8DR =3D Arg1
                        }
                    }
                    OperationRegion (ECOR, EmbeddedControl, 0x00, 0x0100)
                    Field (ECOR, ByteAcc, NoLock, Preserve)
                    {
                        HDBM,   1,
                            ,   1,
                        HKLK,   1,
                        HFNE,   1,
                            ,   1,
                            ,   1,
                        HLDM,   1,
                        Offset (0x01),
                        BBLS,   1,
                        BTCM,   1,
                            ,   1,
                            ,   1,
                            ,   1,
                        HBPR,   1,
                        BTPC,   1,
                        Offset (0x02),
                        HDUE,   1,
                            ,   4,
                        SNLK,   1,
                        Offset (0x03),
                            ,   5,
                        HAUM,   2,
                        Offset (0x05),
                        HSPA,   1,
                        Offset (0x06),
                        HSUN,   8,
                        HSRP,   8,
                        Offset (0x09),
                            ,   6,
                        FNKS,   1,
                        Offset (0x0C),
                        HLCL,   8,
                            ,   4,
                        CALM,   1,
                        Offset (0x0E),
                        HFNS,   2,
                        Offset (0x0F),
                            ,   6,
                        NULS,   1,
                        Offset (0x10),
                        HAM0,   8,
                        HAM1,   8,
                        HAM2,   8,
                        HAM3,   8,
                        HAM4,   8,
                        HAM5,   8,
                        HAM6,   8,
                        HAM7,   8,
                        HAM8,   8,
                        HAM9,   8,
                        HAMA,   8,
                        HAMB,   8,
                        HAMC,   8,
                        HAMD,   8,
                        HAME,   8,
                        HAMF,   8,
                        Offset (0x23),
                        HANT,   8,
                        Offset (0x26),
                            ,   2,
                        HANA,   2,
                        Offset (0x27),
                        Offset (0x28),
                            ,   1,
                        SKEM,   1,
                        Offset (0x29),
                        Offset (0x2A),
                        HATR,   8,
                        HT0H,   8,
                        HT0L,   8,
                        HT1H,   8,
                        HT1L,   8,
                        HFSP,   8,
                            ,   6,
                        HMUT,   1,
                        Offset (0x31),
                            ,   2,
                        HUWB,   1,
                            ,   3,
                        VPON,   1,
                        VRST,   1,
                        HWPM,   1,
                        HWLB,   1,
                        HWLO,   1,
                        HWDK,   1,
                        HWFN,   1,
                        HWBT,   1,
                        HWRI,   1,
                        HWBU,   1,
                        HWLU,   1,
                        Offset (0x34),
                            ,   3,
                        PIBS,   1,
                            ,   3,
                        HPLO,   1,
                        Offset (0x36),
                        HWAC,   16,
                        HB0S,   7,
                        HB0A,   1,
                        HB1S,   7,
                        HB1A,   1,
                        HCMU,   1,
                            ,   2,
                        OVRQ,   1,
                        DCBD,   1,
                        DCWL,   1,
                        DCWW,   1,
                        HB1I,   1,
                            ,   1,
                        KBLT,   1,
                        BTPW,   1,
                        FNKC,   1,
                        HUBS,   1,
                        BDPW,   1,
                        BDDT,   1,
                        HUBB,   1,
                        Offset (0x46),
                            ,   1,
                        BTWK,   1,
                        HPLD,   1,
                            ,   1,
                        HPAC,   1,
                        BTST,   1,
                        Offset (0x47),
                        HPBU,   1,
                            ,   1,
                        HBID,   1,
                            ,   3,
                        HBCS,   1,
                        HPNF,   1,
                            ,   1,
                        GSTS,   1,
                            ,   2,
                        HLBU,   1,
                        DOCD,   1,
                        HCBL,   1,
                        Offset (0x49),
                        SLUL,   1,
                        Offset (0x4C),
                        HTMH,   8,
                        HTML,   8,
                        HWAK,   16,
                        HMPR,   8,
                            ,   7,
                        HMDN,   1,
                        Offset (0x78),
                        TMP0,   8,
                        Offset (0x80),
                        Offset (0x81),
                        HIID,   8,
                        Offset (0x83),
                        HFNI,   8,
                        HSPD,   16,
                        Offset (0x88),
                        TSL0,   7,
                        TSR0,   1,
                        TSL1,   7,
                        TSR1,   1,
                        TSL2,   7,
                        TSR2,   1,
                        TSL3,   7,
                        TSR3,   1,
                        Offset (0x8D),
                        HDAA,   3,
                        HDAB,   3,
                        HDAC,   2,
                        RCBD,   1,
                        RCWL,   1,
                        RCWW,   1,
                        Offset (0xB0),
                        HDEN,   32,
                        HDEP,   32,
                        HDEM,   8,
                        HDES,   8,
                        Offset (0xC8),
                        ATMX,   8,
                        HWAT,   8,
                        Offset (0xCC),
                        PWMH,   8,
                        PWML,   8,
                        Offset (0xED),
                            ,   4,
                        HDDD,   1
                    }
---------------------------------------------------------------------------=
--------------------

Many thanks,
Devin


On Thu, May 25, 2017 at 10:15 AM, Moore, Robert <robert.moore(a)intel.com>
wrote:

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

--===============1964825023583994666==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+PGRpdj5IaSBSb2JlcnQsPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5U
aGFua3MgZm9yIHlvdXIgaW5zaWdodC48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PkhvdyBjYW4g
SSBmaW5kIG91dCB3aGV0aGVyIGlzIGl0IGEgbWlzc2luZyBFQyBkcml2ZXIgb3IgdGhlIEVDIGRy
aXZlciBpc8KgZmFpbGluZyB0byBpbnN0YWxsIGEgaGFuZGxlciBmb3IgdGhlIEVDIG9wZXJhdGlv
biByZWdpb24/PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5JcyB0aGUgRUMgZHJpdmVyIHNvbWUg
QyBjb2RlIHRoYXQgSSB3b3VsZCBiZSBleHBlY3RlZCB0byB3cml0ZSBhcyBwYXJ0IG9mIHRoZSBP
U0wgb3IgaXMgaXQgZXhwZWN0ZWQgdG8gYmUgaW5jbHVkZWQgd2l0aCB0aGUgT1MgKFFOWCBpbiB0
aGlzIGNhc2UpPzwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+SSBzdXNwZWN0IHRoYXQgdGhlIHBy
b2JsZW0gaXMgc29tZXdoZXJlIGluwqBteSBPU0wgKHNpbmNlIEkmIzM5O20gdmVyeSBuZXcgdG8g
QUNQSSkuIERvIHlvdSB0aGluayB0aGlzIGlzIGxpa2VseSB0aGUgY2FzZT8gV2hhdCBzaG91bGQg
SSBmb2N1cyBvbiB0byBkZWJ1ZyBteSBPU0wgaWYgdGhpcyBpcyB0aGUgY2FzZT88L2Rpdj48ZGl2
Pjxicj48L2Rpdj48ZGl2PkhlcmUmIzM5O3MgYW4gZXhjZXJwdCBmcm9tIHRoZSBMZW5vdm8mIzM5
O3MgRFNEVC5kc2wgKGhvcGluZyBpdCBoZWxwcyk6PC9kaXY+PGRpdj4tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLTwvZGl2PjxkaXY+wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIERldmljZSAoRUMpPGJyPsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB7PGJy
PsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIE5hbWUgKF9ISUQsIEVpc2FJ
ZCAoJnF1b3Q7UE5QMEMwOSZxdW90OykgLyogRW1iZWRkZWQgQ29udHJvbGxlciBEZXZpY2UgKi8p
wqAgLy8gX0hJRDogSGFyZHdhcmUgSUQ8YnI+wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgTmFtZSAoX1VJRCwgMHgwMCnCoCAvLyBfVUlEOiBVbmlxdWUgSUQ8YnI+wqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgTmFtZSAoX0dQRSwgMHgyMCnCoCAvLyBf
R1BFOiBHZW5lcmFsIFB1cnBvc2UgRXZlbnRzPGJyPsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIE1ldGhvZCAoX1JFRywgMiwgTm90U2VyaWFsaXplZCnCoCAvLyBfUkVHOiBS
ZWdpb24gQXZhaWxhYmlsaXR5PGJyPsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIHs8YnI+wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBJ
ZiAoKEFyZzAgPT0gMHgwMykpPGJyPsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgezxicj7CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgXEg4RFIgPSBBcmcxPGJyPsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgfTxicj7CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCB9PC9kaXY+PGRpdj7CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBPcGVyYXRpb25SZWdpb24gKEVDT1IsIEVtYmVkZGVkQ29udHJvbCwgMHgwMCwgMHgwMTAwKTxi
cj7CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBGaWVsZCAoRUNPUiwgQnl0
ZUFjYywgTm9Mb2NrLCBQcmVzZXJ2ZSk8YnI+wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgezxicj7CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIEhEQk0swqDCoCAxLCA8YnI+wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgICzCoMKgIDEsIDxicj7CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIEhLTEsswqDCoCAxLCA8YnI+wqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBIRk5FLMKgwqAgMSwgPGJyPsKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAswqDCoCAxLCA8YnI+
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICzC
oMKgIDEsIDxicj7CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IEhMRE0swqDCoCAxLCA8YnI+wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBPZmZzZXQgKDB4MDEpLCA8YnI+wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBCQkxTLMKgwqAgMSwgPGJyPsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgQlRDTSzCoMKgIDEsIDxicj7CoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLMKgwqAgMSwgPGJyPsKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAswqDCoCAx
LCA8YnI+wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgICzCoMKgIDEsIDxicj7CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIEhCUFIswqDCoCAxLCA8YnI+wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBCVFBDLMKgwqAgMSwgPGJyPsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgT2Zmc2V0ICgweDAyKSwgPGJyPsKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgSERVRSzCoMKgIDEsIDxicj7CoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLMKgwqAgNCwgPGJy
PsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgU05MSyzCoMKg
IDEsIDxicj7CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIE9m
ZnNldCAoMHgwMyksIDxicj7CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgLMKgwqAgNSwgPGJyPsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgSEFVTSzCoMKgIDIsIDxicj7CoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIE9mZnNldCAoMHgwNSksIDxicj7CoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEhTUEEswqDCoCAxLCA8YnI+wqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBPZmZzZXQgKDB4MDYpLCA8
YnI+wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBIU1VOLMKg
wqAgOCwgPGJyPsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
SFNSUCzCoMKgIDgsIDxicj7CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIE9mZnNldCAoMHgwOSksIDxicj7CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLMKgwqAgNiwgPGJyPsKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgRk5LUyzCoMKgIDEsIDxicj7CoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIE9mZnNldCAoMHgwQyksIDxicj7CoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEhMQ0wswqDCoCA4LCA8
YnI+wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
ICzCoMKgIDQsIDxicj7CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIENBTE0swqDCoCAxLCA8YnI+wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBPZmZzZXQgKDB4MEUpLCA8YnI+wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBIRk5TLMKgwqAgMiwgPGJyPsKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgT2Zmc2V0ICgweDBGKSwgPGJyPsKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAswqDCoCA2LCA8YnI+
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBOVUxTLMKgwqAg
MSwgPGJyPsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgT2Zm
c2V0ICgweDEwKSwgPGJyPsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgSEFNMCzCoMKgIDgsIDxicj7CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIEhBTTEswqDCoCA4LCA8YnI+wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBIQU0yLMKgwqAgOCwgPGJyPsKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgSEFNMyzCoMKgIDgsIDxicj7CoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEhBTTQswqDCoCA4LCA8YnI+wqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBIQU01LMKgwqAgOCwgPGJy
PsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgSEFNNizCoMKg
IDgsIDxicj7CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEhB
TTcswqDCoCA4LCA8YnI+wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBIQU04LMKgwqAgOCwgPGJyPsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgSEFNOSzCoMKgIDgsIDxicj7CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIEhBTUEswqDCoCA4LCA8YnI+wqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBIQU1CLMKgwqAgOCwgPGJyPsKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgSEFNQyzCoMKgIDgsIDxicj7CoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEhBTUQswqDCoCA4LCA8YnI+
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBIQU1FLMKgwqAg
OCwgPGJyPsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgSEFN
RizCoMKgIDgsIDxicj7CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIE9mZnNldCAoMHgyMyksIDxicj7CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIEhBTlQswqDCoCA4LCA8YnI+wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBPZmZzZXQgKDB4MjYpLCA8YnI+wqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICzCoMKgIDIsIDxicj7CoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEhBTkEswqDCoCAyLCA8YnI+
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBPZmZzZXQgKDB4
MjcpLCA8YnI+wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBP
ZmZzZXQgKDB4MjgpLCA8YnI+wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgICzCoMKgIDEsIDxicj7CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIFNLRU0swqDCoCAxLCA8YnI+wqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBPZmZzZXQgKDB4MjkpLCA8YnI+wqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBPZmZzZXQgKDB4MkEpLCA8YnI+wqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBIQVRSLMKgwqAgOCwg
PGJyPsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgSFQwSCzC
oMKgIDgsIDxicj7CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IEhUMEwswqDCoCA4LCA8YnI+wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBIVDFILMKgwqAgOCwgPGJyPsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgSFQxTCzCoMKgIDgsIDxicj7CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIEhGU1AswqDCoCA4LCA8YnI+wqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICzCoMKgIDYsIDxicj7CoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEhNVVQswqDCoCAxLCA8YnI+
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBPZmZzZXQgKDB4
MzEpLCA8YnI+wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgICzCoMKgIDIsIDxicj7CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIEhVV0IswqDCoCAxLCA8YnI+wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICzCoMKgIDMsIDxicj7CoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFZQT04swqDCoCAxLCA8YnI+wqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBWUlNULMKgwqAgMSwgPGJyPsKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgSFdQTSzCoMKgIDEsIDxi
cj7CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEhXTEIswqDC
oCAxLCA8YnI+wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBI
V0xPLMKgwqAgMSwgPGJyPsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgSFdESyzCoMKgIDEsIDxicj7CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIEhXRk4swqDCoCAxLCA8YnI+wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBIV0JULMKgwqAgMSwgPGJyPsKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgSFdSSSzCoMKgIDEsIDxicj7CoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEhXQlUswqDCoCAxLCA8YnI+wqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBIV0xVLMKgwqAgMSwgPGJy
PsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgT2Zmc2V0ICgw
eDM0KSwgPGJyPsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCAswqDCoCAzLCA8YnI+wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBQSUJTLMKgwqAgMSwgPGJyPsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAswqDCoCAzLCA8YnI+wqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBIUExPLMKgwqAgMSwgPGJyPsKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgT2Zmc2V0ICgweDM2KSwgPGJyPsKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgSFdBQyzCoMKgIDE2
LCA8YnI+wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBIQjBT
LMKgwqAgNywgPGJyPsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgSEIwQSzCoMKgIDEsIDxicj7CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIEhCMVMswqDCoCA3LCA8YnI+wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBIQjFBLMKgwqAgMSwgPGJyPsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgSENNVSzCoMKgIDEsIDxicj7CoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLMKgwqAgMiwgPGJyPsKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgT1ZSUSzCoMKgIDEsIDxi
cj7CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIERDQkQswqDC
oCAxLCA8YnI+wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBE
Q1dMLMKgwqAgMSwgPGJyPsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgRENXVyzCoMKgIDEsIDxicj7CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIEhCMUkswqDCoCAxLCA8YnI+wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICzCoMKgIDEsIDxicj7CoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEtCTFQswqDCoCAxLCA8YnI+wqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBCVFBXLMKgwqAgMSwgPGJyPsKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgRk5LQyzCoMKgIDEs
IDxicj7CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEhVQlMs
wqDCoCAxLCA8YnI+wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBCRFBXLMKgwqAgMSwgPGJyPsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgQkREVCzCoMKgIDEsIDxicj7CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIEhVQkIswqDCoCAxLCA8YnI+wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBPZmZzZXQgKDB4NDYpLCA8YnI+wqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICzCoMKgIDEsIDxicj7CoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEJUV0sswqDCoCAxLCA8
YnI+wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBIUExELMKg
wqAgMSwgPGJyPsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCAswqDCoCAxLCA8YnI+wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBIUEFDLMKgwqAgMSwgPGJyPsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgQlRTVCzCoMKgIDEsIDxicj7CoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIE9mZnNldCAoMHg0NyksIDxicj7CoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEhQQlUswqDCoCAxLCA8YnI+wqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICzCoMKgIDEs
IDxicj7CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEhCSUQs
wqDCoCAxLCA8YnI+wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgICzCoMKgIDMsIDxicj7CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIEhCQ1MswqDCoCAxLCA8YnI+wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBIUE5GLMKgwqAgMSwgPGJyPsKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAswqDCoCAxLCA8YnI+wqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBHU1RTLMKgwqAgMSwgPGJyPsKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAswqDC
oCAyLCA8YnI+wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBI
TEJVLMKgwqAgMSwgPGJyPsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgRE9DRCzCoMKgIDEsIDxicj7CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIEhDQkwswqDCoCAxLCA8YnI+wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBPZmZzZXQgKDB4NDkpLCA8YnI+wqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBTTFVMLMKgwqAgMSwgPGJyPsKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgT2Zmc2V0ICgweDRDKSwgPGJyPsKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgSFRNSCzCoMKgIDgs
IDxicj7CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEhUTUws
wqDCoCA4LCA8YnI+wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBIV0FLLMKgwqAgMTYsIDxicj7CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIEhNUFIswqDCoCA4LCA8YnI+wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICzCoMKgIDcsIDxicj7CoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEhNRE4swqDCoCAxLCA8YnI+wqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBPZmZzZXQgKDB4NzgpLCA8YnI+wqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBUTVAwLMKgwqAgOCwg
PGJyPsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgT2Zmc2V0
ICgweDgwKSwgPGJyPsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgT2Zmc2V0ICgweDgxKSwgPGJyPsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgSElJRCzCoMKgIDgsIDxicj7CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIE9mZnNldCAoMHg4MyksIDxicj7CoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEhGTkkswqDCoCA4LCA8YnI+wqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBIU1BELMKgwqAgMTYsIDxicj7CoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIE9mZnNldCAoMHg4OCks
IDxicj7CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFRTTDAs
wqDCoCA3LCA8YnI+wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBUU1IwLMKgwqAgMSwgPGJyPsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgVFNMMSzCoMKgIDcsIDxicj7CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIFRTUjEswqDCoCAxLCA8YnI+wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBUU0wyLMKgwqAgNywgPGJyPsKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgVFNSMizCoMKgIDEsIDxicj7CoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFRTTDMswqDCoCA3LCA8YnI+wqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBUU1IzLMKgwqAgMSwg
PGJyPsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgT2Zmc2V0
ICgweDhEKSwgPGJyPsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgSERBQSzCoMKgIDMsIDxicj7CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIEhEQUIswqDCoCAzLCA8YnI+wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBIREFDLMKgwqAgMiwgPGJyPsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgUkNCRCzCoMKgIDEsIDxicj7CoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFJDV0wswqDCoCAxLCA8YnI+wqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBSQ1dXLMKgwqAgMSwgPGJyPsKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgT2Zmc2V0ICgweEIw
KSwgPGJyPsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgSERF
TizCoMKgIDMyLCA8YnI+wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBIREVQLMKgwqAgMzIsIDxicj7CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIEhERU0swqDCoCA4LCA8YnI+wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBIREVTLMKgwqAgOCwgPGJyPsKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgT2Zmc2V0ICgweEM4KSwgPGJyPsKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgQVRNWCzCoMKgIDgsIDxicj7CoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEhXQVQswqDCoCA4LCA8
YnI+wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBPZmZzZXQg
KDB4Q0MpLCA8YnI+wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBQV01ILMKgwqAgOCwgPGJyPsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgUFdNTCzCoMKgIDgsIDxicj7CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIE9mZnNldCAoMHhFRCksIDxicj7CoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLMKgwqAgNCwgPGJyPsKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgSERERCzCoMKgIDE8YnI+wqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfTwvZGl2PjxkaXY+PGRpdj4tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLTwvZGl2PjwvZGl2PjxkaXY+PGJyPjwvZGl2
PjxkaXY+TWFueSB0aGFua3MsPGJyPkRldmluPC9kaXY+PGRpdj48YnI+PC9kaXY+PC9kaXY+PGRp
diBjbGFzcz0iZ21haWxfZXh0cmEiPjxicj48ZGl2IGNsYXNzPSJnbWFpbF9xdW90ZSI+T24gVGh1
LCBNYXkgMjUsIDIwMTcgYXQgMTA6MTUgQU0sIE1vb3JlLCBSb2JlcnQgPHNwYW4gZGlyPSJsdHIi
PiZsdDs8YSBocmVmPSJtYWlsdG86cm9iZXJ0Lm1vb3JlQGludGVsLmNvbSIgdGFyZ2V0PSJfYmxh
bmsiPnJvYmVydC5tb29yZUBpbnRlbC5jb208L2E+Jmd0Ozwvc3Bhbj4gd3JvdGU6PGJyPjxibG9j
a3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowIDAgMCAuOGV4O2JvcmRl
ci1sZWZ0OjFweCAjY2NjIHNvbGlkO3BhZGRpbmctbGVmdDoxZXgiPg0KDQoNCg0KDQoNCjxkaXYg
bGFuZz0iRU4tVVMiIHZsaW5rPSIjOTU0RjcyIiBsaW5rPSIjMDU2M0MxIj4NCjxkaXYgY2xhc3M9
Im1fMjc3MTIyNzQ1MTk1NDM4MzA5OFdvcmRTZWN0aW9uMSI+PHNwYW4+DQo8cCBjbGFzcz0iTXNv
Tm9ybWFsIj5BQ1BJIEVycm9yOiBSZWdpb24gRW1iZWRkZWRDb250cm9sIChJRD0zKSBoYXMgbm8g
aGFuZGxlciAoMjAxNzAzMDMvZXhmbGRpby00MzEpPHU+PC91Pjx1PjwvdT48L3A+DQo8cCBjbGFz
cz0iTXNvTm9ybWFsIj48c3BhbiBzdHlsZT0iY29sb3I6cmdiKDMxLDczLDEyNSk7Zm9udC1mYW1p
bHk6JnF1b3Q7Q2FsaWJyaSZxdW90OyxzYW5zLXNlcmlmO2ZvbnQtc2l6ZToxMXB0Ij48dT48L3U+
wqA8dT48L3U+PC9zcGFuPjwvcD4NCjwvc3Bhbj48cCBjbGFzcz0iTXNvTm9ybWFsIj48c3BhbiBz
dHlsZT0iY29sb3I6cmdiKDMxLDczLDEyNSk7Zm9udC1mYW1pbHk6JnF1b3Q7Q2FsaWJyaSZxdW90
OyxzYW5zLXNlcmlmO2ZvbnQtc2l6ZToxMXB0Ij5Zb3UgZWl0aGVyIGRvbuKAmXQgaGF2ZSBhIGRy
aXZlciBmb3IgdGhlIEVDLCBvciB5b3VyIEVDIGRyaXZlciBoYXMgbm90IGluc3RhbGxlZCBhIGhh
bmRsZXIgZm9yIHRoZSBFQyBvcGVyYXRpb24gcmVnaW9uLjx1PjwvdT48dT48L3U+PC9zcGFuPjwv
cD4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPjxzcGFuIHN0eWxlPSJjb2xvcjpyZ2IoMzEsNzMsMTI1
KTtmb250LWZhbWlseTomcXVvdDtDYWxpYnJpJnF1b3Q7LHNhbnMtc2VyaWY7Zm9udC1zaXplOjEx
cHQiPjx1PjwvdT7CoDx1PjwvdT48L3NwYW4+PC9wPg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+PHNw
YW4gc3R5bGU9ImNvbG9yOnJnYigzMSw3MywxMjUpO2ZvbnQtZmFtaWx5OiZxdW90O0NhbGlicmkm
cXVvdDssc2Fucy1zZXJpZjtmb250LXNpemU6MTFwdCI+SSB3b3VsZCBndWVzcy48dT48L3U+PHU+
PC91Pjwvc3Bhbj48L3A+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj48c3BhbiBzdHlsZT0iY29sb3I6
cmdiKDMxLDczLDEyNSk7Zm9udC1mYW1pbHk6JnF1b3Q7Q2FsaWJyaSZxdW90OyxzYW5zLXNlcmlm
O2ZvbnQtc2l6ZToxMXB0Ij48dT48L3U+wqA8dT48L3U+PC9zcGFuPjwvcD4NCjxwIGNsYXNzPSJN
c29Ob3JtYWwiPjxzcGFuIHN0eWxlPSJjb2xvcjpyZ2IoMzEsNzMsMTI1KTtmb250LWZhbWlseTom
cXVvdDtDYWxpYnJpJnF1b3Q7LHNhbnMtc2VyaWY7Zm9udC1zaXplOjExcHQiPjx1PjwvdT7CoDx1
PjwvdT48L3NwYW4+PC9wPg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+PHNwYW4gc3R5bGU9ImNvbG9y
OnJnYigzMSw3MywxMjUpO2ZvbnQtZmFtaWx5OiZxdW90O0NhbGlicmkmcXVvdDssc2Fucy1zZXJp
Zjtmb250LXNpemU6MTFwdCI+PHU+PC91PsKgPHU+PC91Pjwvc3Bhbj48L3A+DQo8cCBjbGFzcz0i
TXNvTm9ybWFsIj48c3BhbiBzdHlsZT0iY29sb3I6cmdiKDMxLDczLDEyNSk7Zm9udC1mYW1pbHk6
JnF1b3Q7Q2FsaWJyaSZxdW90OyxzYW5zLXNlcmlmO2ZvbnQtc2l6ZToxMXB0Ij48dT48L3U+wqA8
dT48L3U+PC9zcGFuPjwvcD4NCjxkaXYgc3R5bGU9ImJvcmRlci13aWR0aDptZWRpdW0gbWVkaXVt
IG1lZGl1bSAxLjVwdDtib3JkZXItc3R5bGU6bm9uZSBub25lIG5vbmUgc29saWQ7Ym9yZGVyLWNv
bG9yOmN1cnJlbnRDb2xvciBjdXJyZW50Q29sb3IgY3VycmVudENvbG9yIGJsdWU7cGFkZGluZzow
aW4gMGluIDBpbiA0cHQiPg0KPGRpdj4NCjxkaXYgc3R5bGU9ImJvcmRlci13aWR0aDoxcHQgbWVk
aXVtIG1lZGl1bTtib3JkZXItc3R5bGU6c29saWQgbm9uZSBub25lO2JvcmRlci1jb2xvcjpyZ2Io
MjI1LDIyNSwyMjUpIGN1cnJlbnRDb2xvciBjdXJyZW50Q29sb3I7cGFkZGluZzozcHQgMGluIDBp
biI+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj48Yj48c3BhbiBzdHlsZT0iZm9udC1mYW1pbHk6JnF1
b3Q7Q2FsaWJyaSZxdW90OyxzYW5zLXNlcmlmO2ZvbnQtc2l6ZToxMXB0Ij5Gcm9tOjwvc3Bhbj48
L2I+PHNwYW4gc3R5bGU9ImZvbnQtZmFtaWx5OiZxdW90O0NhbGlicmkmcXVvdDssc2Fucy1zZXJp
Zjtmb250LXNpemU6MTFwdCI+IERldmVsIFttYWlsdG86PGEgaHJlZj0ibWFpbHRvOmRldmVsLWJv
dW5jZXNAYWNwaWNhLm9yZyIgdGFyZ2V0PSJfYmxhbmsiPmRldmVsLWJvdW5jZXNAYWNwaWNhLjx3
YnI+b3JnPC9hPl0NCjxiPk9uIEJlaGFsZiBPZiA8L2I+RGV2aW4gU3RlZmZsZXI8YnI+DQo8Yj5T
ZW50OjwvYj4gVGh1cnNkYXksIE1heSAyNSwgMjAxNyA2OjE1IEFNPGJyPg0KPGI+VG86PC9iPiA8
YSBocmVmPSJtYWlsdG86ZGV2ZWxAYWNwaWNhLm9yZyIgdGFyZ2V0PSJfYmxhbmsiPmRldmVsQGFj
cGljYS5vcmc8L2E+PGJyPg0KPGI+U3ViamVjdDo8L2I+IFtEZXZlbF0gSGVscCBuZWVkZWQgZm9y
ICZxdW90O0FDUEkgRXJyb3I6IE5vIGhhbmRsZXIgZm9yIFJlZ2lvbiBbRUNPUl0mcXVvdDsgKHVz
aW5nIG15IG93biBPU0wpPHU+PC91Pjx1PjwvdT48L3NwYW4+PC9wPg0KPC9kaXY+DQo8L2Rpdj48
ZGl2PjxkaXYgY2xhc3M9Img1Ij4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPjx1PjwvdT7CoDx1Pjwv
dT48L3A+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+SGVsbG8sPHU+PC91Pjx1PjwvdT48
L3A+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+PHU+PC91PsKgPHU+PC91PjwvcD4NCjwv
ZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPkkgYW0gd29ya2luZyBvbiBhbiBPU0wg
Zm9yIFFOWC4gSSBhbSBnZXR0aW5nIHNvbWUgZXJyb3JzIHByaW50ZWQgb3V0IGR1cmluZ8KgQWNw
aUluaXRpYWxpemVPYmplY3RzIGJ1dCBvbmx5IGluIG9uZSBvdXQgb2YgdGhyZWUgbGFwdG9wcyB0
aGF0IEkgYW0gdGVzdGluZy4gQSBEZWxsIGFuZCBBU1VTIGxhcHRvcCBkbyBub3QgaGF2ZSB0aGUg
ZXJyb3JzIGJ1dCBhIExlbm92byBsYXB0b3AgZG9lcy4gSSBhbSBhYmxlDQogdG8gcmVhZCBiYXR0
ZXJ5IHN0YXR1cyAoX0JTVCkgb24gdGhlIERlbGwgYW5kIEFTVVMgbGFwdG9wcyBidXQgbm90IG9u
IHRoZSBMZW5vdm8gbGFwdG9wLjx1PjwvdT48dT48L3U+PC9wPg0KPC9kaXY+DQo8ZGl2Pg0KPHAg
Y2xhc3M9Ik1zb05vcm1hbCI+PHU+PC91PsKgPHU+PC91PjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxw
IGNsYXNzPSJNc29Ob3JtYWwiPlRoZSBBQ1BJQ0EgdmVyc2lvbiBJIGFtIHVzaW5nIGlzIDIwMTcw
MzAzLjx1PjwvdT48dT48L3U+PC9wPg0KPC9kaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1h
bCI+PHU+PC91PsKgPHU+PC91PjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3Jt
YWwiPlNvbWUgcXVlc3Rpb25zIEkgaGF2ZSBhcmU6PHU+PC91Pjx1PjwvdT48L3A+DQo8L2Rpdj4N
CjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj4tIElzIHRoaXMgdGhlIGNvcnJlY3QgbWFpbGlu
ZyBsaXN0IGZvciB0aGlzIGVtYWlsPzx1PjwvdT48dT48L3U+PC9wPg0KPC9kaXY+DQo8ZGl2Pg0K
PHAgY2xhc3M9Ik1zb05vcm1hbCI+LSBEb2VzIHRoaXMgYXBwZWFyIHRvIGJlIGEgYnVnIGluIEFD
UElDQSwgaW4gbXkgT1NMLCBvciBzb21ld2hlcmUgZWxzZSAobWF5YmUgdGhlIGxhcHRvcCBCSU9T
KT88dT48L3U+PHU+PC91PjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwi
Pi0gU2hvdWxkIEkgcmFpc2UgYSBidWcgZm9yIHRoaXM/PHU+PC91Pjx1PjwvdT48L3A+DQo8L2Rp
dj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj4tIFdvdWxkIHlvdSBwcm92aWRlIGFueSBy
ZWNvbW1lbmRhdGlvbnMgdG8gaGVscCBtZSB0cm91Ymxlc2hvb3QgdGhpcz88dT48L3U+PHU+PC91
PjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPi0gV2hhdCBvdGhlciBp
bmZvcm1hdGlvbiBzaG91bGQgSSBwcm92aWRlPzx1PjwvdT48dT48L3U+PC9wPg0KPC9kaXY+DQo8
ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+PHU+PC91PsKgPHU+PC91PjwvcD4NCjwvZGl2Pg0K
PGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPlRoaXMgaXMgdGhlIG91dHB1dCBkdXJpbmcgQUNQ
SSBpbml0aWFsaXphdGlvbiBvbiB0aGUgcHJvYmxlbWF0aWMgbGFwdG9wIChmcm9tIG15IE9TTCk6
PHU+PC91Pjx1PjwvdT48L3A+DQo8L2Rpdj4NCjxkaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05v
cm1hbCI+LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tPHdicj4tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS08d2JyPi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLTx3YnI+LS0t
LS0tPHU+PC91Pjx1PjwvdT48L3A+DQo8L2Rpdj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFs
Ij5BQ1BJOiBSU0RQIDB4MDAwMDAwMDAwMDBGMDEyMCAwMDAwMjQgKHYwMiBMRU5PVk8pPHU+PC91
Pjx1PjwvdT48L3A+DQo8L2Rpdj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj5BQ1BJOiBY
U0RUIDB4MDAwMDAwMDBEN0ZEMjE4OCAwMDAwQ0MgKHYwMSBMRU5PVk8gVFAtUjAwIMKgIDAwMDAw
MDAwIFBURUMgMDAwMDAwMDIpPHU+PC91Pjx1PjwvdT48L3A+DQo8L2Rpdj4NCjxkaXY+DQo8cCBj
bGFzcz0iTXNvTm9ybWFsIj5BQ1BJOiBGQUNQIDB4MDAwMDAwMDBEN0ZGNzAwMCAwMDAwRjQgKHYw
NSBMRU5PVk8gVFAtUjAwIMKgIDAwMDAwNDIwIFBURUMgMDAwMDAwMDIpPHU+PC91Pjx1PjwvdT48
L3A+DQo8L2Rpdj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj5BQ1BJOiBEU0RUIDB4MDAw
MDAwMDBEN0ZERTAwMCAwMTE0NTEgKHYwMiBMRU5PVk8gVFAtUjAwIMKgIDAwMDAwNDIwIElOVEwg
MjAxNDExMDcpPHU+PC91Pjx1PjwvdT48L3A+DQo8L2Rpdj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNv
Tm9ybWFsIj5BQ1BJOiBGQUNTIDB4MDAwMDAwMDBEN0ZBMjAwMCAwMDAwNDA8dT48L3U+PHU+PC91
PjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPkFDUEk6IFVFRkkgMHgw
MDAwMDAwMEQ3RkI5MDAwIDAwMDA0MiAodjAxIExFTk9WTyBUUC1SMDAgwqAgMDAwMDA0MjAgUFRF
QyAwMDAwMDAwMik8dT48L3U+PHU+PC91PjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJN
c29Ob3JtYWwiPkFDUEk6IFNTRFQgMHgwMDAwMDAwMEQ3RkY4MDAwIDAwNEUwQSAodjAyIExFTk9W
TyBTYVNzZHQgwqAgMDAwMDMwMDAgSU5UTCAyMDE0MTEwNyk8dT48L3U+PHU+PC91PjwvcD4NCjwv
ZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPkFDUEk6IEFTRiEgMHgwMDAwMDAwMEQ3
RkY2MDAwIDAwMDBBNSAodjMyIExFTk9WTyBUUC1SMDAgwqAgMDAwMDA0MjAgUFRFQyAwMDAwMDAw
Mik8dT48L3U+PHU+PC91PjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwi
PkFDUEk6IEVDRFQgMHgwMDAwMDAwMEQ3RkY1MDAwIDAwMDA1MiAodjAxIExFTk9WTyBUUC1SMDAg
wqAgMDAwMDA0MjAgUFRFQyAwMDAwMDAwMik8dT48L3U+PHU+PC91PjwvcD4NCjwvZGl2Pg0KPGRp
dj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPkFDUEk6IEhQRVQgMHgwMDAwMDAwMEQ3RkY0MDAwIDAw
MDAzOCAodjAxIExFTk9WTyBUUC1SMDAgwqAgMDAwMDA0MjAgUFRFQyAwMDAwMDAwMik8dT48L3U+
PHU+PC91PjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPkFDUEk6IExQ
SVQgMHgwMDAwMDAwMEQ3RkYzMDAwIDAwMDA5NCAodjAxIExFTk9WTyBUUC1SMDAgwqAgMDAwMDA0
MjAgUFRFQyAwMDAwMDAwMik8dT48L3U+PHU+PC91PjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNs
YXNzPSJNc29Ob3JtYWwiPkFDUEk6IEFQSUMgMHgwMDAwMDAwMEQ3RkYyMDAwIDAwMDBCQyAodjAz
IExFTk9WTyBUUC1SMDAgwqAgMDAwMDA0MjAgUFRFQyAwMDAwMDAwMik8dT48L3U+PHU+PC91Pjwv
cD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPkFDUEk6IE1DRkcgMHgwMDAw
MDAwMEQ3RkYxMDAwIDAwMDAzQyAodjAxIExFTk9WTyBUUC1SMDAgwqAgMDAwMDA0MjAgUFRFQyAw
MDAwMDAwMik8dT48L3U+PHU+PC91PjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29O
b3JtYWwiPkFDUEk6IFdEQVQgMHgwMDAwMDAwMEQ3RkYwMDAwIDAwMDEzNCAodjAxIExFTk9WTyBU
UC1SMDAgwqAgMDAwMDA0MjAgUFRFQyAwMDAwMDAwMik8dT48L3U+PHU+PC91PjwvcD4NCjwvZGl2
Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPkFDUEk6IFNTRFQgMHgwMDAwMDAwMEQ3RkRD
MDAwIDAwMUFGQyAodjAxIExFTk9WTyBTYXRhQWhjaSAwMDAwMTAwMCBJTlRMIDIwMTQxMTA3KTx1
PjwvdT48dT48L3U+PC9wPg0KPC9kaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+QUNQ
STogREJHUCAweDAwMDAwMDAwRDdGREIwMDAgMDAwMDM0ICh2MDEgTEVOT1ZPIFRQLVIwMCDCoCAw
MDAwMDQyMCBQVEVDIDAwMDAwMDAyKTx1PjwvdT48dT48L3U+PC9wPg0KPC9kaXY+DQo8ZGl2Pg0K
PHAgY2xhc3M9Ik1zb05vcm1hbCI+QUNQSTogREJHMiAweDAwMDAwMDAwRDdGREEwMDAgMDAwMDU0
ICh2MDAgTEVOT1ZPIFRQLVIwMCDCoCAwMDAwMDQyMCBQVEVDIDAwMDAwMDAyKTx1PjwvdT48dT48
L3U+PC9wPg0KPC9kaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+QUNQSTogQk9PVCAw
eDAwMDAwMDAwRDdGRDkwMDAgMDAwMDI4ICh2MDEgTEVOT1ZPIFRQLVIwMCDCoCAwMDAwMDQyMCBQ
VEVDIDAwMDAwMDAyKTx1PjwvdT48dT48L3U+PC9wPg0KPC9kaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9
Ik1zb05vcm1hbCI+QUNQSTogQkFUQiAweDAwMDAwMDAwRDdGRDgwMDAgMDAwMDQ2ICh2MDEgTEVO
T1ZPIFRQLVIwMCDCoCAwMDAwMDQyMCBQVEVDIDAwMDAwMDAyKTx1PjwvdT48dT48L3U+PC9wPg0K
PC9kaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+QUNQSTogU0xJQyAweDAwMDAwMDAw
RDdGRDcwMDAgMDAwMTc2ICh2MDEgTEVOT1ZPIFRQLVIwMCDCoCAwMDAwMDQyMCBQVEVDIDAwMDAw
MDAyKTx1PjwvdT48dT48L3U+PC9wPg0KPC9kaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1h
bCI+QUNQSTogU1NEVCAweDAwMDAwMDAwRDdGRDYwMDAgMDAwRTU4ICh2MDIgTEVOT1ZPIENwdVNz
ZHQgwqAwMDAwMzAwMCBJTlRMIDIwMTQxMTA3KTx1PjwvdT48dT48L3U+PC9wPg0KPC9kaXY+DQo8
ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+QUNQSTogU1NEVCAweDAwMDAwMDAwRDdGRDUwMDAg
MDAwM0Q5ICh2MDIgTEVOT1ZPIEN0ZHBCIMKgIMKgMDAwMDEwMDAgSU5UTCAyMDE0MTEwNyk8dT48
L3U+PHU+PC91PjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPkFDUEk6
IE1TRE0gMHgwMDAwMDAwMEQ3RkQ0MDAwIDAwMDA1NSAodjAzIExFTk9WTyBUUC1SMDAgwqAgMDAw
MDA0MjAgUFRFQyAwMDAwMDAwMik8dT48L3U+PHU+PC91PjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxw
IGNsYXNzPSJNc29Ob3JtYWwiPkFDUEk6IEZQRFQgMHgwMDAwMDAwMEQ3RkQzMDAwIDAwMDA0NCAo
djAxIExFTk9WTyBUUC1SMDAgwqAgMDAwMDA0MjAgUFRFQyAwMDAwMDAwMik8dT48L3U+PHU+PC91
PjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPkFDUEk6IFVFRkkgMHgw
MDAwMDAwMEQ3RkEwMDAwIDAwMDEyQSAodjAxIExFTk9WTyBUUC1SMDAgwqAgMDAwMDA0MjAgUFRF
QyAwMDAwMDAwMik8dT48L3U+PHU+PC91PjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJN
c29Ob3JtYWwiPjx1PjwvdT7CoDx1PjwvdT48L3A+DQo8L2Rpdj4NCjxkaXY+DQo8cCBjbGFzcz0i
TXNvTm9ybWFsIj5Jbml0aWFsaXppbmcgTmFtZXNwYWNlIG9iamVjdHM6PHU+PC91Pjx1PjwvdT48
L3A+DQo8L2Rpdj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj5UYWJsZSBbRFNEVDogVFAt
UjAwIMKgXSAoaWQgMDEpIC0gMjc1NyBPYmplY3RzIHdpdGggwqA3NiBEZXZpY2VzLCDCoDQwIFJl
Z2lvbnMsIMKgNTEwIE1ldGhvZHMgKDE0MC8zNzAvMjQgU2VyaWFsL05vbi9DdnQpPHU+PC91Pjx1
PjwvdT48L3A+DQo8L2Rpdj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj5UYWJsZSBbU1NE
VDogU2FTc2R0IMKgXSAoaWQgMDIpIC0gwqA1NTIgT2JqZWN0cyB3aXRoIMKgMTggRGV2aWNlcywg
wqAyMCBSZWdpb25zLCDCoDEzMSBNZXRob2RzICg0MS85MC83IFNlcmlhbC9Ob24vQ3Z0KTx1Pjwv
dT48dT48L3U+PC9wPg0KPC9kaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+VGFibGUg
W1NTRFQ6IFNhdGFBaGNpXSAoaWQgMDMpIC0gwqAxODMgT2JqZWN0cyB3aXRoIMKgIDggRGV2aWNl
cywgwqAgMCBSZWdpb25zLCDCoCAzNCBNZXRob2RzICgyNS85LzUgU2VyaWFsL05vbi9DdnQpPHU+
PC91Pjx1PjwvdT48L3A+DQo8L2Rpdj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj5UYWJs
ZSBbU1NEVDogQ3B1U3NkdCBdIChpZCAwNCkgLSDCoDExNCBPYmplY3RzIHdpdGggwqAgMCBEZXZp
Y2VzLCDCoCAzIFJlZ2lvbnMsIMKgIDI5IE1ldGhvZHMgKDEzLzE2LzEzIFNlcmlhbC9Ob24vQ3Z0
KTx1PjwvdT48dT48L3U+PC9wPg0KPC9kaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+
VGFibGUgW1NTRFQ6IEN0ZHBCIMKgIF0gKGlkIDA1KSAtIMKgIDMzIE9iamVjdHMgd2l0aCDCoCAw
IERldmljZXMsIMKgIDEgUmVnaW9ucywgwqAgwqA1IE1ldGhvZHMgKDIvMy8xIFNlcmlhbC9Ob24v
Q3Z0KTx1PjwvdT48dT48L3U+PC9wPg0KPC9kaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1h
bCI+QUNQSTogNSBBQ1BJIEFNTCB0YWJsZXMgc3VjY2Vzc2Z1bGx5IGFjcXVpcmVkIGFuZCBsb2Fk
ZWQ8dT48L3U+PHU+PC91PjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwi
PkNvbXBsZXRpbmcgUmVnaW9uL0ZpZWxkL0J1ZmZlci9QYWNrYWdlIGluaXRpYWxpemF0aW9uOjx1
PjwvdT48dT48L3U+PC9wPg0KPC9kaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+wqAg
wqAgSW5pdGlhbGl6ZWQgNjMvNjQgUmVnaW9ucyA3MS83MSBGaWVsZHMgODgvODggQnVmZmVycyA4
My84MyBQYWNrYWdlcyAoMzY0OCBub2Rlcyk8dT48L3U+PHU+PC91PjwvcD4NCjwvZGl2Pg0KPGRp
dj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPsKgZXZ4ZmV2bnQtMDIxOCBFbmFibGUgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqA6IFRyYW5zaXRpb24gdG8gQUNQSSBtb2RlIHN1Y2Nlc3NmdWw8dT48L3U+
PHU+PC91PjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPkluaXRpYWxp
emluZyBHZW5lcmFsIFB1cnBvc2UgRXZlbnRzIChHUEVzKTo8dT48L3U+PHU+PC91PjwvcD4NCjwv
ZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPsKgIMKgIEluaXRpYWxpemVkIEdQRSAw
MCB0byA3RiBbX0dQRV0gMTYgcmVncyBvbiBpbnRlcnJ1cHQgMHg5IChTQ0kpPHU+PC91Pjx1Pjwv
dT48L3A+DQo8L2Rpdj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj5Jbml0aWFsaXppbmcg
RGV2aWNlL1Byb2Nlc3Nvci9UaGVybWFsIG9iamVjdHMgYW5kIGV4ZWN1dGluZyBfSU5JL19TVEEg
bWV0aG9kczo8dT48L3U+PHU+PC91PjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29O
b3JtYWwiPkFDUEkgRXJyb3I6IE5vIGhhbmRsZXIgZm9yIFJlZ2lvbiBbRUNPUl0gKDgwZGExMzAp
IFtFbWJlZGRlZENvbnRyb2xdICgyMDE3MDMwMy9ldnJlZ2lvbi0yOTEpPHU+PC91Pjx1PjwvdT48
L3A+DQo8L2Rpdj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj5BQ1BJIEVycm9yOiBSZWdp
b24gRW1iZWRkZWRDb250cm9sIChJRD0zKSBoYXMgbm8gaGFuZGxlciAoMjAxNzAzMDMvZXhmbGRp
by00MzEpPHU+PC91Pjx1PjwvdT48L3A+DQo8L2Rpdj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9y
bWFsIj5BQ1BJIEVycm9yOiBNZXRob2QgcGFyc2UvZXhlY3V0aW9uIGZhaWxlZCBbXF9TQi5QQ0kw
LkxQQy5FQy5BQy5fUFNSXSAoTm9kZSA4MGQwYzMwKSwgQUVfTk9UX0VYSVNUICgyMDE3MDMwMy9w
c3BhcnNlLTY2OCk8dT48L3U+PHU+PC91PjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJN
c29Ob3JtYWwiPkFDUEkgRXJyb3I6IE1ldGhvZCBwYXJzZS9leGVjdXRpb24gZmFpbGVkIFtcX1NC
Ll9JTkldIChOb2RlIDgwZTRmNTApLCBBRV9OT1RfRVhJU1QgKDIwMTcwMzAzL3BzcGFyc2UtNjY4
KTx1PjwvdT48dT48L3U+PC9wPg0KPC9kaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+
QUNQSSBFcnJvcjogTm8gaGFuZGxlciBmb3IgUmVnaW9uIFtFQ09SXSAoODBkYTEzMCkgW0VtYmVk
ZGVkQ29udHJvbF0gKDIwMTcwMzAzL2V2cmVnaW9uLTI5MSk8dT48L3U+PHU+PC91PjwvcD4NCjwv
ZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPkFDUEkgRXJyb3I6IFJlZ2lvbiBFbWJl
ZGRlZENvbnRyb2wgKElEPTMpIGhhcyBubyBoYW5kbGVyICgyMDE3MDMwMy9leGZsZGlvLTQzMSk8
dT48L3U+PHU+PC91PjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPkFD
UEkgRXJyb3I6IE1ldGhvZCBwYXJzZS9leGVjdXRpb24gZmFpbGVkIFtcX1NCLlBDSTAuTFBDLkVD
Ll9JTkldIChOb2RlIDgwZDAwZDApLCBBRV9OT1RfRVhJU1QgKDIwMTcwMzAzL3BzcGFyc2UtNjY4
KTx1PjwvdT48dT48L3U+PC9wPg0KPC9kaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+
QUNQSSBFeGNlcHRpb246IEFFX05PVF9FWElTVCwgZHVyaW5nIFxfU0IuUENJMC5MUEMuRUMuX0lO
SSBleGVjdXRpb24gKDIwMTcwMzAzL25zaW5pdC04MDcpPHU+PC91Pjx1PjwvdT48L3A+DQo8L2Rp
dj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj7CoCDCoCBFeGVjdXRlZCAxMyBfSU5JIG1l
dGhvZHMgcmVxdWlyaW5nIDEgX1NUQSBleGVjdXRpb25zIChleGFtaW5lZCAxMTMgb2JqZWN0cyk8
dT48L3U+PHU+PC91PjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPi0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLTx3YnI+LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tPHdicj4tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS08d2JyPi0tLS0tLTx1Pjwv
dT48dT48L3U+PC9wPg0KPC9kaXY+DQo8L2Rpdj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFs
Ij48dT48L3U+wqA8dT48L3U+PC9wPg0KPC9kaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1h
bCI+VGhpcyBpcyB0aGUgb3V0cHV0IGZyb20gY2FsbGluZyBBY3BpRXZhbHVhdGVPYmplY3QgZm9y
IHRoZSBjb250cm9sIG1ldGhvZCAmcXVvdDtcX1NCLlBDSTAuTFBDLkVDLkJBVDAuX0JTVCZxdW90
Oywgd2hpY2ggcmV0dXJucyB3aXRoIEFFX05PVF9FWElTVDo8dT48L3U+PHU+PC91PjwvcD4NCjwv
ZGl2Pg0KPGRpdj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj4tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS08d2JyPi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLTx3YnI+LS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tPHdicj4tLS0tLS08dT48L3U+PHU+PC91PjwvcD4N
CjwvZGl2Pg0KPC9kaXY+DQo8ZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPkFDUEkg
RXJyb3I6IE5vIGhhbmRsZXIgZm9yIFJlZ2lvbiBbRUNPUl0gKDgwZGExMzApIFtFbWJlZGRlZENv
bnRyb2xdICgyMDE3MDMwMy9ldnJlZ2lvbi0yOTEpPHU+PC91Pjx1PjwvdT48L3A+DQo8L2Rpdj4N
CjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj5BQ1BJIEVycm9yOiBSZWdpb24gRW1iZWRkZWRD
b250cm9sIChJRD0zKSBoYXMgbm8gaGFuZGxlciAoMjAxNzAzMDMvZXhmbGRpby00MzEpPHU+PC91
Pjx1PjwvdT48L3A+DQo8L2Rpdj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj5BQ1BJIEVy
cm9yOiBNZXRob2QgcGFyc2UvZXhlY3V0aW9uIGZhaWxlZCBbXF9TQi5QQ0kwLkxQQy5FQy5CQVQw
Ll9CU1RdIChOb2RlIDgwZDBiNzApLCBBRV9OT1RfRVhJU1QgKDIwMTcwMzAzL3BzcGFyc2UtNjY4
KTx1PjwvdT48dT48L3U+PC9wPg0KPC9kaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tPHdicj4tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS08d2JyPi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLTx3YnI+LS0tLS0tPHU+
PC91Pjx1PjwvdT48L3A+DQo8L2Rpdj4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3Jt
YWwiPjx1PjwvdT7CoDx1PjwvdT48L3A+DQo8L2Rpdj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9y
bWFsIj5UaGlzIGlzIHRoZSBvdXRwdXQgZnJvbSBleGVjdXRpbmcgdGhlIGNvbnRyb2wgbWV0aG9k
IHVzaW5nIGFjcGlleGVjOjx1PjwvdT48dT48L3U+PC9wPg0KPC9kaXY+DQo8ZGl2Pg0KPGRpdj4N
CjxwIGNsYXNzPSJNc29Ob3JtYWwiPi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLTx3YnI+
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tPHdicj4tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS08d2JyPi0tLS0tLTx1PjwvdT48dT48L3U+PC9wPg0KPC9kaXY+DQo8ZGl2Pg0KPHAg
Y2xhc3M9Ik1zb05vcm1hbCI+IyAuL2FjcGlleGVjICouZGF0PHU+PC91Pjx1PjwvdT48L3A+DQo8
L2Rpdj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj48dT48L3U+wqA8dT48L3U+PC9wPg0K
PC9kaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+PHU+PC91PsKgPHU+PC91PjwvcD4N
CjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPkludGVsIEFDUEkgQ29tcG9uZW50
IEFyY2hpdGVjdHVyZTx1PjwvdT48dT48L3U+PC9wPg0KPC9kaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9
Ik1zb05vcm1hbCI+QU1MIEV4ZWN1dGlvbi9EZWJ1ZyBVdGlsaXR5IHZlcnNpb24gMjAxNzAzMDM8
dT48L3U+PHU+PC91PjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPkNv
cHlyaWdodCAoYykgMjAwMCAtIDIwMTcgSW50ZWwgQ29ycG9yYXRpb248dT48L3U+PHU+PC91Pjwv
cD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPjx1PjwvdT7CoDx1PjwvdT48
L3A+DQo8L2Rpdj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj5JbnB1dCBmaWxlIGFwaWMu
ZGF0LCBMZW5ndGggMHhCQyAoMTg4KSBieXRlczx1PjwvdT48dT48L3U+PC9wPg0KPC9kaXY+DQo8
ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+SW5wdXQgZmlsZSBhc2YhLmRhdCwgTGVuZ3RoIDB4
QTUgKDE2NSkgYnl0ZXM8dT48L3U+PHU+PC91PjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNz
PSJNc29Ob3JtYWwiPklucHV0IGZpbGUgYmF0Yi5kYXQsIExlbmd0aCAweDQ2ICg3MCkgYnl0ZXM8
dT48L3U+PHU+PC91PjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPklu
cHV0IGZpbGUgYm9vdC5kYXQsIExlbmd0aCAweDI4ICg0MCkgYnl0ZXM8dT48L3U+PHU+PC91Pjwv
cD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPklucHV0IGZpbGUgZGJnMi5k
YXQsIExlbmd0aCAweDU0ICg4NCkgYnl0ZXM8dT48L3U+PHU+PC91PjwvcD4NCjwvZGl2Pg0KPGRp
dj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPklucHV0IGZpbGUgZGJncC5kYXQsIExlbmd0aCAweDM0
ICg1MikgYnl0ZXM8dT48L3U+PHU+PC91PjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJN
c29Ob3JtYWwiPklucHV0IGZpbGUgZHNkdC5kYXQsIExlbmd0aCAweDExNDUxICg3MDczNykgYnl0
ZXM8dT48L3U+PHU+PC91PjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwi
PklucHV0IGZpbGUgZWNkdC5kYXQsIExlbmd0aCAweDUyICg4MikgYnl0ZXM8dT48L3U+PHU+PC91
PjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPklucHV0IGZpbGUgZmFj
cC5kYXQsIExlbmd0aCAweEY0ICgyNDQpIGJ5dGVzPHU+PC91Pjx1PjwvdT48L3A+DQo8L2Rpdj4N
CjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj5JbnB1dCBmaWxlIGZhY3MuZGF0LCBMZW5ndGgg
MHg0MCAoNjQpIGJ5dGVzPHU+PC91Pjx1PjwvdT48L3A+DQo8L2Rpdj4NCjxkaXY+DQo8cCBjbGFz
cz0iTXNvTm9ybWFsIj5JbnB1dCBmaWxlIGZwZHQuZGF0LCBMZW5ndGggMHg0NCAoNjgpIGJ5dGVz
PHU+PC91Pjx1PjwvdT48L3A+DQo8L2Rpdj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj5J
bnB1dCBmaWxlIGhwZXQuZGF0LCBMZW5ndGggMHgzOCAoNTYpIGJ5dGVzPHU+PC91Pjx1PjwvdT48
L3A+DQo8L2Rpdj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj5JbnB1dCBmaWxlIGxwaXQu
ZGF0LCBMZW5ndGggMHg5NCAoMTQ4KSBieXRlczx1PjwvdT48dT48L3U+PC9wPg0KPC9kaXY+DQo8
ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+SW5wdXQgZmlsZSBtY2ZnLmRhdCwgTGVuZ3RoIDB4
M0MgKDYwKSBieXRlczx1PjwvdT48dT48L3U+PC9wPg0KPC9kaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9
Ik1zb05vcm1hbCI+SW5wdXQgZmlsZSBtc2RtLmRhdCwgTGVuZ3RoIDB4NTUgKDg1KSBieXRlczx1
PjwvdT48dT48L3U+PC9wPg0KPC9kaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+SW5w
dXQgZmlsZSBzbGljLmRhdCwgTGVuZ3RoIDB4MTc2ICgzNzQpIGJ5dGVzPHU+PC91Pjx1PjwvdT48
L3A+DQo8L2Rpdj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj5JbnB1dCBmaWxlIHNzZHQx
LmRhdCwgTGVuZ3RoIDB4NEUwQSAoMTk5NzgpIGJ5dGVzPHU+PC91Pjx1PjwvdT48L3A+DQo8L2Rp
dj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj5JbnB1dCBmaWxlIHNzZHQyLmRhdCwgTGVu
Z3RoIDB4MUFGQyAoNjkwOCkgYnl0ZXM8dT48L3U+PHU+PC91PjwvcD4NCjwvZGl2Pg0KPGRpdj4N
CjxwIGNsYXNzPSJNc29Ob3JtYWwiPklucHV0IGZpbGUgc3NkdDMuZGF0LCBMZW5ndGggMHhFNTgg
KDM2NzIpIGJ5dGVzPHU+PC91Pjx1PjwvdT48L3A+DQo8L2Rpdj4NCjxkaXY+DQo8cCBjbGFzcz0i
TXNvTm9ybWFsIj5JbnB1dCBmaWxlIHNzZHQ0LmRhdCwgTGVuZ3RoIDB4M0Q5ICg5ODUpIGJ5dGVz
PHU+PC91Pjx1PjwvdT48L3A+DQo8L2Rpdj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj5J
bnB1dCBmaWxlIHVlZmkxLmRhdCwgTGVuZ3RoIDB4NDIgKDY2KSBieXRlczx1PjwvdT48dT48L3U+
PC9wPg0KPC9kaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+SW5wdXQgZmlsZSB1ZWZp
Mi5kYXQsIExlbmd0aCAweDEyQSAoMjk4KSBieXRlczx1PjwvdT48dT48L3U+PC9wPg0KPC9kaXY+
DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+SW5wdXQgZmlsZSB3ZGF0LmRhdCwgTGVuZ3Ro
IDB4MTM0ICgzMDgpIGJ5dGVzPHU+PC91Pjx1PjwvdT48L3A+DQo8L2Rpdj4NCjxkaXY+DQo8cCBj
bGFzcz0iTXNvTm9ybWFsIj5JbnB1dCBmaWxlIHhzZHQuZGF0LCBMZW5ndGggMHhDQyAoMjA0KSBi
eXRlczx1PjwvdT48dT48L3U+PC9wPg0KPC9kaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1h
bCI+PHU+PC91PsKgPHU+PC91PjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3Jt
YWwiPkFDUEk6IFJTRFAgMHgwMDAwMDAwMDA4MERCQ0UwIDAwMDAyNCAodjAyIEludGVsICk8dT48
L3U+PHU+PC91PjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPkFDUEk6
IFhTRFQgMHgwMDAwMDAwMDA4MEU3OEM4IDAwMDBFNCAodjAwIEludGVsIMKgQWNwaUV4ZWMgMDAw
MDEwMDEgSU5UTCAyMDE3MDMwMyk8dT48L3U+PHU+PC91PjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxw
IGNsYXNzPSJNc29Ob3JtYWwiPkFDUEk6IEZBQ1AgMHgwMDAwMDAwMDA4MEVBNTUwIDAwMDBGNCAo
djA1IExFTk9WTyBUUC1SMDAgwqAgMDAwMDA0MjAgUFRFQyAwMDAwMDAwMik8dT48L3U+PHU+PC91
PjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPkFDUEk6IERTRFQgMHgw
MDAwMDAwMDA4MEVGMDIwIDAxMTQ1MSAodjAyIExFTk9WTyBUUC1SMDAgwqAgMDAwMDA0MjAgSU5U
TCAyMDE0MTEwNyk8dT48L3U+PHU+PC91PjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJN
c29Ob3JtYWwiPkFDUEk6IEZBQ1MgMHgwMDAwMDAwMDA4MERCRDIwIDAwMDA0MDx1PjwvdT48dT48
L3U+PC9wPg0KPC9kaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+QUNQSTogQVBJQyAw
eDAwMDAwMDAwMDgwRUE3MDggMDAwMEJDICh2MDMgTEVOT1ZPIFRQLVIwMCDCoCAwMDAwMDQyMCBQ
VEVDIDAwMDAwMDAyKTx1PjwvdT48dT48L3U+PC9wPg0KPC9kaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9
Ik1zb05vcm1hbCI+QUNQSTogQVNGISAweDAwMDAwMDAwMDgwRUE2NTAgMDAwMEE1ICh2MzIgTEVO
T1ZPIFRQLVIwMCDCoCAwMDAwMDQyMCBQVEVDIDAwMDAwMDAyKTx1PjwvdT48dT48L3U+PC9wPg0K
PC9kaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+QUNQSTogQkFUQiAweDAwMDAwMDAw
MDgwRTMwQTggMDAwMDQ2ICh2MDEgTEVOT1ZPIFRQLVIwMCDCoCAwMDAwMDQyMCBQVEVDIDAwMDAw
MDAyKTx1PjwvdT48dT48L3U+PC9wPg0KPC9kaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1h
bCI+QUNQSTogQk9PVCAweDAwMDAwMDAwMDgwRTAxRDggMDAwMDI4ICh2MDEgTEVOT1ZPIFRQLVIw
MCDCoCAwMDAwMDQyMCBQVEVDIDAwMDAwMDAyKTx1PjwvdT48dT48L3U+PC9wPg0KPC9kaXY+DQo8
ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+QUNQSTogREJHMiAweDAwMDAwMDAwMDgwRTIxRjAg
MDAwMDU0ICh2MDAgTEVOT1ZPIFRQLVIwMCDCoCAwMDAwMDQyMCBQVEVDIDAwMDAwMDAyKTx1Pjwv
dT48dT48L3U+PC9wPg0KPC9kaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+QUNQSTog
REJHUCAweDAwMDAwMDAwMDgwRTEyRDggMDAwMDM0ICh2MDEgTEVOT1ZPIFRQLVIwMCDCoCAwMDAw
MDQyMCBQVEVDIDAwMDAwMDAyKTx1PjwvdT48dT48L3U+PC9wPg0KPC9kaXY+DQo8ZGl2Pg0KPHAg
Y2xhc3M9Ik1zb05vcm1hbCI+QUNQSTogRUNEVCAweDAwMDAwMDAwMDgwRTIyNTggMDAwMDUyICh2
MDEgTEVOT1ZPIFRQLVIwMCDCoCAwMDAwMDQyMCBQVEVDIDAwMDAwMDAyKTx1PjwvdT48dT48L3U+
PC9wPg0KPC9kaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+QUNQSTogRkFDUyAweDAw
MDAwMDAwMDgwRTEzMjAgMDAwMDQwPHU+PC91Pjx1PjwvdT48L3A+DQo8L2Rpdj4NCjxkaXY+DQo8
cCBjbGFzcz0iTXNvTm9ybWFsIj5BQ1BJOiBGUERUIDB4MDAwMDAwMDAwODBFMzEwMCAwMDAwNDQg
KHYwMSBMRU5PVk8gVFAtUjAwIMKgIDAwMDAwNDIwIFBURUMgMDAwMDAwMDIpPHU+PC91Pjx1Pjwv
dT48L3A+DQo8L2Rpdj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj5BQ1BJOiBIUEVUIDB4
MDAwMDAwMDAwODBFMTM2OCAwMDAwMzggKHYwMSBMRU5PVk8gVFAtUjAwIMKgIDAwMDAwNDIwIFBU
RUMgMDAwMDAwMDIpPHU+PC91Pjx1PjwvdT48L3A+DQo8L2Rpdj4NCjxkaXY+DQo8cCBjbGFzcz0i
TXNvTm9ybWFsIj5BQ1BJOiBMUElUIDB4MDAwMDAwMDAwODBFQTRCMCAwMDAwOTQgKHYwMSBMRU5P
Vk8gVFAtUjAwIMKgIDAwMDAwNDIwIFBURUMgMDAwMDAwMDIpPHU+PC91Pjx1PjwvdT48L3A+DQo8
L2Rpdj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj5BQ1BJOiBNQ0ZHIDB4MDAwMDAwMDAw
ODBFMTNCMCAwMDAwM0MgKHYwMSBMRU5PVk8gVFAtUjAwIMKgIDAwMDAwNDIwIFBURUMgMDAwMDAw
MDIpPHU+PC91Pjx1PjwvdT48L3A+DQo8L2Rpdj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFs
Ij5BQ1BJOiBNU0RNIDB4MDAwMDAwMDAwODBFMjJDMCAwMDAwNTUgKHYwMyBMRU5PVk8gVFAtUjAw
IMKgIDAwMDAwNDIwIFBURUMgMDAwMDAwMDIpPHU+PC91Pjx1PjwvdT48L3A+DQo8L2Rpdj4NCjxk
aXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj5BQ1BJOiBTTElDIDB4MDAwMDAwMDAwODBFQTMyOCAw
MDAxNzYgKHYwMSBMRU5PVk8gVFAtUjAwIMKgIDAwMDAwNDIwIFBURUMgMDAwMDAwMDIpPHU+PC91
Pjx1PjwvdT48L3A+DQo8L2Rpdj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj5BQ1BJOiBT
U0RUIDB4MDAwMDAwMDAwODEwMTAyMCAwMDRFMEEgKHYwMiBMRU5PVk8gU2FTc2R0IMKgIDAwMDAz
MDAwIElOVEwgMjAxNDExMDcpPHU+PC91Pjx1PjwvdT48L3A+DQo8L2Rpdj4NCjxkaXY+DQo8cCBj
bGFzcz0iTXNvTm9ybWFsIj5BQ1BJOiBTU0RUIDB4MDAwMDAwMDAwODBFODgyMCAwMDFBRkMgKHYw
MSBMRU5PVk8gU2F0YUFoY2kgMDAwMDEwMDAgSU5UTCAyMDE0MTEwNyk8dT48L3U+PHU+PC91Pjwv
cD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPkFDUEk6IFNTRFQgMHgwMDAw
MDAwMDA4MEU3OUI4IDAwMEU1OCAodjAyIExFTk9WTyBDcHVTc2R0IMKgMDAwMDMwMDAgSU5UTCAy
MDE0MTEwNyk8dT48L3U+PHU+PC91PjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29O
b3JtYWwiPkFDUEk6IFNTRFQgMHgwMDAwMDAwMDA4MEVBN0QwIDAwMDNEOSAodjAyIExFTk9WTyBD
dGRwQiDCoCDCoDAwMDAxMDAwIElOVEwgMjAxNDExMDcpPHU+PC91Pjx1PjwvdT48L3A+DQo8L2Rp
dj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj5BQ1BJOiBVRUZJIDB4MDAwMDAwMDAwODBF
MzE1OCAwMDAwNDIgKHYwMSBMRU5PVk8gVFAtUjAwIMKgIDAwMDAwNDIwIFBURUMgMDAwMDAwMDIp
PHU+PC91Pjx1PjwvdT48L3A+DQo8L2Rpdj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj5B
Q1BJOiBVRUZJIDB4MDAwMDAwMDAwODBFNzQ3MCAwMDAxMkEgKHYwMSBMRU5PVk8gVFAtUjAwIMKg
IDAwMDAwNDIwIFBURUMgMDAwMDAwMDIpPHU+PC91Pjx1PjwvdT48L3A+DQo8L2Rpdj4NCjxkaXY+
DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj5BQ1BJOiBXREFUIDB4MDAwMDAwMDAwODBFNzMzMCAwMDAx
MzQgKHYwMSBMRU5PVk8gVFAtUjAwIMKgIDAwMDAwNDIwIFBURUMgMDAwMDAwMDIpPHU+PC91Pjx1
PjwvdT48L3A+DQo8L2Rpdj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj5BQ1BJOiBYU0RU
IDB4MDAwMDAwMDAwODBFNzIzMCAwMDAwQ0MgKHYwMSBMRU5PVk8gVFAtUjAwIMKgIDAwMDAwMDAw
IFBURUMgMDAwMDAwMDIpPHU+PC91Pjx1PjwvdT48L3A+DQo8L2Rpdj4NCjxkaXY+DQo8cCBjbGFz
cz0iTXNvTm9ybWFsIj5Jbml0aWFsaXppbmcgR2VuZXJhbCBQdXJwb3NlIEV2ZW50cyAoR1BFcyk6
PHU+PC91Pjx1PjwvdT48L3A+DQo8L2Rpdj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj7C
oCDCoCBJbml0aWFsaXplZCBHUEUgMDAgdG8gN0YgW19HUEVdIDE2IHJlZ3Mgb24gaW50ZXJydXB0
IDB4OSAoU0NJKTx1PjwvdT48dT48L3U+PC9wPg0KPC9kaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1z
b05vcm1hbCI+PHU+PC91PsKgPHU+PC91PjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJN
c29Ob3JtYWwiPkluaXRpYWxpemluZyBOYW1lc3BhY2Ugb2JqZWN0czo8dT48L3U+PHU+PC91Pjwv
cD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPlRhYmxlIFtEU0RUOiBUUC1S
MDAgwqBdIChpZCAwMSkgLSAyNzU3IE9iamVjdHMgd2l0aCDCoDc2IERldmljZXMsIMKgNDAgUmVn
aW9ucywgwqA1MTAgTWV0aG9kcyAoMTQwLzM3MC8yNCBTZXJpYWwvTm9uL0N2dCk8dT48L3U+PHU+
PC91PjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPlRhYmxlIFtTU0RU
OiBTYVNzZHQgwqBdIChpZCAwMikgLSDCoDU1MiBPYmplY3RzIHdpdGggwqAxOCBEZXZpY2VzLCDC
oDIwIFJlZ2lvbnMsIMKgMTMxIE1ldGhvZHMgKDQxLzkwLzcgU2VyaWFsL05vbi9DdnQpPHU+PC91
Pjx1PjwvdT48L3A+DQo8L2Rpdj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj5UYWJsZSBb
U1NEVDogU2F0YUFoY2ldIChpZCAwMykgLSDCoDE4MyBPYmplY3RzIHdpdGggwqAgOCBEZXZpY2Vz
LCDCoCAwIFJlZ2lvbnMsIMKgIDM0IE1ldGhvZHMgKDI1LzkvNSBTZXJpYWwvTm9uL0N2dCk8dT48
L3U+PHU+PC91PjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPlRhYmxl
IFtTU0RUOiBDcHVTc2R0IF0gKGlkIDA0KSAtIMKgMTE0IE9iamVjdHMgd2l0aCDCoCAwIERldmlj
ZXMsIMKgIDMgUmVnaW9ucywgwqAgMjkgTWV0aG9kcyAoMTMvMTYvMTMgU2VyaWFsL05vbi9DdnQp
PHU+PC91Pjx1PjwvdT48L3A+DQo8L2Rpdj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj5U
YWJsZSBbU1NEVDogQ3RkcEIgwqAgXSAoaWQgMDUpIC0gwqAgMzMgT2JqZWN0cyB3aXRoIMKgIDAg
RGV2aWNlcywgwqAgMSBSZWdpb25zLCDCoCDCoDUgTWV0aG9kcyAoMi8zLzEgU2VyaWFsL05vbi9D
dnQpPHU+PC91Pjx1PjwvdT48L3A+DQo8L2Rpdj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFs
Ij5BQ1BJOiA1IEFDUEkgQU1MIHRhYmxlcyBzdWNjZXNzZnVsbHkgYWNxdWlyZWQgYW5kIGxvYWRl
ZDx1PjwvdT48dT48L3U+PC9wPg0KPC9kaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+
PHU+PC91PsKgPHU+PC91PjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwi
PkNvbXBsZXRpbmcgUmVnaW9uL0ZpZWxkL0J1ZmZlci9QYWNrYWdlIGluaXRpYWxpemF0aW9uOjx1
PjwvdT48dT48L3U+PC9wPg0KPC9kaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+wqAg
wqAgSW5pdGlhbGl6ZWQgNjMvNjQgUmVnaW9ucyA3MS83MSBGaWVsZHMgODgvODggQnVmZmVycyA4
My84MyBQYWNrYWdlcyAoMzY0OCBub2Rlcyk8dT48L3U+PHU+PC91PjwvcD4NCjwvZGl2Pg0KPGRp
dj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPkluaXRpYWxpemluZyBEZXZpY2UvUHJvY2Vzc29yL1Ro
ZXJtYWwgb2JqZWN0cyBhbmQgZXhlY3V0aW5nIF9JTkkvX1NUQSBtZXRob2RzOjx1PjwvdT48dT48
L3U+PC9wPg0KPC9kaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+W0FjcGlFeGVjXSBF
eGNlcHRpb24gQUVfQU1MX0lORklOSVRFX0xPT1AgZHVyaW5nIGV4ZWN1dGlvbiBvZiBtZXRob2Qg
W1NNSV9dIE9wY29kZSBbV2hpbGVdIEA0NDx1PjwvdT48dT48L3U+PC9wPg0KPC9kaXY+DQo8ZGl2
Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+W1NNSV9dIEAwMDAzNCAjMDBBMjogwqBXaGlsZSAoPHU+
PC91Pjx1PjwvdT48L3A+DQo8L2Rpdj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj5ObyBM
b2NhbCBWYXJpYWJsZXMgYXJlIGluaXRpYWxpemVkIGZvciBtZXRob2QgW1NNSV9dPHU+PC91Pjx1
PjwvdT48L3A+DQo8L2Rpdj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj48dT48L3U+wqA8
dT48L3U+PC9wPg0KPC9kaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+SW5pdGlhbGl6
ZWQgQXJndW1lbnRzIGZvciBNZXRob2QgW1NNSV9dOiDCoCgwIGFyZ3VtZW50cyBkZWZpbmVkIGZv
ciBtZXRob2QgaW52b2NhdGlvbik8dT48L3U+PHU+PC91PjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxw
IGNsYXNzPSJNc29Ob3JtYWwiPsKgIMKgIEFyZzA6IMKgIDgxZWNjNDAgJmx0O09iaiZndDsgwqAg
wqAgwqAgwqAgwqAgwqAgSW50ZWdlciAwMDAwMDAwMDAwMDAwMDA5PHU+PC91Pjx1PjwvdT48L3A+
DQo8L2Rpdj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj7CoCDCoCBBcmcxOiDCoCA4MWVj
YTM4ICZsdDtPYmomZ3Q7IMKgIMKgIMKgIMKgIMKgIMKgIEludGVnZXIgMDAwMDAwMDAwMDAwMDAw
MTx1PjwvdT48dT48L3U+PC9wPg0KPC9kaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+
wqAgwqAgQXJnMjogwqAgODFlY2JkOCAmbHQ7T2JqJmd0OyDCoCDCoCDCoCDCoCDCoCDCoCBJbnRl
Z2VyIDAwMDAwMDAwMDAwMDAwMDA8dT48L3U+PHU+PC91PjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxw
IGNsYXNzPSJNc29Ob3JtYWwiPsKgIMKgIEFyZzM6IMKgIDgxZWM5ZDAgJmx0O09iaiZndDsgwqAg
wqAgwqAgwqAgwqAgwqAgSW50ZWdlciAwMDAwMDAwMDAwMDAwMDAwPHU+PC91Pjx1PjwvdT48L3A+
DQo8L2Rpdj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj7CoCDCoCBBcmc0OiDCoCA4MWVj
YjA4ICZsdDtPYmomZ3Q7IMKgIMKgIMKgIMKgIMKgIMKgIEludGVnZXIgMDAwMDAwMDAwMDAwMDAw
MDx1PjwvdT48dT48L3U+PC9wPg0KPC9kaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+
PHU+PC91PsKgPHU+PC91PjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwi
PkFDUEkgRXJyb3I6IE1ldGhvZCBwYXJzZS9leGVjdXRpb24gZmFpbGVkIFtcU01JXSAoTm9kZSA4
MTRkZTQwKSwgQUVfQU1MX0lORklOSVRFX0xPT1AgKDIwMTcwMzAzL3BzcGFyc2UtNjY4KTx1Pjwv
dT48dT48L3U+PC9wPg0KPC9kaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+QUNQSSBF
cnJvcjogTWV0aG9kIHBhcnNlL2V4ZWN1dGlvbiBmYWlsZWQgW1xXR1NWXSAoTm9kZSA4MTRlOTc4
KSwgQUVfQU1MX0lORklOSVRFX0xPT1AgKDIwMTcwMzAzL3BzcGFyc2UtNjY4KTx1PjwvdT48dT48
L3U+PC9wPg0KPC9kaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+QUNQSSBFcnJvcjog
TWV0aG9kIHBhcnNlL2V4ZWN1dGlvbiBmYWlsZWQgW1xfU0IuUENJMC5MUEMuRUMuSEtFWS5XR0lO
XSAoTm9kZSA4MTQzODEwKSwgQUVfQU1MX0lORklOSVRFX0xPT1AgKDIwMTcwMzAzL3BzcGFyc2Ut
NjY4KTx1PjwvdT48dT48L3U+PC9wPg0KPC9kaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1h
bCI+QUNQSSBFcnJvcjogTWV0aG9kIHBhcnNlL2V4ZWN1dGlvbiBmYWlsZWQgW1xfU0IuUENJMC5M
UEMuRUMuX0lOSV0gKE5vZGUgODEyMWFlMCksIEFFX0FNTF9JTkZJTklURV9MT09QICgyMDE3MDMw
My9wc3BhcnNlLTY2OCk8dT48L3U+PHU+PC91PjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNz
PSJNc29Ob3JtYWwiPkFDUEkgRXhjZXB0aW9uOiBBRV9BTUxfSU5GSU5JVEVfTE9PUCwgZHVyaW5n
IFxfU0IuUENJMC5MUEMuRUMuX0lOSSBleGVjdXRpb24gKDIwMTcwMzAzL25zaW5pdC04MDcpPHU+
PC91Pjx1PjwvdT48L3A+DQo8L2Rpdj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj7CoCDC
oCBFeGVjdXRlZCAxNCBfSU5JIG1ldGhvZHMgcmVxdWlyaW5nIDEgX1NUQSBleGVjdXRpb25zIChl
eGFtaW5lZCAxMTMgb2JqZWN0cyk8dT48L3U+PHU+PC91PjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxw
IGNsYXNzPSJNc29Ob3JtYWwiPi0gZXhlY3V0ZSBcX1NCLlBDSTAuTFBDLkVDLkJBVDAuX0JTVDx1
PjwvdT48dT48L3U+PC9wPg0KPC9kaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+RXZh
bHVhdGluZyBcX1NCLlBDSTAuTFBDLkVDLkJBVDAuX0JTVDx1PjwvdT48dT48L3U+PC9wPg0KPC9k
aXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+MHg0IE91dHN0YW5kaW5nIGFsbG9jYXRp
b25zIGFmdGVyIGV2YWx1YXRpb24gb2YgXF9TQi5QQ0kwLkxQQy5FQy5CQVQwLl9CU1Q8dT48L3U+
PHU+PC91PjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPkV2YWx1YXRp
b24gb2YgXF9TQi5QQ0kwLkxQQy5FQy5CQVQwLl9CU1QgcmV0dXJuZWQgb2JqZWN0IDgwZWFmZjAs
IGV4dGVybmFsIGJ1ZmZlciBsZW5ndGggNzg8dT48L3U+PHU+PC91PjwvcD4NCjwvZGl2Pg0KPGRp
dj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPsKgIFtQYWNrYWdlXSBDb250YWlucyA0IEVsZW1lbnRz
Ojx1PjwvdT48dT48L3U+PC9wPg0KPC9kaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+
wqAgwqAgW0ludGVnZXJdID0gMDAwMDAwMDAwMDAwMDAwNDx1PjwvdT48dT48L3U+PC9wPg0KPC9k
aXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+wqAgwqAgW0ludGVnZXJdID0gMDAwMDAw
MDAwMDAwMDAwMDx1PjwvdT48dT48L3U+PC9wPg0KPC9kaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1z
b05vcm1hbCI+wqAgwqAgW0ludGVnZXJdID0gMDAwMDAwMDAwMDAwMDAwMDx1PjwvdT48dT48L3U+
PC9wPg0KPC9kaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+wqAgwqAgW0ludGVnZXJd
ID0gMDAwMDAwMDAwMDAwMDAwMDx1PjwvdT48dT48L3U+PC9wPg0KPC9kaXY+DQo8ZGl2Pg0KPHAg
Y2xhc3M9Ik1zb05vcm1hbCI+LSBxPHU+PC91Pjx1PjwvdT48L3A+DQo8L2Rpdj4NCjxkaXY+DQo8
cCBjbGFzcz0iTXNvTm9ybWFsIj4tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS08d2JyPi0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLTx3YnI+LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tPHdicj4tLS0tLS08dT48L3U+PHU+PC91PjwvcD4NCjwvZGl2Pg0KPC9kaXY+DQo8ZGl2
Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+PHU+PC91PsKgPHU+PC91PjwvcD4NCjwvZGl2Pg0KPGRp
dj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPk5vdGU6IEkgdHJpZWQgcnVubmluZyBMaW51eCBvbiB0
aGUgTGVub3ZvIGxhcHRvcCBhbmQgaXQgY2FuIHJlYWQgdGhlIGJhdHRlcnkgc3RhdHVzIG9rLjx1
PjwvdT48dT48L3U+PC9wPg0KPC9kaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+PHU+
PC91PsKgPHU+PC91PjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPlRo
YW5rIHlvdSw8dT48L3U+PHU+PC91PjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29O
b3JtYWwiPkRldmluPHU+PC91Pjx1PjwvdT48L3A+DQo8L2Rpdj4NCjxkaXY+DQo8cCBjbGFzcz0i
TXNvTm9ybWFsIj48dT48L3U+wqA8dT48L3U+PC9wPg0KPC9kaXY+DQo8L2Rpdj4NCjwvZGl2Pjwv
ZGl2PjwvZGl2Pg0KPC9kaXY+DQo8L2Rpdj4NCg0KPC9ibG9ja3F1b3RlPjwvZGl2Pjxicj48L2Rp
dj4NCg==

--===============1964825023583994666==--

