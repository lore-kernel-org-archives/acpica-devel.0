Content-Type: multipart/mixed; boundary="===============2389251624107108081=="
MIME-Version: 1.0
From: Lorenzo Pieralisi <lorenzo.pieralisi at arm.com>
Subject: Re: [Devel] [RFCv2 2/2] iommu/arm-smmu-v3:Enable ACPI based HiSilicon
 erratum 161010801
Date: Thu, 08 Jun 2017 11:15:08 +0100
Message-ID: <20170608101508.GA8644@red-moon>
In-Reply-To: 5FC3163CFD30C246ABAA99954A238FA838363D5D@FRAEML521-MBX.china.huawei.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============2389251624107108081==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 08, 2017 at 09:09:28AM +0000, Shameerali Kolothum Thodi wrote:
> =

> =

> > -----Original Message-----
> > From: Lorenzo Pieralisi [mailto:lorenzo.pieralisi(a)arm.com]
> > Sent: Thursday, June 08, 2017 9:49 AM
> > To: Shameerali Kolothum Thodi
> > Cc: marc.zyngier(a)arm.com; sudeep.holla(a)arm.com; will.deacon(a)arm.c=
om;
> > robin.murphy(a)arm.com; hanjun.guo(a)linaro.org; Gabriele Paoloni; John
> > Garry; iommu(a)lists.linux-foundation.org; linux-arm-
> > kernel(a)lists.infradead.org; linux-acpi(a)vger.kernel.org; devel(a)acp=
ica.org;
> > Linuxarm; Wangzhou (B); Guohanjun (Hanjun Guo)
> > Subject: Re: [RFCv2 2/2] iommu/arm-smmu-v3:Enable ACPI based HiSilicon
> > erratum 161010801
> > =

> > On Tue, Jun 06, 2017 at 03:01:36PM +0000, Shameerali Kolothum Thodi
> > wrote:
> > =

> > [...]
> > =

> > > > > +	irq_dom =3D pci_msi_get_device_domain(to_pci_dev(dev));
> > > > > +	if (irq_dom) {
> > > > > +		int	ret;
> > > > > +		u32	rid;
> > > > > +
> > > > > +		rid =3D pci_msi_domain_get_msi_rid(irq_dom,
> > > > to_pci_dev(dev));
> > > > > +		ret =3D iort_dev_find_its_base(dev, rid, 0, &base);
> > > >
> > > > Well, here we use ITS id 0 which is fine as long as code in IORT
> > > > uses the same policy for getting the irq_domain (ie we want to
> > > > reserve the ITS address space that is actually used by the device to
> > > > send IRQs not a a different one) it is just a heads-up because I fi=
nd this
> > confusing.
> > >
> > > Ok. Just to make it clear, 0 is the index into the ITS identifier
> > > list.  I noted that iort_get_device_domain() uses index 0 while
> > > retrieving the ITS identifier.  May be use the same approach here as
> > > well? ie, remove the index from function call?
> > >
> > > I am not sure, how we can get the index info  though theoretically It
> > > is possible for the ITS group node having multiple ITSs.
> > =

> > Actually I think it would make sense to reserve ALL ITS regions a devic=
e may
> > be mapped to instead of just index 0 (ie in your case it is equivalent)=
; this
> > leaves us some leeway as to choose which ITS the device will be actually
> > mapped to and this code does not have to care.
> =

> Ok. That make sense. Just a quick one, is it ok to add another helper fun=
ction in
> iort code to retrieve the its->its_count then? =


While at it, given that the pci API code to retrieve domain and rid falls
back to IORT anyway, I would add the whole reservation to IORT (mind,
it depends on IOMMU_API) as one function instead of fiddling about with
indexes.

Side note: why Hilisicon dts upstream (eg hip07.dtsi) report ITS size
as 256K ? I was just checking whether the ITS reg map size is system
dependent and I bumped into them, I suspect there may be some dts
patching needed here.

Lorenzo

--===============2389251624107108081==--

