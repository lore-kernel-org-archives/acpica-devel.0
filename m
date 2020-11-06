Content-Type: multipart/mixed; boundary="===============0458043096169020431=="
MIME-Version: 1.0
From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi at huawei.com>
Subject: [Devel] Re: [RFC PATCH 3/4] ACPI/IORT: Add RMR memory regions
 reservation helper
Date: Fri, 06 Nov 2020 16:00:23 +0000
Message-ID: <4e1e1d3d873049cfaedda14a1187e1cd@huawei.com>
In-Reply-To: b0123797-4b49-8256-1080-36b9a6f7eee6@arm.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============0458043096169020431==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



> -----Original Message-----
> From: Robin Murphy [mailto:robin.murphy(a)arm.com]
> Sent: 06 November 2020 13:06
> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi(a)huawei.com>;
> linux-arm-kernel(a)lists.infradead.org; linux-acpi(a)vger.kernel.org;
> iommu(a)lists.linux-foundation.org; devel(a)acpica.org
> Cc: Linuxarm <linuxarm(a)huawei.com>; lorenzo.pieralisi(a)arm.com;
> joro(a)8bytes.org; wanghuiqiang <wanghuiqiang(a)huawei.com>; Guohanjun
> (Hanjun Guo) <guohanjun(a)huawei.com>; Jonathan Cameron
> <jonathan.cameron(a)huawei.com>
> Subject: Re: [RFC PATCH 3/4] ACPI/IORT: Add RMR memory regions reservation
> helper
> =

> On 2020-11-06 08:30, Shameerali Kolothum Thodi wrote:
> >
> >
> >> -----Original Message-----
> >> From: Robin Murphy [mailto:robin.murphy(a)arm.com]
> >> Sent: 05 November 2020 18:04
> >> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi(a)huawei.com>;
> >> linux-arm-kernel(a)lists.infradead.org; linux-acpi(a)vger.kernel.org;
> >> iommu(a)lists.linux-foundation.org; devel(a)acpica.org
> >> Cc: Linuxarm <linuxarm(a)huawei.com>; lorenzo.pieralisi(a)arm.com;
> >> joro(a)8bytes.org; wanghuiqiang <wanghuiqiang(a)huawei.com>; Guohanjun
> >> (Hanjun Guo) <guohanjun(a)huawei.com>; Jonathan Cameron
> >> <jonathan.cameron(a)huawei.com>
> >> Subject: Re: [RFC PATCH 3/4] ACPI/IORT: Add RMR memory regions
> reservation
> >> helper
> >>
> >> On 2020-10-27 11:26, Shameer Kolothum wrote:
> >>> Add a helper function that retrieves RMR memory descriptors
> >>> associated with a given endpoint dev. These memory regions
> >>> should have a unity=C2=A0mapping in the SMMU. So reserve them as
> >>> IOMMU_RESV_DIRECT.
> >>
> >> As a general observation, we also need a way into this that isn't from
> >> the perspective of endpoint devices. With SMMUv3 we need to know all t=
he
> >> active stream IDs relevant to a given SMMU instance at probe time, so
> >> that we can set up some kind of valid stream table entries *before*
> >> enabling the SMMU in the reset routine.
> >
> > So I guess, the idea is to provide an interface here to retrieve those =
active
> > stream Ids? The problem is, at present(AFAICS), RMR doesn=E2=80=99t hav=
e any
> > means to specify such devices.
> =

> I'm thinking we need to check if any RMRs exist in the IORT, if so find
> the devices that map to them, then resolve those devices' ID mappings.
> In terms of the interface, maybe the better option is to do something
> closer to what intel-iommu does and handle *all* the processing up-front
> - let the IOMMU driver just call into the firmware code once to retrieve
> a complete list of all the relevant abstracted RMR (or DT equivalent)
> information, so it can then resolve both its own early initialisation
> and the later per-device setup without calling back into firmware code
> again.

Ok. I will try to change the interface then.

> >   Otherwise we're just going to
> >> kill ongoing traffic (e.g. EFI GOP) with C_BAD_STE long before we ever
> >> start adding devices and worrying about reserved regions for them.
> >> Similarly for the initial SMR/S2CR state on SMMUv2 with disable_bypass.
> >
> > Ok. I see the discussion here,
> >
> https://lore.kernel.org/linux-iommu/484b9e90-7395-6161-577c-4d3f3716997e
> @arm.com/
> >
> >  From what I gather, the plan is to setup a default IDENTITY_DOMAIN for
> > devices that have live stream going on during boot/SMMU probe time.
> =

> Well, whether we use bypass or a temporary translation context for the
> period before we even get to default domains... that's a discussion that
> can wait until we have the ability to set up the STEs at all ;)

Sure.

Thanks,
Shameer
 =

> Robin.
> =

> >>> Signed-off-by: Shameer Kolothum
> <shameerali.kolothum.thodi(a)huawei.com>
> >>> ---
> >>>    drivers/acpi/arm64/iort.c | 56
> >> +++++++++++++++++++++++++++++++++++++++
> >>>    include/linux/acpi_iort.h |  4 +++
> >>>    2 files changed, 60 insertions(+)
> >>>
> >>> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> >>> index b32cd53cca08..c0700149e60b 100644
> >>> --- a/drivers/acpi/arm64/iort.c
> >>> +++ b/drivers/acpi/arm64/iort.c
> >>> @@ -842,6 +842,60 @@ static inline int iort_add_device_replay(struct
> >> device *dev)
> >>>    	return err;
> >>>    }
> >>>
> >>> +static bool iort_dev_has_rmr(struct device *dev, struct iort_rmr_ent=
ry
> *e)
> >>> +{
> >>> +	struct iommu_fwspec *fwspec =3D dev_iommu_fwspec_get(dev);
> >>> +	struct acpi_iort_node *iommu;
> >>> +	struct iort_rmr_id *rmr_ids =3D e->rmr_ids;
> >>> +	int i, j;
> >>> +
> >>> +	iommu =3D iort_get_iort_node(fwspec->iommu_fwnode);
> >>> +
> >>> +	for (i =3D 0; i < e->rmr_ids_num; i++, rmr_ids++) {
> >>> +		for (j =3D 0; j < fwspec->num_ids; j++) {
> >>> +			if (rmr_ids->sid =3D=3D fwspec->ids[j] &&
> >>> +			    rmr_ids->smmu =3D=3D iommu)
> >>> +				return true;
> >>> +		}
> >>> +	}
> >>> +
> >>> +	return false;
> >>> +}
> >>> +
> >>> +/**
> >>> + * iort_dev_rmr_get_resv_regions - RMR Reserved region driver helper
> >>> + * @dev: Device from iommu_get_resv_regions()
> >>> + * @head: Reserved region list from iommu_get_resv_regions()
> >>> + *
> >>> + * Returns: 0 on success, <0 failure
> >>> + */
> >>> +int iort_dev_rmr_get_resv_regions(struct device *dev, struct list_he=
ad
> >> *head)
> >>> +{
> >>> +	struct iort_rmr_entry *e;
> >>> +
> >>> +	list_for_each_entry(e, &iort_rmr_list, list) {
> >>> +		struct iommu_resv_region *region;
> >>> +		struct acpi_iort_rmr_desc *rmr;
> >>> +		int prot =3D IOMMU_READ | IOMMU_WRITE |
> >>> +			   IOMMU_NOEXEC | IOMMU_MMIO;
> >>> +
> >>> +		if (!iort_dev_has_rmr(dev, e))
> >>> +			continue;
> >>> +
> >>> +		rmr =3D e->rmr_desc;
> >>> +		region =3D iommu_alloc_resv_region(rmr->base_address,
> >>> +						 rmr->length, prot,
> >>> +						 IOMMU_RESV_DIRECT);
> >>> +		if (!region) {
> >>> +			dev_err(dev, "Out of memory allocating RMR regions\n");
> >>> +			return -ENOMEM;
> >>> +		}
> >>> +		list_add_tail(&region->list, head);
> >>> +	}
> >>> +
> >>> +	return 0;
> >>> +}
> >>> +
> >>>    /**
> >>>     * iort_iommu_msi_get_resv_regions - Reserved region driver helper
> >>>     * @dev: Device from iommu_get_resv_regions()
> >>> @@ -1112,6 +1166,8 @@ int iort_iommu_msi_get_resv_regions(struct
> >> device *dev, struct list_head *head)
> >>>    const struct iommu_ops *iort_iommu_configure_id(struct device *dev,
> >>>    						const u32 *input_id)
> >>>    { return NULL; }
> >>> +int iort_dev_rmr_get_resv_regions(struct device *dev, struct list_he=
ad
> >> *head)
> >>> +{ return 0; }
> >>>    #endif
> >>>
> >>>    static int nc_dma_get_range(struct device *dev, u64 *size)
> >>> diff --git a/include/linux/acpi_iort.h b/include/linux/acpi_iort.h
> >>> index 20a32120bb88..6dd89faf340c 100644
> >>> --- a/include/linux/acpi_iort.h
> >>> +++ b/include/linux/acpi_iort.h
> >>> @@ -38,6 +38,7 @@ void iort_dma_setup(struct device *dev, u64
> >> *dma_addr, u64 *size);
> >>>    const struct iommu_ops *iort_iommu_configure_id(struct device *dev,
> >>>    						const u32 *id_in);
> >>>    int iort_iommu_msi_get_resv_regions(struct device *dev, struct
> list_head
> >> *head);
> >>> +int iort_dev_rmr_get_resv_regions(struct device *dev, struct list_he=
ad
> >> *head);
> >>>    #else
> >>>    static inline void acpi_iort_init(void) { }
> >>>    static inline u32 iort_msi_map_id(struct device *dev, u32 id)
> >>> @@ -55,6 +56,9 @@ static inline const struct iommu_ops
> >> *iort_iommu_configure_id(
> >>>    static inline
> >>>    int iort_iommu_msi_get_resv_regions(struct device *dev, struct
> list_head
> >> *head)
> >>>    { return 0; }
> >>> +static inline
> >>> +int iort_dev_rmr_get_resv_regions(struct device *dev, struct list_he=
ad
> >> *head)
> >>> +{ return 0; }
> >>>    #endif
> >>>
> >>>    #endif /* __ACPI_IORT_H__ */
> >>>

--===============0458043096169020431==--

