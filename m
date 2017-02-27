Content-Type: multipart/mixed; boundary="===============3972455078949223039=="
MIME-Version: 1.0
From: Zheng, Lv <lv.zheng at intel.com>
Subject: Re: [Devel] [PATCH v2] acpi: acpica: fix acpi operand cache leak
Date: Mon, 27 Feb 2017 02:45:50 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E886CE41241@SHSMSX101.ccr.corp.intel.com>
In-Reply-To: CAJZ5v0gUOcV2+r9fMxYS89FrWk1HoguAvF2qO=Lt9o-eNRhEBQ@mail.gmail.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============3972455078949223039==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi, Rafael

> From: linux-acpi-owner(a)vger.kernel.org [mailto:linux-acpi-owner(a)vger.=
kernel.org] On Behalf Of Rafael J.
> Wysocki
> Subject: Re: [PATCH v2] acpi: acpica: fix acpi operand cache leak
> =

> On Fri, Feb 24, 2017 at 11:37 PM, Seunghun Han <kkamagui(a)gmail.com> wro=
te:
> > Hi, Rafael.
> >
> > I agree with you and I added my opinion below.
> >
> > 2017-02-25 1:50 GMT+09:00 Rafael J. Wysocki <rjw(a)rjwysocki.net>:
> >> On Friday, February 24, 2017 09:56:21 PM Seunghun Han wrote:
> >>> Hi, Rafeal.
> >>>
> >>> I added my opinion below.
> >>>
> >>> 2017-02-24 21:13 GMT+09:00 Rafael J. Wysocki <rjw(a)rjwysocki.net>:
> >>> > On Friday, February 24, 2017 09:15:52 PM Seunghun Han wrote:
> >>> >> Hi, Rafael.
> >>> >>
> >>> >> I added my opinion below.
> >>> >>
> >>> >> 2017-02-24 20:50 GMT+09:00 Rafael J. Wysocki <rjw(a)rjwysocki.net>:
> >>> >> > On Friday, February 24, 2017 08:52:42 PM Seunghun Han wrote:
> >>> >> >> Hi, Lv Zheng.
> >>> >> >>
> >>> >> >> I added my handcrafted ACPI table under your request, because
> >>> >> >> "acpidump -c on" and "acpidump -c off" doesn't work.
> >>> >> >>
> >>> >> >> 2017-02-21 19:36 GMT+09:00 Seunghun Han <kkamagui(a)gmail.com>:
> >>> >> >> > Hello,
> >>> >> >> >
> >>> >> >> > I attached the test results below,
> >>> >> >> >
> >>> >> >> > 2017-02-21 9:53 GMT+09:00 Rowafael J. Wysocki <rjw(a)rjwysock=
i.net>:
> >>> >> >> >> On Tuesday, February 21, 2017 12:33:08 AM Zheng, Lv wrote:
> >>> >> >> >>> Hi,
> >>> >> >> >>>
> >>> >> >> >>> > From: linux-acpi-owner(a)vger.kernel.org [mailto:linux-ac=
pi-owner(a)vger.kernel.org] On
> Behalf Of Seunghun
> >>> >> >> >>> > Han
> >>> >> >> >>> > Subject: [PATCH v2] acpi: acpica: fix acpi operand cache =
leak
> >>> >> >> >>> >
> >>> >> >> >>> > I'm Seunghun Han, and I work for National Security Resear=
ch Institute of
> >>> >> >> >>> > South Korea.
> >>> >> >> >>> >
> >>> >> >> >>> > I have been doing a research on ACPI and making a handcra=
fted ACPI table
> >>> >> >> >>> > for my research.
> >>> >> >> >>> > Errors of handcrafted ACPI tables are handled well in Lin=
ux kernel while boot
> >>> >> >> >>> > process, and Linux kernel goes well without critical prob=
lems.
> >>> >> >> >>> > But I found some ACPI operand cache leaks in ACPI early a=
bort cases.
> >>> >> >> >>> >
> >>> >> >> >>> > Boot log of ACPI operand cache leak is as follows:
> >>> >> >> >>> > >[    0.174332] ACPI: Added _OSI(Module Device)
> >>> >> >> >>> > >[    0.175504] ACPI: Added _OSI(Processor Device)
> >>> >> >> >>> > >[    0.176010] ACPI: Added _OSI(3.0 _SCP Extensions)
> >>> >> >> >>> > >[    0.177032] ACPI: Added _OSI(Processor Aggregator Dev=
ice)
> >>> >> >> >>> > >[    0.178284] ACPI: SCI (IRQ16705) allocation failed
> >>> >> >> >>> > >[    0.179352] ACPI Exception: AE_NOT_ACQUIRED, Unable t=
o install System Control
> Interrupt handler
> >>> >> >> >>> > (20160930/evevent-131)
> >>> >> >> >>> > >[    0.180008] ACPI: Unable to start the ACPI Interpreter
> >>> >> >> >>> > >[    0.181125] ACPI Error: Could not remove SCI handler =
(20160930/evmisc-281)
> >>> >> >> >>> > >[    0.184068] kmem_cache_destroy Acpi-Operand: Slab cac=
he still has objects
> >>> >> >> >>> > >[    0.185358] CPU: 0 PID: 1 Comm: swapper/0 Not tainted=
 4.10.0-rc3 #2
> >>> >> >> >>> > >[    0.186820] Hardware name: innotek GmbH VirtualBox/Vi=
rtualBox, BIOS VirtualBox
> 12/01/2006
> >>> >> >> >>> > >[    0.188000] Call Trace:
> >>> >> >> >>> > >[    0.188000]  ? dump_stack+0x5c/0x7d
> >>> >> >> >>> > >[    0.188000]  ? kmem_cache_destroy+0x224/0x230
> >>> >> >> >>> > >[    0.188000]  ? acpi_sleep_proc_init+0x22/0x22
> >>> >> >> >>> > >[    0.188000]  ? acpi_os_delete_cache+0xa/0xd
> >>> >> >> >>> > >[    0.188000]  ? acpi_ut_delete_caches+0x3f/0x7b
> >>> >> >> >>> > >[    0.188000]  ? acpi_terminate+0x5/0xf
> >>> >> >> >>> > >[    0.188000]  ? acpi_init+0x288/0x32e
> >>> >> >> >>> > >[    0.188000]  ? __class_create+0x4c/0x80
> >>> >> >> >>> > >[    0.188000]  ? video_setup+0x7a/0x7a
> >>> >> >> >>> > >[    0.188000]  ? do_one_initcall+0x4e/0x1b0
> >>> >> >> >>> > >[    0.188000]  ? kernel_init_freeable+0x194/0x21a
> >>> >> >> >>> > >[    0.188000]  ? rest_init+0x80/0x80
> >>> >> >> >>> > >[    0.188000]  ? kernel_init+0xa/0x100
> >>> >> >> >>> > >[    0.188000]  ? ret_from_fork+0x25/0x30
> >>> >> >> >>>
> >>> >> >> >>> I'm more interested in the way of triggering AE_NOT_ACQUIRE=
D error.
> >>> >> >> >>> So could you send us the handcrafted ACPI table or both the=
 "acpidump -c on" and
> "acpidump -c off" output?
> >>> >> >>
> >>> >> >> I modified FACP, FACS, APIC table in VirtualBox for Linux.
> >>> >> >> Here are raw dumps of table.
> >>> >> >
> >>> >> > So, excuse me, but what's the security issue here?
> >>> >> >
> >>> >> > You hacked your ACPI tables into pieces which requires root priv=
ileges anyway.
> >>> >> >
> >>> >> > Thanks,
> >>> >> > Rafael
> >>> >> >
> >>> >>
> >>> >> As you mentioned earlier, I hacked my ACPI table for research, so =
it seems that
> >>> >> it is not a security issue.
> >>> >>
> >>> >> But, if new mainboard are released and they have a vendor-specific=
 ACPI table
> >>> >> which has invalid data, the old version of kernel (<=3D4.9) will p=
ossibly expose
> >>> >> kernel address and KASLR will be neutralized unintentionally.
> >>> >
> >>> > But that would mean a basically non-functional system, so I'm not s=
ure how
> >>> > anyone can actually take advantage of the "KASLR neutralization".
> >>>
> >>> I think an attacker can take advantage of the "KASLR neutralization".=
 As you
> >>> know, KASLR is good technology to protect kernel from kernel exploits.
> >>>
> >>> If the kernel has vulnerabilities, the attacker can make exploit usin=
g them.
> >>> But, the exploit usually needs gadgets (small code), therefore the at=
tacker
> >>> should know where the gadgets are in kernel. If the KASLR is working =
in kernel,
> >>> the attacker should find the actual kernel address, and he can get ke=
rnel
> >>> address information from kernel warning.
> >>
> >> If the system basically doesn't work, that information isn't  particul=
arly useful.
> >>
> >>> >> I know the vendors collaborate with Linux kernel developers, but t=
he problem
> >>> >> can still occur.
> >>> >>
> >>> >> Hardware vendors release so many kinds of mainboard in a year, and=
 the major
> >>> >> Linux distros (Ubuntu, Fedora, etc.) will have 4.8 kernel for a lo=
ng time.
> >>> >>
> >>> >> For this reason, I think this issue has a security aspect.
> >>> >
> >>> > Well, not quite IMO.
> >>> >
> >>> > If the system needs ACPI tables and the kernel cannot use them, it =
just won't
> >>> > work no matter what.
> >>> >
> >>> > Thanks,
> >>> > Rafael
> >>> >
> >>> Yes, you are right. But, Linux kernel has well-defined exception hand=
lers, so
> >>> some systems may work fine like my test machine. Moreover the users m=
ay not
> >>> recognize what the problem is, and I think that they will use the sys=
tem in
> >>> insecure status for a long time.
> >>
> >> A virtual box or a guest can run without ACPI tables.  A bare metal sy=
stem
> >> where ACPI tables are necessary will be more-or-less unusable if the k=
ernel
> >> cannot use them (it won't be able to detect interrupt controllers and =
the PCI
> >> host bridge just for starters).
> >>
> >> Running a guest with totally broken ACPI tables requires root privileg=
es on the
> >> host.  Running a bare metal system with totally broken ACPI tables (wh=
ich seems
> >> to be your basic concern) may be a good research project, but nobody w=
ill do
> >> that in practice.  And everybody who tries that will notice what's goi=
ng on.
> >>
> >> Yes, you found a bug, but I still am not convinced about how this is s=
ecurity-related.
> >
> > I totally agree with you that this case is not in practice now.
> > I just started researching on ACPI, and I don't have enough ideas to oc=
cur
> > a security problem using a bug. I just think that it has a little possi=
bility
> > which is security-related.
> >
> > Thank you so much for your guides.
> > It helps me a lot to change my research direction.
> >
> > So, could my patch be merged in next kernel (4.11 rc-1)? or do I need t=
o do
> > something for it?
> > Please let me know.
> =

> Generally, ACPICA patches (and this is one of them) have to go in via
> the upstream ACPICA project maintained by Bob Moore and Lv.  Please
> see MAINTAINERS for pointers to the mailing list etc.
> =

> Lv, can you please advise on the next steps?

I already gave my advices.
The fix was OK to me and I back ported it to ACPICA:
https://github.com/acpica/acpica/pull/206
However it fixes a code path that in theory shouldn't be invoked in Linux k=
ernel.
But anyway it was merged and you will see it in the next ACPICA release.

I asked Han for the handcrafted ACPI table.
And obtained that:
ACPI: FACP 0x00000000DFFF00F0 0000F4 (v04 VBOX VBOXFACP 00000001 ASL  00000=
061)
0x0000: 46 41 43 50 F4 00 00 00 04 60 56 42 4F 58 20 20
0x0010: 56 42 4F 58 46 41 43 50 01 00 00 00 41 53 4C 20
0x0020: 61 00 00 00 00 02 FF DF 80 04 FF DF 41 41 41 41
0x0030: 2E 44 00 00 A1 A0 00 00 00 40 00 00 00 00 00 00
0x0040: 04 40 00 00 00 00 00 00 00 00 00 00 08 40 00 00
0x0050: 20 40 00 00 00 00 00 00 04 02 00 04 02 00 00 00
0x0060: 65 00 E9 03 00 00 00 00 00 00 00 00 00 03 00 00
0x0070: 41 05 00 00 01 08 00 01 50 40 00 00 00 00 00 00
0x0080: 10 00 00 00 00 02 FF DF 00 00 00 00 80 04 FF DF
0x0090: 00 00 00 00 01 20 00 02 00 40 00 00 00 00 00 00
0x00A0: 00 00 00 00 00 00 00 00 00 00 00 00 01 10 00 02
0x00B0: 04 40 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x00C0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x00D0: 01 20 00 03 08 40 00 00 00 00 00 00 01 10 00 01
0x00E0: 20 40 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x00F0: 00 00 00 00

ACPI: FACS 0x00000000DFFF0200 000040
0x0000: 46 41 43 53 40 00 00 00 00 00 00 00 00 00 00 00
0x0010: 00 00 00 00 00 00 00 00 00 41 41 41 41 41 41 41
0x0020: 01 00 00 00 00 00 00 00 00 41 00 00 00 00 00 00
0x0030: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

ACPI: APIC 0x00000000DFFF0240 00006C (v02 VBOX VBOXAPIC 00000001 ASL  00000=
061)
0x0000: 41 50 49 43 6C 00 00 00 02 21 56 42 4F 58 20 20
0x0010: 56 42 4F 58 41 50 49 43 01 00 00 00 41 53 4C 20
0x0020: 61 00 00 00 00 00 E0 FE 01 00 00 00 02 0A 00 00
0x0030: 02 00 00 00 00 00 02 0A 00 09 09 00 00 00 0D 00
0x0040: 00 08 00 00 01 00 41 41 41 41 41 41 41 41 41 00
0x0050: 00 08 02 02 01 00 00 00 00 08 03 03 01 00 00 00
0x0060: 01 0C 04 00 00 00 C0 FE 00 00 00 00

Where there is still no AML tables and the failure in the patch description=
 seems to be related to the AML tables.
So I'm still not aware of what the "handcrafted tables" meant to us and wha=
t the problem was.

Thanks and best regards
Lv

> =

> Thanks,
> Rafael
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo(a)vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--===============3972455078949223039==--

