Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C54327B50C
	for <acpica-devel@lists.linux.dev>; Mon,  2 Feb 2026 04:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770006512; cv=pass; b=CBI2odrwizDyF/MhjCe0wi1vpMbGn9dO+quhE5/kuNK0dczjl4siS1UCZHudRmwWfFM+DVNiN3uEBtBrjNKVa7wUqdWeeOYe2+OV9LaUacpylfAO9HMjN3vRkhIhUX3NrAMYgWXzCtLWZOK0NCIT4Y4rQccIBBfkgLj8rm1pw8I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770006512; c=relaxed/simple;
	bh=pUVGgthQ839+VjER5eMc/k3P643CMKy+SrYbAa3c6hc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jM/IUltqOqxQLkQBK4pCCE5y6L14QSdqAfQOFI+R1AQ8Oz8DyKoDMYjLIxU/0uMp4WzvOZIa3+sxlwXAPDP8vTiZPtjKP5CYO0KB1o/kLvIGr/hJpEID6AoHcnvAyR0ZvmRsfMrDfHixcbbJiLytyulBuyycUuv0sdvYKqKT/gI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=ZzT18WBz; arc=pass smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ZzT18WBz"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-385da75c6e6so39520681fa.2
        for <acpica-devel@lists.linux.dev>; Sun, 01 Feb 2026 20:28:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770006508; cv=none;
        d=google.com; s=arc-20240605;
        b=Oaojp4fi2ZSOs6qN3zHH/gxPOPbOZoHjeTmJylTFESBoVBDtQthk82NFKa0KFu17m3
         /Ac4Lad1s6TMfC7jURzhP4ar5tRocHnlatOpqXM8xKA3V1LH+U1dRynF6McRcmgfb8kC
         pGoWOayVQmZbPSQx2vii+a6nHwhIzs2QudNf7KzBG4YyFFAlO4ywYfP1bLJHEvXWf4a/
         LcHKvDBG4zDq2KsHWrRGC9MwZccrGlWQZvKPTGBA1xZcqb/v+L9J7xCz5ocQ3FrfC1G7
         GenQiJ6lFompDBAgB6/vkzQ45zpkfkrtdd5R6iM3uQaQ7/kBrKUldtt5ZN0nzYHq5q6Z
         S9fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2RZFio6MipuyvvHseqe3FSKD7GaQ7TcS4ZKkrjtcRy0=;
        fh=tqCOxYfExI3+REOWrK9TX/nPnUUbSiW7erfgqQg/9wo=;
        b=LTt9YzTrdS+Pn3gSQFxMXLE//ise/rXrjOYfS1mz6dCQ4xEVyLZUiVADoSUjCVGMnb
         FzMrZVKGVrfQ2sETbqf0ceEfKc4HP5WhjZhEMYWbQxmT4JYGYZqvIJYmtabQq/Z9AGML
         VPXL6m6mrKvbfHrKfbuyf++Iz5pLh+Y+rBXJ/dqKnaL743jxUKBmuNWvDQQsO8gaOBEb
         LDAQE7FaMVQP+ViklUYhzVNqvdu9tge17a0rB7jeQMVhiF7JK0P2WZpLswHj1HbX12YY
         iCUf8eDiP9S79u3bq4XLETYI+mBnOCKOQdoqlk2A1g0VjQnxuVL1KZ9GKhYhymMXtZB6
         8K1w==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1770006508; x=1770611308; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2RZFio6MipuyvvHseqe3FSKD7GaQ7TcS4ZKkrjtcRy0=;
        b=ZzT18WBzQZFgoYLS1R4aBfI04Uruodq6u7jRuuK6VEgx49aZ7ui0ViEdKhtVA3apqO
         m1Yq71NV9fgB4HchaEU96PlSInnwjoCUQHOgA0y3XddigP9PTzfNEoP5lvtyFQISZu8K
         pRof6/GZcXGpNwoYIvCwUMi25vSCetA3j95ubIrcbjDj/cfXW0mEGaay4+hYMLRwi1j3
         rCZK2vDoTkV1aE26ticArOzLVOsFqo9yIfL2t5hMBCDA9L1X/EFq+1nxkAHzmd5hHR/3
         RQIhTHEzdKDDhQTKd4k2K0tBl8/efFhV7lQEjP072y09pynuXDrrLcN5+M5/lv/aoWw7
         yvGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770006508; x=1770611308;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2RZFio6MipuyvvHseqe3FSKD7GaQ7TcS4ZKkrjtcRy0=;
        b=fYz8QqBr8xCkUxptu7gTO11QOv9VUuU5Cmkhmg3tDvZPPXbHCDU972f19404emLL4K
         3NIg0X0PNPoOQblnRd0nORY8dQxKbq8uD6IL1ut5amWTb0Gjfh6AhQxH4L5OIZkmeUlG
         IKublTaIQCOESU6ASIA5bivQK2ZWMmxe+NKjDcNAuKUc/XWXyjEMTzOjw5DRnnAWRS3M
         PkSjKK8z7hRdKrUUvo9GhU4W9TBUdmkiyNjTDYt+65YLO646J/nFrxaKozfVt/N/alUt
         tw3xqaKtuxZ+fgFAtgPVbdvIX8vUnvNPcno8Ii2xMxpzdvu/8C5jCYIO+yAgicu2sSoL
         g4Ug==
X-Forwarded-Encrypted: i=1; AJvYcCVhBKH97pB/x6nBiSmkjV8uP2flxbm0XeAbyDTvaykTdjFWt6ximRsctGdiQsg1YIlJO9FgKMWXPLJPQMg=@lists.linux.dev
X-Gm-Message-State: AOJu0Yy/J+R/ouUBprDG2DetneLxrtDlrbUQ4F+95evFFXmUXWRVjR1/
	rWI50w6Ux1YPIIRjKn7VL1rWVgEKPJqAcSSykLocpuWj5stF/hbIItr1emBNkp/eKz+Tg8fFp9P
	9rOVYgbb5WDoJJwuhgHVW49VyoZOGHR+lcOiaH2AUKzWcMS9HLhQ7v7s=
X-Gm-Gg: AZuq6aIiIpIDcZwybLsN7HyXgmtjMXB40ul2oHhgJmfT0s6xFbhr4bkOf1kMrfIQ3vo
	CAJeVAo0R9JwLHMEh+pUuNjNHSEQrebns4w3yLEIWQPiAwofRc2hyJT+xmm/XY/vV4NaFT3EeY7
	jZF1PKHMyV6UURMg9bA0JE4+6z865rCo/vqkTAKqeORQbwtxcRl457Ynr4qN+0oUXfDkPopAiRf
	org4t75QTS4NL8SJ7xGUwAUDFc4DRtcpnrkTjJe2FA+JhgjdDOi54a0FAeYIOQWrN7tLSwFW7Oc
	aA==
X-Received: by 2002:a17:907:74e:b0:b8d:be69:78bf with SMTP id
 a640c23a62f3a-b8dff5dd77amr628734866b.20.1770006490652; Sun, 01 Feb 2026
 20:28:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260128-ssqosid-cbqri-v2-0-dca586b091b9@kernel.org> <20260128-ssqosid-cbqri-v2-3-dca586b091b9@kernel.org>
In-Reply-To: <20260128-ssqosid-cbqri-v2-3-dca586b091b9@kernel.org>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Mon, 2 Feb 2026 12:27:59 +0800
X-Gm-Features: AZwV_Qh6sUTHEto5Wt3yZWj9_zPb8qdXk_-HeJ2r0Rjdk_jaW_mUHlx9PsMyamI
Message-ID: <CAEEQ3wmK_4y-woedO0htdh3tnO=4SEGwRUrDsGLYRWwsPF105w@mail.gmail.com>
Subject: Re: [External] [PATCH RFC v2 03/17] RISC-V: Add support for srmcfg
 CSR from Ssqosid ext
To: Drew Fustini <fustini@kernel.org>
Cc: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	=?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@ventanamicro.com>, 
	Samuel Holland <samuel.holland@sifive.com>, Adrien Ricciardi <aricciardi@baylibre.com>, 
	Nicolas Pitre <npitre@baylibre.com>, =?UTF-8?Q?Kornel_Dul=C4=99ba?= <mindal@semihalf.com>, 
	Atish Patra <atish.patra@linux.dev>, Atish Kumar Patra <atishp@rivosinc.com>, 
	Vasudevan Srinivasan <vasu@rivosinc.com>, Ved Shanbhogue <ved@rivosinc.com>, 
	Chen Pei <cp0613@linux.alibaba.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
	Weiwei Li <liwei1518@gmail.com>, guo.wenjia23@zte.com.cn, liu.qingtao2@zte.com.cn, 
	Reinette Chatre <reinette.chatre@intel.com>, Tony Luck <tony.luck@intel.com>, 
	Babu Moger <babu.moger@amd.com>, Peter Newman <peternewman@google.com>, 
	Fenghua Yu <fenghua.yu@intel.com>, James Morse <james.morse@arm.com>, 
	Ben Horgan <ben.horgan@arm.com>, Dave Martin <Dave.Martin@arm.com>, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, x86@kernel.org, 
	Rob Herring <robh@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Robert Moore <robert.moore@intel.com>, Sunil V L <sunilvl@ventanamicro.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, linux-acpi@vger.kernel.org, 
	acpica-devel@lists.linux.dev, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Drew=EF=BC=8C

On Thu, Jan 29, 2026 at 4:28=E2=80=AFAM Drew Fustini <fustini@kernel.org> w=
rote:
>
> Add support for the srmcfg CSR defined in the Ssqosid ISA extension
> (Supervisor-mode Quality of Service ID). The CSR contains two fields:
>
>   - Resource Control ID (RCID) used determine resource allocation
>   - Monitoring Counter ID (MCID) used to track resource usage
>
> Requests from a hart to shared resources like cache will be tagged with
> these IDs. This allows the usage of shared resources to be associated
> with the task currently running on the hart.
>
> A srmcfg field is added to thread_struct and has the same format as the
> srmcfg CSR. This allows the scheduler to set the hart's srmcfg CSR to
> contain the RCID and MCID for the task that is being scheduled in. The
> srmcfg CSR is only written to if the thread_struct.srmcfg is different
> than the current value of the CSR.
>
> A per-cpu variable cpu_srmcfg is used to mirror that state of the CSR.
> This is because access to L1D hot memory should be several times faster
> than a CSR read. Also, in the case of virtualization, accesses to this
> CSR are trapped in the hypervisor.
>
> Link: https://github.com/riscv/riscv-ssqosid/releases/tag/v1.0
> Co-developed-by: Kornel Dul=C4=99ba <mindal@semihalf.com>
> Signed-off-by: Kornel Dul=C4=99ba <mindal@semihalf.com>
> [fustini: rename csr, refactor switch_to, rebase on upstream]
> Signed-off-by: Drew Fustini <fustini@kernel.org>
> ---
>  MAINTAINERS                        |  7 +++++++
>  arch/riscv/Kconfig                 | 17 ++++++++++++++++
>  arch/riscv/include/asm/csr.h       |  8 ++++++++
>  arch/riscv/include/asm/processor.h |  3 +++
>  arch/riscv/include/asm/qos.h       | 41 ++++++++++++++++++++++++++++++++=
++++++
>  arch/riscv/include/asm/switch_to.h |  3 +++
>  arch/riscv/kernel/Makefile         |  2 ++
>  arch/riscv/kernel/qos/Makefile     |  2 ++
>  arch/riscv/kernel/qos/qos.c        |  5 +++++
>  9 files changed, 88 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 765ad2daa218..e98d553bd0ca 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -22505,6 +22505,13 @@ F:     drivers/perf/riscv_pmu.c
>  F:     drivers/perf/riscv_pmu_legacy.c
>  F:     drivers/perf/riscv_pmu_sbi.c
>
> +RISC-V QOS RESCTRL SUPPORT
> +M:     Drew Fustini <fustini@kernel.org>

If you don=E2=80=99t mind, to help support RISC-V QoS resctrl development a=
nd
ensure interface stability, could you please add an 'R:' entry with my
email address?

> +L:     linux-riscv@lists.infradead.org
> +S:     Supported
> +F:     arch/riscv/include/asm/qos.h
> +F:     arch/riscv/kernel/qos/
> +
>  RISC-V RPMI AND MPXY DRIVERS
>  M:     Rahul Pathak <rahul@summations.net>
>  M:     Anup Patel <anup@brainfault.org>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 6b39f37f769a..35a6238b02c5 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -595,6 +595,23 @@ config RISCV_ISA_SVNAPOT
>
>           If you don't know what to do here, say Y.
>
> +config RISCV_ISA_SSQOSID
> +       bool "Ssqosid extension support for supervisor mode Quality of Se=
rvice ID"
> +       default y
> +       help
> +         Adds support for the Ssqosid ISA extension (Supervisor-mode
> +         Quality of Service ID).
> +
> +         Ssqosid defines the srmcfg CSR which allows the system to tag t=
he
> +         running process with an RCID (Resource Control ID) and MCID
> +         (Monitoring Counter ID). The RCID is used to determine resource
> +         allocation. The MCID is used to track resource usage in event
> +         counters.
> +
> +         For example, a cache controller may use the RCID to apply a
> +         cache partitioning scheme and use the MCID to track how much
> +         cache a process, or a group of processes, is using.
> +
>  config RISCV_ISA_SVPBMT
>         bool "Svpbmt extension support for supervisor mode page-based mem=
ory types"
>         depends on 64BIT && MMU
> diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
> index 4a37a98398ad..2590b89b8f72 100644
> --- a/arch/riscv/include/asm/csr.h
> +++ b/arch/riscv/include/asm/csr.h
> @@ -75,6 +75,13 @@
>  #define SATP_ASID_MASK _AC(0xFFFF, UL)
>  #endif
>
> +/* SRMCFG fields */
> +#define SRMCFG_RCID_MASK       _AC(0x00000FFF, UL)
> +#define SRMCFG_MCID_MASK       SRMCFG_RCID_MASK
> +#define SRMCFG_MCID_SHIFT      16
> +#define SRMCFG_MASK            ((SRMCFG_MCID_MASK << SRMCFG_MCID_SHIFT) =
| \
> +                                 SRMCFG_RCID_MASK)
> +
>  /* Exception cause high bit - is an interrupt if set */
>  #define CAUSE_IRQ_FLAG         (_AC(1, UL) << (__riscv_xlen - 1))
>
> @@ -317,6 +324,7 @@
>  #define CSR_STVAL              0x143
>  #define CSR_SIP                        0x144
>  #define CSR_SATP               0x180
> +#define CSR_SRMCFG             0x181
>
>  #define CSR_STIMECMP           0x14D
>  #define CSR_STIMECMPH          0x15D
> diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/=
processor.h
> index da5426122d28..183c55e32b96 100644
> --- a/arch/riscv/include/asm/processor.h
> +++ b/arch/riscv/include/asm/processor.h
> @@ -122,6 +122,9 @@ struct thread_struct {
>         /* A forced icache flush is not needed if migrating to the previo=
us cpu. */
>         unsigned int prev_cpu;
>  #endif
> +#ifdef CONFIG_RISCV_ISA_SSQOSID
> +       u32 srmcfg;
> +#endif
>  };
>
>  /* Whitelist the fstate from the task_struct for hardened usercopy */
> diff --git a/arch/riscv/include/asm/qos.h b/arch/riscv/include/asm/qos.h
> new file mode 100644
> index 000000000000..84830d7c6dc4
> --- /dev/null
> +++ b/arch/riscv/include/asm/qos.h
> @@ -0,0 +1,41 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ASM_RISCV_QOS_H
> +#define _ASM_RISCV_QOS_H
> +
> +#ifdef CONFIG_RISCV_ISA_SSQOSID
> +
> +#include <linux/sched.h>
> +#include <linux/jump_label.h>
> +
> +#include <asm/barrier.h>
> +#include <asm/csr.h>
> +#include <asm/hwcap.h>
> +
> +/* cached value of srmcfg csr for each cpu */
> +DECLARE_PER_CPU(u32, cpu_srmcfg);
> +
> +static inline void __switch_to_srmcfg(struct task_struct *next)
> +{
> +       u32 *cpu_srmcfg_ptr =3D this_cpu_ptr(&cpu_srmcfg);
> +       u32 thread_srmcfg;
> +
> +       thread_srmcfg =3D READ_ONCE(next->thread.srmcfg);
> +
> +       if (thread_srmcfg !=3D *cpu_srmcfg_ptr) {
> +               *cpu_srmcfg_ptr =3D thread_srmcfg;
> +               csr_write(CSR_SRMCFG, thread_srmcfg);
> +       }
> +}
> +
> +static __always_inline bool has_srmcfg(void)
> +{
> +       return riscv_has_extension_unlikely(RISCV_ISA_EXT_SSQOSID);
> +}
> +
> +#else /* ! CONFIG_RISCV_ISA_SSQOSID  */
> +
> +static __always_inline bool has_srmcfg(void) { return false; }
> +#define __switch_to_srmcfg(__next) do { } while (0)
> +
> +#endif /* CONFIG_RISCV_ISA_SSQOSID */
> +#endif /* _ASM_RISCV_QOS_H */
> diff --git a/arch/riscv/include/asm/switch_to.h b/arch/riscv/include/asm/=
switch_to.h
> index 0e71eb82f920..a684a3795d3d 100644
> --- a/arch/riscv/include/asm/switch_to.h
> +++ b/arch/riscv/include/asm/switch_to.h
> @@ -14,6 +14,7 @@
>  #include <asm/processor.h>
>  #include <asm/ptrace.h>
>  #include <asm/csr.h>
> +#include <asm/qos.h>
>
>  #ifdef CONFIG_FPU
>  extern void __fstate_save(struct task_struct *save_to);
> @@ -119,6 +120,8 @@ do {                                                 =
       \
>                 __switch_to_fpu(__prev, __next);        \
>         if (has_vector() || has_xtheadvector())         \
>                 __switch_to_vector(__prev, __next);     \
> +       if (has_srmcfg())                               \
> +               __switch_to_srmcfg(__next);     \
>         if (switch_to_should_flush_icache(__next))      \
>                 local_flush_icache_all();               \
>         __switch_to_envcfg(__next);                     \
> diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
> index f60fce69b725..a3c36d18145c 100644
> --- a/arch/riscv/kernel/Makefile
> +++ b/arch/riscv/kernel/Makefile
> @@ -125,3 +125,5 @@ obj-$(CONFIG_ACPI)          +=3D acpi.o
>  obj-$(CONFIG_ACPI_NUMA)        +=3D acpi_numa.o
>
>  obj-$(CONFIG_GENERIC_CPU_VULNERABILITIES) +=3D bugs.o
> +
> +obj-$(CONFIG_RISCV_ISA_SSQOSID) +=3D qos/
> diff --git a/arch/riscv/kernel/qos/Makefile b/arch/riscv/kernel/qos/Makef=
ile
> new file mode 100644
> index 000000000000..9f996263a86d
> --- /dev/null
> +++ b/arch/riscv/kernel/qos/Makefile
> @@ -0,0 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0
> +obj-$(CONFIG_RISCV_ISA_SSQOSID) +=3D qos.o
> diff --git a/arch/riscv/kernel/qos/qos.c b/arch/riscv/kernel/qos/qos.c
> new file mode 100644
> index 000000000000..7b06f7ae9056
> --- /dev/null
> +++ b/arch/riscv/kernel/qos/qos.c
> @@ -0,0 +1,5 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +#include <asm/qos.h>
> +
> +/* cached value of sqoscfg csr for each cpu */
> +DEFINE_PER_CPU(u32, cpu_srmcfg);
>
> --
> 2.43.0
>

Thanks,
Yunhui
