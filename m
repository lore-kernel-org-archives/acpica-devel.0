Content-Type: multipart/mixed; boundary="===============3129644092500208112=="
MIME-Version: 1.0
From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi at huawei.com>
Subject: [Devel] Re: [RFC PATCH v2 0/8] ACPI/IORT: Support for IORT RMR node
Date: Thu, 15 Apr 2021 10:37:02 +0000
Message-ID: <f061e603b440466db26be9baf334f2b0@huawei.com>
In-Reply-To: 2e58d4e6-83fd-b5cf-b2db-7575cb197058@redhat.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============3129644092500208112==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

[+Lorenzo]

> -----Original Message-----
> From: Auger Eric [mailto:eric.auger(a)redhat.com]
> Sent: 15 April 2021 10:49
> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi(a)huawei.com>;
> linux-arm-kernel(a)lists.infradead.org; linux-acpi(a)vger.kernel.org;
> iommu(a)lists.linux-foundation.org; devel(a)acpica.org
> Cc: Linuxarm <linuxarm(a)huawei.com>; steven.price(a)arm.com; Guohanjun
> (Hanjun Guo) <guohanjun(a)huawei.com>; Sami.Mujawar(a)arm.com;
> robin.murphy(a)arm.com; wanghuiqiang <wanghuiqiang(a)huawei.com>;
> Jean-Philippe Brucker <jean-philippe(a)linaro.org>
> Subject: Re: [RFC PATCH v2 0/8] ACPI/IORT: Support for IORT RMR node
> =

> Hi Shameer,
> =

> + Jean-Philippe
> =

> =

> On 11/19/20 1:11 PM, Shameer Kolothum wrote:
> > RFC v1 --> v2:
> > =C2=A0- Added a generic interface for IOMMU drivers to retrieve all the
> > =C2=A0 =C2=A0RMR info associated with a given IOMMU.
> > =C2=A0- SMMUv3 driver gets the RMR list during probe() and installs
> > =C2=A0=C2=A0 bypass STEs for all the SIDs in the RMR list. This is to k=
eep
> >  =C2=A0 the ongoing traffic alive(if any) during SMMUv3 reset. This is
> >    based on the suggestions received for v1 to take care of the
> >    EFI framebuffer use case. Only sanity tested for now.
> > =C2=A0- During the probe/attach device, SMMUv3 driver reserves any
> > =C2=A0 =C2=A0RMR region associated with the device such that there is a=
 unity
> > =C2=A0 =C2=A0mapping for them in SMMU.
> > ---
> >
> > The series adds support to IORT RMR nodes specified in IORT
> > Revision E -ARM DEN 0049E[0]. RMR nodes are used to describe memory
> > ranges that are used by endpoints and require a unity mapping
> > in SMMU.
> >
> > We have faced issues with 3408iMR RAID controller cards which
> > fail to boot when SMMU is enabled. This is because these controllers
> > make use of host memory for various caching related purposes and when
> > SMMU is enabled the iMR firmware fails to access these memory regions
> > as there is no mapping for them. IORT RMR provides a way for UEFI to
> > describe and report these memory regions so that the kernel can make
> > a unity mapping for these in SMMU.
> >
> > RFC because, Patch #1 is to update the actbl2.h and should be done
> > through acpica update. I have send out a pull request[1] for that.
> >
> > Tests:
> >
> > With a UEFI, that reports the RMR for the dev,
> > ....
> > [16F0h 5872   1]                         Type : 06
> > [16F1h 5873   2]                       Length : 007C
> > [16F3h 5875   1]                     Revision : 00
> > [1038h 0056   2]                     Reserved : 00000000
> > [1038h 0056   2]                   Identifier : 00000000
> > [16F8h 5880   4]                Mapping Count : 00000001
> > [16FCh 5884   4]               Mapping Offset : 00000040
> >
> > [1700h 5888   4]    Number of RMR Descriptors : 00000002
> > [1704h 5892   4]        RMR Descriptor Offset : 00000018
> >
> > [1708h 5896   8]          Base Address of RMR : 0000E6400000
> > [1710h 5904   8]                Length of RMR : 000000100000
> > [1718h 5912   4]                     Reserved : 00000000
> >
> > [171Ch 5916   8]          Base Address of RMR : 0000000027B00000
> > [1724h 5924   8]                Length of RMR : 0000000000C00000
> > [172Ch 5932   4]                     Reserved : 00000000
> >
> > [1730h 5936   4]                   Input base : 00000000
> > [1734h 5940   4]                     ID Count : 00000001
> > [1738h 5944   4]                  Output Base : 00000003
> > [173Ch 5948   4]             Output Reference : 00000064
> > [1740h 5952   4]        Flags (decoded below) : 00000001
> >                                Single Mapping : 1
> =

> Following Jean-Philippe's suggestion I have used your series for nested
> stage SMMUv3 integration, ie. to simplify the MSI nested stage mapping.
> =

> Host allocates hIOVA -> physical doorbell (pDB) as it normally does for
> VFIO device passthrough. IOVA Range is 0x8000000 - 0x8100000.
> =

> I expose this MIS IOVA range to the guest as an RMR and as a result
> guest has a flat mapping for this range. As the physical device is
> programmed with hIOVA we have the following mapping:
> =

> IOVA            IPA          PA
> hIOVA   ->     hIOVA     ->  pDB
>         S1               s2
> =

> This works.
> =

> The only weird thing is that I need to expose 256 RMRs due to the
> 'Single Mapping' mandatory flag. I need to have 1 RMR per potential SID
> on the bus.

Please see the discussion here,
https://op-lists.linaro.org/pipermail/linaro-open-discussions/2021-April/00=
0150.html

Hi Lorenzo,

May be this is a use case for relaxing that single mapping requirement.

Thanks,
Shameer

> =

> I will post a new version of SMMUv3 nested stage soon for people to test
> & compare. Obviously this removes a bunch of code on both SMMU/VFIO and
> QEMU code so I think this solution looks better overall.
> =

> Thanks
> =

> Eric
> > ...
> >
> > Without the series the RAID controller initialization fails as
> > below,
> >
> > ...
> > [   12.631117] megaraid_sas 0000:03:00.0: FW supports sync
> cache        : Yes
> > [   12.637360] megaraid_sas 0000:03:00.0: megasas_disable_intr_fusion is
> called outbound_intr_mask:0x40000009
> > [   18.776377] megaraid_sas 0000:03:00.0: Init cmd return status FAILED
> for SCSI host 0
> > [   23.019383] megaraid_sas 0000:03:00.0: Waiting for FW to come to
> ready state
> > [  106.684281] megaraid_sas 0000:03:00.0: FW in FAULT state, Fault
> code:0x10000 subcode:0x0 func:megasas_transition_to_ready
> > [  106.695186] megaraid_sas 0000:03:00.0: System Register set:
> > [  106.889787] megaraid_sas 0000:03:00.0: Failed to transition controll=
er to
> ready for scsi0.
> > [  106.910475] megaraid_sas 0000:03:00.0: Failed from megasas_init_fw
> 6407
> > estuary:/$
> >
> > With the series, now the kernel has direct mapping for the dev as
> > below,
> >
> > estuary:/$ cat /sys/kernel/iommu_groups/0/reserved_regions
> > 0x0000000008000000 0x00000000080fffff msi
> > 0x0000000027b00000 0x00000000286fffff direct
> > 0x00000000e6400000 0x00000000e64fffff direct
> > estuary:/$
> >
> > ....
> > [   12.254318] megaraid_sas 0000:03:00.0: megasas_disable_intr_fusion is
> called outbound_intr_mask:0x40000009
> > [   12.739089] megaraid_sas 0000:03:00.0: FW provided supportMaxExtLDs:
> 0      max_lds: 32
> > [   12.746628] megaraid_sas 0000:03:00.0: controller type       :
> iMR(0MB)
> > [   12.752694] megaraid_sas 0000:03:00.0: Online Controller Reset(OCR) =
 :
> Enabled
> > [   12.759798] megaraid_sas 0000:03:00.0: Secure JBOD support   : Yes
> > [   12.765778] megaraid_sas 0000:03:00.0: NVMe passthru support : Yes
> > [   12.771931] megaraid_sas 0000:03:00.0: FW provided TM
> TaskAbort/Reset timeou: 6 secs/60 secs
> > [   12.780503] megaraid_sas 0000:03:00.0: JBOD sequence map
> support     : Yes
> > [   12.787000] megaraid_sas 0000:03:00.0: PCI Lane Margining
> support    : No
> > [   12.819179] megaraid_sas 0000:03:00.0: NVME page size        :
> (4096)
> > [   12.825672] megaraid_sas 0000:03:00.0: megasas_enable_intr_fusion is
> called outbound_intr_mask:0x40000000
> > [   12.835199] megaraid_sas 0000:03:00.0: INIT adapter done
> > [   12.873932] megaraid_sas 0000:03:00.0: pci id                :
> (0x1000)/(0x0017)/(0x19e5)/(0xd213)
> > [   12.881644] megaraid_sas 0000:03:00.0: unevenspan support    : no
> > [   12.887451] megaraid_sas 0000:03:00.0: firmware crash dump   : no
> > [   12.893344] megaraid_sas 0000:03:00.0: JBOD sequence map     :
> enabled
> >
> > RAID controller init is now success and can detect the drives
> > attached as well.
> >
> > Thanks,
> > Shameer
> >
> > [0]. https://developer.arm.com/documentation/den0049/latest/
> > [1]. https://github.com/acpica/acpica/pull/638
> >
> > Shameer Kolothum (8):
> >   ACPICA: IORT: Update for revision E
> >   ACPI/IORT: Add support for RMR node parsing
> >   iommu/dma: Introduce generic helper to retrieve RMR info
> >   ACPI/IORT: Add RMR memory regions reservation helper
> >   iommu/arm-smmu-v3: Introduce strtab init helper
> >   iommu/arm-smmu-v3: Add bypass flag to=C2=A0arm_smmu_write_strtab_ent()
> >   iommu/arm-smmu-v3: Get associated RMR info and install bypass STE
> >   iommu/arm-smmu-v3: Reserve any RMR regions associated with a=C2=A0dev
> >
> >  drivers/acpi/arm64/iort.c                   | 182
> +++++++++++++++++++-
> >  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 112 ++++++++++--
> >  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |   2 +
> >  drivers/iommu/dma-iommu.c                   |  39 +++++
> >  include/acpi/actbl2.h                       |  25 ++-
> >  include/linux/acpi_iort.h                   |   6 +
> >  include/linux/dma-iommu.h                   |   7 +
> >  include/linux/iommu.h                       |  16 ++
> >  8 files changed, 367 insertions(+), 22 deletions(-)
> >


--===============3129644092500208112==--

