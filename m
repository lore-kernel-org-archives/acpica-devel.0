Return-Path: <vincent.guittot@linaro.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 623E74190B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org F414540642
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697646345; x=1698251145;
 darn=lists.linuxfoundation.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=aBPvPoGvatc00L33SJsgf3xSxpMurf+haw6UVXLiWPI=;
 b=CADB3aldFT3ugpY5D5Lzite15jgRZDOrB5fg5QC69km8gytoeWEgnndMRBGnVTbKRg
 /kJqIqpWINyqYQ3BX/3pHaBiokqUJMlK1dNS0kYH98VKSKxc7tEdLP8S97jwkokK1P3D
 PHJ+HN86h5YSbk7/mLGm6WabTtdxUDqphou1Emr4Y/LGYzE6NHNQ0Iv/kBTqfjWvYy+q
 a6AVyId1WNJXKBWAjCMYyvyuQ9BeprLTiMJz/A8yqKluEk8y95COob+sfNDvYUoUK7ii
 fKq3Gld+Zu9oyJz7CRQK9Asj604K2YqY4bwtaeiq8/MFy8kiCJ5UJ1g9ooFpZhBXlojS
 h5dA==
From: Vincent Guittot <vincent.guittot@linaro.org>
Message-Id: <20231018162540.667646-1-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Acpica-devel] [PATCH v3 0/6] consolidate and cleanup CPU capacity
List-Id: "This is the central place for ACPICA developer discussions and
 issues." <acpica-devel.lists.linuxfoundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/acpica-devel/>
List-Post: <mailto:acpica-devel@lists.linuxfoundation.org>
List-Help: <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=subscribe>
Date: Wed, 18 Oct 2023 16:25:51 -0000
To: linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, sudeep.holla@arm.com, gregkh@linuxfoundation.org, rafael@kernel.org, mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com, viresh.kumar@linaro.org, lenb@kernel.org, robert.moore@intel.com, lukasz.luba@arm.com, ionela.voinescu@arm.com, pierre.gondois@arm.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, acpica-devel@lists.linuxfoundation.org
Cc: suagrfillet@gmail.com, conor.dooley@microchip.com, lftan@kernel.org, ajones@ventanamicro.com

This is the 1st part of consolidating how the max compute capacity is
used in the scheduler and how we calculate the frequency for a level of
utilization.

Fix some unconsistancy when computing frequency for an utilization. There
can be a mismatch between energy model and schedutil.

Next step will be to make a difference between the original
max compute capacity of a CPU and what is currently available when
there is a capping applying forever (i.e. seconds or more).


Changes since v2:
- Remove the 1st patch which has been queued in tip
- Rework how to initialize the reference frequency for cppc_cpufreq and
  change topology_init_cpu_capacity_cppc() to also set capacity_ref_freq
- Add a RFC to convert AMU to use arch_scale_freq_ref and move the config
  of the AMU ratio to be done when intializing cpu capacity and
  capacity_ref_freq
- Added some tags

Changes since v1:
- Fix typos
- Added changes in cpufreq to use arch_scale_freq_ref() when calling
  arch_set_freq_scale (patch 3).
- arch_scale_freq_ref() is always defined and returns 0 (as proposed
  by Ionela) when not defined by the arch. This simplifies the code with
  the addition of patch 3.
- Simplify Energy Model which always uses arch_scale_freq_ref(). The
  latter returns 0 when not defined by arch instead of last item of the 
  perf domain. This is not a problem because the function is only defined
  for compilation purpose in this case and we don't care about the
  returned value. (patch 5)
- Added changes in cppc cpufreq to set capacity_ref_freq (patch 6)
- Added reviewed tag for patch 1 which got a minor change but not for
  others as I did some changes which could make previous reviewed tag
  no more relevant.

Vincent Guittot (6):
  topology: add a new arch_scale_freq_reference
  cpufreq: use the fixed and coherent frequency for scaling capacity
  cpufreq/schedutil: use a fixed reference frequency
  energy_model: use a fixed reference frequency
  cpufreq/cppc: set the frequency used for computing the capacity
  arm64/amu: use capacity_ref_freq to set AMU ratio

 arch/arm/include/asm/topology.h   |   1 +
 arch/arm64/include/asm/topology.h |   1 +
 arch/arm64/kernel/topology.c      |  18 ++--
 arch/riscv/include/asm/topology.h |   1 +
 drivers/acpi/cppc_acpi.c          |  93 ++++++++++++++++++++
 drivers/base/arch_topology.c      |  56 ++++++++----
 drivers/cpufreq/cppc_cpufreq.c    | 141 +++++-------------------------
 drivers/cpufreq/cpufreq.c         |   4 +-
 include/acpi/cppc_acpi.h          |   2 +
 include/linux/arch_topology.h     |   8 ++
 include/linux/cpufreq.h           |   9 ++
 include/linux/energy_model.h      |  14 ++-
 kernel/sched/cpufreq_schedutil.c  |  26 +++++-
 13 files changed, 225 insertions(+), 149 deletions(-)

-- 
2.34.1

