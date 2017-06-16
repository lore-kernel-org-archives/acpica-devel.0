Content-Type: multipart/mixed; boundary="===============3448695910602774403=="
MIME-Version: 1.0
From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi at huawei.com>
Subject: Re: [Devel] [PATCH 2/2] iommu/arm-smmu-v3:Enable ACPI based HiSilicon
 erratum 161010801
Date: Fri, 16 Jun 2017 11:31:06 +0000
Message-ID: <5FC3163CFD30C246ABAA99954A238FA83836B2DC@FRAEML521-MBX.china.huawei.com>
In-Reply-To: 20170616111729.GB22323@red-moon
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============3448695910602774403==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



> -----Original Message-----
> From: Lorenzo Pieralisi [mailto:lorenzo.pieralisi(a)arm.com]
> Sent: Friday, June 16, 2017 12:17 PM
> To: Shameerali Kolothum Thodi
> Cc: marc.zyngier(a)arm.com; will.deacon(a)arm.com; Linuxarm; linux-
> acpi(a)vger.kernel.org; iommu(a)lists.linux-foundation.org;
> hanjun.guo(a)linaro.org; sudeep.holla(a)arm.com; robin.murphy(a)arm.com;
> linux-arm-kernel(a)lists.infradead.org; devel(a)acpica.org
> Subject: Re: [PATCH 2/2] iommu/arm-smmu-v3:Enable ACPI based HiSilicon
> erratum 161010801
> =

> On Fri, Jun 16, 2017 at 09:43:52AM +0000, Shameerali Kolothum Thodi wrote:
> > Hi Lorenzo,
> >
> > > -----Original Message-----
> > > From: linuxarm-bounces(a)huawei.com [mailto:linuxarm-
> > > bounces(a)huawei.com] On Behalf Of Shameerali Kolothum Thodi
> > > Sent: Tuesday, June 13, 2017 3:53 PM
> > > To: Lorenzo Pieralisi
> > > Cc: marc.zyngier(a)arm.com; will.deacon(a)arm.com; Linuxarm; linux-
> > > acpi(a)vger.kernel.org; iommu(a)lists.linux-foundation.org;
> > > hanjun.guo(a)linaro.org; sudeep.holla(a)arm.com;
> robin.murphy(a)arm.com;
> > > linux-arm-kernel(a)lists.infradead.org; devel(a)acpica.org
> > > Subject: RE: [PATCH 2/2] iommu/arm-smmu-v3:Enable ACPI based
> HiSilicon
> > > erratum 161010801
> >
> > [...]
> >  > > > ---
> > > > >  drivers/iommu/arm-smmu-v3.c | 27 ++++++++++++++++++++++----
> -
> > > > >  1 file changed, 22 insertions(+), 5 deletions(-)
> > > > >
> > > > > diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-
> smmu-
> > > > v3.c
> > > > > index abe4b88..2636c85 100644
> > > > > --- a/drivers/iommu/arm-smmu-v3.c
> > > > > +++ b/drivers/iommu/arm-smmu-v3.c
> > > > > @@ -597,6 +597,7 @@ struct arm_smmu_device {
> > > > >  	u32				features;
> > > > >
> > > > >  #define ARM_SMMU_OPT_SKIP_PREFETCH	(1 << 0)
> > > > > +#define ARM_SMMU_OPT_RESV_HW_MSI	(1 << 1)
> > > > >  	u32				options;
> > > > >
> > > > >  	struct arm_smmu_cmdq		cmdq;
> > > > > @@ -1904,14 +1905,29 @@ static void
> > > arm_smmu_get_resv_regions(struct
> > > > device *dev,
> > > > >  				      struct list_head *head)
> > > > >  {
> > > > >  	struct iommu_resv_region *region;
> > > > > +	struct arm_smmu_device *smmu;
> > > > > +	struct iommu_fwspec *fwspec =3D dev->iommu_fwspec;
> > > > >  	int prot =3D IOMMU_WRITE | IOMMU_NOEXEC |
> IOMMU_MMIO;
> > > > >
> > > > > -	region =3D iommu_alloc_resv_region(MSI_IOVA_BASE,
> > > > MSI_IOVA_LENGTH,
> > > > > -					 prot,
> IOMMU_RESV_SW_MSI);
> > > > > -	if (!region)
> > > > > -		return;
> > > > > +	smmu =3D arm_smmu_get_by_fwnode(fwspec-
> >iommu_fwnode);
> > > > >
> > > > > -	list_add_tail(&region->list, head);
> > > > > +	if (smmu && (smmu->options &
> ARM_SMMU_OPT_RESV_HW_MSI)
> > > > &&
> > > > > +		      dev_is_pci(dev)) {
> > > > > +		int ret;
> > > > > +
> > > > > +		ret =3D iort_iommu_its_get_resv_regions(dev, head);
> > > >
> > > > This should be made fwnode dependent, it makes precious little sense
> to
> > > call
> > > > IORT to reserve regions on a DT based platforms (I know the
> > > > ARM_SMMU_OPT_RESV_HW_MSI option is only selected in ACPI (?)
> but
> > > > comment applies regardless - have you prototyped a DT version too ?=
).
> > >
> > > Ok. I will add a check here.
> >
> > This is what I have in mind. Please take a look and let me know. I will=
 send
> out
> > a v2 of this series soon.
> > ....
> > if (smmu && (smmu->options & ARM_SMMU_OPT_RESV_HW_MSI) &&
> > 			dev_is_pci(dev)) {
> > 	int ret =3D -EINVAL;
> >
> > 	if (!is_of_node(smmu->dev->fwnode))
> > 		ret =3D iort_iommu_its_get_resv_regions(dev, head);
> >
> > 	if (ret) {
> > 		dev_warn(dev, "HW MSI region resv failed: %d\n", ret);
> > 		return;
> > 	}
> > } else {
> =

> The fwnode handling is fine, I do not like much the:
> =

> dev_is_pci()
> =

> check because it relies on implicit knowledge of the platform and
> the quirks you need (ie you know that it is _just_ a PCI RC quirk
> implicitly), the logic behind reserving the regions is a bit
> convoluted and not easy to understand at all.
> =

> Let me try to rephrase it: you know, through an SMMU model number,
> that your PCI RC handles MSI in a specific way, but by reading the
> code above this is not clear at all, at least to me. This is a PCI
> RC quirk but it does not depend on any PCI RC specific firmware binding
> whatsoever, that's what is a bit hard to understand.

Right.  I had a thought of limiting the iort_iommu_its_get_resv_regions
to pci devices only. Just like the way iommu_dma_get_resv_regions()
does now. But not sure there will ever be a platform which requires this
for non-pci devices as well.

Thanks,
Shameer

--===============3448695910602774403==--

