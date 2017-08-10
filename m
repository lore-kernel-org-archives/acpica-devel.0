Content-Type: multipart/mixed; boundary="===============0679750318659896126=="
MIME-Version: 1.0
From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi at huawei.com>
Subject: Re: [Devel] [PATCH v6 3/3] iommu/arm-smmu-v3:Enable ACPI based
 HiSilicon erratum 161010801
Date: Thu, 10 Aug 2017 17:52:01 +0000
Message-ID: <5FC3163CFD30C246ABAA99954A238FA8383CC287@FRAEML521-MBX.china.huawei.com>
In-Reply-To: 20170810172723.GD9980@arm.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============0679750318659896126==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Will,

> -----Original Message-----
> From: Will Deacon [mailto:will.deacon(a)arm.com]
> Sent: Thursday, August 10, 2017 6:27 PM
> To: Shameerali Kolothum Thodi
> Cc: lorenzo.pieralisi(a)arm.com; marc.zyngier(a)arm.com;
> sudeep.holla(a)arm.com; robin.murphy(a)arm.com; hanjun.guo(a)linaro.org;
> Gabriele Paoloni; John Garry; iommu(a)lists.linux-foundation.org; linux-a=
rm-
> kernel(a)lists.infradead.org; linux-acpi(a)vger.kernel.org; devel(a)acpic=
a.org;
> Linuxarm; Wangzhou (B); Guohanjun (Hanjun Guo)
> Subject: Re: [PATCH v6 3/3] iommu/arm-smmu-v3:Enable ACPI based
> HiSilicon erratum 161010801
> =

> On Wed, Aug 09, 2017 at 11:07:15AM +0100, Shameer Kolothum wrote:
> > The HiSilicon erratum 161010801 describes the limitation of HiSilicon
> > platforms Hip06/Hip07 to support the SMMU mappings for MSI
> transactions.
> >
> > On these platforms GICv3 ITS translator is presented with the deviceID
> > by extending the MSI payload data to 64 bits to include the deviceID.
> > Hence, the PCIe controller on this platforms has to differentiate the
> > MSI payload against other DMA payload and has to modify the MSI
> payload.
> > This basically makes it difficult for this platforms to have a SMMU
> > translation for MSI.
> >
> > This patch implements a ACPI table based quirk to reserve the hw msi
> > regions in the smmu-v3 driver which means these address regions will
> > not be translated and will be excluded from iova allocations.
> >
> > Signed-off-by: Shameer Kolothum
> <shameerali.kolothum.thodi(a)huawei.com>
> > ---
> >  drivers/iommu/arm-smmu-v3.c | 27 ++++++++++++++++++++++-----
> >  1 file changed, 22 insertions(+), 5 deletions(-)
> =

> Please can you also add a devicetree binding with corresponding
> documentation to enable this workaround on non-ACPI based systems too?
> It should be straightforward if you update the arm_smmu_options table.

As I mentioned before, devicetree was a lower priority and we would definit=
ely
submit patch to support that. Even if we update the arm_smmu_options table
with DT binding, the generic function to retrieve the MSI address regions o=
nly
works on ACPI/IORT case now.

Moreover I am on holidays starting tomorrow, and really appreciate if this =
series
can go through now.

Please let me know.

Thanks,
Shameer

--===============0679750318659896126==--

