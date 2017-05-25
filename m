Content-Type: multipart/mixed; boundary="===============0613607338669573575=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: Re: [Devel] Help needed for "ACPI Error: No handler for Region
 [ECOR]" (using my own OSL)
Date: Thu, 25 May 2017 19:47:12 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37E59B64B@ORSMSX110.amr.corp.intel.com>
In-Reply-To: 94F2FBAB4432B54E8AACC7DFDE6C92E37E59B62B@ORSMSX110.amr.corp.intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============0613607338669573575==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

I just looked into the ACPICA source, and yes, it appears that QNX uses ACP=
ICA:

#ifndef __ACQNX_H__
#define __ACQNX_H__

#define ACPI_USE_STANDARD_HEADERS
#define ACPI_USE_SYSTEM_CLIBRARY

#define ACPI_UINTPTR_T          uintptr_t
#define ACPI_USE_LOCAL_CACHE
#define ACPI_CAST_PTHREAD_T(x)  ((ACPI_THREAD_ID) ACPI_TO_INTEGER (x))

/* At present time (QNX 6.6) all supported architectures are 32 bits. */
#define ACPI_MACHINE_WIDTH      32

Which means that the ACPICA-to-QNX OSL interface layer already exists.

From: Devel [mailto:devel-bounces(a)acpica.org] On Behalf Of Moore, Robert
Sent: Thursday, May 25, 2017 12:41 PM
To: Devin Steffler <devinsteffler(a)gmail.com>
Cc: devel(a)acpica.org
Subject: Re: [Devel] Help needed for "ACPI Error: No handler for Region [EC=
OR]" (using my own OSL)

I can=E2=80=99t speak for QNX, but the EC driver would be part of it. It ha=
s nothing to do with your OSL.

I=E2=80=99m not sure why you have to write your own OSL, this should alread=
y be part of QNX, assuming that it has ACPI support, and uses ACPICA as the=
 underlying ACPI software.

To put this more succinctly:  ACPICA provides the underlying infrastructure=
 for ACPI support in an OS. But, the OS must provide its own ACPI-related d=
rivers and other ACPI support. The EC driver is one of these ACPI-related d=
rivers.

Bob


From: Devin Steffler [mailto:devinsteffler(a)gmail.com]
Sent: Thursday, May 25, 2017 7:48 AM
To: Moore, Robert <robert.moore(a)intel.com<mailto:robert.moore(a)intel.com=
>>
Cc: devel(a)acpica.org<mailto:devel(a)acpica.org>
Subject: Re: [Devel] Help needed for "ACPI Error: No handler for Region [EC=
OR]" (using my own OSL)

Hi Robert,

Thanks for your insight.

How can I find out whether is it a missing EC driver or the EC driver is fa=
iling to install a handler for the EC operation region?

Is the EC driver some C code that I would be expected to write as part of t=
he OSL or is it expected to be included with the OS (QNX in this case)?

I suspect that the problem is somewhere in my OSL (since I'm very new to AC=
PI). Do you think this is likely the case? What should I focus on to debug =
my OSL if this is the case?

Here's an excerpt from the Lenovo's DSDT.dsl (hoping it helps):
---------------------------------------------------------------------------=
--------------------
                Device (EC)
                {
                    Name (_HID, EisaId ("PNP0C09") /* Embedded Controller D=
evice */)  // _HID: Hardware ID
                    Name (_UID, 0x00)  // _UID: Unique ID
                    Name (_GPE, 0x20)  // _GPE: General Purpose Events
                    Method (_REG, 2, NotSerialized)  // _REG: Region Availa=
bility
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


On Thu, May 25, 2017 at 10:15 AM, Moore, Robert <robert.moore(a)intel.com<m=
ailto:robert.moore(a)intel.com>> wrote:
ACPI Error: Region EmbeddedControl (ID=3D3) has no handler (20170303/exfldi=
o-431)

You either don=E2=80=99t have a driver for the EC, or your EC driver has no=
t installed a handler for the EC operation region.

I would guess.




From: Devel [mailto:devel-bounces(a)acpica.org<mailto:devel-bounces(a)acpic=
a.org>] On Behalf Of Devin Steffler
Sent: Thursday, May 25, 2017 6:15 AM
To: devel(a)acpica.org<mailto:devel(a)acpica.org>
Subject: [Devel] Help needed for "ACPI Error: No handler for Region [ECOR]"=
 (using my own OSL)

Hello,

I am working on an OSL for QNX. I am getting some errors printed out during=
 AcpiInitializeObjects but only in one out of three laptops that I am testi=
ng. A Dell and ASUS laptop do not have the errors but a Lenovo laptop does.=
 I am able to read battery status (_BST) on the Dell and ASUS laptops but n=
ot on the Lenovo laptop.

The ACPICA version I am using is 20170303.

Some questions I have are:
- Is this the correct mailing list for this email?
- Does this appear to be a bug in ACPICA, in my OSL, or somewhere else (may=
be the laptop BIOS)?
- Should I raise a bug for this?
- Would you provide any recommendations to help me troubleshoot this?
- What other information should I provide?

This is the output during ACPI initialization on the problematic laptop (fr=
om my OSL):
---------------------------------------------------------------------------=
---------------------
ACPI: RSDP 0x00000000000F0120 000024 (v02 LENOVO)
ACPI: XSDT 0x00000000D7FD2188 0000CC (v01 LENOVO TP-R00   00000000 PTEC 000=
00002)
ACPI: FACP 0x00000000D7FF7000 0000F4 (v05 LENOVO TP-R00   00000420 PTEC 000=
00002)
ACPI: DSDT 0x00000000D7FDE000 011451 (v02 LENOVO TP-R00   00000420 INTL 201=
41107)
ACPI: FACS 0x00000000D7FA2000 000040
ACPI: UEFI 0x00000000D7FB9000 000042 (v01 LENOVO TP-R00   00000420 PTEC 000=
00002)
ACPI: SSDT 0x00000000D7FF8000 004E0A (v02 LENOVO SaSsdt   00003000 INTL 201=
41107)
ACPI: ASF! 0x00000000D7FF6000 0000A5 (v32 LENOVO TP-R00   00000420 PTEC 000=
00002)
ACPI: ECDT 0x00000000D7FF5000 000052 (v01 LENOVO TP-R00   00000420 PTEC 000=
00002)
ACPI: HPET 0x00000000D7FF4000 000038 (v01 LENOVO TP-R00   00000420 PTEC 000=
00002)
ACPI: LPIT 0x00000000D7FF3000 000094 (v01 LENOVO TP-R00   00000420 PTEC 000=
00002)
ACPI: APIC 0x00000000D7FF2000 0000BC (v03 LENOVO TP-R00   00000420 PTEC 000=
00002)
ACPI: MCFG 0x00000000D7FF1000 00003C (v01 LENOVO TP-R00   00000420 PTEC 000=
00002)
ACPI: WDAT 0x00000000D7FF0000 000134 (v01 LENOVO TP-R00   00000420 PTEC 000=
00002)
ACPI: SSDT 0x00000000D7FDC000 001AFC (v01 LENOVO SataAhci 00001000 INTL 201=
41107)
ACPI: DBGP 0x00000000D7FDB000 000034 (v01 LENOVO TP-R00   00000420 PTEC 000=
00002)
ACPI: DBG2 0x00000000D7FDA000 000054 (v00 LENOVO TP-R00   00000420 PTEC 000=
00002)
ACPI: BOOT 0x00000000D7FD9000 000028 (v01 LENOVO TP-R00   00000420 PTEC 000=
00002)
ACPI: BATB 0x00000000D7FD8000 000046 (v01 LENOVO TP-R00   00000420 PTEC 000=
00002)
ACPI: SLIC 0x00000000D7FD7000 000176 (v01 LENOVO TP-R00   00000420 PTEC 000=
00002)
ACPI: SSDT 0x00000000D7FD6000 000E58 (v02 LENOVO CpuSsdt  00003000 INTL 201=
41107)
ACPI: SSDT 0x00000000D7FD5000 0003D9 (v02 LENOVO CtdpB    00001000 INTL 201=
41107)
ACPI: MSDM 0x00000000D7FD4000 000055 (v03 LENOVO TP-R00   00000420 PTEC 000=
00002)
ACPI: FPDT 0x00000000D7FD3000 000044 (v01 LENOVO TP-R00   00000420 PTEC 000=
00002)
ACPI: UEFI 0x00000000D7FA0000 00012A (v01 LENOVO TP-R00   00000420 PTEC 000=
00002)

Initializing Namespace objects:
Table [DSDT: TP-R00  ] (id 01) - 2757 Objects with  76 Devices,  40 Regions=
,  510 Methods (140/370/24 Serial/Non/Cvt)
Table [SSDT: SaSsdt  ] (id 02) -  552 Objects with  18 Devices,  20 Regions=
,  131 Methods (41/90/7 Serial/Non/Cvt)
Table [SSDT: SataAhci] (id 03) -  183 Objects with   8 Devices,   0 Regions=
,   34 Methods (25/9/5 Serial/Non/Cvt)
Table [SSDT: CpuSsdt ] (id 04) -  114 Objects with   0 Devices,   3 Regions=
,   29 Methods (13/16/13 Serial/Non/Cvt)
Table [SSDT: CtdpB   ] (id 05) -   33 Objects with   0 Devices,   1 Regions=
,    5 Methods (2/3/1 Serial/Non/Cvt)
ACPI: 5 ACPI AML tables successfully acquired and loaded
Completing Region/Field/Buffer/Package initialization:
    Initialized 63/64 Regions 71/71 Fields 88/88 Buffers 83/83 Packages (36=
48 nodes)
 evxfevnt-0218 Enable                : Transition to ACPI mode successful
Initializing General Purpose Events (GPEs):
    Initialized GPE 00 to 7F [_GPE] 16 regs on interrupt 0x9 (SCI)
Initializing Device/Processor/Thermal objects and executing _INI/_STA metho=
ds:
ACPI Error: No handler for Region [ECOR] (80da130) [EmbeddedControl] (20170=
303/evregion-291)
ACPI Error: Region EmbeddedControl (ID=3D3) has no handler (20170303/exfldi=
o-431)
ACPI Error: Method parse/execution failed [\_SB.PCI0.LPC.EC.AC._PSR] (Node =
80d0c30), AE_NOT_EXIST (20170303/psparse-668)
ACPI Error: Method parse/execution failed [\_SB._INI] (Node 80e4f50), AE_NO=
T_EXIST (20170303/psparse-668)
ACPI Error: No handler for Region [ECOR] (80da130) [EmbeddedControl] (20170=
303/evregion-291)
ACPI Error: Region EmbeddedControl (ID=3D3) has no handler (20170303/exfldi=
o-431)
ACPI Error: Method parse/execution failed [\_SB.PCI0.LPC.EC._INI] (Node 80d=
00d0), AE_NOT_EXIST (20170303/psparse-668)
ACPI Exception: AE_NOT_EXIST, during \_SB.PCI0.LPC.EC._INI execution (20170=
303/nsinit-807)
    Executed 13 _INI methods requiring 1 _STA executions (examined 113 obje=
cts)
---------------------------------------------------------------------------=
---------------------

This is the output from calling AcpiEvaluateObject for the control method "=
\_SB.PCI0.LPC.EC.BAT0._BST", which returns with AE_NOT_EXIST:
---------------------------------------------------------------------------=
---------------------
ACPI Error: No handler for Region [ECOR] (80da130) [EmbeddedControl] (20170=
303/evregion-291)
ACPI Error: Region EmbeddedControl (ID=3D3) has no handler (20170303/exfldi=
o-431)
ACPI Error: Method parse/execution failed [\_SB.PCI0.LPC.EC.BAT0._BST] (Nod=
e 80d0b70), AE_NOT_EXIST (20170303/psparse-668)
---------------------------------------------------------------------------=
---------------------

This is the output from executing the control method using acpiexec:
---------------------------------------------------------------------------=
---------------------
# ./acpiexec *.dat


Intel ACPI Component Architecture
AML Execution/Debug Utility version 20170303
Copyright (c) 2000 - 2017 Intel Corporation

Input file apic.dat, Length 0xBC (188) bytes
Input file asf!.dat, Length 0xA5 (165) bytes
Input file batb.dat, Length 0x46 (70) bytes
Input file boot.dat, Length 0x28 (40) bytes
Input file dbg2.dat, Length 0x54 (84) bytes
Input file dbgp.dat, Length 0x34 (52) bytes
Input file dsdt.dat, Length 0x11451 (70737) bytes
Input file ecdt.dat, Length 0x52 (82) bytes
Input file facp.dat, Length 0xF4 (244) bytes
Input file facs.dat, Length 0x40 (64) bytes
Input file fpdt.dat, Length 0x44 (68) bytes
Input file hpet.dat, Length 0x38 (56) bytes
Input file lpit.dat, Length 0x94 (148) bytes
Input file mcfg.dat, Length 0x3C (60) bytes
Input file msdm.dat, Length 0x55 (85) bytes
Input file slic.dat, Length 0x176 (374) bytes
Input file ssdt1.dat, Length 0x4E0A (19978) bytes
Input file ssdt2.dat, Length 0x1AFC (6908) bytes
Input file ssdt3.dat, Length 0xE58 (3672) bytes
Input file ssdt4.dat, Length 0x3D9 (985) bytes
Input file uefi1.dat, Length 0x42 (66) bytes
Input file uefi2.dat, Length 0x12A (298) bytes
Input file wdat.dat, Length 0x134 (308) bytes
Input file xsdt.dat, Length 0xCC (204) bytes

ACPI: RSDP 0x00000000080DBCE0 000024 (v02 Intel )
ACPI: XSDT 0x00000000080E78C8 0000E4 (v00 Intel  AcpiExec 00001001 INTL 201=
70303)
ACPI: FACP 0x00000000080EA550 0000F4 (v05 LENOVO TP-R00   00000420 PTEC 000=
00002)
ACPI: DSDT 0x00000000080EF020 011451 (v02 LENOVO TP-R00   00000420 INTL 201=
41107)
ACPI: FACS 0x00000000080DBD20 000040
ACPI: APIC 0x00000000080EA708 0000BC (v03 LENOVO TP-R00   00000420 PTEC 000=
00002)
ACPI: ASF! 0x00000000080EA650 0000A5 (v32 LENOVO TP-R00   00000420 PTEC 000=
00002)
ACPI: BATB 0x00000000080E30A8 000046 (v01 LENOVO TP-R00   00000420 PTEC 000=
00002)
ACPI: BOOT 0x00000000080E01D8 000028 (v01 LENOVO TP-R00   00000420 PTEC 000=
00002)
ACPI: DBG2 0x00000000080E21F0 000054 (v00 LENOVO TP-R00   00000420 PTEC 000=
00002)
ACPI: DBGP 0x00000000080E12D8 000034 (v01 LENOVO TP-R00   00000420 PTEC 000=
00002)
ACPI: ECDT 0x00000000080E2258 000052 (v01 LENOVO TP-R00   00000420 PTEC 000=
00002)
ACPI: FACS 0x00000000080E1320 000040
ACPI: FPDT 0x00000000080E3100 000044 (v01 LENOVO TP-R00   00000420 PTEC 000=
00002)
ACPI: HPET 0x00000000080E1368 000038 (v01 LENOVO TP-R00   00000420 PTEC 000=
00002)
ACPI: LPIT 0x00000000080EA4B0 000094 (v01 LENOVO TP-R00   00000420 PTEC 000=
00002)
ACPI: MCFG 0x00000000080E13B0 00003C (v01 LENOVO TP-R00   00000420 PTEC 000=
00002)
ACPI: MSDM 0x00000000080E22C0 000055 (v03 LENOVO TP-R00   00000420 PTEC 000=
00002)
ACPI: SLIC 0x00000000080EA328 000176 (v01 LENOVO TP-R00   00000420 PTEC 000=
00002)
ACPI: SSDT 0x0000000008101020 004E0A (v02 LENOVO SaSsdt   00003000 INTL 201=
41107)
ACPI: SSDT 0x00000000080E8820 001AFC (v01 LENOVO SataAhci 00001000 INTL 201=
41107)
ACPI: SSDT 0x00000000080E79B8 000E58 (v02 LENOVO CpuSsdt  00003000 INTL 201=
41107)
ACPI: SSDT 0x00000000080EA7D0 0003D9 (v02 LENOVO CtdpB    00001000 INTL 201=
41107)
ACPI: UEFI 0x00000000080E3158 000042 (v01 LENOVO TP-R00   00000420 PTEC 000=
00002)
ACPI: UEFI 0x00000000080E7470 00012A (v01 LENOVO TP-R00   00000420 PTEC 000=
00002)
ACPI: WDAT 0x00000000080E7330 000134 (v01 LENOVO TP-R00   00000420 PTEC 000=
00002)
ACPI: XSDT 0x00000000080E7230 0000CC (v01 LENOVO TP-R00   00000000 PTEC 000=
00002)
Initializing General Purpose Events (GPEs):
    Initialized GPE 00 to 7F [_GPE] 16 regs on interrupt 0x9 (SCI)

Initializing Namespace objects:
Table [DSDT: TP-R00  ] (id 01) - 2757 Objects with  76 Devices,  40 Regions=
,  510 Methods (140/370/24 Serial/Non/Cvt)
Table [SSDT: SaSsdt  ] (id 02) -  552 Objects with  18 Devices,  20 Regions=
,  131 Methods (41/90/7 Serial/Non/Cvt)
Table [SSDT: SataAhci] (id 03) -  183 Objects with   8 Devices,   0 Regions=
,   34 Methods (25/9/5 Serial/Non/Cvt)
Table [SSDT: CpuSsdt ] (id 04) -  114 Objects with   0 Devices,   3 Regions=
,   29 Methods (13/16/13 Serial/Non/Cvt)
Table [SSDT: CtdpB   ] (id 05) -   33 Objects with   0 Devices,   1 Regions=
,    5 Methods (2/3/1 Serial/Non/Cvt)
ACPI: 5 ACPI AML tables successfully acquired and loaded

Completing Region/Field/Buffer/Package initialization:
    Initialized 63/64 Regions 71/71 Fields 88/88 Buffers 83/83 Packages (36=
48 nodes)
Initializing Device/Processor/Thermal objects and executing _INI/_STA metho=
ds:
[AcpiExec] Exception AE_AML_INFINITE_LOOP during execution of method [SMI_]=
 Opcode [While] @44
[SMI_] @00034 #00A2:  While (
No Local Variables are initialized for method [SMI_]

Initialized Arguments for Method [SMI_]:  (0 arguments defined for method i=
nvocation)
    Arg0:   81ecc40 <Obj>             Integer 0000000000000009
    Arg1:   81eca38 <Obj>             Integer 0000000000000001
    Arg2:   81ecbd8 <Obj>             Integer 0000000000000000
    Arg3:   81ec9d0 <Obj>             Integer 0000000000000000
    Arg4:   81ecb08 <Obj>             Integer 0000000000000000

ACPI Error: Method parse/execution failed [\SMI] (Node 814de40), AE_AML_INF=
INITE_LOOP (20170303/psparse-668)
ACPI Error: Method parse/execution failed [\WGSV] (Node 814e978), AE_AML_IN=
FINITE_LOOP (20170303/psparse-668)
ACPI Error: Method parse/execution failed [\_SB.PCI0.LPC.EC.HKEY.WGIN] (Nod=
e 8143810), AE_AML_INFINITE_LOOP (20170303/psparse-668)
ACPI Error: Method parse/execution failed [\_SB.PCI0.LPC.EC._INI] (Node 812=
1ae0), AE_AML_INFINITE_LOOP (20170303/psparse-668)
ACPI Exception: AE_AML_INFINITE_LOOP, during \_SB.PCI0.LPC.EC._INI executio=
n (20170303/nsinit-807)
    Executed 14 _INI methods requiring 1 _STA executions (examined 113 obje=
cts)
- execute \_SB.PCI0.LPC.EC.BAT0._BST
Evaluating \_SB.PCI0.LPC.EC.BAT0._BST
0x4 Outstanding allocations after evaluation of \_SB.PCI0.LPC.EC.BAT0._BST
Evaluation of \_SB.PCI0.LPC.EC.BAT0._BST returned object 80eaff0, external =
buffer length 78
  [Package] Contains 4 Elements:
    [Integer] =3D 0000000000000004
    [Integer] =3D 0000000000000000
    [Integer] =3D 0000000000000000
    [Integer] =3D 0000000000000000
- q
---------------------------------------------------------------------------=
---------------------

Note: I tried running Linux on the Lenovo laptop and it can read the batter=
y status ok.

Thank you,
Devin



--===============0613607338669573575==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGh0bWwgeG1sbnM6dj0idXJuOnNjaGVtYXMtbWljcm9zb2Z0LWNvbTp2bWwiIHhtbG5zOm89InVy
bjpzY2hlbWFzLW1pY3Jvc29mdC1jb206b2ZmaWNlOm9mZmljZSIgeG1sbnM6dz0idXJuOnNjaGVt
YXMtbWljcm9zb2Z0LWNvbTpvZmZpY2U6d29yZCIgeG1sbnM6bT0iaHR0cDovL3NjaGVtYXMubWlj
cm9zb2Z0LmNvbS9vZmZpY2UvMjAwNC8xMi9vbW1sIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcv
VFIvUkVDLWh0bWw0MCI+DQo8aGVhZD4NCjxtZXRhIGh0dHAtZXF1aXY9IkNvbnRlbnQtVHlwZSIg
Y29udGVudD0idGV4dC9odG1sOyBjaGFyc2V0PXV0Zi04Ij4NCjxtZXRhIG5hbWU9IkdlbmVyYXRv
ciIgY29udGVudD0iTWljcm9zb2Z0IFdvcmQgMTUgKGZpbHRlcmVkIG1lZGl1bSkiPg0KPHN0eWxl
PjwhLS0NCi8qIEZvbnQgRGVmaW5pdGlvbnMgKi8NCkBmb250LWZhY2UNCgl7Zm9udC1mYW1pbHk6
Q2FsaWJyaTsNCglwYW5vc2UtMToyIDE1IDUgMiAyIDIgNCAzIDIgNDt9DQovKiBTdHlsZSBEZWZp
bml0aW9ucyAqLw0KcC5Nc29Ob3JtYWwsIGxpLk1zb05vcm1hbCwgZGl2Lk1zb05vcm1hbA0KCXtt
YXJnaW46MGluOw0KCW1hcmdpbi1ib3R0b206LjAwMDFwdDsNCglmb250LXNpemU6MTIuMHB0Ow0K
CWZvbnQtZmFtaWx5OiJUaW1lcyBOZXcgUm9tYW4iLHNlcmlmO30NCmE6bGluaywgc3Bhbi5Nc29I
eXBlcmxpbmsNCgl7bXNvLXN0eWxlLXByaW9yaXR5Ojk5Ow0KCWNvbG9yOmJsdWU7DQoJdGV4dC1k
ZWNvcmF0aW9uOnVuZGVybGluZTt9DQphOnZpc2l0ZWQsIHNwYW4uTXNvSHlwZXJsaW5rRm9sbG93
ZWQNCgl7bXNvLXN0eWxlLXByaW9yaXR5Ojk5Ow0KCWNvbG9yOnB1cnBsZTsNCgl0ZXh0LWRlY29y
YXRpb246dW5kZXJsaW5lO30NCnNwYW4uRW1haWxTdHlsZTE3DQoJe21zby1zdHlsZS10eXBlOnBl
cnNvbmFsOw0KCWZvbnQtZmFtaWx5OiJDYWxpYnJpIixzYW5zLXNlcmlmOw0KCWNvbG9yOiMxRjQ5
N0Q7fQ0Kc3Bhbi5FbWFpbFN0eWxlMTgNCgl7bXNvLXN0eWxlLXR5cGU6cGVyc29uYWwtcmVwbHk7
DQoJZm9udC1mYW1pbHk6IkNhbGlicmkiLHNhbnMtc2VyaWY7DQoJY29sb3I6IzFGNDk3RDt9DQou
TXNvQ2hwRGVmYXVsdA0KCXttc28tc3R5bGUtdHlwZTpleHBvcnQtb25seTsNCglmb250LXNpemU6
MTAuMHB0O30NCkBwYWdlIFdvcmRTZWN0aW9uMQ0KCXtzaXplOjguNWluIDExLjBpbjsNCgltYXJn
aW46MS4waW4gMS4waW4gMS4waW4gMS4waW47fQ0KZGl2LldvcmRTZWN0aW9uMQ0KCXtwYWdlOldv
cmRTZWN0aW9uMTt9DQotLT48L3N0eWxlPjwhLS1baWYgZ3RlIG1zbyA5XT48eG1sPg0KPG86c2hh
cGVkZWZhdWx0cyB2OmV4dD0iZWRpdCIgc3BpZG1heD0iMTAyNiIgLz4NCjwveG1sPjwhW2VuZGlm
XS0tPjwhLS1baWYgZ3RlIG1zbyA5XT48eG1sPg0KPG86c2hhcGVsYXlvdXQgdjpleHQ9ImVkaXQi
Pg0KPG86aWRtYXAgdjpleHQ9ImVkaXQiIGRhdGE9IjEiIC8+DQo8L286c2hhcGVsYXlvdXQ+PC94
bWw+PCFbZW5kaWZdLS0+DQo8L2hlYWQ+DQo8Ym9keSBsYW5nPSJFTi1VUyIgbGluaz0iYmx1ZSIg
dmxpbms9InB1cnBsZSI+DQo8ZGl2IGNsYXNzPSJXb3JkU2VjdGlvbjEiPg0KPHAgY2xhc3M9Ik1z
b05vcm1hbCI+PHNwYW4gc3R5bGU9ImZvbnQtc2l6ZToxMS4wcHQ7Zm9udC1mYW1pbHk6JnF1b3Q7
Q2FsaWJyaSZxdW90OyxzYW5zLXNlcmlmO2NvbG9yOiMxRjQ5N0QiPkkganVzdCBsb29rZWQgaW50
byB0aGUgQUNQSUNBIHNvdXJjZSwgYW5kIHllcywgaXQgYXBwZWFycyB0aGF0IFFOWCB1c2VzIEFD
UElDQTo8bzpwPjwvbzpwPjwvc3Bhbj48L3A+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj48c3BhbiBz
dHlsZT0iZm9udC1zaXplOjExLjBwdDtmb250LWZhbWlseTomcXVvdDtDYWxpYnJpJnF1b3Q7LHNh
bnMtc2VyaWY7Y29sb3I6IzFGNDk3RCI+PG86cD4mbmJzcDs8L286cD48L3NwYW4+PC9wPg0KPHAg
Y2xhc3M9Ik1zb05vcm1hbCIgc3R5bGU9InRleHQtYXV0b3NwYWNlOm5vbmUiPjxzcGFuIHN0eWxl
PSJmb250LXNpemU6MTAuMHB0O2ZvbnQtZmFtaWx5OiZxdW90O0NvdXJpZXIgTmV3JnF1b3Q7O2Nv
bG9yOmJsdWUiPiNpZm5kZWY8L3NwYW4+PHNwYW4gc3R5bGU9ImZvbnQtc2l6ZToxMC4wcHQ7Zm9u
dC1mYW1pbHk6JnF1b3Q7Q291cmllciBOZXcmcXVvdDsiPiBfX0FDUU5YX0hfXzxvOnA+PC9vOnA+
PC9zcGFuPjwvcD4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiIHN0eWxlPSJ0ZXh0LWF1dG9zcGFjZTpu
b25lIj48c3BhbiBzdHlsZT0iZm9udC1zaXplOjEwLjBwdDtmb250LWZhbWlseTomcXVvdDtDb3Vy
aWVyIE5ldyZxdW90Oztjb2xvcjpibHVlIj4jZGVmaW5lPC9zcGFuPjxzcGFuIHN0eWxlPSJmb250
LXNpemU6MTAuMHB0O2ZvbnQtZmFtaWx5OiZxdW90O0NvdXJpZXIgTmV3JnF1b3Q7Ij4gX19BQ1FO
WF9IX188bzpwPjwvbzpwPjwvc3Bhbj48L3A+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIiBzdHlsZT0i
dGV4dC1hdXRvc3BhY2U6bm9uZSI+PHNwYW4gc3R5bGU9ImZvbnQtc2l6ZToxMC4wcHQ7Zm9udC1m
YW1pbHk6JnF1b3Q7Q291cmllciBOZXcmcXVvdDsiPjxvOnA+Jm5ic3A7PC9vOnA+PC9zcGFuPjwv
cD4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiIHN0eWxlPSJ0ZXh0LWF1dG9zcGFjZTpub25lIj48c3Bh
biBzdHlsZT0iZm9udC1zaXplOjEwLjBwdDtmb250LWZhbWlseTomcXVvdDtDb3VyaWVyIE5ldyZx
dW90Oztjb2xvcjpibHVlIj4jZGVmaW5lPC9zcGFuPjxzcGFuIHN0eWxlPSJmb250LXNpemU6MTAu
MHB0O2ZvbnQtZmFtaWx5OiZxdW90O0NvdXJpZXIgTmV3JnF1b3Q7Ij4gQUNQSV9VU0VfU1RBTkRB
UkRfSEVBREVSUzxvOnA+PC9vOnA+PC9zcGFuPjwvcD4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiIHN0
eWxlPSJ0ZXh0LWF1dG9zcGFjZTpub25lIj48c3BhbiBzdHlsZT0iZm9udC1zaXplOjEwLjBwdDtm
b250LWZhbWlseTomcXVvdDtDb3VyaWVyIE5ldyZxdW90Oztjb2xvcjpibHVlIj4jZGVmaW5lPC9z
cGFuPjxzcGFuIHN0eWxlPSJmb250LXNpemU6MTAuMHB0O2ZvbnQtZmFtaWx5OiZxdW90O0NvdXJp
ZXIgTmV3JnF1b3Q7Ij4gQUNQSV9VU0VfU1lTVEVNX0NMSUJSQVJZPG86cD48L286cD48L3NwYW4+
PC9wPg0KPHAgY2xhc3M9Ik1zb05vcm1hbCIgc3R5bGU9InRleHQtYXV0b3NwYWNlOm5vbmUiPjxz
cGFuIHN0eWxlPSJmb250LXNpemU6MTAuMHB0O2ZvbnQtZmFtaWx5OiZxdW90O0NvdXJpZXIgTmV3
JnF1b3Q7Ij48bzpwPiZuYnNwOzwvbzpwPjwvc3Bhbj48L3A+DQo8cCBjbGFzcz0iTXNvTm9ybWFs
IiBzdHlsZT0idGV4dC1hdXRvc3BhY2U6bm9uZSI+PHNwYW4gc3R5bGU9ImZvbnQtc2l6ZToxMC4w
cHQ7Zm9udC1mYW1pbHk6JnF1b3Q7Q291cmllciBOZXcmcXVvdDs7Y29sb3I6Ymx1ZSI+I2RlZmlu
ZTwvc3Bhbj48c3BhbiBzdHlsZT0iZm9udC1zaXplOjEwLjBwdDtmb250LWZhbWlseTomcXVvdDtD
b3VyaWVyIE5ldyZxdW90OyI+IEFDUElfVUlOVFBUUl9UJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IHVpbnRwdHJfdDxvOnA+PC9vOnA+PC9zcGFu
PjwvcD4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiIHN0eWxlPSJ0ZXh0LWF1dG9zcGFjZTpub25lIj48
c3BhbiBzdHlsZT0iZm9udC1zaXplOjEwLjBwdDtmb250LWZhbWlseTomcXVvdDtDb3VyaWVyIE5l
dyZxdW90Oztjb2xvcjpibHVlIj4jZGVmaW5lPC9zcGFuPjxzcGFuIHN0eWxlPSJmb250LXNpemU6
MTAuMHB0O2ZvbnQtZmFtaWx5OiZxdW90O0NvdXJpZXIgTmV3JnF1b3Q7Ij4gQUNQSV9VU0VfTE9D
QUxfQ0FDSEU8bzpwPjwvbzpwPjwvc3Bhbj48L3A+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIiBzdHls
ZT0idGV4dC1hdXRvc3BhY2U6bm9uZSI+PHNwYW4gc3R5bGU9ImZvbnQtc2l6ZToxMC4wcHQ7Zm9u
dC1mYW1pbHk6JnF1b3Q7Q291cmllciBOZXcmcXVvdDs7Y29sb3I6Ymx1ZSI+I2RlZmluZTwvc3Bh
bj48c3BhbiBzdHlsZT0iZm9udC1zaXplOjEwLjBwdDtmb250LWZhbWlseTomcXVvdDtDb3VyaWVy
IE5ldyZxdW90OyI+IEFDUElfQ0FTVF9QVEhSRUFEX1QoeCkmbmJzcDsgKChBQ1BJX1RIUkVBRF9J
RCkgQUNQSV9UT19JTlRFR0VSICh4KSk8bzpwPjwvbzpwPjwvc3Bhbj48L3A+DQo8cCBjbGFzcz0i
TXNvTm9ybWFsIiBzdHlsZT0idGV4dC1hdXRvc3BhY2U6bm9uZSI+PHNwYW4gc3R5bGU9ImZvbnQt
c2l6ZToxMC4wcHQ7Zm9udC1mYW1pbHk6JnF1b3Q7Q291cmllciBOZXcmcXVvdDsiPjxvOnA+Jm5i
c3A7PC9vOnA+PC9zcGFuPjwvcD4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiIHN0eWxlPSJ0ZXh0LWF1
dG9zcGFjZTpub25lIj48c3BhbiBzdHlsZT0iZm9udC1zaXplOjEwLjBwdDtmb250LWZhbWlseTom
cXVvdDtDb3VyaWVyIE5ldyZxdW90Oztjb2xvcjpncmVlbiI+LyogQXQgcHJlc2VudCB0aW1lIChR
TlggNi42KSBhbGwgc3VwcG9ydGVkIGFyY2hpdGVjdHVyZXMgYXJlIDMyIGJpdHMuICovPG86cD48
L286cD48L3NwYW4+PC9wPg0KPHAgY2xhc3M9Ik1zb05vcm1hbCIgc3R5bGU9InRleHQtYXV0b3Nw
YWNlOm5vbmUiPjxzcGFuIHN0eWxlPSJmb250LXNpemU6MTAuMHB0O2ZvbnQtZmFtaWx5OiZxdW90
O0NvdXJpZXIgTmV3JnF1b3Q7O2NvbG9yOmJsdWUiPiNkZWZpbmU8L3NwYW4+PHNwYW4gc3R5bGU9
ImZvbnQtc2l6ZToxMC4wcHQ7Zm9udC1mYW1pbHk6JnF1b3Q7Q291cmllciBOZXcmcXVvdDsiPiBB
Q1BJX01BQ0hJTkVfV0lEVEgmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgMzI8bzpwPjwv
bzpwPjwvc3Bhbj48L3A+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj48c3BhbiBzdHlsZT0iZm9udC1z
aXplOjExLjBwdDtmb250LWZhbWlseTomcXVvdDtDYWxpYnJpJnF1b3Q7LHNhbnMtc2VyaWY7Y29s
b3I6IzFGNDk3RCI+PG86cD4mbmJzcDs8L286cD48L3NwYW4+PC9wPg0KPHAgY2xhc3M9Ik1zb05v
cm1hbCI+PHNwYW4gc3R5bGU9ImZvbnQtc2l6ZToxMS4wcHQ7Zm9udC1mYW1pbHk6JnF1b3Q7Q2Fs
aWJyaSZxdW90OyxzYW5zLXNlcmlmO2NvbG9yOiMxRjQ5N0QiPldoaWNoIG1lYW5zIHRoYXQgdGhl
IEFDUElDQS10by1RTlggT1NMIGludGVyZmFjZSBsYXllciBhbHJlYWR5IGV4aXN0cy48bzpwPjwv
bzpwPjwvc3Bhbj48L3A+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj48c3BhbiBzdHlsZT0iZm9udC1z
aXplOjExLjBwdDtmb250LWZhbWlseTomcXVvdDtDYWxpYnJpJnF1b3Q7LHNhbnMtc2VyaWY7Y29s
b3I6IzFGNDk3RCI+PG86cD4mbmJzcDs8L286cD48L3NwYW4+PC9wPg0KPGRpdiBzdHlsZT0iYm9y
ZGVyOm5vbmU7Ym9yZGVyLWxlZnQ6c29saWQgYmx1ZSAxLjVwdDtwYWRkaW5nOjBpbiAwaW4gMGlu
IDQuMHB0Ij4NCjxkaXY+DQo8ZGl2IHN0eWxlPSJib3JkZXI6bm9uZTtib3JkZXItdG9wOnNvbGlk
ICNFMUUxRTEgMS4wcHQ7cGFkZGluZzozLjBwdCAwaW4gMGluIDBpbiI+DQo8cCBjbGFzcz0iTXNv
Tm9ybWFsIj48Yj48c3BhbiBzdHlsZT0iZm9udC1zaXplOjExLjBwdDtmb250LWZhbWlseTomcXVv
dDtDYWxpYnJpJnF1b3Q7LHNhbnMtc2VyaWYiPkZyb206PC9zcGFuPjwvYj48c3BhbiBzdHlsZT0i
Zm9udC1zaXplOjExLjBwdDtmb250LWZhbWlseTomcXVvdDtDYWxpYnJpJnF1b3Q7LHNhbnMtc2Vy
aWYiPiBEZXZlbCBbbWFpbHRvOmRldmVsLWJvdW5jZXNAYWNwaWNhLm9yZ10NCjxiPk9uIEJlaGFs
ZiBPZiA8L2I+TW9vcmUsIFJvYmVydDxicj4NCjxiPlNlbnQ6PC9iPiBUaHVyc2RheSwgTWF5IDI1
LCAyMDE3IDEyOjQxIFBNPGJyPg0KPGI+VG86PC9iPiBEZXZpbiBTdGVmZmxlciAmbHQ7ZGV2aW5z
dGVmZmxlckBnbWFpbC5jb20mZ3Q7PGJyPg0KPGI+Q2M6PC9iPiBkZXZlbEBhY3BpY2Eub3JnPGJy
Pg0KPGI+U3ViamVjdDo8L2I+IFJlOiBbRGV2ZWxdIEhlbHAgbmVlZGVkIGZvciAmcXVvdDtBQ1BJ
IEVycm9yOiBObyBoYW5kbGVyIGZvciBSZWdpb24gW0VDT1JdJnF1b3Q7ICh1c2luZyBteSBvd24g
T1NMKTxvOnA+PC9vOnA+PC9zcGFuPjwvcD4NCjwvZGl2Pg0KPC9kaXY+DQo8cCBjbGFzcz0iTXNv
Tm9ybWFsIj48bzpwPiZuYnNwOzwvbzpwPjwvcD4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPjxzcGFu
IHN0eWxlPSJmb250LXNpemU6MTEuMHB0O2ZvbnQtZmFtaWx5OiZxdW90O0NhbGlicmkmcXVvdDss
c2Fucy1zZXJpZjtjb2xvcjojMUY0OTdEIj5JIGNhbuKAmXQgc3BlYWsgZm9yIFFOWCwgYnV0IHRo
ZSBFQyBkcml2ZXIgd291bGQgYmUgcGFydCBvZiBpdC4gSXQgaGFzIG5vdGhpbmcgdG8gZG8gd2l0
aCB5b3VyIE9TTC48bzpwPjwvbzpwPjwvc3Bhbj48L3A+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj48
c3BhbiBzdHlsZT0iZm9udC1zaXplOjExLjBwdDtmb250LWZhbWlseTomcXVvdDtDYWxpYnJpJnF1
b3Q7LHNhbnMtc2VyaWY7Y29sb3I6IzFGNDk3RCI+PG86cD4mbmJzcDs8L286cD48L3NwYW4+PC9w
Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+PHNwYW4gc3R5bGU9ImZvbnQtc2l6ZToxMS4wcHQ7Zm9u
dC1mYW1pbHk6JnF1b3Q7Q2FsaWJyaSZxdW90OyxzYW5zLXNlcmlmO2NvbG9yOiMxRjQ5N0QiPkni
gJltIG5vdCBzdXJlIHdoeSB5b3UgaGF2ZSB0byB3cml0ZSB5b3VyIG93biBPU0wsIHRoaXMgc2hv
dWxkIGFscmVhZHkgYmUgcGFydCBvZiBRTlgsIGFzc3VtaW5nIHRoYXQgaXQgaGFzIEFDUEkgc3Vw
cG9ydCwgYW5kIHVzZXMgQUNQSUNBIGFzIHRoZSB1bmRlcmx5aW5nIEFDUEkNCiBzb2Z0d2FyZS48
bzpwPjwvbzpwPjwvc3Bhbj48L3A+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj48c3BhbiBzdHlsZT0i
Zm9udC1zaXplOjExLjBwdDtmb250LWZhbWlseTomcXVvdDtDYWxpYnJpJnF1b3Q7LHNhbnMtc2Vy
aWY7Y29sb3I6IzFGNDk3RCI+PG86cD4mbmJzcDs8L286cD48L3NwYW4+PC9wPg0KPHAgY2xhc3M9
Ik1zb05vcm1hbCI+PHNwYW4gc3R5bGU9ImZvbnQtc2l6ZToxMS4wcHQ7Zm9udC1mYW1pbHk6JnF1
b3Q7Q2FsaWJyaSZxdW90OyxzYW5zLXNlcmlmO2NvbG9yOiMxRjQ5N0QiPlRvIHB1dCB0aGlzIG1v
cmUgc3VjY2luY3RseTombmJzcDsgQUNQSUNBIHByb3ZpZGVzIHRoZSB1bmRlcmx5aW5nIGluZnJh
c3RydWN0dXJlIGZvciBBQ1BJIHN1cHBvcnQgaW4gYW4gT1MuIEJ1dCwgdGhlIE9TIG11c3QgcHJv
dmlkZSBpdHMgb3duIEFDUEktcmVsYXRlZCBkcml2ZXJzIGFuZA0KIG90aGVyIEFDUEkgc3VwcG9y
dC4gVGhlIEVDIGRyaXZlciBpcyBvbmUgb2YgdGhlc2UgQUNQSS1yZWxhdGVkIGRyaXZlcnMuPG86
cD48L286cD48L3NwYW4+PC9wPg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+PHNwYW4gc3R5bGU9ImZv
bnQtc2l6ZToxMS4wcHQ7Zm9udC1mYW1pbHk6JnF1b3Q7Q2FsaWJyaSZxdW90OyxzYW5zLXNlcmlm
O2NvbG9yOiMxRjQ5N0QiPjxvOnA+Jm5ic3A7PC9vOnA+PC9zcGFuPjwvcD4NCjxwIGNsYXNzPSJN
c29Ob3JtYWwiPjxzcGFuIHN0eWxlPSJmb250LXNpemU6MTEuMHB0O2ZvbnQtZmFtaWx5OiZxdW90
O0NhbGlicmkmcXVvdDssc2Fucy1zZXJpZjtjb2xvcjojMUY0OTdEIj5Cb2I8bzpwPjwvbzpwPjwv
c3Bhbj48L3A+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj48c3BhbiBzdHlsZT0iZm9udC1zaXplOjEx
LjBwdDtmb250LWZhbWlseTomcXVvdDtDYWxpYnJpJnF1b3Q7LHNhbnMtc2VyaWY7Y29sb3I6IzFG
NDk3RCI+PG86cD4mbmJzcDs8L286cD48L3NwYW4+PC9wPg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+
PHNwYW4gc3R5bGU9ImZvbnQtc2l6ZToxMS4wcHQ7Zm9udC1mYW1pbHk6JnF1b3Q7Q2FsaWJyaSZx
dW90OyxzYW5zLXNlcmlmO2NvbG9yOiMxRjQ5N0QiPjxvOnA+Jm5ic3A7PC9vOnA+PC9zcGFuPjwv
cD4NCjxkaXYgc3R5bGU9ImJvcmRlcjpub25lO2JvcmRlci1sZWZ0OnNvbGlkIGJsdWUgMS41cHQ7
cGFkZGluZzowaW4gMGluIDBpbiA0LjBwdCI+DQo8ZGl2Pg0KPGRpdiBzdHlsZT0iYm9yZGVyOm5v
bmU7Ym9yZGVyLXRvcDpzb2xpZCAjRTFFMUUxIDEuMHB0O3BhZGRpbmc6My4wcHQgMGluIDBpbiAw
aW4iPg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+PGI+PHNwYW4gc3R5bGU9ImZvbnQtc2l6ZToxMS4w
cHQ7Zm9udC1mYW1pbHk6JnF1b3Q7Q2FsaWJyaSZxdW90OyxzYW5zLXNlcmlmIj5Gcm9tOjwvc3Bh
bj48L2I+PHNwYW4gc3R5bGU9ImZvbnQtc2l6ZToxMS4wcHQ7Zm9udC1mYW1pbHk6JnF1b3Q7Q2Fs
aWJyaSZxdW90OyxzYW5zLXNlcmlmIj4gRGV2aW4gU3RlZmZsZXIgWzxhIGhyZWY9Im1haWx0bzpk
ZXZpbnN0ZWZmbGVyQGdtYWlsLmNvbSI+bWFpbHRvOmRldmluc3RlZmZsZXJAZ21haWwuY29tPC9h
Pl0NCjxicj4NCjxiPlNlbnQ6PC9iPiBUaHVyc2RheSwgTWF5IDI1LCAyMDE3IDc6NDggQU08YnI+
DQo8Yj5Ubzo8L2I+IE1vb3JlLCBSb2JlcnQgJmx0OzxhIGhyZWY9Im1haWx0bzpyb2JlcnQubW9v
cmVAaW50ZWwuY29tIj5yb2JlcnQubW9vcmVAaW50ZWwuY29tPC9hPiZndDs8YnI+DQo8Yj5DYzo8
L2I+IDxhIGhyZWY9Im1haWx0bzpkZXZlbEBhY3BpY2Eub3JnIj5kZXZlbEBhY3BpY2Eub3JnPC9h
Pjxicj4NCjxiPlN1YmplY3Q6PC9iPiBSZTogW0RldmVsXSBIZWxwIG5lZWRlZCBmb3IgJnF1b3Q7
QUNQSSBFcnJvcjogTm8gaGFuZGxlciBmb3IgUmVnaW9uIFtFQ09SXSZxdW90OyAodXNpbmcgbXkg
b3duIE9TTCk8bzpwPjwvbzpwPjwvc3Bhbj48L3A+DQo8L2Rpdj4NCjwvZGl2Pg0KPHAgY2xhc3M9
Ik1zb05vcm1hbCI+PG86cD4mbmJzcDs8L286cD48L3A+DQo8ZGl2Pg0KPGRpdj4NCjxwIGNsYXNz
PSJNc29Ob3JtYWwiPkhpIFJvYmVydCw8bzpwPjwvbzpwPjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxw
IGNsYXNzPSJNc29Ob3JtYWwiPjxvOnA+Jm5ic3A7PC9vOnA+PC9wPg0KPC9kaXY+DQo8ZGl2Pg0K
PHAgY2xhc3M9Ik1zb05vcm1hbCI+VGhhbmtzIGZvciB5b3VyIGluc2lnaHQuPG86cD48L286cD48
L3A+DQo8L2Rpdj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj48bzpwPiZuYnNwOzwvbzpw
PjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPkhvdyBjYW4gSSBmaW5k
IG91dCB3aGV0aGVyIGlzIGl0IGEgbWlzc2luZyBFQyBkcml2ZXIgb3IgdGhlIEVDIGRyaXZlciBp
cyZuYnNwO2ZhaWxpbmcgdG8gaW5zdGFsbCBhIGhhbmRsZXIgZm9yIHRoZSBFQyBvcGVyYXRpb24g
cmVnaW9uPzxvOnA+PC9vOnA+PC9wPg0KPC9kaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1h
bCI+PG86cD4mbmJzcDs8L286cD48L3A+DQo8L2Rpdj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9y
bWFsIj5JcyB0aGUgRUMgZHJpdmVyIHNvbWUgQyBjb2RlIHRoYXQgSSB3b3VsZCBiZSBleHBlY3Rl
ZCB0byB3cml0ZSBhcyBwYXJ0IG9mIHRoZSBPU0wgb3IgaXMgaXQgZXhwZWN0ZWQgdG8gYmUgaW5j
bHVkZWQgd2l0aCB0aGUgT1MgKFFOWCBpbiB0aGlzIGNhc2UpPzxvOnA+PC9vOnA+PC9wPg0KPC9k
aXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+PG86cD4mbmJzcDs8L286cD48L3A+DQo8
L2Rpdj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj5JIHN1c3BlY3QgdGhhdCB0aGUgcHJv
YmxlbSBpcyBzb21ld2hlcmUgaW4mbmJzcDtteSBPU0wgKHNpbmNlIEknbSB2ZXJ5IG5ldyB0byBB
Q1BJKS4gRG8geW91IHRoaW5rIHRoaXMgaXMgbGlrZWx5IHRoZSBjYXNlPyBXaGF0IHNob3VsZCBJ
IGZvY3VzIG9uIHRvIGRlYnVnIG15IE9TTCBpZiB0aGlzIGlzIHRoZSBjYXNlPzxvOnA+PC9vOnA+
PC9wPg0KPC9kaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+PG86cD4mbmJzcDs8L286
cD48L3A+DQo8L2Rpdj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj5IZXJlJ3MgYW4gZXhj
ZXJwdCBmcm9tIHRoZSBMZW5vdm8ncyBEU0RULmRzbCAoaG9waW5nIGl0IGhlbHBzKTo8bzpwPjwv
bzpwPjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPi0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tPG86cD48L286cD48L3A+DQo8L2Rpdj4NCjxkaXY+
DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj4mbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsg
RGV2aWNlIChFQyk8YnI+DQombmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgezxicj4N
CiZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyBOYW1lIChfSElELCBFaXNhSWQgKCZxdW90O1BOUDBDMDkmcXVvdDspIC8qIEVtYmVkZGVkIENv
bnRyb2xsZXIgRGV2aWNlICovKSZuYnNwOyAvLyBfSElEOiBIYXJkd2FyZSBJRDxicj4NCiZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBOYW1l
IChfVUlELCAweDAwKSZuYnNwOyAvLyBfVUlEOiBVbmlxdWUgSUQ8YnI+DQombmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgTmFtZSAoX0dQRSwg
MHgyMCkmbmJzcDsgLy8gX0dQRTogR2VuZXJhbCBQdXJwb3NlIEV2ZW50czxicj4NCiZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBNZXRob2Qg
KF9SRUcsIDIsIE5vdFNlcmlhbGl6ZWQpJm5ic3A7IC8vIF9SRUc6IFJlZ2lvbiBBdmFpbGFiaWxp
dHk8YnI+DQombmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsgezxicj4NCiZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBJZiAoKEFyZzAgPT0gMHgw
MykpPGJyPg0KJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IHs8YnI+DQombmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgXEg4RFIgPSBBcmcxPGJyPg0KJm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7IH08YnI+DQombmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgfTxvOnA+PC9vOnA+PC9wPg0KPC9kaXY+DQo8ZGl2
Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IE9wZXJhdGlvblJlZ2lvbiAoRUNPUiwgRW1iZWRkZWRD
b250cm9sLCAweDAwLCAweDAxMDApPGJyPg0KJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IEZpZWxkIChFQ09SLCBCeXRlQWNjLCBOb0xvY2ss
IFByZXNlcnZlKTxicj4NCiZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyB7PGJyPg0KJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IEhEQk0sJm5i
c3A7Jm5ic3A7IDEsIDxicj4NCiZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyAsJm5ic3A7Jm5ic3A7IDEsIDxicj4NCiZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyBIS0xLLCZuYnNwOyZuYnNwOyAxLCA8YnI+DQombmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgSEZO
RSwmbmJzcDsmbmJzcDsgMSwgPGJyPg0KJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7ICwmbmJzcDsmbmJzcDsgMSwgPGJyPg0KJm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7ICwmbmJzcDsmbmJzcDsgMSwgPGJyPg0KJm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IEhMRE0sJm5ic3A7Jm5ic3A7IDEsIDxicj4NCiZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyBPZmZzZXQgKDB4MDEpLCA8YnI+DQombmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsgQkJMUywmbmJzcDsmbmJzcDsgMSwgPGJyPg0KJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
IEJUQ00sJm5ic3A7Jm5ic3A7IDEsIDxicj4NCiZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyAsJm5ic3A7Jm5ic3A7IDEsIDxicj4NCiZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyAsJm5ic3A7Jm5ic3A7IDEsIDxicj4N
CiZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyAsJm5ic3A7
Jm5ic3A7IDEsIDxicj4NCiZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBIQlBSLCZuYnNwOyZuYnNw
OyAxLCA8YnI+DQombmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgQlRQQywmbmJzcDsmbmJzcDsgMSwg
PGJyPg0KJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IE9mZnNldCAoMHgwMiksIDxicj4NCiZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyBIRFVFLCZuYnNwOyZuYnNwOyAxLCA8YnI+DQombmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgLCZuYnNwOyZuYnNwOyA0LCA8
YnI+DQombmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgU05MSywmbmJzcDsmbmJzcDsgMSwgPGJyPg0K
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IE9mZnNldCAoMHgwMyksIDxicj4NCiZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyAsJm5ic3A7Jm5ic3A7IDUsIDxi
cj4NCiZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBIQVVNLCZuYnNwOyZuYnNwOyAyLCA8YnI+DQom
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgT2Zmc2V0ICgweDA1KSwgPGJyPg0KJm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7IEhTUEEsJm5ic3A7Jm5ic3A7IDEsIDxicj4NCiZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyBPZmZzZXQgKDB4MDYpLCA8YnI+DQombmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgSFNV
TiwmbmJzcDsmbmJzcDsgOCwgPGJyPg0KJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IEhTUlAsJm5i
c3A7Jm5ic3A7IDgsIDxicj4NCiZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBPZmZzZXQgKDB4MDkp
LCA8YnI+DQombmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsg
LCZuYnNwOyZuYnNwOyA2LCA8YnI+DQombmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgRk5LUywmbmJz
cDsmbmJzcDsgMSwgPGJyPg0KJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IE9mZnNldCAoMHgwQyks
IDxicj4NCiZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBITENMLCZuYnNwOyZuYnNwOyA4LCA8YnI+
DQombmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgLCZuYnNw
OyZuYnNwOyA0LCA8YnI+DQombmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgQ0FMTSwmbmJzcDsmbmJz
cDsgMSwgPGJyPg0KJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IE9mZnNldCAoMHgwRSksIDxicj4N
CiZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBIRk5TLCZuYnNwOyZuYnNwOyAyLCA8YnI+DQombmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsgT2Zmc2V0ICgweDBGKSwgPGJyPg0KJm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7ICwmbmJzcDsmbmJzcDsgNiwgPGJyPg0K
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IE5VTFMsJm5ic3A7Jm5ic3A7IDEsIDxicj4NCiZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyBPZmZzZXQgKDB4MTApLCA8YnI+DQombmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsgSEFNMCwmbmJzcDsmbmJzcDsgOCwgPGJyPg0KJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7IEhBTTEsJm5ic3A7Jm5ic3A7IDgsIDxicj4NCiZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBI
QU0yLCZuYnNwOyZuYnNwOyA4LCA8YnI+DQombmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgSEFNMywm
bmJzcDsmbmJzcDsgOCwgPGJyPg0KJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IEhBTTQsJm5ic3A7
Jm5ic3A7IDgsIDxicj4NCiZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBIQU01LCZuYnNwOyZuYnNw
OyA4LCA8YnI+DQombmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgSEFNNiwmbmJzcDsmbmJzcDsgOCwg
PGJyPg0KJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IEhBTTcsJm5ic3A7Jm5ic3A7IDgsIDxicj4N
CiZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBIQU04LCZuYnNwOyZuYnNwOyA4LCA8YnI+DQombmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsgSEFNOSwmbmJzcDsmbmJzcDsgOCwgPGJyPg0KJm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7IEhBTUEsJm5ic3A7Jm5ic3A7IDgsIDxicj4NCiZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyBIQU1CLCZuYnNwOyZuYnNwOyA4LCA8YnI+DQombmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsgSEFNQywmbmJzcDsmbmJzcDsgOCwgPGJyPg0KJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
IEhBTUQsJm5ic3A7Jm5ic3A7IDgsIDxicj4NCiZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBIQU1F
LCZuYnNwOyZuYnNwOyA4LCA8YnI+DQombmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgSEFNRiwmbmJz
cDsmbmJzcDsgOCwgPGJyPg0KJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IE9mZnNldCAoMHgyMyks
IDxicj4NCiZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBIQU5ULCZuYnNwOyZuYnNwOyA4LCA8YnI+
DQombmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgT2Zmc2V0ICgweDI2KSwgPGJyPg0KJm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7ICwmbmJzcDsmbmJzcDsgMiwg
PGJyPg0KJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IEhBTkEsJm5ic3A7Jm5ic3A7IDIsIDxicj4N
CiZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBPZmZzZXQgKDB4MjcpLCA8YnI+DQombmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsgT2Zmc2V0ICgweDI4KSwgPGJyPg0KJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7ICwmbmJzcDsmbmJzcDsgMSwgPGJyPg0KJm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7IFNLRU0sJm5ic3A7Jm5ic3A7IDEsIDxicj4NCiZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyBPZmZzZXQgKDB4MjkpLCA8YnI+DQombmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsgT2Zmc2V0ICgweDJBKSwgPGJyPg0KJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IEhBVFIsJm5i
c3A7Jm5ic3A7IDgsIDxicj4NCiZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBIVDBILCZuYnNwOyZu
YnNwOyA4LCA8YnI+DQombmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgSFQwTCwmbmJzcDsmbmJzcDsg
OCwgPGJyPg0KJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IEhUMUgsJm5ic3A7Jm5ic3A7IDgsIDxi
cj4NCiZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBIVDFMLCZuYnNwOyZuYnNwOyA4LCA8YnI+DQom
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgSEZTUCwmbmJzcDsmbmJzcDsgOCwgPGJyPg0KJm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7ICwmbmJzcDsmbmJzcDsg
NiwgPGJyPg0KJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IEhNVVQsJm5ic3A7Jm5ic3A7IDEsIDxi
cj4NCiZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBPZmZzZXQgKDB4MzEpLCA8YnI+DQombmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgLCZuYnNwOyZuYnNwOyAy
LCA8YnI+DQombmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgSFVXQiwmbmJzcDsmbmJzcDsgMSwgPGJy
Pg0KJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7ICwmbmJz
cDsmbmJzcDsgMywgPGJyPg0KJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IFZQT04sJm5ic3A7Jm5i
c3A7IDEsIDxicj4NCiZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBWUlNULCZuYnNwOyZuYnNwOyAx
LCA8YnI+DQombmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgSFdQTSwmbmJzcDsmbmJzcDsgMSwgPGJy
Pg0KJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IEhXTEIsJm5ic3A7Jm5ic3A7IDEsIDxicj4NCiZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBIV0xPLCZuYnNwOyZuYnNwOyAxLCA8YnI+DQombmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsgSFdESywmbmJzcDsmbmJzcDsgMSwgPGJyPg0KJm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7IEhXRk4sJm5ic3A7Jm5ic3A7IDEsIDxicj4NCiZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyBIV0JULCZuYnNwOyZuYnNwOyAxLCA8YnI+DQombmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsgSFdSSSwmbmJzcDsmbmJzcDsgMSwgPGJyPg0KJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IEhX
QlUsJm5ic3A7Jm5ic3A7IDEsIDxicj4NCiZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBIV0xVLCZu
YnNwOyZuYnNwOyAxLCA8YnI+DQombmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgT2Zmc2V0ICgweDM0
KSwgPGJyPg0KJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
ICwmbmJzcDsmbmJzcDsgMywgPGJyPg0KJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IFBJQlMsJm5i
c3A7Jm5ic3A7IDEsIDxicj4NCiZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyAsJm5ic3A7Jm5ic3A7IDMsIDxicj4NCiZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyBIUExPLCZuYnNwOyZuYnNwOyAxLCA8YnI+DQombmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgT2Zm
c2V0ICgweDM2KSwgPGJyPg0KJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IEhXQUMsJm5ic3A7Jm5i
c3A7IDE2LCA8YnI+DQombmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgSEIwUywmbmJzcDsmbmJzcDsg
NywgPGJyPg0KJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IEhCMEEsJm5ic3A7Jm5ic3A7IDEsIDxi
cj4NCiZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBIQjFTLCZuYnNwOyZuYnNwOyA3LCA8YnI+DQom
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgSEIxQSwmbmJzcDsmbmJzcDsgMSwgPGJyPg0KJm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7IEhDTVUsJm5ic3A7Jm5ic3A7IDEsIDxicj4NCiZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyAsJm5ic3A7Jm5ic3A7IDIsIDxi
cj4NCiZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBPVlJRLCZuYnNwOyZuYnNwOyAxLCA8YnI+DQom
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgRENCRCwmbmJzcDsmbmJzcDsgMSwgPGJyPg0KJm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7IERDV0wsJm5ic3A7Jm5ic3A7IDEsIDxicj4NCiZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyBEQ1dXLCZuYnNwOyZuYnNwOyAxLCA8YnI+DQombmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsgSEIxSSwmbmJzcDsmbmJzcDsgMSwgPGJyPg0KJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7ICwmbmJzcDsmbmJzcDsgMSwgPGJyPg0KJm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7IEtCTFQsJm5ic3A7Jm5ic3A7IDEsIDxicj4NCiZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyBCVFBXLCZuYnNwOyZuYnNwOyAxLCA8YnI+DQombmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsgRk5LQywmbmJzcDsmbmJzcDsgMSwgPGJyPg0KJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7IEhVQlMsJm5ic3A7Jm5ic3A7IDEsIDxicj4NCiZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBC
RFBXLCZuYnNwOyZuYnNwOyAxLCA8YnI+DQombmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgQkREVCwm
bmJzcDsmbmJzcDsgMSwgPGJyPg0KJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IEhVQkIsJm5ic3A7
Jm5ic3A7IDEsIDxicj4NCiZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBPZmZzZXQgKDB4NDYpLCA8
YnI+DQombmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgLCZu
YnNwOyZuYnNwOyAxLCA8YnI+DQombmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgQlRXSywmbmJzcDsm
bmJzcDsgMSwgPGJyPg0KJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IEhQTEQsJm5ic3A7Jm5ic3A7
IDEsIDxicj4NCiZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyAsJm5ic3A7Jm5ic3A7IDEsIDxicj4NCiZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBIUEFDLCZu
YnNwOyZuYnNwOyAxLCA8YnI+DQombmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgQlRTVCwmbmJzcDsm
bmJzcDsgMSwgPGJyPg0KJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IE9mZnNldCAoMHg0NyksIDxi
cj4NCiZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBIUEJVLCZuYnNwOyZuYnNwOyAxLCA8YnI+DQom
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgLCZuYnNwOyZu
YnNwOyAxLCA8YnI+DQombmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgSEJJRCwmbmJzcDsmbmJzcDsg
MSwgPGJyPg0KJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
ICwmbmJzcDsmbmJzcDsgMywgPGJyPg0KJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IEhCQ1MsJm5i
c3A7Jm5ic3A7IDEsIDxicj4NCiZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBIUE5GLCZuYnNwOyZu
YnNwOyAxLCA8YnI+DQombmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsgLCZuYnNwOyZuYnNwOyAxLCA8YnI+DQombmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgR1NU
UywmbmJzcDsmbmJzcDsgMSwgPGJyPg0KJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7ICwmbmJzcDsmbmJzcDsgMiwgPGJyPg0KJm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7IEhMQlUsJm5ic3A7Jm5ic3A7IDEsIDxicj4NCiZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyBET0NELCZuYnNwOyZuYnNwOyAxLCA8YnI+DQombmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgSENC
TCwmbmJzcDsmbmJzcDsgMSwgPGJyPg0KJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IE9mZnNldCAo
MHg0OSksIDxicj4NCiZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBTTFVMLCZuYnNwOyZuYnNwOyAx
LCA8YnI+DQombmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgT2Zmc2V0ICgweDRDKSwgPGJyPg0KJm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IEhUTUgsJm5ic3A7Jm5ic3A7IDgsIDxicj4NCiZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyBIVE1MLCZuYnNwOyZuYnNwOyA4LCA8YnI+DQombmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsgSFdBSywmbmJzcDsmbmJzcDsgMTYsIDxicj4NCiZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyBITVBSLCZuYnNwOyZuYnNwOyA4LCA8YnI+DQombmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgLCZuYnNwOyZuYnNwOyA3LCA8YnI+DQombmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsgSE1ETiwmbmJzcDsmbmJzcDsgMSwgPGJyPg0KJm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7IE9mZnNldCAoMHg3OCksIDxicj4NCiZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyBUTVAwLCZuYnNwOyZuYnNwOyA4LCA8YnI+DQombmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgT2Zm
c2V0ICgweDgwKSwgPGJyPg0KJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IE9mZnNldCAoMHg4MSks
IDxicj4NCiZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBISUlELCZuYnNwOyZuYnNwOyA4LCA8YnI+
DQombmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgT2Zmc2V0ICgweDgzKSwgPGJyPg0KJm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7IEhGTkksJm5ic3A7Jm5ic3A7IDgsIDxicj4NCiZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyBIU1BELCZuYnNwOyZuYnNwOyAxNiwgPGJyPg0KJm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7IE9mZnNldCAoMHg4OCksIDxicj4NCiZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBUU0ww
LCZuYnNwOyZuYnNwOyA3LCA8YnI+DQombmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgVFNSMCwmbmJz
cDsmbmJzcDsgMSwgPGJyPg0KJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IFRTTDEsJm5ic3A7Jm5i
c3A7IDcsIDxicj4NCiZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBUU1IxLCZuYnNwOyZuYnNwOyAx
LCA8YnI+DQombmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgVFNMMiwmbmJzcDsmbmJzcDsgNywgPGJy
Pg0KJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IFRTUjIsJm5ic3A7Jm5ic3A7IDEsIDxicj4NCiZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBUU0wzLCZuYnNwOyZuYnNwOyA3LCA8YnI+DQombmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsgVFNSMywmbmJzcDsmbmJzcDsgMSwgPGJyPg0KJm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7IE9mZnNldCAoMHg4RCksIDxicj4NCiZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyBIREFBLCZuYnNwOyZuYnNwOyAzLCA8YnI+DQombmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgSERB
QiwmbmJzcDsmbmJzcDsgMywgPGJyPg0KJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IEhEQUMsJm5i
c3A7Jm5ic3A7IDIsIDxicj4NCiZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBSQ0JELCZuYnNwOyZu
YnNwOyAxLCA8YnI+DQombmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgUkNXTCwmbmJzcDsmbmJzcDsg
MSwgPGJyPg0KJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IFJDV1csJm5ic3A7Jm5ic3A7IDEsIDxi
cj4NCiZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBPZmZzZXQgKDB4QjApLCA8YnI+DQombmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsgSERFTiwmbmJzcDsmbmJzcDsgMzIsIDxicj4NCiZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyBIREVQLCZuYnNwOyZuYnNwOyAzMiwgPGJyPg0KJm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7IEhERU0sJm5ic3A7Jm5ic3A7IDgsIDxicj4NCiZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyBIREVTLCZuYnNwOyZuYnNwOyA4LCA8YnI+DQombmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsg
T2Zmc2V0ICgweEM4KSwgPGJyPg0KJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IEFUTVgsJm5ic3A7
Jm5ic3A7IDgsIDxicj4NCiZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBIV0FULCZuYnNwOyZuYnNw
OyA4LCA8YnI+DQombmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgT2Zmc2V0ICgweENDKSwgPGJyPg0K
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IFBXTUgsJm5ic3A7Jm5ic3A7IDgsIDxicj4NCiZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyBQV01MLCZuYnNwOyZuYnNwOyA4LCA8YnI+DQombmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsgT2Zmc2V0ICgweEVEKSwgPGJyPg0KJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7ICwmbmJzcDsmbmJzcDsgNCwgPGJyPg0KJm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7IEhEREQsJm5ic3A7Jm5ic3A7IDE8YnI+DQombmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgfTxvOnA+PC9vOnA+
PC9wPg0KPC9kaXY+DQo8ZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPi0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tPG86cD48L286cD48L3A+DQo8L2Rpdj4NCjwv
ZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPjxvOnA+Jm5ic3A7PC9vOnA+PC9wPg0K
PC9kaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+TWFueSB0aGFua3MsPGJyPg0KRGV2
aW48bzpwPjwvbzpwPjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPjxv
OnA+Jm5ic3A7PC9vOnA+PC9wPg0KPC9kaXY+DQo8L2Rpdj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNv
Tm9ybWFsIj48bzpwPiZuYnNwOzwvbzpwPjwvcD4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFs
Ij5PbiBUaHUsIE1heSAyNSwgMjAxNyBhdCAxMDoxNSBBTSwgTW9vcmUsIFJvYmVydCAmbHQ7PGEg
aHJlZj0ibWFpbHRvOnJvYmVydC5tb29yZUBpbnRlbC5jb20iIHRhcmdldD0iX2JsYW5rIj5yb2Jl
cnQubW9vcmVAaW50ZWwuY29tPC9hPiZndDsgd3JvdGU6PG86cD48L286cD48L3A+DQo8YmxvY2tx
dW90ZSBzdHlsZT0iYm9yZGVyOm5vbmU7Ym9yZGVyLWxlZnQ6c29saWQgI0NDQ0NDQyAxLjBwdDtw
YWRkaW5nOjBpbiAwaW4gMGluIDYuMHB0O21hcmdpbi1sZWZ0OjQuOHB0O21hcmdpbi10b3A6NS4w
cHQ7bWFyZ2luLXJpZ2h0OjBpbjttYXJnaW4tYm90dG9tOjUuMHB0Ij4NCjxkaXY+DQo8ZGl2Pg0K
PHAgY2xhc3M9Ik1zb05vcm1hbCIgc3R5bGU9Im1zby1tYXJnaW4tdG9wLWFsdDphdXRvO21zby1t
YXJnaW4tYm90dG9tLWFsdDphdXRvIj5BQ1BJIEVycm9yOiBSZWdpb24gRW1iZWRkZWRDb250cm9s
IChJRD0zKSBoYXMgbm8gaGFuZGxlciAoMjAxNzAzMDMvZXhmbGRpby00MzEpPG86cD48L286cD48
L3A+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIiBzdHlsZT0ibXNvLW1hcmdpbi10b3AtYWx0OmF1dG87
bXNvLW1hcmdpbi1ib3R0b20tYWx0OmF1dG8iPjxzcGFuIHN0eWxlPSJmb250LXNpemU6MTEuMHB0
O2ZvbnQtZmFtaWx5OiZxdW90O0NhbGlicmkmcXVvdDssc2Fucy1zZXJpZjtjb2xvcjojMUY0OTdE
Ij4mbmJzcDs8L3NwYW4+PG86cD48L286cD48L3A+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIiBzdHls
ZT0ibXNvLW1hcmdpbi10b3AtYWx0OmF1dG87bXNvLW1hcmdpbi1ib3R0b20tYWx0OmF1dG8iPjxz
cGFuIHN0eWxlPSJmb250LXNpemU6MTEuMHB0O2ZvbnQtZmFtaWx5OiZxdW90O0NhbGlicmkmcXVv
dDssc2Fucy1zZXJpZjtjb2xvcjojMUY0OTdEIj5Zb3UgZWl0aGVyIGRvbuKAmXQgaGF2ZSBhIGRy
aXZlciBmb3IgdGhlIEVDLCBvciB5b3VyIEVDIGRyaXZlciBoYXMgbm90IGluc3RhbGxlZCBhIGhh
bmRsZXIgZm9yIHRoZSBFQw0KIG9wZXJhdGlvbiByZWdpb24uPC9zcGFuPjxvOnA+PC9vOnA+PC9w
Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCIgc3R5bGU9Im1zby1tYXJnaW4tdG9wLWFsdDphdXRvO21z
by1tYXJnaW4tYm90dG9tLWFsdDphdXRvIj48c3BhbiBzdHlsZT0iZm9udC1zaXplOjExLjBwdDtm
b250LWZhbWlseTomcXVvdDtDYWxpYnJpJnF1b3Q7LHNhbnMtc2VyaWY7Y29sb3I6IzFGNDk3RCI+
Jm5ic3A7PC9zcGFuPjxvOnA+PC9vOnA+PC9wPg0KPHAgY2xhc3M9Ik1zb05vcm1hbCIgc3R5bGU9
Im1zby1tYXJnaW4tdG9wLWFsdDphdXRvO21zby1tYXJnaW4tYm90dG9tLWFsdDphdXRvIj48c3Bh
biBzdHlsZT0iZm9udC1zaXplOjExLjBwdDtmb250LWZhbWlseTomcXVvdDtDYWxpYnJpJnF1b3Q7
LHNhbnMtc2VyaWY7Y29sb3I6IzFGNDk3RCI+SSB3b3VsZCBndWVzcy48L3NwYW4+PG86cD48L286
cD48L3A+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIiBzdHlsZT0ibXNvLW1hcmdpbi10b3AtYWx0OmF1
dG87bXNvLW1hcmdpbi1ib3R0b20tYWx0OmF1dG8iPjxzcGFuIHN0eWxlPSJmb250LXNpemU6MTEu
MHB0O2ZvbnQtZmFtaWx5OiZxdW90O0NhbGlicmkmcXVvdDssc2Fucy1zZXJpZjtjb2xvcjojMUY0
OTdEIj4mbmJzcDs8L3NwYW4+PG86cD48L286cD48L3A+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIiBz
dHlsZT0ibXNvLW1hcmdpbi10b3AtYWx0OmF1dG87bXNvLW1hcmdpbi1ib3R0b20tYWx0OmF1dG8i
PjxzcGFuIHN0eWxlPSJmb250LXNpemU6MTEuMHB0O2ZvbnQtZmFtaWx5OiZxdW90O0NhbGlicmkm
cXVvdDssc2Fucy1zZXJpZjtjb2xvcjojMUY0OTdEIj4mbmJzcDs8L3NwYW4+PG86cD48L286cD48
L3A+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIiBzdHlsZT0ibXNvLW1hcmdpbi10b3AtYWx0OmF1dG87
bXNvLW1hcmdpbi1ib3R0b20tYWx0OmF1dG8iPjxzcGFuIHN0eWxlPSJmb250LXNpemU6MTEuMHB0
O2ZvbnQtZmFtaWx5OiZxdW90O0NhbGlicmkmcXVvdDssc2Fucy1zZXJpZjtjb2xvcjojMUY0OTdE
Ij4mbmJzcDs8L3NwYW4+PG86cD48L286cD48L3A+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIiBzdHls
ZT0ibXNvLW1hcmdpbi10b3AtYWx0OmF1dG87bXNvLW1hcmdpbi1ib3R0b20tYWx0OmF1dG8iPjxz
cGFuIHN0eWxlPSJmb250LXNpemU6MTEuMHB0O2ZvbnQtZmFtaWx5OiZxdW90O0NhbGlicmkmcXVv
dDssc2Fucy1zZXJpZjtjb2xvcjojMUY0OTdEIj4mbmJzcDs8L3NwYW4+PG86cD48L286cD48L3A+
DQo8ZGl2IHN0eWxlPSJib3JkZXI6bm9uZTtib3JkZXItbGVmdDpzb2xpZCB3aW5kb3d0ZXh0IDEu
NXB0O3BhZGRpbmc6MGluIDBpbiAwaW4gNC4wcHQ7Ym9yZGVyLWNvbG9yOmN1cnJlbnRDb2xvciBj
dXJyZW50Q29sb3IgY3VycmVudENvbG9yIGJsdWUiPg0KPGRpdj4NCjxkaXYgc3R5bGU9ImJvcmRl
cjpub25lO2JvcmRlci10b3A6c29saWQgd2luZG93dGV4dCAxLjBwdDtwYWRkaW5nOjMuMHB0IDBp
biAwaW4gMGluO2JvcmRlci1jb2xvcjpjdXJyZW50Q29sb3IgY3VycmVudENvbG9yIj4NCjxwIGNs
YXNzPSJNc29Ob3JtYWwiIHN0eWxlPSJtc28tbWFyZ2luLXRvcC1hbHQ6YXV0bzttc28tbWFyZ2lu
LWJvdHRvbS1hbHQ6YXV0byI+PGI+PHNwYW4gc3R5bGU9ImZvbnQtc2l6ZToxMS4wcHQ7Zm9udC1m
YW1pbHk6JnF1b3Q7Q2FsaWJyaSZxdW90OyxzYW5zLXNlcmlmIj5Gcm9tOjwvc3Bhbj48L2I+PHNw
YW4gc3R5bGU9ImZvbnQtc2l6ZToxMS4wcHQ7Zm9udC1mYW1pbHk6JnF1b3Q7Q2FsaWJyaSZxdW90
OyxzYW5zLXNlcmlmIj4gRGV2ZWwgW21haWx0bzo8YSBocmVmPSJtYWlsdG86ZGV2ZWwtYm91bmNl
c0BhY3BpY2Eub3JnIiB0YXJnZXQ9Il9ibGFuayI+ZGV2ZWwtYm91bmNlc0BhY3BpY2Eub3JnPC9h
Pl0NCjxiPk9uIEJlaGFsZiBPZiA8L2I+RGV2aW4gU3RlZmZsZXI8YnI+DQo8Yj5TZW50OjwvYj4g
VGh1cnNkYXksIE1heSAyNSwgMjAxNyA2OjE1IEFNPGJyPg0KPGI+VG86PC9iPiA8YSBocmVmPSJt
YWlsdG86ZGV2ZWxAYWNwaWNhLm9yZyIgdGFyZ2V0PSJfYmxhbmsiPmRldmVsQGFjcGljYS5vcmc8
L2E+PGJyPg0KPGI+U3ViamVjdDo8L2I+IFtEZXZlbF0gSGVscCBuZWVkZWQgZm9yICZxdW90O0FD
UEkgRXJyb3I6IE5vIGhhbmRsZXIgZm9yIFJlZ2lvbiBbRUNPUl0mcXVvdDsgKHVzaW5nIG15IG93
biBPU0wpPC9zcGFuPjxvOnA+PC9vOnA+PC9wPg0KPC9kaXY+DQo8L2Rpdj4NCjxkaXY+DQo8ZGl2
Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCIgc3R5bGU9Im1zby1tYXJnaW4tdG9wLWFsdDphdXRvO21z
by1tYXJnaW4tYm90dG9tLWFsdDphdXRvIj4mbmJzcDs8bzpwPjwvbzpwPjwvcD4NCjxkaXY+DQo8
cCBjbGFzcz0iTXNvTm9ybWFsIiBzdHlsZT0ibXNvLW1hcmdpbi10b3AtYWx0OmF1dG87bXNvLW1h
cmdpbi1ib3R0b20tYWx0OmF1dG8iPkhlbGxvLDxvOnA+PC9vOnA+PC9wPg0KPGRpdj4NCjxwIGNs
YXNzPSJNc29Ob3JtYWwiIHN0eWxlPSJtc28tbWFyZ2luLXRvcC1hbHQ6YXV0bzttc28tbWFyZ2lu
LWJvdHRvbS1hbHQ6YXV0byI+Jm5ic3A7PG86cD48L286cD48L3A+DQo8L2Rpdj4NCjxkaXY+DQo8
cCBjbGFzcz0iTXNvTm9ybWFsIiBzdHlsZT0ibXNvLW1hcmdpbi10b3AtYWx0OmF1dG87bXNvLW1h
cmdpbi1ib3R0b20tYWx0OmF1dG8iPkkgYW0gd29ya2luZyBvbiBhbiBPU0wgZm9yIFFOWC4gSSBh
bSBnZXR0aW5nIHNvbWUgZXJyb3JzIHByaW50ZWQgb3V0IGR1cmluZyZuYnNwO0FjcGlJbml0aWFs
aXplT2JqZWN0cyBidXQgb25seSBpbiBvbmUgb3V0IG9mIHRocmVlIGxhcHRvcHMgdGhhdCBJIGFt
IHRlc3RpbmcuIEEgRGVsbCBhbmQgQVNVUyBsYXB0b3ANCiBkbyBub3QgaGF2ZSB0aGUgZXJyb3Jz
IGJ1dCBhIExlbm92byBsYXB0b3AgZG9lcy4gSSBhbSBhYmxlIHRvIHJlYWQgYmF0dGVyeSBzdGF0
dXMgKF9CU1QpIG9uIHRoZSBEZWxsIGFuZCBBU1VTIGxhcHRvcHMgYnV0IG5vdCBvbiB0aGUgTGVu
b3ZvIGxhcHRvcC48bzpwPjwvbzpwPjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29O
b3JtYWwiIHN0eWxlPSJtc28tbWFyZ2luLXRvcC1hbHQ6YXV0bzttc28tbWFyZ2luLWJvdHRvbS1h
bHQ6YXV0byI+Jm5ic3A7PG86cD48L286cD48L3A+DQo8L2Rpdj4NCjxkaXY+DQo8cCBjbGFzcz0i
TXNvTm9ybWFsIiBzdHlsZT0ibXNvLW1hcmdpbi10b3AtYWx0OmF1dG87bXNvLW1hcmdpbi1ib3R0
b20tYWx0OmF1dG8iPlRoZSBBQ1BJQ0EgdmVyc2lvbiBJIGFtIHVzaW5nIGlzIDIwMTcwMzAzLjxv
OnA+PC9vOnA+PC9wPg0KPC9kaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCIgc3R5bGU9
Im1zby1tYXJnaW4tdG9wLWFsdDphdXRvO21zby1tYXJnaW4tYm90dG9tLWFsdDphdXRvIj4mbmJz
cDs8bzpwPjwvbzpwPjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiIHN0
eWxlPSJtc28tbWFyZ2luLXRvcC1hbHQ6YXV0bzttc28tbWFyZ2luLWJvdHRvbS1hbHQ6YXV0byI+
U29tZSBxdWVzdGlvbnMgSSBoYXZlIGFyZTo8bzpwPjwvbzpwPjwvcD4NCjwvZGl2Pg0KPGRpdj4N
CjxwIGNsYXNzPSJNc29Ob3JtYWwiIHN0eWxlPSJtc28tbWFyZ2luLXRvcC1hbHQ6YXV0bzttc28t
bWFyZ2luLWJvdHRvbS1hbHQ6YXV0byI+LSBJcyB0aGlzIHRoZSBjb3JyZWN0IG1haWxpbmcgbGlz
dCBmb3IgdGhpcyBlbWFpbD88bzpwPjwvbzpwPjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNz
PSJNc29Ob3JtYWwiIHN0eWxlPSJtc28tbWFyZ2luLXRvcC1hbHQ6YXV0bzttc28tbWFyZ2luLWJv
dHRvbS1hbHQ6YXV0byI+LSBEb2VzIHRoaXMgYXBwZWFyIHRvIGJlIGEgYnVnIGluIEFDUElDQSwg
aW4gbXkgT1NMLCBvciBzb21ld2hlcmUgZWxzZSAobWF5YmUgdGhlIGxhcHRvcCBCSU9TKT88bzpw
PjwvbzpwPjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiIHN0eWxlPSJt
c28tbWFyZ2luLXRvcC1hbHQ6YXV0bzttc28tbWFyZ2luLWJvdHRvbS1hbHQ6YXV0byI+LSBTaG91
bGQgSSByYWlzZSBhIGJ1ZyBmb3IgdGhpcz88bzpwPjwvbzpwPjwvcD4NCjwvZGl2Pg0KPGRpdj4N
CjxwIGNsYXNzPSJNc29Ob3JtYWwiIHN0eWxlPSJtc28tbWFyZ2luLXRvcC1hbHQ6YXV0bzttc28t
bWFyZ2luLWJvdHRvbS1hbHQ6YXV0byI+LSBXb3VsZCB5b3UgcHJvdmlkZSBhbnkgcmVjb21tZW5k
YXRpb25zIHRvIGhlbHAgbWUgdHJvdWJsZXNob290IHRoaXM/PG86cD48L286cD48L3A+DQo8L2Rp
dj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIiBzdHlsZT0ibXNvLW1hcmdpbi10b3AtYWx0
OmF1dG87bXNvLW1hcmdpbi1ib3R0b20tYWx0OmF1dG8iPi0gV2hhdCBvdGhlciBpbmZvcm1hdGlv
biBzaG91bGQgSSBwcm92aWRlPzxvOnA+PC9vOnA+PC9wPg0KPC9kaXY+DQo8ZGl2Pg0KPHAgY2xh
c3M9Ik1zb05vcm1hbCIgc3R5bGU9Im1zby1tYXJnaW4tdG9wLWFsdDphdXRvO21zby1tYXJnaW4t
Ym90dG9tLWFsdDphdXRvIj4mbmJzcDs8bzpwPjwvbzpwPjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxw
IGNsYXNzPSJNc29Ob3JtYWwiIHN0eWxlPSJtc28tbWFyZ2luLXRvcC1hbHQ6YXV0bzttc28tbWFy
Z2luLWJvdHRvbS1hbHQ6YXV0byI+VGhpcyBpcyB0aGUgb3V0cHV0IGR1cmluZyBBQ1BJIGluaXRp
YWxpemF0aW9uIG9uIHRoZSBwcm9ibGVtYXRpYyBsYXB0b3AgKGZyb20gbXkgT1NMKTo8bzpwPjwv
bzpwPjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIiBzdHls
ZT0ibXNvLW1hcmdpbi10b3AtYWx0OmF1dG87bXNvLW1hcmdpbi1ib3R0b20tYWx0OmF1dG8iPi0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLTxvOnA+PC9vOnA+PC9wPg0KPC9k
aXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCIgc3R5bGU9Im1zby1tYXJnaW4tdG9wLWFs
dDphdXRvO21zby1tYXJnaW4tYm90dG9tLWFsdDphdXRvIj5BQ1BJOiBSU0RQIDB4MDAwMDAwMDAw
MDBGMDEyMCAwMDAwMjQgKHYwMiBMRU5PVk8pPG86cD48L286cD48L3A+DQo8L2Rpdj4NCjxkaXY+
DQo8cCBjbGFzcz0iTXNvTm9ybWFsIiBzdHlsZT0ibXNvLW1hcmdpbi10b3AtYWx0OmF1dG87bXNv
LW1hcmdpbi1ib3R0b20tYWx0OmF1dG8iPkFDUEk6IFhTRFQgMHgwMDAwMDAwMEQ3RkQyMTg4IDAw
MDBDQyAodjAxIExFTk9WTyBUUC1SMDAgJm5ic3A7IDAwMDAwMDAwIFBURUMgMDAwMDAwMDIpPG86
cD48L286cD48L3A+DQo8L2Rpdj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIiBzdHlsZT0i
bXNvLW1hcmdpbi10b3AtYWx0OmF1dG87bXNvLW1hcmdpbi1ib3R0b20tYWx0OmF1dG8iPkFDUEk6
IEZBQ1AgMHgwMDAwMDAwMEQ3RkY3MDAwIDAwMDBGNCAodjA1IExFTk9WTyBUUC1SMDAgJm5ic3A7
IDAwMDAwNDIwIFBURUMgMDAwMDAwMDIpPG86cD48L286cD48L3A+DQo8L2Rpdj4NCjxkaXY+DQo8
cCBjbGFzcz0iTXNvTm9ybWFsIiBzdHlsZT0ibXNvLW1hcmdpbi10b3AtYWx0OmF1dG87bXNvLW1h
cmdpbi1ib3R0b20tYWx0OmF1dG8iPkFDUEk6IERTRFQgMHgwMDAwMDAwMEQ3RkRFMDAwIDAxMTQ1
MSAodjAyIExFTk9WTyBUUC1SMDAgJm5ic3A7IDAwMDAwNDIwIElOVEwgMjAxNDExMDcpPG86cD48
L286cD48L3A+DQo8L2Rpdj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIiBzdHlsZT0ibXNv
LW1hcmdpbi10b3AtYWx0OmF1dG87bXNvLW1hcmdpbi1ib3R0b20tYWx0OmF1dG8iPkFDUEk6IEZB
Q1MgMHgwMDAwMDAwMEQ3RkEyMDAwIDAwMDA0MDxvOnA+PC9vOnA+PC9wPg0KPC9kaXY+DQo8ZGl2
Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCIgc3R5bGU9Im1zby1tYXJnaW4tdG9wLWFsdDphdXRvO21z
by1tYXJnaW4tYm90dG9tLWFsdDphdXRvIj5BQ1BJOiBVRUZJIDB4MDAwMDAwMDBEN0ZCOTAwMCAw
MDAwNDIgKHYwMSBMRU5PVk8gVFAtUjAwICZuYnNwOyAwMDAwMDQyMCBQVEVDIDAwMDAwMDAyKTxv
OnA+PC9vOnA+PC9wPg0KPC9kaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCIgc3R5bGU9
Im1zby1tYXJnaW4tdG9wLWFsdDphdXRvO21zby1tYXJnaW4tYm90dG9tLWFsdDphdXRvIj5BQ1BJ
OiBTU0RUIDB4MDAwMDAwMDBEN0ZGODAwMCAwMDRFMEEgKHYwMiBMRU5PVk8gU2FTc2R0ICZuYnNw
OyAwMDAwMzAwMCBJTlRMIDIwMTQxMTA3KTxvOnA+PC9vOnA+PC9wPg0KPC9kaXY+DQo8ZGl2Pg0K
PHAgY2xhc3M9Ik1zb05vcm1hbCIgc3R5bGU9Im1zby1tYXJnaW4tdG9wLWFsdDphdXRvO21zby1t
YXJnaW4tYm90dG9tLWFsdDphdXRvIj5BQ1BJOiBBU0YhIDB4MDAwMDAwMDBEN0ZGNjAwMCAwMDAw
QTUgKHYzMiBMRU5PVk8gVFAtUjAwICZuYnNwOyAwMDAwMDQyMCBQVEVDIDAwMDAwMDAyKTxvOnA+
PC9vOnA+PC9wPg0KPC9kaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCIgc3R5bGU9Im1z
by1tYXJnaW4tdG9wLWFsdDphdXRvO21zby1tYXJnaW4tYm90dG9tLWFsdDphdXRvIj5BQ1BJOiBF
Q0RUIDB4MDAwMDAwMDBEN0ZGNTAwMCAwMDAwNTIgKHYwMSBMRU5PVk8gVFAtUjAwICZuYnNwOyAw
MDAwMDQyMCBQVEVDIDAwMDAwMDAyKTxvOnA+PC9vOnA+PC9wPg0KPC9kaXY+DQo8ZGl2Pg0KPHAg
Y2xhc3M9Ik1zb05vcm1hbCIgc3R5bGU9Im1zby1tYXJnaW4tdG9wLWFsdDphdXRvO21zby1tYXJn
aW4tYm90dG9tLWFsdDphdXRvIj5BQ1BJOiBIUEVUIDB4MDAwMDAwMDBEN0ZGNDAwMCAwMDAwMzgg
KHYwMSBMRU5PVk8gVFAtUjAwICZuYnNwOyAwMDAwMDQyMCBQVEVDIDAwMDAwMDAyKTxvOnA+PC9v
OnA+PC9wPg0KPC9kaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCIgc3R5bGU9Im1zby1t
YXJnaW4tdG9wLWFsdDphdXRvO21zby1tYXJnaW4tYm90dG9tLWFsdDphdXRvIj5BQ1BJOiBMUElU
IDB4MDAwMDAwMDBEN0ZGMzAwMCAwMDAwOTQgKHYwMSBMRU5PVk8gVFAtUjAwICZuYnNwOyAwMDAw
MDQyMCBQVEVDIDAwMDAwMDAyKTxvOnA+PC9vOnA+PC9wPg0KPC9kaXY+DQo8ZGl2Pg0KPHAgY2xh
c3M9Ik1zb05vcm1hbCIgc3R5bGU9Im1zby1tYXJnaW4tdG9wLWFsdDphdXRvO21zby1tYXJnaW4t
Ym90dG9tLWFsdDphdXRvIj5BQ1BJOiBBUElDIDB4MDAwMDAwMDBEN0ZGMjAwMCAwMDAwQkMgKHYw
MyBMRU5PVk8gVFAtUjAwICZuYnNwOyAwMDAwMDQyMCBQVEVDIDAwMDAwMDAyKTxvOnA+PC9vOnA+
PC9wPg0KPC9kaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCIgc3R5bGU9Im1zby1tYXJn
aW4tdG9wLWFsdDphdXRvO21zby1tYXJnaW4tYm90dG9tLWFsdDphdXRvIj5BQ1BJOiBNQ0ZHIDB4
MDAwMDAwMDBEN0ZGMTAwMCAwMDAwM0MgKHYwMSBMRU5PVk8gVFAtUjAwICZuYnNwOyAwMDAwMDQy
MCBQVEVDIDAwMDAwMDAyKTxvOnA+PC9vOnA+PC9wPg0KPC9kaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9
Ik1zb05vcm1hbCIgc3R5bGU9Im1zby1tYXJnaW4tdG9wLWFsdDphdXRvO21zby1tYXJnaW4tYm90
dG9tLWFsdDphdXRvIj5BQ1BJOiBXREFUIDB4MDAwMDAwMDBEN0ZGMDAwMCAwMDAxMzQgKHYwMSBM
RU5PVk8gVFAtUjAwICZuYnNwOyAwMDAwMDQyMCBQVEVDIDAwMDAwMDAyKTxvOnA+PC9vOnA+PC9w
Pg0KPC9kaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCIgc3R5bGU9Im1zby1tYXJnaW4t
dG9wLWFsdDphdXRvO21zby1tYXJnaW4tYm90dG9tLWFsdDphdXRvIj5BQ1BJOiBTU0RUIDB4MDAw
MDAwMDBEN0ZEQzAwMCAwMDFBRkMgKHYwMSBMRU5PVk8gU2F0YUFoY2kgMDAwMDEwMDAgSU5UTCAy
MDE0MTEwNyk8bzpwPjwvbzpwPjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3Jt
YWwiIHN0eWxlPSJtc28tbWFyZ2luLXRvcC1hbHQ6YXV0bzttc28tbWFyZ2luLWJvdHRvbS1hbHQ6
YXV0byI+QUNQSTogREJHUCAweDAwMDAwMDAwRDdGREIwMDAgMDAwMDM0ICh2MDEgTEVOT1ZPIFRQ
LVIwMCAmbmJzcDsgMDAwMDA0MjAgUFRFQyAwMDAwMDAwMik8bzpwPjwvbzpwPjwvcD4NCjwvZGl2
Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiIHN0eWxlPSJtc28tbWFyZ2luLXRvcC1hbHQ6
YXV0bzttc28tbWFyZ2luLWJvdHRvbS1hbHQ6YXV0byI+QUNQSTogREJHMiAweDAwMDAwMDAwRDdG
REEwMDAgMDAwMDU0ICh2MDAgTEVOT1ZPIFRQLVIwMCAmbmJzcDsgMDAwMDA0MjAgUFRFQyAwMDAw
MDAwMik8bzpwPjwvbzpwPjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwi
IHN0eWxlPSJtc28tbWFyZ2luLXRvcC1hbHQ6YXV0bzttc28tbWFyZ2luLWJvdHRvbS1hbHQ6YXV0
byI+QUNQSTogQk9PVCAweDAwMDAwMDAwRDdGRDkwMDAgMDAwMDI4ICh2MDEgTEVOT1ZPIFRQLVIw
MCAmbmJzcDsgMDAwMDA0MjAgUFRFQyAwMDAwMDAwMik8bzpwPjwvbzpwPjwvcD4NCjwvZGl2Pg0K
PGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiIHN0eWxlPSJtc28tbWFyZ2luLXRvcC1hbHQ6YXV0
bzttc28tbWFyZ2luLWJvdHRvbS1hbHQ6YXV0byI+QUNQSTogQkFUQiAweDAwMDAwMDAwRDdGRDgw
MDAgMDAwMDQ2ICh2MDEgTEVOT1ZPIFRQLVIwMCAmbmJzcDsgMDAwMDA0MjAgUFRFQyAwMDAwMDAw
Mik8bzpwPjwvbzpwPjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiIHN0
eWxlPSJtc28tbWFyZ2luLXRvcC1hbHQ6YXV0bzttc28tbWFyZ2luLWJvdHRvbS1hbHQ6YXV0byI+
QUNQSTogU0xJQyAweDAwMDAwMDAwRDdGRDcwMDAgMDAwMTc2ICh2MDEgTEVOT1ZPIFRQLVIwMCAm
bmJzcDsgMDAwMDA0MjAgUFRFQyAwMDAwMDAwMik8bzpwPjwvbzpwPjwvcD4NCjwvZGl2Pg0KPGRp
dj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiIHN0eWxlPSJtc28tbWFyZ2luLXRvcC1hbHQ6YXV0bztt
c28tbWFyZ2luLWJvdHRvbS1hbHQ6YXV0byI+QUNQSTogU1NEVCAweDAwMDAwMDAwRDdGRDYwMDAg
MDAwRTU4ICh2MDIgTEVOT1ZPIENwdVNzZHQgJm5ic3A7MDAwMDMwMDAgSU5UTCAyMDE0MTEwNyk8
bzpwPjwvbzpwPjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiIHN0eWxl
PSJtc28tbWFyZ2luLXRvcC1hbHQ6YXV0bzttc28tbWFyZ2luLWJvdHRvbS1hbHQ6YXV0byI+QUNQ
STogU1NEVCAweDAwMDAwMDAwRDdGRDUwMDAgMDAwM0Q5ICh2MDIgTEVOT1ZPIEN0ZHBCICZuYnNw
OyAmbmJzcDswMDAwMTAwMCBJTlRMIDIwMTQxMTA3KTxvOnA+PC9vOnA+PC9wPg0KPC9kaXY+DQo8
ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCIgc3R5bGU9Im1zby1tYXJnaW4tdG9wLWFsdDphdXRv
O21zby1tYXJnaW4tYm90dG9tLWFsdDphdXRvIj5BQ1BJOiBNU0RNIDB4MDAwMDAwMDBEN0ZENDAw
MCAwMDAwNTUgKHYwMyBMRU5PVk8gVFAtUjAwICZuYnNwOyAwMDAwMDQyMCBQVEVDIDAwMDAwMDAy
KTxvOnA+PC9vOnA+PC9wPg0KPC9kaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCIgc3R5
bGU9Im1zby1tYXJnaW4tdG9wLWFsdDphdXRvO21zby1tYXJnaW4tYm90dG9tLWFsdDphdXRvIj5B
Q1BJOiBGUERUIDB4MDAwMDAwMDBEN0ZEMzAwMCAwMDAwNDQgKHYwMSBMRU5PVk8gVFAtUjAwICZu
YnNwOyAwMDAwMDQyMCBQVEVDIDAwMDAwMDAyKTxvOnA+PC9vOnA+PC9wPg0KPC9kaXY+DQo8ZGl2
Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCIgc3R5bGU9Im1zby1tYXJnaW4tdG9wLWFsdDphdXRvO21z
by1tYXJnaW4tYm90dG9tLWFsdDphdXRvIj5BQ1BJOiBVRUZJIDB4MDAwMDAwMDBEN0ZBMDAwMCAw
MDAxMkEgKHYwMSBMRU5PVk8gVFAtUjAwICZuYnNwOyAwMDAwMDQyMCBQVEVDIDAwMDAwMDAyKTxv
OnA+PC9vOnA+PC9wPg0KPC9kaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCIgc3R5bGU9
Im1zby1tYXJnaW4tdG9wLWFsdDphdXRvO21zby1tYXJnaW4tYm90dG9tLWFsdDphdXRvIj4mbmJz
cDs8bzpwPjwvbzpwPjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiIHN0
eWxlPSJtc28tbWFyZ2luLXRvcC1hbHQ6YXV0bzttc28tbWFyZ2luLWJvdHRvbS1hbHQ6YXV0byI+
SW5pdGlhbGl6aW5nIE5hbWVzcGFjZSBvYmplY3RzOjxvOnA+PC9vOnA+PC9wPg0KPC9kaXY+DQo8
ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCIgc3R5bGU9Im1zby1tYXJnaW4tdG9wLWFsdDphdXRv
O21zby1tYXJnaW4tYm90dG9tLWFsdDphdXRvIj5UYWJsZSBbRFNEVDogVFAtUjAwICZuYnNwO10g
KGlkIDAxKSAtIDI3NTcgT2JqZWN0cyB3aXRoICZuYnNwOzc2IERldmljZXMsICZuYnNwOzQwIFJl
Z2lvbnMsICZuYnNwOzUxMCBNZXRob2RzICgxNDAvMzcwLzI0IFNlcmlhbC9Ob24vQ3Z0KTxvOnA+
PC9vOnA+PC9wPg0KPC9kaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCIgc3R5bGU9Im1z
by1tYXJnaW4tdG9wLWFsdDphdXRvO21zby1tYXJnaW4tYm90dG9tLWFsdDphdXRvIj5UYWJsZSBb
U1NEVDogU2FTc2R0ICZuYnNwO10gKGlkIDAyKSAtICZuYnNwOzU1MiBPYmplY3RzIHdpdGggJm5i
c3A7MTggRGV2aWNlcywgJm5ic3A7MjAgUmVnaW9ucywgJm5ic3A7MTMxIE1ldGhvZHMgKDQxLzkw
LzcgU2VyaWFsL05vbi9DdnQpPG86cD48L286cD48L3A+DQo8L2Rpdj4NCjxkaXY+DQo8cCBjbGFz
cz0iTXNvTm9ybWFsIiBzdHlsZT0ibXNvLW1hcmdpbi10b3AtYWx0OmF1dG87bXNvLW1hcmdpbi1i
b3R0b20tYWx0OmF1dG8iPlRhYmxlIFtTU0RUOiBTYXRhQWhjaV0gKGlkIDAzKSAtICZuYnNwOzE4
MyBPYmplY3RzIHdpdGggJm5ic3A7IDggRGV2aWNlcywgJm5ic3A7IDAgUmVnaW9ucywgJm5ic3A7
IDM0IE1ldGhvZHMgKDI1LzkvNSBTZXJpYWwvTm9uL0N2dCk8bzpwPjwvbzpwPjwvcD4NCjwvZGl2
Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiIHN0eWxlPSJtc28tbWFyZ2luLXRvcC1hbHQ6
YXV0bzttc28tbWFyZ2luLWJvdHRvbS1hbHQ6YXV0byI+VGFibGUgW1NTRFQ6IENwdVNzZHQgXSAo
aWQgMDQpIC0gJm5ic3A7MTE0IE9iamVjdHMgd2l0aCAmbmJzcDsgMCBEZXZpY2VzLCAmbmJzcDsg
MyBSZWdpb25zLCAmbmJzcDsgMjkgTWV0aG9kcyAoMTMvMTYvMTMgU2VyaWFsL05vbi9DdnQpPG86
cD48L286cD48L3A+DQo8L2Rpdj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIiBzdHlsZT0i
bXNvLW1hcmdpbi10b3AtYWx0OmF1dG87bXNvLW1hcmdpbi1ib3R0b20tYWx0OmF1dG8iPlRhYmxl
IFtTU0RUOiBDdGRwQiAmbmJzcDsgXSAoaWQgMDUpIC0gJm5ic3A7IDMzIE9iamVjdHMgd2l0aCAm
bmJzcDsgMCBEZXZpY2VzLCAmbmJzcDsgMSBSZWdpb25zLCAmbmJzcDsgJm5ic3A7NSBNZXRob2Rz
ICgyLzMvMSBTZXJpYWwvTm9uL0N2dCk8bzpwPjwvbzpwPjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxw
IGNsYXNzPSJNc29Ob3JtYWwiIHN0eWxlPSJtc28tbWFyZ2luLXRvcC1hbHQ6YXV0bzttc28tbWFy
Z2luLWJvdHRvbS1hbHQ6YXV0byI+QUNQSTogNSBBQ1BJIEFNTCB0YWJsZXMgc3VjY2Vzc2Z1bGx5
IGFjcXVpcmVkIGFuZCBsb2FkZWQ8bzpwPjwvbzpwPjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNs
YXNzPSJNc29Ob3JtYWwiIHN0eWxlPSJtc28tbWFyZ2luLXRvcC1hbHQ6YXV0bzttc28tbWFyZ2lu
LWJvdHRvbS1hbHQ6YXV0byI+Q29tcGxldGluZyBSZWdpb24vRmllbGQvQnVmZmVyL1BhY2thZ2Ug
aW5pdGlhbGl6YXRpb246PG86cD48L286cD48L3A+DQo8L2Rpdj4NCjxkaXY+DQo8cCBjbGFzcz0i
TXNvTm9ybWFsIiBzdHlsZT0ibXNvLW1hcmdpbi10b3AtYWx0OmF1dG87bXNvLW1hcmdpbi1ib3R0
b20tYWx0OmF1dG8iPiZuYnNwOyAmbmJzcDsgSW5pdGlhbGl6ZWQgNjMvNjQgUmVnaW9ucyA3MS83
MSBGaWVsZHMgODgvODggQnVmZmVycyA4My84MyBQYWNrYWdlcyAoMzY0OCBub2Rlcyk8bzpwPjwv
bzpwPjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiIHN0eWxlPSJtc28t
bWFyZ2luLXRvcC1hbHQ6YXV0bzttc28tbWFyZ2luLWJvdHRvbS1hbHQ6YXV0byI+Jm5ic3A7ZXZ4
ZmV2bnQtMDIxOCBFbmFibGUgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJz
cDsgJm5ic3A7ICZuYnNwOzogVHJhbnNpdGlvbiB0byBBQ1BJIG1vZGUgc3VjY2Vzc2Z1bDxvOnA+
PC9vOnA+PC9wPg0KPC9kaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCIgc3R5bGU9Im1z
by1tYXJnaW4tdG9wLWFsdDphdXRvO21zby1tYXJnaW4tYm90dG9tLWFsdDphdXRvIj5Jbml0aWFs
aXppbmcgR2VuZXJhbCBQdXJwb3NlIEV2ZW50cyAoR1BFcyk6PG86cD48L286cD48L3A+DQo8L2Rp
dj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIiBzdHlsZT0ibXNvLW1hcmdpbi10b3AtYWx0
OmF1dG87bXNvLW1hcmdpbi1ib3R0b20tYWx0OmF1dG8iPiZuYnNwOyAmbmJzcDsgSW5pdGlhbGl6
ZWQgR1BFIDAwIHRvIDdGIFtfR1BFXSAxNiByZWdzIG9uIGludGVycnVwdCAweDkgKFNDSSk8bzpw
PjwvbzpwPjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiIHN0eWxlPSJt
c28tbWFyZ2luLXRvcC1hbHQ6YXV0bzttc28tbWFyZ2luLWJvdHRvbS1hbHQ6YXV0byI+SW5pdGlh
bGl6aW5nIERldmljZS9Qcm9jZXNzb3IvVGhlcm1hbCBvYmplY3RzIGFuZCBleGVjdXRpbmcgX0lO
SS9fU1RBIG1ldGhvZHM6PG86cD48L286cD48L3A+DQo8L2Rpdj4NCjxkaXY+DQo8cCBjbGFzcz0i
TXNvTm9ybWFsIiBzdHlsZT0ibXNvLW1hcmdpbi10b3AtYWx0OmF1dG87bXNvLW1hcmdpbi1ib3R0
b20tYWx0OmF1dG8iPkFDUEkgRXJyb3I6IE5vIGhhbmRsZXIgZm9yIFJlZ2lvbiBbRUNPUl0gKDgw
ZGExMzApIFtFbWJlZGRlZENvbnRyb2xdICgyMDE3MDMwMy9ldnJlZ2lvbi0yOTEpPG86cD48L286
cD48L3A+DQo8L2Rpdj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIiBzdHlsZT0ibXNvLW1h
cmdpbi10b3AtYWx0OmF1dG87bXNvLW1hcmdpbi1ib3R0b20tYWx0OmF1dG8iPkFDUEkgRXJyb3I6
IFJlZ2lvbiBFbWJlZGRlZENvbnRyb2wgKElEPTMpIGhhcyBubyBoYW5kbGVyICgyMDE3MDMwMy9l
eGZsZGlvLTQzMSk8bzpwPjwvbzpwPjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29O
b3JtYWwiIHN0eWxlPSJtc28tbWFyZ2luLXRvcC1hbHQ6YXV0bzttc28tbWFyZ2luLWJvdHRvbS1h
bHQ6YXV0byI+QUNQSSBFcnJvcjogTWV0aG9kIHBhcnNlL2V4ZWN1dGlvbiBmYWlsZWQgW1xfU0Iu
UENJMC5MUEMuRUMuQUMuX1BTUl0gKE5vZGUgODBkMGMzMCksIEFFX05PVF9FWElTVCAoMjAxNzAz
MDMvcHNwYXJzZS02NjgpPG86cD48L286cD48L3A+DQo8L2Rpdj4NCjxkaXY+DQo8cCBjbGFzcz0i
TXNvTm9ybWFsIiBzdHlsZT0ibXNvLW1hcmdpbi10b3AtYWx0OmF1dG87bXNvLW1hcmdpbi1ib3R0
b20tYWx0OmF1dG8iPkFDUEkgRXJyb3I6IE1ldGhvZCBwYXJzZS9leGVjdXRpb24gZmFpbGVkIFtc
X1NCLl9JTkldIChOb2RlIDgwZTRmNTApLCBBRV9OT1RfRVhJU1QgKDIwMTcwMzAzL3BzcGFyc2Ut
NjY4KTxvOnA+PC9vOnA+PC9wPg0KPC9kaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCIg
c3R5bGU9Im1zby1tYXJnaW4tdG9wLWFsdDphdXRvO21zby1tYXJnaW4tYm90dG9tLWFsdDphdXRv
Ij5BQ1BJIEVycm9yOiBObyBoYW5kbGVyIGZvciBSZWdpb24gW0VDT1JdICg4MGRhMTMwKSBbRW1i
ZWRkZWRDb250cm9sXSAoMjAxNzAzMDMvZXZyZWdpb24tMjkxKTxvOnA+PC9vOnA+PC9wPg0KPC9k
aXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCIgc3R5bGU9Im1zby1tYXJnaW4tdG9wLWFs
dDphdXRvO21zby1tYXJnaW4tYm90dG9tLWFsdDphdXRvIj5BQ1BJIEVycm9yOiBSZWdpb24gRW1i
ZWRkZWRDb250cm9sIChJRD0zKSBoYXMgbm8gaGFuZGxlciAoMjAxNzAzMDMvZXhmbGRpby00MzEp
PG86cD48L286cD48L3A+DQo8L2Rpdj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIiBzdHls
ZT0ibXNvLW1hcmdpbi10b3AtYWx0OmF1dG87bXNvLW1hcmdpbi1ib3R0b20tYWx0OmF1dG8iPkFD
UEkgRXJyb3I6IE1ldGhvZCBwYXJzZS9leGVjdXRpb24gZmFpbGVkIFtcX1NCLlBDSTAuTFBDLkVD
Ll9JTkldIChOb2RlIDgwZDAwZDApLCBBRV9OT1RfRVhJU1QgKDIwMTcwMzAzL3BzcGFyc2UtNjY4
KTxvOnA+PC9vOnA+PC9wPg0KPC9kaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCIgc3R5
bGU9Im1zby1tYXJnaW4tdG9wLWFsdDphdXRvO21zby1tYXJnaW4tYm90dG9tLWFsdDphdXRvIj5B
Q1BJIEV4Y2VwdGlvbjogQUVfTk9UX0VYSVNULCBkdXJpbmcgXF9TQi5QQ0kwLkxQQy5FQy5fSU5J
IGV4ZWN1dGlvbiAoMjAxNzAzMDMvbnNpbml0LTgwNyk8bzpwPjwvbzpwPjwvcD4NCjwvZGl2Pg0K
PGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiIHN0eWxlPSJtc28tbWFyZ2luLXRvcC1hbHQ6YXV0
bzttc28tbWFyZ2luLWJvdHRvbS1hbHQ6YXV0byI+Jm5ic3A7ICZuYnNwOyBFeGVjdXRlZCAxMyBf
SU5JIG1ldGhvZHMgcmVxdWlyaW5nIDEgX1NUQSBleGVjdXRpb25zIChleGFtaW5lZCAxMTMgb2Jq
ZWN0cyk8bzpwPjwvbzpwPjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwi
IHN0eWxlPSJtc28tbWFyZ2luLXRvcC1hbHQ6YXV0bzttc28tbWFyZ2luLWJvdHRvbS1hbHQ6YXV0
byI+LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tPG86cD48L286cD48L3A+
DQo8L2Rpdj4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiIHN0eWxlPSJtc28t
bWFyZ2luLXRvcC1hbHQ6YXV0bzttc28tbWFyZ2luLWJvdHRvbS1hbHQ6YXV0byI+Jm5ic3A7PG86
cD48L286cD48L3A+DQo8L2Rpdj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIiBzdHlsZT0i
bXNvLW1hcmdpbi10b3AtYWx0OmF1dG87bXNvLW1hcmdpbi1ib3R0b20tYWx0OmF1dG8iPlRoaXMg
aXMgdGhlIG91dHB1dCBmcm9tIGNhbGxpbmcgQWNwaUV2YWx1YXRlT2JqZWN0IGZvciB0aGUgY29u
dHJvbCBtZXRob2QgJnF1b3Q7XF9TQi5QQ0kwLkxQQy5FQy5CQVQwLl9CU1QmcXVvdDssIHdoaWNo
IHJldHVybnMgd2l0aCBBRV9OT1RfRVhJU1Q6PG86cD48L286cD48L3A+DQo8L2Rpdj4NCjxkaXY+
DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCIgc3R5bGU9Im1zby1tYXJnaW4tdG9wLWFsdDph
dXRvO21zby1tYXJnaW4tYm90dG9tLWFsdDphdXRvIj4tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS08bzpwPjwvbzpwPjwvcD4NCjwvZGl2Pg0KPC9kaXY+DQo8ZGl2Pg0KPGRp
dj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiIHN0eWxlPSJtc28tbWFyZ2luLXRvcC1hbHQ6YXV0bztt
c28tbWFyZ2luLWJvdHRvbS1hbHQ6YXV0byI+QUNQSSBFcnJvcjogTm8gaGFuZGxlciBmb3IgUmVn
aW9uIFtFQ09SXSAoODBkYTEzMCkgW0VtYmVkZGVkQ29udHJvbF0gKDIwMTcwMzAzL2V2cmVnaW9u
LTI5MSk8bzpwPjwvbzpwPjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwi
IHN0eWxlPSJtc28tbWFyZ2luLXRvcC1hbHQ6YXV0bzttc28tbWFyZ2luLWJvdHRvbS1hbHQ6YXV0
byI+QUNQSSBFcnJvcjogUmVnaW9uIEVtYmVkZGVkQ29udHJvbCAoSUQ9MykgaGFzIG5vIGhhbmRs
ZXIgKDIwMTcwMzAzL2V4ZmxkaW8tNDMxKTxvOnA+PC9vOnA+PC9wPg0KPC9kaXY+DQo8ZGl2Pg0K
PHAgY2xhc3M9Ik1zb05vcm1hbCIgc3R5bGU9Im1zby1tYXJnaW4tdG9wLWFsdDphdXRvO21zby1t
YXJnaW4tYm90dG9tLWFsdDphdXRvIj5BQ1BJIEVycm9yOiBNZXRob2QgcGFyc2UvZXhlY3V0aW9u
IGZhaWxlZCBbXF9TQi5QQ0kwLkxQQy5FQy5CQVQwLl9CU1RdIChOb2RlIDgwZDBiNzApLCBBRV9O
T1RfRVhJU1QgKDIwMTcwMzAzL3BzcGFyc2UtNjY4KTxvOnA+PC9vOnA+PC9wPg0KPC9kaXY+DQo8
ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCIgc3R5bGU9Im1zby1tYXJnaW4tdG9wLWFsdDphdXRv
O21zby1tYXJnaW4tYm90dG9tLWFsdDphdXRvIj4tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS08bzpwPjwvbzpwPjwvcD4NCjwvZGl2Pg0KPC9kaXY+DQo8ZGl2Pg0KPHAgY2xh
c3M9Ik1zb05vcm1hbCIgc3R5bGU9Im1zby1tYXJnaW4tdG9wLWFsdDphdXRvO21zby1tYXJnaW4t
Ym90dG9tLWFsdDphdXRvIj4mbmJzcDs8bzpwPjwvbzpwPjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxw
IGNsYXNzPSJNc29Ob3JtYWwiIHN0eWxlPSJtc28tbWFyZ2luLXRvcC1hbHQ6YXV0bzttc28tbWFy
Z2luLWJvdHRvbS1hbHQ6YXV0byI+VGhpcyBpcyB0aGUgb3V0cHV0IGZyb20gZXhlY3V0aW5nIHRo
ZSBjb250cm9sIG1ldGhvZCB1c2luZyBhY3BpZXhlYzo8bzpwPjwvbzpwPjwvcD4NCjwvZGl2Pg0K
PGRpdj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIiBzdHlsZT0ibXNvLW1hcmdpbi10b3At
YWx0OmF1dG87bXNvLW1hcmdpbi1ib3R0b20tYWx0OmF1dG8iPi0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLTxvOnA+PC9vOnA+PC9wPg0KPC9kaXY+DQo8ZGl2Pg0KPHAgY2xh
c3M9Ik1zb05vcm1hbCIgc3R5bGU9Im1zby1tYXJnaW4tdG9wLWFsdDphdXRvO21zby1tYXJnaW4t
Ym90dG9tLWFsdDphdXRvIj4jIC4vYWNwaWV4ZWMgKi5kYXQ8bzpwPjwvbzpwPjwvcD4NCjwvZGl2
Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiIHN0eWxlPSJtc28tbWFyZ2luLXRvcC1hbHQ6
YXV0bzttc28tbWFyZ2luLWJvdHRvbS1hbHQ6YXV0byI+Jm5ic3A7PG86cD48L286cD48L3A+DQo8
L2Rpdj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIiBzdHlsZT0ibXNvLW1hcmdpbi10b3At
YWx0OmF1dG87bXNvLW1hcmdpbi1ib3R0b20tYWx0OmF1dG8iPiZuYnNwOzxvOnA+PC9vOnA+PC9w
Pg0KPC9kaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCIgc3R5bGU9Im1zby1tYXJnaW4t
dG9wLWFsdDphdXRvO21zby1tYXJnaW4tYm90dG9tLWFsdDphdXRvIj5JbnRlbCBBQ1BJIENvbXBv
bmVudCBBcmNoaXRlY3R1cmU8bzpwPjwvbzpwPjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNz
PSJNc29Ob3JtYWwiIHN0eWxlPSJtc28tbWFyZ2luLXRvcC1hbHQ6YXV0bzttc28tbWFyZ2luLWJv
dHRvbS1hbHQ6YXV0byI+QU1MIEV4ZWN1dGlvbi9EZWJ1ZyBVdGlsaXR5IHZlcnNpb24gMjAxNzAz
MDM8bzpwPjwvbzpwPjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiIHN0
eWxlPSJtc28tbWFyZ2luLXRvcC1hbHQ6YXV0bzttc28tbWFyZ2luLWJvdHRvbS1hbHQ6YXV0byI+
Q29weXJpZ2h0IChjKSAyMDAwIC0gMjAxNyBJbnRlbCBDb3Jwb3JhdGlvbjxvOnA+PC9vOnA+PC9w
Pg0KPC9kaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCIgc3R5bGU9Im1zby1tYXJnaW4t
dG9wLWFsdDphdXRvO21zby1tYXJnaW4tYm90dG9tLWFsdDphdXRvIj4mbmJzcDs8bzpwPjwvbzpw
PjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiIHN0eWxlPSJtc28tbWFy
Z2luLXRvcC1hbHQ6YXV0bzttc28tbWFyZ2luLWJvdHRvbS1hbHQ6YXV0byI+SW5wdXQgZmlsZSBh
cGljLmRhdCwgTGVuZ3RoIDB4QkMgKDE4OCkgYnl0ZXM8bzpwPjwvbzpwPjwvcD4NCjwvZGl2Pg0K
PGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiIHN0eWxlPSJtc28tbWFyZ2luLXRvcC1hbHQ6YXV0
bzttc28tbWFyZ2luLWJvdHRvbS1hbHQ6YXV0byI+SW5wdXQgZmlsZSBhc2YhLmRhdCwgTGVuZ3Ro
IDB4QTUgKDE2NSkgYnl0ZXM8bzpwPjwvbzpwPjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNz
PSJNc29Ob3JtYWwiIHN0eWxlPSJtc28tbWFyZ2luLXRvcC1hbHQ6YXV0bzttc28tbWFyZ2luLWJv
dHRvbS1hbHQ6YXV0byI+SW5wdXQgZmlsZSBiYXRiLmRhdCwgTGVuZ3RoIDB4NDYgKDcwKSBieXRl
czxvOnA+PC9vOnA+PC9wPg0KPC9kaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCIgc3R5
bGU9Im1zby1tYXJnaW4tdG9wLWFsdDphdXRvO21zby1tYXJnaW4tYm90dG9tLWFsdDphdXRvIj5J
bnB1dCBmaWxlIGJvb3QuZGF0LCBMZW5ndGggMHgyOCAoNDApIGJ5dGVzPG86cD48L286cD48L3A+
DQo8L2Rpdj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIiBzdHlsZT0ibXNvLW1hcmdpbi10
b3AtYWx0OmF1dG87bXNvLW1hcmdpbi1ib3R0b20tYWx0OmF1dG8iPklucHV0IGZpbGUgZGJnMi5k
YXQsIExlbmd0aCAweDU0ICg4NCkgYnl0ZXM8bzpwPjwvbzpwPjwvcD4NCjwvZGl2Pg0KPGRpdj4N
CjxwIGNsYXNzPSJNc29Ob3JtYWwiIHN0eWxlPSJtc28tbWFyZ2luLXRvcC1hbHQ6YXV0bzttc28t
bWFyZ2luLWJvdHRvbS1hbHQ6YXV0byI+SW5wdXQgZmlsZSBkYmdwLmRhdCwgTGVuZ3RoIDB4MzQg
KDUyKSBieXRlczxvOnA+PC9vOnA+PC9wPg0KPC9kaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05v
cm1hbCIgc3R5bGU9Im1zby1tYXJnaW4tdG9wLWFsdDphdXRvO21zby1tYXJnaW4tYm90dG9tLWFs
dDphdXRvIj5JbnB1dCBmaWxlIGRzZHQuZGF0LCBMZW5ndGggMHgxMTQ1MSAoNzA3MzcpIGJ5dGVz
PG86cD48L286cD48L3A+DQo8L2Rpdj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIiBzdHls
ZT0ibXNvLW1hcmdpbi10b3AtYWx0OmF1dG87bXNvLW1hcmdpbi1ib3R0b20tYWx0OmF1dG8iPklu
cHV0IGZpbGUgZWNkdC5kYXQsIExlbmd0aCAweDUyICg4MikgYnl0ZXM8bzpwPjwvbzpwPjwvcD4N
CjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiIHN0eWxlPSJtc28tbWFyZ2luLXRv
cC1hbHQ6YXV0bzttc28tbWFyZ2luLWJvdHRvbS1hbHQ6YXV0byI+SW5wdXQgZmlsZSBmYWNwLmRh
dCwgTGVuZ3RoIDB4RjQgKDI0NCkgYnl0ZXM8bzpwPjwvbzpwPjwvcD4NCjwvZGl2Pg0KPGRpdj4N
CjxwIGNsYXNzPSJNc29Ob3JtYWwiIHN0eWxlPSJtc28tbWFyZ2luLXRvcC1hbHQ6YXV0bzttc28t
bWFyZ2luLWJvdHRvbS1hbHQ6YXV0byI+SW5wdXQgZmlsZSBmYWNzLmRhdCwgTGVuZ3RoIDB4NDAg
KDY0KSBieXRlczxvOnA+PC9vOnA+PC9wPg0KPC9kaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05v
cm1hbCIgc3R5bGU9Im1zby1tYXJnaW4tdG9wLWFsdDphdXRvO21zby1tYXJnaW4tYm90dG9tLWFs
dDphdXRvIj5JbnB1dCBmaWxlIGZwZHQuZGF0LCBMZW5ndGggMHg0NCAoNjgpIGJ5dGVzPG86cD48
L286cD48L3A+DQo8L2Rpdj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIiBzdHlsZT0ibXNv
LW1hcmdpbi10b3AtYWx0OmF1dG87bXNvLW1hcmdpbi1ib3R0b20tYWx0OmF1dG8iPklucHV0IGZp
bGUgaHBldC5kYXQsIExlbmd0aCAweDM4ICg1NikgYnl0ZXM8bzpwPjwvbzpwPjwvcD4NCjwvZGl2
Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiIHN0eWxlPSJtc28tbWFyZ2luLXRvcC1hbHQ6
YXV0bzttc28tbWFyZ2luLWJvdHRvbS1hbHQ6YXV0byI+SW5wdXQgZmlsZSBscGl0LmRhdCwgTGVu
Z3RoIDB4OTQgKDE0OCkgYnl0ZXM8bzpwPjwvbzpwPjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNs
YXNzPSJNc29Ob3JtYWwiIHN0eWxlPSJtc28tbWFyZ2luLXRvcC1hbHQ6YXV0bzttc28tbWFyZ2lu
LWJvdHRvbS1hbHQ6YXV0byI+SW5wdXQgZmlsZSBtY2ZnLmRhdCwgTGVuZ3RoIDB4M0MgKDYwKSBi
eXRlczxvOnA+PC9vOnA+PC9wPg0KPC9kaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCIg
c3R5bGU9Im1zby1tYXJnaW4tdG9wLWFsdDphdXRvO21zby1tYXJnaW4tYm90dG9tLWFsdDphdXRv
Ij5JbnB1dCBmaWxlIG1zZG0uZGF0LCBMZW5ndGggMHg1NSAoODUpIGJ5dGVzPG86cD48L286cD48
L3A+DQo8L2Rpdj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIiBzdHlsZT0ibXNvLW1hcmdp
bi10b3AtYWx0OmF1dG87bXNvLW1hcmdpbi1ib3R0b20tYWx0OmF1dG8iPklucHV0IGZpbGUgc2xp
Yy5kYXQsIExlbmd0aCAweDE3NiAoMzc0KSBieXRlczxvOnA+PC9vOnA+PC9wPg0KPC9kaXY+DQo8
ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCIgc3R5bGU9Im1zby1tYXJnaW4tdG9wLWFsdDphdXRv
O21zby1tYXJnaW4tYm90dG9tLWFsdDphdXRvIj5JbnB1dCBmaWxlIHNzZHQxLmRhdCwgTGVuZ3Ro
IDB4NEUwQSAoMTk5NzgpIGJ5dGVzPG86cD48L286cD48L3A+DQo8L2Rpdj4NCjxkaXY+DQo8cCBj
bGFzcz0iTXNvTm9ybWFsIiBzdHlsZT0ibXNvLW1hcmdpbi10b3AtYWx0OmF1dG87bXNvLW1hcmdp
bi1ib3R0b20tYWx0OmF1dG8iPklucHV0IGZpbGUgc3NkdDIuZGF0LCBMZW5ndGggMHgxQUZDICg2
OTA4KSBieXRlczxvOnA+PC9vOnA+PC9wPg0KPC9kaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05v
cm1hbCIgc3R5bGU9Im1zby1tYXJnaW4tdG9wLWFsdDphdXRvO21zby1tYXJnaW4tYm90dG9tLWFs
dDphdXRvIj5JbnB1dCBmaWxlIHNzZHQzLmRhdCwgTGVuZ3RoIDB4RTU4ICgzNjcyKSBieXRlczxv
OnA+PC9vOnA+PC9wPg0KPC9kaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCIgc3R5bGU9
Im1zby1tYXJnaW4tdG9wLWFsdDphdXRvO21zby1tYXJnaW4tYm90dG9tLWFsdDphdXRvIj5JbnB1
dCBmaWxlIHNzZHQ0LmRhdCwgTGVuZ3RoIDB4M0Q5ICg5ODUpIGJ5dGVzPG86cD48L286cD48L3A+
DQo8L2Rpdj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIiBzdHlsZT0ibXNvLW1hcmdpbi10
b3AtYWx0OmF1dG87bXNvLW1hcmdpbi1ib3R0b20tYWx0OmF1dG8iPklucHV0IGZpbGUgdWVmaTEu
ZGF0LCBMZW5ndGggMHg0MiAoNjYpIGJ5dGVzPG86cD48L286cD48L3A+DQo8L2Rpdj4NCjxkaXY+
DQo8cCBjbGFzcz0iTXNvTm9ybWFsIiBzdHlsZT0ibXNvLW1hcmdpbi10b3AtYWx0OmF1dG87bXNv
LW1hcmdpbi1ib3R0b20tYWx0OmF1dG8iPklucHV0IGZpbGUgdWVmaTIuZGF0LCBMZW5ndGggMHgx
MkEgKDI5OCkgYnl0ZXM8bzpwPjwvbzpwPjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJN
c29Ob3JtYWwiIHN0eWxlPSJtc28tbWFyZ2luLXRvcC1hbHQ6YXV0bzttc28tbWFyZ2luLWJvdHRv
bS1hbHQ6YXV0byI+SW5wdXQgZmlsZSB3ZGF0LmRhdCwgTGVuZ3RoIDB4MTM0ICgzMDgpIGJ5dGVz
PG86cD48L286cD48L3A+DQo8L2Rpdj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIiBzdHls
ZT0ibXNvLW1hcmdpbi10b3AtYWx0OmF1dG87bXNvLW1hcmdpbi1ib3R0b20tYWx0OmF1dG8iPklu
cHV0IGZpbGUgeHNkdC5kYXQsIExlbmd0aCAweENDICgyMDQpIGJ5dGVzPG86cD48L286cD48L3A+
DQo8L2Rpdj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIiBzdHlsZT0ibXNvLW1hcmdpbi10
b3AtYWx0OmF1dG87bXNvLW1hcmdpbi1ib3R0b20tYWx0OmF1dG8iPiZuYnNwOzxvOnA+PC9vOnA+
PC9wPg0KPC9kaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCIgc3R5bGU9Im1zby1tYXJn
aW4tdG9wLWFsdDphdXRvO21zby1tYXJnaW4tYm90dG9tLWFsdDphdXRvIj5BQ1BJOiBSU0RQIDB4
MDAwMDAwMDAwODBEQkNFMCAwMDAwMjQgKHYwMiBJbnRlbCApPG86cD48L286cD48L3A+DQo8L2Rp
dj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIiBzdHlsZT0ibXNvLW1hcmdpbi10b3AtYWx0
OmF1dG87bXNvLW1hcmdpbi1ib3R0b20tYWx0OmF1dG8iPkFDUEk6IFhTRFQgMHgwMDAwMDAwMDA4
MEU3OEM4IDAwMDBFNCAodjAwIEludGVsICZuYnNwO0FjcGlFeGVjIDAwMDAxMDAxIElOVEwgMjAx
NzAzMDMpPG86cD48L286cD48L3A+DQo8L2Rpdj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFs
IiBzdHlsZT0ibXNvLW1hcmdpbi10b3AtYWx0OmF1dG87bXNvLW1hcmdpbi1ib3R0b20tYWx0OmF1
dG8iPkFDUEk6IEZBQ1AgMHgwMDAwMDAwMDA4MEVBNTUwIDAwMDBGNCAodjA1IExFTk9WTyBUUC1S
MDAgJm5ic3A7IDAwMDAwNDIwIFBURUMgMDAwMDAwMDIpPG86cD48L286cD48L3A+DQo8L2Rpdj4N
CjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIiBzdHlsZT0ibXNvLW1hcmdpbi10b3AtYWx0OmF1
dG87bXNvLW1hcmdpbi1ib3R0b20tYWx0OmF1dG8iPkFDUEk6IERTRFQgMHgwMDAwMDAwMDA4MEVG
MDIwIDAxMTQ1MSAodjAyIExFTk9WTyBUUC1SMDAgJm5ic3A7IDAwMDAwNDIwIElOVEwgMjAxNDEx
MDcpPG86cD48L286cD48L3A+DQo8L2Rpdj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIiBz
dHlsZT0ibXNvLW1hcmdpbi10b3AtYWx0OmF1dG87bXNvLW1hcmdpbi1ib3R0b20tYWx0OmF1dG8i
PkFDUEk6IEZBQ1MgMHgwMDAwMDAwMDA4MERCRDIwIDAwMDA0MDxvOnA+PC9vOnA+PC9wPg0KPC9k
aXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCIgc3R5bGU9Im1zby1tYXJnaW4tdG9wLWFs
dDphdXRvO21zby1tYXJnaW4tYm90dG9tLWFsdDphdXRvIj5BQ1BJOiBBUElDIDB4MDAwMDAwMDAw
ODBFQTcwOCAwMDAwQkMgKHYwMyBMRU5PVk8gVFAtUjAwICZuYnNwOyAwMDAwMDQyMCBQVEVDIDAw
MDAwMDAyKTxvOnA+PC9vOnA+PC9wPg0KPC9kaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1h
bCIgc3R5bGU9Im1zby1tYXJnaW4tdG9wLWFsdDphdXRvO21zby1tYXJnaW4tYm90dG9tLWFsdDph
dXRvIj5BQ1BJOiBBU0YhIDB4MDAwMDAwMDAwODBFQTY1MCAwMDAwQTUgKHYzMiBMRU5PVk8gVFAt
UjAwICZuYnNwOyAwMDAwMDQyMCBQVEVDIDAwMDAwMDAyKTxvOnA+PC9vOnA+PC9wPg0KPC9kaXY+
DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCIgc3R5bGU9Im1zby1tYXJnaW4tdG9wLWFsdDph
dXRvO21zby1tYXJnaW4tYm90dG9tLWFsdDphdXRvIj5BQ1BJOiBCQVRCIDB4MDAwMDAwMDAwODBF
MzBBOCAwMDAwNDYgKHYwMSBMRU5PVk8gVFAtUjAwICZuYnNwOyAwMDAwMDQyMCBQVEVDIDAwMDAw
MDAyKTxvOnA+PC9vOnA+PC9wPg0KPC9kaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCIg
c3R5bGU9Im1zby1tYXJnaW4tdG9wLWFsdDphdXRvO21zby1tYXJnaW4tYm90dG9tLWFsdDphdXRv
Ij5BQ1BJOiBCT09UIDB4MDAwMDAwMDAwODBFMDFEOCAwMDAwMjggKHYwMSBMRU5PVk8gVFAtUjAw
ICZuYnNwOyAwMDAwMDQyMCBQVEVDIDAwMDAwMDAyKTxvOnA+PC9vOnA+PC9wPg0KPC9kaXY+DQo8
ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCIgc3R5bGU9Im1zby1tYXJnaW4tdG9wLWFsdDphdXRv
O21zby1tYXJnaW4tYm90dG9tLWFsdDphdXRvIj5BQ1BJOiBEQkcyIDB4MDAwMDAwMDAwODBFMjFG
MCAwMDAwNTQgKHYwMCBMRU5PVk8gVFAtUjAwICZuYnNwOyAwMDAwMDQyMCBQVEVDIDAwMDAwMDAy
KTxvOnA+PC9vOnA+PC9wPg0KPC9kaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCIgc3R5
bGU9Im1zby1tYXJnaW4tdG9wLWFsdDphdXRvO21zby1tYXJnaW4tYm90dG9tLWFsdDphdXRvIj5B
Q1BJOiBEQkdQIDB4MDAwMDAwMDAwODBFMTJEOCAwMDAwMzQgKHYwMSBMRU5PVk8gVFAtUjAwICZu
YnNwOyAwMDAwMDQyMCBQVEVDIDAwMDAwMDAyKTxvOnA+PC9vOnA+PC9wPg0KPC9kaXY+DQo8ZGl2
Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCIgc3R5bGU9Im1zby1tYXJnaW4tdG9wLWFsdDphdXRvO21z
by1tYXJnaW4tYm90dG9tLWFsdDphdXRvIj5BQ1BJOiBFQ0RUIDB4MDAwMDAwMDAwODBFMjI1OCAw
MDAwNTIgKHYwMSBMRU5PVk8gVFAtUjAwICZuYnNwOyAwMDAwMDQyMCBQVEVDIDAwMDAwMDAyKTxv
OnA+PC9vOnA+PC9wPg0KPC9kaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCIgc3R5bGU9
Im1zby1tYXJnaW4tdG9wLWFsdDphdXRvO21zby1tYXJnaW4tYm90dG9tLWFsdDphdXRvIj5BQ1BJ
OiBGQUNTIDB4MDAwMDAwMDAwODBFMTMyMCAwMDAwNDA8bzpwPjwvbzpwPjwvcD4NCjwvZGl2Pg0K
PGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiIHN0eWxlPSJtc28tbWFyZ2luLXRvcC1hbHQ6YXV0
bzttc28tbWFyZ2luLWJvdHRvbS1hbHQ6YXV0byI+QUNQSTogRlBEVCAweDAwMDAwMDAwMDgwRTMx
MDAgMDAwMDQ0ICh2MDEgTEVOT1ZPIFRQLVIwMCAmbmJzcDsgMDAwMDA0MjAgUFRFQyAwMDAwMDAw
Mik8bzpwPjwvbzpwPjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiIHN0
eWxlPSJtc28tbWFyZ2luLXRvcC1hbHQ6YXV0bzttc28tbWFyZ2luLWJvdHRvbS1hbHQ6YXV0byI+
QUNQSTogSFBFVCAweDAwMDAwMDAwMDgwRTEzNjggMDAwMDM4ICh2MDEgTEVOT1ZPIFRQLVIwMCAm
bmJzcDsgMDAwMDA0MjAgUFRFQyAwMDAwMDAwMik8bzpwPjwvbzpwPjwvcD4NCjwvZGl2Pg0KPGRp
dj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiIHN0eWxlPSJtc28tbWFyZ2luLXRvcC1hbHQ6YXV0bztt
c28tbWFyZ2luLWJvdHRvbS1hbHQ6YXV0byI+QUNQSTogTFBJVCAweDAwMDAwMDAwMDgwRUE0QjAg
MDAwMDk0ICh2MDEgTEVOT1ZPIFRQLVIwMCAmbmJzcDsgMDAwMDA0MjAgUFRFQyAwMDAwMDAwMik8
bzpwPjwvbzpwPjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiIHN0eWxl
PSJtc28tbWFyZ2luLXRvcC1hbHQ6YXV0bzttc28tbWFyZ2luLWJvdHRvbS1hbHQ6YXV0byI+QUNQ
STogTUNGRyAweDAwMDAwMDAwMDgwRTEzQjAgMDAwMDNDICh2MDEgTEVOT1ZPIFRQLVIwMCAmbmJz
cDsgMDAwMDA0MjAgUFRFQyAwMDAwMDAwMik8bzpwPjwvbzpwPjwvcD4NCjwvZGl2Pg0KPGRpdj4N
CjxwIGNsYXNzPSJNc29Ob3JtYWwiIHN0eWxlPSJtc28tbWFyZ2luLXRvcC1hbHQ6YXV0bzttc28t
bWFyZ2luLWJvdHRvbS1hbHQ6YXV0byI+QUNQSTogTVNETSAweDAwMDAwMDAwMDgwRTIyQzAgMDAw
MDU1ICh2MDMgTEVOT1ZPIFRQLVIwMCAmbmJzcDsgMDAwMDA0MjAgUFRFQyAwMDAwMDAwMik8bzpw
PjwvbzpwPjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiIHN0eWxlPSJt
c28tbWFyZ2luLXRvcC1hbHQ6YXV0bzttc28tbWFyZ2luLWJvdHRvbS1hbHQ6YXV0byI+QUNQSTog
U0xJQyAweDAwMDAwMDAwMDgwRUEzMjggMDAwMTc2ICh2MDEgTEVOT1ZPIFRQLVIwMCAmbmJzcDsg
MDAwMDA0MjAgUFRFQyAwMDAwMDAwMik8bzpwPjwvbzpwPjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxw
IGNsYXNzPSJNc29Ob3JtYWwiIHN0eWxlPSJtc28tbWFyZ2luLXRvcC1hbHQ6YXV0bzttc28tbWFy
Z2luLWJvdHRvbS1hbHQ6YXV0byI+QUNQSTogU1NEVCAweDAwMDAwMDAwMDgxMDEwMjAgMDA0RTBB
ICh2MDIgTEVOT1ZPIFNhU3NkdCAmbmJzcDsgMDAwMDMwMDAgSU5UTCAyMDE0MTEwNyk8bzpwPjwv
bzpwPjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiIHN0eWxlPSJtc28t
bWFyZ2luLXRvcC1hbHQ6YXV0bzttc28tbWFyZ2luLWJvdHRvbS1hbHQ6YXV0byI+QUNQSTogU1NE
VCAweDAwMDAwMDAwMDgwRTg4MjAgMDAxQUZDICh2MDEgTEVOT1ZPIFNhdGFBaGNpIDAwMDAxMDAw
IElOVEwgMjAxNDExMDcpPG86cD48L286cD48L3A+DQo8L2Rpdj4NCjxkaXY+DQo8cCBjbGFzcz0i
TXNvTm9ybWFsIiBzdHlsZT0ibXNvLW1hcmdpbi10b3AtYWx0OmF1dG87bXNvLW1hcmdpbi1ib3R0
b20tYWx0OmF1dG8iPkFDUEk6IFNTRFQgMHgwMDAwMDAwMDA4MEU3OUI4IDAwMEU1OCAodjAyIExF
Tk9WTyBDcHVTc2R0ICZuYnNwOzAwMDAzMDAwIElOVEwgMjAxNDExMDcpPG86cD48L286cD48L3A+
DQo8L2Rpdj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIiBzdHlsZT0ibXNvLW1hcmdpbi10
b3AtYWx0OmF1dG87bXNvLW1hcmdpbi1ib3R0b20tYWx0OmF1dG8iPkFDUEk6IFNTRFQgMHgwMDAw
MDAwMDA4MEVBN0QwIDAwMDNEOSAodjAyIExFTk9WTyBDdGRwQiAmbmJzcDsgJm5ic3A7MDAwMDEw
MDAgSU5UTCAyMDE0MTEwNyk8bzpwPjwvbzpwPjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNz
PSJNc29Ob3JtYWwiIHN0eWxlPSJtc28tbWFyZ2luLXRvcC1hbHQ6YXV0bzttc28tbWFyZ2luLWJv
dHRvbS1hbHQ6YXV0byI+QUNQSTogVUVGSSAweDAwMDAwMDAwMDgwRTMxNTggMDAwMDQyICh2MDEg
TEVOT1ZPIFRQLVIwMCAmbmJzcDsgMDAwMDA0MjAgUFRFQyAwMDAwMDAwMik8bzpwPjwvbzpwPjwv
cD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiIHN0eWxlPSJtc28tbWFyZ2lu
LXRvcC1hbHQ6YXV0bzttc28tbWFyZ2luLWJvdHRvbS1hbHQ6YXV0byI+QUNQSTogVUVGSSAweDAw
MDAwMDAwMDgwRTc0NzAgMDAwMTJBICh2MDEgTEVOT1ZPIFRQLVIwMCAmbmJzcDsgMDAwMDA0MjAg
UFRFQyAwMDAwMDAwMik8bzpwPjwvbzpwPjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJN
c29Ob3JtYWwiIHN0eWxlPSJtc28tbWFyZ2luLXRvcC1hbHQ6YXV0bzttc28tbWFyZ2luLWJvdHRv
bS1hbHQ6YXV0byI+QUNQSTogV0RBVCAweDAwMDAwMDAwMDgwRTczMzAgMDAwMTM0ICh2MDEgTEVO
T1ZPIFRQLVIwMCAmbmJzcDsgMDAwMDA0MjAgUFRFQyAwMDAwMDAwMik8bzpwPjwvbzpwPjwvcD4N
CjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiIHN0eWxlPSJtc28tbWFyZ2luLXRv
cC1hbHQ6YXV0bzttc28tbWFyZ2luLWJvdHRvbS1hbHQ6YXV0byI+QUNQSTogWFNEVCAweDAwMDAw
MDAwMDgwRTcyMzAgMDAwMENDICh2MDEgTEVOT1ZPIFRQLVIwMCAmbmJzcDsgMDAwMDAwMDAgUFRF
QyAwMDAwMDAwMik8bzpwPjwvbzpwPjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29O
b3JtYWwiIHN0eWxlPSJtc28tbWFyZ2luLXRvcC1hbHQ6YXV0bzttc28tbWFyZ2luLWJvdHRvbS1h
bHQ6YXV0byI+SW5pdGlhbGl6aW5nIEdlbmVyYWwgUHVycG9zZSBFdmVudHMgKEdQRXMpOjxvOnA+
PC9vOnA+PC9wPg0KPC9kaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCIgc3R5bGU9Im1z
by1tYXJnaW4tdG9wLWFsdDphdXRvO21zby1tYXJnaW4tYm90dG9tLWFsdDphdXRvIj4mbmJzcDsg
Jm5ic3A7IEluaXRpYWxpemVkIEdQRSAwMCB0byA3RiBbX0dQRV0gMTYgcmVncyBvbiBpbnRlcnJ1
cHQgMHg5IChTQ0kpPG86cD48L286cD48L3A+DQo8L2Rpdj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNv
Tm9ybWFsIiBzdHlsZT0ibXNvLW1hcmdpbi10b3AtYWx0OmF1dG87bXNvLW1hcmdpbi1ib3R0b20t
YWx0OmF1dG8iPiZuYnNwOzxvOnA+PC9vOnA+PC9wPg0KPC9kaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9
Ik1zb05vcm1hbCIgc3R5bGU9Im1zby1tYXJnaW4tdG9wLWFsdDphdXRvO21zby1tYXJnaW4tYm90
dG9tLWFsdDphdXRvIj5Jbml0aWFsaXppbmcgTmFtZXNwYWNlIG9iamVjdHM6PG86cD48L286cD48
L3A+DQo8L2Rpdj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIiBzdHlsZT0ibXNvLW1hcmdp
bi10b3AtYWx0OmF1dG87bXNvLW1hcmdpbi1ib3R0b20tYWx0OmF1dG8iPlRhYmxlIFtEU0RUOiBU
UC1SMDAgJm5ic3A7XSAoaWQgMDEpIC0gMjc1NyBPYmplY3RzIHdpdGggJm5ic3A7NzYgRGV2aWNl
cywgJm5ic3A7NDAgUmVnaW9ucywgJm5ic3A7NTEwIE1ldGhvZHMgKDE0MC8zNzAvMjQgU2VyaWFs
L05vbi9DdnQpPG86cD48L286cD48L3A+DQo8L2Rpdj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9y
bWFsIiBzdHlsZT0ibXNvLW1hcmdpbi10b3AtYWx0OmF1dG87bXNvLW1hcmdpbi1ib3R0b20tYWx0
OmF1dG8iPlRhYmxlIFtTU0RUOiBTYVNzZHQgJm5ic3A7XSAoaWQgMDIpIC0gJm5ic3A7NTUyIE9i
amVjdHMgd2l0aCAmbmJzcDsxOCBEZXZpY2VzLCAmbmJzcDsyMCBSZWdpb25zLCAmbmJzcDsxMzEg
TWV0aG9kcyAoNDEvOTAvNyBTZXJpYWwvTm9uL0N2dCk8bzpwPjwvbzpwPjwvcD4NCjwvZGl2Pg0K
PGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiIHN0eWxlPSJtc28tbWFyZ2luLXRvcC1hbHQ6YXV0
bzttc28tbWFyZ2luLWJvdHRvbS1hbHQ6YXV0byI+VGFibGUgW1NTRFQ6IFNhdGFBaGNpXSAoaWQg
MDMpIC0gJm5ic3A7MTgzIE9iamVjdHMgd2l0aCAmbmJzcDsgOCBEZXZpY2VzLCAmbmJzcDsgMCBS
ZWdpb25zLCAmbmJzcDsgMzQgTWV0aG9kcyAoMjUvOS81IFNlcmlhbC9Ob24vQ3Z0KTxvOnA+PC9v
OnA+PC9wPg0KPC9kaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCIgc3R5bGU9Im1zby1t
YXJnaW4tdG9wLWFsdDphdXRvO21zby1tYXJnaW4tYm90dG9tLWFsdDphdXRvIj5UYWJsZSBbU1NE
VDogQ3B1U3NkdCBdIChpZCAwNCkgLSAmbmJzcDsxMTQgT2JqZWN0cyB3aXRoICZuYnNwOyAwIERl
dmljZXMsICZuYnNwOyAzIFJlZ2lvbnMsICZuYnNwOyAyOSBNZXRob2RzICgxMy8xNi8xMyBTZXJp
YWwvTm9uL0N2dCk8bzpwPjwvbzpwPjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29O
b3JtYWwiIHN0eWxlPSJtc28tbWFyZ2luLXRvcC1hbHQ6YXV0bzttc28tbWFyZ2luLWJvdHRvbS1h
bHQ6YXV0byI+VGFibGUgW1NTRFQ6IEN0ZHBCICZuYnNwOyBdIChpZCAwNSkgLSAmbmJzcDsgMzMg
T2JqZWN0cyB3aXRoICZuYnNwOyAwIERldmljZXMsICZuYnNwOyAxIFJlZ2lvbnMsICZuYnNwOyAm
bmJzcDs1IE1ldGhvZHMgKDIvMy8xIFNlcmlhbC9Ob24vQ3Z0KTxvOnA+PC9vOnA+PC9wPg0KPC9k
aXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCIgc3R5bGU9Im1zby1tYXJnaW4tdG9wLWFs
dDphdXRvO21zby1tYXJnaW4tYm90dG9tLWFsdDphdXRvIj5BQ1BJOiA1IEFDUEkgQU1MIHRhYmxl
cyBzdWNjZXNzZnVsbHkgYWNxdWlyZWQgYW5kIGxvYWRlZDxvOnA+PC9vOnA+PC9wPg0KPC9kaXY+
DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCIgc3R5bGU9Im1zby1tYXJnaW4tdG9wLWFsdDph
dXRvO21zby1tYXJnaW4tYm90dG9tLWFsdDphdXRvIj4mbmJzcDs8bzpwPjwvbzpwPjwvcD4NCjwv
ZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiIHN0eWxlPSJtc28tbWFyZ2luLXRvcC1h
bHQ6YXV0bzttc28tbWFyZ2luLWJvdHRvbS1hbHQ6YXV0byI+Q29tcGxldGluZyBSZWdpb24vRmll
bGQvQnVmZmVyL1BhY2thZ2UgaW5pdGlhbGl6YXRpb246PG86cD48L286cD48L3A+DQo8L2Rpdj4N
CjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIiBzdHlsZT0ibXNvLW1hcmdpbi10b3AtYWx0OmF1
dG87bXNvLW1hcmdpbi1ib3R0b20tYWx0OmF1dG8iPiZuYnNwOyAmbmJzcDsgSW5pdGlhbGl6ZWQg
NjMvNjQgUmVnaW9ucyA3MS83MSBGaWVsZHMgODgvODggQnVmZmVycyA4My84MyBQYWNrYWdlcyAo
MzY0OCBub2Rlcyk8bzpwPjwvbzpwPjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29O
b3JtYWwiIHN0eWxlPSJtc28tbWFyZ2luLXRvcC1hbHQ6YXV0bzttc28tbWFyZ2luLWJvdHRvbS1h
bHQ6YXV0byI+SW5pdGlhbGl6aW5nIERldmljZS9Qcm9jZXNzb3IvVGhlcm1hbCBvYmplY3RzIGFu
ZCBleGVjdXRpbmcgX0lOSS9fU1RBIG1ldGhvZHM6PG86cD48L286cD48L3A+DQo8L2Rpdj4NCjxk
aXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIiBzdHlsZT0ibXNvLW1hcmdpbi10b3AtYWx0OmF1dG87
bXNvLW1hcmdpbi1ib3R0b20tYWx0OmF1dG8iPltBY3BpRXhlY10gRXhjZXB0aW9uIEFFX0FNTF9J
TkZJTklURV9MT09QIGR1cmluZyBleGVjdXRpb24gb2YgbWV0aG9kIFtTTUlfXSBPcGNvZGUgW1do
aWxlXSBANDQ8bzpwPjwvbzpwPjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3Jt
YWwiIHN0eWxlPSJtc28tbWFyZ2luLXRvcC1hbHQ6YXV0bzttc28tbWFyZ2luLWJvdHRvbS1hbHQ6
YXV0byI+W1NNSV9dIEAwMDAzNCAjMDBBMjogJm5ic3A7V2hpbGUgKDxvOnA+PC9vOnA+PC9wPg0K
PC9kaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCIgc3R5bGU9Im1zby1tYXJnaW4tdG9w
LWFsdDphdXRvO21zby1tYXJnaW4tYm90dG9tLWFsdDphdXRvIj5ObyBMb2NhbCBWYXJpYWJsZXMg
YXJlIGluaXRpYWxpemVkIGZvciBtZXRob2QgW1NNSV9dPG86cD48L286cD48L3A+DQo8L2Rpdj4N
CjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIiBzdHlsZT0ibXNvLW1hcmdpbi10b3AtYWx0OmF1
dG87bXNvLW1hcmdpbi1ib3R0b20tYWx0OmF1dG8iPiZuYnNwOzxvOnA+PC9vOnA+PC9wPg0KPC9k
aXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCIgc3R5bGU9Im1zby1tYXJnaW4tdG9wLWFs
dDphdXRvO21zby1tYXJnaW4tYm90dG9tLWFsdDphdXRvIj5Jbml0aWFsaXplZCBBcmd1bWVudHMg
Zm9yIE1ldGhvZCBbU01JX106ICZuYnNwOygwIGFyZ3VtZW50cyBkZWZpbmVkIGZvciBtZXRob2Qg
aW52b2NhdGlvbik8bzpwPjwvbzpwPjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29O
b3JtYWwiIHN0eWxlPSJtc28tbWFyZ2luLXRvcC1hbHQ6YXV0bzttc28tbWFyZ2luLWJvdHRvbS1h
bHQ6YXV0byI+Jm5ic3A7ICZuYnNwOyBBcmcwOiAmbmJzcDsgODFlY2M0MCAmbHQ7T2JqJmd0OyAm
bmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyBJbnRlZ2VyIDAwMDAwMDAw
MDAwMDAwMDk8bzpwPjwvbzpwPjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3Jt
YWwiIHN0eWxlPSJtc28tbWFyZ2luLXRvcC1hbHQ6YXV0bzttc28tbWFyZ2luLWJvdHRvbS1hbHQ6
YXV0byI+Jm5ic3A7ICZuYnNwOyBBcmcxOiAmbmJzcDsgODFlY2EzOCAmbHQ7T2JqJmd0OyAmbmJz
cDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyBJbnRlZ2VyIDAwMDAwMDAwMDAw
MDAwMDE8bzpwPjwvbzpwPjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwi
IHN0eWxlPSJtc28tbWFyZ2luLXRvcC1hbHQ6YXV0bzttc28tbWFyZ2luLWJvdHRvbS1hbHQ6YXV0
byI+Jm5ic3A7ICZuYnNwOyBBcmcyOiAmbmJzcDsgODFlY2JkOCAmbHQ7T2JqJmd0OyAmbmJzcDsg
Jm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyBJbnRlZ2VyIDAwMDAwMDAwMDAwMDAw
MDA8bzpwPjwvbzpwPjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiIHN0
eWxlPSJtc28tbWFyZ2luLXRvcC1hbHQ6YXV0bzttc28tbWFyZ2luLWJvdHRvbS1hbHQ6YXV0byI+
Jm5ic3A7ICZuYnNwOyBBcmczOiAmbmJzcDsgODFlYzlkMCAmbHQ7T2JqJmd0OyAmbmJzcDsgJm5i
c3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyBJbnRlZ2VyIDAwMDAwMDAwMDAwMDAwMDA8
bzpwPjwvbzpwPjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiIHN0eWxl
PSJtc28tbWFyZ2luLXRvcC1hbHQ6YXV0bzttc28tbWFyZ2luLWJvdHRvbS1hbHQ6YXV0byI+Jm5i
c3A7ICZuYnNwOyBBcmc0OiAmbmJzcDsgODFlY2IwOCAmbHQ7T2JqJmd0OyAmbmJzcDsgJm5ic3A7
ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyBJbnRlZ2VyIDAwMDAwMDAwMDAwMDAwMDA8bzpw
PjwvbzpwPjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiIHN0eWxlPSJt
c28tbWFyZ2luLXRvcC1hbHQ6YXV0bzttc28tbWFyZ2luLWJvdHRvbS1hbHQ6YXV0byI+Jm5ic3A7
PG86cD48L286cD48L3A+DQo8L2Rpdj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIiBzdHls
ZT0ibXNvLW1hcmdpbi10b3AtYWx0OmF1dG87bXNvLW1hcmdpbi1ib3R0b20tYWx0OmF1dG8iPkFD
UEkgRXJyb3I6IE1ldGhvZCBwYXJzZS9leGVjdXRpb24gZmFpbGVkIFtcU01JXSAoTm9kZSA4MTRk
ZTQwKSwgQUVfQU1MX0lORklOSVRFX0xPT1AgKDIwMTcwMzAzL3BzcGFyc2UtNjY4KTxvOnA+PC9v
OnA+PC9wPg0KPC9kaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCIgc3R5bGU9Im1zby1t
YXJnaW4tdG9wLWFsdDphdXRvO21zby1tYXJnaW4tYm90dG9tLWFsdDphdXRvIj5BQ1BJIEVycm9y
OiBNZXRob2QgcGFyc2UvZXhlY3V0aW9uIGZhaWxlZCBbXFdHU1ZdIChOb2RlIDgxNGU5NzgpLCBB
RV9BTUxfSU5GSU5JVEVfTE9PUCAoMjAxNzAzMDMvcHNwYXJzZS02NjgpPG86cD48L286cD48L3A+
DQo8L2Rpdj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIiBzdHlsZT0ibXNvLW1hcmdpbi10
b3AtYWx0OmF1dG87bXNvLW1hcmdpbi1ib3R0b20tYWx0OmF1dG8iPkFDUEkgRXJyb3I6IE1ldGhv
ZCBwYXJzZS9leGVjdXRpb24gZmFpbGVkIFtcX1NCLlBDSTAuTFBDLkVDLkhLRVkuV0dJTl0gKE5v
ZGUgODE0MzgxMCksIEFFX0FNTF9JTkZJTklURV9MT09QICgyMDE3MDMwMy9wc3BhcnNlLTY2OCk8
bzpwPjwvbzpwPjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiIHN0eWxl
PSJtc28tbWFyZ2luLXRvcC1hbHQ6YXV0bzttc28tbWFyZ2luLWJvdHRvbS1hbHQ6YXV0byI+QUNQ
SSBFcnJvcjogTWV0aG9kIHBhcnNlL2V4ZWN1dGlvbiBmYWlsZWQgW1xfU0IuUENJMC5MUEMuRUMu
X0lOSV0gKE5vZGUgODEyMWFlMCksIEFFX0FNTF9JTkZJTklURV9MT09QICgyMDE3MDMwMy9wc3Bh
cnNlLTY2OCk8bzpwPjwvbzpwPjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3Jt
YWwiIHN0eWxlPSJtc28tbWFyZ2luLXRvcC1hbHQ6YXV0bzttc28tbWFyZ2luLWJvdHRvbS1hbHQ6
YXV0byI+QUNQSSBFeGNlcHRpb246IEFFX0FNTF9JTkZJTklURV9MT09QLCBkdXJpbmcgXF9TQi5Q
Q0kwLkxQQy5FQy5fSU5JIGV4ZWN1dGlvbiAoMjAxNzAzMDMvbnNpbml0LTgwNyk8bzpwPjwvbzpw
PjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiIHN0eWxlPSJtc28tbWFy
Z2luLXRvcC1hbHQ6YXV0bzttc28tbWFyZ2luLWJvdHRvbS1hbHQ6YXV0byI+Jm5ic3A7ICZuYnNw
OyBFeGVjdXRlZCAxNCBfSU5JIG1ldGhvZHMgcmVxdWlyaW5nIDEgX1NUQSBleGVjdXRpb25zIChl
eGFtaW5lZCAxMTMgb2JqZWN0cyk8bzpwPjwvbzpwPjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNs
YXNzPSJNc29Ob3JtYWwiIHN0eWxlPSJtc28tbWFyZ2luLXRvcC1hbHQ6YXV0bzttc28tbWFyZ2lu
LWJvdHRvbS1hbHQ6YXV0byI+LSBleGVjdXRlIFxfU0IuUENJMC5MUEMuRUMuQkFUMC5fQlNUPG86
cD48L286cD48L3A+DQo8L2Rpdj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIiBzdHlsZT0i
bXNvLW1hcmdpbi10b3AtYWx0OmF1dG87bXNvLW1hcmdpbi1ib3R0b20tYWx0OmF1dG8iPkV2YWx1
YXRpbmcgXF9TQi5QQ0kwLkxQQy5FQy5CQVQwLl9CU1Q8bzpwPjwvbzpwPjwvcD4NCjwvZGl2Pg0K
PGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiIHN0eWxlPSJtc28tbWFyZ2luLXRvcC1hbHQ6YXV0
bzttc28tbWFyZ2luLWJvdHRvbS1hbHQ6YXV0byI+MHg0IE91dHN0YW5kaW5nIGFsbG9jYXRpb25z
IGFmdGVyIGV2YWx1YXRpb24gb2YgXF9TQi5QQ0kwLkxQQy5FQy5CQVQwLl9CU1Q8bzpwPjwvbzpw
PjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiIHN0eWxlPSJtc28tbWFy
Z2luLXRvcC1hbHQ6YXV0bzttc28tbWFyZ2luLWJvdHRvbS1hbHQ6YXV0byI+RXZhbHVhdGlvbiBv
ZiBcX1NCLlBDSTAuTFBDLkVDLkJBVDAuX0JTVCByZXR1cm5lZCBvYmplY3QgODBlYWZmMCwgZXh0
ZXJuYWwgYnVmZmVyIGxlbmd0aCA3ODxvOnA+PC9vOnA+PC9wPg0KPC9kaXY+DQo8ZGl2Pg0KPHAg
Y2xhc3M9Ik1zb05vcm1hbCIgc3R5bGU9Im1zby1tYXJnaW4tdG9wLWFsdDphdXRvO21zby1tYXJn
aW4tYm90dG9tLWFsdDphdXRvIj4mbmJzcDsgW1BhY2thZ2VdIENvbnRhaW5zIDQgRWxlbWVudHM6
PG86cD48L286cD48L3A+DQo8L2Rpdj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIiBzdHls
ZT0ibXNvLW1hcmdpbi10b3AtYWx0OmF1dG87bXNvLW1hcmdpbi1ib3R0b20tYWx0OmF1dG8iPiZu
YnNwOyAmbmJzcDsgW0ludGVnZXJdID0gMDAwMDAwMDAwMDAwMDAwNDxvOnA+PC9vOnA+PC9wPg0K
PC9kaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCIgc3R5bGU9Im1zby1tYXJnaW4tdG9w
LWFsdDphdXRvO21zby1tYXJnaW4tYm90dG9tLWFsdDphdXRvIj4mbmJzcDsgJm5ic3A7IFtJbnRl
Z2VyXSA9IDAwMDAwMDAwMDAwMDAwMDA8bzpwPjwvbzpwPjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxw
IGNsYXNzPSJNc29Ob3JtYWwiIHN0eWxlPSJtc28tbWFyZ2luLXRvcC1hbHQ6YXV0bzttc28tbWFy
Z2luLWJvdHRvbS1hbHQ6YXV0byI+Jm5ic3A7ICZuYnNwOyBbSW50ZWdlcl0gPSAwMDAwMDAwMDAw
MDAwMDAwPG86cD48L286cD48L3A+DQo8L2Rpdj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFs
IiBzdHlsZT0ibXNvLW1hcmdpbi10b3AtYWx0OmF1dG87bXNvLW1hcmdpbi1ib3R0b20tYWx0OmF1
dG8iPiZuYnNwOyAmbmJzcDsgW0ludGVnZXJdID0gMDAwMDAwMDAwMDAwMDAwMDxvOnA+PC9vOnA+
PC9wPg0KPC9kaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCIgc3R5bGU9Im1zby1tYXJn
aW4tdG9wLWFsdDphdXRvO21zby1tYXJnaW4tYm90dG9tLWFsdDphdXRvIj4tIHE8bzpwPjwvbzpw
PjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiIHN0eWxlPSJtc28tbWFy
Z2luLXRvcC1hbHQ6YXV0bzttc28tbWFyZ2luLWJvdHRvbS1hbHQ6YXV0byI+LS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tPG86cD48L286cD48L3A+DQo8L2Rpdj4NCjwvZGl2
Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiIHN0eWxlPSJtc28tbWFyZ2luLXRvcC1hbHQ6
YXV0bzttc28tbWFyZ2luLWJvdHRvbS1hbHQ6YXV0byI+Jm5ic3A7PG86cD48L286cD48L3A+DQo8
L2Rpdj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIiBzdHlsZT0ibXNvLW1hcmdpbi10b3At
YWx0OmF1dG87bXNvLW1hcmdpbi1ib3R0b20tYWx0OmF1dG8iPk5vdGU6IEkgdHJpZWQgcnVubmlu
ZyBMaW51eCBvbiB0aGUgTGVub3ZvIGxhcHRvcCBhbmQgaXQgY2FuIHJlYWQgdGhlIGJhdHRlcnkg
c3RhdHVzIG9rLjxvOnA+PC9vOnA+PC9wPg0KPC9kaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05v
cm1hbCIgc3R5bGU9Im1zby1tYXJnaW4tdG9wLWFsdDphdXRvO21zby1tYXJnaW4tYm90dG9tLWFs
dDphdXRvIj4mbmJzcDs8bzpwPjwvbzpwPjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJN
c29Ob3JtYWwiIHN0eWxlPSJtc28tbWFyZ2luLXRvcC1hbHQ6YXV0bzttc28tbWFyZ2luLWJvdHRv
bS1hbHQ6YXV0byI+VGhhbmsgeW91LDxvOnA+PC9vOnA+PC9wPg0KPC9kaXY+DQo8ZGl2Pg0KPHAg
Y2xhc3M9Ik1zb05vcm1hbCIgc3R5bGU9Im1zby1tYXJnaW4tdG9wLWFsdDphdXRvO21zby1tYXJn
aW4tYm90dG9tLWFsdDphdXRvIj5EZXZpbjxvOnA+PC9vOnA+PC9wPg0KPC9kaXY+DQo8ZGl2Pg0K
PHAgY2xhc3M9Ik1zb05vcm1hbCIgc3R5bGU9Im1zby1tYXJnaW4tdG9wLWFsdDphdXRvO21zby1t
YXJnaW4tYm90dG9tLWFsdDphdXRvIj4mbmJzcDs8bzpwPjwvbzpwPjwvcD4NCjwvZGl2Pg0KPC9k
aXY+DQo8L2Rpdj4NCjwvZGl2Pg0KPC9kaXY+DQo8L2Rpdj4NCjwvZGl2Pg0KPC9ibG9ja3F1b3Rl
Pg0KPC9kaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj48bzpwPiZuYnNwOzwvbzpwPjwvcD4NCjwv
ZGl2Pg0KPC9kaXY+DQo8L2Rpdj4NCjwvZGl2Pg0KPC9ib2R5Pg0KPC9odG1sPg0K

--===============0613607338669573575==--

