Content-Type: multipart/mixed; boundary="===============8333339384029663384=="
MIME-Version: 1.0
From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi at huawei.com>
Subject: Re: [Devel] [PATCH v4 1/2] acpi:iort: Add an IORT helper function to
 reserve HW ITS address regions for IOMMU drivers
Date: Fri, 28 Jul 2017 15:48:48 +0000
Message-ID: <5FC3163CFD30C246ABAA99954A238FA8383C0FA5@FRAEML521-MBX.china.huawei.com>
In-Reply-To: 20170728095755.GA10987@red-moon
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============8333339384029663384==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



> -----Original Message-----
> From: Lorenzo Pieralisi [mailto:lorenzo.pieralisi(a)arm.com]
> Sent: Friday, July 28, 2017 10:58 AM
> To: Shameerali Kolothum Thodi
> Cc: Robin Murphy; Guohanjun (Hanjun Guo); Gabriele Paoloni;
> marc.zyngier(a)arm.com; John Garry; will.deacon(a)arm.com; Linuxarm; linu=
x-
> acpi(a)vger.kernel.org; iommu(a)lists.linux-foundation.org;
> hanjun.guo(a)linaro.org; Wangzhou (B); sudeep.holla(a)arm.com; linux-arm-
> kernel(a)lists.infradead.org; devel(a)acpica.org
> Subject: Re: [PATCH v4 1/2] acpi:iort: Add an IORT helper function to res=
erve
> HW ITS address regions for IOMMU drivers
> =

> On Thu, Jul 27, 2017 at 01:26:14PM +0000, Shameerali Kolothum Thodi wrote:
> >
> >
> > > -----Original Message-----
> > > From: Robin Murphy [mailto:robin.murphy(a)arm.com]
> > > Sent: Thursday, July 27, 2017 12:13 PM
> > > To: Shameerali Kolothum Thodi; Lorenzo Pieralisi
> > > Cc: Guohanjun (Hanjun Guo); Gabriele Paoloni; marc.zyngier(a)arm.com;
> > > John Garry; will.deacon(a)arm.com; Linuxarm;
> > > linux-acpi(a)vger.kernel.org; iommu(a)lists.linux-foundation.org;
> > > hanjun.guo(a)linaro.org; Wangzhou (B); sudeep.holla(a)arm.com;
> > > linux-arm-kernel(a)lists.infradead.org;
> > > devel(a)acpica.org
> > > Subject: Re: [PATCH v4 1/2] acpi:iort: Add an IORT helper function
> > > to reserve HW ITS address regions for IOMMU drivers
> > >
> > [...]
> >
> > > >>>> I can make these changes but I suspect this series will go via
> > > >>>> IOMMU tree, let me know how you want to handle it.
> > > >>>>
> > > >>>> Lorenzo
> > > >>>>
> > > >>>>> +	node =3D iort_find_dev_node(dev);
> > > >>>>> +	if (!node)
> > > >>>>> +		return -ENODEV;
> > > >>>>> +
> > > >>>
> > > >>> I'd suggest we also want a comment here to clarify that we're
> > > >>> currently assuming straightforward topologies where all mappings
> > > >>> for a given root complex/named component target the same ITS
> > > >>> group. Otherwise
> > > we're
> > > >> going
> > > >>> to need somewhat more logic to iterate the its_node processing
> > > >>> over every mapping (or every alias in the PCI case), but avoid
> > > >>> creating duplicate entries.
> > > >>
> > > >> You have a point and we have time to update the code. Short of
> > > >> reserving all ITS regions for every device that maps to one at
> > > >> least, we could (even pre-compute instead of looking it up on the
> > > >> fly) create a list of ITS identifiers a given IORT node may map
> > > >> to and use that to reserve the regions.
> > > >
> > > > I am trying to understand the use case scenario discussed here.
> > > > Apologies if it is a dumb query.
> > > >
> > > > My understanding is that, it is possible to have a PCI  RC iort
> > > > node mapped
> > > to
> > > > multiple ITS group nodes.  That is perfectly fine and given a dev
> > > > input RID
> > > we
> > > > can identify the ITS group the device points to using -
> iort_node_map_id().
> > > >
> > > > But the above discussion seems to suggest that there might be
> > > > situations
> > > where
> > > > we have to go through all the mapped ITS groups and identify all
> > > > the ITSs
> > > associated
> > > > with the RC.  Clearly I am missing something.
> > >
> > > I was mostly thinking of a situation like this:
> > >
> > > +----Node 0-----+  +----Node 1-----+
> > > |  [CPU 0..n]   |  |  [CPU n+1..]  |
> > > | [ITS group 0] |  | [ITS group 1] |
> > > +---------------+  +---------------+
> > >         ^                  ^
> > >          \_______  _______/
> > >                  \/
> > >             +--Node 2--+
> > >             |  [SMMU]  |
> > >             |     ^    |
> > >             |     |    |
> > >             | [Device] |
> > >             +----------+
> > >
> > > where the (named component) device has IDs for both ITS groups (to
> > > help optimise affining, or allow physically hotplugging CPU nodes,
> > > or whatever - I'm hypothesising here ;)).  A generic IORT function
> > > isn't in a position to decide *which* ITS region the device may be
> > > targeting at any given time, so can only correctly describe both.
> >
> > Thanks Robin. That makes it clear.
> >
> > > I'm perfectly happy not to even try to support such crazy
> > > configurations until they actually exist, if ever; I'd just prefer
> > > to document whatever assumptions we do make, so that we don't have
> > > to remember or re-derive them when looking at the code in future.
> >
> > So I think the conclusion here is we will document the assumption that
> > we are only taking care of the straightforward topologies for now.
> >
> > Hi Lorenzo,
> > If you are ok with the above, please let me know if it make sense to
> > send out a v5 with this and your other comments or you can take care
> > of them. I am fine either way.
> =

> I added below what should be the final patch - please have a look test and
> post it as part of v5 that should hopefully be final.

Thanks Lorenzo. Will do that.
Shameer

--===============8333339384029663384==--

