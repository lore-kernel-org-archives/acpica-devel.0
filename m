Content-Type: multipart/mixed; boundary="===============4428473832145787707=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: Re: [Devel] New to ACPICA, could use a pointer
Date: Tue, 08 Mar 2016 15:41:43 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37E44FC69@ORSMSX110.amr.corp.intel.com>
In-Reply-To: 989CF009-260A-445C-BCC1-6005A78DAA97@elemental.org
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============4428473832145787707==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Adding Lv, who has worked on the handler stuff.
Bob


> -----Original Message-----
> From: Devel [mailto:devel-bounces(a)acpica.org] On Behalf Of Dale Ghent
> Sent: Tuesday, March 08, 2016 7:20 AM
> To: Devel(a)acpica.org
> Subject: [Devel] New to ACPICA, could use a pointer
> =

> =

> Hello!
> =

> I've taken up a small project to update the illumos kernel with the latest
> ACPICA code, as it's currently a few years overdue for one. One of my test
> cases is on VirtualBox, and I'm trying to figure out the cause (and thus
> the remedy, or at the very least the reasons why it's happening) of a
> particular error message that's emitted on boot and loading our acpica
> kernel driver. The output is as follows:
> =

> Mar  8 03:08:00 bloodacpi acpica: [ID 912267 kern.notice] ACPI: RSDP 0x
> 0   E0000 000024 (v2 VBOX  )
> Mar  8 03:08:00 bloodacpi acpica: [ID 416880 kern.notice] ACPI: XSDT 0x
> 0DBFF0040 00004C (v1 VBOX   VBOXXSDT 00000001 ASL 00000061)
> Mar  8 03:08:00 bloodacpi acpica: [ID 334289 kern.notice] ACPI: FACP 0x
> 0DBFF0110 0000F4 (v4 VBOX   VBOXFACP 00000001 ASL  00000061)Mar  8
> 03:08:00 bloodacpi acpica: [ID 653090 kern.notice] ACPI: DSDT 0x
> 0DBFF0540 001CEB (v1 VBOX   VBOXBIOS 00000002 INTL 20100528)
> Mar  8 03:08:00 bloodacpi acpica: [ID 138051 kern.notice] ACPI: FACS 0x
> 0DBFF0240 000040
> Mar  8 03:08:00 bloodacpi last message repeated 1 timeMar  8 03:08:00
> bloodacpi acpica: [ID 648033 kern.notice] ACPI: APIC 0x       0DBFF028
> 0 00006C (v2 VBOX   VBOXAPIC 00000001 ASL  00000061)
> Mar  8 03:08:00 bloodacpi acpica: [ID 548506 kern.notice] ACPI: HPET 0x
> 0DBFF02F0 000038 (v1 VBOX   VBOXHPET 00000001 ASL  00000061)
> Mar  8 03:08:00 bloodacpi acpica: [ID 517261 kern.notice] ACPI: MCFG 0x
> 0DBFF0330 00003C (v1 VBOX   VBOXMCFG 00000001 ASL  00000061)
> Mar  8 03:08:00 bloodacpi acpica: [ID 272102 kern.notice] ACPI: SSDT 0x
> 0DBFF0370 0001CC (v1 VBOX   VBOXCPUT 00000002 INTL 20100528)
> Mar  8 03:08:00 bloodacpi acpica: [ID 791000 kern.notice] ACPI Error: No
> handler for Region [SYSI] (ffffff01cb5fcc90) [SystemIO]
> (20160212/evregion-255) Mar  8 03:08:00 bloodacpi acpica: [ID 814936
> kern.notice] ACPI Error: Region SystemIO (ID=3D1) has no handler
> (20160212/exfldio-395) Mar  8 03:08:00 bloodacpi acpica: [ID 947390
> kern.notice] ACPI Error: Method parse/execution failed [\] (Node
> fffffffffbd0c1e0), AE_NOT_EXIST (20160212/psparse-631) Mar  8 03:08:00
> bloodacpi acpica: [ID 190582 kern.notice] ACPI: Executed 1 blocks of
> module-level executable AML code Mar  8 03:08:00 bloodacpi acpica: [ID
> 542867 kern.notice] ACPI: 2 ACPI AML tables successfully acquired and
> loaded Mar  8 03:08:00 bloodacpi acpica: [ID 100000 kern.notice] Mar  8
> 03:08:00 bloodacpi acpica: [ID 823235 kern.notice] ACPI: Enabled 2 GPEs in
> block 00 to 07
> =

> The above is what's emitted. I'm curious about the "No hander for Region
> [SYSI]..." and related lines (as well as the odd spaces that have appeared
> in the output between "0x" and the value after each table type, but that's
> a minor issue at the moment)
> =

> I *think* the relevant code to this issue is here:
> http://grok.elemental.org/source/xref/illumos-omnios-
> bloody/usr/src/uts/intel/io/acpica/acpica.c#192
> =

> But after reading through things a few times, I'm not entirely sure if I'm
> actually missing something, or if these handlers need to be removed and
> replaced with something else. This error for the SystemIO hander do not
> show up under the current ACPICA code in illumos, which is based on ACPICA
> 20110527
> =

> Any tips would be appreciated.
> /dale


--===============4428473832145787707==--

