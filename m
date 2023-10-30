Return-Path: <miguel.luis@oracle.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5317260B01
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C247160AFE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=Z2jXVO4hl1wrQB3bDyl9yo/p7WU1EngbAiRM1KEv51o=;
 b=vuSZeLnv750kbKLUpmX6fI0yeuEE3BvaK32K1qBo8jS8IYhLJg4d8fAV3xmwgZ49lhtw
 SwHZCHIbxdkct65wGl/EL2kAKTRKKNK+wJRAF5PfwAATOM+0uxUtVAY8v57lsMjvQqEg
 GQJzWXyv4W3VAWgrF2q0KBLry/TjPKmdUaEQy2abWmSi0gy+msu2QRfPDuuGsIai7A29
 16VkIHqnwy6hsMKx9NgRjgFMQpbVHaoEUncDOigLYmRxaQl06w0gt3oegQipFke6IlBW
 rvjjDVsIY1yzns/PduTjYWKtGyLuzWi5B5jGuugTqrDts5XFcCe/b/U0p7N2BOh0xEtd yg== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z2jXVO4hl1wrQB3bDyl9yo/p7WU1EngbAiRM1KEv51o=;
 b=ePtdatU17WLevJcB8gCokhQKKbl/G1QUi/t6owhs/sO642ulEwbcB4lzLmkZxUS/GeR0Xm/mWSKupLmxgizVbXNtZUSOzYg24qw3T6JSHU3Ccexko94Q3UFoubLXmv3VSgvpVcnD9OBY6You7PE+HTcsOdetk0oGpF2oPbtg/DQ=
From: Miguel Luis <miguel.luis@oracle.com>
Date: Mon, 30 Oct 2023 16:41:19 +0000
Message-ID: <C2C5C292-AD2C-4D98-8225-39ABE68C5395@oracle.com>
References: <ZTffkAdOqL2pI2la@shell.armlinux.org.uk>
In-Reply-To: <ZTffkAdOqL2pI2la@shell.armlinux.org.uk>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1D5E7B22C1FE2F4B9D62B2D8021B6A07@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Acpica-devel] [RFC PATCH v3 00/39] ACPI/arm64: add support for
 virtual cpuhotplug
List-Id: "This is the central place for ACPICA developer discussions and
 issues." <acpica-devel.lists.linuxfoundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/acpica-devel/>
List-Post: <mailto:acpica-devel@lists.linuxfoundation.org>
List-Help: <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=subscribe>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Jean-Philippe Brucker <jean-philippe@linaro.org>, Salil Mehta <salil.mehta@huawei.com>, "jianyong.wu@arm.com" <jianyong.wu@arm.com>, "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>, "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, James Morse <james.morse@arm.com>, "loongarch@lists.linux.dev" <loongarch@lists.linux.dev>, "kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>, "justin.he@arm.com" <justin.he@arm.com>, "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>, "acpica-devel@lists.linuxfoundation.org" <acpica-devel@lists.linuxfoundation.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Russell,

> On 24 Oct 2023, at 15:15, Russell King (Oracle) <linux@armlinux.org.uk> w=
rote:
>=20
> Hi,
>=20
> I'm posting James' patch set updated with most of the review comments
> from his RFC v2 series back in September. Individual patches have a
> changelog attached at the bottom of the commit message. Those which
> I have finished updating have my S-o-b on them, those which still have
> outstanding review comments from RFC v2 do not. In some of these cases
> I've asked questions and am waiting for responses.
>=20
> I'm posting this as RFC v3 because there's still some unaddressed
> comments and it's clearly not ready for merging. Even if it was ready
> to be merged, it is too late in this development cycle to be taking
> this change in, so there would be little point posting it non-RFC.
> Also James stated that he's waiting for confirmation from the
> Kubernetes/Kata folk - I have no idea what the status is there.
>=20
> I will be sending each patch individually to a wider audience
> appropriate for that patch - apologies to those missing out on this
> cover message. I have added more mailing lists to the series with the
> exception of the acpica list in a hope of this cover message also
> reaching those folk.
>=20
> The changes that aren't included are:
>=20
> 1. Updates for my patch that was merged via Thomas (thanks!):
>   c4dd854f740c cpu-hotplug: Provide prototypes for arch CPU registration
>   rather than having this change spread through James' patches.
>=20
> 2. New patch - simplification of PA-RISC's smp_prepare_boot_cpu()
>=20
> 3. Moved "ACPI: Use the acpi_device_is_present() helper in more places"
>   and "ACPI: Rename acpi_scan_device_not_present() to be about
>   enumeration" to the beginning of the series - these two patches are
>   already queued up for merging into 6.7.
>=20
> 4. Moved "arm64, irqchip/gic-v3, ACPI: Move MADT GICC enabled check into
>   a helper" to the beginning of the series, which has been submitted,
>   but as yet the fate of that posting isn't known.
>=20
> The first four patches in this series are provided for completness only.
>=20
> There is an additional patch in James' git tree that isn't in the set
> of patches that James posted: "ACPI: processor: Only call
> arch_unregister_cpu() if HOTPLUG_CPU is selected" which looks to me to
> be a workaround for arch_unregister_cpu() being under the ifdef. I've
> commented on this on the RFC v2 posting making a suggestion, but as yet
> haven't had any response.
>=20
> I've included almost all of James' original covering body below the
> diffstat.
>=20
> The reason that I'm doing this is to help move this code forward so
> hopefully it can be merged - which is why I have been keen to dig out
> from James' patches anything that can be merged and submit it
> separately, since this is a feature for which some users have a
> definite need for.
>=20
> Please note that I haven't tested this beyond building for aarch64 at
> the present time.
>=20
> The series can be found at:
>=20
> git://git.armlinux.org.uk/~rmk/linux-arm.git aarch64/hotplug-vcpu/v6.6-rc=
7
>=20
> Documentation/arch/arm64/cpu-hotplug.rst   |  79 +++++++++++++++
> Documentation/arch/arm64/index.rst         |   1 +
> arch/arm64/Kconfig                         |   1 +
> arch/arm64/include/asm/acpi.h              |  11 +++
> arch/arm64/include/asm/cpu.h               |   1 -
> arch/arm64/kernel/acpi_numa.c              |  11 ---
> arch/arm64/kernel/psci.c                   |   2 +-
> arch/arm64/kernel/setup.c                  |  13 +--
> arch/arm64/kernel/smp.c                    |   5 +-
> arch/ia64/Kconfig                          |   3 +
> arch/ia64/include/asm/acpi.h               |   2 +-
> arch/ia64/include/asm/cpu.h                |   6 --
> arch/ia64/kernel/acpi.c                    |   6 +-
> arch/ia64/kernel/setup.c                   |   2 +-
> arch/ia64/kernel/topology.c                |  35 +------
> arch/loongarch/Kconfig                     |   2 +
> arch/loongarch/configs/loongson3_defconfig |   2 +-
> arch/loongarch/kernel/acpi.c               |   4 +-
> arch/loongarch/kernel/topology.c           |  38 +-------
> arch/parisc/kernel/smp.c                   |   8 +-
> arch/riscv/Kconfig                         |   1 +
> arch/riscv/kernel/setup.c                  |  19 +---
> arch/x86/Kconfig                           |   3 +
> arch/x86/include/asm/cpu.h                 |   4 -
> arch/x86/kernel/acpi/boot.c                |   4 +-
> arch/x86/kernel/cpu/intel_epb.c            |   2 +-
> arch/x86/kernel/topology.c                 |  27 +-----
> drivers/acpi/Kconfig                       |  14 ++-
> drivers/acpi/acpi_processor.c              | 151 +++++++++++++++++++++++-=
-----
> drivers/acpi/bus.c                         |  16 +++
> drivers/acpi/device_pm.c                   |   2 +-
> drivers/acpi/device_sysfs.c                |   2 +-
> drivers/acpi/internal.h                    |   1 -
> drivers/acpi/processor_core.c              |   2 +-
> drivers/acpi/property.c                    |   2 +-
> drivers/acpi/scan.c                        | 148 ++++++++++++++++++------=
----
> drivers/base/arch_topology.c               |  38 +++++---
> drivers/base/cpu.c                         |  44 +++++++--
> drivers/base/init.c                        |   2 +-
> drivers/base/node.c                        |   7 --
> drivers/firmware/psci/psci.c               |   2 +
> drivers/irqchip/irq-gic-v3.c               |  38 +++++---
> include/acpi/acpi_bus.h                    |   1 +
> include/acpi/actbl2.h                      |   1 +
> include/linux/acpi.h                       |  13 ++-
> include/linux/cpu.h                        |   4 +
> include/linux/cpumask.h                    |  25 +++++
> kernel/cpu.c                               |   3 +
> 48 files changed, 516 insertions(+), 292 deletions(-)
>=20
>=20
> On Wed, Sep 13, 2023 at 04:37:48PM +0000, James Morse wrote:
>> Hello!
>>=20
>> Changes since RFC-v1:
>> * riscv is new, ia64 is gone
>> * The KVM support is different, and upstream - no need to patch the host=
.
>>=20
>> ---
>>=20
>> This series adds what looks like cpuhotplug support to arm64 for use in
>> virtual machines. It does this by moving the cpu_register() calls for
>> architectures that support ACPI out of the arch code by using
>> GENERIC_CPU_DEVICES, then into the ACPI processor driver.
>>=20
>> The kubernetes folk really want to be able to add CPUs to an existing VM=
,
>> in exactly the same way they do on x86. The use-case is pre-booting gues=
ts
>> with one CPU, then adding the number that were actually needed when the
>> workload is provisioned.
>>=20
>> Wait? Doesn't arm64 support cpuhotplug already!?
>> In the arm world, cpuhotplug gets used to mean removing the power from a=
 CPU.
>> The CPU is offline, and remains present. For x86, and ACPI, cpuhotplug
>> has the additional step of physically removing the CPU, so that it isn't
>> present anymore.
>>=20
>> Arm64 doesn't support this, and can't support it: CPUs are really a slic=
e
>> of the SoC, and there is not enough information in the existing ACPI tab=
les
>> to describe which bits of the slice also got removed. Without a referenc=
e
>> machine: adding this support to the spec is a wild goose chase.
>>=20
>> Critically: everything described in the firmware tables must remain pres=
ent.
>>=20
>> For a virtual machine this is easy as all the other bits of 'virtual SoC=
'
>> are emulated, so they can (and do) remain present when a vCPU is 'remove=
d'.
>>=20
>> On a system that supports cpuhotplug the MADT has to describe every poss=
ible
>> CPU at boot. Under KVM, the vGIC needs to know about every possible vCPU=
 before
>> the guest is started.
>> With these constraints, virtual-cpuhotplug is really just a hypervisor/f=
irmware
>> policy about which CPUs can be brought online.
>>=20
>> This series adds support for virtual-cpuhotplug as exactly that: firmwar=
e
>> policy. This may even work on a physical machine too; for a guest the pa=
rt of
>> firmware is played by the VMM. (typically Qemu).
>>=20
>> PSCI support is modified to return 'DENIED' if the CPU can't be brought
>> online/enabled yet. The CPU object's _STA method's enabled bit is used t=
o
>> indicate firmware's current disposition. If the CPU has its enabled bit =
clear,
>> it will not be registered with sysfs, and attempts to bring it online wi=
ll
>> fail. The notifications that _STA has changed its value then work in the=
 same
>> way as physical hotplug, and firmware can cause the CPU to be registered=
 some
>> time later, allowing it to be brought online.
>>=20
>> This creates something that looks like cpuhotplug to user-space, as the =
sysfs
>> files appear and disappear, and the udev notifications look the same.
>>=20
>> One notable difference is the CPU present mask, which is exposed via sys=
fs.
>> Because the CPUs remain present throughout, they can still be seen in th=
at mask.
>> This value does get used by webbrowsers to estimate the number of CPUs
>> as the CPU online mask is constantly changed on mobile phones.
>>=20
>> Linux is tolerant of PSCI returning errors, as its always been allowed t=
o do
>> that. To avoid confusing OS that can't tolerate this, we needed an addit=
ional
>> bit in the MADT GICC flags. This series copies ACPI_MADT_ONLINE_CAPABLE,=
 which
>> appears to be for this purpose, but calls it ACPI_MADT_GICC_CPU_CAPABLE =
as it
>> has a different bit position in the GICC.
>>=20
>> This code is unconditionally enabled for all ACPI architectures.
>> If there are problems with firmware tables on some devices, the CPUs wil=
l
>> already be online by the time the acpi_processor_make_enabled() is calle=
d.
>> A mismatch here causes a firmware-bug message and kernel taint. This sho=
uld
>> only affect people with broken firmware who also boot with maxcpus=3D1, =
and
>> bring CPUs online later.
>>=20
>> I had a go at switching the remaining architectures over to GENERIC_CPU_=
DEVICES,
>> so that the Kconfig symbol can be removed, but I got stuck with powerpc
>> and s390.
>>=20
>> I've only build tested Loongarch and riscv. I've removed the ia64 specif=
ic
>> patches, but left the changes in other patches to make git-grep review o=
f
>> renames easier.
>>=20
>> If folk want to play along at home, you'll need a copy of Qemu that supp=
orts this.
>> https://github.com/salil-mehta/qemu.git salil/virt-cpuhp-armv8/rfc-v2-rc=
6
>>=20
>> Replace your '-smp' argument with something like:
>> | -smp cpus=3D1,maxcpus=3D3,cores=3D3,threads=3D1,sockets=3D1
>>=20
>> then feed the following to the Qemu montior;
>> | (qemu) device_add driver=3Dhost-arm-cpu,core-id=3D1,id=3Dcpu1
>> | (qemu) device_del cpu1
>>=20
>>=20
>> Why is this still an RFC? I'm still looking for confirmation from the
>> kubernetes/kata folk that this works for them. Because of this I've cull=
ed
>> the CC list...
>>=20
>>=20
>> This series is based on v6.6-rc1, and can be retrieved from:
>> https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git/ virtual=
_cpu_hotplug/rfc/v2
>>=20
>>=20
>> Thanks,
>>=20
>> James Morse (34):
>>  ACPI: Move ACPI_HOTPLUG_CPU to be disabled on arm64 and riscv
>>  drivers: base: Use present CPUs in GENERIC_CPU_DEVICES
>>  drivers: base: Allow parts of GENERIC_CPU_DEVICES to be overridden
>>  drivers: base: Move cpu_dev_init() after node_dev_init()
>>  drivers: base: Print a warning instead of panic() when register_cpu()
>>    fails
>>  arm64: setup: Switch over to GENERIC_CPU_DEVICES using
>>    arch_register_cpu()
>>  x86: intel_epb: Don't rely on link order
>>  x86/topology: Switch over to GENERIC_CPU_DEVICES
>>  LoongArch: Switch over to GENERIC_CPU_DEVICES
>>  riscv: Switch over to GENERIC_CPU_DEVICES
>>  arch_topology: Make register_cpu_capacity_sysctl() tolerant to late
>>    CPUs
>>  ACPI: Use the acpi_device_is_present() helper in more places
>>  ACPI: Rename acpi_scan_device_not_present() to be about enumeration
>>  ACPI: Only enumerate enabled (or functional) devices
>>  ACPI: processor: Add support for processors described as container
>>    packages
>>  ACPI: processor: Register CPUs that are online, but not described in
>>    the DSDT
>>  ACPI: processor: Register all CPUs from acpi_processor_get_info()
>>  ACPI: Rename ACPI_HOTPLUG_CPU to include 'present'
>>  ACPI: Move acpi_bus_trim_one() before acpi_scan_hot_remove()
>>  ACPI: Rename acpi_processor_hotadd_init and remove pre-processor
>>    guards
>>  ACPI: Add post_eject to struct acpi_scan_handler for cpu hotplug
>>  ACPI: Check _STA present bit before making CPUs not present
>>  ACPI: Warn when the present bit changes but the feature is not enabled
>>  drivers: base: Implement weak arch_unregister_cpu()
>>  LoongArch: Use the __weak version of arch_unregister_cpu()
>>  arm64: acpi: Move get_cpu_for_acpi_id() to a header
>>  ACPICA: Add new MADT GICC flags fields [code first?]
>>  arm64, irqchip/gic-v3, ACPI: Move MADT GICC enabled check into a
>>    helper
>>  irqchip/gic-v3: Don't return errors from gic_acpi_match_gicc()
>>  irqchip/gic-v3: Add support for ACPI's disabled but 'online capable'
>>    CPUs
>>  ACPI: add support to register CPUs based on the _STA enabled bit
>>  arm64: document virtual CPU hotplug's expectations
>>  ACPI: Add _OSC bits to advertise OS support for toggling CPU
>>    present/enabled
>>  cpumask: Add enabled cpumask for present CPUs that can be brought
>>    online
>>=20
>> Jean-Philippe Brucker (1):
>>  arm64: psci: Ignore DENIED CPUs
>=20

Tested on QEMU, based on Salil's RFC v2 [1], running with KVM.
- boot
- hotplug up to 'maxcpus'
- hotunplug down to the number of boot cpus
- hotplug vcpus and migrate with vcpus offline
- hotplug vcpus and migrate with vcpus online
- hotplug vcpus then unplug vcpus then migrate
- successive live migrations (up until 6)

Feel free to add:
Tested-by: Miguel Luis <miguel.luis@oracle.com>

Thank you
Miguel

[1] https://lore.kernel.org/qemu-devel/20230926100436.28284-1-salil.mehta@h=
uawei.com/

> --=20
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
>=20

