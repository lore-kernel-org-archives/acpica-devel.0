Content-Type: multipart/mixed; boundary="===============3563555305956501952=="
MIME-Version: 1.0
From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi at huawei.com>
Subject: [Devel] Re: [RFC PATCH v2 0/8] ACPI/IORT: Support for IORT RMR node
Date: Mon, 04 Jan 2021 08:55:40 +0000
Message-ID: <4f0ede92d9d24b9da0baacd7e77e672d@huawei.com>
In-Reply-To: CABdtJHvGXBMmjbb8z9aHQt=nhAvCiFdsKJZfzagsmT+Kj8G_Bw@mail.gmail.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============3563555305956501952==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



> -----Original Message-----
> From: Jon Nettleton [mailto:jon(a)solid-run.com]
> Sent: 18 December 2020 10:53
> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi(a)huawei.com>
> Cc: Steven Price <steven.price(a)arm.com>; Robin Murphy
> <robin.murphy(a)arm.com>; linux-arm-kernel(a)lists.infradead.org;
> linux-acpi(a)vger.kernel.org; iommu(a)lists.linux-foundation.org;
> devel(a)acpica.org; lorenzo.pieralisi(a)arm.com; joro(a)8bytes.org; Guoha=
njun
> (Hanjun Guo) <guohanjun(a)huawei.com>; Linuxarm <linuxarm(a)huawei.com>;
> Jonathan Cameron <jonathan.cameron(a)huawei.com>;
> Sami.Mujawar(a)arm.com; wanghuiqiang <wanghuiqiang(a)huawei.com>
> Subject: Re: [RFC PATCH v2 0/8] ACPI/IORT: Support for IORT RMR node
> =

> On Thu, Dec 17, 2020 at 4:53 PM Jon Nettleton <jon(a)solid-run.com> wrote:
> >
> > On Thu, Dec 17, 2020 at 4:42 PM Shameerali Kolothum Thodi
> > <shameerali.kolothum.thodi(a)huawei.com> wrote:
> > >
> > >
> > >
> > > > -----Original Message-----
> > > > From: Jon Nettleton [mailto:jon(a)solid-run.com]
> > > > Sent: 17 December 2020 14:48
> > > > To: Shameerali Kolothum Thodi
> <shameerali.kolothum.thodi(a)huawei.com>
> > > > Cc: Steven Price <steven.price(a)arm.com>; Robin Murphy
> > > > <robin.murphy(a)arm.com>; linux-arm-kernel(a)lists.infradead.org;
> > > > linux-acpi(a)vger.kernel.org; iommu(a)lists.linux-foundation.org;
> > > > devel(a)acpica.org; lorenzo.pieralisi(a)arm.com; joro(a)8bytes.org;
> Guohanjun
> > > > (Hanjun Guo) <guohanjun(a)huawei.com>; Linuxarm
> <linuxarm(a)huawei.com>;
> > > > Jonathan Cameron <jonathan.cameron(a)huawei.com>;
> > > > Sami.Mujawar(a)arm.com; wanghuiqiang <wanghuiqiang(a)huawei.com>
> > > > Subject: Re: [RFC PATCH v2 0/8] ACPI/IORT: Support for IORT RMR node
> > > >
> > > > On Mon, Dec 14, 2020 at 3:48 PM Shameerali Kolothum Thodi
> > > > <shameerali.kolothum.thodi(a)huawei.com> wrote:
> > > > >
> > > > >
> > > > >
> > > > > > -----Original Message-----
> > > > > > From: Steven Price [mailto:steven.price(a)arm.com]
> > > > > > Sent: 14 December 2020 13:43
> > > > > > To: Robin Murphy <robin.murphy(a)arm.com>; Shameerali Kolothum
> Thodi
> > > > > > <shameerali.kolothum.thodi(a)huawei.com>;
> > > > > > linux-arm-kernel(a)lists.infradead.org; linux-acpi(a)vger.kerne=
l.org;
> > > > > > iommu(a)lists.linux-foundation.org; devel(a)acpica.org
> > > > > > Cc: Linuxarm <linuxarm(a)huawei.com>; lorenzo.pieralisi(a)arm.c=
om;
> > > > > > joro(a)8bytes.org; wanghuiqiang <wanghuiqiang(a)huawei.com>;
> Guohanjun
> > > > > > (Hanjun Guo) <guohanjun(a)huawei.com>; Jonathan Cameron
> > > > > > <jonathan.cameron(a)huawei.com>; Sami.Mujawar(a)arm.com
> > > > > > Subject: Re: [RFC PATCH v2 0/8] ACPI/IORT: Support for IORT RMR
> node
> > > > > >
> > > > > > On 14/12/2020 12:33, Robin Murphy wrote:
> > > > > > > On 2020-12-14 10:55, Shameerali Kolothum Thodi wrote:
> > > > > > >> Hi Steve,
> > > > > > >>
> > > > > > >>> -----Original Message-----
> > > > > > >>> From: Steven Price [mailto:steven.price(a)arm.com]
> > > > > > >>> Sent: 10 December 2020 10:26
> > > > > > >>> To: Shameerali Kolothum Thodi
> > > > > > <shameerali.kolothum.thodi(a)huawei.com>;
> > > > > > >>> linux-arm-kernel(a)lists.infradead.org; linux-acpi(a)vger.k=
ernel.org;
> > > > > > >>> iommu(a)lists.linux-foundation.org; devel(a)acpica.org
> > > > > > >>> Cc: Linuxarm <linuxarm(a)huawei.com>;
> lorenzo.pieralisi(a)arm.com;
> > > > > > >>> joro(a)8bytes.org; robin.murphy(a)arm.com; wanghuiqiang
> > > > > > >>> <wanghuiqiang(a)huawei.com>; Guohanjun (Hanjun Guo)
> > > > > > >>> <guohanjun(a)huawei.com>; Jonathan Cameron
> > > > > > >>> <jonathan.cameron(a)huawei.com>; Sami.Mujawar(a)arm.com
> > > > > > >>> Subject: Re: [RFC PATCH v2 0/8] ACPI/IORT: Support for IORT=
 RMR
> node
> > > > > > >>>
> > > > > > >>> On 19/11/2020 12:11, Shameer Kolothum wrote:
> > > > > > >>>> RFC v1 --> v2:
> > > > > > >>>>    - Added a generic interface for IOMMU drivers to retrie=
ve all
> the
> > > > > > >>>>      RMR info associated with a given IOMMU.
> > > > > > >>>>    - SMMUv3 driver gets the RMR list during probe() and
> installs
> > > > > > >>>>      bypass STEs for all the SIDs in the RMR list. This is=
 to keep
> > > > > > >>>>      the ongoing traffic alive(if any) during SMMUv3 reset=
. This
> is
> > > > > > >>>>      based on the suggestions received for v1 to take care=
 of
> the
> > > > > > >>>>      EFI framebuffer use case. Only sanity tested for now.
> > > > > > >>>
> > > > > > >>> Hi Shameer,
> > > > > > >>>
> > > > > > >>> Sorry for not looking at this before.
> > > > > > >>>
> > > > > > >>> Do you have any plans to implement support in the SMMUv2
> driver?
> > > > The
> > > > > > >>> platform I've been testing the EFI framebuffer support on h=
as the
> > > > > > >>> display controller behind SMMUv2, so as it stands this seri=
es
> doesn't
> > > > > > >>> work. I did hack something up for SMMUv2 so I was able to t=
est
> the
> > > > first
> > > > > > >>> 4 patches.
> > > > > > >>
> > > > > > >> Thanks for taking a look. Sure, I can look into adding the s=
upport for
> > > > > > >> SMMUv2.
> > > > > >
> > > > > > Great, thanks!
> > > > > >
> > > > > > >>>
> > > > > > >>>>    - During the probe/attach device, SMMUv3 driver reserves
> any
> > > > > > >>>>      RMR region associated with the device such that there=
 is
> a
> > > > unity
> > > > > > >>>>      mapping for them in SMMU.
> > > > > > >>>
> > > > > > >>> For the EFI framebuffer use case there is no device to atta=
ch so I
> > > > > > >>> believe we are left with just the stream ID in bypass mode =
- which
> is
> > > > > > >>> definitely an improvement (the display works!)
> > > > > > >>
> > > > > > >> Cool. That=E2=80=99s good to know.
> > > > > > >>
> > > > > > >>   but not actually a unity
> > > > > > >>> mapping of the RMR range. I'm not sure whether it's worth f=
ixing
> this
> > > > or
> > > > > > >>> not, but I just wanted to point out there's still a need fo=
r a driver
> > > > > > >>> for the device before the bypass mode is replaced with the =
unity
> > > > > > >>> mapping.
> > > > > > >>
> > > > > > >> I am not sure either. My idea was we will have bypass STE se=
tup for
> > > > > > >> all devices
> > > > > > >> with RMR initially and when the corresponding driver takes o=
ver(if
> > > > > > >> that happens)
> > > > > > >> we will have the unity mapping setup properly for the RMR re=
gions.
> And
> > > > > > >> for cases
> > > > > > >> like the above, it will remain in the bypass mode.
> > > > > > >>
> > > > > > >> Do you see any problem(security?) if the dev streams remain =
in
> bypass
> > > > > > >> mode for
> > > > > > >> this dev? Or is it possible to have a stub driver for this d=
ev, so
> > > > > > >> that we will have
> > > > > > >> the probe/attach invoked and everything will fall in place?
> > > > > > >
> > > > > > > The downside is that if a driver never binds to that device, =
it remains
> > > > > > > bypassed. If some other externally-controlled malicious devic=
e could
> > > > > > > manage to spoof that device's requester ID, that could potent=
ially be
> > > > > > > exploited.
> > > > > > >
> > > > > > >> TBH, I haven't looked into creating a temp domain for these =
types
> of
> > > > > > >> the devices
> > > > > > >> and also not sure how we benefit from that compared to the S=
TE
> bypass
> > > > > > >> mode.
> > > > > > >
> > > > > > > That said, setting up temporary translation contexts that ens=
ure any
> > > > > > > access can *only* be to RMR regions until a driver takes over=
 is an
> > > > > > > awful lot more work. I'm inclined to be pragmatic here and sa=
y we
> should
> > > > > > > get things working at all with the simple bypass STE/S2CR met=
hod,
> then
> > > > > > > look at adding the higher-security effort on top.
> > > > > > >
> > > > > > > Right now systems that need this are either broken (but effec=
tively
> > > > > > > secure) or using default bypass with SMMUv2. People who prefe=
r to
> > > > > > > maintain security over functionality in the interim can maint=
ain that
> > > > > > > status quo by simply continuing to not describe any RMRs.
> > > > > >
> > > > > > I agree with Robin, let's get this working with the bypass mode=
 (until
> > > > > > the device binds) like you've currently got. It's much better t=
han what
> > > > > > we have otherwise. Then once that is merged we can look at the
> temporary
> > > > > > translation context or stub driver. The temporary translation c=
ontext
> > > > > > would be 'neatest', but I'm only aware of the EFI framebuffer u=
se case
> > > > > > and for that it might be possible to do something simpler - if =
indeed
> > > > > > anything is needed at all. I'm not sure how much we need to be
> worried
> > > > > > about malicious devices spoofing requester IDs.
> > > > >
> > > > > Perfect. I will keep the STE bypass and respin the series once th=
e update
> > > > > to the IORT rev E is made public(hope that will happen soon). In =
the
> > > > > meantime, appreciate any feedback on the rest of the patches in t=
his
> series.
> > > >
> > > > Shameer,
> > >
> > > Hi Jon,
> > >
> > > >
> > > > I am pretty sure rev E is already public.  You can find it here.
> > > >
> > > > https://developer.arm.com/documentation/den0049/latest/
> > > >
> > > > It is also marked non-confidential.
> > >
> > > Yes, Rev E is already out there. But I am told that ARM folks are wor=
king on
> > > some updates to the IORT spec, especially around the RMR topic. Hopef=
ully
> > > it will be out soon.
> >
> > Yes there are some changes coming to the SPEC but I don't know if it is
> > worth holding up your patchset as an initial implementation.  If you wo=
uld
> > like I am more than happy to bring this up as a topic for the next Stee=
ring
> > Committee meeting.
> >
> > Jon
>
> Shameer,
>

Hi Jon,
 =

> My first attempt at smmuv2 support can be found in this kernel branch.
> =

> https://github.com/SolidRun/linux-stable/commits/linux-5.10.y-cex7
> =

> It is functioning if the bypass SMRs are setup in the firmware and RMR's
> are exposed in the ACPI tables.

Ok. Thanks for sharing it. Happy to carry those patches as part of this
series if you are fine with it.

  Different from your situation we do want
> the device to reclaim the RMR's associated with it on initialization, and=
 I
> am still seeing issues there.  I need to spend more time figuring out why
> this is not working properly.

I am not sure what your requirement is here. So if the kernel driver eventu=
ally
comes up and takes control of the device, you no longer require the bypass/=
identity
mapping for these regions. Is that correct?

Shameer

> -Jon
> =

> >
> > >
> > > >
> > > > I also have initial patches for edk2 and the HoneyComb LX2160a
> > > > ACPI tables adding RMR nodes that partially work with your patches.
> > >
> > > Thanks for the update and good to know that it is useful.
> > >
> > > Shameer
> > >
> > > > This is with basic SMMUv2 support but since you have more experience
> > > > this this I am more than happy to work with you on your patchset.
> > > >
> > > > -Jon
> > > >
> > > >
> > > > >
> > > > > Thanks,
> > > > > Shameer
> > > > > _______________________________________________
> > > > > linux-arm-kernel mailing list
> > > > > linux-arm-kernel(a)lists.infradead.org
> > > > > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============3563555305956501952==--

