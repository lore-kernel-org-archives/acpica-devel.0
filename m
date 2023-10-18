Return-Path: <vincent.guittot@linaro.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8AC8682280
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9404282C8E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697646350; x=1698251150;
 darn=lists.linuxfoundation.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Nf9NNvnyBz0qVw4ihr1xxMPaiT6voh2eHkh7WwYLcYs=;
 b=lOrsi4TKTgVD37GWheiyqR+ATda/v7YVCpTV/ObV1MiQmHSLHnhkimerqlAM4T1sEs
 T+5fmqvGDPEzz/t0MGE1Y63H5cQYI6OwxZuRMisB6pppmYfMXd5zXQfRlTbd7TsTcu7c
 q1/i1OVk6vsek6mBm3pGZtpUOMs+mQYtFj9OO/5yFVanDIP3LMUrw2v58BylxvMdJcQS
 wv/9tdim9xk8VH4jE3x64/JgX+WDYuTmmCDDYJMn38WFv0DuPOXsQAUcUoL3mo0zy7gD
 ApoBmGy7HetEpl8mgQ3NG1ibP2sOk8SItdVW1FlcC6v8nf2S6M0G+m1PjxMGKZSBQpnY
 tWDg==
From: Vincent Guittot <vincent.guittot@linaro.org>
Message-Id: <20231018162540.667646-4-vincent.guittot@linaro.org>
In-Reply-To: <20231018162540.667646-1-vincent.guittot@linaro.org>
References: <20231018162540.667646-1-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Acpica-devel] [PATCH v3 3/6] cpufreq/schedutil: use a fixed
	reference frequency
List-Id: "This is the central place for ACPICA developer discussions and
 issues." <acpica-devel.lists.linuxfoundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/acpica-devel/>
List-Post: <mailto:acpica-devel@lists.linuxfoundation.org>
List-Help: <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=subscribe>
Date: Wed, 18 Oct 2023 16:25:52 -0000
To: linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, sudeep.holla@arm.com, gregkh@linuxfoundation.org, rafael@kernel.org, mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com, viresh.kumar@linaro.org, lenb@kernel.org, robert.moore@intel.com, lukasz.luba@arm.com, ionela.voinescu@arm.com, pierre.gondois@arm.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, acpica-devel@lists.linuxfoundation.org
Cc: suagrfillet@gmail.com, conor.dooley@microchip.com, lftan@kernel.org, ajones@ventanamicro.com

cpuinfo.max_freq can change at runtime because of boost as an example. This
implies that the value could be different than the one that has been
used when computing the capacity of a CPU.

The new arch_scale_freq_ref() returns a fixed and coherent reference
frequency that can be used when computing a frequency based on utilization.

Use this arch_scale_freq_ref() when available and fallback to
policy otherwise.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
Tested-by: Lukasz Luba <lukasz.luba@arm.com>

---
 kernel/sched/cpufreq_schedutil.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 458d359f5991..6e4030482ae8 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -114,6 +114,28 @@ static void sugov_deferred_update(struct sugov_policy *sg_policy)
 	}
 }
 
+/**
+ * cpufreq_get_capacity_ref_freq - get the reference frequency of a given CPU that
+ * has been used to correlate frequency and compute capacity.
+ * @policy: the cpufreq policy of the CPU in question.
+ * @use_current: Fallback to current freq instead of policy->cpuinfo.max_freq.
+ *
+ * Return: the reference CPU frequency to compute a capacity.
+ */
+static __always_inline
+unsigned long get_capacity_ref_freq(struct cpufreq_policy *policy)
+{
+	unsigned int freq = arch_scale_freq_ref(policy->cpu);
+
+	if (freq)
+		return freq;
+
+	if (arch_scale_freq_invariant())
+		return policy->cpuinfo.max_freq;
+
+	return policy->cur;
+}
+
 /**
  * get_next_freq - Compute a new frequency for a given cpufreq policy.
  * @sg_policy: schedutil policy object to compute the new frequency for.
@@ -140,10 +162,10 @@ static unsigned int get_next_freq(struct sugov_policy *sg_policy,
 				  unsigned long util, unsigned long max)
 {
 	struct cpufreq_policy *policy = sg_policy->policy;
-	unsigned int freq = arch_scale_freq_invariant() ?
-				policy->cpuinfo.max_freq : policy->cur;
+	unsigned int freq;
 
 	util = map_util_perf(util);
+	freq = get_capacity_ref_freq(policy);
 	freq = map_util_freq(util, freq, max);
 
 	if (freq == sg_policy->cached_raw_freq && !sg_policy->need_freq_update)
-- 
2.34.1

