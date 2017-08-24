Content-Type: multipart/mixed; boundary="===============8811675045006460680=="
MIME-Version: 1.0
From: Will Deacon <will.deacon at arm.com>
Subject: Re: [Devel] [PATCH v6 3/3] iommu/arm-smmu-v3:Enable ACPI based
 HiSilicon erratum 161010801
Date: Thu, 24 Aug 2017 15:35:37 +0100
Message-ID: <20170824143536.GA8904@arm.com>
In-Reply-To: 53b9795c-6222-9cf0-50dc-9dafbfb67a2c@huawei.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============8811675045006460680==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 23, 2017 at 05:55:52PM +0100, John Garry wrote:
> On 23/08/2017 17:43, Will Deacon wrote:
> >On Wed, Aug 23, 2017 at 03:29:46PM +0100, John Garry wrote:
> >>On 23/08/2017 14:24, Will Deacon wrote:
> >>>On Wed, Aug 23, 2017 at 02:17:24PM +0100, John Garry wrote:
> >>>>>>>Signed-off-by: Shameer Kolothum
> >>>>>><shameerali.kolothum.thodi(a)huawei.com>
> >>>>>>>---
> >>>>>>>drivers/iommu/arm-smmu-v3.c | 27 ++++++++++++++++++++++-----
> >>>>>>>1 file changed, 22 insertions(+), 5 deletions(-)
> >>>>>>
> >>>>>>Please can you also add a devicetree binding with corresponding
> >>>>>>documentation to enable this workaround on non-ACPI based systems t=
oo?
> >>>>>>It should be straightforward if you update the arm_smmu_options tab=
le.
> >>>>>
> >>>>>As I mentioned before, devicetree was a lower priority and we would =
definitely
> >>>>>submit patch to support that. Even if we update the arm_smmu_options=
 table
> >>>>>with DT binding, the generic function to retrieve the MSI address re=
gions only
> >>>>>works on ACPI/IORT case now.
> >>>>>
> >>>>
> >>>>Hi Will,
> >>>>
> >>>>Can you confirm your stance on supporting this workaround for DT as w=
ell as
> >>>>ACPI?
> >>>>
> >>>>For us, we now only "officially" support ACPI FW, and DT support at t=
his
> >>>>point is patchy/limited. To me, adding DT support is just more errata
> >>>>workaround code to maintain with little useful gain.
> >>>
> >>>I basically don't like the idea of a driver that only works for one of
> >>>ACPI or DT yet claims to support both. I'm less fussed about functiona=
lity
> >>>differences (feature X is only available with firmware Y), but not wor=
king
> >>>around a hardware erratum that we know about is just lazy.
> >>>
> >>>So I'd prefer that we handle this in both cases, or blacklist affected
> >>>devices when booting with DT. Continuing as though there isn't an erra=
tum
> >>>is the worst thing we can do.
> >>
> >>OK, seems reasonable.
> >>
> >>We would consider blacklisting the device, where/how to do is the quest=
ion.
> >>
> >>So the errata is in the GICv3 ITS/PCI host controller, and we just use =
the
> >>in-between SMMU (driver) to provide the workaround. So my initial impre=
ssion
> >>is that the PCI host controller would have to be blacklisted IFF behind=
 an
> >>IOMMU for DT firmware in pcie-hisi.c or pci quirks framework. How does =
it
> >>sound?
> >
> >If that avoids us running into the erratum, then fine by me. I'd obvious=
ly
> >prefer we work-around it since we know how to, but that's up to you.
> =

> I'm surpsised that you may want more errata workaround code to maintain.
> =

> Anyway we'll check both approaches and show you how they look and go from
> there.

Don't get me wrong, I don't dream about adding errata workarounds to the
code, but our job as an operating system is to abstract the hardware from
the user, which means dealing with its quirks whether we like it or not.

Thanks,

Will

--===============8811675045006460680==--

