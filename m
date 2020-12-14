Content-Type: multipart/mixed; boundary="===============3283344301141795594=="
MIME-Version: 1.0
From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi at huawei.com>
Subject: [Devel] Re: [RFC PATCH v2 0/8] ACPI/IORT: Support for IORT RMR node
Date: Mon, 14 Dec 2020 10:55:26 +0000
Message-ID: <67cb563d19114f609348dc9f8b4307e9@huawei.com>
In-Reply-To: e9837ba5-deeb-c64c-2261-d0ab82eebfac@arm.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============3283344301141795594==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Steve,

> -----Original Message-----
> From: Steven Price [mailto:steven.price(a)arm.com]
> Sent: 10 December 2020 10:26
> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi(a)huawei.com>;
> linux-arm-kernel(a)lists.infradead.org; linux-acpi(a)vger.kernel.org;
> iommu(a)lists.linux-foundation.org; devel(a)acpica.org
> Cc: Linuxarm <linuxarm(a)huawei.com>; lorenzo.pieralisi(a)arm.com;
> joro(a)8bytes.org; robin.murphy(a)arm.com; wanghuiqiang
> <wanghuiqiang(a)huawei.com>; Guohanjun (Hanjun Guo)
> <guohanjun(a)huawei.com>; Jonathan Cameron
> <jonathan.cameron(a)huawei.com>; Sami.Mujawar(a)arm.com
> Subject: Re: [RFC PATCH v2 0/8] ACPI/IORT: Support for IORT RMR node
> =

> On 19/11/2020 12:11, Shameer Kolothum wrote:
> > RFC v1 --> v2:
> >  =C2=A0- Added a generic interface for IOMMU drivers to retrieve all the
> >  =C2=A0 =C2=A0RMR info associated with a given IOMMU.
> >  =C2=A0- SMMUv3 driver gets the RMR list during probe() and installs
> >  =C2=A0=C2=A0 bypass STEs for all the SIDs in the RMR list. This is to =
keep
> >   =C2=A0 the ongoing traffic alive(if any) during SMMUv3 reset. This is
> >     based on the suggestions received for v1 to take care of the
> >     EFI framebuffer use case. Only sanity tested for now.
> =

> Hi Shameer,
> =

> Sorry for not looking at this before.
> =

> Do you have any plans to implement support in the SMMUv2 driver? The
> platform I've been testing the EFI framebuffer support on has the
> display controller behind SMMUv2, so as it stands this series doesn't
> work. I did hack something up for SMMUv2 so I was able to test the first
> 4 patches.

Thanks for taking a look. Sure, I can look into adding the support for SMMU=
v2. =


> =

> >  =C2=A0- During the probe/attach device, SMMUv3 driver reserves any
> >  =C2=A0 =C2=A0RMR region associated with the device such that there is =
a unity
> >  =C2=A0 =C2=A0mapping for them in SMMU.
> =

> For the EFI framebuffer use case there is no device to attach so I
> believe we are left with just the stream ID in bypass mode - which is
> definitely an improvement (the display works!)

Cool. That=E2=80=99s good to know.

 but not actually a unity
> mapping of the RMR range. I'm not sure whether it's worth fixing this or
> not, but I just wanted to point out there's still a need for a driver
> for the device before the bypass mode is replaced with the unity mapping.

I am not sure either. My idea was we will have bypass STE setup for all dev=
ices
with RMR initially and when the corresponding driver takes over(if that hap=
pens)
we will have the unity mapping setup properly for the RMR regions. And for =
cases
like the above, it will remain in the bypass mode.

Do you see any problem(security?) if the dev streams remain in bypass mode =
for
this dev? Or is it possible to have a stub driver for this dev, so that we =
will have
the probe/attach invoked and everything will fall in place?

TBH, I haven't looked into creating a temp domain for these types of the de=
vices
and also not sure how we benefit from that compared to the STE bypass mode.

Thoughts/Ideas welcome.

Thanks,
Shameer


--===============3283344301141795594==--

