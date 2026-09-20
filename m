Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF2C217B50F;
	Sun, 20 Sep 2026 01:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789867501; cv=none; b=rOVE/+tbjBNbuD56hknPHZI78oZNGoZNexhMSy4erS2JapLsr6ZHGTFJWQwQOZ2jtJJwdxbB8obLn9WXR1FG2mZuQyNPz4ZsaPQZeyqZcwnblMLtfbPXDJcaAF1j0+PlpcK5ewZ+YwWTvB0CyIW+M9yjjlmP9C6nW4WM0c4rpeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789867501; c=relaxed/simple;
	bh=BLZqgEKMZulumIXHwo5OONAHNHGNMK4rnHpwl1rxilk=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=onREFivlVY1CVORQjyg+DyxTIat6xQN6ck/UnBMONXuNQzrwz6XA5NUI4FPRgSV1FJQ85tb/8JlUTgRcGg7WPtmnc5QjI0syoCyr+JAAZBz8zqePfucUmfM2PxXCEFBEnKFex79U6tLZ3GT07yeNTKYIT9dIDlCXz3wHRxB7cuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.62])
	by gateway (Coremail) with SMTP id _____8CxQNHfNa9qs84NAA--.40780S3;
	Sun, 20 Sep 2026 09:24:47 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
	by front1 (Coremail) with SMTP id qMiowJAxmM3dNa9qXc0iAA--.7671S2;
	Sun, 20 Sep 2026 09:24:46 +0800 (CST)
Subject: Re: [PATCH v3 3/4] ACPI: scan: Add support for LoongArch in
 acpi_iommu_configure_id()
To: Huacai Chen <chenhuacai@kernel.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
 Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
 Pawel Chmielewski <pawel.chmielewski@intel.com>, Len Brown
 <lenb@kernel.org>, linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
 linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev,
 lixianglai@loongson.cn
References: <20260915032627.2796747-1-maobibo@loongson.cn>
 <20260915032627.2796747-4-maobibo@loongson.cn>
 <CAAhV-H71irZnQ2hYmsewC6_fZEjnwBm6VJVcKqTsjJGW2xZDBA@mail.gmail.com>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <f83f4c74-07c4-237e-de4f-337c39380377@loongson.cn>
Date: Sun, 20 Sep 2026 09:24:22 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CAAhV-H71irZnQ2hYmsewC6_fZEjnwBm6VJVcKqTsjJGW2xZDBA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJAxmM3dNa9qXc0iAA--.7671S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxJFy5XF4fAF1fKw4fZrWDGFX_yoWrZFyrpF
	WvkFW5GFW8Jr17GF13Zry5uF1YqrWv9FW0vry3Kw1xG3sFkr9YyFsrZFyakFykAr4DCa1I
	vF90gF1qkF1UAFXCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Jr0_Gr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4
	xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v2
	6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67
	vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
	wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc4
	0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AK
	xVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr
	1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU24SoDUUU
	U



On 2026/9/19 下午10:18, Huacai Chen wrote:
> Hi, Bibo,
> 
> On Tue, Sep 15, 2026 at 11:34 AM Bibo Mao <maobibo@loongson.cn> wrote:
>>
>> acpi_iommu_configure_id() currently supports only IORT and VIOT. Add
>> support for IOVT as well.
>>
>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
>> Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>
>> ---
>>   drivers/acpi/loongarch/iovt.c | 61 +++++++++++++++++++++++++++++++++++
>>   drivers/acpi/scan.c           |  3 ++
>>   include/linux/acpi_iovt.h     | 13 ++++++++
>>   3 files changed, 77 insertions(+)
>>   create mode 100644 include/linux/acpi_iovt.h
>>
>> diff --git a/drivers/acpi/loongarch/iovt.c b/drivers/acpi/loongarch/iovt.c
>> index 302ca6a75905..df14ce48eac6 100644
>> --- a/drivers/acpi/loongarch/iovt.c
>> +++ b/drivers/acpi/loongarch/iovt.c
>> @@ -1,6 +1,7 @@
>>   // SPDX-License-Identifier: GPL-2.0-only
>>
>>   #include <linux/acpi.h>
>> +#include <linux/acpi_iovt.h>
>>   #include <linux/pci.h>
>>   #include "init.h"
>>
>> @@ -217,3 +218,63 @@ void __init acpi_iovt_late_init(void)
>>          iovt_init_devices(hdr);
>>          acpi_put_table(hdr);
>>   }
>> +
>> +static int iovt_pci_dev_iommu_init(struct pci_dev *pdev, u16 dev_id, void *data)
>> +{
>> +       u32 sbdf;
>> +       struct iovt_fwnode *np;
>> +       struct device *aliased_dev = data;
>> +       u32 domain = pci_domain_nr(pdev->bus);
>> +       struct iovt_device_entry *entry;
>> +       bool found = false;
>> +
>> +       list_for_each_entry(np, &iovt_fwnode_list, list) {
>> +               if (domain != np->segment)
>> +                       continue;
>> +
>> +               /* We're not translating ourself */
>> +               if (dev_id == np->devid)
>> +                       return -EINVAL;
>> +
>> +               if (np->flag & ACPI_IOVT_IOMMU_MAGAGE_BY_SEGMENT) {
>> +                       found = true;
>> +                       break;
>> +               }
>> +
>> +               list_for_each_entry(entry, &np->ep_list, list) {
>> +                       if (dev_id < entry->start_devid)
>> +                               continue;
>> +
>> +                       if (dev_id > entry->end_devid)
>> +                               continue;
>> +
>> +                       found = true;
>> +                       break;
>> +               }
>> +
>> +               if (found)
>> +                       break;
>> +       }
>> +
>> +       if (!found)
>> +               return -ENODEV;
>> +
>> +       sbdf = (domain << 16) + dev_id;
>> +       return acpi_iommu_fwspec_init(aliased_dev, sbdf, np->fwnode);
>> +}
>> +
>> +/*
>> + * iovt_iommu_configure_id - Set-up IOMMU configuration for a device.
>> + *
>> + * @dev: device to configure
>> + * @id_in: optional input id const value pointer
>> + *
>> + * Returns: 0 on success, <0 on failure
>> + */
>> +int iovt_iommu_configure_id(struct device *dev, const u32 *id_in)
>> +{
>> +       if (!dev_is_pci(dev))
>> +               return -ENODEV;
>> +
>> +       return pci_for_each_dma_alias(to_pci_dev(dev), iovt_pci_dev_iommu_init, dev);
>> +}
>> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
>> index 163a3cccf197..f2f155a65ea9 100644
>> --- a/drivers/acpi/scan.c
>> +++ b/drivers/acpi/scan.c
>> @@ -13,6 +13,7 @@
>>   #include <linux/kernel.h>
>>   #include <linux/acpi.h>
>>   #include <linux/acpi_iort.h>
>> +#include <linux/acpi_iovt.h>
>>   #include <linux/acpi_rimt.h>
>>   #include <linux/acpi_viot.h>
>>   #include <linux/iommu.h>
>> @@ -1628,6 +1629,8 @@ static int acpi_iommu_configure_id(struct device *dev, const u32 *id_in)
>>                  err = rimt_iommu_configure_id(dev, id_in);
>>          if (err && err != -EPROBE_DEFER)
>>                  err = viot_iommu_configure(dev);
>> +       if (err && err != -EPROBE_DEFER)
>> +               err = iovt_iommu_configure_id(dev, id_in);
> We call our acpi_arch_late_init() before acpi_viot_init(), so I think
> it is better to also call iovt_iommu_configure_id() before
> viot_iommu_configure().
Yes, it should be the same order, good catch.

It is both OK for me to put acpi_arch_late_init() after 
acpi_viot_init(), or put iovt_iommu_configure_id() before 
viot_iommu_configure().

Regards
Bibo Mao
> 
> 
> Huacai
>>
>>          mutex_unlock(&iommu_probe_device_lock);
>>
>> diff --git a/include/linux/acpi_iovt.h b/include/linux/acpi_iovt.h
>> new file mode 100644
>> index 000000000000..25a846b96260
>> --- /dev/null
>> +++ b/include/linux/acpi_iovt.h
>> @@ -0,0 +1,13 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +
>> +#ifndef __ACPI_IOVT_H__
>> +#define __ACPI_IOVT_H__
>> +
>> +#if defined(CONFIG_IOMMU_API) && defined(CONFIG_ACPI_IOVT)
>> +int iovt_iommu_configure_id(struct device *dev, const u32 *id_in);
>> +#else
>> +static inline int iovt_iommu_configure_id(struct device *dev, const u32 *id_in)
>> +{ return -ENODEV; }
>> +#endif
>> +
>> +#endif
>> --
>> 2.39.3
>>

