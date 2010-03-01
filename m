Content-Type: multipart/mixed; boundary="===============7020800603254088616=="
MIME-Version: 1.0
From: Samuel Serapion <samcharly at hotmail.com>
Subject: [Devel] Unable to boot in vmware 7
Date: Mon, 01 Mar 2010 16:00:12 -0500
Message-ID: <SNT111-W18E3DB498C6E31271E926DBD3C0@phx.gbl>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============7020800603254088616==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



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

 		 	   		  =

_________________________________________________________________
Hotmail: Trusted email with powerful SPAM protection.
https://signup.live.com/signup.aspx?id=3D60969

--===============7020800603254088616==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGh0bWw+CjxoZWFkPgo8c3R5bGU+PCEtLQouaG1tZXNzYWdlIFAKewptYXJnaW46MHB4OwpwYWRk
aW5nOjBweAp9CmJvZHkuaG1tZXNzYWdlCnsKZm9udC1zaXplOiAxMHB0Owpmb250LWZhbWlseTpW
ZXJkYW5hCn0KLS0+PC9zdHlsZT4KPC9oZWFkPgo8Ym9keSBjbGFzcz0naG1tZXNzYWdlJz4KPGJy
PkhlbGxvLCBpJ3ZlIGJlZW4gZGV2ZWxvcGluZyBhIGRyaXZlciBiYXNlZCBvbiBhY3BpY2EgYW5k
IGxpbnV4IGFjcGkgZm9yIFJlYWN0T1MsIHlvdSBjYW4gZmluZCB0aGUgc291cmNlIGNvZGUgaGVy
ZTogaHR0cDovL2dpdC5yZWFjdG9zLm9yZy8/cD1yZWFjdG9zLmdpdDthPXRyZWU7Zj1yZWFjdG9z
L2RyaXZlcnMvYnVzL2FjcGk7aGI9SEVBRDxicj48YnI+SG93ZXZlciBJIGhhdmUgYmVlbiB1bmFi
bGUgdG8gYm9vdCBpbiB2bXdhcmUgNywgeW91IGNhbiBmaW5kIHRoZSBhY3BpY2EgaW5pdCBzZXF1
ZW5jZSBoZXJlOiBodHRwOi8vZ2l0LnJlYWN0b3Mub3JnLz9wPXJlYWN0b3MuZ2l0O2E9YmxvYjtm
PXJlYWN0b3MvZHJpdmVycy9idXMvYWNwaS9wbnAuYztoYj1IRUFEI2wyNzAgLiBJIGhhdmUgbm8g
aWRlYSB3aGF0cyBnb2luZyB3cm9uZywgcGxlYXNlIGhlbHAgbWUgZGVidWcgdGhpcyBpc3N1ZS48
YnI+PGJyPjxicj4obnRvc2tybmxca2Rca2Rpby5jOjI5NykgLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS08YnI+KG50b3Nrcm5sXGtkXGtkaW8uYzoy
OTgpIFJlYWN0T1MgMC40LVNWTiAoQnVpbGQgMjAxMDAyMjgtcjQ1NzI2KTxicj4obnRvc2tybmxc
a2Rca2Rpby5jOjI5OSkgQ29tbWFuZCBMaW5lOiAvTk9HVUlCT09UIC9ERUJVR1BPUlQ9Q09NMTxi
cj4obnRvc2tybmxca2Rca2Rpby5jOjMwMykgQVJDIFBhdGhzOiBtdWx0aSgwKWRpc2soMCljZHJv
bSgxNTkpIFwgbXVsdGkoMClkaXNrKDApY2Ryb20oMTU5KSBccmVhY3Rvc1w8YnI+KG50b3Nrcm5s
XGtlXGkzODZcY3B1LmM6NzQ2KSBQcmVmZXRjaCBDYWNoZTogNjQgYnl0ZXMmbmJzcDsmbmJzcDsg
TDIgQ2FjaGU6IDUyNDI4OCBieXRlcyBMMiBDYWNoZSBMaW5lOiA2NCBieXRlcyZuYnNwOyBMMiBD
YWNoZSBBc3NvY2lhdGl2aXR5OiAxNjxicj5XQVJOSU5HOiZuYnNwOyBIYWxTdG9wUHJvZmlsZUlu
dGVycnVwdCBhdCBoYWxcaGFseDg2XGdlbmVyaWNccHJvZmlsLmM6MjQgaXMgVU5JTVBMRU1FTlRF
RCE8YnI+KG50b3Nrcm5sXG1tXG1taW5pdC5jOjI4OSkmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgMHg4MDAwMDAwMCAtIDB4ODEwMDAw
MDAmbmJzcDsmbmJzcDsmbmJzcDsgQm9vdCBMb2FkZWQgSW1hZ2U8YnI+KG50b3Nrcm5sXG1tXG1t
aW5pdC5jOjI5MykmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsgMHg4MTAwMDAwMCAtIDB4ODc0MDAwMDAmbmJzcDsmbmJzcDsmbmJzcDsg
UGFnZWQgUG9vbDxicj4obnRvc2tybmxcbW1cbW1pbml0LmM6Mjk3KSZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyAweEIwMDAwMDAwIC0g
MHhCMDYwMTAwMCZuYnNwOyZuYnNwOyZuYnNwOyBQRk4gRGF0YWJhc2U8YnI+KG50b3Nrcm5sXG1t
XG1taW5pdC5jOjMwMSkmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsgMHhCMDYwMTAwMCAtIDB4QjE1QzkwMDAmbmJzcDsmbmJzcDsmbmJz
cDsgQVJNwrMgTm9uIFBhZ2VkIFBvb2w8YnI+KG50b3Nrcm5sXG1tXG1taW5pdC5jOjMwNSkmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsg
MHhCQzAwMDAwMCAtIDB4QkQwMDAwMDAmbmJzcDsmbmJzcDsmbmJzcDsgU3lzdGVtIFZpZXcgU3Bh
Y2U8YnI+KG50b3Nrcm5sXG1tXG1taW5pdC5jOjMwOSkmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgMHhCRDAwMDAwMCAtIDB4QzAwMDAw
MDAmbmJzcDsmbmJzcDsmbmJzcDsgU2Vzc2lvbiBTcGFjZTxicj4obnRvc2tybmxcbW1cbW1pbml0
LmM6MzEyKSZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyAweEMwMDAwMDAwIC0gMHhDMDMwMDAwMCZuYnNwOyZuYnNwOyZuYnNwOyBQYWdl
IFRhYmxlczxicj4obnRvc2tybmxcbW1cbW1pbml0LmM6MzE1KSZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyAweEMwMzAwMDAwIC0gMHhD
MDQwMDAwMCZuYnNwOyZuYnNwOyZuYnNwOyBQYWdlIERpcmVjdG9yaWVzPGJyPihudG9za3JubFxt
bVxtbWluaXQuYzozMTgpJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7IDB4QzA0MDAwMDAgLSAweEMwODAwMDAwJm5ic3A7Jm5ic3A7Jm5i
c3A7IEh5cGVyc3BhY2U8YnI+KG50b3Nrcm5sXG1tXG1taW5pdC5jOjMyMikmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgMHhFMTAwMDAw
MCAtIDB4RjEwMDAwMDAmbmJzcDsmbmJzcDsmbmJzcDsgQVJNwrMgUGFnZWQgUG9vbDxicj4obnRv
c2tybmxcbW1cbW1pbml0LmM6MzI1KSZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyAweEYzNDAwMDAwIC0gMHhGOEJBODAwMCZuYnNwOyZu
YnNwOyZuYnNwOyBTeXN0ZW0gUFRFIFNwYWNlPGJyPihudG9za3JubFxtbVxtbWluaXQuYzozMjgp
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7IDB4RjhCQTgwMDAgLSAweEZGQkUwMDAwJm5ic3A7Jm5ic3A7Jm5ic3A7IE5vbiBQYWdlZCBQ
b29sIEV4cGFuc2lvbiBQVEUgU3BhY2U8YnI+KG50b3Nrcm5sXGtlXGkzODZca2lpbml0LmM6NTMp
IExhcmdlIFBhZ2Ugc3VwcG9ydCBkZXRlY3RlZCBidXQgbm90IHlldCB0YWtlbiBhZHZhbnRhZ2Ug
b2Y8YnI+KG50b3Nrcm5sXGtlXGkzODZccGF0cGdlLmM6NDUpIEdsb2JhbCBwYWdlIHN1cHBvcnQg
ZGV0ZWN0ZWQgYnV0IG5vdCB5ZXQgdGFrZW4gYWR2YW50YWdlIG9mPGJyPihudG9za3JubFxrZVxp
Mzg2XHBhdHBnZS5jOjU4KSBQQVQgc3VwcG9ydCBkZXRlY3RlZCBidXQgbm90IHlldCB0YWtlbiBh
ZHZhbnRhZ2Ugb2Y8YnI+KG50b3Nrcm5sXGtlXGkzODZcbXRyci5jOjI0KSBNVFJSIHN1cHBvcnQg
ZGV0ZWN0ZWQgYnV0IG5vdCB5ZXQgdGFrZW4gYWR2YW50YWdlIG9mPGJyPlBDIENvbXBhdGlibGUg
RWlzYS9Jc2EgSEFMIGhhcyBiZWVuIGluaXRpYWxpemVkPGJyPldBUk5JTkc6Jm5ic3A7IElvUmVw
b3J0UmVzb3VyY2VVc2FnZSBhdCBudG9za3JubFxpb1xpb21nclxpb3JzcmNlLmM6NzAwIGlzIFVO
SU1QTEVNRU5URUQhPGJyPldBUk5JTkc6Jm5ic3A7IElvUmVwb3J0UmVzb3VyY2VVc2FnZSBhdCBu
dG9za3JubFxpb1xpb21nclxpb3JzcmNlLmM6NzAwIGlzIFVOSU1QTEVNRU5URUQhPGJyPihudG9z
a3JubFxpb1xpb21nclxmaWxlLmM6NDIwKSBVc2luZyBJb3BQYXJzZURldmljZSgpIGhhY2suIFJl
cXVlc3RlZCBpbnZhbGlkIGF0dHJpYnV0ZXM6IDE8YnI+KG50b3Nrcm5sXGZzdHViXGRpc2tzdXAu
YzoyNTMpIFp3T3BlblN5bWJvbGljTGlua09iamVjdCBmYWlsZWQgZm9yIFxBcmNOYW1lXG11bHRp
KDApZGlzaygwKXJkaXNrKDEpLCBzdGF0dXM9YzAwMDAwMzQ8YnI+KG50b3Nrcm5sXGZzdHViXGRp
c2tzdXAuYzoyNTMpIFp3T3BlblN5bWJvbGljTGlua09iamVjdCBmYWlsZWQgZm9yIFxBcmNOYW1l
XG11bHRpKDApZGlzaygwKXJkaXNrKDEpLCBzdGF0dXM9YzAwMDAwMzQ8YnI+KGRyaXZlcnNcYnVz
XGFjcGlcbWFpbi5jOjIwNikgRHJpdmVyIEVudHJ5PGJyPihkcml2ZXJzXGJ1c1xhY3BpXG1haW4u
YzozNikgQWRkIERldmljZTogMHhCMTM2QzZGODxicj4oZHJpdmVyc1xidXNcYWNwaVxtYWluLmM6
MzgpICMjIyMjIyMjIyMjIyMjIyMjIyMjIEJ1c19DcmVhdGVDbG9zZSBDcmVhdGluZyBGRE8gRGV2
aWNlICMjIyMjIyMjIyMjIyMjIyMjIyMjPGJyPihkcml2ZXJzXGJ1c1xhY3BpXG1haW4uYzoxNDEp
IEFkZERldmljZTogQjEzNENDNzAgdG8gQjEzNkM2RjgtJmd0O0IxMzZDNkY4IChSb290XCpQTlAw
QzA4XDAwMDApPGJyPihkcml2ZXJzXGJ1c1xhY3BpXHBucC5jOjQ3KSBGRE8gSVJQX01OX0ZJTFRF
Ul9SRVNPVVJDRV9SRVFVSVJFTUVOVFMgSVJQOjB4QjEzNTc5RTA8YnI+KGRyaXZlcnNcYnVzXGFj
cGlccG5wLmM6NDcpIEZETyBJUlBfTU5fU1RBUlRfREVWSUNFIElSUDoweEIxMzU3OUUwPGJyPkFD
UEk6IFJTRFAgMDAwRjY5NDAgMDAwMjQgKHYwMiBQVExURCApPGJyPkFDUEk6IFhTRFQgMUZFRjA4
ODUgMDAwNEMgKHYwMSBJTlRFTCZuYnNwOyA0NDBCWCZuYnNwOyZuYnNwOyZuYnNwOyAwNjA0MDAw
MCBWTVcmbmJzcDsgMDEzMjQyNzIpPGJyPkFDUEk6IEZBQ1AgMUZFRkVFOTggMDAwRjQgKHYwNCBJ
TlRFTCZuYnNwOyA0NDBCWCZuYnNwOyZuYnNwOyZuYnNwOyAwNjA0MDAwMCBQVEwmbmJzcDsgMDAw
RjQyNDApPGJyPkFDUEk6IERTRFQgMUZFRjBBM0QgMEU0NUIgKHYwMSBQVExURCZuYnNwOyBDdXN0
b20mbmJzcDsmbmJzcDsgMDYwNDAwMDAgTVNGVCAwMzAwMDAwMSk8YnI+QUNQSTogRkFDUyAxRkVG
RkZDMCAwMDA0MDxicj5BQ1BJOiBCT09UIDFGRUYwQTE1IDAwMDI4ICh2MDEgUFRMVEQmbmJzcDsg
JFNCRlRCTCQgMDYwNDAwMDAmbmJzcDsgTFRQIDAwMDAwMDAxKTxicj5BQ1BJOiBBUElDIDFGRUYw
OUM1IDAwMDUwICh2MDEgUFRMVEQmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgQVBJQyZuYnNwOyZu
YnNwOyAwNjA0MDAwMCZuYnNwOyBMVFAgMDAwMDAwMDApPGJyPkFDUEk6IE1DRkcgMUZFRjA5ODkg
MDAwM0MgKHYwMSBQVExURCZuYnNwOyAkUENJVEJMJCAwNjA0MDAwMCZuYnNwOyBMVFAgMDAwMDAw
MDEpPGJyPkFDUEk6IFNSQVQgMUZFRjA5MDkgMDAwODAgKHYwMiBWTVdBUkUgTUVNUExVRyZuYnNw
OyAwNjA0MDAwMCBWTVcmbmJzcDsgMDAwMDAwMDEpPGJyPihkcml2ZXJzXGJ1c1xhY3BpXHBucC5j
OjMwNikgQWNwaSBzdWJzeXN0ZW0gaW5pdDxicj4oZHJpdmVyc1xidXNcYWNwaVxidXNtZ3JcYnVz
LmM6MTc4NSkgYWNwaV9pbml0KGRyaXZlcnNcYnVzXGFjcGlcYnVzbWdyXGJ1cy5jOjE3ODcpIFN1
YnN5c3RlbSByZXZpc2lvbiAyMDA5MTIxNDxicj4oZHJpdmVyc1xidXNcYWNwaVxidXNtZ3JcYnVz
LmM6MTY2NykgYWNwaV9idXNfaW5pdChkcml2ZXJzXGJ1c1xhY3BpXGJ1c21nclxidXMuYzoxNTU1
KSBhY3BpX2J1c19pbml0X2lycUFDUEkgRXhjZXB0aW9uOiBBRV9FUlJPUiwgUmV0dXJuZWQgYnkg
SGFuZGxlciBmb3IgW1BDSV9Db25maWddICgyMDA5MTIxNC9ldnJlZ2lvbi01ODgpPGJyPkFDUEkg
RXJyb3IgKHBzcGFyc2UtMDYzMyk6IE1ldGhvZCBwYXJzZS9leGVjdXRpb24gZmFpbGVkIFtcX1NC
Xy5QQ0kwLlAyUDAuX1NUQV0gKE5vZGUgQjEyRkZFRjgpLCBBRV9FUlJPUjxicj5BQ1BJIEV4Y2Vw
dGlvbjogQUVfRVJST1IsIFJldHVybmVkIGJ5IEhhbmRsZXIgZm9yIFtQQ0lfQ29uZmlnXSAoMjAw
OTEyMTQvZXZyZWdpb24tNTg4KTxicj5BQ1BJIEVycm9yIChwc3BhcnNlLTA2MzMpOiBNZXRob2Qg
cGFyc2UvZXhlY3V0aW9uIGZhaWxlZCBbXF9TQl8uUENJMC5QMlAxLl9TVEFdIChOb2RlIEIxMzQ4
M0E4KSwgQUVfRVJST1I8YnI+QUNQSSBFeGNlcHRpb246IEFFX0VSUk9SLCBSZXR1cm5lZCBieSBI
YW5kbGVyIGZvciBbUENJX0NvbmZpZ10gKDIwMDkxMjE0L2V2cmVnaW9uLTU4OCk8YnI+QUNQSSBF
cnJvciAocHNwYXJzZS0wNjMzKTogTWV0aG9kIHBhcnNlL2V4ZWN1dGlvbiBmYWlsZWQgW1xfU0Jf
LlBDSTAuUDJQMi5fU1RBXSAoTm9kZSBCMTM0Njg0OCksIEFFX0VSUk9SPGJyPkFDUEkgRXhjZXB0
aW9uOiBBRV9FUlJPUiwgUmV0dXJuZWQgYnkgSGFuZGxlciBmb3IgW1BDSV9Db25maWddICgyMDA5
MTIxNC9ldnJlZ2lvbi01ODgpPGJyPkFDUEkgRXJyb3IgKHBzcGFyc2UtMDYzMyk6IE1ldGhvZCBw
YXJzZS9leGVjdXRpb24gZmFpbGVkIFtcX1NCXy5QQ0kwLlAyUDMuX1NUQV0gKE5vZGUgQjEzNDRD
RjgpLCBBRV9FUlJPUjxicj5BQ1BJIEV4Y2VwdGlvbjogQUVfRVJST1IsIFJldHVybmVkIGJ5IEhh
bmRsZXIgZm9yIFtQQ0lfQ29uZmlnXSAoMjAwOTEyMTQvZXZyZWdpb24tNTg4KTxicj5BQ1BJIEVy
cm9yIChwc3BhcnNlLTA2MzMpOiBNZXRob2QgcGFyc2UvZXhlY3V0aW9uIGZhaWxlZCBbXF9TQl8u
UENJMC5QRTQwLl9TVEFdIChOb2RlIEIxMzQyMUU4KSwgQUVfRVJST1I8YnI+QUNQSSBFeGNlcHRp
b246IEFFX0VSUk9SLCBSZXR1cm5lZCBieSBIYW5kbGVyIGZvciBbUENJX0NvbmZpZ10gKDIwMDkx
MjE0L2V2cmVnaW9uLTU4OCk8YnI+QUNQSSBFcnJvciAocHNwYXJzZS0wNjMzKTogTWV0aG9kIHBh
cnNlL2V4ZWN1dGlvbiBmYWlsZWQgW1xfU0JfLlBDSTAuUEU1MC5fU1RBXSAoTm9kZSBCMTM0MUQ2
OCksIEFFX0VSUk9SPGJyPkFDUEkgRXhjZXB0aW9uOiBBRV9FUlJPUiwgUmV0dXJuZWQgYnkgSGFu
ZGxlciBmb3IgW1BDSV9Db25maWddICgyMDA5MTIxNC9ldnJlZ2lvbi01ODgpPGJyPkFDUEkgRXJy
b3IgKHBzcGFyc2UtMDYzMyk6IE1ldGhvZCBwYXJzZS9leGVjdXRpb24gZmFpbGVkIFtcX1NCXy5Q
Q0kwLlBFNjAuX1NUQV0gKE5vZGUgQjEzNDE5MTApLCBBRV9FUlJPUjxicj5BQ1BJIEV4Y2VwdGlv
bjogQUVfRVJST1IsIFJldHVybmVkIGJ5IEhhbmRsZXIgZm9yIFtQQ0lfQ29uZmlnXSAoMjAwOTEy
MTQvZXZyZWdpb24tNTg4KTxicj5BQ1BJIEVycm9yIChwc3BhcnNlLTA2MzMpOiBNZXRob2QgcGFy
c2UvZXhlY3V0aW9uIGZhaWxlZCBbXF9TQl8uUENJMC5QRTcwLl9TVEFdIChOb2RlIEIxMzQxNEI4
KSwgQUVfRVJST1I8YnI+QUNQSSBFeGNlcHRpb246IEFFX0VSUk9SLCBSZXR1cm5lZCBieSBIYW5k
bGVyIGZvciBbUENJX0NvbmZpZ10gKDIwMDkxMjE0L2V2cmVnaW9uLTU4OCk8YnI+QUNQSSBFcnJv
ciAocHNwYXJzZS0wNjMzKTogTWV0aG9kIHBhcnNlL2V4ZWN1dGlvbiBmYWlsZWQgW1xfU0JfLlBD
STAuUEU4MC5fU1RBXSAoTm9kZSBCMTM0MTA2MCksIEFFX0VSUk9SPGJyPkFDUEkgRXhjZXB0aW9u
OiBBRV9FUlJPUiwgUmV0dXJuZWQgYnkgSGFuZGxlciBmb3IgW1BDSV9Db25maWddICgyMDA5MTIx
NC9ldnJlZ2lvbi01ODgpPGJyPkFDUEkgRXJyb3IgKHBzcGFyc2UtMDYzMyk6IE1ldGhvZCBwYXJz
ZS9leGVjdXRpb24gZmFpbGVkIFtcX1NCXy5QQ0kwLlBFOTAuX1NUQV0gKE5vZGUgQjEzNDBDMTAp
LCBBRV9FUlJPUjxicj5BQ1BJIEV4Y2VwdGlvbjogQUVfRVJST1IsIFJldHVybmVkIGJ5IEhhbmRs
ZXIgZm9yIFtQQ0lfQ29uZmlnXSAoMjAwOTEyMTQvZXZyZWdpb24tNTg4KTxicj5BQ1BJIEVycm9y
IChwc3BhcnNlLTA2MzMpOiBNZXRob2QgcGFyc2UvZXhlY3V0aW9uIGZhaWxlZCBbXF9TQl8uUENJ
MC5QRUEwLl9TVEFdIChOb2RlIEIxMzQwN0I4KSwgQUVfRVJST1I8YnI+QUNQSSBFeGNlcHRpb246
IEFFX0VSUk9SLCBSZXR1cm5lZCBieSBIYW5kbGVyIGZvciBbUENJX0NvbmZpZ10gKDIwMDkxMjE0
L2V2cmVnaW9uLTU4OCk8YnI+QUNQSSBFcnJvciAocHNwYXJzZS0wNjMzKTogTWV0aG9kIHBhcnNl
L2V4ZWN1dGlvbiBmYWlsZWQgW1xfU0JfLlBDSTAuUEVCMC5fU1RBXSAoTm9kZSBCMTM0MDM2MCks
IEFFX0VSUk9SPGJyPkFDUEkgRXhjZXB0aW9uOiBBRV9FUlJPUiwgUmV0dXJuZWQgYnkgSGFuZGxl
ciBmb3IgW1BDSV9Db25maWddICgyMDA5MTIxNC9ldnJlZ2lvbi01ODgpPGJyPkFDUEkgRXJyb3Ig
KHBzcGFyc2UtMDYzMyk6IE1ldGhvZCBwYXJzZS9leGVjdXRpb24gZmFpbGVkIFtcX1NCXy5QQ0kw
LlBFQzAuX1NUQV0gKE5vZGUgQjEyRjhFRDgpLCBBRV9FUlJPUjxicj5BQ1BJIEV4Y2VwdGlvbjog
QUVfRVJST1IsIFJldHVybmVkIGJ5IEhhbmRsZXIgZm9yIFtQQ0lfQ29uZmlnXSAoMjAwOTEyMTQv
ZXZyZWdpb24tNTg4KTxicj5BQ1BJIEVycm9yIChwc3BhcnNlLTA2MzMpOiBNZXRob2QgcGFyc2Uv
ZXhlY3V0aW9uIGZhaWxlZCBbXF9TQl8uUENJMC5QRUQwLl9TVEFdIChOb2RlIEIxMkY4QTgwKSwg
QUVfRVJST1I8YnI+QUNQSSBFeGNlcHRpb246IEFFX0VSUk9SLCBSZXR1cm5lZCBieSBIYW5kbGVy
IGZvciBbUENJX0NvbmZpZ10gKDIwMDkxMjE0L2V2cmVnaW9uLTU4OCk8YnI+QUNQSSBFcnJvciAo
cHNwYXJzZS0wNjMzKTogTWV0aG9kIHBhcnNlL2V4ZWN1dGlvbiBmYWlsZWQgW1xfU0JfLlBDSTAu
UEVFMC5fU1RBXSAoTm9kZSBCMTJGODYyOCksIEFFX0VSUk9SPGJyPkFDUEkgRXhjZXB0aW9uOiBB
RV9FUlJPUiwgUmV0dXJuZWQgYnkgSGFuZGxlciBmb3IgW1BDSV9Db25maWddICgyMDA5MTIxNC9l
dnJlZ2lvbi01ODgpPGJyPkFDUEkgRXJyb3IgKHBzcGFyc2UtMDYzMyk6IE1ldGhvZCBwYXJzZS9l
eGVjdXRpb24gZmFpbGVkIFtcX1NCXy5QQ0kwLlBFNDEuX1NUQV0gKE5vZGUgQjEyRjgxRDApLCBB
RV9FUlJPUjxicj5BQ1BJIEV4Y2VwdGlvbjogQUVfRVJST1IsIFJldHVybmVkIGJ5IEhhbmRsZXIg
Zm9yIFtQQ0lfQ29uZmlnXSAoMjAwOTEyMTQvZXZyZWdpb24tNTg4KTxicj5BQ1BJIEVycm9yIChw
c3BhcnNlLTA2MzMpOiBNZXRob2QgcGFyc2UvZXhlY3V0aW9uIGZhaWxlZCBbXF9TQl8uUENJMC5Q
RTQyLl9TVEFdIChOb2RlIEIxMkY3RDY4KSwgQUVfRVJST1I8YnI+QUNQSSBFeGNlcHRpb246IEFF
X0VSUk9SLCBSZXR1cm5lZCBieSBIYW5kbGVyIGZvciBbUENJX0NvbmZpZ10gKDIwMDkxMjE0L2V2
cmVnaW9uLTU4OCk8YnI+QUNQSSBFcnJvciAocHNwYXJzZS0wNjMzKTogTWV0aG9kIHBhcnNlL2V4
ZWN1dGlvbiBmYWlsZWQgW1xfU0JfLlBDSTAuUEU0My5fU1RBXSAoTm9kZSBCMTJGNzkxMCksIEFF
X0VSUk9SPGJyPkFDUEkgRXhjZXB0aW9uOiBBRV9FUlJPUiwgUmV0dXJuZWQgYnkgSGFuZGxlciBm
b3IgW1BDSV9Db25maWddICgyMDA5MTIxNC9ldnJlZ2lvbi01ODgpPGJyPkFDUEkgRXJyb3IgKHBz
cGFyc2UtMDYzMyk6IE1ldGhvZCBwYXJzZS9leGVjdXRpb24gZmFpbGVkIFtcX1NCXy5QQ0kwLlBF
NDQuX1NUQV0gKE5vZGUgQjEyRjc0QjgpLCBBRV9FUlJPUjxicj5BQ1BJIEV4Y2VwdGlvbjogQUVf
RVJST1IsIFJldHVybmVkIGJ5IEhhbmRsZXIgZm9yIFtQQ0lfQ29uZmlnXSAoMjAwOTEyMTQvZXZy
ZWdpb24tNTg4KTxicj5BQ1BJIEVycm9yIChwc3BhcnNlLTA2MzMpOiBNZXRob2QgcGFyc2UvZXhl
Y3V0aW9uIGZhaWxlZCBbXF9TQl8uUENJMC5QRTQ1Ll9TVEFdIChOb2RlIEIxMkY3MDYwKSwgQUVf
RVJST1I8YnI+QUNQSSBFeGNlcHRpb246IEFFX0VSUk9SLCBSZXR1cm5lZCBieSBIYW5kbGVyIGZv
ciBbUENJX0NvbmZpZ10gKDIwMDkxMjE0L2V2cmVnaW9uLTU4OCk8YnI+QUNQSSBFcnJvciAocHNw
YXJzZS0wNjMzKTogTWV0aG9kIHBhcnNlL2V4ZWN1dGlvbiBmYWlsZWQgW1xfU0JfLlBDSTAuUEU0
Ni5fU1RBXSAoTm9kZSBCMTJGNkMxMCksIEFFX0VSUk9SPGJyPkFDUEkgRXhjZXB0aW9uOiBBRV9F
UlJPUiwgUmV0dXJuZWQgYnkgSGFuZGxlciBmb3IgW1BDSV9Db25maWddICgyMDA5MTIxNC9ldnJl
Z2lvbi01ODgpPGJyPkFDUEkgRXJyb3IgKHBzcGFyc2UtMDYzMyk6IE1ldGhvZCBwYXJzZS9leGVj
dXRpb24gZmFpbGVkIFtcX1NCXy5QQ0kwLlBFNDcuX1NUQV0gKE5vZGUgQjEyRjY3QjgpLCBBRV9F
UlJPUjxicj5BQ1BJIEV4Y2VwdGlvbjogQUVfRVJST1IsIFJldHVybmVkIGJ5IEhhbmRsZXIgZm9y
IFtQQ0lfQ29uZmlnXSAoMjAwOTEyMTQvZXZyZWdpb24tNTg4KTxicj5BQ1BJIEVycm9yIChwc3Bh
cnNlLTA2MzMpOiBNZXRob2QgcGFyc2UvZXhlY3V0aW9uIGZhaWxlZCBbXF9TQl8uUENJMC5QRTUx
Ll9TVEFdIChOb2RlIEIxMkY2MzYwKSwgQUVfRVJST1I8YnI+QUNQSSBFeGNlcHRpb246IEFFX0VS
Uk9SLCBSZXR1cm5lZCBieSBIYW5kbGVyIGZvciBbUENJX0NvbmZpZ10gKDIwMDkxMjE0L2V2cmVn
aW9uLTU4OCk8YnI+QUNQSSBFcnJvciAocHNwYXJzZS0wNjMzKTogTWV0aG9kIHBhcnNlL2V4ZWN1
dGlvbiBmYWlsZWQgW1xfU0JfLlBDSTAuUEU1Mi5fU1RBXSAoTm9kZSBCMTJGNUVEOCksIEFFX0VS
Uk9SPGJyPkFDUEkgRXhjZXB0aW9uOiBBRV9FUlJPUiwgUmV0dXJuZWQgYnkgSGFuZGxlciBmb3Ig
W1BDSV9Db25maWddICgyMDA5MTIxNC9ldnJlZ2lvbi01ODgpPGJyPkFDUEkgRXJyb3IgKHBzcGFy
c2UtMDYzMyk6IE1ldGhvZCBwYXJzZS9leGVjdXRpb24gZmFpbGVkIFtcX1NCXy5QQ0kwLlBFNTMu
X1NUQV0gKE5vZGUgQjEyRjVBODApLCBBRV9FUlJPUjxicj5BQ1BJIEV4Y2VwdGlvbjogQUVfRVJS
T1IsIFJldHVybmVkIGJ5IEhhbmRsZXIgZm9yIFtQQ0lfQ29uZmlnXSAoMjAwOTEyMTQvZXZyZWdp
b24tNTg4KTxicj5BQ1BJIEVycm9yIChwc3BhcnNlLTA2MzMpOiBNZXRob2QgcGFyc2UvZXhlY3V0
aW9uIGZhaWxlZCBbXF9TQl8uUENJMC5QRTU0Ll9TVEFdIChOb2RlIEIxMkY1NjI4KSwgQUVfRVJS
T1I8YnI+QUNQSSBFeGNlcHRpb246IEFFX0VSUk9SLCBSZXR1cm5lZCBieSBIYW5kbGVyIGZvciBb
UENJX0NvbmZpZ10gKDIwMDkxMjE0L2V2cmVnaW9uLTU4OCk8YnI+QUNQSSBFcnJvciAocHNwYXJz
ZS0wNjMzKTogTWV0aG9kIHBhcnNlL2V4ZWN1dGlvbiBmYWlsZWQgW1xfU0JfLlBDSTAuUEU1NS5f
U1RBXSAoTm9kZSBCMTJGNTFEMCksIEFFX0VSUk9SPGJyPkFDUEkgRXhjZXB0aW9uOiBBRV9FUlJP
UiwgUmV0dXJuZWQgYnkgSGFuZGxlciBmb3IgW1BDSV9Db25maWddICgyMDA5MTIxNC9ldnJlZ2lv
bi01ODgpPGJyPkFDUEkgRXJyb3IgKHBzcGFyc2UtMDYzMyk6IE1ldGhvZCBwYXJzZS9leGVjdXRp
b24gZmFpbGVkIFtcX1NCXy5QQ0kwLlBFNTYuX1NUQV0gKE5vZGUgQjEyRjRENjgpLCBBRV9FUlJP
Ujxicj5BQ1BJIEV4Y2VwdGlvbjogQUVfRVJST1IsIFJldHVybmVkIGJ5IEhhbmRsZXIgZm9yIFtQ
Q0lfQ29uZmlnXSAoMjAwOTEyMTQvZXZyZWdpb24tNTg4KTxicj5BQ1BJIEVycm9yIChwc3BhcnNl
LTA2MzMpOiBNZXRob2QgcGFyc2UvZXhlY3V0aW9uIGZhaWxlZCBbXF9TQl8uUENJMC5QRTU3Ll9T
VEFdIChOb2RlIEIxMkY0OTEwKSwgQUVfRVJST1I8YnI+QUNQSSBFeGNlcHRpb246IEFFX0VSUk9S
LCBSZXR1cm5lZCBieSBIYW5kbGVyIGZvciBbUENJX0NvbmZpZ10gKDIwMDkxMjE0L2V2cmVnaW9u
LTU4OCk8YnI+QUNQSSBFcnJvciAocHNwYXJzZS0wNjMzKTogTWV0aG9kIHBhcnNlL2V4ZWN1dGlv
biBmYWlsZWQgW1xfU0JfLlBDSTAuUEU2MS5fU1RBXSAoTm9kZSBCMTJGNDRCOCksIEFFX0VSUk9S
PGJyPkFDUEkgRXhjZXB0aW9uOiBBRV9FUlJPUiwgUmV0dXJuZWQgYnkgSGFuZGxlciBmb3IgW1BD
SV9Db25maWddICgyMDA5MTIxNC9ldnJlZ2lvbi01ODgpPGJyPkFDUEkgRXJyb3IgKHBzcGFyc2Ut
MDYzMyk6IE1ldGhvZCBwYXJzZS9leGVjdXRpb24gZmFpbGVkIFtcX1NCXy5QQ0kwLlBFNjIuX1NU
QV0gKE5vZGUgQjEyRjQwNjApLCBBRV9FUlJPUjxicj5BQ1BJIEV4Y2VwdGlvbjogQUVfRVJST1Is
IFJldHVybmVkIGJ5IEhhbmRsZXIgZm9yIFtQQ0lfQ29uZmlnXSAoMjAwOTEyMTQvZXZyZWdpb24t
NTg4KTxicj5BQ1BJIEVycm9yIChwc3BhcnNlLTA2MzMpOiBNZXRob2QgcGFyc2UvZXhlY3V0aW9u
IGZhaWxlZCBbXF9TQl8uUENJMC5QRTYzLl9TVEFdIChOb2RlIEIxMkYzQzEwKSwgQUVfRVJST1I8
YnI+QUNQSSBFeGNlcHRpb246IEFFX0VSUk9SLCBSZXR1cm5lZCBieSBIYW5kbGVyIGZvciBbUENJ
X0NvbmZpZ10gKDIwMDkxMjE0L2V2cmVnaW9uLTU4OCk8YnI+QUNQSSBFcnJvciAocHNwYXJzZS0w
NjMzKTogTWV0aG9kIHBhcnNlL2V4ZWN1dGlvbiBmYWlsZWQgW1xfU0JfLlBDSTAuUEU2NC5fU1RB
XSAoTm9kZSBCMTJGMzdCOCksIEFFX0VSUk9SPGJyPkFDUEkgRXhjZXB0aW9uOiBBRV9FUlJPUiwg
UmV0dXJuZWQgYnkgSGFuZGxlciBmb3IgW1BDSV9Db25maWddICgyMDA5MTIxNC9ldnJlZ2lvbi01
ODgpPGJyPkFDUEkgRXJyb3IgKHBzcGFyc2UtMDYzMyk6IE1ldGhvZCBwYXJzZS9leGVjdXRpb24g
ZmFpbGVkIFtcX1NCXy5QQ0kwLlBFNjUuX1NUQV0gKE5vZGUgQjEyRjMzNjApLCBBRV9FUlJPUjxi
cj5BQ1BJIEV4Y2VwdGlvbjogQUVfRVJST1IsIFJldHVybmVkIGJ5IEhhbmRsZXIgZm9yIFtQQ0lf
Q29uZmlnXSAoMjAwOTEyMTQvZXZyZWdpb24tNTg4KTxicj5BQ1BJIEVycm9yIChwc3BhcnNlLTA2
MzMpOiBNZXRob2QgcGFyc2UvZXhlY3V0aW9uIGZhaWxlZCBbXF9TQl8uUENJMC5QRTY2Ll9TVEFd
IChOb2RlIEIxMkYyRUQ4KSwgQUVfRVJST1I8YnI+QUNQSSBFeGNlcHRpb246IEFFX0VSUk9SLCBS
ZXR1cm5lZCBieSBIYW5kbGVyIGZvciBbUENJX0NvbmZpZ10gKDIwMDkxMjE0L2V2cmVnaW9uLTU4
OCk8YnI+QUNQSSBFcnJvciAocHNwYXJzZS0wNjMzKTogTWV0aG9kIHBhcnNlL2V4ZWN1dGlvbiBm
YWlsZWQgW1xfU0JfLlBDSTAuUEU2Ny5fU1RBXSAoTm9kZSBCMTJGMkE4MCksIEFFX0VSUk9SPGJy
PkFDUEkgRXhjZXB0aW9uOiBBRV9FUlJPUiwgUmV0dXJuZWQgYnkgSGFuZGxlciBmb3IgW1BDSV9D
b25maWddICgyMDA5MTIxNC9ldnJlZ2lvbi01ODgpPGJyPkFDUEkgRXJyb3IgKHBzcGFyc2UtMDYz
Myk6IE1ldGhvZCBwYXJzZS9leGVjdXRpb24gZmFpbGVkIFtcX1NCXy5QQ0kwLlBFNzEuX1NUQV0g
KE5vZGUgQjEyRjI2MjgpLCBBRV9FUlJPUjxicj5BQ1BJIEV4Y2VwdGlvbjogQUVfRVJST1IsIFJl
dHVybmVkIGJ5IEhhbmRsZXIgZm9yIFtQQ0lfQ29uZmlnXSAoMjAwOTEyMTQvZXZyZWdpb24tNTg4
KTxicj5BQ1BJIEVycm9yIChwc3BhcnNlLTA2MzMpOiBNZXRob2QgcGFyc2UvZXhlY3V0aW9uIGZh
aWxlZCBbXF9TQl8uUENJMC5QRTcyLl9TVEFdIChOb2RlIEIxMkYyMUQwKSwgQUVfRVJST1I8YnI+
QUNQSSBFeGNlcHRpb246IEFFX0VSUk9SLCBSZXR1cm5lZCBieSBIYW5kbGVyIGZvciBbUENJX0Nv
bmZpZ10gKDIwMDkxMjE0L2V2cmVnaW9uLTU4OCk8YnI+QUNQSSBFcnJvciAocHNwYXJzZS0wNjMz
KTogTWV0aG9kIHBhcnNlL2V4ZWN1dGlvbiBmYWlsZWQgW1xfU0JfLlBDSTAuUEU3My5fU1RBXSAo
Tm9kZSBCMTJGMUQ2OCksIEFFX0VSUk9SPGJyPkFDUEkgRXhjZXB0aW9uOiBBRV9FUlJPUiwgUmV0
dXJuZWQgYnkgSGFuZGxlciBmb3IgW1BDSV9Db25maWddICgyMDA5MTIxNC9ldnJlZ2lvbi01ODgp
PGJyPkFDUEkgRXJyb3IgKHBzcGFyc2UtMDYzMyk6IE1ldGhvZCBwYXJzZS9leGVjdXRpb24gZmFp
bGVkIFtcX1NCXy5QQ0kwLlBFNzQuX1NUQV0gKE5vZGUgQjEyRjE5MTApLCBBRV9FUlJPUjxicj5B
Q1BJIEV4Y2VwdGlvbjogQUVfRVJST1IsIFJldHVybmVkIGJ5IEhhbmRsZXIgZm9yIFtQQ0lfQ29u
ZmlnXSAoMjAwOTEyMTQvZXZyZWdpb24tNTg4KTxicj5BQ1BJIEVycm9yIChwc3BhcnNlLTA2MzMp
OiBNZXRob2QgcGFyc2UvZXhlY3V0aW9uIGZhaWxlZCBbXF9TQl8uUENJMC5QRTc1Ll9TVEFdIChO
b2RlIEIxMkYxNEI4KSwgQUVfRVJST1I8YnI+QUNQSSBFeGNlcHRpb246IEFFX0VSUk9SLCBSZXR1
cm5lZCBieSBIYW5kbGVyIGZvciBbUENJX0NvbmZpZ10gKDIwMDkxMjE0L2V2cmVnaW9uLTU4OCk8
YnI+QUNQSSBFcnJvciAocHNwYXJzZS0wNjMzKTogTWV0aG9kIHBhcnNlL2V4ZWN1dGlvbiBmYWls
ZWQgW1xfU0JfLlBDSTAuUEU3Ni5fU1RBXSAoTm9kZSBCMTJGMTA2MCksIEFFX0VSUk9SPGJyPkFD
UEkgRXhjZXB0aW9uOiBBRV9FUlJPUiwgUmV0dXJuZWQgYnkgSGFuZGxlciBmb3IgW1BDSV9Db25m
aWddICgyMDA5MTIxNC9ldnJlZ2lvbi01ODgpPGJyPkFDUEkgRXJyb3IgKHBzcGFyc2UtMDYzMyk6
IE1ldGhvZCBwYXJzZS9leGVjdXRpb24gZmFpbGVkIFtcX1NCXy5QQ0kwLlBFNzcuX1NUQV0gKE5v
ZGUgQjEyRjBDMTApLCBBRV9FUlJPUjxicj5BQ1BJIEV4Y2VwdGlvbjogQUVfRVJST1IsIFJldHVy
bmVkIGJ5IEhhbmRsZXIgZm9yIFtQQ0lfQ29uZmlnXSAoMjAwOTEyMTQvZXZyZWdpb24tNTg4KTxi
cj5BQ1BJIEVycm9yIChwc3BhcnNlLTA2MzMpOiBNZXRob2QgcGFyc2UvZXhlY3V0aW9uIGZhaWxl
ZCBbXF9TQl8uUENJMC5QRTgxLl9TVEFdIChOb2RlIEIxMkYwN0I4KSwgQUVfRVJST1I8YnI+QUNQ
SSBFeGNlcHRpb246IEFFX0VSUk9SLCBSZXR1cm5lZCBieSBIYW5kbGVyIGZvciBbUENJX0NvbmZp
Z10gKDIwMDkxMjE0L2V2cmVnaW9uLTU4OCk8YnI+QUNQSSBFcnJvciAocHNwYXJzZS0wNjMzKTog
TWV0aG9kIHBhcnNlL2V4ZWN1dGlvbiBmYWlsZWQgW1xfU0JfLlBDSTAuUEU4Mi5fU1RBXSAoTm9k
ZSBCMTJGMDM2MCksIEFFX0VSUk9SPGJyPkFDUEkgRXhjZXB0aW9uOiBBRV9FUlJPUiwgUmV0dXJu
ZWQgYnkgSGFuZGxlciBmb3IgW1BDSV9Db25maWddICgyMDA5MTIxNC9ldnJlZ2lvbi01ODgpPGJy
PkFDUEkgRXJyb3IgKHBzcGFyc2UtMDYzMyk6IE1ldGhvZCBwYXJzZS9leGVjdXRpb24gZmFpbGVk
IFtcX1NCXy5QQ0kwLlBFODMuX1NUQV0gKE5vZGUgQjEyRUZFRDgpLCBBRV9FUlJPUjxicj5BQ1BJ
IEV4Y2VwdGlvbjogQUVfRVJST1IsIFJldHVybmVkIGJ5IEhhbmRsZXIgZm9yIFtQQ0lfQ29uZmln
XSAoMjAwOTEyMTQvZXZyZWdpb24tNTg4KTxicj5BQ1BJIEVycm9yIChwc3BhcnNlLTA2MzMpOiBN
ZXRob2QgcGFyc2UvZXhlY3V0aW9uIGZhaWxlZCBbXF9TQl8uUENJMC5QRTg0Ll9TVEFdIChOb2Rl
IEIxMkVGQTgwKSwgQUVfRVJST1I8YnI+QUNQSSBFeGNlcHRpb246IEFFX0VSUk9SLCBSZXR1cm5l
ZCBieSBIYW5kbGVyIGZvciBbUENJX0NvbmZpZ10gKDIwMDkxMjE0L2V2cmVnaW9uLTU4OCk8YnI+
QUNQSSBFcnJvciAocHNwYXJzZS0wNjMzKTogTWV0aG9kIHBhcnNlL2V4ZWN1dGlvbiBmYWlsZWQg
W1xfU0JfLlBDSTAuUEU4NS5fU1RBXSAoTm9kZSBCMTJFRjYyOCksIEFFX0VSUk9SPGJyPkFDUEkg
RXhjZXB0aW9uOiBBRV9FUlJPUiwgUmV0dXJuZWQgYnkgSGFuZGxlciBmb3IgW1BDSV9Db25maWdd
ICgyMDA5MTIxNC9ldnJlZ2lvbi01ODgpPGJyPkFDUEkgRXJyb3IgKHBzcGFyc2UtMDYzMyk6IE1l
dGhvZCBwYXJzZS9leGVjdXRpb24gZmFpbGVkIFtcX1NCXy5QQ0kwLlBFODYuX1NUQV0gKE5vZGUg
QjEyRUYxRDApLCBBRV9FUlJPUjxicj5BQ1BJIEV4Y2VwdGlvbjogQUVfRVJST1IsIFJldHVybmVk
IGJ5IEhhbmRsZXIgZm9yIFtQQ0lfQ29uZmlnXSAoMjAwOTEyMTQvZXZyZWdpb24tNTg4KTxicj5B
Q1BJIEVycm9yIChwc3BhcnNlLTA2MzMpOiBNZXRob2QgcGFyc2UvZXhlY3V0aW9uIGZhaWxlZCBb
XF9TQl8uUENJMC5QRTg3Ll9TVEFdIChOb2RlIEIxMkVFRDY4KSwgQUVfRVJST1I8YnI+QUNQSSBF
eGNlcHRpb246IEFFX0VSUk9SLCBSZXR1cm5lZCBieSBIYW5kbGVyIGZvciBbUENJX0NvbmZpZ10g
KDIwMDkxMjE0L2V2cmVnaW9uLTU4OCk8YnI+QUNQSSBFcnJvciAocHNwYXJzZS0wNjMzKTogTWV0
aG9kIHBhcnNlL2V4ZWN1dGlvbiBmYWlsZWQgW1xfU0JfLlBDSTAuUEU5MS5fU1RBXSAoTm9kZSBC
MTJFRTkxMCksIEFFX0VSUk9SPGJyPkFDUEkgRXhjZXB0aW9uOiBBRV9FUlJPUiwgUmV0dXJuZWQg
YnkgSGFuZGxlciBmb3IgW1BDSV9Db25maWddICgyMDA5MTIxNC9ldnJlZ2lvbi01ODgpPGJyPkFD
UEkgRXJyb3IgKHBzcGFyc2UtMDYzMyk6IE1ldGhvZCBwYXJzZS9leGVjdXRpb24gZmFpbGVkIFtc
X1NCXy5QQ0kwLlBFOTIuX1NUQV0gKE5vZGUgQjEyRUU0QjgpLCBBRV9FUlJPUjxicj5BQ1BJIEV4
Y2VwdGlvbjogQUVfRVJST1IsIFJldHVybmVkIGJ5IEhhbmRsZXIgZm9yIFtQQ0lfQ29uZmlnXSAo
MjAwOTEyMTQvZXZyZWdpb24tNTg4KTxicj5BQ1BJIEVycm9yIChwc3BhcnNlLTA2MzMpOiBNZXRo
b2QgcGFyc2UvZXhlY3V0aW9uIGZhaWxlZCBbXF9TQl8uUENJMC5QRTkzLl9TVEFdIChOb2RlIEIx
MkVFMDYwKSwgQUVfRVJST1I8YnI+QUNQSSBFeGNlcHRpb246IEFFX0VSUk9SLCBSZXR1cm5lZCBi
eSBIYW5kbGVyIGZvciBbUENJX0NvbmZpZ10gKDIwMDkxMjE0L2V2cmVnaW9uLTU4OCk8YnI+QUNQ
SSBFcnJvciAocHNwYXJzZS0wNjMzKTogTWV0aG9kIHBhcnNlL2V4ZWN1dGlvbiBmYWlsZWQgW1xf
U0JfLlBDSTAuUEU5NC5fU1RBXSAoTm9kZSBCMTJFREMxMCksIEFFX0VSUk9SPGJyPkFDUEkgRXhj
ZXB0aW9uOiBBRV9FUlJPUiwgUmV0dXJuZWQgYnkgSGFuZGxlciBmb3IgW1BDSV9Db25maWddICgy
MDA5MTIxNC9ldnJlZ2lvbi01ODgpPGJyPkFDUEkgRXJyb3IgKHBzcGFyc2UtMDYzMyk6IE1ldGhv
ZCBwYXJzZS9leGVjdXRpb24gZmFpbGVkIFtcX1NCXy5QQ0kwLlBFOTUuX1NUQV0gKE5vZGUgQjEy
RUQ3QjgpLCBBRV9FUlJPUjxicj5BQ1BJIEV4Y2VwdGlvbjogQUVfRVJST1IsIFJldHVybmVkIGJ5
IEhhbmRsZXIgZm9yIFtQQ0lfQ29uZmlnXSAoMjAwOTEyMTQvZXZyZWdpb24tNTg4KTxicj5BQ1BJ
IEVycm9yIChwc3BhcnNlLTA2MzMpOiBNZXRob2QgcGFyc2UvZXhlY3V0aW9uIGZhaWxlZCBbXF9T
Ql8uUENJMC5QRTk2Ll9TVEFdIChOb2RlIEIxMkVEMzYwKSwgQUVfRVJST1I8YnI+QUNQSSBFeGNl
cHRpb246IEFFX0VSUk9SLCBSZXR1cm5lZCBieSBIYW5kbGVyIGZvciBbUENJX0NvbmZpZ10gKDIw
MDkxMjE0L2V2cmVnaW9uLTU4OCk8YnI+QUNQSSBFcnJvciAocHNwYXJzZS0wNjMzKTogTWV0aG9k
IHBhcnNlL2V4ZWN1dGlvbiBmYWlsZWQgW1xfU0JfLlBDSTAuUEU5Ny5fU1RBXSAoTm9kZSBCMTJF
Q0VEOCksIEFFX0VSUk9SPGJyPkFDUEkgRXhjZXB0aW9uOiBBRV9FUlJPUiwgUmV0dXJuZWQgYnkg
SGFuZGxlciBmb3IgW1BDSV9Db25maWddICgyMDA5MTIxNC9ldnJlZ2lvbi01ODgpPGJyPkFDUEkg
RXJyb3IgKHBzcGFyc2UtMDYzMyk6IE1ldGhvZCBwYXJzZS9leGVjdXRpb24gZmFpbGVkIFtcX1NC
Xy5QQ0kwLlBFQTEuX1NUQV0gKE5vZGUgQjEyRUNBODApLCBBRV9FUlJPUjxicj5BQ1BJIEV4Y2Vw
dGlvbjogQUVfRVJST1IsIFJldHVybmVkIGJ5IEhhbmRsZXIgZm9yIFtQQ0lfQ29uZmlnXSAoMjAw
OTEyMTQvZXZyZWdpb24tNTg4KTxicj5BQ1BJIEVycm9yIChwc3BhcnNlLTA2MzMpOiBNZXRob2Qg
cGFyc2UvZXhlY3V0aW9uIGZhaWxlZCBbXF9TQl8uUENJMC5QRUEyLl9TVEFdIChOb2RlIEIxMkVD
NjI4KSwgQUVfRVJST1I8YnI+QUNQSSBFeGNlcHRpb246IEFFX0VSUk9SLCBSZXR1cm5lZCBieSBI
YW5kbGVyIGZvciBbUENJX0NvbmZpZ10gKDIwMDkxMjE0L2V2cmVnaW9uLTU4OCk8YnI+QUNQSSBF
cnJvciAocHNwYXJzZS0wNjMzKTogTWV0aG9kIHBhcnNlL2V4ZWN1dGlvbiBmYWlsZWQgW1xfU0Jf
LlBDSTAuUEVBMy5fU1RBXSAoTm9kZSBCMTJFQzFEMCksIEFFX0VSUk9SPGJyPkFDUEkgRXhjZXB0
aW9uOiBBRV9FUlJPUiwgUmV0dXJuZWQgYnkgSGFuZGxlciBmb3IgW1BDSV9Db25maWddICgyMDA5
MTIxNC9ldnJlZ2lvbi01ODgpPGJyPkFDUEkgRXJyb3IgKHBzcGFyc2UtMDYzMyk6IE1ldGhvZCBw
YXJzZS9leGVjdXRpb24gZmFpbGVkIFtcX1NCXy5QQ0kwLlBFQTQuX1NUQV0gKE5vZGUgQjEyRUJE
NjgpLCBBRV9FUlJPUjxicj5BQ1BJIEV4Y2VwdGlvbjogQUVfRVJST1IsIFJldHVybmVkIGJ5IEhh
bmRsZXIgZm9yIFtQQ0lfQ29uZmlnXSAoMjAwOTEyMTQvZXZyZWdpb24tNTg4KTxicj5BQ1BJIEVy
cm9yIChwc3BhcnNlLTA2MzMpOiBNZXRob2QgcGFyc2UvZXhlY3V0aW9uIGZhaWxlZCBbXF9TQl8u
UENJMC5QRUE1Ll9TVEFdIChOb2RlIEIxMkVCOTEwKSwgQUVfRVJST1I8YnI+QUNQSSBFeGNlcHRp
b246IEFFX0VSUk9SLCBSZXR1cm5lZCBieSBIYW5kbGVyIGZvciBbUENJX0NvbmZpZ10gKDIwMDkx
MjE0L2V2cmVnaW9uLTU4OCk8YnI+QUNQSSBFcnJvciAocHNwYXJzZS0wNjMzKTogTWV0aG9kIHBh
cnNlL2V4ZWN1dGlvbiBmYWlsZWQgW1xfU0JfLlBDSTAuUEVBNi5fU1RBXSAoTm9kZSBCMTJFQjRC
OCksIEFFX0VSUk9SPGJyPkFDUEkgRXhjZXB0aW9uOiBBRV9FUlJPUiwgUmV0dXJuZWQgYnkgSGFu
ZGxlciBmb3IgW1BDSV9Db25maWddICgyMDA5MTIxNC9ldnJlZ2lvbi01ODgpPGJyPkFDUEkgRXJy
b3IgKHBzcGFyc2UtMDYzMyk6IE1ldGhvZCBwYXJzZS9leGVjdXRpb24gZmFpbGVkIFtcX1NCXy5Q
Q0kwLlBFQTcuX1NUQV0gKE5vZGUgQjEyRUIwNjApLCBBRV9FUlJPUjxicj5BQ1BJIEV4Y2VwdGlv
bjogQUVfRVJST1IsIFJldHVybmVkIGJ5IEhhbmRsZXIgZm9yIFtQQ0lfQ29uZmlnXSAoMjAwOTEy
MTQvZXZyZWdpb24tNTg4KTxicj5BQ1BJIEVycm9yIChwc3BhcnNlLTA2MzMpOiBNZXRob2QgcGFy
c2UvZXhlY3V0aW9uIGZhaWxlZCBbXF9TQl8uUENJMC5QRUIxLl9TVEFdIChOb2RlIEIxMkVBQzEw
KSwgQUVfRVJST1I8YnI+QUNQSSBFeGNlcHRpb246IEFFX0VSUk9SLCBSZXR1cm5lZCBieSBIYW5k
bGVyIGZvciBbUENJX0NvbmZpZ10gKDIwMDkxMjE0L2V2cmVnaW9uLTU4OCk8YnI+QUNQSSBFcnJv
ciAocHNwYXJzZS0wNjMzKTogTWV0aG9kIHBhcnNlL2V4ZWN1dGlvbiBmYWlsZWQgW1xfU0JfLlBD
STAuUEVCMi5fU1RBXSAoTm9kZSBCMTJFQTdCOCksIEFFX0VSUk9SPGJyPkFDUEkgRXhjZXB0aW9u
OiBBRV9FUlJPUiwgUmV0dXJuZWQgYnkgSGFuZGxlciBmb3IgW1BDSV9Db25maWddICgyMDA5MTIx
NC9ldnJlZ2lvbi01ODgpPGJyPkFDUEkgRXJyb3IgKHBzcGFyc2UtMDYzMyk6IE1ldGhvZCBwYXJz
ZS9leGVjdXRpb24gZmFpbGVkIFtcX1NCXy5QQ0kwLlBFQjMuX1NUQV0gKE5vZGUgQjEyRUEzNjAp
LCBBRV9FUlJPUjxicj5BQ1BJIEV4Y2VwdGlvbjogQUVfRVJST1IsIFJldHVybmVkIGJ5IEhhbmRs
ZXIgZm9yIFtQQ0lfQ29uZmlnXSAoMjAwOTEyMTQvZXZyZWdpb24tNTg4KTxicj5BQ1BJIEVycm9y
IChwc3BhcnNlLTA2MzMpOiBNZXRob2QgcGFyc2UvZXhlY3V0aW9uIGZhaWxlZCBbXF9TQl8uUENJ
MC5QRUI0Ll9TVEFdIChOb2RlIEIxMkU5RUQ4KSwgQUVfRVJST1I8YnI+QUNQSSBFeGNlcHRpb246
IEFFX0VSUk9SLCBSZXR1cm5lZCBieSBIYW5kbGVyIGZvciBbUENJX0NvbmZpZ10gKDIwMDkxMjE0
L2V2cmVnaW9uLTU4OCk8YnI+QUNQSSBFcnJvciAocHNwYXJzZS0wNjMzKTogTWV0aG9kIHBhcnNl
L2V4ZWN1dGlvbiBmYWlsZWQgW1xfU0JfLlBDSTAuUEVCNS5fU1RBXSAoTm9kZSBCMTJFOUE4MCks
IEFFX0VSUk9SPGJyPkFDUEkgRXhjZXB0aW9uOiBBRV9FUlJPUiwgUmV0dXJuZWQgYnkgSGFuZGxl
ciBmb3IgW1BDSV9Db25maWddICgyMDA5MTIxNC9ldnJlZ2lvbi01ODgpPGJyPkFDUEkgRXJyb3Ig
KHBzcGFyc2UtMDYzMyk6IE1ldGhvZCBwYXJzZS9leGVjdXRpb24gZmFpbGVkIFtcX1NCXy5QQ0kw
LlBFQjYuX1NUQV0gKE5vZGUgQjEyRTk2MjgpLCBBRV9FUlJPUjxicj5BQ1BJIEV4Y2VwdGlvbjog
QUVfRVJST1IsIFJldHVybmVkIGJ5IEhhbmRsZXIgZm9yIFtQQ0lfQ29uZmlnXSAoMjAwOTEyMTQv
ZXZyZWdpb24tNTg4KTxicj5BQ1BJIEVycm9yIChwc3BhcnNlLTA2MzMpOiBNZXRob2QgcGFyc2Uv
ZXhlY3V0aW9uIGZhaWxlZCBbXF9TQl8uUENJMC5QRUI3Ll9TVEFdIChOb2RlIEIxMkU5MUQwKSwg
QUVfRVJST1I8YnI+UHVUVFlFbnRlcmVkIGRlYnVnZ2VyIG9uIGxhc3QtY2hhbmNlIGV4Y2VwdGlv
biAoRXhjZXB0aW9uIENvZGU6IDB4YzAwMDAwMDUpIChQYWdlIEZhdWx0KTxicj5NZW1vcnkgYXQg
MHgwMDAwMDAwMCBjb3VsZCBub3QgYmUgcmVhZDogUGFnZSBub3QgcHJlc2VudC48YnI+PGJyPiAJ
CSAJICAgCQkgIDxiciAvPjxociAvPkhvdG1haWw6IFRydXN0ZWQgZW1haWwgd2l0aCBwb3dlcmZ1
bCBTUEFNIHByb3RlY3Rpb24uIDxhIGhyZWY9J2h0dHBzOi8vc2lnbnVwLmxpdmUuY29tL3NpZ251
cC5hc3B4P2lkPTYwOTY5JyB0YXJnZXQ9J19uZXcnPlNpZ24gdXAgbm93LjwvYT48L2JvZHk+Cjwv
aHRtbD4=
--===============7020800603254088616==--

