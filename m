Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793805372;
	b=GL43gAqNl/yK3LaMY1gUCGSE2NBrDU6Lgu4dYOYpYv4DbpDXOjhspJgMzgbjxhhf+gBg
	 HkDNROv3SRHcijnz0/UppLIFfXXSAgt33lOE3j2G1qSBMTdzBb+JEFt7CxTyisgwPsilk
	 /mwU247xmw5FSbmP+A/Iuper7+0OHH6/9O8O7yQ0g9kr8abZKk+Mh+u16xeOy8lAHJhPu
	 8Ht6bwQ14zICoX/UillzJ3qxia+tMz6eh3dqKNFLdi5YZWKLrjieS/3W/G4E1yvLzMnbE
	 AHAxHoQq6yI49v4htkkmkw7WwOXSARGNzPyRQHCA4o1/bW5efzKoWv0IteCxyP11jGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793805372;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=6BzJTf+9zOj6b1DI2tW45vlOMvFFlfpqxjqXrxOY85Q=;
	b=Tk+tBJZhIu41gE28EZzNzB9YXb0VqZyDgqJ67QacUMHnDUyTDGJrW8wYl+Qo6VJYFj3y
	 ovOb0pxcgvQStWriUmbfZwzbhivLZRhfCMwJdNNLYbeEVSYYYGJSkiHzW1m7MIFiNWGrc
	 aQsKBW7NvwBWrAJPL/0cxsYK/2LBnUcfhZ9qXsjPNPN8IIyRb+Gf7CRHblvnHMQocthPq
	 +pd/abKA1Zt9Ti4MH8Kdfz4c00AsNFmet93co2nwESOmQ1XuKpLm9YX1FttMt2UKd5ULi
	 rRg16z1LsBCYOdi59tMz9chPWJev/3ygxA0OqcZg6OqIOAxbmswsPgfyHUFmXIqpdzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=e0fUJcYt;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 654196082BEA
	for <acpica-devel@lists.linux.dev>; Wed,  4 Nov 2026 15:16:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 654196082BEA
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=e0fUJcYt
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 63D131576;
	Wed,  4 Nov 2026 07:16:06 -0800 (PST)
Received: from [10.0.130.179] (e127648.arm.com [10.0.130.179])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4722F3F632;
	Wed,  4 Nov 2026 07:16:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793805369; bh=R3BE3Js5qTxa0hvvmDnseDfPGZ0ejh2HVouUW0zy5/c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=e0fUJcYt12inwf8RZGmraI6jvQ2p7fdaOI9jFqHE181GTnyzQdb7oO9dLU0znMeZO
	 ZzkX5lVQC4u7kbxEBBMtIDtGV0RkGwbP/yrcLNB4yirnvz1CueIrDPnvIFYOO2s80n
	 Wvk2JrbqAYwCRNLIsaiOC2Zc4NRwbv60Xmt2Vqck=
Message-ID: <79700c48-e031-422a-a6b6-8c4118131e98@arm.com>
Date: Wed, 4 Nov 2026 15:16:02 +0000
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Post: <mailto:acpica-devel@lists.linux.dev>
List-Help: <mailto:acpica-devel+help@lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:acpica-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 3/3] cpufreq: CPPC: Reflect the OSPM nominal in boost
 and limits
To: Sumit Gupta <sumitg@nvidia.com>, rafael@kernel.org,
 viresh.kumar@linaro.org, pierre.gondois@arm.com, ionela.voinescu@arm.com,
 zhenglifeng1@huawei.com, zhanjie9@hisilicon.com, lenb@kernel.org,
 mario.limonciello@amd.com, maciej.wieczor-retman@intel.com,
 pawel.chmielewski@intel.com, linux-pm@vger.kernel.org,
 linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev,
 linux-kernel@vger.kernel.org
Cc: linux-tegra@vger.kernel.org, treding@nvidia.com, jonathanh@nvidia.com,
 vsethi@nvidia.com, ksitaraman@nvidia.com, sanjayc@nvidia.com,
 mochs@nvidia.com, bbasu@nvidia.com
References: <20261030172745.2045743-1-sumitg@nvidia.com>
 <20261030172745.2045743-4-sumitg@nvidia.com>
 <6392b2cb-0cbf-455a-8c05-c273535b2c10@arm.com>
 <4d9aa879-316c-4188-bc5a-71e3b65e8a3b@nvidia.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <4d9aa879-316c-4188-bc5a-71e3b65e8a3b@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/4/26 15:08, Sumit Gupta wrote:
> Hi Christian,
> 
> 
> On 03/11/26 22:42, Christian Loehle wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> On 10/30/26 17:27, Sumit Gupta wrote:
>>> Boost is the performance range above nominal, so lowering the OSPM
>>> Nominal Performance enlarges the boost range and drops the non-boost
>>> ceiling. Keep the policy limits consistent with the register.
>>>
>>> Add cppc_cpufreq_effective_nominal(), which returns the OSPM Nominal
>>> Performance when set and the platform nominal otherwise. Use it for the
>>> non-boost ceiling in set_boost(), and to update the policy limits when
>>> ospm_nominal_freq is written.
>>>
>>> The cpufreq core caps scaling_max_freq with a per-policy QoS request,
>>> boost_freq_req, that it sets to cpuinfo.max_freq and refreshes only when
>>> boost is toggled. A write to ospm_nominal_freq changes cpuinfo.max_freq
>>> without toggling boost, so cppc_cpufreq_update_nominal_limits() updates
>>> the request itself, rather than leaving scaling_max_freq at the old
>>> nominal.
>>>
>>> When boost is enabled the ceiling is highest_perf, not the nominal, so
>>> the update is skipped. set_boost() applies the new nominal when boost is
>>> turned off.
>>>
>>> A platform with highest_perf == nominal_perf has no boost range at boot.
>>> Lowering the OSPM nominal from sysfs can create one. The core, however,
>>> adds its boost FREQ_QOS_MAX request only at policy setup, and only if
>>> boost_supported is already set. Set boost_supported in init() when the
>>> OSPM register is supported and highest_perf > lowest_perf. Boost can
>>> then be enabled after the nominal is lowered.
>>>
>>> Suggested-by: Pierre Gondois <pierre.gondois@arm.com>
>>> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
>>
>> Thinking out loud here:
>> I'm curious if there's actually a use-case for this, presumably once we
>> let userspace effectively dictate boost allocation, we practically expect
>> userspace to sort out scheduling, too (e.g. by pinning?) and therefore this
>> becomes largely irrelevant?
>>
> 
> I think it is still needed. Lowering the OSPM nominal puts the levels
> between it and the platform nominal into the boost range.
> Without this patch, boost=0 still allows those levels. Userspace would
> then need an extra frequency cap to stay out of boost. This patch makes
> boost=0 cap the policy at the OSPM nominal.

Duh of course, I was somehow too focused on the cpufreq capacity pressure
to not see the obvious one, nevermind and sorry for the noise.

Reviewed-by: Christian Loehle <christian.loehle@arm.com>

