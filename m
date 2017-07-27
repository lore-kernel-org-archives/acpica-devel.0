Content-Type: multipart/mixed; boundary="===============3027439967978096159=="
MIME-Version: 1.0
From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi at huawei.com>
Subject: Re: [Devel] [PATCH v4 1/2] acpi:iort: Add an IORT helper function to
 reserve HW ITS address regions for IOMMU drivers
Date: Thu, 27 Jul 2017 13:26:14 +0000
Message-ID: <5FC3163CFD30C246ABAA99954A238FA8383C04A2@FRAEML521-MBX.china.huawei.com>
In-Reply-To: 989fec76-45e7-d744-3411-78ec2764cb7d@arm.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============3027439967978096159==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



> -----Original Message-----
> From: Robin Murphy [mailto:robin.murphy(a)arm.com]
> Sent: Thursday, July 27, 2017 12:13 PM
> To: Shameerali Kolothum Thodi; Lorenzo Pieralisi
> Cc: Guohanjun (Hanjun Guo); Gabriele Paoloni; marc.zyngier(a)arm.com;
> John Garry; will.deacon(a)arm.com; Linuxarm; linux-acpi(a)vger.kernel.org;
> iommu(a)lists.linux-foundation.org; hanjun.guo(a)linaro.org; Wangzhou (B);
> sudeep.holla(a)arm.com; linux-arm-kernel(a)lists.infradead.org;
> devel(a)acpica.org
> Subject: Re: [PATCH v4 1/2] acpi:iort: Add an IORT helper function to res=
erve
> HW ITS address regions for IOMMU drivers
> =

[...]

> >>>> I can make these changes but I suspect this series will go via IOMMU
> >>>> tree, let me know how you want to handle it.
> >>>>
> >>>> Lorenzo
> >>>>
> >>>>> +	node =3D iort_find_dev_node(dev);
> >>>>> +	if (!node)
> >>>>> +		return -ENODEV;
> >>>>> +
> >>>
> >>> I'd suggest we also want a comment here to clarify that we're current=
ly
> >>> assuming straightforward topologies where all mappings for a given ro=
ot
> >>> complex/named component target the same ITS group. Otherwise
> we're
> >> going
> >>> to need somewhat more logic to iterate the its_node processing over
> >>> every mapping (or every alias in the PCI case), but avoid creating
> >>> duplicate entries.
> >>
> >> You have a point and we have time to update the code. Short of reservi=
ng
> >> all ITS regions for every device that maps to one at least, we could (=
even
> >> pre-compute instead of looking it up on the fly) create a list of ITS
> >> identifiers a given IORT node may map to and use that to reserve the
> >> regions.
> >
> > I am trying to understand the use case scenario discussed here. Apologi=
es
> > if it is a dumb query.
> >
> > My understanding is that, it is possible to have a PCI  RC iort node ma=
pped
> to
> > multiple ITS group nodes.  That is perfectly fine and given a dev input=
 RID
> we
> > can identify the ITS group the device points to using - iort_node_map_i=
d().
> >
> > But the above discussion seems to suggest that there might be situations
> where
> > we have to go through all the mapped ITS groups and identify all the IT=
Ss
> associated
> > with the RC.  Clearly I am missing something.
> =

> I was mostly thinking of a situation like this:
> =

> +----Node 0-----+  +----Node 1-----+
> |  [CPU 0..n]   |  |  [CPU n+1..]  |
> | [ITS group 0] |  | [ITS group 1] |
> +---------------+  +---------------+
>         ^                  ^
>          \_______  _______/
>                  \/
>             +--Node 2--+
>             |  [SMMU]  |
>             |     ^    |
>             |     |    |
>             | [Device] |
>             +----------+
> =

> where the (named component) device has IDs for both ITS groups (to help
> optimise affining, or allow physically hotplugging CPU nodes, or
> whatever - I'm hypothesising here ;)).  A generic IORT function isn't in
> a position to decide *which* ITS region the device may be targeting at
> any given time, so can only correctly describe both.

Thanks Robin. That makes it clear.
 =

> I'm perfectly happy not to even try to support such crazy configurations
> until they actually exist, if ever; I'd just prefer to document whatever
> assumptions we do make, so that we don't have to remember or re-derive
> them when looking at the code in future.

So I think the conclusion here is we will document the assumption that we a=
re
only taking care of the straightforward topologies for now.

Hi Lorenzo,
If you are ok with the above, please let me know if it make sense to send o=
ut
a v5 with this and your other comments or you can take care of them. I am f=
ine
either way.

Many thanks,
Shameer






--===============3027439967978096159==--

