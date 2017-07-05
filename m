Content-Type: multipart/mixed; boundary="===============5581664795223630584=="
MIME-Version: 1.0
From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi at huawei.com>
Subject: Re: [Devel] [PATCH v3 2/2] iommu/arm-smmu-v3:Enable ACPI based
 HiSilicon erratum 161010801
Date: Wed, 05 Jul 2017 09:48:53 +0000
Message-ID: <5FC3163CFD30C246ABAA99954A238FA83839DB59@FRAEML521-MBX.china.huawei.com>
In-Reply-To: 20170704173820.GO22175@arm.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============5581664795223630584==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



> -----Original Message-----
> From: Will Deacon [mailto:will.deacon(a)arm.com]
> Sent: Tuesday, July 04, 2017 6:38 PM
> To: Shameerali Kolothum Thodi
> Cc: lorenzo.pieralisi(a)arm.com; marc.zyngier(a)arm.com;
> sudeep.holla(a)arm.com; robin.murphy(a)arm.com; hanjun.guo(a)linaro.org;
> Gabriele Paoloni; John Garry; Linuxarm; linux-acpi(a)vger.kernel.org;
> iommu(a)lists.linux-foundation.org; Wangzhou (B); Guohanjun (Hanjun Guo);
> linux-arm-kernel(a)lists.infradead.org; devel(a)acpica.org
> Subject: Re: [PATCH v3 2/2] iommu/arm-smmu-v3:Enable ACPI based
> HiSilicon erratum 161010801
> =

> On Fri, Jun 23, 2017 at 03:58:01PM +0100, shameer wrote:
> > The HiSilicon erratum 161010801 describes the limitation of HiSilicon
> > platforms Hip06/Hip07 to support the SMMU mappings for MSI
> transactions.
> >
> > On these platforms GICv3 ITS translator is presented with the deviceID
> > by extending the MSI payload data to 64 bits to include the deviceID.
> > Hence, the PCIe controller on this platforms has to differentiate the
> > MSI payload against other DMA payload and has to modify the MSI
> payload.
> > This basically makes it difficult for this platforms to have a SMMU
> > translation for MSI.
> >
> > This patch implements a ACPI table based quirk to reserve the hw msi
> > regions in the smmu-v3 driver which means these address regions will
> > not be translated and will be excluded from iova allocations.
> >
> > Signed-off-by: shameer <shameerali.kolothum.thodi(a)huawei.com>
> > ---
> >  drivers/iommu/arm-smmu-v3.c | 30 ++++++++++++++++++++++++++----
> >  1 file changed, 26 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-
> v3.c
> > index abe4b88..c9346f2 100644
> > --- a/drivers/iommu/arm-smmu-v3.c
> > +++ b/drivers/iommu/arm-smmu-v3.c
> > @@ -597,6 +597,7 @@ struct arm_smmu_device {
> >  	u32				features;
> >
> >  #define ARM_SMMU_OPT_SKIP_PREFETCH	(1 << 0)
> > +#define ARM_SMMU_OPT_RESV_HW_MSI	(1 << 1)
> >  	u32				options;
> >
> >  	struct arm_smmu_cmdq		cmdq;
> > @@ -1904,14 +1905,34 @@ static void arm_smmu_get_resv_regions(struct
> device *dev,
> >  				      struct list_head *head)
> >  {
> >  	struct iommu_resv_region *region;
> > +	struct arm_smmu_device *smmu;
> > +	struct iommu_fwspec *fwspec =3D dev->iommu_fwspec;
> >  	int prot =3D IOMMU_WRITE | IOMMU_NOEXEC | IOMMU_MMIO;
> > +	int resv =3D 0;
> >
> > -	region =3D iommu_alloc_resv_region(MSI_IOVA_BASE,
> MSI_IOVA_LENGTH,
> > -					 prot, IOMMU_RESV_SW_MSI);
> > -	if (!region)
> > +	smmu =3D arm_smmu_get_by_fwnode(fwspec->iommu_fwnode);
> =

> Does this callback actually get called without a prior ->add_device callb=
ack
> for the master in question? If not, then we can already claw the structure
> out via the iommu_priv field in the fwspec.

Thanks Will for going through this.

Yes, from the logs I have, it looks like _resv callback is always called af=
ter
 ->add_device. I will double check this with vfio bind case as well.

And I guess, this is what you are proposing to retrieve the smmu,

master =3D dev->iommu_fwspec->iommu_priv;
smmu =3D master->smmu;

> > +	if (WARN_ON(!smmu))
>
> Again, how does this trigger?
> >  		return;
> >
> > -	list_add_tail(&region->list, head);
> > +	if ((smmu->options & ARM_SMMU_OPT_RESV_HW_MSI)) {
> > +
> > +		if (!is_of_node(smmu->dev->fwnode))
> > +			resv =3D iort_iommu_its_get_resv_regions(dev, head);
> =

> How does this work when we're not using ACPI? Shouldn't of vs ACPI be
> abstracted from the driver?

At present ARM_SMMU_OPT_RESV_HW_MSI is only set for ACPI and  DT support for
this is a low priority for us at the moment. Is the suggestion is to have a=
 common function
outside the smmu driver for _iommu_its_get_resv_regions() ? I am not sure w=
hat
is the best way here. =


Thanks,
Shameer




--===============5581664795223630584==--

