Content-Type: multipart/mixed; boundary="===============4901037732665432209=="
MIME-Version: 1.0
From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi at huawei.com>
Subject: Re: [Devel] [PATCH v2 2/2] iommu/arm-smmu-v3:Enable ACPI based
 HiSilicon erratum 161010801
Date: Tue, 20 Jun 2017 15:39:30 +0000
Message-ID: <5FC3163CFD30C246ABAA99954A238FA8383866C7@FRAEML521-MBS.china.huawei.com>
In-Reply-To: d6e824b0-17bd-dd41-2d11-0491d8f66759@arm.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============4901037732665432209==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



> -----Original Message-----
> From: Robin Murphy [mailto:robin.murphy(a)arm.com]
> Sent: Tuesday, June 20, 2017 4:16 PM
> To: Shameerali Kolothum Thodi; Lorenzo Pieralisi
> Cc: marc.zyngier(a)arm.com; sudeep.holla(a)arm.com; will.deacon(a)arm.com;
> hanjun.guo(a)linaro.org; Gabriele Paoloni; John Garry; iommu(a)lists.linu=
x-
> foundation.org; linux-arm-kernel(a)lists.infradead.org; linux-
> acpi(a)vger.kernel.org; devel(a)acpica.org; Linuxarm; Wangzhou (B);
> Guohanjun (Hanjun Guo)
> Subject: Re: [PATCH v2 2/2] iommu/arm-smmu-v3:Enable ACPI based
> HiSilicon erratum 161010801
> =

> On 20/06/17 15:07, Shameerali Kolothum Thodi wrote:
> >
> >
> >> -----Original Message-----
> >> From: Lorenzo Pieralisi [mailto:lorenzo.pieralisi(a)arm.com]
> >> Sent: Tuesday, June 20, 2017 11:29 AM
> >> To: Shameerali Kolothum Thodi
> >> Cc: marc.zyngier(a)arm.com; sudeep.holla(a)arm.com;
> will.deacon(a)arm.com;
> >> robin.murphy(a)arm.com; hanjun.guo(a)linaro.org; Gabriele Paoloni; John
> >> Garry; iommu(a)lists.linux-foundation.org; linux-arm-
> >> kernel(a)lists.infradead.org; linux-acpi(a)vger.kernel.org;
> devel(a)acpica.org;
> >> Linuxarm; Wangzhou (B); Guohanjun (Hanjun Guo)
> >> Subject: Re: [PATCH v2 2/2] iommu/arm-smmu-v3:Enable ACPI based
> >> HiSilicon erratum 161010801
> >>
> >> Hi Shameer,
> >>
> >> On Mon, Jun 19, 2017 at 04:45:00PM +0100, shameer wrote:
> >>> The HiSilicon erratum 161010801 describes the limitation of HiSilicon
> >>> platforms Hip06/Hip07 to support the SMMU mappings for MSI
> >> transactions.
> >>>
> >>> On these platforms GICv3 ITS translator is presented with the deviceID
> >>> by extending the MSI payload data to 64 bits to include the deviceID.
> >>> Hence, the PCIe controller on this platforms has to differentiate the
> >>> MSI payload against other DMA payload and has to modify the MSI
> >> payload.
> >>> This basically makes it difficult for this platforms to have a SMMU
> >>> translation for MSI.
> >>>
> >>> This patch implements a ACPI table based quirk to reserve the hw msi
> >>> regions in the smmu-v3 driver which means these address regions will
> >>> not be translated and will be excluded from iova allocations.
> >>>
> >>> Signed-off-by: shameer <shameerali.kolothum.thodi(a)huawei.com>
> >>> ---
> >>>  drivers/iommu/arm-smmu-v3.c | 29 ++++++++++++++++++++++++-----
> >>>  1 file changed, 24 insertions(+), 5 deletions(-)
> >>>
> >>> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-
> smmu-
> >> v3.c
> >>> index abe4b88..f03c63b 100644
> >>> --- a/drivers/iommu/arm-smmu-v3.c
> >>> +++ b/drivers/iommu/arm-smmu-v3.c
> >>> @@ -597,6 +597,7 @@ struct arm_smmu_device {
> >>>  	u32				features;
> >>>
> >>>  #define ARM_SMMU_OPT_SKIP_PREFETCH	(1 << 0)
> >>> +#define ARM_SMMU_OPT_RESV_HW_MSI	(1 << 1)
> >>>  	u32				options;
> >>>
> >>>  	struct arm_smmu_cmdq		cmdq;
> >>> @@ -1904,14 +1905,31 @@ static void
> arm_smmu_get_resv_regions(struct
> >> device *dev,
> >>>  				      struct list_head *head)
> >>>  {
> >>>  	struct iommu_resv_region *region;
> >>> +	struct arm_smmu_device *smmu;
> >>> +	struct iommu_fwspec *fwspec =3D dev->iommu_fwspec;
> >>>  	int prot =3D IOMMU_WRITE | IOMMU_NOEXEC | IOMMU_MMIO;
> >>>
> >>> -	region =3D iommu_alloc_resv_region(MSI_IOVA_BASE,
> >> MSI_IOVA_LENGTH,
> >>> -					 prot, IOMMU_RESV_SW_MSI);
> >>> -	if (!region)
> >>> -		return;
> >>> +	smmu =3D arm_smmu_get_by_fwnode(fwspec->iommu_fwnode);
> >>> +
> >>> +	if (smmu && (smmu->options & ARM_SMMU_OPT_RESV_HW_MSI)
> >> &&
> >>> +		      dev_is_pci(dev)) {
> >>
> >> IORT changes are fine to me, I am still no big fan of this supposedly
> >> generic option that is _really_ platform specific (in particular as I
> >> said before the quirk depends on the PCI host bridge but in this
> >> patchset I see no such dependency. In short - the quirk is hooked off
> >> the SMMUv3 model which implicitly implies a PCI host bridge
> >> configuration IIUC). It is Will and Robin decision though, I am not su=
re
> >> you can make it any tidier (given that on ACPI you may not even have
> >> a PCI host bridge specific _HID to base your check above on).
> >
> > Thanks Lorenzo. I understand your point. As far as our platform is
> > concerned, I think It is ok to remove the dev_is_pci() check and make
> > it generic, if that helps.  I don't think it will harm us other than co=
uple of
> >  "HW MSI region resv failed: " logs  for our platform devices.
> =

> I think the answer there is that iort_iommu_its_get_resv_regions()
> really should distinguish between "this device just doesn't have an ITS
> mapping" and "something actually went wrong", such that you don't treat
> the former as an error. That's almost certainly cleaner than e.g. trying
> to check if dev has an associated MSI domain here before calling it.

If I understood that correctly, the suggestion is to treat cases where devi=
ce
doesn=E2=80=99t have any ITS node associated with it as "success".

+int iort_iommu_its_get_resv_regions(struct device *dev, struct list_head *=
head)
+{
[....]
+	if (!its_node)
+		return -ENODEV;

ie, return success above from patch 1/2.

Lorenzo, =


Please let me know if that=E2=80=99s a correct thing to do as I am not sure=
 about all the error
scenarios here.

Thanks,
Shameer


--===============4901037732665432209==--

