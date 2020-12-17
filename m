Content-Type: multipart/mixed; boundary="===============5435010742857509006=="
MIME-Version: 1.0
From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi at huawei.com>
Subject: [Devel] Re: [RFC PATCH v2 0/8] ACPI/IORT: Support for IORT RMR node
Date: Thu, 17 Dec 2020 15:42:24 +0000
Message-ID: <93c22f3c57c042c39871a0fd3a2eaa0e@huawei.com>
In-Reply-To: CABdtJHvoWCE4Zd5gTf4wbAKtriWRFx6y1CSH0taVxMmEf7tweg@mail.gmail.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============5435010742857509006==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



> -----Original Message-----
> From: Jon Nettleton [mailto:jon(a)solid-run.com]
> Sent: 17 December 2020 14:48
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

> On Mon, Dec 14, 2020 at 3:48 PM Shameerali Kolothum Thodi
> <shameerali.kolothum.thodi(a)huawei.com> wrote:
> >
> >
> >
> > > -----Original Message-----
> > > From: Steven Price [mailto:steven.price(a)arm.com]
> > > Sent: 14 December 2020 13:43
> > > To: Robin Murphy <robin.murphy(a)arm.com>; Shameerali Kolothum Thodi
> > > <shameerali.kolothum.thodi(a)huawei.com>;
> > > linux-arm-kernel(a)lists.infradead.org; linux-acpi(a)vger.kernel.org;
> > > iommu(a)lists.linux-foundation.org; devel(a)acpica.org
> > > Cc: Linuxarm <linuxarm(a)huawei.com>; lorenzo.pieralisi(a)arm.com;
> > > joro(a)8bytes.org; wanghuiqiang <wanghuiqiang(a)huawei.com>; Guohanjun
> > > (Hanjun Guo) <guohanjun(a)huawei.com>; Jonathan Cameron
> > > <jonathan.cameron(a)huawei.com>; Sami.Mujawar(a)arm.com
> > > Subject: Re: [RFC PATCH v2 0/8] ACPI/IORT: Support for IORT RMR node
> > >
> > > On 14/12/2020 12:33, Robin Murphy wrote:
> > > > On 2020-12-14 10:55, Shameerali Kolothum Thodi wrote:
> > > >> Hi Steve,
> > > >>
> > > >>> -----Original Message-----
> > > >>> From: Steven Price [mailto:steven.price(a)arm.com]
> > > >>> Sent: 10 December 2020 10:26
> > > >>> To: Shameerali Kolothum Thodi
> > > <shameerali.kolothum.thodi(a)huawei.com>;
> > > >>> linux-arm-kernel(a)lists.infradead.org; linux-acpi(a)vger.kernel.=
org;
> > > >>> iommu(a)lists.linux-foundation.org; devel(a)acpica.org
> > > >>> Cc: Linuxarm <linuxarm(a)huawei.com>; lorenzo.pieralisi(a)arm.com;
> > > >>> joro(a)8bytes.org; robin.murphy(a)arm.com; wanghuiqiang
> > > >>> <wanghuiqiang(a)huawei.com>; Guohanjun (Hanjun Guo)
> > > >>> <guohanjun(a)huawei.com>; Jonathan Cameron
> > > >>> <jonathan.cameron(a)huawei.com>; Sami.Mujawar(a)arm.com
> > > >>> Subject: Re: [RFC PATCH v2 0/8] ACPI/IORT: Support for IORT RMR n=
ode
> > > >>>
> > > >>> On 19/11/2020 12:11, Shameer Kolothum wrote:
> > > >>>> RFC v1 --> v2:
> > > >>>>    - Added a generic interface for IOMMU drivers to retrieve all=
 the
> > > >>>>      RMR info associated with a given IOMMU.
> > > >>>>    - SMMUv3 driver gets the RMR list during probe() and installs
> > > >>>>      bypass STEs for all the SIDs in the RMR list. This is to ke=
ep
> > > >>>>      the ongoing traffic alive(if any) during SMMUv3 reset. This=
 is
> > > >>>>      based on the suggestions received for v1 to take care of the
> > > >>>>      EFI framebuffer use case. Only sanity tested for now.
> > > >>>
> > > >>> Hi Shameer,
> > > >>>
> > > >>> Sorry for not looking at this before.
> > > >>>
> > > >>> Do you have any plans to implement support in the SMMUv2 driver?
> The
> > > >>> platform I've been testing the EFI framebuffer support on has the
> > > >>> display controller behind SMMUv2, so as it stands this series doe=
sn't
> > > >>> work. I did hack something up for SMMUv2 so I was able to test the
> first
> > > >>> 4 patches.
> > > >>
> > > >> Thanks for taking a look. Sure, I can look into adding the support=
 for
> > > >> SMMUv2.
> > >
> > > Great, thanks!
> > >
> > > >>>
> > > >>>>    - During the probe/attach device, SMMUv3 driver reserves any
> > > >>>>      RMR region associated with the device such that there is a
> unity
> > > >>>>      mapping for them in SMMU.
> > > >>>
> > > >>> For the EFI framebuffer use case there is no device to attach so I
> > > >>> believe we are left with just the stream ID in bypass mode - whic=
h is
> > > >>> definitely an improvement (the display works!)
> > > >>
> > > >> Cool. That=E2=80=99s good to know.
> > > >>
> > > >>   but not actually a unity
> > > >>> mapping of the RMR range. I'm not sure whether it's worth fixing =
this
> or
> > > >>> not, but I just wanted to point out there's still a need for a dr=
iver
> > > >>> for the device before the bypass mode is replaced with the unity
> > > >>> mapping.
> > > >>
> > > >> I am not sure either. My idea was we will have bypass STE setup for
> > > >> all devices
> > > >> with RMR initially and when the corresponding driver takes over(if
> > > >> that happens)
> > > >> we will have the unity mapping setup properly for the RMR regions.=
 And
> > > >> for cases
> > > >> like the above, it will remain in the bypass mode.
> > > >>
> > > >> Do you see any problem(security?) if the dev streams remain in byp=
ass
> > > >> mode for
> > > >> this dev? Or is it possible to have a stub driver for this dev, so
> > > >> that we will have
> > > >> the probe/attach invoked and everything will fall in place?
> > > >
> > > > The downside is that if a driver never binds to that device, it rem=
ains
> > > > bypassed. If some other externally-controlled malicious device could
> > > > manage to spoof that device's requester ID, that could potentially =
be
> > > > exploited.
> > > >
> > > >> TBH, I haven't looked into creating a temp domain for these types =
of
> > > >> the devices
> > > >> and also not sure how we benefit from that compared to the STE byp=
ass
> > > >> mode.
> > > >
> > > > That said, setting up temporary translation contexts that ensure any
> > > > access can *only* be to RMR regions until a driver takes over is an
> > > > awful lot more work. I'm inclined to be pragmatic here and say we s=
hould
> > > > get things working at all with the simple bypass STE/S2CR method, t=
hen
> > > > look at adding the higher-security effort on top.
> > > >
> > > > Right now systems that need this are either broken (but effectively
> > > > secure) or using default bypass with SMMUv2. People who prefer to
> > > > maintain security over functionality in the interim can maintain th=
at
> > > > status quo by simply continuing to not describe any RMRs.
> > >
> > > I agree with Robin, let's get this working with the bypass mode (until
> > > the device binds) like you've currently got. It's much better than wh=
at
> > > we have otherwise. Then once that is merged we can look at the tempor=
ary
> > > translation context or stub driver. The temporary translation context
> > > would be 'neatest', but I'm only aware of the EFI framebuffer use case
> > > and for that it might be possible to do something simpler - if indeed
> > > anything is needed at all. I'm not sure how much we need to be worried
> > > about malicious devices spoofing requester IDs.
> >
> > Perfect. I will keep the STE bypass and respin the series once the upda=
te
> > to the IORT rev E is made public(hope that will happen soon). In the
> > meantime, appreciate any feedback on the rest of the patches in this se=
ries.
> =

> Shameer,

Hi Jon,

> =

> I am pretty sure rev E is already public.  You can find it here.
> =

> https://developer.arm.com/documentation/den0049/latest/
> =

> It is also marked non-confidential.

Yes, Rev E is already out there. But I am told that ARM folks are working on
some updates to the IORT spec, especially around the RMR topic. Hopefully
it will be out soon.
 =

> =

> I also have initial patches for edk2 and the HoneyComb LX2160a
> ACPI tables adding RMR nodes that partially work with your patches.

Thanks for the update and good to know that it is useful.

Shameer

> This is with basic SMMUv2 support but since you have more experience
> this this I am more than happy to work with you on your patchset.
> =

> -Jon
> =

> =

> >
> > Thanks,
> > Shameer
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel(a)lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============5435010742857509006==--

