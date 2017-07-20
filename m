Content-Type: multipart/mixed; boundary="===============1508562232044757367=="
MIME-Version: 1.0
From: Robin Murphy <robin.murphy at arm.com>
Subject: Re: [Devel] [PATCH v3 2/2] iommu/arm-smmu-v3:Enable ACPI based
 HiSilicon erratum 161010801
Date: Thu, 20 Jul 2017 15:31:39 +0100
Message-ID: <f3ba9136-068a-280d-2849-f3a0081c1d90@arm.com>
In-Reply-To: 5FC3163CFD30C246ABAA99954A238FA8383B9D5A@FRAEML521-MBX.china.huawei.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============1508562232044757367==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 19/07/17 11:48, Shameerali Kolothum Thodi wrote:
> =

> =

>> -----Original Message-----
>> From: Will Deacon [mailto:will.deacon(a)arm.com]
>> Sent: Friday, July 14, 2017 8:33 PM
>> To: Shameerali Kolothum Thodi
>> Cc: lorenzo.pieralisi(a)arm.com; marc.zyngier(a)arm.com;
>> sudeep.holla(a)arm.com; robin.murphy(a)arm.com; hanjun.guo(a)linaro.org;
>> Gabriele Paoloni; John Garry; Linuxarm; linux-acpi(a)vger.kernel.org;
>> iommu(a)lists.linux-foundation.org; Wangzhou (B); Guohanjun (Hanjun Guo);
>> linux-arm-kernel(a)lists.infradead.org; devel(a)acpica.org
>> Subject: Re: [PATCH v3 2/2] iommu/arm-smmu-v3:Enable ACPI based
>> HiSilicon erratum 161010801
>>
> [...]
>>>>> -	list_add_tail(&region->list, head);
>>>>> +	if ((smmu->options & ARM_SMMU_OPT_RESV_HW_MSI)) {
>>>>> +
>>>>> +		if (!is_of_node(smmu->dev->fwnode))
>>>>> +			resv =3D iort_iommu_its_get_resv_regions(dev, head);
>>>>
>>>> How does this work when we're not using ACPI? Shouldn't of vs ACPI
>>>> be abstracted from the driver?
>>>
>>> At present ARM_SMMU_OPT_RESV_HW_MSI is only set for ACPI and  DT
>>> support for this is a low priority for us at the moment. Is the
>>> suggestion is to have a common function outside the smmu driver for
>>> _iommu_its_get_resv_regions() ? I am not sure what is the best way here.
>>
>> Right, something like that. The driver shouldn't need to care whether or=
 not
>> it's using ACPI or DT when setting these options.
> =

> Below is what I have in mind for the common function for msi reserve.
> But just wondering invoking iort_ functions from iommu code =

> is acceptable or not . Could you please take a look and let me know.

At that point, it seems like we might as well just roll it into
iommu_dma_get_resv_regions() directly[1]. It probably makes sense for
any DT equivalent to be described generically, rather than
SMMU-specific, so parsing that would fit into common code as well.

Then in the SMMU drivers we can skip creating the SW_MSI region if
iommu-dma gave us back any real ones (and remove the apparently
unnecessary resv_msi check in VFIO). Or be lazy and just leave it, as it
doesn't seem to do much harm to have both.

Robin.

[1] This is what I hacked up locally on top of patch #1:
----->8-----
diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 9d1cebe7f6cb..50292827da49 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -19,6 +19,7 @@
  * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  */

+#include <linux/acpi_iort.h>
 #include <linux/device.h>
 #include <linux/dma-iommu.h>
 #include <linux/gfp.h>
@@ -174,6 +175,10 @@ void iommu_dma_get_resv_regions(struct device *dev,
struct list_head *list)
 	struct pci_host_bridge *bridge;
 	struct resource_entry *window;

+	if (!is_of_node(dev->iommu_fwspec->iommu_fwnode) &&
+		iort_iommu_its_get_resv_regions(dev, list) < 0)
+		return;
+
 	if (!dev_is_pci(dev))
 		return;


--===============1508562232044757367==--

