Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDF674399D5;
	Mon, 12 Oct 2026 07:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791789417; cv=none; b=UU8SQOCt0yXVTnZ7/QWGh+AuIiwqdH4f82d+K/pQ2KcDNqsE/hs1sq/TdkwD+xObAsJqecN2Kqro8kjNQCPpLX6wrFn4nX0j8Vg9weG8ty+gZLXuPQO9n8JptCJgA5VbO1fo4t/XF2GgZ4qG4EUKOtKufL5o93fcIAtYT3uKaEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791789417; c=relaxed/simple;
	bh=GHGRzDu1jlT6vvkm/rdVz4B+NvejExmm3Ww2ilVvNb0=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=AIPq97Jr2PmEHK3fNBiqd7elUJT4LXAPtSIamqKrl+cW1kGQcmzwtXSJ6/RLpzknKbehlhZbVju4PQjjlF/soudE4TJv+xZd0s86/VJOmvK4hJDm0IwvK3otGJYGrDTqoehYuzOk1gTQIgc8N/Q5PDgQJ8DGc8afZDSKvy2qtks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.40.46.54])
	by gateway (Coremail) with SMTP id _____8DxTtNkicxquNwUAA--.60215S3;
	Mon, 12 Oct 2026 15:16:52 +0800 (CST)
Received: from [10.40.46.54] (unknown [10.40.46.54])
	by front1 (Coremail) with SMTP id qMiowJDxg8xeicxqAlcrAA--.63784S2;
	Mon, 12 Oct 2026 15:16:46 +0800 (CST)
Message-ID: <10bd45f8-2d37-42f0-b7d2-a4a84933c9b3@loongson.cn>
Date: Mon, 12 Oct 2026 15:18:13 +0800
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: rafael@kernel.org, linux-acpi@vger.kernel.org
Cc: acpica-devel@lists.linux.dev, chenhuacai@kernel.org, lenb@kernel.org,
 linux-kernel@vger.kernel.org, lixianglai@loongson.cn,
 loongarch@lists.linux.dev, maciej.wieczor-retman@intel.com,
 pawel.chmielewski@intel.com, maobibo@loongson.cn
References: <20260922121058.972734-2-maobibo@loongson.cn>
Subject: Re: [PATCH v4 1/4] ACPICA: actbl2.h: Add bit constants of the Flags
 field in the IOVT IOMMU structure
Content-Language: en-US
From: Bibo Mao <maobibo@loongson.cn>
In-Reply-To: <20260922121058.972734-2-maobibo@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:qMiowJDxg8xeicxqAlcrAA--.63784S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj9xXoWrZw17Xw1xCry7GF1fCry8JFc_yoWDKwb_Ca
	na9F4kZ3WDWF1xtrs8t3WxArWjgayxAFZ3KFs5WFn8Aa92vrWUurnakryS9F4kC3929FWD
	ZFn8WrWF9wnxGosvyTuYvTs0mTUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbzkYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	WUJVW8JwA2z4x0Y4vEx4A2jsIE14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
	8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AK
	xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41l42xK82IYc2Ij64vIr4
	1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK
	67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI
	8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAv
	wI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14
	v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07jUsqXUUUUU=

This change is already merged in acpica tree.

slightly ping.

On Tue, Sep 22, 2026 at 08:10:55PM +0800, Bibo Mao wrote:
 > According to the IOVT specification, define macros for each bit of the
 > Flags field in the IOVT IOMMU structure.
 >
 > Link: https://github.com/open-acpica/acpica/commit/352f750e4cc0
 > Signed-off-by: Bibo Mao <maobibo@loongson.cn>
 > ---
 >  include/acpi/actbl2.h | 7 +++++++
 >  1 file changed, 7 insertions(+)
 >
 > diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
 > index baef525367b5..76e4a5bc79b4 100644
 > --- a/include/acpi/actbl2.h
 > +++ b/include/acpi/actbl2.h
 > @@ -919,6 +919,13 @@ struct acpi_iovt_iommu {
 >       u32 device_entry_offset;
 >  };
 >
 > +/* Masks for Flags field above */
 > +#define ACPI_IOVT_IOMMU_PCI_DEVICE           (1<<0)
 > +#define ACPI_IOVT_IOMMU_PXM_VALID            (1<<1)
 > +#define ACPI_IOVT_IOMMU_MAGAGE_BY_SEGMENT    (1<<2)
 > +#define ACPI_IOVT_IOMMU_HW_CAP_SUPPORT               (1<<3)
 > +#define ACPI_IOVT_IOMMU_MSI_INT_BYPASS               (1<<4)
 > +
 >  struct acpi_iovt_device_entry {
 >       u8 type;
 >       u8 length;
 > --
 > 2.39.3
 >

