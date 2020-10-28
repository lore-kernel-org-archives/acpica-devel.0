Content-Type: multipart/mixed; boundary="===============2048114872925492947=="
MIME-Version: 1.0
From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi at huawei.com>
Subject: [Devel] Re: [RFC PATCH 1/4] ACPICA: IORT: Update for revision E
Date: Wed, 28 Oct 2020 18:40:33 +0000
Message-ID: <ad260ac88bb84f9d850f95f05454e140@huawei.com>
In-Reply-To: MWHPR11MB1599988D7C857E3AFFA4A48AF0170@MWHPR11MB1599.namprd11.prod.outlook.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============2048114872925492947==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Erik,

[Adding back the original MLs + CC list]

> -----Original Message-----
> From: Kaneda, Erik [mailto:erik.kaneda(a)intel.com]
> Sent: 28 October 2020 18:20
> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi(a)huawei.com>;
> Moore, Robert <robert.moore(a)intel.com>; Wysocki, Rafael J
> <rafael.j.wysocki(a)intel.com>
> Subject: RE: [Devel] [RFC PATCH 1/4] ACPICA: IORT: Update for revision E
> =

> =

> =

> > -----Original Message-----
> > From: Shameerali Kolothum Thodi
> > <shameerali.kolothum.thodi(a)huawei.com>
> > Sent: Wednesday, October 28, 2020 1:15 AM
> > To: Moore, Robert <robert.moore(a)intel.com>
> > Cc: Kaneda, Erik <erik.kaneda(a)intel.com>
> > Subject: RE: [Devel] [RFC PATCH 1/4] ACPICA: IORT: Update for revision
> > E
> >
> > Hi,
> >
> > > -----Original Message-----
> > > From: Moore, Robert [mailto:robert.moore(a)intel.com]
> > > Sent: 27 October 2020 21:46
> > > To: Shameerali Kolothum Thodi
> > <shameerali.kolothum.thodi(a)huawei.com>
> > > Cc: Kaneda, Erik <erik.kaneda(a)intel.com>
> > > Subject: RE: [Devel] [RFC PATCH 1/4] ACPICA: IORT: Update for
> > > revision E
> > >
> > > This patch will need to be ported to the native ACPICA format.
> >
> > Thanks for your feedback. Sorry that, I am not familiar with the proces=
s here.
> > As mentioned
> > below, I thought a pull request via acpica git is enough, which you
> > can find here,
> >
> > https://github.com/acpica/acpica/pull/638
> >
> > The above pull includes this header file change + other changes
> > related to RMR for tools.
> >
> > Please let me know what else needs to be done when you say "native
> > format".
> =

> Oh ok, thanks for the pull request. You're submitting this as an RFC for =
linux. Do
> you expect the IORT definition to change throughout linux's RFC period? I=
f you
> don't plan on changing the IORT definition, we can look at the pull reque=
st.

The IORT revision E document is published here,
https://developer.arm.com/documentation/den0049/latest/
and I don=E2=80=99t think it will change now (But ARM folks can confirm thi=
s).

I submitted this as an RFC, because of the very dependency on this actbl2.h
header updates and this being not available in kernel. =


> Once we merge it, I'll submit the ACPICA patches to Rafael after we do a
> release.

Ok. Thanks for the details. Looking forward to getting this merged to kerne=
l soon :)

Thanks,
Shameer
 =

> Erik
> >
> > Thanks,
> > Shameer
> >
> >
> > >
> > >
> > > -----Original Message-----
> > > From: Shameer Kolothum <shameerali.kolothum.thodi(a)huawei.com>
> > > Sent: Tuesday, October 27, 2020 4:27 AM
> > > To: linux-arm-kernel(a)lists.infradead.org;
> > > linux-acpi(a)vger.kernel.org; iommu(a)lists.linux-foundation.org;
> > > devel(a)acpica.org
> > > Cc: linuxarm(a)huawei.com; lorenzo.pieralisi(a)arm.com; joro(a)8bytes=
.org;
> > > robin.murphy(a)arm.com; wanghuiqiang(a)huawei.com;
> > > jonathan.cameron(a)huawei.com
> > > Subject: [Devel] [RFC PATCH 1/4] ACPICA: IORT: Update for revision E
> > >
> > > IORT revision E contains a few additions like,
> > > =C2=A0 =C2=A0 -Added an identifier field in the node descriptors to a=
id table
> > > =C2=A0 =C2=A0 =C2=A0cross-referencing.
> > > =C2=A0 =C2=A0 -Introduced the Reserved Memory Range(RMR) node. This i=
s used
> > >  =C2=A0 =C2=A0 to describe memory ranges that are used by endpoints a=
nd
> > > requires
> > >  =C2=A0 =C2=A0 a unity mapping in SMMU.
> > >     -Introduced a flag in the RC node to express support for PRI.
> > >
> > > Signed-off-by: Shameer Kolothum
> > <shameerali.kolothum.thodi(a)huawei.com>
> > > ---
> > >  -This should be updated through acpica git. I have sent out a pull
> > >   request for the same here,
> > >   https://github.com/acpica/acpica/pull/638
> > >
> > > Please help to review.
> > > ---
> > >  include/acpi/actbl2.h | 25 +++++++++++++++++++------
> > >  1 file changed, 19 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h index
> > > ec66779cb193..274fce7b5c01 100644
> > > --- a/include/acpi/actbl2.h
> > > +++ b/include/acpi/actbl2.h
> > > @@ -68,7 +68,7 @@
> > >   * IORT - IO Remapping Table
> > >   *
> > >   * Conforms to "IO Remapping Table System Software on ARM
> > > Platforms",
> > > - * Document number: ARM DEN 0049D, March 2018
> > > + * Document number: ARM DEN 0049E, June 2020
> > >   *
> > >
> > >
> > **********************************************************
> > ******
> > > **************/
> > >
> > > @@ -86,7 +86,8 @@ struct acpi_iort_node {
> > >  	u8 type;
> > >  	u16 length;
> > >  	u8 revision;
> > > -	u32 reserved;
> > > +	u16 reserved;
> > > +	u16 identifier;
> > >  	u32 mapping_count;
> > >  	u32 mapping_offset;
> > >  	char node_data[1];
> > > @@ -100,7 +101,8 @@ enum acpi_iort_node_type {
> > >  	ACPI_IORT_NODE_PCI_ROOT_COMPLEX =3D 0x02,
> > >  	ACPI_IORT_NODE_SMMU =3D 0x03,
> > >  	ACPI_IORT_NODE_SMMU_V3 =3D 0x04,
> > > -	ACPI_IORT_NODE_PMCG =3D 0x05
> > > +	ACPI_IORT_NODE_PMCG =3D 0x05,
> > > +	ACPI_IORT_NODE_RMR =3D 0x06,
> > >  };
> > >
> > >  struct acpi_iort_id_mapping {
> > > @@ -167,10 +169,10 @@ struct acpi_iort_root_complex {
> > >  	u8 reserved[3];		/* Reserved, must be zero */
> > >  };
> > >
> > > -/* Values for ats_attribute field above */
> > > +/* Masks for ats_attribute field above */
> > >
> > > -#define ACPI_IORT_ATS_SUPPORTED         0x00000001	/* The
> root
> > > complex supports ATS */
> > > -#define ACPI_IORT_ATS_UNSUPPORTED       0x00000000	/* The
> root
> > > complex doesn't support ATS */
> > > +#define ACPI_IORT_ATS_SUPPORTED         (1)	/* The root complex
> > > supports ATS */
> > > +#define ACPI_IORT_PRI_SUPPORTED         (1<<1)	/* The root
> complex
> > > supports PRI */
> > >
> > >  struct acpi_iort_smmu {
> > >  	u64 base_address;	/* SMMU base address */
> > > @@ -241,6 +243,17 @@ struct acpi_iort_pmcg {
> > >  	u64 page1_base_address;
> > >  };
> > >
> > > +struct acpi_iort_rmr {
> > > +	u32 rmr_count;
> > > +	u32 rmr_offset;
> > > +};
> > > +
> > > +struct acpi_iort_rmr_desc {
> > > +	u64 base_address;
> > > +	u64 length;
> > > +	u32 reserved;
> > > +};
> > > +
> > >
> > >
> > /**********************************************************
> > *****
> > > ****************
> > >   *
> > >   * IVRS - I/O Virtualization Reporting Structure
> > > --
> > > 2.17.1
> > > _______________________________________________
> > > Devel mailing list -- devel(a)acpica.org To unsubscribe send an email
> > > to
> > > devel-
> > leave(a)acpica.org %(web_page_url)slistinfo%(cgiext)s/%(_internal_name
> > > )s

--===============2048114872925492947==--

