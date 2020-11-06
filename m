Content-Type: multipart/mixed; boundary="===============7280179639118200186=="
MIME-Version: 1.0
From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi at huawei.com>
Subject: [Devel] Re: [RFC PATCH 0/4] ACPI/IORT: Support for IORT RMR node
Date: Fri, 06 Nov 2020 16:17:54 +0000
Message-ID: <ad2f8ea7821f4b728ab32b61e4a6121e@huawei.com>
In-Reply-To: ca4a8e2d-40d9-b08d-7ec9-6a50d37f9126@arm.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============7280179639118200186==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



> -----Original Message-----
> From: Steven Price [mailto:steven.price(a)arm.com]
> Sent: 06 November 2020 15:22
> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi(a)huawei.com>;
> linux-arm-kernel(a)lists.infradead.org; linux-acpi(a)vger.kernel.org;
> iommu(a)lists.linux-foundation.org; devel(a)acpica.org
> Cc: lorenzo.pieralisi(a)arm.com; joro(a)8bytes.org; Jonathan Cameron
> <jonathan.cameron(a)huawei.com>; Linuxarm <linuxarm(a)huawei.com>;
> Guohanjun (Hanjun Guo) <guohanjun(a)huawei.com>; Sami Mujawar
> <Sami.Mujawar(a)arm.com>; robin.murphy(a)arm.com; wanghuiqiang
> <wanghuiqiang(a)huawei.com>
> Subject: Re: [RFC PATCH 0/4] ACPI/IORT: Support for IORT RMR node
> =

> On 28/10/2020 18:24, Shameerali Kolothum Thodi wrote:
> > Hi Steve,
> >
> >> -----Original Message-----
> >> From: Steven Price [mailto:steven.price(a)arm.com]
> >> Sent: 28 October 2020 16:44
> >> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi(a)huawei.com>;
> >> linux-arm-kernel(a)lists.infradead.org; linux-acpi(a)vger.kernel.org;
> >> iommu(a)lists.linux-foundation.org; devel(a)acpica.org
> >> Cc: lorenzo.pieralisi(a)arm.com; joro(a)8bytes.org; Jonathan Cameron
> >> <jonathan.cameron(a)huawei.com>; Linuxarm <linuxarm(a)huawei.com>;
> >> Guohanjun (Hanjun Guo) <guohanjun(a)huawei.com>;
> robin.murphy(a)arm.com;
> >> wanghuiqiang <wanghuiqiang(a)huawei.com>; Sami Mujawar
> >> <Sami.Mujawar(a)arm.com>
> >> Subject: Re: [RFC PATCH 0/4] ACPI/IORT: Support for IORT RMR node
> >>
> >> On 27/10/2020 11:26, Shameer Kolothum wrote:
> >>> The series adds support to IORT RMR nodes specified in IORT
> >>> Revision E -ARM DEN 0049E[0]. RMR nodes are=C2=A0used to=C2=A0describ=
e memory
> >>> ranges that are used by endpoints and require a unity mapping
> >>> in SMMU.
> >>
> >> Hi Shameer,
> >>
> >> I've also been taking a look at RMR, and Sami is helping me get set up
> >> so that I can do some testing. We're hoping to be able to test an EFI
> >> framebuffer or splash screen - which has the added complication of the
> >> unity mapping becoming redundant if a native display driver takes over
> >> the display controller.
> >>
> >> I've looked through your series and the code looks correct to me.
> >
> > Thanks for taking a look and the details.
> >
> >> Hopefully I'll be able to give it some testing soon.
> >
> > Cool. Please update once you get a chance run the tests.
> =

> Hi Shameer,

Hi Steve,

> Just to update on this, for the EFI framebuffer use case I hit exactly
> the issue that Robin has mentioned in another thread - the RMR is
> effectively ignored because the display controller isn't being handled
> by Linux (so there's no device to link it to).

Thanks for the update. Here, by "ignored "you meant get_resv_regions()
is not called or not?

 The splash screen might
> similarly flicker as the SMMU reset will initially block the traffic
> before the RMR region is enabled.

Does that mean you somehow managed to make the unity
mapping but there was flicker during the SMMU reset to
unity mapping setup period. Sorry I am trying to understand
the exact behavior observed in this case.

Thanks,
Shameer

--===============7280179639118200186==--

