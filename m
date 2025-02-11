Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496A41B85FD
	for <acpica-devel@lists.linux.dev>; Tue, 11 Feb 2025 12:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739275280; cv=none; b=CwArAcinbKNS/4HTq5hC6QUQUJOz1pbHuz/ibk/HLBej1S6eME+s/NIqUzQhuV2Q2eGA2HJLnxyDZCwbM0Brh1Psc4eEtTW1ikVFgW1TFsdIoeW0Fqa4fa4qfMTa4HrfS2ftaewlPR9XUs7YKxosRVdCAPY1iVEqpQy5sx5vpvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739275280; c=relaxed/simple;
	bh=coGhJ4FDslwaXOjbG0NX4DSiL83TYxGibJL0y0TxOxg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=t5MoUDMMMVkNZg+RwGvtB/Z8Z1QY/njSGlLBVhvRoYFOVrcFMOO/XlYV1cuGgypNQKXy6nZdMkF2a36Ar0CtdjRD5m0DPZ2x7gCHKAz4rCHIare+ADvV00/fnWSz/v2gEjD9nkzU79xLQqL6ABJrtYxGpsFVByRsz1RbfH3jGbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Ysg140gk8z1V6WM;
	Tue, 11 Feb 2025 19:57:28 +0800 (CST)
Received: from kwepemh100008.china.huawei.com (unknown [7.202.181.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 51EF71A0188;
	Tue, 11 Feb 2025 20:01:13 +0800 (CST)
Received: from [10.67.121.90] (10.67.121.90) by kwepemh100008.china.huawei.com
 (7.202.181.93) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 11 Feb
 2025 20:01:12 +0800
Message-ID: <b45d0d81-e4f7-474e-a146-0075a6145cc2@huawei.com>
Date: Tue, 11 Feb 2025 20:01:11 +0800
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch 0/5] Support Autonomous Selection mode in cppc_cpufreq
To: Viresh Kumar <viresh.kumar@linaro.org>, Sumit Gupta <sumitg@nvidia.com>
CC: <rafael@kernel.org>, <lenb@kernel.org>, <robert.moore@intel.com>,
	<corbet@lwn.net>, <linux-pm@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <acpica-devel@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<treding@nvidia.com>, <jonathanh@nvidia.com>, <sashal@nvidia.com>,
	<vsethi@nvidia.com>, <ksitaraman@nvidia.com>, <sanjayc@nvidia.com>,
	<bbasu@nvidia.com>
References: <20250211103737.447704-1-sumitg@nvidia.com>
 <20250211104428.dibsnxmkiluzixvz@vireshk-i7>
From: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
In-Reply-To: <20250211104428.dibsnxmkiluzixvz@vireshk-i7>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemh100008.china.huawei.com (7.202.181.93)

On 2025/2/11 18:44, Viresh Kumar wrote:
> On 11-02-25, 16:07, Sumit Gupta wrote:
>> This patchset supports the Autonomous Performance Level Selection mode
>> in the cppc_cpufreq driver. The feature is part of the existing CPPC
>> specification and already present in Intel and AMD specific pstate
>> cpufreq drivers. The patchset adds the support in generic acpi cppc
>> cpufreq driver.
> 
> Is there an overlap with:
> 
> https://lore.kernel.org/all/20250206131428.3261578-1-zhenglifeng1@huawei.com/
> 
> ?

Ha, it looks like we're doing something very similar.

> 
>> It adds a new 'cppc_cpufreq_epp' instance of the 'cppc_cpufreq' driver
>> for supporting the Autonomous Performance Level Selection and Energy
>> Performance Preference (EPP).
>> Autonomous selection will get enabled during boot if 'cppc_auto_sel'
>> boot argument is passed or the 'Autonomous Selection Enable' register
>> is already set before kernel boot. When enabled, the hardware is
>> allowed to autonomously select the CPU frequency within the min and
>> max perf boundaries using the Engergy Performance Preference hints.
>> The EPP values range from '0x0'(performance preference) to '0xFF'
>> (energy efficiency preference).
>>
>> It also exposes the acpi_cppc sysfs nodes to update the epp, auto_sel
>> and {min|max_perf} registers for changing the hints to hardware for
>> Autonomous selection.
>>
>> In a followup patch, plan to add support to dynamically switch the
>> cpufreq driver instance from 'cppc_cpufreq_epp' to 'cppc_cpufreq' and
>> vice-versa without reboot.
>>
>> The patches are divided into below groups:
>> - Patch [1-2]: Improvements. Can be applied independently.
>> - Patch [3-4]: sysfs store nodes for Auto mode. Depend on Patch [1-2].
>> - Patch [5]: Support for 'cppc_cpufreq_epp'. Uses a macro from [3].
>>
>> Sumit Gupta (5):
>>   ACPI: CPPC: add read perf ctrls api and rename few existing
>>   ACPI: CPPC: expand macro to create store acpi_cppc sysfs node
>>   ACPI: CPPC: support updating epp, auto_sel and {min|max_perf} from
>>     sysfs
>>   Documentation: ACPI: add autonomous mode ctrls info in cppc_sysfs.txt
>>   cpufreq: CPPC: Add cppc_cpufreq_epp instance for Autonomous mode
>>
>>  Documentation/admin-guide/acpi/cppc_sysfs.rst |  28 ++
>>  .../admin-guide/kernel-parameters.txt         |  11 +
>>  drivers/acpi/cppc_acpi.c                      | 311 ++++++++++++++++--
>>  drivers/cpufreq/cppc_cpufreq.c                | 260 ++++++++++++++-
>>  include/acpi/cppc_acpi.h                      |  19 +-
>>  5 files changed, 572 insertions(+), 57 deletions(-)
> 

