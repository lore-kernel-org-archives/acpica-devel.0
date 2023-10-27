Return-Path: <vincent.guittot@linaro.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 67C824EE8F
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3316C4EE8E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698393845; x=1698998645;
 darn=lists.linuxfoundation.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=boXAGtuda+Qb9m4tektze7XbzOBCPPY4QNhYroPvhtw=;
 b=jOw78M986oMAn2litBIywQOLBDU/oV7Aa7Z9KLI/azTu2bD6UQAZ+kOZLLhAc48lf7
 00MyDq/qeEoTKpfzgsa5shW4qU0zlwKSOpXNPEWELQ43x3Xa/G3eZxv58tE0CvlaCw/A
 y04nBOb6ng8jDgrOU1bQ659WQ8lyXDmBDhDtVKKybR8chQFxZEohjfrjUcgWsVFzeWY+
 5W+Imuor6e0E3mw7702aXDlQR+A7lp9s5IrkxqKe2NHPFdp/zdevXImZjD0acURK+R+M
 7Tmj3Q1Kzl65/O/omHPh9cNWMfW2VLar5lwhs+VC1pmjfrAMy9mtmreVTKXNggRa/ITB
 7iBg==
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Fri, 27 Oct 2023 10:03:53 +0200
Message-Id: <20231027080400.56703-1-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Acpica-devel] [PATCH v4 0/7] consolidate and cleanup CPU capacity
List-Id: "This is the central place for ACPICA developer discussions and
 issues." <acpica-devel.lists.linuxfoundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/acpica-devel/>
List-Post: <mailto:acpica-devel@lists.linuxfoundation.org>
List-Help: <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=subscribe>
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


Changes since v3:
- Split patch 5 cpufreq/cppc
- Fix topology_init_cpu_capacity_cppc() 
- Fix init if AMU ratio
- Added some tags

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

Vincent Guittot (7):
  topology: add a new arch_scale_freq_reference
  cpufreq: use the fixed and coherent frequency for scaling capacity
  cpufreq/schedutil: use a fixed reference frequency
  energy_model: use a fixed reference frequency
  cpufreq/cppc: move and rename cppc_cpufreq_{perf_to_khz|khz_to_perf}
  cpufreq/cppc: set the frequency used for computing the capacity
  arm64/amu: use capacity_ref_freq to set AMU ratio

 arch/arm/include/asm/topology.h   |   1 +
 arch/arm64/include/asm/topology.h |   1 +
 arch/arm64/kernel/topology.c      |  26 +++---
 arch/riscv/include/asm/topology.h |   1 +
 drivers/acpi/cppc_acpi.c          |  93 +++++++++++++++++++++
 drivers/base/arch_topology.c      |  55 ++++++++----
 drivers/cpufreq/cppc_cpufreq.c    | 134 ++++--------------------------
 drivers/cpufreq/cpufreq.c         |   4 +-
 include/acpi/cppc_acpi.h          |   2 +
 include/linux/arch_topology.h     |   8 ++
 include/linux/cpufreq.h           |   9 ++
 include/linux/energy_model.h      |  14 +++-
 kernel/sched/cpufreq_schedutil.c  |  26 +++++-
 13 files changed, 221 insertions(+), 153 deletions(-)

-- 
2.34.1

