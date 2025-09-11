Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 440894A32
	for <acpica-devel@lists.linux.dev>; Thu, 11 Sep 2025 04:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757564888; cv=none; b=A6yzvIY4rFlZh6ovMiewtV1odr/WMZ+hy1Mt8PTooM7+i1KfFRn0aO7BOKxpTUh4BKZ9BQXEV6qSmNew9dztvelSDNlpr8ulPdNbyZ5p2cxRqLjYUudvHqOosxi5Xs0BSGvsbSmdjlp9/YVN3TcK0sH2rGjsu+jEnCInK2Db6UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757564888; c=relaxed/simple;
	bh=ymwoN8HVzEu96HC+Scu0Y1rq8pT9FNncKZTtDQc4V+w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D/aAQKeN4ixMle6hwHDc3726VS9yR9FLUL2c4JAUYV8OAwwg5ewHuD0OERo88bFSLnUlTNJe8ZPP49cy38WsEwgcFF06+fJOTbHmMmP1xQani6KYRgzm+y2IA9B+PnPWuhSXamcDRUsmeVF3u/IZ9lKoDmHc7OCfsvssqy7cP6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ft1DMjSU; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ft1DMjSU"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1757564882; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=IUu9taPZoApNbuQhkcFfradbfbsd2faZRK0ukpoOPLU=;
	b=ft1DMjSUeVEpixw4p4mI+jxuRcTG6BqRzETES1dMJym4ERRGuEZiuTtStii84nuEttILnePgGcNkN96Qy1Efo+M1tS0FPfsA1BX0xZIdGkA5lFxwHWHg3cv7WmPVLExVwlyELfkO+TiLc7/dPgR/nLgWEYjVBp9Cpc76Lv0uUrQ=
Received: from 30.246.178.7(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WnkiLzk_1757564880 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 11 Sep 2025 12:28:01 +0800
Message-ID: <998939f5-e0f9-457f-98a2-73f687ad29cc@linux.alibaba.com>
Date: Thu, 11 Sep 2025 12:28:00 +0800
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] acpi,srat: Fix incorrect device handle check for Generic
 Initiator
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: rafael@kernel.org, lenb@kernel.org, robert.moore@intel.com,
 andrew@kernel.org, bfaccini@nvidia.com, eahariha@linux.microsoft.com,
 dan.j.williams@intel.com, thorsten.blum@linux.dev, gourry@gourry.net,
 nunodasneves@linux.microsoft.com, wangyuquan1236@phytium.com.cn,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 acpica-devel@lists.linux.dev
References: <20250910093949.5793-1-xueshuai@linux.alibaba.com>
 <20250910105729.000070a5@huawei.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20250910105729.000070a5@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/9/10 17:57, Jonathan Cameron 写道:
> On Wed, 10 Sep 2025 17:39:49 +0800
> Shuai Xue <xueshuai@linux.alibaba.com> wrote:
> 
>> The Generic Initiator Affinity Structure in SRAT table uses device
>> handle type field to indicate the device type. According to ACPI
>> specification, the device handle type value of 1 represents PCI device,
>> not 0.
>>
>> Fix this by defining explicit macros for device handle types and using
>> the correct check for PCI devices:
>>
>> - ACPI_SRAT_ACPI_DEVICE_HANDLE (0): ACPI device handle
>> - ACPI_SRAT_PCI_DEVICE_HANDLE (1): PCI device handle
>>
>> Fixes: 894c26a1c274 ("ACPI: Support Generic Initiator only domains")
>> Reported-by: Wu Zongyong <wuzongyong@linux.alibaba.com>
>> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
> 
> The actbl3.h additions need to go through acpcia and then have a link
> tag in here to show that it was merged.  Perhaps just fix it with a number
> for now and follow up with the acpcia stuff in the longer run?

Sure, I will drop changes in actbl3.h to make it easy to progress.

> 
> Also note clearly this only affects a debug print - no functional bug.
> That may change whether people choose to backport this or not.

Yes.

> 
> I'm curious on whether you are thinking of wiring this up so that
> we can set the appropriate nodes on PCI Devices other than by doing it
> with _PXM().  For obscure reasons there can be references both ways
> (so DSDT Device entry -> SRAT via _PXM, and SRAT -> Device via this field
> of generic initiators).
> 
> For now we only implement the first one so all we need is a node to be
> instantiated for the GI to sit in.
> 
> Come to think of it the fix that made PCI device entries in DSDT with _PXM
> turn up in the right place was reverted (for a problem with broken firmware
> on AMD threadripper systems - IIRC that I think is long solved).
> Not sure if that path even works today and the one this code is about has
> never been hooked up.

You mean add a new map like pxm_to_node_map[]?

> 
> Thanks for the fix!
> 
> Jonathan
> 
> 

Thanks.

Best Regards,
Shuai
