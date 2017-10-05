Content-Type: multipart/mixed; boundary="===============7398997012217374305=="
MIME-Version: 1.0
From: Robin Murphy <robin.murphy at arm.com>
Subject: Re: [Devel] [PATCH v8 3/5] iommu/of: Add msi address regions
 reservation helper
Date: Thu, 05 Oct 2017 13:44:49 +0100
Message-ID: <cd4d3ad0-317e-6b7b-c5f4-f4e6eac3ee10@arm.com>
In-Reply-To: d525f112-fb20-d14b-bea0-6547c8b933dd@huawei.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============7398997012217374305==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 05/10/17 13:37, John Garry wrote:
> On 05/10/2017 12:07, Robin Murphy wrote:
>> On 04/10/17 14:50, Lorenzo Pieralisi wrote:
>>> On Wed, Oct 04, 2017 at 12:22:04PM +0100, Marc Zyngier wrote:
>>>> On 27/09/17 14:32, Shameer Kolothum wrote:
>>>>> From: John Garry <john.garry(a)huawei.com>
>>>>>
>>>>> On some platforms msi-controller address regions have to be excluded
>>>>> from normal IOVA allocation in that they are detected and decoded in
>>>>> a HW specific way by system components and so they cannot be
>>>>> considered
>>>>> normal IOVA address space.
>>>>>
>>>>> Add a helper function that retrieves msi address regions through
>>>>> device
>>>>> tree msi mapping, so that these regions will not be translated by
>>>>> IOMMU
>>>>> and will be excluded from IOVA allocations.
>>>>>
>>>>> Signed-off-by: John Garry <john.garry(a)huawei.com>
>>>>> [Shameer: Modified msi-parent retrieval logic]
>>>>> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi(a)huawei.c=
om>
>>>>> ---
>>>>> =C2=A0drivers/iommu/of_iommu.c | 95
>>>>> ++++++++++++++++++++++++++++++++++++++++++++++++
>>>>> =C2=A0include/linux/of_iommu.h | 10 +++++
>>>>> =C2=A02 files changed, 105 insertions(+)
>>>>>
>>>>> diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
>>>>> index e60e3db..ffd7fb7 100644
>>>>> --- a/drivers/iommu/of_iommu.c
>>>>> +++ b/drivers/iommu/of_iommu.c
>>>>> @@ -21,6 +21,7 @@
>>>>> =C2=A0#include <linux/iommu.h>
>>>>> =C2=A0#include <linux/limits.h>
>>>>> =C2=A0#include <linux/of.h>
>>>>> +#include <linux/of_address.h>
>>>>> =C2=A0#include <linux/of_iommu.h>
>>>>> =C2=A0#include <linux/of_pci.h>
>>>>> =C2=A0#include <linux/slab.h>
>>>>> @@ -138,6 +139,14 @@ static int of_iommu_xlate(struct device *dev,
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 return ops->of_xlate(dev, iommu_spec);
>>>>> =C2=A0}
>>>>>
>>>>> +static int __get_pci_rid(struct pci_dev *pdev, u16 alias, void *data)
>>>>> +{
>>>>> +=C2=A0=C2=A0=C2=A0 u32 *rid =3D data;
>>>>> +
>>>>> +=C2=A0=C2=A0=C2=A0 *rid =3D alias;
>>>>> +=C2=A0=C2=A0=C2=A0 return 0;
>>>>> +}
>>>>> +
>>>>> =C2=A0struct of_pci_iommu_alias_info {
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 struct device *dev;
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 struct device_node *np;
>>>>> @@ -163,6 +172,73 @@ static int of_pci_iommu_init(struct pci_dev
>>>>> *pdev, u16 alias, void *data)
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 return info->np =3D=3D pdev->bus->dev.of_nod=
e;
>>>>> =C2=A0}
>>>>>
>>>>> +static int of_iommu_alloc_resv_region(struct device_node *np,
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct list_he=
ad *head)
>>>>> +{
>>>>> +=C2=A0=C2=A0=C2=A0 int prot =3D IOMMU_WRITE | IOMMU_NOEXEC | IOMMU_M=
MIO;
>>>>> +=C2=A0=C2=A0=C2=A0 struct iommu_resv_region *region;
>>>>> +=C2=A0=C2=A0=C2=A0 struct resource res;
>>>>> +=C2=A0=C2=A0=C2=A0 int err;
>>>>> +
>>>>> +=C2=A0=C2=A0=C2=A0 err =3D of_address_to_resource(np, 0, &res);
>>>>
>>>> What is the rational for registering the first region only? Surely you
>>>> can have more than one region in an MSI controller (yes, your
>>>> particular
>>>> case is the ITS which has only one, but we're trying to do something
>>>> generic here).
>>>>
>>>> Another issue I have with this code is that it inserts all of the ITS
>>>> MMIO in the RESV_MSI range. As long as we don't generate any page
>>>> tables
>>>> for this, we're fine. But if we ever change this, we'll end-up with the
>>>> ITS programming interface being exposed to a device, which wouldn't be
>>>> acceptable.
>>>>
>>>> Why can't we have some generic property instead, that would describe
>>>> the
>>>> actual ranges that cannot be translated? That way, no random insertion
>>>> of a random range, and relatively future proof.
>>
>> Indeed. Furthermore, IORT has the advantage of being limited to a few
>> distinct device types and SBSA-compliant system topologies, so the
>> ITS-chasing is reasonable there (modulo only reserving GITS_TRANSLATER).
>> The scope of DT covers more embedded things as well like PCI host
>> controllers with internal MSI doorbells, and potentially even
>> direct-mapped memory regions for things like bootloader framebuffers to
>> prevent display glitches - a generic address/size/flags description of a
>> region could work for just about everything.
>>
>>> IORT code has the same issue (ie it reserves all ITS regions) and I do
>>> not know where a property can be added to describe those ranges (IORT
>>> specs ? I'd rather not) in ACPI other than the IORT tables entries
>>> themselves.
>>>
>>>> I'm not sure where to declare it (PCIe node? IOMMU node?), but it'd
>>>> feel
>>>> like a much nicer and simpler solution to this problem.
>>>
>>> It could be but if we throw ACPI into the picture we have to knock
>>> together Hisilicon specific namespace bindings to handle this and
>>> quickly.
>>
>> As above I'm happy with the ITS-specific solution for ACPI given the
>> limits of IORT. What I had in mind for DT was something tied in with the
>> generic IOMMU bindings. Something like this is probably easiest to
>> handle, but does rather spread the information around:
>>
>>
>> =C2=A0 pci {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ...
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iommu-map =3D <0 0 &iommu1 0x10000>;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iommu-reserved-ranges =3D <0x12340000 0x1=
000 IOMMU_MSI>,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <0x34560000 0x1000 IOMMU_MSI>;
>> =C2=A0 };
>>
>> =C2=A0 display {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ...
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iommus =3D <&iommu1 0x20000>;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* simplefb region */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iommu-reserved-ranges =3D <0x80080000 0x8=
0000 IOMMU_DIRECT>,
>> =C2=A0 };
>>
>>
>> Alternatively, something inspired by reserved-memory might perhaps be
>> conceptually neater, at the risk of being more complicated:
>>
>>
>> =C2=A0 iommu1: iommu(a)acbd0000 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ...
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #iommu-cells =3D <1>;
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iommu-reserved-ranges {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #address-cells =
=3D <1>;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #size-cells =3D <=
1>;
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 its0_resv: msi(a)12340000 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 compatible =3D "iommu-msi-region";
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 reg =3D <0x12340000 0x1000>;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 its1_resv: msi(a)34560000 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 compatible =3D "iommu-msi-region";
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 reg =3D <0x34560000 0x1000>;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fb_resv: direct(a)12340000 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 compatible =3D "iommu-direct-region";
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 reg =3D <0x80080000 0x80000>;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
>> =C2=A0 };
>>
>>
> =

> If we did this, wouldn't it be easier to create dangerous reserved
> regions, like our ITS region which Marc was concerned by? It's not so
> hard to get dts changes into the kernel.

Well, yeah. It's also equally easy to add some peripheral register
region to the /memory node and watch hilarity ensue. The solution to
both is "don't put bogus crap in your DT".

There's a big difference between wilfully misdescribing your platform
requirements vs. having the kernel automagically infer something but
leave a hole open in the process.

Robin.

--===============7398997012217374305==--

