Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=114.242.206.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793870048;
	b=jkq202nmQphFZqbTy6D3Eqo10R1w+3gOrCTJGUGsr5gmhsSKyB7r/Eb+srneANW4BxDe
	 P+nlCvIfu7CW8Hw1kSTn2RBdVYsKIrLast5FFA/ho9Te7My2lAJBgQkOJMFqnNchW8Pew
	 AbTH0GRvYKgnLkiBqva6hujA3LgJoy63sjPafe1lYw1Lt3MNinfA3PoBh/lJKfxjlgIBf
	 RZY5GovB+7Ihxwtc9IIk4brKchUDqBrEZAnXIbh9x/D9AkD+9VVUUCRikBy+RzWzj/Uy3
	 goErNCcUD4rFchAcbh466000W5LnTiItbbg5jY4QtkQNERDhNeMb/Td+5VeCI+1mK4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793870048;
	h=DMARC-Filter:Received:Received:Subject:To:Cc:References:From:
	 Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:Content-Type:
	 Content-Language:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-CM-SenderInfo:X-Coremail-Antispam;
	bh=n9Rf37eO4THPEC6BfsALgd8nh4beTqOK842MpIGgx80=;
	b=IKIwA+MqJxR0B5NqGjSxNHpMXIFsG9w8VYPzOIygQex4vk//BfPhXEaUJW1esNlSQj8F
	 OMJiNq00be06uQahhLLHrCGg+rawSzZ7giSTXexNHjMqAue8wVADeWJmmn6rEWUsiXsfh
	 Zteikx0wtXXp2k2YA7YdAE7CHlvS04w7t+AbbP0/b1iunO2qLpmOIVL8c7xcnHt/GWmPX
	 qBXUlrqgkx17vrSJZ0RhrIhOS5qBfBhDZGP8lADzsv55j/zzjhpyrOB34nWdZVY9+Wc0H
	 lYnzdKdoqtRd4p2IaGYfNAVrNoBf9lEeOdv9JGNwsjOmCALKxeJuytVusm7kOe92W+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=loongson.cn;
	spf=pass smtp.mailfrom=loongson.cn;
	arc=none smtp.remote-ip=114.242.206.163
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 804C7606A328;
	Thu,  5 Nov 2026 09:14:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 804C7606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.62])
	by gateway (Coremail) with SMTP id _____8CxPtPcSOxqmpocAA--.17262S3;
	Thu, 05 Nov 2026 17:14:04 +0800 (CST)
Received: from [127.0.0.1] (unknown [127.0.0.1])
	by front1 (Coremail) with SMTP id qMiowJCx9czZSOxqbYgyAA--.10853S2;
	Thu, 05 Nov 2026 17:14:03 +0800 (CST)
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
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <6f8a9203-6fb1-268a-8d37-37e69fbf2ee9@loongson.cn>
Date: Thu, 5 Nov 2026 17:15:17 +0800
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
In-Reply-To: <CAAhV-H7Vq2ayLJNLRSo5RRiWOcmF2BXT_QOhEDg_jWOzYteqWw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJCx9czZSOxqbYgyAA--.10853S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7CF1ftr48JFWxuw4fAr1xXrc_yoW8ZrWrpr
	s2vayrKFWDXr47Gr1vgwnxCF1rt398CF1a9r4Sgry7tr9akr1rtF4Uua1Y9a97CrZ5CayI
	vFy2vrWfWFyjvrgCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
	1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv
	67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
	AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
	F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GF
	ylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
	xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
	4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07j8
	yCJUUUUU=



On 2026/10/23 下午3:59, Huacai Chen wrote:
> Bibo,
> 
> Now I have applied this series but with some modifications, please
> double check and test the code.
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git/log/?h=loongarch-next
In my v4 submit, it is:
+               case ACPI_IOVT_DEVICE_ENTRY_START:
+                       is_start = true;
+                       start_devid = ep->device_id;
+                       break;
however in rc1, it is modified as:
                 case ACPI_IOVT_DEVICE_ENTRY_START:
                         is_start = true;
                         entry->start_devid = ep->device_id;
                         break;
Here entry is not allocated and NULL pointer, it is allocated in 
ACPI_IOVT_DEVICE_ENTRY_END switch case.

I really do not know what is aid to modify it and let others to test.

> 
> Huacai
> 
> On Mon, Oct 12, 2026 at 3:16 PM Bibo Mao <maobibo@loongson.cn> wrote:
>>
>> This change is already merged in acpica tree.
>>
>> slightly ping.
>>
>> On Tue, Sep 22, 2026 at 08:10:55PM +0800, Bibo Mao wrote:
>>   > According to the IOVT specification, define macros for each bit of the
>>   > Flags field in the IOVT IOMMU structure.
>>   >
>>   > Link: https://github.com/open-acpica/acpica/commit/352f750e4cc0
>>   > Signed-off-by: Bibo Mao <maobibo@loongson.cn>
>>   > ---
>>   >  include/acpi/actbl2.h | 7 +++++++
>>   >  1 file changed, 7 insertions(+)
>>   >
>>   > diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
>>   > index baef525367b5..76e4a5bc79b4 100644
>>   > --- a/include/acpi/actbl2.h
>>   > +++ b/include/acpi/actbl2.h
>>   > @@ -919,6 +919,13 @@ struct acpi_iovt_iommu {
>>   >       u32 device_entry_offset;
>>   >  };
>>   >
>>   > +/* Masks for Flags field above */
>>   > +#define ACPI_IOVT_IOMMU_PCI_DEVICE           (1<<0)
>>   > +#define ACPI_IOVT_IOMMU_PXM_VALID            (1<<1)
>>   > +#define ACPI_IOVT_IOMMU_MAGAGE_BY_SEGMENT    (1<<2)
>>   > +#define ACPI_IOVT_IOMMU_HW_CAP_SUPPORT               (1<<3)
>>   > +#define ACPI_IOVT_IOMMU_MSI_INT_BYPASS               (1<<4)
>>   > +
>>   >  struct acpi_iovt_device_entry {
>>   >       u8 type;
>>   >       u8 length;
>>   > --
>>   > 2.39.3
>>   >
>>

