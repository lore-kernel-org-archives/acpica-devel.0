Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E64418859B
	for <acpica-devel@lists.linux.dev>; Tue, 21 Oct 2025 06:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761029710; cv=none; b=A+L8+/v0VEIGVIZYcHdObvciWrockuptqzI6IqsRIBHMK7zZc60R9GcePyplL/Pmtseigzp1C2FcTA2tbUozNqGHSnT3tM/5apq8WRfjefO6ib3iOo4YB6+4S+0MKuh0Njdn2aGYJT5jfJvT5AtPvaldfQ11xuw7vLgWnhvuAU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761029710; c=relaxed/simple;
	bh=b01jDFBPXq5rbV8Y/L7o1RFolYKy1v18IqquZM7AR4A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H3xClwdbF3Gi6JfmYqbLkA8na2bI+tp+oafEqOOVEiSJxUuqx9nLWtH4XLM0ZHLPnBN/BEKHSw3f0gQtskCE5Nv/EwUbMGdrdHnD2GMXfZ8yTCme6aiCWfPC3ZmP65MBnzqVGWEqUKPgHkjQhjsTs7K2qi5S4kwpgTdkANScv9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=q5E+XnHT; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="q5E+XnHT"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1761029699; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=hW6pCW/lelgtOE/oMGx+iPlRXFCWmvEmZjCWVQr6yhg=;
	b=q5E+XnHTiXMltzCPWENoIwgmZlX0FafHZjYYyhMwH6Zcegpv9DsjC4NmzhRKvl9iprOut0oSVQpPA+lq2iYzNJeuiL9BviiQoEO0gO9sLFFwE6SGG4Hpce/vlJYer4HoEzcr6fbUxzTD+eeVEdcqSuha3AVdZHfw69JF0de0YDA=
Received: from 30.246.161.241(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WqhvgzO_1761029697 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 21 Oct 2025 14:54:58 +0800
Message-ID: <45d5e6a9-d561-4df9-96d4-285f2ca12888@linux.alibaba.com>
Date: Tue, 21 Oct 2025 14:54:52 +0800
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] acpi,srat: Fix incorrect device handle check for
 Generic Initiator
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: lenb@kernel.org, robert.moore@intel.com, andrew@kernel.org,
 bfaccini@nvidia.com, eahariha@linux.microsoft.com, dan.j.williams@intel.com,
 thorsten.blum@linux.dev, gourry@gourry.net,
 nunodasneves@linux.microsoft.com, wangyuquan1236@phytium.com.cn,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 acpica-devel@lists.linux.dev
References: <20250913023224.39281-1-xueshuai@linux.alibaba.com>
 <20250915093549.00006109@huawei.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20250915093549.00006109@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/9/15 16:35, Jonathan Cameron 写道:
> On Sat, 13 Sep 2025 10:32:24 +0800
> Shuai Xue <xueshuai@linux.alibaba.com> wrote:
> 
>> The Generic Initiator Affinity Structure in SRAT table uses device
>> handle type field to indicate the device type. According to ACPI
>> specification, the device handle type value of 1 represents PCI device,
>> not 0.
>>
>> Fixes: 894c26a1c274 ("ACPI: Support Generic Initiator only domains")
>> Reported-by: Wu Zongyong <wuzongyong@linux.alibaba.com>
>> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
> 
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> 
> Thanks!
> 
>> ---
>> changes since v1: drop changes in actbl3.h to make it easy to progress per Jonathan
>> ---


Hi, Rafael,

Gentle ping.

Are you happy to pick this bugfix up in this cycle?

Thanks.
Shuai
