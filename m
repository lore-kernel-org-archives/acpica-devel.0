Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B017333E7
	for <acpica-devel@lists.linux.dev>; Mon,  2 Feb 2026 03:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770002288; cv=pass; b=dXHZ2UB5l/6PQTjUqR/DZ1V9lLASvvd3F2CtKTxQj/t310TC1wJA806hnF9X99z9J6+tVDPvfOG2BmSzmlgJ8pL6Mw+CeaG9j7hD0dC6EXgcvGuL9n4FfTn9zoTVvAziidGLYReDzcuOySeqS8VCRfIEHXNefD+5tgP+GsZQB7o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770002288; c=relaxed/simple;
	bh=ShGgQhbThQ6I+6O+faNv+aPbTubcoIQhkPUIA0b5/DY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YOfMlQz7ozLMrP/ThwnrSWHRqV/5ML1iOuY3Edr17Fd95vx4Y+4LgUVzrdp8+137Qonj9UM9+lPDx+i0Kjs7GAzYkA/MKfP4JZsoc4RJf/ZD0UDS+D3/UONlXSg04Mn7+3uGh5X0wG0v5uSOojNFyPdEOgaudTi3ErxxeDm40KI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=UjhpvPtO; arc=pass smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="UjhpvPtO"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-658d54197d3so6439297a12.0
        for <acpica-devel@lists.linux.dev>; Sun, 01 Feb 2026 19:18:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770002284; cv=none;
        d=google.com; s=arc-20240605;
        b=FM3JmU9b0HR5FkC2R5qDQkJHbUi4ckuzaV70KCjQeQGKMiHpyJVpXbeIGgjqnP4crT
         IlpKZApuZ2vYvF7ukt/8f/OnuZNAyZWv7nV1uDg9blths+nZ3Cgq2dIunhCMt5CwcqRY
         wxTyl25fAUrTCtZ1cPvFxe4g8KJUeAPfjJ6LvrRDenTAj01+dEwkTJiW2N7unrRDlHt6
         SIxuWXYNIpXcDYSxs3Rijx0EBjwAKdFi6t7d9CLHa+ILW2j/CYpt5Pqtobc43nx69vf3
         t3PZm2tBQNfcjcSn4uPjI8JNkrFNkyL6Y4RVE9WTSIaVWsEn5vGeIMJ8Ydc3qoEiRvqS
         l8cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=f2z9Nua1MUqgPyVmhT784kx+od6sNmMKO2jLUk+q1qQ=;
        fh=3mklhnpu4RbJJX8oAP2WSQNRGMZBY26a8BRl9ng7WIw=;
        b=Xondqlz0VCasrJd/e9avaR3nIeILDiIQ70MlovJ3cN3vj0ofv1nN6MjqRJhBr1AA7N
         ROYeDoTuqf2BulsdSN3G1OptVU0z8YJAjYh2oAivcr/dwlXkmvJ1y/CjgV7dUGrlFQM7
         ApvVExxLdmUTeaAjrnaqb2aIsUq+w8pwa8ALFVjzSvfQZfGHbEjQPdjSIeXHBb8aG22v
         VOmmq/2EWK+//okTXxTbg9h9VFHF+mCUMae/qZfW5rGFNJ4gRpk7v+sGr4ShAiTmwwKk
         za41cSacvXtEz+zgZSFaHLouw1ETvp7yD5bBXxbHc/RVyPjFQDNAdCD5rSoKBuk3InWB
         xX9w==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1770002284; x=1770607084; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f2z9Nua1MUqgPyVmhT784kx+od6sNmMKO2jLUk+q1qQ=;
        b=UjhpvPtOJITJZwZLRiFUmO0wYr4DinsAS2Rx7GWFbqcu5EjnSvdvSV/J9yXH+YYhSd
         op4jyKWhYz2b3e76f5QfatR8/taFVO6VtR7BO+fpQNHXTIYyI7Ah5MVJeaOSo7gzHe5a
         RjrkszbXwcpoqrEVvtJdPFumQKcqPu+fsdzaf8RmmQsl1XhGJ67Dk6DMgkSNC/UcExGV
         kEpq0RALXCOgFFZiLsis8iGYSC5T0AwGqr6kZVdhH1Z3z1r37uv0BWSfIUibZWp9QVCz
         zSeD8AMGVQE6u4rR5K0ddOH82nk3a9QD+AFeX9BrrtPSXpok5v8pqOSu+x5glmDIO/f3
         9vxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770002284; x=1770607084;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=f2z9Nua1MUqgPyVmhT784kx+od6sNmMKO2jLUk+q1qQ=;
        b=mAIW34gESgcN+56Q5FPFKTNcRHNEc2dAliyMDlA81FGpUihY3vcp7wWePQxpKZiYEl
         3vKxktZ9L0TiHWKAzIxjBqKiPf1q7+TAJDGDl4BOq2+Gr1YeQ6/oU7iUbFZ5x5ie5py6
         C8XMRUmvRSgJmqf1brjx2qxLllYhc38e+8dHprtvbAM8obSSSeLQXmqoEyIa7TZ888W4
         k8isPS0SPAHrqMfvST2N/ofPAZ9gYY3RMBi3QLIDETmhDzVhyII5k7FolPFJUIsqg13w
         iVbSistEHHuEVYRVbWQrphnPVLTg9H0Yl3UPyOIXR3Qe17OZJi0DIoPH4HqrHVOib2hC
         yXvQ==
X-Forwarded-Encrypted: i=1; AJvYcCXHCPc/0gEKfCpf3RdOMoncteUIxpihlJcBJmrNpFd4DqX23Lk0lzlmk+AJhT7XNj+S/kUPBeTX8Yjq54k=@lists.linux.dev
X-Gm-Message-State: AOJu0YwSyt+AbhX/SBBxVikLOe2ud8X6i3mMltW7k360J3RJzZQxu2yr
	s7wP2y8GLZ9Oq3148/DZLMK9sTW156wSULPnsBIOLyN8cgg2IORRMOrGKJOnRD5/Gpl13iIC8Or
	UT6tfwX+LsKyew25sxiPQ/FqZbVAO5w8QKGK0XTPt5w==
X-Gm-Gg: AZuq6aIbH7/RFBSKQaG+KCsm0jbIrDWemDFEwYRMNJpT5ThCPlaa1T3xcTN1g8Ezz7g
	w04xMnapXEdz9eBwaGVF905YSGnPjj5ijIllU38x/0ZjseDIfKGFzahd60bMwVBb295Lbmrf9Mq
	t3HnsGp2grX6fxZZijnoWIkwtXZ6HMjSk5HAtk61TLlsVmIyNtT0MpIbBhBDqat5QukNg84cpwF
	vuLJ4oMZuSHbQdO162gaddaUuzxKX1hhadRA7srRZmvZkq7qn/cfPLtdRw7V7XiwlmSCZFi2hQV
	8w==
X-Received: by 2002:a05:6402:146e:b0:64b:5885:87d6 with SMTP id
 4fb4d7f45d1cf-658de5936acmr5660707a12.24.1770002283907; Sun, 01 Feb 2026
 19:18:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260128-ssqosid-cbqri-v2-0-dca586b091b9@kernel.org> <20260128-ssqosid-cbqri-v2-3-dca586b091b9@kernel.org>
In-Reply-To: <20260128-ssqosid-cbqri-v2-3-dca586b091b9@kernel.org>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Mon, 2 Feb 2026 11:17:52 +0800
X-Gm-Features: AZwV_QjLj_QCXAGGOyiKRELyI0nXPUskAFHV0pKdx8_ngOCQOAP2pJR-3btcosk
Message-ID: <CAEEQ3wkqC4jFf1LGgh2c6dgGwT=tuvpFV+D4fiw40P3LZ7_8hg@mail.gmail.com>
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

Hi Drew,

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


First set the cpu_list, and then the condition thread_srmcfg !=3D
*cpu_srmcfg_ptr will not be satisfied. Is a default value required
here? Both code paths for cpu_list and tasks are compared against the
default value; you may refer to the implementation of mpam.

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
