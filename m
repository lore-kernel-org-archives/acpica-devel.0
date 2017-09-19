Content-Type: multipart/mixed; boundary="===============7211133590173227259=="
MIME-Version: 1.0
From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi at huawei.com>
Subject: Re: [Devel] [PATCH v7 1/5] Doc: iommu/arm-smmu-v3: Add workaround for
 HiSilicon erratum 161010801
Date: Tue, 19 Sep 2017 16:09:33 +0000
Message-ID: <5FC3163CFD30C246ABAA99954A238FA838411AD3@FRAEML521-MBX.china.huawei.com>
In-Reply-To: 20170919145314.2irmqpsfneeydupo@rob-hp-laptop
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============7211133590173227259==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



> -----Original Message-----
> From: Rob Herring [mailto:robh(a)kernel.org]
> Sent: Tuesday, September 19, 2017 3:53 PM
> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi(a)huawei.com>
> Cc: lorenzo.pieralisi(a)arm.com; marc.zyngier(a)arm.com;
> sudeep.holla(a)arm.com; will.deacon(a)arm.com; robin.murphy(a)arm.com;
> joro(a)8bytes.org; mark.rutland(a)arm.com; hanjun.guo(a)linaro.org; Gabri=
ele
> Paoloni <gabriele.paoloni(a)huawei.com>; John Garry
> <john.garry(a)huawei.com>; iommu(a)lists.linux-foundation.org; linux-arm-
> kernel(a)lists.infradead.org; linux-acpi(a)vger.kernel.org;
> devicetree(a)vger.kernel.org; devel(a)acpica.org; Linuxarm
> <linuxarm(a)huawei.com>; Wangzhou (B) <wangzhou1(a)hisilicon.com>;
> Guohanjun (Hanjun Guo) <guohanjun(a)huawei.com>
> Subject: Re: [PATCH v7 1/5] Doc: iommu/arm-smmu-v3: Add workaround for
> HiSilicon erratum 161010801
> =

> On Thu, Sep 14, 2017 at 01:57:52PM +0100, Shameer Kolothum wrote:
> > From: John Garry <john.garry(a)huawei.com>
> >
> > The HiSilicon erratum 161010801 describes the limitation of HiSilicon
> platforms
> > hip06/hip07 to support the SMMU mappings for MSI transactions.
> >
> > On these platforms, GICv3 ITS translator is presented with the deviceID
> > by extending the MSI payload data to 64 bits to include the deviceID.
> > Hence, the PCIe controller on this platforms has to differentiate the M=
SI
> > payload against other DMA payload and has to modify the MSI payload.
> > This basically makes it difficult for this platforms to have a SMMU
> > translation for MSI.
> >
> > This patch adds a SMMUv3 binding to flag that the SMMU breaks msi
> > translation at ITS.
> >
> > Also, the arm64 silicon errata is updated with this same erratum.
> >
> > Signed-off-by: John Garry <john.garry(a)huawei.com>
> > Signed-off-by: Shameer Kolothum
> <shameerali.kolothum.thodi(a)huawei.com>
[...]
> > --- a/Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt
> > +++ b/Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt
> > @@ -55,6 +55,9 @@ the PCIe specification.
> >  - hisilicon,broken-prefetch-cmd
> >                      : Avoid sending CMD_PREFETCH_* commands to the SMM=
U.
> >
> > +- hisilicon,broken-untranslated-msi
> > +                    : Reserve ITS HW region to avoid translating msi.
> > +
> =

> This should be determined from the compatible string. Continuing to add
> properties for each errata doesn't scale.

Ok. I think the suggestion here is to follow the arm-smmu.c (SMMUv1/v2) =

driver way of implementing the errata. As you might have noticed,  the =

SMMUv3 driver dt errata framework depends on properties  and this will
change the way errata is implemented in the driver now.

Hi Will/Robin,
Could you please take a look and let us know your thoughts on changing
the SMMUv3 dt errata implementation to version/model/compatible string
framework for this quirk.

Thanks,
Shameer

--===============7211133590173227259==--

