Content-Type: multipart/mixed; boundary="===============8638766198116861347=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: Re: [Devel] Unable to boot in vmware 7
Date: Tue, 02 Mar 2010 09:14:38 -0800
Message-ID: <4911F71203A09E4D9981D27F9D83085859D37551@orsmsx503.amr.corp.intel.com>
In-Reply-To: SNT111-W18E3DB498C6E31271E926DBD3C0@phx.gbl
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============8638766198116861347==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


If this is the error you are talking about

ACPI Exception: AE_ERROR, Returned by Handler for [PCI_Config] (20091214/ev=
region-588)
ACPI Error (psparse-0633): Method parse/execution failed [\_SB_.PCI0.PEB7._=
STA] (Node B12E91D0), AE_ERROR

You'll need to debug the PCI_Config operation handler.


________________________________
From: devel-bounces(a)acpica.org [mailto:devel-bounces(a)acpica.org] On Beh=
alf Of Samuel Serapion
Sent: Monday, March 01, 2010 1:00 PM
To: devel(a)acpica.org
Subject: [Devel] Unable to boot in vmware 7


Hello, i've been developing a driver based on acpica and linux acpi for Rea=
ctOS, you can find the source code here: http://git.reactos.org/?p=3Dreacto=
s.git;a=3Dtree;f=3Dreactos/drivers/bus/acpi;hb=3DHEAD

However I have been unable to boot in vmware 7, you can find the acpica ini=
t sequence here: http://git.reactos.org/?p=3Dreactos.git;a=3Dblob;f=3Dreact=
os/drivers/bus/acpi/pnp.c;hb=3DHEAD#l270 . I have no idea whats going wrong=
, please help me debug this issue.


(ntoskrnl\kd\kdio.c:297) --------------------------------------------------=
---
(ntoskrnl\kd\kdio.c:298) ReactOS 0.4-SVN (Build 20100228-r45726)
(ntoskrnl\kd\kdio.c:299) Command Line: /NOGUIBOOT /DEBUGPORT=3DCOM1
(ntoskrnl\kd\kdio.c:303) ARC Paths: multi(0)disk(0)cdrom(159) \ multi(0)dis=
k(0)cdrom(159) \reactos\
(ntoskrnl\ke\i386\cpu.c:746) Prefetch Cache: 64 bytes   L2 Cache: 524288 by=
tes L2 Cache Line: 64 bytes  L2 Cache Associativity: 16
WARNING:  HalStopProfileInterrupt at hal\halx86\generic\profil.c:24 is UNIM=
PLEMENTED!
(ntoskrnl\mm\mminit.c:289)           0x80000000 - 0x81000000    Boot Loaded=
 Image
(ntoskrnl\mm\mminit.c:293)           0x81000000 - 0x87400000    Paged Pool
(ntoskrnl\mm\mminit.c:297)           0xB0000000 - 0xB0601000    PFN Database
(ntoskrnl\mm\mminit.c:301)           0xB0601000 - 0xB15C9000    ARM=C3=82=
=C2=B3 Non Paged Pool
(ntoskrnl\mm\mminit.c:305)           0xBC000000 - 0xBD000000    System View=
 Space
(ntoskrnl\mm\mminit.c:309)           0xBD000000 - 0xC0000000    Session Spa=
ce
(ntoskrnl\mm\mminit.c:312)           0xC0000000 - 0xC0300000    Page Tables
(ntoskrnl\mm\mminit.c:315)           0xC0300000 - 0xC0400000    Page Direct=
ories
(ntoskrnl\mm\mminit.c:318)           0xC0400000 - 0xC0800000    Hyperspace
(ntoskrnl\mm\mminit.c:322)           0xE1000000 - 0xF1000000    ARM=C3=82=
=C2=B3 Paged Pool
(ntoskrnl\mm\mminit.c:325)           0xF3400000 - 0xF8BA8000    System PTE =
Space
(ntoskrnl\mm\mminit.c:328)           0xF8BA8000 - 0xFFBE0000    Non Paged P=
ool Expansion PTE Space
(ntoskrnl\ke\i386\kiinit.c:53) Large Page support detected but not yet take=
n advantage of
(ntoskrnl\ke\i386\patpge.c:45) Global page support detected but not yet tak=
en advantage of
(ntoskrnl\ke\i386\patpge.c:58) PAT support detected but not yet taken advan=
tage of
(ntoskrnl\ke\i386\mtrr.c:24) MTRR support detected but not yet taken advant=
age of
PC Compatible Eisa/Isa HAL has been initialized
WARNING:  IoReportResourceUsage at ntoskrnl\io\iomgr\iorsrce.c:700 is UNIMP=
LEMENTED!
WARNING:  IoReportResourceUsage at ntoskrnl\io\iomgr\iorsrce.c:700 is UNIMP=
LEMENTED!
(ntoskrnl\io\iomgr\file.c:420) Using IopParseDevice() hack. Requested inval=
id attributes: 1
(ntoskrnl\fstub\disksup.c:253) ZwOpenSymbolicLinkObject failed for \ArcName=
\multi(0)disk(0)rdisk(1), status=3Dc0000034
(ntoskrnl\fstub\disksup.c:253) ZwOpenSymbolicLinkObject failed for \ArcName=
\multi(0)disk(0)rdisk(1), status=3Dc0000034
(drivers\bus\acpi\main.c:206) Driver Entry
(drivers\bus\acpi\main.c:36) Add Device: 0xB136C6F8
(drivers\bus\acpi\main.c:38) #################### Bus_CreateClose Creating =
FDO Device ####################
(drivers\bus\acpi\main.c:141) AddDevice: B134CC70 to B136C6F8->B136C6F8 (Ro=
ot\*PNP0C08\0000)
(drivers\bus\acpi\pnp.c:47) FDO IRP_MN_FILTER_RESOURCE_REQUIREMENTS IRP:0xB=
13579E0
(drivers\bus\acpi\pnp.c:47) FDO IRP_MN_START_DEVICE IRP:0xB13579E0
ACPI: RSDP 000F6940 00024 (v02 PTLTD )
ACPI: XSDT 1FEF0885 0004C (v01 INTEL  440BX    06040000 VMW  01324272)
ACPI: FACP 1FEFEE98 000F4 (v04 INTEL  440BX    06040000 PTL  000F4240)
ACPI: DSDT 1FEF0A3D 0E45B (v01 PTLTD  Custom   06040000 MSFT 03000001)
ACPI: FACS 1FEFFFC0 00040
ACPI: BOOT 1FEF0A15 00028 (v01 PTLTD  $SBFTBL$ 06040000  LTP 00000001)
ACPI: APIC 1FEF09C5 00050 (v01 PTLTD     APIC   06040000  LTP 00000000)
ACPI: MCFG 1FEF0989 0003C (v01 PTLTD  $PCITBL$ 06040000  LTP 00000001)
ACPI: SRAT 1FEF0909 00080 (v02 VMWARE MEMPLUG  06040000 VMW  00000001)
(drivers\bus\acpi\pnp.c:306) Acpi subsystem init
(drivers\bus\acpi\busmgr\bus.c:1785) acpi_init(drivers\bus\acpi\busmgr\bus.=
c:1787) Subsystem revision 20091214
(drivers\bus\acpi\busmgr\bus.c:1667) acpi_bus_init(drivers\bus\acpi\busmgr\=
bus.c:1555) acpi_bus_init_irqACPI Exception: AE_ERROR, Returned by Handler =
for [PCI_Config] (20091214/evregion-588)
ACPI Error (psparse-0633): Method parse/execution failed [\_SB_.PCI0.P2P0._=
STA] (Node B12FFEF8), AE_ERROR
ACPI Exception: AE_ERROR, Returned by Handler for [PCI_Config] (20091214/ev=
region-588)
ACPI Error (psparse-0633): Method parse/execution failed [\_SB_.PCI0.P2P1._=
STA] (Node B13483A8), AE_ERROR
ACPI Exception: AE_ERROR, Returned by Handler for [PCI_Config] (20091214/ev=
region-588)
ACPI Error (psparse-0633): Method parse/execution failed [\_SB_.PCI0.P2P2._=
STA] (Node B1346848), AE_ERROR
ACPI Exception: AE_ERROR, Returned by Handler for [PCI_Config] (20091214/ev=
region-588)
ACPI Error (psparse-0633): Method parse/execution failed [\_SB_.PCI0.P2P3._=
STA] (Node B1344CF8), AE_ERROR
ACPI Exception: AE_ERROR, Returned by Handler for [PCI_Config] (20091214/ev=
region-588)
ACPI Error (psparse-0633): Method parse/execution failed [\_SB_.PCI0.PE40._=
STA] (Node B13421E8), AE_ERROR
ACPI Exception: AE_ERROR, Returned by Handler for [PCI_Config] (20091214/ev=
region-588)
ACPI Error (psparse-0633): Method parse/execution failed [\_SB_.PCI0.PE50._=
STA] (Node B1341D68), AE_ERROR
ACPI Exception: AE_ERROR, Returned by Handler for [PCI_Config] (20091214/ev=
region-588)
ACPI Error (psparse-0633): Method parse/execution failed [\_SB_.PCI0.PE60._=
STA] (Node B1341910), AE_ERROR
ACPI Exception: AE_ERROR, Returned by Handler for [PCI_Config] (20091214/ev=
region-588)
ACPI Error (psparse-0633): Method parse/execution failed [\_SB_.PCI0.PE70._=
STA] (Node B13414B8), AE_ERROR
ACPI Exception: AE_ERROR, Returned by Handler for [PCI_Config] (20091214/ev=
region-588)
ACPI Error (psparse-0633): Method parse/execution failed [\_SB_.PCI0.PE80._=
STA] (Node B1341060), AE_ERROR
ACPI Exception: AE_ERROR, Returned by Handler for [PCI_Config] (20091214/ev=
region-588)
ACPI Error (psparse-0633): Method parse/execution failed [\_SB_.PCI0.PE90._=
STA] (Node B1340C10), AE_ERROR
ACPI Exception: AE_ERROR, Returned by Handler for [PCI_Config] (20091214/ev=
region-588)
ACPI Error (psparse-0633): Method parse/execution failed [\_SB_.PCI0.PEA0._=
STA] (Node B13407B8), AE_ERROR
ACPI Exception: AE_ERROR, Returned by Handler for [PCI_Config] (20091214/ev=
region-588)
ACPI Error (psparse-0633): Method parse/execution failed [\_SB_.PCI0.PEB0._=
STA] (Node B1340360), AE_ERROR
ACPI Exception: AE_ERROR, Returned by Handler for [PCI_Config] (20091214/ev=
region-588)
ACPI Error (psparse-0633): Method parse/execution failed [\_SB_.PCI0.PEC0._=
STA] (Node B12F8ED8), AE_ERROR
ACPI Exception: AE_ERROR, Returned by Handler for [PCI_Config] (20091214/ev=
region-588)
ACPI Error (psparse-0633): Method parse/execution failed [\_SB_.PCI0.PED0._=
STA] (Node B12F8A80), AE_ERROR
ACPI Exception: AE_ERROR, Returned by Handler for [PCI_Config] (20091214/ev=
region-588)
ACPI Error (psparse-0633): Method parse/execution failed [\_SB_.PCI0.PEE0._=
STA] (Node B12F8628), AE_ERROR
ACPI Exception: AE_ERROR, Returned by Handler for [PCI_Config] (20091214/ev=
region-588)
ACPI Error (psparse-0633): Method parse/execution failed [\_SB_.PCI0.PE41._=
STA] (Node B12F81D0), AE_ERROR
ACPI Exception: AE_ERROR, Returned by Handler for [PCI_Config] (20091214/ev=
region-588)
ACPI Error (psparse-0633): Method parse/execution failed [\_SB_.PCI0.PE42._=
STA] (Node B12F7D68), AE_ERROR
ACPI Exception: AE_ERROR, Returned by Handler for [PCI_Config] (20091214/ev=
region-588)
ACPI Error (psparse-0633): Method parse/execution failed [\_SB_.PCI0.PE43._=
STA] (Node B12F7910), AE_ERROR
ACPI Exception: AE_ERROR, Returned by Handler for [PCI_Config] (20091214/ev=
region-588)
ACPI Error (psparse-0633): Method parse/execution failed [\_SB_.PCI0.PE44._=
STA] (Node B12F74B8), AE_ERROR
ACPI Exception: AE_ERROR, Returned by Handler for [PCI_Config] (20091214/ev=
region-588)
ACPI Error (psparse-0633): Method parse/execution failed [\_SB_.PCI0.PE45._=
STA] (Node B12F7060), AE_ERROR
ACPI Exception: AE_ERROR, Returned by Handler for [PCI_Config] (20091214/ev=
region-588)
ACPI Error (psparse-0633): Method parse/execution failed [\_SB_.PCI0.PE46._=
STA] (Node B12F6C10), AE_ERROR
ACPI Exception: AE_ERROR, Returned by Handler for [PCI_Config] (20091214/ev=
region-588)
ACPI Error (psparse-0633): Method parse/execution failed [\_SB_.PCI0.PE47._=
STA] (Node B12F67B8), AE_ERROR
ACPI Exception: AE_ERROR, Returned by Handler for [PCI_Config] (20091214/ev=
region-588)
ACPI Error (psparse-0633): Method parse/execution failed [\_SB_.PCI0.PE51._=
STA] (Node B12F6360), AE_ERROR
ACPI Exception: AE_ERROR, Returned by Handler for [PCI_Config] (20091214/ev=
region-588)
ACPI Error (psparse-0633): Method parse/execution failed [\_SB_.PCI0.PE52._=
STA] (Node B12F5ED8), AE_ERROR
ACPI Exception: AE_ERROR, Returned by Handler for [PCI_Config] (20091214/ev=
region-588)
ACPI Error (psparse-0633): Method parse/execution failed [\_SB_.PCI0.PE53._=
STA] (Node B12F5A80), AE_ERROR
ACPI Exception: AE_ERROR, Returned by Handler for [PCI_Config] (20091214/ev=
region-588)
ACPI Error (psparse-0633): Method parse/execution failed [\_SB_.PCI0.PE54._=
STA] (Node B12F5628), AE_ERROR
ACPI Exception: AE_ERROR, Returned by Handler for [PCI_Config] (20091214/ev=
region-588)
ACPI Error (psparse-0633): Method parse/execution failed [\_SB_.PCI0.PE55._=
STA] (Node B12F51D0), AE_ERROR
ACPI Exception: AE_ERROR, Returned by Handler for [PCI_Config] (20091214/ev=
region-588)
ACPI Error (psparse-0633): Method parse/execution failed [\_SB_.PCI0.PE56._=
STA] (Node B12F4D68), AE_ERROR
ACPI Exception: AE_ERROR, Returned by Handler for [PCI_Config] (20091214/ev=
region-588)
ACPI Error (psparse-0633): Method parse/execution failed [\_SB_.PCI0.PE57._=
STA] (Node B12F4910), AE_ERROR
ACPI Exception: AE_ERROR, Returned by Handler for [PCI_Config] (20091214/ev=
region-588)
ACPI Error (psparse-0633): Method parse/execution failed [\_SB_.PCI0.PE61._=
STA] (Node B12F44B8), AE_ERROR
ACPI Exception: AE_ERROR, Returned by Handler for [PCI_Config] (20091214/ev=
region-588)
ACPI Error (psparse-0633): Method parse/execution failed [\_SB_.PCI0.PE62._=
STA] (Node B12F4060), AE_ERROR
ACPI Exception: AE_ERROR, Returned by Handler for [PCI_Config] (20091214/ev=
region-588)
ACPI Error (psparse-0633): Method parse/execution failed [\_SB_.PCI0.PE63._=
STA] (Node B12F3C10), AE_ERROR
ACPI Exception: AE_ERROR, Returned by Handler for [PCI_Config] (20091214/ev=
region-588)
ACPI Error (psparse-0633): Method parse/execution failed [\_SB_.PCI0.PE64._=
STA] (Node B12F37B8), AE_ERROR
ACPI Exception: AE_ERROR, Returned by Handler for [PCI_Config] (20091214/ev=
region-588)
ACPI Error (psparse-0633): Method parse/execution failed [\_SB_.PCI0.PE65._=
STA] (Node B12F3360), AE_ERROR
ACPI Exception: AE_ERROR, Returned by Handler for [PCI_Config] (20091214/ev=
region-588)
ACPI Error (psparse-0633): Method parse/execution failed [\_SB_.PCI0.PE66._=
STA] (Node B12F2ED8), AE_ERROR
ACPI Exception: AE_ERROR, Returned by Handler for [PCI_Config] (20091214/ev=
region-588)
ACPI Error (psparse-0633): Method parse/execution failed [\_SB_.PCI0.PE67._=
STA] (Node B12F2A80), AE_ERROR
ACPI Exception: AE_ERROR, Returned by Handler for [PCI_Config] (20091214/ev=
region-588)
ACPI Error (psparse-0633): Method parse/execution failed [\_SB_.PCI0.PE71._=
STA] (Node B12F2628), AE_ERROR
ACPI Exception: AE_ERROR, Returned by Handler for [PCI_Config] (20091214/ev=
region-588)
ACPI Error (psparse-0633): Method parse/execution failed [\_SB_.PCI0.PE72._=
STA] (Node B12F21D0), AE_ERROR
ACPI Exception: AE_ERROR, Returned by Handler for [PCI_Config] (20091214/ev=
region-588)
ACPI Error (psparse-0633): Method parse/execution failed [\_SB_.PCI0.PE73._=
STA] (Node B12F1D68), AE_ERROR
ACPI Exception: AE_ERROR, Returned by Handler for [PCI_Config] (20091214/ev=
region-588)
ACPI Error (psparse-0633): Method parse/execution failed [\_SB_.PCI0.PE74._=
STA] (Node B12F1910), AE_ERROR
ACPI Exception: AE_ERROR, Returned by Handler for [PCI_Config] (20091214/ev=
region-588)
ACPI Error (psparse-0633): Method parse/execution failed [\_SB_.PCI0.PE75._=
STA] (Node B12F14B8), AE_ERROR
ACPI Exception: AE_ERROR, Returned by Handler for [PCI_Config] (20091214/ev=
region-588)
ACPI Error (psparse-0633): Method parse/execution failed [\_SB_.PCI0.PE76._=
STA] (Node B12F1060), AE_ERROR
ACPI Exception: AE_ERROR, Returned by Handler for [PCI_Config] (20091214/ev=
region-588)
ACPI Error (psparse-0633): Method parse/execution failed [\_SB_.PCI0.PE77._=
STA] (Node B12F0C10), AE_ERROR
ACPI Exception: AE_ERROR, Returned by Handler for [PCI_Config] (20091214/ev=
region-588)
ACPI Error (psparse-0633): Method parse/execution failed [\_SB_.PCI0.PE81._=
STA] (Node B12F07B8), AE_ERROR
ACPI Exception: AE_ERROR, Returned by Handler for [PCI_Config] (20091214/ev=
region-588)
ACPI Error (psparse-0633): Method parse/execution failed [\_SB_.PCI0.PE82._=
STA] (Node B12F0360), AE_ERROR
ACPI Exception: AE_ERROR, Returned by Handler for [PCI_Config] (20091214/ev=
region-588)
ACPI Error (psparse-0633): Method parse/execution failed [\_SB_.PCI0.PE83._=
STA] (Node B12EFED8), AE_ERROR
ACPI Exception: AE_ERROR, Returned by Handler for [PCI_Config] (20091214/ev=
region-588)
ACPI Error (psparse-0633): Method parse/execution failed [\_SB_.PCI0.PE84._=
STA] (Node B12EFA80), AE_ERROR
ACPI Exception: AE_ERROR, Returned by Handler for [PCI_Config] (20091214/ev=
region-588)
ACPI Error (psparse-0633): Method parse/execution failed [\_SB_.PCI0.PE85._=
STA] (Node B12EF628), AE_ERROR
ACPI Exception: AE_ERROR, Returned by Handler for [PCI_Config] (20091214/ev=
region-588)
ACPI Error (psparse-0633): Method parse/execution failed [\_SB_.PCI0.PE86._=
STA] (Node B12EF1D0), AE_ERROR
ACPI Exception: AE_ERROR, Returned by Handler for [PCI_Config] (20091214/ev=
region-588)
ACPI Error (psparse-0633): Method parse/execution failed [\_SB_.PCI0.PE87._=
STA] (Node B12EED68), AE_ERROR
ACPI Exception: AE_ERROR, Returned by Handler for [PCI_Config] (20091214/ev=
region-588)
ACPI Error (psparse-0633): Method parse/execution failed [\_SB_.PCI0.PE91._=
STA] (Node B12EE910), AE_ERROR
ACPI Exception: AE_ERROR, Returned by Handler for [PCI_Config] (20091214/ev=
region-588)
ACPI Error (psparse-0633): Method parse/execution failed [\_SB_.PCI0.PE92._=
STA] (Node B12EE4B8), AE_ERROR
ACPI Exception: AE_ERROR, Returned by Handler for [PCI_Config] (20091214/ev=
region-588)
ACPI Error (psparse-0633): Method parse/execution failed [\_SB_.PCI0.PE93._=
STA] (Node B12EE060), AE_ERROR
ACPI Exception: AE_ERROR, Returned by Handler for [PCI_Config] (20091214/ev=
region-588)
ACPI Error (psparse-0633): Method parse/execution failed [\_SB_.PCI0.PE94._=
STA] (Node B12EDC10), AE_ERROR
ACPI Exception: AE_ERROR, Returned by Handler for [PCI_Config] (20091214/ev=
region-588)
ACPI Error (psparse-0633): Method parse/execution failed [\_SB_.PCI0.PE95._=
STA] (Node B12ED7B8), AE_ERROR
ACPI Exception: AE_ERROR, Returned by Handler for [PCI_Config] (20091214/ev=
region-588)
ACPI Error (psparse-0633): Method parse/execution failed [\_SB_.PCI0.PE96._=
STA] (Node B12ED360), AE_ERROR
ACPI Exception: AE_ERROR, Returned by Handler for [PCI_Config] (20091214/ev=
region-588)
ACPI Error (psparse-0633): Method parse/execution failed [\_SB_.PCI0.PE97._=
STA] (Node B12ECED8), AE_ERROR
ACPI Exception: AE_ERROR, Returned by Handler for [PCI_Config] (20091214/ev=
region-588)
ACPI Error (psparse-0633): Method parse/execution failed [\_SB_.PCI0.PEA1._=
STA] (Node B12ECA80), AE_ERROR
ACPI Exception: AE_ERROR, Returned by Handler for [PCI_Config] (20091214/ev=
region-588)
ACPI Error (psparse-0633): Method parse/execution failed [\_SB_.PCI0.PEA2._=
STA] (Node B12EC628), AE_ERROR
ACPI Exception: AE_ERROR, Returned by Handler for [PCI_Config] (20091214/ev=
region-588)
ACPI Error (psparse-0633): Method parse/execution failed [\_SB_.PCI0.PEA3._=
STA] (Node B12EC1D0), AE_ERROR
ACPI Exception: AE_ERROR, Returned by Handler for [PCI_Config] (20091214/ev=
region-588)
ACPI Error (psparse-0633): Method parse/execution failed [\_SB_.PCI0.PEA4._=
STA] (Node B12EBD68), AE_ERROR
ACPI Exception: AE_ERROR, Returned by Handler for [PCI_Config] (20091214/ev=
region-588)
ACPI Error (psparse-0633): Method parse/execution failed [\_SB_.PCI0.PEA5._=
STA] (Node B12EB910), AE_ERROR
ACPI Exception: AE_ERROR, Returned by Handler for [PCI_Config] (20091214/ev=
region-588)
ACPI Error (psparse-0633): Method parse/execution failed [\_SB_.PCI0.PEA6._=
STA] (Node B12EB4B8), AE_ERROR
ACPI Exception: AE_ERROR, Returned by Handler for [PCI_Config] (20091214/ev=
region-588)
ACPI Error (psparse-0633): Method parse/execution failed [\_SB_.PCI0.PEA7._=
STA] (Node B12EB060), AE_ERROR
ACPI Exception: AE_ERROR, Returned by Handler for [PCI_Config] (20091214/ev=
region-588)
ACPI Error (psparse-0633): Method parse/execution failed [\_SB_.PCI0.PEB1._=
STA] (Node B12EAC10), AE_ERROR
ACPI Exception: AE_ERROR, Returned by Handler for [PCI_Config] (20091214/ev=
region-588)
ACPI Error (psparse-0633): Method parse/execution failed [\_SB_.PCI0.PEB2._=
STA] (Node B12EA7B8), AE_ERROR
ACPI Exception: AE_ERROR, Returned by Handler for [PCI_Config] (20091214/ev=
region-588)
ACPI Error (psparse-0633): Method parse/execution failed [\_SB_.PCI0.PEB3._=
STA] (Node B12EA360), AE_ERROR
ACPI Exception: AE_ERROR, Returned by Handler for [PCI_Config] (20091214/ev=
region-588)
ACPI Error (psparse-0633): Method parse/execution failed [\_SB_.PCI0.PEB4._=
STA] (Node B12E9ED8), AE_ERROR
ACPI Exception: AE_ERROR, Returned by Handler for [PCI_Config] (20091214/ev=
region-588)
ACPI Error (psparse-0633): Method parse/execution failed [\_SB_.PCI0.PEB5._=
STA] (Node B12E9A80), AE_ERROR
ACPI Exception: AE_ERROR, Returned by Handler for [PCI_Config] (20091214/ev=
region-588)
ACPI Error (psparse-0633): Method parse/execution failed [\_SB_.PCI0.PEB6._=
STA] (Node B12E9628), AE_ERROR
ACPI Exception: AE_ERROR, Returned by Handler for [PCI_Config] (20091214/ev=
region-588)
ACPI Error (psparse-0633): Method parse/execution failed [\_SB_.PCI0.PEB7._=
STA] (Node B12E91D0), AE_ERROR
PuTTYEntered debugger on last-chance exception (Exception Code: 0xc0000005)=
 (Page Fault)
Memory at 0x00000000 could not be read: Page not present.

________________________________
Hotmail: Trusted email with powerful SPAM protection. Sign up now.<https://=
signup.live.com/signup.aspx?id=3D60969>

--===============8638766198116861347==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGh0bWwgeG1sbnM6dj0idXJuOnNjaGVtYXMtbWljcm9zb2Z0LWNvbTp2bWwiIHhtbG5zOm89InVy
bjpzY2hlbWFzLW1pY3Jvc29mdC1jb206b2ZmaWNlOm9mZmljZSIgeG1sbnM6dz0idXJuOnNjaGVt
YXMtbWljcm9zb2Z0LWNvbTpvZmZpY2U6d29yZCIgeG1sbnM6c3QxPSJ1cm46c2NoZW1hcy1taWNy
b3NvZnQtY29tOm9mZmljZTpzbWFydHRhZ3MiIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy9UUi9S
RUMtaHRtbDQwIj4KCjxoZWFkPgo8bWV0YSBodHRwLWVxdWl2PUNvbnRlbnQtVHlwZSBjb250ZW50
PSJ0ZXh0L2h0bWw7IGNoYXJzZXQ9aXNvLTg4NTktMSI+CjxtZXRhIG5hbWU9R2VuZXJhdG9yIGNv
bnRlbnQ9Ik1pY3Jvc29mdCBXb3JkIDExIChmaWx0ZXJlZCBtZWRpdW0pIj4KPCEtLVtpZiAhbXNv
XT4KPHN0eWxlPgp2XDoqIHtiZWhhdmlvcjp1cmwoI2RlZmF1bHQjVk1MKTt9Cm9cOioge2JlaGF2
aW9yOnVybCgjZGVmYXVsdCNWTUwpO30Kd1w6KiB7YmVoYXZpb3I6dXJsKCNkZWZhdWx0I1ZNTCk7
fQouc2hhcGUge2JlaGF2aW9yOnVybCgjZGVmYXVsdCNWTUwpO30KPC9zdHlsZT4KPCFbZW5kaWZd
LS0+PG86U21hcnRUYWdUeXBlCiBuYW1lc3BhY2V1cmk9InVybjpzY2hlbWFzLW1pY3Jvc29mdC1j
b206b2ZmaWNlOnNtYXJ0dGFncyIgbmFtZT0iUGVyc29uTmFtZSIvPgo8IS0tW2lmICFtc29dPgo8
c3R5bGU+CnN0MVw6KntiZWhhdmlvcjp1cmwoI2RlZmF1bHQjaWVvb3VpKSB9Cjwvc3R5bGU+Cjwh
W2VuZGlmXS0tPgo8c3R5bGU+CjwhLS0KIC8qIEZvbnQgRGVmaW5pdGlvbnMgKi8KIEBmb250LWZh
Y2UKCXtmb250LWZhbWlseTpUYWhvbWE7CglwYW5vc2UtMToyIDExIDYgNCAzIDUgNCA0IDIgNDt9
CkBmb250LWZhY2UKCXtmb250LWZhbWlseTpWZXJkYW5hOwoJcGFub3NlLTE6MiAxMSA2IDQgMyA1
IDQgNCAyIDQ7fQogLyogU3R5bGUgRGVmaW5pdGlvbnMgKi8KIHAuTXNvTm9ybWFsLCBsaS5Nc29O
b3JtYWwsIGRpdi5Nc29Ob3JtYWwKCXttYXJnaW46MGluOwoJbWFyZ2luLWJvdHRvbTouMDAwMXB0
OwoJZm9udC1zaXplOjEyLjBwdDsKCWZvbnQtZmFtaWx5OiJUaW1lcyBOZXcgUm9tYW4iO30KYTps
aW5rLCBzcGFuLk1zb0h5cGVybGluawoJe2NvbG9yOmJsdWU7Cgl0ZXh0LWRlY29yYXRpb246dW5k
ZXJsaW5lO30KYTp2aXNpdGVkLCBzcGFuLk1zb0h5cGVybGlua0ZvbGxvd2VkCgl7Y29sb3I6Ymx1
ZTsKCXRleHQtZGVjb3JhdGlvbjp1bmRlcmxpbmU7fQpwCgl7bXNvLW1hcmdpbi10b3AtYWx0OmF1
dG87CgltYXJnaW4tcmlnaHQ6MGluOwoJbXNvLW1hcmdpbi1ib3R0b20tYWx0OmF1dG87CgltYXJn
aW4tbGVmdDowaW47Cglmb250LXNpemU6MTIuMHB0OwoJZm9udC1mYW1pbHk6IlRpbWVzIE5ldyBS
b21hbiI7fQpzcGFuLkVtYWlsU3R5bGUxOAoJe21zby1zdHlsZS10eXBlOnBlcnNvbmFsLXJlcGx5
OwoJZm9udC1mYW1pbHk6QXJpYWw7Cgljb2xvcjpuYXZ5O30KQHBhZ2UgU2VjdGlvbjEKCXtzaXpl
OjguNWluIDExLjBpbjsKCW1hcmdpbjoxLjBpbiAxLjI1aW4gMS4waW4gMS4yNWluO30KZGl2LlNl
Y3Rpb24xCgl7cGFnZTpTZWN0aW9uMTt9Ci0tPgo8L3N0eWxlPgoKPC9oZWFkPgoKPGJvZHkgbGFu
Zz1FTi1VUyBsaW5rPWJsdWUgdmxpbms9Ymx1ZT4KCjxkaXYgY2xhc3M9U2VjdGlvbjE+Cgo8cCBj
bGFzcz1Nc29Ob3JtYWw+PGZvbnQgc2l6ZT0yIGNvbG9yPW5hdnkgZmFjZT1BcmlhbD48c3BhbiBz
dHlsZT0nZm9udC1zaXplOgoxMC4wcHQ7Zm9udC1mYW1pbHk6QXJpYWw7Y29sb3I6bmF2eSc+PG86
cD4mbmJzcDs8L286cD48L3NwYW4+PC9mb250PjwvcD4KCjxwIGNsYXNzPU1zb05vcm1hbD48Zm9u
dCBzaXplPTIgY29sb3I9bmF2eSBmYWNlPUFyaWFsPjxzcGFuIHN0eWxlPSdmb250LXNpemU6CjEw
LjBwdDtmb250LWZhbWlseTpBcmlhbDtjb2xvcjpuYXZ5Jz5JZiB0aGlzIGlzIHRoZSBlcnJvciB5
b3UgYXJlIHRhbGtpbmcgYWJvdXQ8bzpwPjwvbzpwPjwvc3Bhbj48L2ZvbnQ+PC9wPgoKPHAgY2xh
c3M9TXNvTm9ybWFsPjxmb250IHNpemU9MiBjb2xvcj1uYXZ5IGZhY2U9QXJpYWw+PHNwYW4gc3R5
bGU9J2ZvbnQtc2l6ZToKMTAuMHB0O2ZvbnQtZmFtaWx5OkFyaWFsO2NvbG9yOm5hdnknPjxvOnA+
Jm5ic3A7PC9vOnA+PC9zcGFuPjwvZm9udD48L3A+Cgo8cCBjbGFzcz1Nc29Ob3JtYWw+PGZvbnQg
c2l6ZT0yIGZhY2U9VmVyZGFuYT48c3BhbiBzdHlsZT0nZm9udC1zaXplOjEwLjBwdDsKZm9udC1m
YW1pbHk6VmVyZGFuYSc+QUNQSSBFeGNlcHRpb246IEFFX0VSUk9SLCBSZXR1cm5lZCBieSBIYW5k
bGVyIGZvcgpbUENJX0NvbmZpZ10gKDIwMDkxMjE0L2V2cmVnaW9uLTU4OCk8YnI+CkFDUEkgRXJy
b3IgKHBzcGFyc2UtMDYzMyk6IE1ldGhvZCBwYXJzZS9leGVjdXRpb24gZmFpbGVkIFtcX1NCXy5Q
Q0kwLlBFQjcuX1NUQV0KKE5vZGUgQjEyRTkxRDApLCBBRV9FUlJPUjxicj4KPGJyPgo8bzpwPjwv
bzpwPjwvc3Bhbj48L2ZvbnQ+PC9wPgoKPHAgY2xhc3M9TXNvTm9ybWFsPjxmb250IHNpemU9MiBm
YWNlPVZlcmRhbmE+PHNwYW4gc3R5bGU9J2ZvbnQtc2l6ZToxMC4wcHQ7CmZvbnQtZmFtaWx5OlZl
cmRhbmEnPllvdSYjODIxNztsbCBuZWVkIHRvIGRlYnVnIHRoZSBQQ0lfQ29uZmlnIG9wZXJhdGlv
bgpoYW5kbGVyLjxvOnA+PC9vOnA+PC9zcGFuPjwvZm9udD48L3A+Cgo8cCBjbGFzcz1Nc29Ob3Jt
YWw+PGZvbnQgc2l6ZT0yIGNvbG9yPW5hdnkgZmFjZT1BcmlhbD48c3BhbiBzdHlsZT0nZm9udC1z
aXplOgoxMC4wcHQ7Zm9udC1mYW1pbHk6QXJpYWw7Y29sb3I6bmF2eSc+PG86cD4mbmJzcDs8L286
cD48L3NwYW4+PC9mb250PjwvcD4KCjxwIGNsYXNzPU1zb05vcm1hbD48Zm9udCBzaXplPTIgY29s
b3I9bmF2eSBmYWNlPUFyaWFsPjxzcGFuIHN0eWxlPSdmb250LXNpemU6CjEwLjBwdDtmb250LWZh
bWlseTpBcmlhbDtjb2xvcjpuYXZ5Jz48bzpwPiZuYnNwOzwvbzpwPjwvc3Bhbj48L2ZvbnQ+PC9w
PgoKPGRpdiBzdHlsZT0nYm9yZGVyOm5vbmU7Ym9yZGVyLWxlZnQ6c29saWQgYmx1ZSAxLjVwdDtw
YWRkaW5nOjBpbiAwaW4gMGluIDQuMHB0Jz4KCjxkaXY+Cgo8ZGl2IGNsYXNzPU1zb05vcm1hbCBh
bGlnbj1jZW50ZXIgc3R5bGU9J3RleHQtYWxpZ246Y2VudGVyJz48Zm9udCBzaXplPTMKZmFjZT0i
VGltZXMgTmV3IFJvbWFuIj48c3BhbiBzdHlsZT0nZm9udC1zaXplOjEyLjBwdCc+Cgo8aHIgc2l6
ZT0yIHdpZHRoPSIxMDAlIiBhbGlnbj1jZW50ZXIgdGFiaW5kZXg9LTE+Cgo8L3NwYW4+PC9mb250
PjwvZGl2PgoKPHAgY2xhc3M9TXNvTm9ybWFsPjxiPjxmb250IHNpemU9MiBmYWNlPVRhaG9tYT48
c3BhbiBzdHlsZT0nZm9udC1zaXplOjEwLjBwdDsKZm9udC1mYW1pbHk6VGFob21hO2ZvbnQtd2Vp
Z2h0OmJvbGQnPkZyb206PC9zcGFuPjwvZm9udD48L2I+PGZvbnQgc2l6ZT0yCmZhY2U9VGFob21h
PjxzcGFuIHN0eWxlPSdmb250LXNpemU6MTAuMHB0O2ZvbnQtZmFtaWx5OlRhaG9tYSc+CmRldmVs
LWJvdW5jZXNAYWNwaWNhLm9yZyBbbWFpbHRvOmRldmVsLWJvdW5jZXNAYWNwaWNhLm9yZ10gPGI+
PHNwYW4Kc3R5bGU9J2ZvbnQtd2VpZ2h0OmJvbGQnPk9uIEJlaGFsZiBPZiA8L3NwYW4+PC9iPlNh
bXVlbCBTZXJhcGlvbjxicj4KPGI+PHNwYW4gc3R5bGU9J2ZvbnQtd2VpZ2h0OmJvbGQnPlNlbnQ6
PC9zcGFuPjwvYj4gTW9uZGF5LCBNYXJjaCAwMSwgMjAxMCAxOjAwClBNPGJyPgo8Yj48c3BhbiBz
dHlsZT0nZm9udC13ZWlnaHQ6Ym9sZCc+VG86PC9zcGFuPjwvYj4gPHN0MTpQZXJzb25OYW1lIHc6
c3Q9Im9uIj5kZXZlbEBhY3BpY2Eub3JnPC9zdDE6UGVyc29uTmFtZT48YnI+CjxiPjxzcGFuIHN0
eWxlPSdmb250LXdlaWdodDpib2xkJz5TdWJqZWN0Ojwvc3Bhbj48L2I+IFtEZXZlbF0gVW5hYmxl
IHRvIGJvb3QgaW4Kdm13YXJlIDc8L3NwYW4+PC9mb250PjxvOnA+PC9vOnA+PC9wPgoKPC9kaXY+
Cgo8cCBjbGFzcz1Nc29Ob3JtYWw+PGZvbnQgc2l6ZT0zIGZhY2U9IlRpbWVzIE5ldyBSb21hbiI+
PHNwYW4gc3R5bGU9J2ZvbnQtc2l6ZToKMTIuMHB0Jz48bzpwPiZuYnNwOzwvbzpwPjwvc3Bhbj48
L2ZvbnQ+PC9wPgoKPHAgY2xhc3M9TXNvTm9ybWFsIHN0eWxlPSdtYXJnaW4tYm90dG9tOjEyLjBw
dCc+PGZvbnQgc2l6ZT0yIGZhY2U9VmVyZGFuYT48c3BhbgpzdHlsZT0nZm9udC1zaXplOjEwLjBw
dDtmb250LWZhbWlseTpWZXJkYW5hJz48YnI+CkhlbGxvLCBpJ3ZlIGJlZW4gZGV2ZWxvcGluZyBh
IGRyaXZlciBiYXNlZCBvbiBhY3BpY2EgYW5kIGxpbnV4IGFjcGkgZm9yClJlYWN0T1MsIHlvdSBj
YW4gZmluZCB0aGUgc291cmNlIGNvZGUgaGVyZToKaHR0cDovL2dpdC5yZWFjdG9zLm9yZy8/cD1y
ZWFjdG9zLmdpdDthPXRyZWU7Zj1yZWFjdG9zL2RyaXZlcnMvYnVzL2FjcGk7aGI9SEVBRDxicj4K
PGJyPgpIb3dldmVyIEkgaGF2ZSBiZWVuIHVuYWJsZSB0byBib290IGluIHZtd2FyZSA3LCB5b3Ug
Y2FuIGZpbmQgdGhlIGFjcGljYSBpbml0CnNlcXVlbmNlIGhlcmU6Cmh0dHA6Ly9naXQucmVhY3Rv
cy5vcmcvP3A9cmVhY3Rvcy5naXQ7YT1ibG9iO2Y9cmVhY3Rvcy9kcml2ZXJzL2J1cy9hY3BpL3Bu
cC5jO2hiPUhFQUQjbDI3MAouIEkgaGF2ZSBubyBpZGVhIHdoYXRzIGdvaW5nIHdyb25nLCBwbGVh
c2UgaGVscCBtZSBkZWJ1ZyB0aGlzIGlzc3VlLjxicj4KPGJyPgo8YnI+CihudG9za3JubFxrZFxr
ZGlvLmM6Mjk3KSAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLTxicj4KKG50b3Nrcm5sXGtkXGtkaW8uYzoyOTgpIFJlYWN0T1MgMC40LVNWTiAoQnVp
bGQgMjAxMDAyMjgtcjQ1NzI2KTxicj4KKG50b3Nrcm5sXGtkXGtkaW8uYzoyOTkpIENvbW1hbmQg
TGluZTogL05PR1VJQk9PVCAvREVCVUdQT1JUPUNPTTE8YnI+CihudG9za3JubFxrZFxrZGlvLmM6
MzAzKSBBUkMgUGF0aHM6IG11bHRpKDApZGlzaygwKWNkcm9tKDE1OSkgXAptdWx0aSgwKWRpc2so
MCljZHJvbSgxNTkpIFxyZWFjdG9zXDxicj4KKG50b3Nrcm5sXGtlXGkzODZcY3B1LmM6NzQ2KSBQ
cmVmZXRjaCBDYWNoZTogNjQgYnl0ZXMmbmJzcDsmbmJzcDsgTDIgQ2FjaGU6CjUyNDI4OCBieXRl
cyBMMiBDYWNoZSBMaW5lOiA2NCBieXRlcyZuYnNwOyBMMiBDYWNoZSBBc3NvY2lhdGl2aXR5OiAx
Njxicj4KV0FSTklORzombmJzcDsgSGFsU3RvcFByb2ZpbGVJbnRlcnJ1cHQgYXQgaGFsXGhhbHg4
NlxnZW5lcmljXHByb2ZpbC5jOjI0IGlzClVOSU1QTEVNRU5URUQhPGJyPgoobnRvc2tybmxcbW1c
bW1pbml0LmM6Mjg5KSZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOwoweDgwMDAwMDAwIC0gMHg4MTAwMDAwMCZuYnNwOyZuYnNwOyZuYnNw
OyBCb290IExvYWRlZCBJbWFnZTxicj4KKG50b3Nrcm5sXG1tXG1taW5pdC5jOjI5MykmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsKMHg4
MTAwMDAwMCAtIDB4ODc0MDAwMDAmbmJzcDsmbmJzcDsmbmJzcDsgUGFnZWQgUG9vbDxicj4KKG50
b3Nrcm5sXG1tXG1taW5pdC5jOjI5NykmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsKMHhCMDAwMDAwMCAtIDB4QjA2MDEwMDAmbmJzcDsm
bmJzcDsmbmJzcDsgUEZOIERhdGFiYXNlPGJyPgoobnRvc2tybmxcbW1cbW1pbml0LmM6MzAxKSZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OwoweEIwNjAxMDAwIC0gMHhCMTVDOTAwMCZuYnNwOyZuYnNwOyZuYnNwOyBBUk3CsyBOb24gUGFn
ZWQgUG9vbDxicj4KKG50b3Nrcm5sXG1tXG1taW5pdC5jOjMwNSkmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsKMHhCQzAwMDAwMCAtIDB4
QkQwMDAwMDAmbmJzcDsmbmJzcDsmbmJzcDsgU3lzdGVtIFZpZXcgU3BhY2U8YnI+CihudG9za3Ju
bFxtbVxtbWluaXQuYzozMDkpJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7CjB4QkQwMDAwMDAgLSAweEMwMDAwMDAwJm5ic3A7Jm5ic3A7
Jm5ic3A7IFNlc3Npb24gU3BhY2U8YnI+CihudG9za3JubFxtbVxtbWluaXQuYzozMTIpJm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7CjB4
QzAwMDAwMDAgLSAweEMwMzAwMDAwJm5ic3A7Jm5ic3A7Jm5ic3A7IFBhZ2UgVGFibGVzPGJyPgoo
bnRvc2tybmxcbW1cbW1pbml0LmM6MzE1KSZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOwoweEMwMzAwMDAwIC0gMHhDMDQwMDAwMCZuYnNw
OyZuYnNwOyZuYnNwOyBQYWdlIERpcmVjdG9yaWVzPGJyPgoobnRvc2tybmxcbW1cbW1pbml0LmM6
MzE4KSZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOwoweEMwNDAwMDAwIC0gMHhDMDgwMDAwMCZuYnNwOyZuYnNwOyZuYnNwOyBIeXBlcnNw
YWNlPGJyPgoobnRvc2tybmxcbW1cbW1pbml0LmM6MzIyKSZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOwoweEUxMDAwMDAwIC0gMHhGMTAw
MDAwMCZuYnNwOyZuYnNwOyZuYnNwOyBBUk3CsyBQYWdlZCBQb29sPGJyPgoobnRvc2tybmxcbW1c
bW1pbml0LmM6MzI1KSZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOwoweEYzNDAwMDAwIC0gMHhGOEJBODAwMCZuYnNwOyZuYnNwOyZuYnNw
OyBTeXN0ZW0gUFRFIFNwYWNlPGJyPgoobnRvc2tybmxcbW1cbW1pbml0LmM6MzI4KSZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOwoweEY4
QkE4MDAwIC0gMHhGRkJFMDAwMCZuYnNwOyZuYnNwOyZuYnNwOyBOb24gUGFnZWQgUG9vbCBFeHBh
bnNpb24gUFRFIFNwYWNlPGJyPgoobnRvc2tybmxca2VcaTM4NlxraWluaXQuYzo1MykgTGFyZ2Ug
UGFnZSBzdXBwb3J0IGRldGVjdGVkIGJ1dCBub3QgeWV0IHRha2VuCmFkdmFudGFnZSBvZjxicj4K
KG50b3Nrcm5sXGtlXGkzODZccGF0cGdlLmM6NDUpIEdsb2JhbCBwYWdlIHN1cHBvcnQgZGV0ZWN0
ZWQgYnV0IG5vdCB5ZXQgdGFrZW4KYWR2YW50YWdlIG9mPGJyPgoobnRvc2tybmxca2VcaTM4Nlxw
YXRwZ2UuYzo1OCkgUEFUIHN1cHBvcnQgZGV0ZWN0ZWQgYnV0IG5vdCB5ZXQgdGFrZW4gYWR2YW50
YWdlCm9mPGJyPgoobnRvc2tybmxca2VcaTM4NlxtdHJyLmM6MjQpIE1UUlIgc3VwcG9ydCBkZXRl
Y3RlZCBidXQgbm90IHlldCB0YWtlbiBhZHZhbnRhZ2UKb2Y8YnI+ClBDIENvbXBhdGlibGUgRWlz
YS9Jc2EgSEFMIGhhcyBiZWVuIGluaXRpYWxpemVkPGJyPgpXQVJOSU5HOiZuYnNwOyBJb1JlcG9y
dFJlc291cmNlVXNhZ2UgYXQgbnRvc2tybmxcaW9caW9tZ3JcaW9yc3JjZS5jOjcwMCBpcwpVTklN
UExFTUVOVEVEITxicj4KV0FSTklORzombmJzcDsgSW9SZXBvcnRSZXNvdXJjZVVzYWdlIGF0IG50
b3Nrcm5sXGlvXGlvbWdyXGlvcnNyY2UuYzo3MDAgaXMKVU5JTVBMRU1FTlRFRCE8YnI+CihudG9z
a3JubFxpb1xpb21nclxmaWxlLmM6NDIwKSBVc2luZyBJb3BQYXJzZURldmljZSgpIGhhY2suIFJl
cXVlc3RlZCBpbnZhbGlkCmF0dHJpYnV0ZXM6IDE8YnI+CihudG9za3JubFxmc3R1YlxkaXNrc3Vw
LmM6MjUzKSBad09wZW5TeW1ib2xpY0xpbmtPYmplY3QgZmFpbGVkIGZvcgpcQXJjTmFtZVxtdWx0
aSgwKWRpc2soMClyZGlzaygxKSwgc3RhdHVzPWMwMDAwMDM0PGJyPgoobnRvc2tybmxcZnN0dWJc
ZGlza3N1cC5jOjI1MykgWndPcGVuU3ltYm9saWNMaW5rT2JqZWN0IGZhaWxlZCBmb3IKXEFyY05h
bWVcbXVsdGkoMClkaXNrKDApcmRpc2soMSksIHN0YXR1cz1jMDAwMDAzNDxicj4KKGRyaXZlcnNc
YnVzXGFjcGlcbWFpbi5jOjIwNikgRHJpdmVyIEVudHJ5PGJyPgooZHJpdmVyc1xidXNcYWNwaVxt
YWluLmM6MzYpIEFkZCBEZXZpY2U6IDB4QjEzNkM2Rjg8YnI+Cihkcml2ZXJzXGJ1c1xhY3BpXG1h
aW4uYzozOCkgIyMjIyMjIyMjIyMjIyMjIyMjIyMgQnVzX0NyZWF0ZUNsb3NlIENyZWF0aW5nIEZE
TwpEZXZpY2UgIyMjIyMjIyMjIyMjIyMjIyMjIyM8YnI+Cihkcml2ZXJzXGJ1c1xhY3BpXG1haW4u
YzoxNDEpIEFkZERldmljZTogQjEzNENDNzAgdG8gQjEzNkM2RjgtJmd0O0IxMzZDNkY4CihSb290
XCpQTlAwQzA4XDAwMDApPGJyPgooZHJpdmVyc1xidXNcYWNwaVxwbnAuYzo0NykgRkRPIElSUF9N
Tl9GSUxURVJfUkVTT1VSQ0VfUkVRVUlSRU1FTlRTCklSUDoweEIxMzU3OUUwPGJyPgooZHJpdmVy
c1xidXNcYWNwaVxwbnAuYzo0NykgRkRPIElSUF9NTl9TVEFSVF9ERVZJQ0UgSVJQOjB4QjEzNTc5
RTA8YnI+CkFDUEk6IFJTRFAgMDAwRjY5NDAgMDAwMjQgKHYwMiBQVExURCApPGJyPgpBQ1BJOiBY
U0RUIDFGRUYwODg1IDAwMDRDICh2MDEgSU5URUwmbmJzcDsgNDQwQlgmbmJzcDsmbmJzcDsmbmJz
cDsgMDYwNDAwMDAKVk1XJm5ic3A7IDAxMzI0MjcyKTxicj4KQUNQSTogRkFDUCAxRkVGRUU5OCAw
MDBGNCAodjA0IElOVEVMJm5ic3A7IDQ0MEJYJm5ic3A7Jm5ic3A7Jm5ic3A7IDA2MDQwMDAwClBU
TCZuYnNwOyAwMDBGNDI0MCk8YnI+CkFDUEk6IERTRFQgMUZFRjBBM0QgMEU0NUIgKHYwMSBQVExU
RCZuYnNwOyBDdXN0b20mbmJzcDsmbmJzcDsgMDYwNDAwMDAgTVNGVAowMzAwMDAwMSk8YnI+CkFD
UEk6IEZBQ1MgMUZFRkZGQzAgMDAwNDA8YnI+CkFDUEk6IEJPT1QgMUZFRjBBMTUgMDAwMjggKHYw
MSBQVExURCZuYnNwOyAkU0JGVEJMJCAwNjA0MDAwMCZuYnNwOyBMVFAKMDAwMDAwMDEpPGJyPgpB
Q1BJOiBBUElDIDFGRUYwOUM1IDAwMDUwICh2MDEgUFRMVEQmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsgQVBJQyZuYnNwOyZuYnNwOwowNjA0MDAwMCZuYnNwOyBMVFAgMDAwMDAwMDApPGJyPgpBQ1BJ
OiBNQ0ZHIDFGRUYwOTg5IDAwMDNDICh2MDEgUFRMVEQmbmJzcDsgJFBDSVRCTCQgMDYwNDAwMDAm
bmJzcDsgTFRQCjAwMDAwMDAxKTxicj4KQUNQSTogU1JBVCAxRkVGMDkwOSAwMDA4MCAodjAyIFZN
V0FSRSBNRU1QTFVHJm5ic3A7IDA2MDQwMDAwIFZNVyZuYnNwOwowMDAwMDAwMSk8YnI+Cihkcml2
ZXJzXGJ1c1xhY3BpXHBucC5jOjMwNikgQWNwaSBzdWJzeXN0ZW0gaW5pdDxicj4KKGRyaXZlcnNc
YnVzXGFjcGlcYnVzbWdyXGJ1cy5jOjE3ODUpCmFjcGlfaW5pdChkcml2ZXJzXGJ1c1xhY3BpXGJ1
c21nclxidXMuYzoxNzg3KSBTdWJzeXN0ZW0gcmV2aXNpb24gMjAwOTEyMTQ8YnI+Cihkcml2ZXJz
XGJ1c1xhY3BpXGJ1c21nclxidXMuYzoxNjY3KQphY3BpX2J1c19pbml0KGRyaXZlcnNcYnVzXGFj
cGlcYnVzbWdyXGJ1cy5jOjE1NTUpIGFjcGlfYnVzX2luaXRfaXJxQUNQSSBFeGNlcHRpb246CkFF
X0VSUk9SLCBSZXR1cm5lZCBieSBIYW5kbGVyIGZvciBbUENJX0NvbmZpZ10gKDIwMDkxMjE0L2V2
cmVnaW9uLTU4OCk8YnI+CkFDUEkgRXJyb3IgKHBzcGFyc2UtMDYzMyk6IE1ldGhvZCBwYXJzZS9l
eGVjdXRpb24gZmFpbGVkIFtcX1NCXy5QQ0kwLlAyUDAuX1NUQV0KKE5vZGUgQjEyRkZFRjgpLCBB
RV9FUlJPUjxicj4KQUNQSSBFeGNlcHRpb246IEFFX0VSUk9SLCBSZXR1cm5lZCBieSBIYW5kbGVy
IGZvciBbUENJX0NvbmZpZ10gKDIwMDkxMjE0L2V2cmVnaW9uLTU4OCk8YnI+CkFDUEkgRXJyb3Ig
KHBzcGFyc2UtMDYzMyk6IE1ldGhvZCBwYXJzZS9leGVjdXRpb24gZmFpbGVkIFtcX1NCXy5QQ0kw
LlAyUDEuX1NUQV0KKE5vZGUgQjEzNDgzQTgpLCBBRV9FUlJPUjxicj4KQUNQSSBFeGNlcHRpb246
IEFFX0VSUk9SLCBSZXR1cm5lZCBieSBIYW5kbGVyIGZvciBbUENJX0NvbmZpZ10KKDIwMDkxMjE0
L2V2cmVnaW9uLTU4OCk8YnI+CkFDUEkgRXJyb3IgKHBzcGFyc2UtMDYzMyk6IE1ldGhvZCBwYXJz
ZS9leGVjdXRpb24gZmFpbGVkIFtcX1NCXy5QQ0kwLlAyUDIuX1NUQV0KKE5vZGUgQjEzNDY4NDgp
LCBBRV9FUlJPUjxicj4KQUNQSSBFeGNlcHRpb246IEFFX0VSUk9SLCBSZXR1cm5lZCBieSBIYW5k
bGVyIGZvciBbUENJX0NvbmZpZ10KKDIwMDkxMjE0L2V2cmVnaW9uLTU4OCk8YnI+CkFDUEkgRXJy
b3IgKHBzcGFyc2UtMDYzMyk6IE1ldGhvZCBwYXJzZS9leGVjdXRpb24gZmFpbGVkIFtcX1NCXy5Q
Q0kwLlAyUDMuX1NUQV0KKE5vZGUgQjEzNDRDRjgpLCBBRV9FUlJPUjxicj4KQUNQSSBFeGNlcHRp
b246IEFFX0VSUk9SLCBSZXR1cm5lZCBieSBIYW5kbGVyIGZvciBbUENJX0NvbmZpZ10KKDIwMDkx
MjE0L2V2cmVnaW9uLTU4OCk8YnI+CkFDUEkgRXJyb3IgKHBzcGFyc2UtMDYzMyk6IE1ldGhvZCBw
YXJzZS9leGVjdXRpb24gZmFpbGVkIFtcX1NCXy5QQ0kwLlBFNDAuX1NUQV0KKE5vZGUgQjEzNDIx
RTgpLCBBRV9FUlJPUjxicj4KQUNQSSBFeGNlcHRpb246IEFFX0VSUk9SLCBSZXR1cm5lZCBieSBI
YW5kbGVyIGZvciBbUENJX0NvbmZpZ10gKDIwMDkxMjE0L2V2cmVnaW9uLTU4OCk8YnI+CkFDUEkg
RXJyb3IgKHBzcGFyc2UtMDYzMyk6IE1ldGhvZCBwYXJzZS9leGVjdXRpb24gZmFpbGVkIFtcX1NC
Xy5QQ0kwLlBFNTAuX1NUQV0KKE5vZGUgQjEzNDFENjgpLCBBRV9FUlJPUjxicj4KQUNQSSBFeGNl
cHRpb246IEFFX0VSUk9SLCBSZXR1cm5lZCBieSBIYW5kbGVyIGZvciBbUENJX0NvbmZpZ10KKDIw
MDkxMjE0L2V2cmVnaW9uLTU4OCk8YnI+CkFDUEkgRXJyb3IgKHBzcGFyc2UtMDYzMyk6IE1ldGhv
ZCBwYXJzZS9leGVjdXRpb24gZmFpbGVkIFtcX1NCXy5QQ0kwLlBFNjAuX1NUQV0KKE5vZGUgQjEz
NDE5MTApLCBBRV9FUlJPUjxicj4KQUNQSSBFeGNlcHRpb246IEFFX0VSUk9SLCBSZXR1cm5lZCBi
eSBIYW5kbGVyIGZvciBbUENJX0NvbmZpZ10KKDIwMDkxMjE0L2V2cmVnaW9uLTU4OCk8YnI+CkFD
UEkgRXJyb3IgKHBzcGFyc2UtMDYzMyk6IE1ldGhvZCBwYXJzZS9leGVjdXRpb24gZmFpbGVkIFtc
X1NCXy5QQ0kwLlBFNzAuX1NUQV0KKE5vZGUgQjEzNDE0QjgpLCBBRV9FUlJPUjxicj4KQUNQSSBF
eGNlcHRpb246IEFFX0VSUk9SLCBSZXR1cm5lZCBieSBIYW5kbGVyIGZvciBbUENJX0NvbmZpZ10K
KDIwMDkxMjE0L2V2cmVnaW9uLTU4OCk8YnI+CkFDUEkgRXJyb3IgKHBzcGFyc2UtMDYzMyk6IE1l
dGhvZCBwYXJzZS9leGVjdXRpb24gZmFpbGVkIFtcX1NCXy5QQ0kwLlBFODAuX1NUQV0KKE5vZGUg
QjEzNDEwNjApLCBBRV9FUlJPUjxicj4KQUNQSSBFeGNlcHRpb246IEFFX0VSUk9SLCBSZXR1cm5l
ZCBieSBIYW5kbGVyIGZvciBbUENJX0NvbmZpZ10gKDIwMDkxMjE0L2V2cmVnaW9uLTU4OCk8YnI+
CkFDUEkgRXJyb3IgKHBzcGFyc2UtMDYzMyk6IE1ldGhvZCBwYXJzZS9leGVjdXRpb24gZmFpbGVk
IFtcX1NCXy5QQ0kwLlBFOTAuX1NUQV0KKE5vZGUgQjEzNDBDMTApLCBBRV9FUlJPUjxicj4KQUNQ
SSBFeGNlcHRpb246IEFFX0VSUk9SLCBSZXR1cm5lZCBieSBIYW5kbGVyIGZvciBbUENJX0NvbmZp
Z10KKDIwMDkxMjE0L2V2cmVnaW9uLTU4OCk8YnI+CkFDUEkgRXJyb3IgKHBzcGFyc2UtMDYzMyk6
IE1ldGhvZCBwYXJzZS9leGVjdXRpb24gZmFpbGVkIFtcX1NCXy5QQ0kwLlBFQTAuX1NUQV0KKE5v
ZGUgQjEzNDA3QjgpLCBBRV9FUlJPUjxicj4KQUNQSSBFeGNlcHRpb246IEFFX0VSUk9SLCBSZXR1
cm5lZCBieSBIYW5kbGVyIGZvciBbUENJX0NvbmZpZ10KKDIwMDkxMjE0L2V2cmVnaW9uLTU4OCk8
YnI+CkFDUEkgRXJyb3IgKHBzcGFyc2UtMDYzMyk6IE1ldGhvZCBwYXJzZS9leGVjdXRpb24gZmFp
bGVkIFtcX1NCXy5QQ0kwLlBFQjAuX1NUQV0KKE5vZGUgQjEzNDAzNjApLCBBRV9FUlJPUjxicj4K
QUNQSSBFeGNlcHRpb246IEFFX0VSUk9SLCBSZXR1cm5lZCBieSBIYW5kbGVyIGZvciBbUENJX0Nv
bmZpZ10KKDIwMDkxMjE0L2V2cmVnaW9uLTU4OCk8YnI+CkFDUEkgRXJyb3IgKHBzcGFyc2UtMDYz
Myk6IE1ldGhvZCBwYXJzZS9leGVjdXRpb24gZmFpbGVkIFtcX1NCXy5QQ0kwLlBFQzAuX1NUQV0K
KE5vZGUgQjEyRjhFRDgpLCBBRV9FUlJPUjxicj4KQUNQSSBFeGNlcHRpb246IEFFX0VSUk9SLCBS
ZXR1cm5lZCBieSBIYW5kbGVyIGZvciBbUENJX0NvbmZpZ10KKDIwMDkxMjE0L2V2cmVnaW9uLTU4
OCk8YnI+CkFDUEkgRXJyb3IgKHBzcGFyc2UtMDYzMyk6IE1ldGhvZCBwYXJzZS9leGVjdXRpb24g
ZmFpbGVkIFtcX1NCXy5QQ0kwLlBFRDAuX1NUQV0KKE5vZGUgQjEyRjhBODApLCBBRV9FUlJPUjxi
cj4KQUNQSSBFeGNlcHRpb246IEFFX0VSUk9SLCBSZXR1cm5lZCBieSBIYW5kbGVyIGZvciBbUENJ
X0NvbmZpZ10KKDIwMDkxMjE0L2V2cmVnaW9uLTU4OCk8YnI+CkFDUEkgRXJyb3IgKHBzcGFyc2Ut
MDYzMyk6IE1ldGhvZCBwYXJzZS9leGVjdXRpb24gZmFpbGVkIFtcX1NCXy5QQ0kwLlBFRTAuX1NU
QV0KKE5vZGUgQjEyRjg2MjgpLCBBRV9FUlJPUjxicj4KQUNQSSBFeGNlcHRpb246IEFFX0VSUk9S
LCBSZXR1cm5lZCBieSBIYW5kbGVyIGZvciBbUENJX0NvbmZpZ10KKDIwMDkxMjE0L2V2cmVnaW9u
LTU4OCk8YnI+CkFDUEkgRXJyb3IgKHBzcGFyc2UtMDYzMyk6IE1ldGhvZCBwYXJzZS9leGVjdXRp
b24gZmFpbGVkIFtcX1NCXy5QQ0kwLlBFNDEuX1NUQV0KKE5vZGUgQjEyRjgxRDApLCBBRV9FUlJP
Ujxicj4KQUNQSSBFeGNlcHRpb246IEFFX0VSUk9SLCBSZXR1cm5lZCBieSBIYW5kbGVyIGZvciBb
UENJX0NvbmZpZ10KKDIwMDkxMjE0L2V2cmVnaW9uLTU4OCk8YnI+CkFDUEkgRXJyb3IgKHBzcGFy
c2UtMDYzMyk6IE1ldGhvZCBwYXJzZS9leGVjdXRpb24gZmFpbGVkIFtcX1NCXy5QQ0kwLlBFNDIu
X1NUQV0KKE5vZGUgQjEyRjdENjgpLCBBRV9FUlJPUjxicj4KQUNQSSBFeGNlcHRpb246IEFFX0VS
Uk9SLCBSZXR1cm5lZCBieSBIYW5kbGVyIGZvciBbUENJX0NvbmZpZ10KKDIwMDkxMjE0L2V2cmVn
aW9uLTU4OCk8YnI+CkFDUEkgRXJyb3IgKHBzcGFyc2UtMDYzMyk6IE1ldGhvZCBwYXJzZS9leGVj
dXRpb24gZmFpbGVkIFtcX1NCXy5QQ0kwLlBFNDMuX1NUQV0KKE5vZGUgQjEyRjc5MTApLCBBRV9F
UlJPUjxicj4KQUNQSSBFeGNlcHRpb246IEFFX0VSUk9SLCBSZXR1cm5lZCBieSBIYW5kbGVyIGZv
ciBbUENJX0NvbmZpZ10KKDIwMDkxMjE0L2V2cmVnaW9uLTU4OCk8YnI+CkFDUEkgRXJyb3IgKHBz
cGFyc2UtMDYzMyk6IE1ldGhvZCBwYXJzZS9leGVjdXRpb24gZmFpbGVkIFtcX1NCXy5QQ0kwLlBF
NDQuX1NUQV0KKE5vZGUgQjEyRjc0QjgpLCBBRV9FUlJPUjxicj4KQUNQSSBFeGNlcHRpb246IEFF
X0VSUk9SLCBSZXR1cm5lZCBieSBIYW5kbGVyIGZvciBbUENJX0NvbmZpZ10KKDIwMDkxMjE0L2V2
cmVnaW9uLTU4OCk8YnI+CkFDUEkgRXJyb3IgKHBzcGFyc2UtMDYzMyk6IE1ldGhvZCBwYXJzZS9l
eGVjdXRpb24gZmFpbGVkIFtcX1NCXy5QQ0kwLlBFNDUuX1NUQV0KKE5vZGUgQjEyRjcwNjApLCBB
RV9FUlJPUjxicj4KQUNQSSBFeGNlcHRpb246IEFFX0VSUk9SLCBSZXR1cm5lZCBieSBIYW5kbGVy
IGZvciBbUENJX0NvbmZpZ10KKDIwMDkxMjE0L2V2cmVnaW9uLTU4OCk8YnI+CkFDUEkgRXJyb3Ig
KHBzcGFyc2UtMDYzMyk6IE1ldGhvZCBwYXJzZS9leGVjdXRpb24gZmFpbGVkIFtcX1NCXy5QQ0kw
LlBFNDYuX1NUQV0KKE5vZGUgQjEyRjZDMTApLCBBRV9FUlJPUjxicj4KQUNQSSBFeGNlcHRpb246
IEFFX0VSUk9SLCBSZXR1cm5lZCBieSBIYW5kbGVyIGZvciBbUENJX0NvbmZpZ10KKDIwMDkxMjE0
L2V2cmVnaW9uLTU4OCk8YnI+CkFDUEkgRXJyb3IgKHBzcGFyc2UtMDYzMyk6IE1ldGhvZCBwYXJz
ZS9leGVjdXRpb24gZmFpbGVkIFtcX1NCXy5QQ0kwLlBFNDcuX1NUQV0KKE5vZGUgQjEyRjY3Qjgp
LCBBRV9FUlJPUjxicj4KQUNQSSBFeGNlcHRpb246IEFFX0VSUk9SLCBSZXR1cm5lZCBieSBIYW5k
bGVyIGZvciBbUENJX0NvbmZpZ10KKDIwMDkxMjE0L2V2cmVnaW9uLTU4OCk8YnI+CkFDUEkgRXJy
b3IgKHBzcGFyc2UtMDYzMyk6IE1ldGhvZCBwYXJzZS9leGVjdXRpb24gZmFpbGVkIFtcX1NCXy5Q
Q0kwLlBFNTEuX1NUQV0KKE5vZGUgQjEyRjYzNjApLCBBRV9FUlJPUjxicj4KQUNQSSBFeGNlcHRp
b246IEFFX0VSUk9SLCBSZXR1cm5lZCBieSBIYW5kbGVyIGZvciBbUENJX0NvbmZpZ10KKDIwMDkx
MjE0L2V2cmVnaW9uLTU4OCk8YnI+CkFDUEkgRXJyb3IgKHBzcGFyc2UtMDYzMyk6IE1ldGhvZCBw
YXJzZS9leGVjdXRpb24gZmFpbGVkIFtcX1NCXy5QQ0kwLlBFNTIuX1NUQV0KKE5vZGUgQjEyRjVF
RDgpLCBBRV9FUlJPUjxicj4KQUNQSSBFeGNlcHRpb246IEFFX0VSUk9SLCBSZXR1cm5lZCBieSBI
YW5kbGVyIGZvciBbUENJX0NvbmZpZ10KKDIwMDkxMjE0L2V2cmVnaW9uLTU4OCk8YnI+CkFDUEkg
RXJyb3IgKHBzcGFyc2UtMDYzMyk6IE1ldGhvZCBwYXJzZS9leGVjdXRpb24gZmFpbGVkIFtcX1NC
Xy5QQ0kwLlBFNTMuX1NUQV0KKE5vZGUgQjEyRjVBODApLCBBRV9FUlJPUjxicj4KQUNQSSBFeGNl
cHRpb246IEFFX0VSUk9SLCBSZXR1cm5lZCBieSBIYW5kbGVyIGZvciBbUENJX0NvbmZpZ10KKDIw
MDkxMjE0L2V2cmVnaW9uLTU4OCk8YnI+CkFDUEkgRXJyb3IgKHBzcGFyc2UtMDYzMyk6IE1ldGhv
ZCBwYXJzZS9leGVjdXRpb24gZmFpbGVkIFtcX1NCXy5QQ0kwLlBFNTQuX1NUQV0KKE5vZGUgQjEy
RjU2MjgpLCBBRV9FUlJPUjxicj4KQUNQSSBFeGNlcHRpb246IEFFX0VSUk9SLCBSZXR1cm5lZCBi
eSBIYW5kbGVyIGZvciBbUENJX0NvbmZpZ10KKDIwMDkxMjE0L2V2cmVnaW9uLTU4OCk8YnI+CkFD
UEkgRXJyb3IgKHBzcGFyc2UtMDYzMyk6IE1ldGhvZCBwYXJzZS9leGVjdXRpb24gZmFpbGVkIFtc
X1NCXy5QQ0kwLlBFNTUuX1NUQV0KKE5vZGUgQjEyRjUxRDApLCBBRV9FUlJPUjxicj4KQUNQSSBF
eGNlcHRpb246IEFFX0VSUk9SLCBSZXR1cm5lZCBieSBIYW5kbGVyIGZvciBbUENJX0NvbmZpZ10K
KDIwMDkxMjE0L2V2cmVnaW9uLTU4OCk8YnI+CkFDUEkgRXJyb3IgKHBzcGFyc2UtMDYzMyk6IE1l
dGhvZCBwYXJzZS9leGVjdXRpb24gZmFpbGVkIFtcX1NCXy5QQ0kwLlBFNTYuX1NUQV0KKE5vZGUg
QjEyRjRENjgpLCBBRV9FUlJPUjxicj4KQUNQSSBFeGNlcHRpb246IEFFX0VSUk9SLCBSZXR1cm5l
ZCBieSBIYW5kbGVyIGZvciBbUENJX0NvbmZpZ10KKDIwMDkxMjE0L2V2cmVnaW9uLTU4OCk8YnI+
CkFDUEkgRXJyb3IgKHBzcGFyc2UtMDYzMyk6IE1ldGhvZCBwYXJzZS9leGVjdXRpb24gZmFpbGVk
IFtcX1NCXy5QQ0kwLlBFNTcuX1NUQV0KKE5vZGUgQjEyRjQ5MTApLCBBRV9FUlJPUjxicj4KQUNQ
SSBFeGNlcHRpb246IEFFX0VSUk9SLCBSZXR1cm5lZCBieSBIYW5kbGVyIGZvciBbUENJX0NvbmZp
Z10KKDIwMDkxMjE0L2V2cmVnaW9uLTU4OCk8YnI+CkFDUEkgRXJyb3IgKHBzcGFyc2UtMDYzMyk6
IE1ldGhvZCBwYXJzZS9leGVjdXRpb24gZmFpbGVkIFtcX1NCXy5QQ0kwLlBFNjEuX1NUQV0KKE5v
ZGUgQjEyRjQ0QjgpLCBBRV9FUlJPUjxicj4KQUNQSSBFeGNlcHRpb246IEFFX0VSUk9SLCBSZXR1
cm5lZCBieSBIYW5kbGVyIGZvciBbUENJX0NvbmZpZ10KKDIwMDkxMjE0L2V2cmVnaW9uLTU4OCk8
YnI+CkFDUEkgRXJyb3IgKHBzcGFyc2UtMDYzMyk6IE1ldGhvZCBwYXJzZS9leGVjdXRpb24gZmFp
bGVkIFtcX1NCXy5QQ0kwLlBFNjIuX1NUQV0KKE5vZGUgQjEyRjQwNjApLCBBRV9FUlJPUjxicj4K
QUNQSSBFeGNlcHRpb246IEFFX0VSUk9SLCBSZXR1cm5lZCBieSBIYW5kbGVyIGZvciBbUENJX0Nv
bmZpZ10KKDIwMDkxMjE0L2V2cmVnaW9uLTU4OCk8YnI+CkFDUEkgRXJyb3IgKHBzcGFyc2UtMDYz
Myk6IE1ldGhvZCBwYXJzZS9leGVjdXRpb24gZmFpbGVkIFtcX1NCXy5QQ0kwLlBFNjMuX1NUQV0K
KE5vZGUgQjEyRjNDMTApLCBBRV9FUlJPUjxicj4KQUNQSSBFeGNlcHRpb246IEFFX0VSUk9SLCBS
ZXR1cm5lZCBieSBIYW5kbGVyIGZvciBbUENJX0NvbmZpZ10KKDIwMDkxMjE0L2V2cmVnaW9uLTU4
OCk8YnI+CkFDUEkgRXJyb3IgKHBzcGFyc2UtMDYzMyk6IE1ldGhvZCBwYXJzZS9leGVjdXRpb24g
ZmFpbGVkIFtcX1NCXy5QQ0kwLlBFNjQuX1NUQV0KKE5vZGUgQjEyRjM3QjgpLCBBRV9FUlJPUjxi
cj4KQUNQSSBFeGNlcHRpb246IEFFX0VSUk9SLCBSZXR1cm5lZCBieSBIYW5kbGVyIGZvciBbUENJ
X0NvbmZpZ10KKDIwMDkxMjE0L2V2cmVnaW9uLTU4OCk8YnI+CkFDUEkgRXJyb3IgKHBzcGFyc2Ut
MDYzMyk6IE1ldGhvZCBwYXJzZS9leGVjdXRpb24gZmFpbGVkIFtcX1NCXy5QQ0kwLlBFNjUuX1NU
QV0KKE5vZGUgQjEyRjMzNjApLCBBRV9FUlJPUjxicj4KQUNQSSBFeGNlcHRpb246IEFFX0VSUk9S
LCBSZXR1cm5lZCBieSBIYW5kbGVyIGZvciBbUENJX0NvbmZpZ10KKDIwMDkxMjE0L2V2cmVnaW9u
LTU4OCk8YnI+CkFDUEkgRXJyb3IgKHBzcGFyc2UtMDYzMyk6IE1ldGhvZCBwYXJzZS9leGVjdXRp
b24gZmFpbGVkIFtcX1NCXy5QQ0kwLlBFNjYuX1NUQV0KKE5vZGUgQjEyRjJFRDgpLCBBRV9FUlJP
Ujxicj4KQUNQSSBFeGNlcHRpb246IEFFX0VSUk9SLCBSZXR1cm5lZCBieSBIYW5kbGVyIGZvciBb
UENJX0NvbmZpZ10KKDIwMDkxMjE0L2V2cmVnaW9uLTU4OCk8YnI+CkFDUEkgRXJyb3IgKHBzcGFy
c2UtMDYzMyk6IE1ldGhvZCBwYXJzZS9leGVjdXRpb24gZmFpbGVkIFtcX1NCXy5QQ0kwLlBFNjcu
X1NUQV0KKE5vZGUgQjEyRjJBODApLCBBRV9FUlJPUjxicj4KQUNQSSBFeGNlcHRpb246IEFFX0VS
Uk9SLCBSZXR1cm5lZCBieSBIYW5kbGVyIGZvciBbUENJX0NvbmZpZ10KKDIwMDkxMjE0L2V2cmVn
aW9uLTU4OCk8YnI+CkFDUEkgRXJyb3IgKHBzcGFyc2UtMDYzMyk6IE1ldGhvZCBwYXJzZS9leGVj
dXRpb24gZmFpbGVkIFtcX1NCXy5QQ0kwLlBFNzEuX1NUQV0KKE5vZGUgQjEyRjI2MjgpLCBBRV9F
UlJPUjxicj4KQUNQSSBFeGNlcHRpb246IEFFX0VSUk9SLCBSZXR1cm5lZCBieSBIYW5kbGVyIGZv
ciBbUENJX0NvbmZpZ10KKDIwMDkxMjE0L2V2cmVnaW9uLTU4OCk8YnI+CkFDUEkgRXJyb3IgKHBz
cGFyc2UtMDYzMyk6IE1ldGhvZCBwYXJzZS9leGVjdXRpb24gZmFpbGVkIFtcX1NCXy5QQ0kwLlBF
NzIuX1NUQV0KKE5vZGUgQjEyRjIxRDApLCBBRV9FUlJPUjxicj4KQUNQSSBFeGNlcHRpb246IEFF
X0VSUk9SLCBSZXR1cm5lZCBieSBIYW5kbGVyIGZvciBbUENJX0NvbmZpZ10KKDIwMDkxMjE0L2V2
cmVnaW9uLTU4OCk8YnI+CkFDUEkgRXJyb3IgKHBzcGFyc2UtMDYzMyk6IE1ldGhvZCBwYXJzZS9l
eGVjdXRpb24gZmFpbGVkIFtcX1NCXy5QQ0kwLlBFNzMuX1NUQV0KKE5vZGUgQjEyRjFENjgpLCBB
RV9FUlJPUjxicj4KQUNQSSBFeGNlcHRpb246IEFFX0VSUk9SLCBSZXR1cm5lZCBieSBIYW5kbGVy
IGZvciBbUENJX0NvbmZpZ10KKDIwMDkxMjE0L2V2cmVnaW9uLTU4OCk8YnI+CkFDUEkgRXJyb3Ig
KHBzcGFyc2UtMDYzMyk6IE1ldGhvZCBwYXJzZS9leGVjdXRpb24gZmFpbGVkIFtcX1NCXy5QQ0kw
LlBFNzQuX1NUQV0KKE5vZGUgQjEyRjE5MTApLCBBRV9FUlJPUjxicj4KQUNQSSBFeGNlcHRpb246
IEFFX0VSUk9SLCBSZXR1cm5lZCBieSBIYW5kbGVyIGZvciBbUENJX0NvbmZpZ10KKDIwMDkxMjE0
L2V2cmVnaW9uLTU4OCk8YnI+CkFDUEkgRXJyb3IgKHBzcGFyc2UtMDYzMyk6IE1ldGhvZCBwYXJz
ZS9leGVjdXRpb24gZmFpbGVkIFtcX1NCXy5QQ0kwLlBFNzUuX1NUQV0KKE5vZGUgQjEyRjE0Qjgp
LCBBRV9FUlJPUjxicj4KQUNQSSBFeGNlcHRpb246IEFFX0VSUk9SLCBSZXR1cm5lZCBieSBIYW5k
bGVyIGZvciBbUENJX0NvbmZpZ10KKDIwMDkxMjE0L2V2cmVnaW9uLTU4OCk8YnI+CkFDUEkgRXJy
b3IgKHBzcGFyc2UtMDYzMyk6IE1ldGhvZCBwYXJzZS9leGVjdXRpb24gZmFpbGVkIFtcX1NCXy5Q
Q0kwLlBFNzYuX1NUQV0KKE5vZGUgQjEyRjEwNjApLCBBRV9FUlJPUjxicj4KQUNQSSBFeGNlcHRp
b246IEFFX0VSUk9SLCBSZXR1cm5lZCBieSBIYW5kbGVyIGZvciBbUENJX0NvbmZpZ10KKDIwMDkx
MjE0L2V2cmVnaW9uLTU4OCk8YnI+CkFDUEkgRXJyb3IgKHBzcGFyc2UtMDYzMyk6IE1ldGhvZCBw
YXJzZS9leGVjdXRpb24gZmFpbGVkIFtcX1NCXy5QQ0kwLlBFNzcuX1NUQV0KKE5vZGUgQjEyRjBD
MTApLCBBRV9FUlJPUjxicj4KQUNQSSBFeGNlcHRpb246IEFFX0VSUk9SLCBSZXR1cm5lZCBieSBI
YW5kbGVyIGZvciBbUENJX0NvbmZpZ10KKDIwMDkxMjE0L2V2cmVnaW9uLTU4OCk8YnI+CkFDUEkg
RXJyb3IgKHBzcGFyc2UtMDYzMyk6IE1ldGhvZCBwYXJzZS9leGVjdXRpb24gZmFpbGVkIFtcX1NC
Xy5QQ0kwLlBFODEuX1NUQV0KKE5vZGUgQjEyRjA3QjgpLCBBRV9FUlJPUjxicj4KQUNQSSBFeGNl
cHRpb246IEFFX0VSUk9SLCBSZXR1cm5lZCBieSBIYW5kbGVyIGZvciBbUENJX0NvbmZpZ10KKDIw
MDkxMjE0L2V2cmVnaW9uLTU4OCk8YnI+CkFDUEkgRXJyb3IgKHBzcGFyc2UtMDYzMyk6IE1ldGhv
ZCBwYXJzZS9leGVjdXRpb24gZmFpbGVkIFtcX1NCXy5QQ0kwLlBFODIuX1NUQV0KKE5vZGUgQjEy
RjAzNjApLCBBRV9FUlJPUjxicj4KQUNQSSBFeGNlcHRpb246IEFFX0VSUk9SLCBSZXR1cm5lZCBi
eSBIYW5kbGVyIGZvciBbUENJX0NvbmZpZ10KKDIwMDkxMjE0L2V2cmVnaW9uLTU4OCk8YnI+CkFD
UEkgRXJyb3IgKHBzcGFyc2UtMDYzMyk6IE1ldGhvZCBwYXJzZS9leGVjdXRpb24gZmFpbGVkIFtc
X1NCXy5QQ0kwLlBFODMuX1NUQV0KKE5vZGUgQjEyRUZFRDgpLCBBRV9FUlJPUjxicj4KQUNQSSBF
eGNlcHRpb246IEFFX0VSUk9SLCBSZXR1cm5lZCBieSBIYW5kbGVyIGZvciBbUENJX0NvbmZpZ10K
KDIwMDkxMjE0L2V2cmVnaW9uLTU4OCk8YnI+CkFDUEkgRXJyb3IgKHBzcGFyc2UtMDYzMyk6IE1l
dGhvZCBwYXJzZS9leGVjdXRpb24gZmFpbGVkIFtcX1NCXy5QQ0kwLlBFODQuX1NUQV0KKE5vZGUg
QjEyRUZBODApLCBBRV9FUlJPUjxicj4KQUNQSSBFeGNlcHRpb246IEFFX0VSUk9SLCBSZXR1cm5l
ZCBieSBIYW5kbGVyIGZvciBbUENJX0NvbmZpZ10KKDIwMDkxMjE0L2V2cmVnaW9uLTU4OCk8YnI+
CkFDUEkgRXJyb3IgKHBzcGFyc2UtMDYzMyk6IE1ldGhvZCBwYXJzZS9leGVjdXRpb24gZmFpbGVk
IFtcX1NCXy5QQ0kwLlBFODUuX1NUQV0KKE5vZGUgQjEyRUY2MjgpLCBBRV9FUlJPUjxicj4KQUNQ
SSBFeGNlcHRpb246IEFFX0VSUk9SLCBSZXR1cm5lZCBieSBIYW5kbGVyIGZvciBbUENJX0NvbmZp
Z10KKDIwMDkxMjE0L2V2cmVnaW9uLTU4OCk8YnI+CkFDUEkgRXJyb3IgKHBzcGFyc2UtMDYzMyk6
IE1ldGhvZCBwYXJzZS9leGVjdXRpb24gZmFpbGVkIFtcX1NCXy5QQ0kwLlBFODYuX1NUQV0KKE5v
ZGUgQjEyRUYxRDApLCBBRV9FUlJPUjxicj4KQUNQSSBFeGNlcHRpb246IEFFX0VSUk9SLCBSZXR1
cm5lZCBieSBIYW5kbGVyIGZvciBbUENJX0NvbmZpZ10KKDIwMDkxMjE0L2V2cmVnaW9uLTU4OCk8
YnI+CkFDUEkgRXJyb3IgKHBzcGFyc2UtMDYzMyk6IE1ldGhvZCBwYXJzZS9leGVjdXRpb24gZmFp
bGVkIFtcX1NCXy5QQ0kwLlBFODcuX1NUQV0KKE5vZGUgQjEyRUVENjgpLCBBRV9FUlJPUjxicj4K
QUNQSSBFeGNlcHRpb246IEFFX0VSUk9SLCBSZXR1cm5lZCBieSBIYW5kbGVyIGZvciBbUENJX0Nv
bmZpZ10KKDIwMDkxMjE0L2V2cmVnaW9uLTU4OCk8YnI+CkFDUEkgRXJyb3IgKHBzcGFyc2UtMDYz
Myk6IE1ldGhvZCBwYXJzZS9leGVjdXRpb24gZmFpbGVkIFtcX1NCXy5QQ0kwLlBFOTEuX1NUQV0K
KE5vZGUgQjEyRUU5MTApLCBBRV9FUlJPUjxicj4KQUNQSSBFeGNlcHRpb246IEFFX0VSUk9SLCBS
ZXR1cm5lZCBieSBIYW5kbGVyIGZvciBbUENJX0NvbmZpZ10KKDIwMDkxMjE0L2V2cmVnaW9uLTU4
OCk8YnI+CkFDUEkgRXJyb3IgKHBzcGFyc2UtMDYzMyk6IE1ldGhvZCBwYXJzZS9leGVjdXRpb24g
ZmFpbGVkIFtcX1NCXy5QQ0kwLlBFOTIuX1NUQV0KKE5vZGUgQjEyRUU0QjgpLCBBRV9FUlJPUjxi
cj4KQUNQSSBFeGNlcHRpb246IEFFX0VSUk9SLCBSZXR1cm5lZCBieSBIYW5kbGVyIGZvciBbUENJ
X0NvbmZpZ10KKDIwMDkxMjE0L2V2cmVnaW9uLTU4OCk8YnI+CkFDUEkgRXJyb3IgKHBzcGFyc2Ut
MDYzMyk6IE1ldGhvZCBwYXJzZS9leGVjdXRpb24gZmFpbGVkIFtcX1NCXy5QQ0kwLlBFOTMuX1NU
QV0KKE5vZGUgQjEyRUUwNjApLCBBRV9FUlJPUjxicj4KQUNQSSBFeGNlcHRpb246IEFFX0VSUk9S
LCBSZXR1cm5lZCBieSBIYW5kbGVyIGZvciBbUENJX0NvbmZpZ10KKDIwMDkxMjE0L2V2cmVnaW9u
LTU4OCk8YnI+CkFDUEkgRXJyb3IgKHBzcGFyc2UtMDYzMyk6IE1ldGhvZCBwYXJzZS9leGVjdXRp
b24gZmFpbGVkIFtcX1NCXy5QQ0kwLlBFOTQuX1NUQV0KKE5vZGUgQjEyRURDMTApLCBBRV9FUlJP
Ujxicj4KQUNQSSBFeGNlcHRpb246IEFFX0VSUk9SLCBSZXR1cm5lZCBieSBIYW5kbGVyIGZvciBb
UENJX0NvbmZpZ10KKDIwMDkxMjE0L2V2cmVnaW9uLTU4OCk8YnI+CkFDUEkgRXJyb3IgKHBzcGFy
c2UtMDYzMyk6IE1ldGhvZCBwYXJzZS9leGVjdXRpb24gZmFpbGVkIFtcX1NCXy5QQ0kwLlBFOTUu
X1NUQV0KKE5vZGUgQjEyRUQ3QjgpLCBBRV9FUlJPUjxicj4KQUNQSSBFeGNlcHRpb246IEFFX0VS
Uk9SLCBSZXR1cm5lZCBieSBIYW5kbGVyIGZvciBbUENJX0NvbmZpZ10KKDIwMDkxMjE0L2V2cmVn
aW9uLTU4OCk8YnI+CkFDUEkgRXJyb3IgKHBzcGFyc2UtMDYzMyk6IE1ldGhvZCBwYXJzZS9leGVj
dXRpb24gZmFpbGVkIFtcX1NCXy5QQ0kwLlBFOTYuX1NUQV0KKE5vZGUgQjEyRUQzNjApLCBBRV9F
UlJPUjxicj4KQUNQSSBFeGNlcHRpb246IEFFX0VSUk9SLCBSZXR1cm5lZCBieSBIYW5kbGVyIGZv
ciBbUENJX0NvbmZpZ10KKDIwMDkxMjE0L2V2cmVnaW9uLTU4OCk8YnI+CkFDUEkgRXJyb3IgKHBz
cGFyc2UtMDYzMyk6IE1ldGhvZCBwYXJzZS9leGVjdXRpb24gZmFpbGVkIFtcX1NCXy5QQ0kwLlBF
OTcuX1NUQV0KKE5vZGUgQjEyRUNFRDgpLCBBRV9FUlJPUjxicj4KQUNQSSBFeGNlcHRpb246IEFF
X0VSUk9SLCBSZXR1cm5lZCBieSBIYW5kbGVyIGZvciBbUENJX0NvbmZpZ10KKDIwMDkxMjE0L2V2
cmVnaW9uLTU4OCk8YnI+CkFDUEkgRXJyb3IgKHBzcGFyc2UtMDYzMyk6IE1ldGhvZCBwYXJzZS9l
eGVjdXRpb24gZmFpbGVkIFtcX1NCXy5QQ0kwLlBFQTEuX1NUQV0KKE5vZGUgQjEyRUNBODApLCBB
RV9FUlJPUjxicj4KQUNQSSBFeGNlcHRpb246IEFFX0VSUk9SLCBSZXR1cm5lZCBieSBIYW5kbGVy
IGZvciBbUENJX0NvbmZpZ10gKDIwMDkxMjE0L2V2cmVnaW9uLTU4OCk8YnI+CkFDUEkgRXJyb3Ig
KHBzcGFyc2UtMDYzMyk6IE1ldGhvZCBwYXJzZS9leGVjdXRpb24gZmFpbGVkIFtcX1NCXy5QQ0kw
LlBFQTIuX1NUQV0KKE5vZGUgQjEyRUM2MjgpLCBBRV9FUlJPUjxicj4KQUNQSSBFeGNlcHRpb246
IEFFX0VSUk9SLCBSZXR1cm5lZCBieSBIYW5kbGVyIGZvciBbUENJX0NvbmZpZ10KKDIwMDkxMjE0
L2V2cmVnaW9uLTU4OCk8YnI+CkFDUEkgRXJyb3IgKHBzcGFyc2UtMDYzMyk6IE1ldGhvZCBwYXJz
ZS9leGVjdXRpb24gZmFpbGVkIFtcX1NCXy5QQ0kwLlBFQTMuX1NUQV0KKE5vZGUgQjEyRUMxRDAp
LCBBRV9FUlJPUjxicj4KQUNQSSBFeGNlcHRpb246IEFFX0VSUk9SLCBSZXR1cm5lZCBieSBIYW5k
bGVyIGZvciBbUENJX0NvbmZpZ10KKDIwMDkxMjE0L2V2cmVnaW9uLTU4OCk8YnI+CkFDUEkgRXJy
b3IgKHBzcGFyc2UtMDYzMyk6IE1ldGhvZCBwYXJzZS9leGVjdXRpb24gZmFpbGVkIFtcX1NCXy5Q
Q0kwLlBFQTQuX1NUQV0KKE5vZGUgQjEyRUJENjgpLCBBRV9FUlJPUjxicj4KQUNQSSBFeGNlcHRp
b246IEFFX0VSUk9SLCBSZXR1cm5lZCBieSBIYW5kbGVyIGZvciBbUENJX0NvbmZpZ10KKDIwMDkx
MjE0L2V2cmVnaW9uLTU4OCk8YnI+CkFDUEkgRXJyb3IgKHBzcGFyc2UtMDYzMyk6IE1ldGhvZCBw
YXJzZS9leGVjdXRpb24gZmFpbGVkIFtcX1NCXy5QQ0kwLlBFQTUuX1NUQV0KKE5vZGUgQjEyRUI5
MTApLCBBRV9FUlJPUjxicj4KQUNQSSBFeGNlcHRpb246IEFFX0VSUk9SLCBSZXR1cm5lZCBieSBI
YW5kbGVyIGZvciBbUENJX0NvbmZpZ10gKDIwMDkxMjE0L2V2cmVnaW9uLTU4OCk8YnI+CkFDUEkg
RXJyb3IgKHBzcGFyc2UtMDYzMyk6IE1ldGhvZCBwYXJzZS9leGVjdXRpb24gZmFpbGVkIFtcX1NC
Xy5QQ0kwLlBFQTYuX1NUQV0KKE5vZGUgQjEyRUI0QjgpLCBBRV9FUlJPUjxicj4KQUNQSSBFeGNl
cHRpb246IEFFX0VSUk9SLCBSZXR1cm5lZCBieSBIYW5kbGVyIGZvciBbUENJX0NvbmZpZ10KKDIw
MDkxMjE0L2V2cmVnaW9uLTU4OCk8YnI+CkFDUEkgRXJyb3IgKHBzcGFyc2UtMDYzMyk6IE1ldGhv
ZCBwYXJzZS9leGVjdXRpb24gZmFpbGVkIFtcX1NCXy5QQ0kwLlBFQTcuX1NUQV0KKE5vZGUgQjEy
RUIwNjApLCBBRV9FUlJPUjxicj4KQUNQSSBFeGNlcHRpb246IEFFX0VSUk9SLCBSZXR1cm5lZCBi
eSBIYW5kbGVyIGZvciBbUENJX0NvbmZpZ10KKDIwMDkxMjE0L2V2cmVnaW9uLTU4OCk8YnI+CkFD
UEkgRXJyb3IgKHBzcGFyc2UtMDYzMyk6IE1ldGhvZCBwYXJzZS9leGVjdXRpb24gZmFpbGVkIFtc
X1NCXy5QQ0kwLlBFQjEuX1NUQV0KKE5vZGUgQjEyRUFDMTApLCBBRV9FUlJPUjxicj4KQUNQSSBF
eGNlcHRpb246IEFFX0VSUk9SLCBSZXR1cm5lZCBieSBIYW5kbGVyIGZvciBbUENJX0NvbmZpZ10K
KDIwMDkxMjE0L2V2cmVnaW9uLTU4OCk8YnI+CkFDUEkgRXJyb3IgKHBzcGFyc2UtMDYzMyk6IE1l
dGhvZCBwYXJzZS9leGVjdXRpb24gZmFpbGVkIFtcX1NCXy5QQ0kwLlBFQjIuX1NUQV0KKE5vZGUg
QjEyRUE3QjgpLCBBRV9FUlJPUjxicj4KQUNQSSBFeGNlcHRpb246IEFFX0VSUk9SLCBSZXR1cm5l
ZCBieSBIYW5kbGVyIGZvciBbUENJX0NvbmZpZ10gKDIwMDkxMjE0L2V2cmVnaW9uLTU4OCk8YnI+
CkFDUEkgRXJyb3IgKHBzcGFyc2UtMDYzMyk6IE1ldGhvZCBwYXJzZS9leGVjdXRpb24gZmFpbGVk
IFtcX1NCXy5QQ0kwLlBFQjMuX1NUQV0KKE5vZGUgQjEyRUEzNjApLCBBRV9FUlJPUjxicj4KQUNQ
SSBFeGNlcHRpb246IEFFX0VSUk9SLCBSZXR1cm5lZCBieSBIYW5kbGVyIGZvciBbUENJX0NvbmZp
Z10KKDIwMDkxMjE0L2V2cmVnaW9uLTU4OCk8YnI+CkFDUEkgRXJyb3IgKHBzcGFyc2UtMDYzMyk6
IE1ldGhvZCBwYXJzZS9leGVjdXRpb24gZmFpbGVkIFtcX1NCXy5QQ0kwLlBFQjQuX1NUQV0KKE5v
ZGUgQjEyRTlFRDgpLCBBRV9FUlJPUjxicj4KQUNQSSBFeGNlcHRpb246IEFFX0VSUk9SLCBSZXR1
cm5lZCBieSBIYW5kbGVyIGZvciBbUENJX0NvbmZpZ10KKDIwMDkxMjE0L2V2cmVnaW9uLTU4OCk8
YnI+CkFDUEkgRXJyb3IgKHBzcGFyc2UtMDYzMyk6IE1ldGhvZCBwYXJzZS9leGVjdXRpb24gZmFp
bGVkIFtcX1NCXy5QQ0kwLlBFQjUuX1NUQV0KKE5vZGUgQjEyRTlBODApLCBBRV9FUlJPUjxicj4K
QUNQSSBFeGNlcHRpb246IEFFX0VSUk9SLCBSZXR1cm5lZCBieSBIYW5kbGVyIGZvciBbUENJX0Nv
bmZpZ10KKDIwMDkxMjE0L2V2cmVnaW9uLTU4OCk8YnI+CkFDUEkgRXJyb3IgKHBzcGFyc2UtMDYz
Myk6IE1ldGhvZCBwYXJzZS9leGVjdXRpb24gZmFpbGVkIFtcX1NCXy5QQ0kwLlBFQjYuX1NUQV0K
KE5vZGUgQjEyRTk2MjgpLCBBRV9FUlJPUjxicj4KQUNQSSBFeGNlcHRpb246IEFFX0VSUk9SLCBS
ZXR1cm5lZCBieSBIYW5kbGVyIGZvciBbUENJX0NvbmZpZ10gKDIwMDkxMjE0L2V2cmVnaW9uLTU4
OCk8YnI+CkFDUEkgRXJyb3IgKHBzcGFyc2UtMDYzMyk6IE1ldGhvZCBwYXJzZS9leGVjdXRpb24g
ZmFpbGVkIFtcX1NCXy5QQ0kwLlBFQjcuX1NUQV0KKE5vZGUgQjEyRTkxRDApLCBBRV9FUlJPUjxi
cj4KUHVUVFlFbnRlcmVkIGRlYnVnZ2VyIG9uIGxhc3QtY2hhbmNlIGV4Y2VwdGlvbiAoRXhjZXB0
aW9uIENvZGU6IDB4YzAwMDAwMDUpCihQYWdlIEZhdWx0KTxicj4KTWVtb3J5IGF0IDB4MDAwMDAw
MDAgY291bGQgbm90IGJlIHJlYWQ6IFBhZ2Ugbm90IHByZXNlbnQuPGJyPgo8YnI+CjxvOnA+PC9v
OnA+PC9zcGFuPjwvZm9udD48L3A+Cgo8ZGl2IGNsYXNzPU1zb05vcm1hbCBhbGlnbj1jZW50ZXIg
c3R5bGU9J3RleHQtYWxpZ246Y2VudGVyJz48Zm9udCBzaXplPTIKZmFjZT1WZXJkYW5hPjxzcGFu
IHN0eWxlPSdmb250LXNpemU6MTAuMHB0O2ZvbnQtZmFtaWx5OlZlcmRhbmEnPgoKPGhyIHNpemU9
MiB3aWR0aD0iMTAwJSIgYWxpZ249Y2VudGVyPgoKPC9zcGFuPjwvZm9udD48L2Rpdj4KCjxwIGNs
YXNzPU1zb05vcm1hbD48Zm9udCBzaXplPTIgZmFjZT1WZXJkYW5hPjxzcGFuIHN0eWxlPSdmb250
LXNpemU6MTAuMHB0Owpmb250LWZhbWlseTpWZXJkYW5hJz5Ib3RtYWlsOiBUcnVzdGVkIGVtYWls
IHdpdGggcG93ZXJmdWwgU1BBTSBwcm90ZWN0aW9uLiA8YQpocmVmPSJodHRwczovL3NpZ251cC5s
aXZlLmNvbS9zaWdudXAuYXNweD9pZD02MDk2OSIgdGFyZ2V0PSJfbmV3Ij5TaWduIHVwIG5vdy48
L2E+PG86cD48L286cD48L3NwYW4+PC9mb250PjwvcD4KCjwvZGl2PgoKPC9kaXY+Cgo8L2JvZHk+
Cgo8L2h0bWw+Cg==

--===============8638766198116861347==--

