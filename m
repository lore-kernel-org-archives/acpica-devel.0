Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=114.242.206.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793877767;
	b=vvivarzNh5q30y9z2JENj8+g+1spIhv18sMbiuCX7AugTNE2bro9hj37T7ZcJQGuNAiB
	 ucvVw+oQ55p8nPX2Z4GqdwPhidE3qd8doZhKJCrHhMJqgE3Wr8Suw5b2+4tAXJZSeFoqW
	 t5/YizzfwLLAaiE+/l55HBHX3xVC+9WHcFZrfdGx21APJvVoOfw/6f0VqP9jKugjfuxZ1
	 hLc6rYJ/jl/AqMHCurH9EHI+Fu8KUX+6HhrM6Yl6SUjTskW0iFN0PXIHCc3wnmAcRhkuJ
	 IbjysK+NDwkHL/ZRfdSmv0IFlqrFNg0wXCPfq8bX9oG24ju5gt90D1RLndMjr4wRtDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793877767;
	h=DMARC-Filter:Received:Received:Subject:To:Cc:References:From:
	 Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:Content-Type:
	 Content-Language:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-CM-SenderInfo:X-Coremail-Antispam;
	bh=cmaFW9ug8iVH0wND/xcVo7iynyR/9c9bPF8WcjdPRdQ=;
	b=quoYLmkqLDJFM3H0Zo+cYjaUh0/7S3gisDCXCzNiUbbPNchK5BFY8g1zes6ImTAy/Emr
	 EyU+8vgZJwg371TlSZVhp6deJlZrwZkehJafmb+kcZb5+fBaJhnBroWJMNDsZpBUdCW6i
	 dIXU/Mu3xA5gC1tLh1B3wD+bt5HdlePDlivqlhVlbWNkcYRwWgiC3Lh+pWUa4ZKU+8o18
	 VvwJVZM0CmlOzw0FG1SKhmIKmkEmPyk+dbsa4oH7kd6AzuHi+ep1dVIzcYNuuiTH+4Wwf
	 YPFq9inoBQVOA0BF9+qdA9RaqRK9Sg9928wfUcYVzcFphAKYuQ0YVVaYd5ds9M00Z2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=loongson.cn;
	spf=pass smtp.mailfrom=loongson.cn;
	arc=none smtp.remote-ip=114.242.206.163
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0152D606D810;
	Thu,  5 Nov 2026 11:22:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0152D606D810
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.62])
	by gateway (Coremail) with SMTP id _____8AxYdECZ+xqWqYcAA--.17983S3;
	Thu, 05 Nov 2026 19:22:42 +0800 (CST)
Received: from [127.0.0.1] (unknown [127.0.0.1])
	by front1 (Coremail) with SMTP id qMiowJAxmM3+ZuxqIY4yAA--.37214S2;
	Thu, 05 Nov 2026 19:22:40 +0800 (CST)
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
 <66b9d482-d577-748c-729d-0fba70701d3d@loongson.cn>
 <CAAhV-H6PL6RLM3KA4BLQEt804FnsDE4CtKeB0KaW7Gj8rm2PMw@mail.gmail.com>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <843a9418-2017-c2c6-45c5-38628e7e0bdb@loongson.cn>
Date: Thu, 5 Nov 2026 19:23:54 +0800
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
In-Reply-To: <CAAhV-H6PL6RLM3KA4BLQEt804FnsDE4CtKeB0KaW7Gj8rm2PMw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJAxmM3+ZuxqIY4yAA--.37214S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxAFy7ZFyfZFyxtrWxWw4UAwc_yoWruF1xpF
	4xGay5KFWDJr17Grn2qw1DuF15tryUGryIgw1jgryUCr9a9r1FqF4UJF4YkF97ZrZ8CF1I
	vF1jyrW3WF1UAFgCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Sb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
	1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv
	67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
	AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C2
	67AKxVWUtVW8ZwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI
	8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWU
	CwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r
	1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBI
	daVFxhVjvjDU0xZFpf9x07UiiSdUUUUU=



On 2026/11/5 下午6:31, Huacai Chen wrote:
> On Thu, Nov 5, 2026 at 5:49 PM Bibo Mao <maobibo@loongson.cn> wrote:
>>
>>
>>
>> On 2026/11/5 下午5:31, Huacai Chen wrote:
>>> On Thu, Nov 5, 2026 at 5:14 PM Bibo Mao <maobibo@loongson.cn> wrote:
>>>>
>>>>
>>>>
>>>> On 2026/10/23 下午3:59, Huacai Chen wrote:
>>>>> Bibo,
>>>>>
>>>>> Now I have applied this series but with some modifications, please
>>>>> double check and test the code.
>>>>>
>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git/log/?h=loongarch-next
>>>> In my v4 submit, it is:
>>>> +               case ACPI_IOVT_DEVICE_ENTRY_START:
>>>> +                       is_start = true;
>>>> +                       start_devid = ep->device_id;
>>>> +                       break;
>>>> however in rc1, it is modified as:
>>>>                    case ACPI_IOVT_DEVICE_ENTRY_START:
>>>>                            is_start = true;
>>>>                            entry->start_devid = ep->device_id;
>>>>                            break;
>>>> Here entry is not allocated and NULL pointer, it is allocated in
>>>> ACPI_IOVT_DEVICE_ENTRY_END switch case.
>>>>
>>>> I really do not know what is aid to modify it and let others to test.
>>> Sorry, it's my fault.
>>>
>>> In theory I should point out the modification (eliminating the local
>>> variable start_devid) and refresh a new version. But we have no time
>>> to do this because when the first patch is merged into the ACPI repo
>>> it is near the merge window.
>> Maybe our work style is different, I do not care much for the coding style.
>>>
>>> If you agree, I will submit such modifications to fix it.
>> fix is welcome.
>>>
>>> diff --git a/drivers/acpi/loongarch/iovt.c b/drivers/acpi/loongarch/iovt.c
>>> index 87cee4f0fc80..4cdac28a1fd0 100644
>>> --- a/drivers/acpi/loongarch/iovt.c
>>> +++ b/drivers/acpi/loongarch/iovt.c
>>> @@ -115,6 +115,10 @@ static int __init iovt_add_iommu(struct
>>> acpi_iovt_iommu *iommu)
>>>           for (i = 0; i < iommu->device_entry_num; i++) {
>>>                   switch (ep->type) {
>>>                   case ACPI_IOVT_DEVICE_ENTRY_START:
>>> +                       entry = kzalloc_obj(struct iovt_device_entry,
>>> GFP_ATOMIC);
>> There will be memory leak problem if there are START/START/END in the table.
> That means a broken table? I think we don't need to consider broken
> tables, because there may be kinds of broken pattern rather than just
> a START/START/END.
yes, START/END/START, START/START/END, START/SINGLE/END. what is the 
relationship between "don't need to consider" and kinds of broken pattern?

what is the policy from your side with such BIOS table? let memory leak 
and continue?

> 
> Huacai
> 
>>
>> Regards
>> Bibo Mao
>>> +                       if (!entry)
>>> +                               return -ENOMEM;
>>> +
>>>                           is_start = true;
>>>                           entry->start_devid = ep->device_id;
>>>                           break;
>>> @@ -122,10 +126,6 @@ static int __init iovt_add_iommu(struct
>>> acpi_iovt_iommu *iommu)
>>>                           if (!is_start)
>>>                                   break;
>>>
>>> -                       entry = kzalloc_obj(struct iovt_device_entry,
>>> GFP_ATOMIC);
>>> -                       if (!entry)
>>> -                               return -ENOMEM;
>>> -
>>>                           is_start = false;
>>>                           entry->end_devid = ep->device_id;
>>>                           list_add_tail(&entry->list, &np->ep_list);
>>>
>>> Huacai
>>>
>>>>
>>>>>
>>>>> Huacai
>>>>>
>>>>> On Mon, Oct 12, 2026 at 3:16 PM Bibo Mao <maobibo@loongson.cn> wrote:
>>>>>>
>>>>>> This change is already merged in acpica tree.
>>>>>>
>>>>>> slightly ping.
>>>>>>
>>>>>> On Tue, Sep 22, 2026 at 08:10:55PM +0800, Bibo Mao wrote:
>>>>>>     > According to the IOVT specification, define macros for each bit of the
>>>>>>     > Flags field in the IOVT IOMMU structure.
>>>>>>     >
>>>>>>     > Link: https://github.com/open-acpica/acpica/commit/352f750e4cc0
>>>>>>     > Signed-off-by: Bibo Mao <maobibo@loongson.cn>
>>>>>>     > ---
>>>>>>     >  include/acpi/actbl2.h | 7 +++++++
>>>>>>     >  1 file changed, 7 insertions(+)
>>>>>>     >
>>>>>>     > diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
>>>>>>     > index baef525367b5..76e4a5bc79b4 100644
>>>>>>     > --- a/include/acpi/actbl2.h
>>>>>>     > +++ b/include/acpi/actbl2.h
>>>>>>     > @@ -919,6 +919,13 @@ struct acpi_iovt_iommu {
>>>>>>     >       u32 device_entry_offset;
>>>>>>     >  };
>>>>>>     >
>>>>>>     > +/* Masks for Flags field above */
>>>>>>     > +#define ACPI_IOVT_IOMMU_PCI_DEVICE           (1<<0)
>>>>>>     > +#define ACPI_IOVT_IOMMU_PXM_VALID            (1<<1)
>>>>>>     > +#define ACPI_IOVT_IOMMU_MAGAGE_BY_SEGMENT    (1<<2)
>>>>>>     > +#define ACPI_IOVT_IOMMU_HW_CAP_SUPPORT               (1<<3)
>>>>>>     > +#define ACPI_IOVT_IOMMU_MSI_INT_BYPASS               (1<<4)
>>>>>>     > +
>>>>>>     >  struct acpi_iovt_device_entry {
>>>>>>     >       u8 type;
>>>>>>     >       u8 length;
>>>>>>     > --
>>>>>>     > 2.39.3
>>>>>>     >
>>>>>>
>>>>
>>>>
>>

