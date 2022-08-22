Content-Type: multipart/mixed; boundary="===============5887588270126638544=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: [Devel] Re: Bug: Re: [PATCH v3] ACPI: Split out processor thermal
 register from ACPI PSS
Date: Mon, 22 Aug 2022 14:25:24 +0200
Message-ID: <CAJZ5v0gx+eY-wOHmVip4VTCwjco=_yeSX5t76q39dUKyB7vBiw@mail.gmail.com>
In-Reply-To: TYWP286MB26016A8EF8040BE37DE9A27BB1719@TYWP286MB2601.JPNP286.PROD.OUTLOOK.COM
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============5887588270126638544==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 22, 2022 at 10:19 AM Riwen Lu <luriwen(a)hotmail.com> wrote:
>
> =E5=9C=A8 2022/8/19 04:23, Jeremy Linton =E5=86=99=E9=81=93:
> > Hi,
> >
> > On 6/16/22 21:51, Riwen Lu wrote:
> >> From: Riwen Lu <luriwen(a)kylinos.cn>
> >>
> >> Commit 239708a3af44 ("ACPI: Split out ACPI PSS from ACPI Processor
> >> driver"), moves processor thermal registration to acpi_pss_perf_init(),
> >> which doesn't get executed if ACPI_CPU_FREQ_PSS is not enabled.
> >>
> >> As ARM64 supports P-states using CPPC, it should be possible to also
> >> support processor passive cooling even if PSS is not enabled. Split
> >> out the processor thermal cooling register from ACPI PSS to support
> >> this, and move it into a separate function in processor_thermal.c.
> >
> > It appears this commit 7fdc74da940d ACPI: processor: Split out thermal
> > initialization from ACPI PSS
> >
> > Is causing the following:
> >     41.341659] ------------[ cut here ]------------
> > [   41.346280] freq_qos_remove_request() called for unknown object
> > [   41.352251] WARNING: CPU: 3 PID: 1089 at kernel/power/qos.c:597
> > freq_qos_remove_request+0xa4/0xc4
> > [   41.361152] Modules linked in: nf_nat_tftp nft_objref
> > nf_conntrack_tftp nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib
> > nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct
> > nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip_set
> > nf_tables nfnetlink qrtr bnep sunrpc vfat fat btsdio brcmfmac hci_uart
> > btqca cfg80211 bs
> > [   41.413245] CPU: 3 PID: 1089 Comm: rmmod Not tainted 6.0.0-rc1MINI+ =
#237
> > [   41.419951] Hardware name: Raspberry Pi Foundation Raspberry Pi 4
> > Model B/Raspberry Pi 4 Model B, BIOS EDK2-DEV 07/18/2022
> > [   41.430990] pstate: 40400005 (nZcv daif +PAN -UAO -TCO -DIT -SSBS
> > BTYPE=3D--)
> > [   41.437955] pc : freq_qos_remove_request+0xa4/0xc4
> > [   41.442752] lr : freq_qos_remove_request+0xa4/0xc4
> > [   41.447550] sp : ffff80000a4bbb60
> > [   41.450862] x29: ffff80000a4bbb60 x28: ffff07858798a1c0 x27:
> > 0000000000000000
> > [   41.458012] x26: 0000000000000000 x25: ffffdf6ade80f850 x24:
> > ffff07858b07d200
> > [   41.465158] x23: ffffdf6ade812cb0 x22: ffff07858b07d000 x21:
> > ffffdf6ade80f850
> > [   41.472303] x20: ffffdf6ade26b998 x19: ffff0785809ba5a8 x18:
> > ffffffffffffffff
> > [   41.479447] x17: 0000000000000000 x16: ffffdf6adcc25320 x15:
> > 0000000000000006
> > [   41.486592] x14: 0000000000000000 x13: 7463656a626f206e x12:
> > 776f6e6b6e752072
> > [   41.493736] x11: 00000000ffffdfff x10: ffffdf6ade8fd520 x9 :
> > ffffdf6adcae53ac
> > [   41.500881] x8 : 000000000002ffe8 x7 : c0000000ffffdfff x6 :
> > 0000000000000001
> > [   41.508026] x5 : 0000000000000000 x4 : ffff07863b7ac450 x3 :
> > ffff07863b7b8bb0
> > [   41.515170] x2 : 0000000000000001 x1 : ffff281b5d54f000 x0 :
> > 0000000000000033
> > [   41.522315] Call trace:
> > [   41.524759]  freq_qos_remove_request+0xa4/0xc4
> > [   41.529210]  acpi_thermal_cpufreq_exit+0x90/0xb0
> > [   41.533834]  acpi_processor_notifier+0x74/0x90
> > [   41.538281]  blocking_notifier_call_chain+0x78/0xb0
> > [   41.543161]  cpufreq_policy_free+0x154/0x1e0
> > [   41.547438]  cpufreq_remove_dev+0xc0/0x10c
> > [   41.551538]  subsys_interface_unregister+0xf0/0xfc
> > [   41.556335]  cpufreq_unregister_driver+0x54/0x120
> > [   41.561043]  cppc_cpufreq_exit+0x28/0xd2c [cppc_cpufreq]
> > [   41.566370]  __do_sys_delete_module.constprop.0+0x150/0x2bc
> > [   41.571947]  __arm64_sys_delete_module+0x20/0x30
> > [   41.576567]  invoke_syscall+0x50/0x120
> > [   41.580318]  el0_svc_common.constprop.0+0x4c/0xf4
> > [   41.585023]  do_el0_svc+0x38/0x4c
> > [   41.588338]  el0_svc+0x34/0xdc
> > [   41.591394]  el0t_64_sync_handler+0x11c/0x150
> > [   41.595752]  el0t_64_sync+0x190/0x194
> > [   41.599416] ---[ end trace 0000000000000000 ]---
> >
> > When the cppc_cpufreq driver is rmmod'ed from a running machine that has
> > both CPPC and a thermal zone. I reverted and bisected it, and in both
> > cases the splat above goes away.
>
> Did you enable the option ACPI_CPU_FREQ_PSS ? When I reverted the commit
> 7fdc74da940d and enable ACPI_CPU_FREQ_PSS, the warning above also appears.

AFAICS, this option is enabled automatically on all architectures
other than ARM64 when the ACPI processor driver is enabled, so I'm not
sure what you mean.
--===============5887588270126638544==--

