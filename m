Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=114.242.206.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794015834;
	b=X//lw/Ig6jUucU8ReV+xaaO+kiHn7PrAAZS4iduvxI4BEkU+Sw+D4NzwBc/n2sFJYFnP
	 KL12WnydF2EypTouuaOQvdni8VibfYC5DpkLTqFGRQOGw99jeE4e9lKr8dfgUW5ESvJny
	 7YNhTSIUlhemkgWBvyTggFp8Njbt8KNsNwMeDjoqyTD4GQLEAJk/YvfQ/C7Ck34W+N/5j
	 vmYPvHfFpNyXQrIHALD48Cw/LnUw2yPWFNNCgHLKRiNcjFqjDLEHoKIgQJoivr5QQoLpb
	 LZkFricS+1ib0ZGv6KIQimoKRAJwAPoG3y3T+0j1Cwak2yypxf4mXdNLr0SABmA7Swg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794015834;
	h=DMARC-Filter:Received:Received:Subject:To:Cc:References:From:
	 Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:Content-Type:
	 Content-Language:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-CM-SenderInfo:X-Coremail-Antispam;
	bh=GFdXwzO2TBZ1vUWOss39FQ4uB3VM3cJovyEdHGPvsD8=;
	b=xqqfFUYzyBTAqud0xcPvPCLJlThlApJ12wz59rAJWi2VsqH0WLCdaqVf1dlqXxGXjAWl
	 /odN6Wmn5rrTAQWkb4vURig7Y76lc0j4ioLcHW/rTyTeI3ST4/1wWhcSeRvbY8t/1yWU5
	 3T5SugdO05D7CHBqjKaHYMo0vxRuj7P7l3MgcUzGdooMZ5ZlzEgxqw0lmdV5QLFex7ayo
	 oxl2FUgI/0b6ur0HG53SQKO1K4afPspdg2QxP1l5JV1HWa5b1ik7O+UO0jozewobSALg2
	 nT58KsCrQOkNgTeJc5Wf0wIn8muL2CBwevg41BHOUSJNYSN9YcvRbmQuN6Mnp5uWHXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=loongson.cn;
	spf=pass smtp.mailfrom=loongson.cn;
	arc=none smtp.remote-ip=114.242.206.163
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B116606A32E;
	Sat,  7 Nov 2026 01:43:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1B116606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.62])
	by gateway (Coremail) with SMTP id _____8AxdvBUgu5qt0odAA--.18783S3;
	Sat, 07 Nov 2026 09:43:49 +0800 (CST)
Received: from [127.0.0.1] (unknown [127.0.0.1])
	by front1 (Coremail) with SMTP id qMiowJAx1cxRgu5q6eAyAA--.10256S2;
	Sat, 07 Nov 2026 09:43:45 +0800 (CST)
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
 <843a9418-2017-c2c6-45c5-38628e7e0bdb@loongson.cn>
 <CAAhV-H4O07hKyPJ8rTMo=vD=t+qFM7UAJOPDGZDVJ0Ti-gOdEQ@mail.gmail.com>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <e04352c2-f4ce-d415-72d4-21e03b828843@loongson.cn>
Date: Sat, 7 Nov 2026 09:45:01 +0800
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
In-Reply-To: <CAAhV-H4O07hKyPJ8rTMo=vD=t+qFM7UAJOPDGZDVJ0Ti-gOdEQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJAx1cxRgu5q6eAyAA--.10256S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxtF4DZr1UtryUZF1fZrWfCrX_yoWxZFyDpF
	48JFW5KFWDJr17Gr10qw1Uur15tr1UGryIgryjgryUCrnrtr1rJF4UJFWYkFykAr98GF10
	qF1jyrW7WF4UArgCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUPYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWU
	AwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMx
	k0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l
	4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxV
	WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI
	7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
	1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI
	42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07jYpB-UUUUU=



On 2026/11/6 下午10:58, Huacai Chen wrote:
> On Thu, Nov 5, 2026 at 7:22 PM Bibo Mao <maobibo@loongson.cn> wrote:
>>
>>
>>
>> On 2026/11/5 下午6:31, Huacai Chen wrote:
>>> On Thu, Nov 5, 2026 at 5:49 PM Bibo Mao <maobibo@loongson.cn> wrote:
>>>>
>>>>
>>>>
>>>> On 2026/11/5 下午5:31, Huacai Chen wrote:
>>>>> On Thu, Nov 5, 2026 at 5:14 PM Bibo Mao <maobibo@loongson.cn> wrote:
>>>>>>
>>>>>>
>>>>>>
>>>>>> On 2026/10/23 下午3:59, Huacai Chen wrote:
>>>>>>> Bibo,
>>>>>>>
>>>>>>> Now I have applied this series but with some modifications, please
>>>>>>> double check and test the code.
>>>>>>>
>>>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git/log/?h=loongarch-next
>>>>>> In my v4 submit, it is:
>>>>>> +               case ACPI_IOVT_DEVICE_ENTRY_START:
>>>>>> +                       is_start = true;
>>>>>> +                       start_devid = ep->device_id;
>>>>>> +                       break;
>>>>>> however in rc1, it is modified as:
>>>>>>                     case ACPI_IOVT_DEVICE_ENTRY_START:
>>>>>>                             is_start = true;
>>>>>>                             entry->start_devid = ep->device_id;
>>>>>>                             break;
>>>>>> Here entry is not allocated and NULL pointer, it is allocated in
>>>>>> ACPI_IOVT_DEVICE_ENTRY_END switch case.
>>>>>>
>>>>>> I really do not know what is aid to modify it and let others to test.
>>>>> Sorry, it's my fault.
>>>>>
>>>>> In theory I should point out the modification (eliminating the local
>>>>> variable start_devid) and refresh a new version. But we have no time
>>>>> to do this because when the first patch is merged into the ACPI repo
>>>>> it is near the merge window.
>>>> Maybe our work style is different, I do not care much for the coding style.
>>>>>
>>>>> If you agree, I will submit such modifications to fix it.
>>>> fix is welcome.
>>>>>
>>>>> diff --git a/drivers/acpi/loongarch/iovt.c b/drivers/acpi/loongarch/iovt.c
>>>>> index 87cee4f0fc80..4cdac28a1fd0 100644
>>>>> --- a/drivers/acpi/loongarch/iovt.c
>>>>> +++ b/drivers/acpi/loongarch/iovt.c
>>>>> @@ -115,6 +115,10 @@ static int __init iovt_add_iommu(struct
>>>>> acpi_iovt_iommu *iommu)
>>>>>            for (i = 0; i < iommu->device_entry_num; i++) {
>>>>>                    switch (ep->type) {
>>>>>                    case ACPI_IOVT_DEVICE_ENTRY_START:
>>>>> +                       entry = kzalloc_obj(struct iovt_device_entry,
>>>>> GFP_ATOMIC);
>>>> There will be memory leak problem if there are START/START/END in the table.
>>> That means a broken table? I think we don't need to consider broken
>>> tables, because there may be kinds of broken pattern rather than just
>>> a START/START/END.
>> yes, START/END/START, START/START/END, START/SINGLE/END. what is the
>> relationship between "don't need to consider" and kinds of broken pattern?
>>
>> what is the policy from your side with such BIOS table? let memory leak
>> and continue?
> The driver can only work with a good table or no table, but not with a
> broken table.
With a broken table, software can discard the whole table, or discard 
the single table entry.
> 
> Take START1/START2/END as an example of broken table: in your original
> code, the END entry will be pairing with START2. But for a broken
> table who can ensure they are the correct pair? If the real correct
> pair is START1 and END, then (entry->start_devid, entry->end_devid)
there is only one policy, software does not know START1/END is right or 
START2/END is right.
> will be a wrong device range. Such mistakes are much worse than a
> memery leak.
> 
> If you want to say "I don't care about correct pairing, memory leak is
> bad in any case.", OK, we can do it like this:
> 
> diff --git a/drivers/acpi/loongarch/iovt.c b/drivers/acpi/loongarch/iovt.c
> index 87cee4f0fc80..ebd11e22c9be 100644
> --- a/drivers/acpi/loongarch/iovt.c
> +++ b/drivers/acpi/loongarch/iovt.c
> @@ -115,6 +115,13 @@ static int __init iovt_add_iommu(struct
> acpi_iovt_iommu *iommu)
>          for (i = 0; i < iommu->device_entry_num; i++) {
>                  switch (ep->type) {
>                  case ACPI_IOVT_DEVICE_ENTRY_START:
> +                       if (is_start)
> +                               break;
there is still memory leak with START/SINGLE/END pairs, is_start set 
with false with ACPI_IOVT_DEVICE_ENTRY_SINGLE case.

Regards
Bibo Mao
> +
> +                       entry = kzalloc_obj(struct iovt_device_entry,
> GFP_ATOMIC);
> +                       if (!entry)
> +                               return -ENOMEM;
> +
>                          is_start = true;
>                          entry->start_devid = ep->device_id;
>                          break;
> @@ -122,10 +129,6 @@ static int __init iovt_add_iommu(struct
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
>>>>
>>>> Regards
>>>> Bibo Mao
>>>>> +                       if (!entry)
>>>>> +                               return -ENOMEM;
>>>>> +
>>>>>                            is_start = true;
>>>>>                            entry->start_devid = ep->device_id;
>>>>>                            break;
>>>>> @@ -122,10 +126,6 @@ static int __init iovt_add_iommu(struct
>>>>> acpi_iovt_iommu *iommu)
>>>>>                            if (!is_start)
>>>>>                                    break;
>>>>>
>>>>> -                       entry = kzalloc_obj(struct iovt_device_entry,
>>>>> GFP_ATOMIC);
>>>>> -                       if (!entry)
>>>>> -                               return -ENOMEM;
>>>>> -
>>>>>                            is_start = false;
>>>>>                            entry->end_devid = ep->device_id;
>>>>>                            list_add_tail(&entry->list, &np->ep_list);
>>>>>
>>>>> Huacai
>>>>>
>>>>>>
>>>>>>>
>>>>>>> Huacai
>>>>>>>
>>>>>>> On Mon, Oct 12, 2026 at 3:16 PM Bibo Mao <maobibo@loongson.cn> wrote:
>>>>>>>>
>>>>>>>> This change is already merged in acpica tree.
>>>>>>>>
>>>>>>>> slightly ping.
>>>>>>>>
>>>>>>>> On Tue, Sep 22, 2026 at 08:10:55PM +0800, Bibo Mao wrote:
>>>>>>>>      > According to the IOVT specification, define macros for each bit of the
>>>>>>>>      > Flags field in the IOVT IOMMU structure.
>>>>>>>>      >
>>>>>>>>      > Link: https://github.com/open-acpica/acpica/commit/352f750e4cc0
>>>>>>>>      > Signed-off-by: Bibo Mao <maobibo@loongson.cn>
>>>>>>>>      > ---
>>>>>>>>      >  include/acpi/actbl2.h | 7 +++++++
>>>>>>>>      >  1 file changed, 7 insertions(+)
>>>>>>>>      >
>>>>>>>>      > diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
>>>>>>>>      > index baef525367b5..76e4a5bc79b4 100644
>>>>>>>>      > --- a/include/acpi/actbl2.h
>>>>>>>>      > +++ b/include/acpi/actbl2.h
>>>>>>>>      > @@ -919,6 +919,13 @@ struct acpi_iovt_iommu {
>>>>>>>>      >       u32 device_entry_offset;
>>>>>>>>      >  };
>>>>>>>>      >
>>>>>>>>      > +/* Masks for Flags field above */
>>>>>>>>      > +#define ACPI_IOVT_IOMMU_PCI_DEVICE           (1<<0)
>>>>>>>>      > +#define ACPI_IOVT_IOMMU_PXM_VALID            (1<<1)
>>>>>>>>      > +#define ACPI_IOVT_IOMMU_MAGAGE_BY_SEGMENT    (1<<2)
>>>>>>>>      > +#define ACPI_IOVT_IOMMU_HW_CAP_SUPPORT               (1<<3)
>>>>>>>>      > +#define ACPI_IOVT_IOMMU_MSI_INT_BYPASS               (1<<4)
>>>>>>>>      > +
>>>>>>>>      >  struct acpi_iovt_device_entry {
>>>>>>>>      >       u8 type;
>>>>>>>>      >       u8 length;
>>>>>>>>      > --
>>>>>>>>      > 2.39.3
>>>>>>>>      >
>>>>>>>>
>>>>>>
>>>>>>
>>>>
>>
>>

