Content-Type: multipart/mixed; boundary="===============3334932196437176028=="
MIME-Version: 1.0
From: Lorenzo Pieralisi <lorenzo.pieralisi at arm.com>
Subject: [Devel] Re: [RFC PATCH v2 1/8] ACPICA: IORT: Update for revision E
Date: Wed, 24 Mar 2021 09:50:12 +0000
Message-ID: <20210324095012.GA15200@e121166-lin.cambridge.arm.com>
In-Reply-To: MWHPR11MB1599F9CAF0D21030619B359BF0649@MWHPR11MB1599.namprd11.prod.outlook.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============3334932196437176028==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 23, 2021 at 06:51:44PM +0000, Kaneda, Erik wrote:
> =

> =

> > -----Original Message-----
> > From: Lorenzo Pieralisi <lorenzo.pieralisi(a)arm.com>
> > Sent: Tuesday, March 23, 2021 8:54 AM
> > To: Kaneda, Erik <erik.kaneda(a)intel.com>
> > Cc: Shameerali Kolothum Thodi <shameerali.kolothum.thodi(a)huawei.com>;
> > linux-arm-kernel(a)lists.infradead.org; linux-acpi(a)vger.kernel.org;
> > iommu(a)lists.linux-foundation.org; devel(a)acpica.org; Moore, Robert
> > <robert.moore(a)intel.com>; Linuxarm <linuxarm(a)huawei.com>;
> > steven.price(a)arm.com; Sami.Mujawar(a)arm.com; robin.murphy(a)arm.com;
> > wanghuiqiang <wanghuiqiang(a)huawei.com>
> > Subject: Re: [RFC PATCH v2 1/8] ACPICA: IORT: Update for revision E
> > =

> > On Mon, Mar 22, 2021 at 09:57:58PM +0000, Kaneda, Erik wrote:
> > >
> > >
> > > > -----Original Message-----
> > > > From: Shameerali Kolothum Thodi
> > > > <shameerali.kolothum.thodi(a)huawei.com>
> > > > Sent: Monday, March 22, 2021 3:36 AM
> > > > To: Kaneda, Erik <erik.kaneda(a)intel.com>; linux-arm-
> > > > kernel(a)lists.infradead.org; linux-acpi(a)vger.kernel.org;
> > iommu(a)lists.linux-
> > > > foundation.org; devel(a)acpica.org; Lorenzo Pieralisi
> > > > <lorenzo.pieralisi(a)arm.com>; Moore, Robert
> > <robert.moore(a)intel.com>
> > > > Cc: Linuxarm <linuxarm(a)huawei.com>; steven.price(a)arm.com;
> > > > Sami.Mujawar(a)arm.com; robin.murphy(a)arm.com; wanghuiqiang
> > > > <wanghuiqiang(a)huawei.com>
> > > > Subject: [Devel] Re: [RFC PATCH v2 1/8] ACPICA: IORT: Update for
> > revision E
> > > >
> > > > [+]
> > > >
> > > > Hi Erik,
> > > >
> > > > As this is now just merged ino acpica-master and based on the discu=
ssion
> > we
> > > > had here,
> > > >
> > > > https://github.com/acpica/acpica/pull/638
> > > >
> > > > I had a discussion with ARM folks(Lorenzo) in the linaro-open-discu=
ssions
> > call
> > > > and
> > > > can confirm that the IORT Revision E is not the final specification=
 and has
> > > > some issues
> > > > which is now corrected in the latest E.b revision[1]. Also there ar=
e no
> > current
> > > > users
> > > > for the Rev E and it may not be a good idea to push this version in=
to the
> > Linux
> > > > kernel
> > > > or elsewhere.
> > > >
> > > > So could you please revert the merge and I am planning to work on t=
he
> > E.b
> > > > soon.
> > > Hi,
> > >
> > > > Please let me know if I need to explicitly send a revert pull reque=
st or not.
> > >
> > > Please send a revert pull request and I'll remember to not submit Lin=
ux-ize
> > the IORT patches.
> > >
> > > From all of the activity that I've seen with the IORT specification,
> > > it looks like this table is nontrivial to design and maintain. The
> > > difficulty I have with the table is that I do not understand which
> > > table revisions are in active use.
> > =

> Hi Lorenzo,
> =

> > Possibly all of them in firmware in the field - I am not sure what you
> > are asking though; if you can elaborate I'd be grateful.
> =

> Yes, I'd be happy to explain.
> =

> The ACPICA project contains code that provides definitions for ACPI table=
s. After each release of this project, the codebase gets translated to a Li=
nux style syntax and relevant patches are submitted to Linux so that it can=
 use these table definitions in their driver codebase. From ACPICA's perspe=
ctive, the code providing these definitions are used to implement a compile=
r/disassembler called iASL. This tool disassembles table definitions so tha=
t the user doesn't have to open a hex editor to decipher ACPI tables. Our g=
oal with iASL is to be able to disassemble as many ACPI tables as possible =
to give users the ability to compile and debug ACPI tables.
> =

> Out of the 60+ tables that we support, IORT has been tricky to maintain. =
There are revisions A-E and we have received pull requests from engineers f=
rom ARM or companies that work with ARM. We are grateful of their contribut=
ions but some of these pull requests have broken support for earlier versio=
ns of IORT. In addition, we sometimes receive communication from people lik=
e Shameer saying that revision E does not currently have users. This leaves=
 Bob and I very confused about which revisions we should be focused on supp=
orting in iASL.
> =

> We need your help in understanding which versions of IORT should be suppo=
rted by iASL as well as Linux.
> =

> I hope this helps.. Let me know if you need me to clarify anything that I=
've written.

Yes, it does, it is my question that wasn't clear, I maintain the
Linux ACPI ARM64 code, I am familiar with ACPICA and all of the above.

What I wanted to say is that overall, all versions should be supported
and I *think* ACPICA is designed so that the static table headers are
meant to support the *latest* table version (whose firmware bindings are
supposed to be backward compatible with all existing versions "in use").

However, revision E and E.a required a spec update, hence Shameer revert
request (which I support).

I think what you are asking is someone from Arm to act as a gatekeeper
to help you ACK/NAK ACPICA IORT changes because you have no visibility
into IORT specs evolution and actual deployment.

Is my understanding correct ?

Thanks,
Lorenzo

> Thanks,
> Erik
> > =

> > > So my question is this: which IORT revisions are being actively used?
> > =

> > See above.
> > =

> > Thanks,
> > Lorenzo
> > =

> > >
> > > Thanks,
> > > Erik
> > > >
> > > > Thanks,
> > > > Shameer
> > > >
> > > > 1. https://developer.arm.com/documentation/den0049/latest/
> > > >
> > > > > -----Original Message-----
> > > > > From: iommu [mailto:iommu-bounces(a)lists.linux-foundation.org] On
> > > > Behalf Of
> > > > > Shameer Kolothum
> > > > > Sent: 19 November 2020 12:12
> > > > > To: linux-arm-kernel(a)lists.infradead.org; linux-acpi(a)vger.ker=
nel.org;
> > > > > iommu(a)lists.linux-foundation.org; devel(a)acpica.org
> > > > > Cc: Linuxarm <linuxarm(a)huawei.com>; steven.price(a)arm.com;
> > > > Guohanjun
> > > > > (Hanjun Guo) <guohanjun(a)huawei.com>; Sami.Mujawar(a)arm.com;
> > > > > robin.murphy(a)arm.com; wanghuiqiang <wanghuiqiang(a)huawei.com>
> > > > > Subject: [RFC PATCH v2 1/8] ACPICA: IORT: Update for revision E
> > > > >
> > > > > IORT revision E contains a few additions like,
> > > > > =C2=A0 =C2=A0 -Added an identifier field in the node descriptors =
to aid table
> > > > > =C2=A0 =C2=A0 =C2=A0cross-referencing.
> > > > > =C2=A0 =C2=A0 -Introduced the Reserved Memory Range(RMR) node. Th=
is is used
> > > > >  =C2=A0 =C2=A0 to describe memory ranges that are used by endpoin=
ts and requires
> > > > >  =C2=A0 =C2=A0 a unity mapping in SMMU.
> > > > >     -Introduced a flag in the RC node to express support for PRI.
> > > > >
> > > > > Signed-off-by: Shameer Kolothum
> > > > <shameerali.kolothum.thodi(a)huawei.com>
> > > > > ---
> > > > >  include/acpi/actbl2.h | 25 +++++++++++++++++++------
> > > > >  1 file changed, 19 insertions(+), 6 deletions(-)
> > > > >
> > > > > diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h index
> > > > > ec66779cb193..274fce7b5c01 100644
> > > > > --- a/include/acpi/actbl2.h
> > > > > +++ b/include/acpi/actbl2.h
> > > > > @@ -68,7 +68,7 @@
> > > > >   * IORT - IO Remapping Table
> > > > >   *
> > > > >   * Conforms to "IO Remapping Table System Software on ARM
> > Platforms",
> > > > > - * Document number: ARM DEN 0049D, March 2018
> > > > > + * Document number: ARM DEN 0049E, June 2020
> > > > >   *
> > > > >
> > > > >
> > > >
> > **********************************************************
> > > > ******
> > > > > **************/
> > > > >
> > > > > @@ -86,7 +86,8 @@ struct acpi_iort_node {
> > > > >  	u8 type;
> > > > >  	u16 length;
> > > > >  	u8 revision;
> > > > > -	u32 reserved;
> > > > > +	u16 reserved;
> > > > > +	u16 identifier;
> > > > >  	u32 mapping_count;
> > > > >  	u32 mapping_offset;
> > > > >  	char node_data[1];
> > > > > @@ -100,7 +101,8 @@ enum acpi_iort_node_type {
> > > > >  	ACPI_IORT_NODE_PCI_ROOT_COMPLEX =3D 0x02,
> > > > >  	ACPI_IORT_NODE_SMMU =3D 0x03,
> > > > >  	ACPI_IORT_NODE_SMMU_V3 =3D 0x04,
> > > > > -	ACPI_IORT_NODE_PMCG =3D 0x05
> > > > > +	ACPI_IORT_NODE_PMCG =3D 0x05,
> > > > > +	ACPI_IORT_NODE_RMR =3D 0x06,
> > > > >  };
> > > > >
> > > > >  struct acpi_iort_id_mapping {
> > > > > @@ -167,10 +169,10 @@ struct acpi_iort_root_complex {
> > > > >  	u8 reserved[3];		/* Reserved, must be zero */
> > > > >  };
> > > > >
> > > > > -/* Values for ats_attribute field above */
> > > > > +/* Masks for ats_attribute field above */
> > > > >
> > > > > -#define ACPI_IORT_ATS_SUPPORTED         0x00000001	/* The root
> > > > > complex supports ATS */
> > > > > -#define ACPI_IORT_ATS_UNSUPPORTED       0x00000000	/* The root
> > > > > complex doesn't support ATS */
> > > > > +#define ACPI_IORT_ATS_SUPPORTED         (1)	/* The root complex
> > > > > supports ATS */
> > > > > +#define ACPI_IORT_PRI_SUPPORTED         (1<<1)	/* The root
> > complex
> > > > > supports PRI */
> > > > >
> > > > >  struct acpi_iort_smmu {
> > > > >  	u64 base_address;	/* SMMU base address */
> > > > > @@ -241,6 +243,17 @@ struct acpi_iort_pmcg {
> > > > >  	u64 page1_base_address;
> > > > >  };
> > > > >
> > > > > +struct acpi_iort_rmr {
> > > > > +	u32 rmr_count;
> > > > > +	u32 rmr_offset;
> > > > > +};
> > > > > +
> > > > > +struct acpi_iort_rmr_desc {
> > > > > +	u64 base_address;
> > > > > +	u64 length;
> > > > > +	u32 reserved;
> > > > > +};
> > > > > +
> > > > >
> > > > >
> > > >
> > /**********************************************************
> > > > *****
> > > > > ****************
> > > > >   *
> > > > >   * IVRS - I/O Virtualization Reporting Structure
> > > > > --
> > > > > 2.17.1
> > > > >
> > > > > _______________________________________________
> > > > > iommu mailing list
> > > > > iommu(a)lists.linux-foundation.org
> > > > > https://lists.linuxfoundation.org/mailman/listinfo/iommu
> > > > _______________________________________________
> > > > Devel mailing list -- devel(a)acpica.org
> > > > To unsubscribe send an email to devel-leave(a)acpica.org
> > > > %(web_page_url)slistinfo%(cgiext)s/%(_internal_name)s
--===============3334932196437176028==--

