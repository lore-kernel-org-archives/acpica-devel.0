Content-Type: multipart/mixed; boundary="===============2426308239295348301=="
MIME-Version: 1.0
From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi at huawei.com>
Subject: [Devel] Re: [RFC PATCH v2 2/8] ACPI/IORT: Add support for RMR node
 parsing
Date: Thu, 15 Apr 2021 10:30:03 +0000
Message-ID: <0c5ef81c82984f6eaabdc9b27ee79070@huawei.com>
In-Reply-To: a64025cd-3312-9621-1771-8e0430220ed8@redhat.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============2426308239295348301==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Eric,

> -----Original Message-----
> From: Auger Eric [mailto:eric.auger(a)redhat.com]
> Sent: 15 April 2021 10:39
> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi(a)huawei.com>;
> linux-arm-kernel(a)lists.infradead.org; linux-acpi(a)vger.kernel.org;
> iommu(a)lists.linux-foundation.org; devel(a)acpica.org
> Cc: Linuxarm <linuxarm(a)huawei.com>; steven.price(a)arm.com; Guohanjun
> (Hanjun Guo) <guohanjun(a)huawei.com>; Sami.Mujawar(a)arm.com;
> robin.murphy(a)arm.com; wanghuiqiang <wanghuiqiang(a)huawei.com>
> Subject: Re: [RFC PATCH v2 2/8] ACPI/IORT: Add support for RMR node parsi=
ng
> =

> Hi Shameer,
> On 11/19/20 1:11 PM, Shameer Kolothum wrote:
> > Add support for parsing RMR node information from ACPI.
> > Find associated stream ids and smmu node=C2=A0info from the
> > RMR node and populate a linked list with RMR memory
> > descriptors.
> >
> > Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi(a)huawei.com>
> > ---
> >  drivers/acpi/arm64/iort.c | 122
> +++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 121 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> > index 9929ff50c0c0..a9705aa35028 100644
> > --- a/drivers/acpi/arm64/iort.c
> > +++ b/drivers/acpi/arm64/iort.c
> > @@ -40,6 +40,25 @@ struct iort_fwnode {
> >  static LIST_HEAD(iort_fwnode_list);
> >  static DEFINE_SPINLOCK(iort_fwnode_lock);
> >
> > +struct iort_rmr_id {
> > +	u32  sid;
> > +	struct acpi_iort_node *smmu;
> > +};
> > +
> > +/*
> > + * One entry for IORT RMR.
> > + */
> > +struct iort_rmr_entry {
> > +	struct list_head list;
> > +
> > +	unsigned int rmr_ids_num;
> > +	struct iort_rmr_id *rmr_ids;
> > +
> > +	struct acpi_iort_rmr_desc *rmr_desc;
> > +};
> > +
> > +static LIST_HEAD(iort_rmr_list);         /* list of RMR regions from A=
CPI
> */
> > +
> >  /**
> >   * iort_set_fwnode() - Create iort_fwnode and use it to register
> >   *		       iommu data in the iort_fwnode_list
> > @@ -393,7 +412,8 @@ static struct acpi_iort_node
> *iort_node_get_id(struct acpi_iort_node *node,
> >  		if (node->type =3D=3D ACPI_IORT_NODE_NAMED_COMPONENT ||
> >  		    node->type =3D=3D ACPI_IORT_NODE_PCI_ROOT_COMPLEX ||
> >  		    node->type =3D=3D ACPI_IORT_NODE_SMMU_V3 ||
> > -		    node->type =3D=3D ACPI_IORT_NODE_PMCG) {
> > +		    node->type =3D=3D ACPI_IORT_NODE_PMCG ||
> > +		    node->type =3D=3D ACPI_IORT_NODE_RMR) {
> >  			*id_out =3D map->output_base;
> >  			return parent;
> >  		}
> > @@ -1647,6 +1667,103 @@ static void __init iort_enable_acs(struct
> acpi_iort_node *iort_node)
> >  #else
> >  static inline void iort_enable_acs(struct acpi_iort_node *iort_node) {=
 }
> >  #endif
> > +static int iort_rmr_desc_valid(struct acpi_iort_rmr_desc *desc)
> > +{
> > +	struct iort_rmr_entry *e;
> > +	u64 end, start =3D desc->base_address, length =3D desc->length;
> > +
> > +	if (!IS_ALIGNED(start, SZ_64K) || !IS_ALIGNED(length, SZ_64K))
> > +		return -EINVAL;
> > +
> > +	end =3D start + length - 1;
> > +
> > +	/* Check for address overlap */
> I don't get this check. What is the problem if you attach the same range
> to different stream ids. Shouldn't you check there is no overlap for the
> same sid?

That=E2=80=99s right. The check should be for memory descriptors within an =
RMR.
I got confused by the wordings in the IORT spec and that is now clarified
with Lorenzo here,

https://op-lists.linaro.org/pipermail/linaro-open-discussions/2021-April/00=
0150.html

I will change this.
> =

> =

> > +	list_for_each_entry(e, &iort_rmr_list, list) {
> > +		u64 e_start =3D e->rmr_desc->base_address;
> > +		u64 e_end =3D e_start + e->rmr_desc->length - 1;
> > +
> > +		if (start <=3D e_end && end >=3D e_start)
> > +			return -EINVAL;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int __init iort_parse_rmr(struct acpi_iort_node *iort_node)
> > +{
> > +	struct iort_rmr_id *rmr_ids, *ids;
> > +	struct iort_rmr_entry *e;
> > +	struct acpi_iort_rmr *rmr;
> > +	struct acpi_iort_rmr_desc *rmr_desc;
> > +	u32 map_count =3D iort_node->mapping_count;
> > +	int i, ret =3D 0, desc_count =3D 0;
> > +
> > +	if (iort_node->type !=3D ACPI_IORT_NODE_RMR)
> > +		return 0;
> > +
> > +	if (!iort_node->mapping_offset || !map_count) {
> > +		pr_err(FW_BUG "Invalid ID mapping, skipping RMR node %p\n",
> > +		       iort_node);
> > +		return -EINVAL;
> > +	}
> > +
> > +	rmr_ids =3D kmalloc(sizeof(*rmr_ids) * map_count, GFP_KERNEL);
> > +	if (!rmr_ids)
> > +		return -ENOMEM;
> > +
> > +	/* Retrieve associated smmu and stream id */
> > +	ids =3D rmr_ids;
> nit: do you need both rmr_ids and ids?

Not really as the spec says it is M:1 mapping. So we only will have one =

single id here(also map_count for the node must be set to 1 as well).

> > +	for (i =3D 0; i < map_count; i++, ids++) {
> > +		ids->smmu =3D iort_node_get_id(iort_node, &ids->sid, i);
> > +		if (!ids->smmu) {
> > +			pr_err(FW_BUG "Invalid SMMU reference, skipping RMR
> node %p\n",
> > +			       iort_node);
> > +			ret =3D -EINVAL;
> > +			goto out;
> > +		}
> > +	}
> > +
> > +	/* Retrieve RMR data */
> > +	rmr =3D (struct acpi_iort_rmr *)iort_node->node_data;
> > +	if (!rmr->rmr_offset || !rmr->rmr_count) {
> > +		pr_err(FW_BUG "Invalid RMR descriptor array, skipping RMR
> node %p\n",
> > +		       iort_node);
> > +		ret =3D -EINVAL;
> > +		goto out;
> > +	}
> > +
> > +	rmr_desc =3D ACPI_ADD_PTR(struct acpi_iort_rmr_desc, iort_node,
> > +				rmr->rmr_offset);
> > +
> > +	for (i =3D 0; i < rmr->rmr_count; i++, rmr_desc++) {
> > +		ret =3D iort_rmr_desc_valid(rmr_desc);
> > +		if (ret) {
> > +			pr_err(FW_BUG "Invalid RMR descriptor[%d] for node %p,
> skipping...\n",
> > +			       i, iort_node);
> > +			goto out;
> so I understand you skip the whole node and not just that rmr desc,
> otherwise you would continue. so in that case don't you need to free
> both rmr_ids and already allocated 'e'?

Agree. This needs to be changed.

> > +		}
> > +
> > +		e =3D kmalloc(sizeof(*e), GFP_KERNEL);
> > +		if (!e) {
> > +			ret =3D -ENOMEM;
> > +			goto out;
> > +		}
> > +
> > +		e->rmr_ids_num =3D map_count;
> > +		e->rmr_ids =3D rmr_ids;
> > +		e->rmr_desc =3D rmr_desc;
> > +
> > +		list_add_tail(&e->list, &iort_rmr_list);
> > +		desc_count++;
> > +	}
> > +
> > +	return 0;
> > +
> > +out:
> > +	if (!desc_count)
> don't you want to test ret instead? see comment above. + free allocated '=
'e'

Right. I will change it next revision.

Thanks for taking a look.

Regards,
Shameer

> > +		kfree(rmr_ids);
> > +	return ret;
> > +}
> >
> >  static void __init iort_init_platform_devices(void)
> >  {
> > @@ -1676,6 +1793,9 @@ static void __init iort_init_platform_devices(voi=
d)
> >
> >  		iort_enable_acs(iort_node);
> >
> > +		if (iort_table->revision =3D=3D 1)
> > +			iort_parse_rmr(iort_node);
> > +
> >  		ops =3D iort_get_dev_cfg(iort_node);
> >  		if (ops) {
> >  			fwnode =3D acpi_alloc_fwnode_static();
> >
> Thanks
> =

> Eric


--===============2426308239295348301==--

