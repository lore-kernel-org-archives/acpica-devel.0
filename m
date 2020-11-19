Content-Type: multipart/mixed; boundary="===============3920713414079075291=="
MIME-Version: 1.0
From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi at huawei.com>
Subject: [Devel] Re: [RFC PATCH 2/4] ACPI/IORT: Add support for RMR node
 parsing
Date: Thu, 19 Nov 2020 12:07:07 +0000
Message-ID: <735edb5c4da842609c1d2a0eed73b06c@huawei.com>
In-Reply-To: DB7PR08MB3097062CEEDB4635BF3F694784EA0@DB7PR08MB3097.eurprd08.prod.outlook.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============3920713414079075291==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



> -----Original Message-----
> From: Sami Mujawar [mailto:Sami.Mujawar(a)arm.com]
> Sent: 09 November 2020 12:30
> To: david.e.box(a)linux.intel.com; Shameerali Kolothum Thodi
> <shameerali.kolothum.thodi(a)huawei.com>;
> linux-arm-kernel(a)lists.infradead.org; linux-acpi(a)vger.kernel.org;
> iommu(a)lists.linux-foundation.org; devel(a)acpica.org
> Cc: Linuxarm <linuxarm(a)huawei.com>; Lorenzo Pieralisi
> <Lorenzo.Pieralisi(a)arm.com>; joro(a)8bytes.org; Robin Murphy
> <Robin.Murphy(a)arm.com>; wanghuiqiang <wanghuiqiang(a)huawei.com>;
> Jonathan Cameron <jonathan.cameron(a)huawei.com>; nd <nd(a)arm.com>
> Subject: RE: [Devel] Re: [RFC PATCH 2/4] ACPI/IORT: Add support for RMR n=
ode
> parsing
> =

> Hi,
> =

> -----Original Message-----
> From: David E. Box <david.e.box(a)linux.intel.com>
> Sent: 28 October 2020 06:44 PM
> To: Shameer Kolothum <shameerali.kolothum.thodi(a)huawei.com>;
> linux-arm-kernel(a)lists.infradead.org; linux-acpi(a)vger.kernel.org;
> iommu(a)lists.linux-foundation.org; devel(a)acpica.org
> Cc: linuxarm(a)huawei.com; Lorenzo Pieralisi <Lorenzo.Pieralisi(a)arm.com=
>;
> joro(a)8bytes.org; Robin Murphy <Robin.Murphy(a)arm.com>;
> wanghuiqiang(a)huawei.com; jonathan.cameron(a)huawei.com
> Subject: [Devel] Re: [RFC PATCH 2/4] ACPI/IORT: Add support for RMR node
> parsing
> =

> Hi,
> =

> On Tue, 2020-10-27 at 11:26 +0000, Shameer Kolothum wrote:
> =

> ...
> =

> > @@ -1647,6 +1667,100 @@ static void __init iort_enable_acs(struct
> > acpi_iort_node *iort_node)
> >  #else
> >  static inline void iort_enable_acs(struct acpi_iort_node *iort_node)
> > { }
> >  #endif
> > +static int iort_rmr_desc_valid(struct acpi_iort_rmr_desc *desc)
> > +{
> > +	struct iort_rmr_entry *e;
> > +	u64 end, start =3D desc->base_address, length =3D desc->length;
> > +
> > +	if ((!IS_ALIGNED(start, SZ_64K)) || (length % SZ_64K !=3D 0))
> =

> You could just do:
> =

> if ((!IS_ALIGNED(start, SZ_64K)) || (length % SZ_64K))
> =

> [SAMI] In my opinion, the following may be better:
> 	if (!IS_ALIGNED(start, SZ_64K) || !IS_ALIGNED(length, SZ_64K))
> [/SAMI]

Thanks for your suggestions. I don't have a strong opinion on either
of those, but will change it with the latter one for now.

Thanks,
Shameer

> Regards,
> =

> Sami Mujawar
> =

> David
> _______________________________________________
> Devel mailing list -- devel(a)acpica.org
> To unsubscribe send an email to devel-leave(a)acpica.org
> %(web_page_url)slistinfo%(cgiext)s/%(_internal_name)s
--===============3920713414079075291==--

