Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=114.242.206.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793872146;
	b=C5DJVxNhQ6b1F7ZeJFM/OWhi9t0oG0b7+7e0MCnclhfVsaJrTXuGXe8GL48/cPWbhMrS
	 Krbx1v9x5wGIq0w7yuOEW5c5FjsX0rgxNPWvZ1ySaJcxFq3LDad4OChIMCAtNChTH1uaD
	 8dcy4/4Yt5UO7CvnSHpZnGbLFuxiAj4F9MEQ3BpDXdsHhcnwIm5oQGot7arV932GWVwXL
	 Iao9wWc/UpKGaxO3NTE4KCiZBAOkiz6QaYwbLZseqRcYAndaBu3Uw+GUAR/Wj/uC3RRFm
	 DnOL+SBIqluINoxOKd8ZIDkiFINzxL27+AL1q2Jv4OWJvuPhwjqfuSzPreEHiDK76TQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793872146;
	h=DMARC-Filter:Received:Received:Subject:To:Cc:References:From:
	 Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:Content-Type:
	 Content-Language:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-CM-SenderInfo:X-Coremail-Antispam;
	bh=g85dMbXugDSMUOP05BVKZjpvH/kIPxQutJb8SZyT+2A=;
	b=hyW7YZevbcIisWwmPdJ8rvsIQnn5mGhZFS3mUeH9uofLjE19y5X4BlPFxdWNtudvFzZd
	 3hLLHtFLbiJn/dsGXvxTNcpiiOvIimsg3kljtOPemBirTzM0ESDDpPjowAZSgtgquL9aB
	 +GMvp1uOFWuQNOlPoWUCcuD4RPcU/hZvNdZC7d5ab3rKmM//TS2KkXNsOorwM1eSWgPv5
	 ox0BwXGmZDOrXsklNSukYwmxdBIfxaU6FLiQnG4bmlve05EE0SC2cF+Pkw1D437Fi5yDy
	 tX0UyAbm7crFYK9JMyel0spsBQ+7egU50+R6wmIsv4phAA7yfPKjvlwtzuQnagMXs5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=loongson.cn;
	spf=pass smtp.mailfrom=loongson.cn;
	arc=none smtp.remote-ip=114.242.206.163
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1CF8606A32C;
	Thu,  5 Nov 2026 09:49:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F1CF8606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.62])
	by gateway (Coremail) with SMTP id _____8BxLNIOUexqJp4cAA--.17495S3;
	Thu, 05 Nov 2026 17:49:02 +0800 (CST)
Received: from [127.0.0.1] (unknown [127.0.0.1])
	by front1 (Coremail) with SMTP id qMiowJBx5cwMUexqG4oyAA--.11332S2;
	Thu, 05 Nov 2026 17:49:01 +0800 (CST)
Subject: Re: [PATCH v4 1/4] ACPICA: actbl2.h: Add bit constants of the Flags
 field in the IOVT IOMMU structure
To: Huacai Chen <chenhuacai@kernel.org>
Cc: rafael@kernel.org, linux-acpi@vger.kernel.org,
 acpica-devel@lists.linux.dev, lenb@kernel.org, linux-kernel@vger.kernel.org,
 lixianglai@loongson.cn, loongarch@lists.linux.dev,
 maciej.wieczor-retman@intel.com, pawel.chmielewski@intel.com
References: <20260922121058.972734-2-maobibo@loongson.cn>
 <10bd45f8-2d37-42f0-b7d2-a4a84933c9b3@loongson.cn>
 <CAAhV-H7Vq2ayLJNLRSo5RRiWOcmF2BXT_QOhEDg_jWOzYteqWw@mail.gmail.com>
 <6f8a9203-6fb1-268a-8d37-37e69fbf2ee9@loongson.cn>
 <CAAhV-H5k8EJrAuqPH44y_+1gcXGCjCoozzK5ii9cLtiLDj5eog@mail.gmail.com>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <66b9d482-d577-748c-729d-0fba70701d3d@loongson.cn>
Date: Thu, 5 Nov 2026 17:50:17 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Post: <mailto:acpica-devel@lists.linux.dev>
List-Help: <mailto:acpica-devel+help@lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:acpica-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <CAAhV-H5k8EJrAuqPH44y_+1gcXGCjCoozzK5ii9cLtiLDj5eog@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJBx5cwMUexqG4oyAA--.11332S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxGF1fAw13Zw4rXr1fKw1UCFX_yoWrJFy7pF
	4xJay5KFWDJr47Gr1vq3Z8uF15t3y8CryIgryFgryjkr9agr1rtF4UAF4Y9as7A395CF1I
	qFyjvrW2gF4UZrgCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Sb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
	1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv
	67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
	AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C2
	67AKxVWUAVWUtwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI
	8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWU
	CwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r
	1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBI
	daVFxhVjvjDU0xZFpf9x07URa0PUUUUU=



On 2026/11/5 下午5:31, Huacai Chen wrote:
> On Thu, Nov 5, 2026 at 5:14 PM Bibo Mao <maobibo@loongson.cn> wrote:
>>
>>
>>
>> On 2026/10/23 下午3:59, Huacai Chen wrote:
>>> Bibo,
>>>
>>> Now I have applied this series but with some modifications, please
>>> double check and test the code.
>>>
>>> https://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git/log/?h=loongarch-next
>> In my v4 submit, it is:
>> +               case ACPI_IOVT_DEVICE_ENTRY_START:
>> +                       is_start = true;
>> +                       start_devid = ep->device_id;
>> +                       break;
>> however in rc1, it is modified as:
>>                   case ACPI_IOVT_DEVICE_ENTRY_START:
>>                           is_start = true;
>>                           entry->start_devid = ep->device_id;
>>                           break;
>> Here entry is not allocated and NULL pointer, it is allocated in
>> ACPI_IOVT_DEVICE_ENTRY_END switch case.
>>
>> I really do not know what is aid to modify it and let others to test.
> Sorry, it's my fault.
> 
> In theory I should point out the modification (eliminating the local
> variable start_devid) and refresh a new version. But we have no time
> to do this because when the first patch is merged into the ACPI repo
> it is near the merge window.
Maybe our work style is different, I do not care much for the coding style.
> 
> If you agree, I will submit such modifications to fix it.
fix is welcome.
> 
> diff --git a/drivers/acpi/loongarch/iovt.c b/drivers/acpi/loongarch/iovt.c
> index 87cee4f0fc80..4cdac28a1fd0 100644
> --- a/drivers/acpi/loongarch/iovt.c
> +++ b/drivers/acpi/loongarch/iovt.c
> @@ -115,6 +115,10 @@ static int __init iovt_add_iommu(struct
> acpi_iovt_iommu *iommu)
>          for (i = 0; i < iommu->device_entry_num; i++) {
>                  switch (ep->type) {
>                  case ACPI_IOVT_DEVICE_ENTRY_START:
> +                       entry = kzalloc_obj(struct iovt_device_entry,
> GFP_ATOMIC);
There will be memory leak problem if there are START/START/END in the table.

Regards
Bibo Mao
> +                       if (!entry)
> +                               return -ENOMEM;
> +
>                          is_start = true;
>                          entry->start_devid = ep->device_id;
>                          break;
> @@ -122,10 +126,6 @@ static int __init iovt_add_iommu(struct
> acpi_iovt_iommu *iommu)
>                          if (!is_start)
>                                  break;
> 
> -                       entry = kzalloc_obj(struct iovt_device_entry,
> GFP_ATOMIC);
> -                       if (!entry)
> -                               return -ENOMEM;
> -
>                          is_start = false;
>                          entry->end_devid = ep->device_id;
>                          list_add_tail(&entry->list, &np->ep_list);
> 
> Huacai
> 
>>
>>>
>>> Huacai
>>>
>>> On Mon, Oct 12, 2026 at 3:16 PM Bibo Mao <maobibo@loongson.cn> wrote:
>>>>
>>>> This change is already merged in acpica tree.
>>>>
>>>> slightly ping.
>>>>
>>>> On Tue, Sep 22, 2026 at 08:10:55PM +0800, Bibo Mao wrote:
>>>>    > According to the IOVT specification, define macros for each bit of the
>>>>    > Flags field in the IOVT IOMMU structure.
>>>>    >
>>>>    > Link: https://github.com/open-acpica/acpica/commit/352f750e4cc0
>>>>    > Signed-off-by: Bibo Mao <maobibo@loongson.cn>
>>>>    > ---
>>>>    >  include/acpi/actbl2.h | 7 +++++++
>>>>    >  1 file changed, 7 insertions(+)
>>>>    >
>>>>    > diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
>>>>    > index baef525367b5..76e4a5bc79b4 100644
>>>>    > --- a/include/acpi/actbl2.h
>>>>    > +++ b/include/acpi/actbl2.h
>>>>    > @@ -919,6 +919,13 @@ struct acpi_iovt_iommu {
>>>>    >       u32 device_entry_offset;
>>>>    >  };
>>>>    >
>>>>    > +/* Masks for Flags field above */
>>>>    > +#define ACPI_IOVT_IOMMU_PCI_DEVICE           (1<<0)
>>>>    > +#define ACPI_IOVT_IOMMU_PXM_VALID            (1<<1)
>>>>    > +#define ACPI_IOVT_IOMMU_MAGAGE_BY_SEGMENT    (1<<2)
>>>>    > +#define ACPI_IOVT_IOMMU_HW_CAP_SUPPORT               (1<<3)
>>>>    > +#define ACPI_IOVT_IOMMU_MSI_INT_BYPASS               (1<<4)
>>>>    > +
>>>>    >  struct acpi_iovt_device_entry {
>>>>    >       u8 type;
>>>>    >       u8 length;
>>>>    > --
>>>>    > 2.39.3
>>>>    >
>>>>
>>
>>

