Content-Type: multipart/mixed; boundary="===============0884611895110474341=="
MIME-Version: 1.0
From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi at huawei.com>
Subject: Re: [Devel] [PATCH] iommu/arm-smmu-v3: Enable ACPI based HiSilicon
 CMD_PREFETCH quirk(erratum 161010701)
Date: Fri, 23 Jun 2017 12:49:34 +0000
Message-ID: <5FC3163CFD30C246ABAA99954A238FA83838930B@FRAEML521-MBS.china.huawei.com>
In-Reply-To: 20170623120207.GA2310@arm.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============0884611895110474341==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



> -----Original Message-----
> From: Will Deacon [mailto:will.deacon(a)arm.com]
> Sent: Friday, June 23, 2017 1:02 PM
> To: Shameerali Kolothum Thodi
> Cc: robin.murphy(a)arm.com; mark.rutland(a)arm.com;
> lorenzo.pieralisi(a)arm.com; John Garry; Gabriele Paoloni; Guohanjun
> (Hanjun Guo); xuwei (O); Linuxarm; devel(a)acpica.org; linux-
> acpi(a)vger.kernel.org; linux-arm-kernel(a)lists.infradead.org;
> devicetree(a)vger.kernel.org
> Subject: Re: [PATCH] iommu/arm-smmu-v3: Enable ACPI based HiSilicon
> CMD_PREFETCH quirk(erratum 161010701)
> =

> On Fri, Jun 23, 2017 at 08:29:28AM +0000, Shameerali Kolothum Thodi wrote:
> > > -----Original Message-----
> > > From: Shameerali Kolothum Thodi
> > > Sent: Wednesday, May 17, 2017 10:12 AM
> > > To: robin.murphy(a)arm.com; will.deacon(a)arm.com;
> mark.rutland(a)arm.com;
> > > lorenzo.pieralisi(a)arm.com
> > > Cc: John Garry; Gabriele Paoloni; Guohanjun (Hanjun Guo); xuwei (O);
> > > Linuxarm; devel(a)acpica.org; linux-acpi(a)vger.kernel.org; linux-arm-
> > > kernel(a)lists.infradead.org; devicetree(a)vger.kernel.org; Shameerali
> > > Kolothum Thodi
> > > Subject: [PATCH] iommu/arm-smmu-v3: Enable ACPI based HiSilicon
> > > CMD_PREFETCH quirk(erratum 161010701)
> > >
> > > HiSilicon SMMUv3 on Hip06/Hip07 platforms doesn't support
> > > CMD_PREFETCH command. The dt based support for this quirk is already
> > > present in the driver(hisilicon,broken-prefetch-cmd). This adds ACPI
> > > support for the quirk using the IORT smmu model number.
> >
> > This also  has dependency on acpica header update and it looks like
> > it's going to take a while to appear on Linux mainline. I have seen
> > patches where a temp local definition for SMMU v3 model number is
> suggested instead.
> >
> > Could you please let me know the plan so that I can base this patch
> > similar to or on top of Caviums "[PATCH] iommu/arm-smmu-v3, acpi: Add
> > temporary Cavium SMMU-V3 IORT model number definitions"
> =

> I think I've got this in hand, but I'll shout if I run into any issues.

Ok. Thanks Will. Sure.

Shameer

--===============0884611895110474341==--

