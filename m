Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.136
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794387040;
	b=Ti7PLRTCAyRvthEzSAIPMLYv/GeWLrg2aZJnRVxl000huZ+5TV8j7Snezi9f/BfX9Fce
	 GeoKS1pRhC5FWODrBKw9SW1ZO2YwmOsn4jk/1UjRh13l2+fDp3nJdxixCbRByHV+8+UwR
	 3eqDbBMzkgEfjU+29q/fFAoYvr+JMqbA40WnPAI9rPQ3JIzdo9q1SGLOkmsxJB8wDIvkL
	 Ru1ZL+UzTKb/GSl9yVaL7KpTH5OPcT8Ln1gAarTNmaD7CpsTQqgDaJvori0ny6fxackhc
	 F0KkNfGo7nGn+F3NNT8RcqEEucj/enFjgA1HDiVBc/CM0qNiZrTAi3bWqPMhQJ/wIHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794387040;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=zCRooG2x6MjJhhdGz/yUbWYEgmkxtWTULJ4B2gjVcXc=;
	b=FCkBD4ykzRn3POyl7teMETZhnf5lDYhXLKrqucXq7+8ETCpzzCCLBhpqFK1hbs2nF/tS
	 9ZGbB4EuR7iWNKMRrkydjM7GgHfznGXownF8OuL32F2el8cRrzTtLFt0QX9AzIr33Naq9
	 7B8V3MvtF0Ecjipp2/73IU2dcmNJyN3+kUJ2tWi7ThfZ9WkKLZL6Hd+XdpBhbKsn0xQxt
	 XIE8HTB/26EBm493/F6lBKYd4O4oTHeiIX8BgFrJX273T9OrsEosKL1/8gCnd64egOUV5
	 7hRm1QAYPhsB3M3BOBk7cwcHvLUD3dhwyr4+D08uetVCdwy3j9tIDl/TmBAv7sYkPog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kylinos.cn;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=74.125.227.136
Received: from mail-pj2-f8.google.com (mail-pj2-f8.google.com [74.125.227.136])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214CD606A32A
	for <acpica-devel@lists.linux.dev>; Wed, 11 Nov 2026 08:50:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 214CD606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj2-f8.google.com with SMTP id 98e67ed59e1d1-3b0ae89de91so1726873a91.1
        for <acpica-devel@lists.linux.dev>; Wed, 11 Nov 2026 00:50:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794387039; x=1794991839;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zCRooG2x6MjJhhdGz/yUbWYEgmkxtWTULJ4B2gjVcXc=;
        b=ORSdBjFOibF87ZCJ80+AcFWd7VmHI5MQ1f6Rf66t5uunMl9R/mTSMJt36M9W6as5pg
         HFiobCm8YDjzzNi/GU+8G+P3ClywgIuPP8XxY91ReMhorPzif0ETb09qYl7CFE5g/Nu0
         qum9FmXb9ww1uZM80KtGYJV4x3+eCkTlD0MpFYWg6JsXDM9JSR276v+DaFK7zeOVEYLB
         m5pawr5cXp5bB+cMW+BUb96FSIdSqYU8CgDslIz+f/U9SXP+x179QCjXjbJhWR0aj9Lv
         adkEE4mNHeU2m1YV6Cl4JVFCqTPcYFn8yVtAh1N7/wyGk6xezeIPycDjPzcScdOMLJum
         1RkQ==
X-Forwarded-Encrypted: i=1; AL+hErHM7XrEPGR5tll4z7HTbG2TfTlVuafXy8eC1Hfg5jBJ4FMi8OIpc/tyrTSHIjxMN2CwnROAZVJUbFULTm8=@lists.linux.dev
X-Gm-Message-State: APuU4Z81VpGWXVoG3xc6s5KFRgR9MdNYITOR9QkpK7KaAfdNiEFAu7HF
	g29ANnpk+iVyI5ZFympnl2ZLhMofmRqtKd6XGOxEhO8RH2MibuMkZ7gj
X-Gm-Gg: AYBFou1b/Fx7PxD63iqnINWNBlRL8rgjv9zQZ977l8S92LHNNPIn6cnezqeygw/31Al
	lStn05zncucNNDWHJvLfFj77oR6sGKd7lndhMn+x7RE0MlcBl1Vk6zURB4ZrY+H8INVTc8g8wzH
	D2fOYBfVsjmlYXZMkR7ek8DUqlS09KRlWCWpEouuCFu8xvkiPrphy8TdtRuvdMj9kvAH1W1ZpwA
	G09hoORoofsvEWbTwhivf221/4BxRAbGoVnBXsJyrlSDbFhhSQNCjksc85BVXNQhq111l9twKFA
	XbzNTIijJvQWAcdUyoOdgv3sahBLETm8TSD5p5vQ3B3mEPMLzpt6oq77Mp+lzgXMhiTPS45ubvY
	5XiWKaHKp9Ui6n9fwiJ0pZyizIrCFGnVcKp30TLEU58o9szspW8Ia+cuLeR2deT0joUp5C6SBZ3
	uCBCLYYZA/K1rqyBewXQ3JIV+P46oUvzEJBo529St5WnrgWc3rMFtPE3kipvhtEnOWnWCSJaDyH
	/J5IZN3y+5zaWYB0NHvg1N2JCX44OJmbDA9Qy3hlO1KImHjdDwnZgQIs8tZ1x+qhhSNMv6tXbfN
	lfqi3pmhU9hLwHpRR9xVZtlYt/3MqSph0t7eZAixhOd+B9N5sWQ=
X-Received: by 2002:a17:90b:4fd0:b0:3ac:9f00:3bc7 with SMTP id 98e67ed59e1d1-3b182eee784mr1752558a91.33.1794387039460;
        Wed, 11 Nov 2026 00:50:39 -0800 (PST)
Received: from kylin-XiaoXinPro-16-AHP9.. ([116.128.244.169])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1838e616dsm2396406a91.4.2026.11.11.00.50.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 00:50:39 -0800 (PST)
From: Xueqin Luo <luoxueqin@kylinos.cn>
To: rafael@kernel.org,
	viresh.kumar@linaro.org,
	sudeep.holla@kernel.org
Cc: zhanjie9@hisilicon.com,
	christian.loehle@arm.com,
	zhenglifeng1@huawei.com,
	sumitg@nvidia.com,
	lenb@kernel.org,
	maciej.wieczor-retman@intel.com,
	pawel.chmielewski@intel.com,
	gregkh@linuxfoundation.org,
	dakr@kernel.org,
	johan@kernel.org,
	ionela.voinescu@arm.com,
	pierre.gondois@arm.com,
	linux-pm@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	driver-core@lists.linux.dev,
	Xueqin Luo <luoxueqin@kylinos.cn>
Subject: [PATCH v6 0/3] cpufreq: cppc: Handle Highest Performance changes at runtime
Date: Wed, 11 Nov 2026 16:50:19 +0800
Message-ID: <20261111085022.1229866-1-luoxueqin@kylinos.cn>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Post: <mailto:acpica-devel@lists.linux.dev>
List-Help: <mailto:acpica-devel+help@lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:acpica-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Rafael, Pierre, Christian, Jie,

This series adds support for handling ACPI CPPC Highest Performance
register changes at runtime, triggered by Notify(0x85) on a processor
device. When the platform changes the Highest Performance value, the
OSPM must re-evaluate the cached capability and propagate the change
to the cpufreq policy, the scheduler's CPU capacity model, and the
frequency invariance engine.

Concrete use cases discussed during review of the previous versions:

- A processor can age over time and its core frequency degrades. It
  is good if platforms can make OSPM and userspace aware of this
  (Jie, Christian).

- Platform operating mode changes between "performance" and
  "powersave" (longer battery life) when the top-most OPP is a
  high-cost one (Rafael).

The mode-switch use case can also move Highest Performance back up,
e.g. when switching from powersave back to performance. update_limits
therefore accepts changes in both directions, capped at the Highest
Performance probed at policy init, as proposed by Christian: any
value above the first probe is ignored, since it would allow boost
support to appear after policy init, which the cpufreq core cannot
handle today (the boost QoS request is only created at policy init).
A policy that started without boost cannot gain it at runtime;
supporting that would need runtime QoS request creation in the core
and is left for later.

v5 -> v6:

- Cap runtime Highest Performance changes at the value probed at
  policy init (Christian): any value above the first probe is
  ignored, since it would allow boost support to appear after policy
  init, which the cpufreq core cannot handle today (the boost QoS
  request is only created at policy init). Within that bound both
  decreases and increases are accepted, so a platform switching back
  to a performance mode restores the previous Highest Performance
  (Rafael's mode-switch use case).

- Refresh the topology capacity for every CPU of the policy
  (policy->related_cpus, covering offline CPUs of the domain as
  well) instead of only policy->cpu, so a shared-policy Notify(0x85)
  targeting any CPU of the policy refreshes the whole domain at
  once (Christian).

- Trim the internal helper comments (cppc_cpufreq_sync_boost_limits(),
  cppc_cpufreq_set_autonomous_perf()) down to the essential notes,
  drop the debug-only value dump, and report boost QoS sync failures
  through pr_err (Jie).

- Ignore values that would drop Highest Performance below Nominal:
  they violate the CPPC invariant and cannot be handled cleanly, so
  the special-casing for them is gone; such
  values are now warned about (Jie).
  topology_update_cpu_capacity() rejects such values as well, to
  match the boot-time validation.

- Return early from cppc_cpufreq_update_limits() when the policy is
  inactive: a concurrent CPU offline may have freed the driver data
  after cpufreq_update_limits() acquired the policy reference.

Note: proposed spec extensions would allow nominal_perf to change
at runtime [1] and introduce a highest_freq value; neither is
handled here.

[1] https://lore.kernel.org/all/20260430142430.755437-3-sumitg@nvidia.com/

The series is split into three patches:
  Patch 1: Core update_limits callback with boost QoS handling;
           runtime changes capped at the boot-probed value.
  Patch 2: Refactor autonomous perf bounds into a reusable helper
           and wire it into update_limits with error logging.
  Patch 3: Topology subsystem runtime capacity updates with
           validation, early-return optimization, and concurrent-safe
           normalization for all CPUs of the policy.

The v5 series was tested on an arm64 8-core big.LITTLE system with runtime
highest_perf changes injected through a debugfs hook that exercises
the same code path as ACPI Notify(0x85), including values above
1024 and full capacity re-normalization (see the v5 discussion for
the measured capacities).

Xueqin Luo (3):
  cpufreq: cppc: Add update_limits support for Highest Performance
    changes
  cpufreq: cppc: Refactor autonomous perf bounds into helper
  arch_topology: Add topology_update_cpu_capacity() for runtime updates

 drivers/base/arch_topology.c   |  77 ++++++++++++++++
 drivers/cpufreq/cppc_cpufreq.c | 157 ++++++++++++++++++++++++++++++---
 include/acpi/cppc_acpi.h       |   1 +
 include/linux/arch_topology.h  |  13 +++
 4 files changed, 235 insertions(+), 13 deletions(-)

Cc: Ionela Voinescu <ionela.voinescu@arm.com>

-- 
2.43.0
