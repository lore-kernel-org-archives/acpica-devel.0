Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63821E379B
	for <acpica-devel@lists.linux.dev>; Thu, 17 Jul 2025 03:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752721444; cv=none; b=ZAPUF7k5lSnJ4dW81EMqidO+eC4Xco5+8T9g4vcxVz+TM640dz8wvvI+MrvAJ+Wckhnnkw3OJpOXiJ63efj5KrCwu0fQH7JJVG2ZBxfdS408JO67DMg7BhUV9Ktvk9i0JmPK33jYyTl8Imf5FYkrKs9ZgfyZ1ltH5++dePeLLUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752721444; c=relaxed/simple;
	bh=MA7DhgnrHAFOSfD3Z71cnWoWC9q9bvXHQq62SUa7Hj8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fcLluLGZTySZ9mAquWRPkb6r8ZoX0IfQMS8tUUdKvRxlLqRQyywmxOIKYrWrulrqlhPqgNBfvscacmHPA602ocT5du1pbIUec1lHUW8fCsMpfH9S2pvvGhDPxMTbG/fnif1uNz0gbjNJ0hj9SCtxrh2/+/tW4kl0Fj0D5AKJheE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=siGf1j6S; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="siGf1j6S"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1752721433; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=y27C67f1ZvJH371/Jn25fxn30qg7QY+upPRPKPMQK4A=;
	b=siGf1j6SG56lzOqRRqTYHgVMM1kksuYqaZ1cxvB2X0xvJZppA997Jn9uLy4GWNzafR64daZ2FKJQBAJ7jbZrODNVCHlWkXGRj61264/hOb59V6DglCLdLHRLOQ4qw9dg1pvSbF8aakt9VZkI8OpO6qKdGadDjboyefZXJ9d3dBE=
Received: from 30.246.162.71(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0Wj6dHlv_1752721419 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 17 Jul 2025 11:03:51 +0800
Message-ID: <58f3242a-e52a-46a9-9a99-3887eeaa1285@linux.alibaba.com>
Date: Thu, 17 Jul 2025 11:03:51 +0800
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ghes: Track number of recovered hardware errors
To: Breno Leitao <leitao@debian.org>
Cc: Borislav Petkov <bp@alien8.de>, Alexander Graf <graf@amazon.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Peter Gonda <pgonda@google.com>, "Luck, Tony" <tony.luck@intel.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 James Morse <james.morse@arm.com>, "Moore, Robert" <robert.moore@intel.com>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "acpica-devel@lists.linux.dev" <acpica-devel@lists.linux.dev>,
 "kernel-team@meta.com" <kernel-team@meta.com>
References: <20250714173556.GQaHU__LL6IUIPCDIW@fat_crate.local>
 <aHWC-J851eaHa_Au@agluck-desk3>
 <20250715082939.GAaHYRc3Yn49jyvYzc@fat_crate.local>
 <kyprjdilgyz3xgw3slnrsemptnpp6h75mipv6a3lgp2dmwqekg@s7azbepy7nu2>
 <20250715103125.GFaHYt_TnFQW6ti0ST@fat_crate.local>
 <vs5x5qvw2veurxdljmdiumqpseze2myx6quw3rmt7li7d3dbin@duoky4z44zzz>
 <20250715125327.GGaHZPRz9QLNNO-7q8@fat_crate.local>
 <68b6961c-4443-48a8-a7f7-ed94f3352d7d@linux.alibaba.com>
 <p2iytcdfvgm74zif6ihd7gs4kuaeza4b4p52cr5ya4upabiome@kr3yy7fjznwe>
 <b4c39a87-c5a4-4525-b598-61fc28a8dc36@linux.alibaba.com>
 <ckn7d3e3xynnup4bbombn7z7xxvld3a7xmqpg4pzp57qebywfc@t2yrn3zqmnje>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <ckn7d3e3xynnup4bbombn7z7xxvld3a7xmqpg4pzp57qebywfc@t2yrn3zqmnje>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/7/16 20:42, Breno Leitao 写道:
> hello Shuai,
> 
> On Wed, Jul 16, 2025 at 11:04:28AM +0800, Shuai Xue wrote:
>>> My plan with this patch is to have a counter for hardware errors that
>>> would be exposed to the crashdump. So, post-morten analyzes tooling can
>>> easily query if there are hardware errors and query RAS information in
>>> the right databases, in case it seems a smoking gun.
>>
>> I see your point. But does using a single ghes_recovered_errors counter
>> to track all corrected and non-fatal errors for CPU, memory, and PCIe
>> really help?
> 
> It provides a quick indication that hardware issues have occurred, which
> can prompt the operator to investigate further via RAS events.
> 
> That said, Tony proposed a more robust approach—categorizing and
> tracking errors by their source. This would involve maintaining separate
> counters for each source using an counter per enum type:
> 
> 	enum recovered_error_sources {
> 		ERR_GHES,
> 		ERR_MCE,
> 		ERR_AER,
> 		...
> 		ERR_NUM_SOURCES
> 	};
> 
> See more at: https://lore.kernel.org/all/aHWC-J851eaHa_Au@agluck-desk3/
> 
> Do you think this would help you by any chance?
> 
> Thanks
> --breno


Personally, I think this approach would be more helpful. Additionally, I
suggest not mixing CEs (Correctable Errors) and UEs (Uncorrectable
Errors) together. This is especially important for memory errors, as CEs
occur much more frequently than UEs, but their impact is much smaller.

Thanks.
Shuai
