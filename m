Content-Type: multipart/mixed; boundary="===============7495952221615346633=="
MIME-Version: 1.0
From: Will Deacon <will.deacon at arm.com>
Subject: Re: [Devel] [PATCH v6 3/3] iommu/arm-smmu-v3:Enable ACPI based
 HiSilicon erratum 161010801
Date: Wed, 23 Aug 2017 14:24:30 +0100
Message-ID: <20170823132430.GB634@arm.com>
In-Reply-To: c6b7c641-b839-1388-7982-366e796e6ba9@huawei.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============7495952221615346633==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 23, 2017 at 02:17:24PM +0100, John Garry wrote:
> >>>Signed-off-by: Shameer Kolothum
> >><shameerali.kolothum.thodi(a)huawei.com>
> >>>---
> >>> drivers/iommu/arm-smmu-v3.c | 27 ++++++++++++++++++++++-----
> >>> 1 file changed, 22 insertions(+), 5 deletions(-)
> >>
> >>Please can you also add a devicetree binding with corresponding
> >>documentation to enable this workaround on non-ACPI based systems too?
> >>It should be straightforward if you update the arm_smmu_options table.
> >
> >As I mentioned before, devicetree was a lower priority and we would defi=
nitely
> >submit patch to support that. Even if we update the arm_smmu_options tab=
le
> >with DT binding, the generic function to retrieve the MSI address region=
s only
> >works on ACPI/IORT case now.
> >
> =

> Hi Will,
> =

> Can you confirm your stance on supporting this workaround for DT as well =
as
> ACPI?
> =

> For us, we now only "officially" support ACPI FW, and DT support at this
> point is patchy/limited. To me, adding DT support is just more errata
> workaround code to maintain with little useful gain.

I basically don't like the idea of a driver that only works for one of
ACPI or DT yet claims to support both. I'm less fussed about functionality
differences (feature X is only available with firmware Y), but not working
around a hardware erratum that we know about is just lazy.

So I'd prefer that we handle this in both cases, or blacklist affected
devices when booting with DT. Continuing as though there isn't an erratum
is the worst thing we can do.

Will

--===============7495952221615346633==--

