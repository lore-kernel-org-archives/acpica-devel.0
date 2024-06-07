Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AC9415B552
	for <acpica-devel@lists.linux.dev>; Fri,  7 Jun 2024 09:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717751423; cv=none; b=M8Os8zm61bjosLqDIn7p91JTFI4pQ7lHugGkLD/aOR6ulXf6Z01iPvbG7YZJrHBumXpFqNgdwa2ga/JN0tkKAYs/+IHTcYzby2u/lOUJ4bwzog/1/v+DzYulvgLGIDt6kG1Cd+UDg3OuHmbV2X708+AYP9MEWfVo7m75hsIhu1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717751423; c=relaxed/simple;
	bh=DYpx4jfQ2pJ69pholDvW6SWXEkPz4I4Vl9+n460bUJI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rUOSxmcNTxfyXtDYrq0M0EGnZuAHZacwZOXKLgcTTOjPKIzLReB3sLyGn/eiu/kQm+qEi4qph1WJiEPEv71WQmWM7Wqci+hhol014EgFhtyT8pKLldNZ+5b9nSWuDUgcftB2WhyixhmYh/O/SMi1Z7SV+gP+JT9FYWFQm28wucc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E08E82F4;
	Fri,  7 Jun 2024 02:10:44 -0700 (PDT)
Received: from [10.57.70.104] (unknown [10.57.70.104])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E3EE93F762;
	Fri,  7 Jun 2024 02:10:18 -0700 (PDT)
Message-ID: <d1ce4b09-c0ac-447e-8779-633bfb2bd8c3@arm.com>
Date: Fri, 7 Jun 2024 10:10:17 +0100
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/1] irqchip/gic-v3: Enable non-coherent
 redistributors/ITSes ACPI probing
To: Amit Singh Tomar <amitsinght@marvell.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: linux-kernel@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Mark Rutland <mark.rutland@arm.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
 acpica-devel@lists.linux.dev
References: <20240123110332.112797-1-lpieralisi@kernel.org>
 <20240606094238.757649-1-lpieralisi@kernel.org>
 <20240606094238.757649-2-lpieralisi@kernel.org>
 <f901fd06-3b6b-4444-a3da-2b75c59059d3@marvell.com>
 <ZmK5Ilk37GyJ4QEa@lpieralisi>
 <02dba55e-39a3-4853-ac52-834cb1c0fc7f@marvell.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <02dba55e-39a3-4853-ac52-834cb1c0fc7f@marvell.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024-06-07 8:53 am, Amit Singh Tomar wrote:
>> On Fri, Jun 07, 2024 at 12:21:54AM +0530, Amit Singh Tomar wrote:
>>
>> [...]
>>
>>>> diff --git a/drivers/acpi/processor_core.c 
>>>> b/drivers/acpi/processor_core.c
>>>> index b203cfe28550..915713c0e9b7 100644
>>>> --- a/drivers/acpi/processor_core.c
>>>> +++ b/drivers/acpi/processor_core.c
>>>> @@ -215,6 +215,21 @@ phys_cpuid_t __init acpi_map_madt_entry(u32 
>>>> acpi_id)
>>>>        return rv;
>>>>    }
>>>> +int __init acpi_get_madt_revision(void)
>>>
>>> Wondering, if we can have a generic function (acpi_get_tbl_revision) to
>>> obtain the revision number for any ACPI table, not just specific to 
>>> MADT?
>>
>> We could - I don't think there would be users other than code in this
>> patch though so I thought it would not be necessary.
>>
> 
> Right, it might not be essential now but I see that MPAM will be another 
> user of it once the MPAM patches are out.
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git/tree/drivers/acpi/arm64/mpam.c?h=mpam/snapshot/v6.7-rc2#n299

Not really; there's already plenty of ACPI code which checks the 
revision of a table *while* also parsing other information from it, and 
that MPAM code is doing the same. Using a standalone function to look up 
the table, check one thing and throw it away, and then immediately have 
to look it up again to do the rest would be needlessly overcomplicated.

The thing in the GIC case is that doing this semi-redundant lookup to 
re-retrieve the top-level MADT header while we're already deep into 
parsing its subtables is still the least-worst option, because the 
alternative would be invasively churning the whole common MADT 
abstraction to pass that information all the way down just for this one 
slightly niche thing.

Thanks,
Robin.
