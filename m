Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793715086;
	b=WJYgat4L4HHqSJ2FdTJZB1/eVk+9LHaoyI6+9vW6iZzLf0NqRDVkIebJWxEEbfhuTIZ4
	 2CydCnvo2vYB95yBNVgddJczVbWNG4j0wiUaoIXB7Pmg6NhckLR5DFr7RB6dRP4kBT1ka
	 1YRGvde8KWWKEn17VcOWKQ9rc+mAf93iZ4kuSDde4eQQa7tzFEVD0BHYl3fLcK01yMPmC
	 gV4THq2/o5PxQiQxmVm+si8wdSFqy1DlSpt15e4u554GltRi9umaLlP3oZ+MkJv97QzlQ
	 2BnXkMyVnr+fgMBTvPCKVqIpInsD+9MtrEtm6f/GJXXzLHDyq+f2Zt2G6lgPuuaDCwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793715086;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=7bHBNa7IZPQ1QbCFBKTfyhdykfY5GVXRYYu9fxpW6k0=;
	b=jIuLzfuQyHjphpOtWeu0rLNFXkKUCdtWqgU3n2L0QnPiytAJ8JW47sa4WlH5WAvSdB6Y
	 TnQS+sLyOHn441Qtdui7l+7v7/wFw2NmbaxUOsgpoRPFAcxjqORJk3NJFbv3+YwfzgiiI
	 jesyw634KwAKGo+5YWljcA1Qw5Z46JOTVAO2x4ZZv0I8m30+zlr7MgqlyuyfCtvRDtZn5
	 43x7Xk6nMMJKDvWEtUBVuJuN+W6TE924JwmxgcX7JapkEXx0eXvf9KbqUUTSm6tFRXBJD
	 fR+UD4aZOdpmI9sbSTk+WVjEuVmGvL2YkBI/pY3oy4/2YJHfXbL4uaJPTkih8Ii4PMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=NkZkFeO0;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E87E606A327
	for <acpica-devel@lists.linux.dev>; Tue,  3 Nov 2026 14:11:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8E87E606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=NkZkFeO0
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9EF121595;
	Tue,  3 Nov 2026 06:11:20 -0800 (PST)
Received: from [10.0.130.179] (e127648.arm.com [10.0.130.179])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1BE533F628;
	Tue,  3 Nov 2026 06:11:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793715083; bh=cTUlnYaVdFBoAxYfMF7MJUgAAOnfL0oBeTH+bYjAzpo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NkZkFeO0akRyTLNwYpkc05k85/oIyVY2rwFujd390pAi7PECXbGlDwkToLNBJmCnF
	 ewONmP+x4adwpIZSqpvC1/D6wUTZXdAYjTWi0lcfbX1tn5AxKA+qze94Qkhq4D1J/p
	 p0F3565Dn4xqLrgUvq3gn7mJatuVqxRGiK5i6u58=
Message-ID: <f326f2c5-9012-41bf-a8da-b2fd9698b9fa@arm.com>
Date: Tue, 3 Nov 2026 14:11:18 +0000
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
Subject: Re: [PATCH v7 0/5] cpufreq: CPPC: Preserve OSPM-set registers across
 hotplug and unload
To: Sumit Gupta <sumitg@nvidia.com>, rafael@kernel.org,
 viresh.kumar@linaro.org, pierre.gondois@arm.com, ionela.voinescu@arm.com,
 zhenglifeng1@huawei.com, zhanjie9@hisilicon.com, lenb@kernel.org,
 ray.huang@amd.com, mario.limonciello@amd.com, perry.yuan@amd.com,
 kprateek.nayak@amd.com, maciej.wieczor-retman@intel.com,
 pawel.chmielewski@intel.com, linux-pm@vger.kernel.org,
 linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev,
 linux-kernel@vger.kernel.org
Cc: linux-tegra@vger.kernel.org, treding@nvidia.com, jonathanh@nvidia.com,
 vsethi@nvidia.com, ksitaraman@nvidia.com, sanjayc@nvidia.com,
 mochs@nvidia.com, bbasu@nvidia.com
References: <20261030092416.1993889-1-sumitg@nvidia.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <20261030092416.1993889-1-sumitg@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/30/26 09:24, Sumit Gupta wrote:
> This series preserves the OSPM-set CPPC registers (Energy Performance
> Preference, Autonomous Activity Window, Autonomous Selection - set via
> sysfs) across CPU hotplug and suspend/resume. On driver unload, it puts
> back the values they had before the driver loaded.
> 
> To do this, it keeps the CPPC cpufreq policy alive across CPU hotplug.
> It also orders the performance-control writes in cppc_set_perf(), so
> that restoring them after a platform reset never sends an invalid
> request.
> 
> Without online()/offline() callbacks, the core tears a policy down when
> its last CPU goes offline and rebuilds it on the way back, re-reading the
> CPPC capabilities each time. The values written to these registers can
> be lost:
> 
>  - Across CPU hotplug or suspend/resume: the platform may reset them
>    while the CPU is offline or suspended.
>  - On driver unload: the driver-written value is left in the register
>    instead of returning to its pre-driver state.
> 
> Handle these with:
> 
>  - Patch 1: orders the Desired, MIN and MAX writes in cppc_set_perf(), so
>    that the platform never sees an invalid request. Christian proposed
>    it in [7], and this version adds fixes found in testing.
>  - Patch 2: adds online()/offline() callbacks so the core keeps policy
>    alive across CPU hotplug instead of tearing it down and rebuilding it.
>  - Patch 3: makes the autonomous selection register helpers take a u64.
>  - Patch 4: saves each register's firmware value at init() and each
>    successful sysfs write as the requested value. offline() restores the
>    firmware values, and online() reapplies the requested values.
>  - Patch 5: extends the same restore and reapply to system
>    suspend/resume.
> 
> v6[6] -> v7:
>  - Patch 1:
>    - clamp Desired into MIN and MAX instead of rejecting it. (Sashiko)
>    - store_auto_select() updates its cache only on success. (Sashiko)
>  - Patch 2:
>    - exit() only frees the driver data. (Sashiko)
>    - online() continues if enabling CPPC fails, as init() does.
>  - Patch 4:
>    - save the requested value on each successful sysfs write, instead
>      of reading it in offline(). (Christian, Rafael [8])
>    - init() fails if a firmware value cannot be read. (Christian)
>    - split the auto_act_window store from perf_limited.
>  - Patch 5:
>    - suspend() no longer reads and saves the registers.
> 
> Christian Loehle (1):
>   ACPI: CPPC: Order performance-control updates
> 
> Sumit Gupta (4):
>   cpufreq: CPPC: Keep the policy across CPU hotplug
>   ACPI: CPPC: Make autonomous selection helpers take a u64
>   cpufreq: CPPC: Preserve OSPM-set registers across hotplug and unload
>   cpufreq: CPPC: Preserve OSPM-set registers across suspend/resume
> 
>  drivers/acpi/cppc_acpi.c       | 318 +++++++++++++++-----
>  drivers/cpufreq/amd-pstate.c   |   2 +-
>  drivers/cpufreq/cppc_cpufreq.c | 530 ++++++++++++++++++++++++++++++---
>  include/acpi/cppc_acpi.h       |   9 +-
>  4 files changed, 729 insertions(+), 130 deletions(-)
> 
> [1] v1: https://lore.kernel.org/lkml/20260623095403.3407436-1-sumitg@nvidia.com/
> [2] v2: https://lore.kernel.org/lkml/20260716153820.2007095-1-sumitg@nvidia.com/
> [3] v3: https://lore.kernel.org/lkml/20260724215937.3368276-1-sumitg@nvidia.com/
> [4] v4: https://lore.kernel.org/lkml/20260806200857.601152-1-sumitg@nvidia.com/
> [5] v5: https://lore.kernel.org/lkml/20260916103820.1760297-1-sumitg@nvidia.com/
> [6] v6: https://lore.kernel.org/lkml/20261020121846.691218-1-sumitg@nvidia.com/
> [7] https://lore.kernel.org/lkml/1be30b2b-e1e5-41ed-a0dc-0dd5ad3c47cd@arm.com/
> [8] https://lore.kernel.org/linux-pm/CAJZ5v0iXip_5Ywk3EkrGL_u2w_hOcGKA1XvrubLPb3diWHx5Lw@mail.gmail.com/
> 

My testing setup is far from perfect, but let's hope good enough:
Tested on Orion O6, AmpereOne and Blackview Ryzen 5 7430U (for ACPI-CPPC only):
- native and emulated CPPC hotplug, both auto-select modes
- S3 on Blackview and s2idle on AmpereOne
- amd-pstate active/passive/guided on Blackview.
Didn't observe any violations in restore order with both native register and
fake support (which silently drops requests before the register write).
Tested-by: Christian Loehle <christian.loehle@arm.com>
