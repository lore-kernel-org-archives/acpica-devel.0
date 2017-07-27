Content-Type: multipart/mixed; boundary="===============7895329020345597862=="
MIME-Version: 1.0
From: Lorenzo Pieralisi <lorenzo.pieralisi at arm.com>
Subject: Re: [Devel] [PATCH v4 1/2] acpi:iort: Add an IORT helper function to
 reserve HW ITS address regions for IOMMU drivers
Date: Thu, 27 Jul 2017 11:12:55 +0100
Message-ID: <20170727101255.GA15067@red-moon>
In-Reply-To: 5FC3163CFD30C246ABAA99954A238FA8383C0268@FRAEML521-MBX.china.huawei.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============7895329020345597862==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 27, 2017 at 09:13:42AM +0000, Shameerali Kolothum Thodi wrote:

[...]

> > > >> +int iort_iommu_its_get_resv_regions(struct device *dev, struct
> > list_head *head)
> > > >> +{
> > > >> +	int i;
> > > >> +	struct acpi_iort_its_group *its;
> > > >> +	struct acpi_iort_node *node, *its_node =3D NULL;
> > > >> +	int resv =3D 0;
> > > >
> > > > Nit: int i, resv =3D 0;
> > > >
> > > > I can make these changes but I suspect this series will go via IOMMU
> > > > tree, let me know how you want to handle it.
> > > >
> > > > Lorenzo
> > > >
> > > >> +	node =3D iort_find_dev_node(dev);
> > > >> +	if (!node)
> > > >> +		return -ENODEV;
> > > >> +
> > >
> > > I'd suggest we also want a comment here to clarify that we're current=
ly
> > > assuming straightforward topologies where all mappings for a given ro=
ot
> > > complex/named component target the same ITS group. Otherwise we're
> > going
> > > to need somewhat more logic to iterate the its_node processing over
> > > every mapping (or every alias in the PCI case), but avoid creating
> > > duplicate entries.
> > =

> > You have a point and we have time to update the code. Short of reserving
> > all ITS regions for every device that maps to one at least, we could (e=
ven
> > pre-compute instead of looking it up on the fly) create a list of ITS
> > identifiers a given IORT node may map to and use that to reserve the
> > regions.
> =

> I am trying to understand the use case scenario discussed here.
> Apologies if it is a dumb query. =

> =

> My understanding is that, it is possible to have a PCI  RC iort node
> mapped to multiple ITS group nodes.  That is perfectly fine and given
> a dev input RID we can identify the ITS group the device points to
> using - iort_node_map_id().
> =

> But the above discussion seems to suggest that there might be
> situations where we have to go through all the mapped ITS groups and
> identify all the ITSs associated with the RC.  Clearly I am missing
> something.

I reckon Robin was referring to this:

https://patchwork.kernel.org/patch/9757911/

Does this help ?

Thanks,
Lorenzo

--===============7895329020345597862==--

