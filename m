Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 593CE53387
	for <acpica-devel@lists.linux.dev>; Tue,  5 Mar 2024 09:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709632460; cv=none; b=T46C0yjthnGvULf7mEHK6hmJUgnzuF8tpk/y+ad9tgDpmJU9EzP18+MG/Ko5gaZrBXeYmcAx0Kxb8a6XQQlMv9ent5JdhL9NJpROH24e8cPrclKMOSsKV1BkTd8ynDCDSOIehB4TTENiRviVtqf0TCKV5g+7J8vQtqvcP5aIAuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709632460; c=relaxed/simple;
	bh=jNKTZwm/zMfNHRVTfXkmKdJ1UALCfxs1UkH3Gqlh3T8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UXhFkbftsQasLicClHUFIuy4X27gIPzq4GHtZzZk6jmlnY7rbIPvw1uA2yALm2qvZy/DA3u2HhcgJzj7OXVnBKfnPLgOgrHy/KRX434xWpeRkHWe5eYZEmNAaAaav9WtJe7I82EjOEP20FctKRnUGuL1TEAzi+yPJ9on1/yfEWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PsmUcX8p; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PsmUcX8p"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2d3f8f7a68dso202871fa.0
        for <acpica-devel@lists.linux.dev>; Tue, 05 Mar 2024 01:54:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709632455; x=1710237255; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IhM0d+kE3plPStk/1c/yuQp6Ohx1jtFSVotBp1VMtT0=;
        b=PsmUcX8p2550GjHHSA1UFd9bVqC6ze45eBLdKFIbBFjJwWOu7BpAN1TXHtBQbeneqz
         WecXUMk1Yq/15v/E62/iJ8CPo81/8vH/UCZJdh/X1jkvoS7waNkm8rB23vBj1QT9Gi8Z
         eX1og4F9ro0xrF3nokxVbXjySilfsS/2L2WV2X0qSwOdsPSjlByBINS5KFwPoAPQMD9c
         dGuzRDeibUlCLOl32o3H4hETxzWecJSOxtonbhiGwMPe58WZqVWY76vGj1xhY0s0LHN4
         D52J4XgwWXIL5KGGsq5kqZr/1h2NGr5woRlKPt2hZFXMDrBtSI4db/kVz7uEM9EDsC1n
         PMgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709632455; x=1710237255;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IhM0d+kE3plPStk/1c/yuQp6Ohx1jtFSVotBp1VMtT0=;
        b=wDs9cqE8eNEy/3MIX9mwLFL9ZHFiuiy6lLyDZvV1AldUupn77RvQjDyxtz8vi8lcCl
         hM1fPRlzEW5z4wBwUIEtGRb68ycbzX2OjtK2w/+Pvkyf8S9RyeeK7hJM/xWN1mm8iUyr
         Ss0ZK+Ur+048fWVT908oTCZM/5Ldp4E+N0j8x3emkUnUb3W4HGd/zLvftLXAcKNkQqn5
         agrl1EsrCyXEP0cjN2HHVvBhh0v5DzqJx1JSPRXgwij9iTjhS8lhTQU7sKL04UkfMLSW
         b2ioNV4uijpptwjhYlUCCHLQPdXKJpIxa8DVVwSqAwvun9IhFT+hrMdXxBqk5UXAyA6y
         Sxbw==
X-Forwarded-Encrypted: i=1; AJvYcCXkJQZ7wRc9sCPL+SHTOf62GuawDsWISjxFjshjflH16u5hzzO49XH92ZGrDKXF17reNsMmxdB4wB3u+niZ30mkMcqeD0M+zPjtsw0p
X-Gm-Message-State: AOJu0YyWjy1loXiNn4MWOy2l3uejnpfnNbW+hK6RrKzqX1g/cik0fr74
	3SoQFGrFl3dBltLsZyzU6x+LBJo1+4hh8fjkUi1o3iD44ibvosFGRVxOm86BPfHjAs70TzbAv5G
	hildb1zD8yVjjA4Bnl2yYUfLRZY8=
X-Google-Smtp-Source: AGHT+IH1y9jM5ofau5NwHul6UpdGMvJwJR/Hnp3eSxZzRLtAunZCfh8YQZeZqH/2FRZAHfwcwFqRRstPSKvzL71iuUQ=
X-Received: by 2002:a2e:9252:0:b0:2d3:e6ce:75cc with SMTP id
 v18-20020a2e9252000000b002d3e6ce75ccmr602516ljg.18.1709632455055; Tue, 05 Mar
 2024 01:54:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1706603678.git.haibo1.xu@intel.com> <799dcc07f41c2357328e9778fbbded7818af34a7.1706603678.git.haibo1.xu@intel.com>
 <ZeasjVWuyeiAlF8y@sunil-laptop>
In-Reply-To: <ZeasjVWuyeiAlF8y@sunil-laptop>
From: Haibo Xu <xiaobo55x@gmail.com>
Date: Tue, 5 Mar 2024 17:54:03 +0800
Message-ID: <CAJve8ok_J41e33UM+Umr6NNDRC_WtsLYuqioW4TWfL8PwXQOCQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] ACPI: RISCV: Add NUMA support based on SRAT and SLIT
To: Sunil V L <sunilvl@ventanamicro.com>
Cc: Haibo Xu <haibo1.xu@intel.com>, ajones@ventanamicro.com, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Robert Moore <robert.moore@intel.com>, Conor Dooley <conor.dooley@microchip.com>, 
	Guo Ren <guoren@kernel.org>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>, 
	Alexandre Ghiti <alexghiti@rivosinc.com>, Greentime Hu <greentime.hu@sifive.com>, 
	Baoquan He <bhe@redhat.com>, =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>, 
	Sami Tolvanen <samitolvanen@google.com>, Jisheng Zhang <jszhang@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, 
	Chen Jiahao <chenjiahao16@huawei.com>, James Morse <james.morse@arm.com>, 
	Evan Green <evan@rivosinc.com>, Samuel Holland <samuel.holland@sifive.com>, 
	Anup Patel <apatel@ventanamicro.com>, Ard Biesheuvel <ardb@kernel.org>, 
	Tony Luck <tony.luck@intel.com>, Yuntao Wang <ytcoode@gmail.com>, 
	Dan Williams <dan.j.williams@intel.com>, Alison Schofield <alison.schofield@intel.com>, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 5, 2024 at 1:24=E2=80=AFPM Sunil V L <sunilvl@ventanamicro.com>=
 wrote:
>
> On Wed, Jan 31, 2024 at 10:32:00AM +0800, Haibo Xu wrote:
> > Add acpi_numa.c file to enable parse NUMA information from
> > ACPI SRAT and SLIT tables. SRAT table provide CPUs(Hart) and
> > memory nodes to proximity domain mapping, while SLIT table
> > provide the distance metrics between proximity domains.
> >
> > Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
> > ---
> >  arch/riscv/include/asm/acpi.h |  15 +++-
> >  arch/riscv/kernel/Makefile    |   1 +
> >  arch/riscv/kernel/acpi.c      |   5 --
> >  arch/riscv/kernel/acpi_numa.c | 133 ++++++++++++++++++++++++++++++++++
> >  arch/riscv/kernel/setup.c     |   4 +-
> >  arch/riscv/kernel/smpboot.c   |   2 -
> >  drivers/acpi/numa/srat.c      |   3 +-
> >  include/linux/acpi.h          |   4 +
> >  8 files changed, 156 insertions(+), 11 deletions(-)
> >  create mode 100644 arch/riscv/kernel/acpi_numa.c
> >
> > diff --git a/arch/riscv/include/asm/acpi.h b/arch/riscv/include/asm/acp=
i.h
> > index 7dad0cf9d701..e0a1f84404f3 100644
> > --- a/arch/riscv/include/asm/acpi.h
> > +++ b/arch/riscv/include/asm/acpi.h
> > @@ -61,11 +61,14 @@ static inline void arch_fix_phys_package_id(int num=
, u32 slot) { }
> >
> >  void acpi_init_rintc_map(void);
> >  struct acpi_madt_rintc *acpi_cpu_get_madt_rintc(int cpu);
> > -u32 get_acpi_id_for_cpu(int cpu);
> > +static inline u32 get_acpi_id_for_cpu(int cpu)
> > +{
> > +     return acpi_cpu_get_madt_rintc(cpu)->uid;
> > +}
> > +
> >  int acpi_get_riscv_isa(struct acpi_table_header *table,
> >                      unsigned int cpu, const char **isa);
> >
> > -static inline int acpi_numa_get_nid(unsigned int cpu) { return NUMA_NO=
_NODE; }
> >  void acpi_get_cbo_block_size(struct acpi_table_header *table, u32 *cbo=
m_size,
> >                            u32 *cboz_size, u32 *cbop_size);
> >  #else
> > @@ -87,4 +90,12 @@ static inline void acpi_get_cbo_block_size(struct ac=
pi_table_header *table,
> >
> >  #endif /* CONFIG_ACPI */
> >
> > +#ifdef CONFIG_ACPI_NUMA
> > +int acpi_numa_get_nid(unsigned int cpu);
> > +void acpi_map_cpus_to_nodes(void);
> > +#else
> > +static inline int acpi_numa_get_nid(unsigned int cpu) { return NUMA_NO=
_NODE; }
> > +static inline void acpi_map_cpus_to_nodes(void) { }
> > +#endif /* CONFIG_ACPI_NUMA */
> > +
> >  #endif /*_ASM_ACPI_H*/
> > diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
> > index f71910718053..5d3e9cf89b76 100644
> > --- a/arch/riscv/kernel/Makefile
> > +++ b/arch/riscv/kernel/Makefile
> > @@ -105,3 +105,4 @@ obj-$(CONFIG_COMPAT)              +=3D compat_vdso/
> >
> >  obj-$(CONFIG_64BIT)          +=3D pi/
> >  obj-$(CONFIG_ACPI)           +=3D acpi.o
> > +obj-$(CONFIG_ACPI_NUMA)      +=3D acpi_numa.o
> > diff --git a/arch/riscv/kernel/acpi.c b/arch/riscv/kernel/acpi.c
> > index e619edc8b0cc..040bdbfea2b4 100644
> > --- a/arch/riscv/kernel/acpi.c
> > +++ b/arch/riscv/kernel/acpi.c
> > @@ -191,11 +191,6 @@ struct acpi_madt_rintc *acpi_cpu_get_madt_rintc(in=
t cpu)
> >       return &cpu_madt_rintc[cpu];
> >  }
> >
> > -u32 get_acpi_id_for_cpu(int cpu)
> > -{
> > -     return acpi_cpu_get_madt_rintc(cpu)->uid;
> > -}
> > -
> >  /*
> >   * __acpi_map_table() will be called before paging_init(), so early_io=
remap()
> >   * or early_memremap() should be called here to for ACPI table mapping=
.
> > diff --git a/arch/riscv/kernel/acpi_numa.c b/arch/riscv/kernel/acpi_num=
a.c
> > new file mode 100644
> > index 000000000000..493642a61457
> > --- /dev/null
> > +++ b/arch/riscv/kernel/acpi_numa.c
> > @@ -0,0 +1,133 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * ACPI 6.6 based NUMA setup for RISCV
> > + * Lots of code was borrowed from arch/arm64/kernel/acpi_numa.c
> > + *
> > + * Copyright 2004 Andi Kleen, SuSE Labs.
> > + * Copyright (C) 2013-2016, Linaro Ltd.
> > + *           Author: Hanjun Guo <hanjun.guo@linaro.org>
> > + * Copyright (C) 2024 Intel Corporation.
> > + *
> > + * Reads the ACPI SRAT table to figure out what memory belongs to whic=
h CPUs.
> > + *
> > + * Called from acpi_numa_init while reading the SRAT and SLIT tables.
> > + * Assumes all memory regions belonging to a single proximity domain
> > + * are in one chunk. Holes between them will be included in the node.
> > + */
> > +
> > +#define pr_fmt(fmt) "ACPI: NUMA: " fmt
> > +
> > +#include <linux/acpi.h>
> > +#include <linux/bitmap.h>
> > +#include <linux/kernel.h>
> > +#include <linux/mm.h>
> > +#include <linux/memblock.h>
> > +#include <linux/mmzone.h>
> > +#include <linux/module.h>
> > +#include <linux/topology.h>
> > +
> > +#include <asm/numa.h>
> > +
> > +static int acpi_early_node_map[NR_CPUS] __initdata =3D { NUMA_NO_NODE =
};
> > +
> > +int __init acpi_numa_get_nid(unsigned int cpu)
> > +{
> > +     return acpi_early_node_map[cpu];
> > +}
> > +
> > +static inline int get_cpu_for_acpi_id(u32 uid)
> > +{
> > +     int cpu;
> > +
> > +     for (cpu =3D 0; cpu < nr_cpu_ids; cpu++)
> > +             if (uid =3D=3D get_acpi_id_for_cpu(cpu))
> > +                     return cpu;
> > +
> > +     return -EINVAL;
> > +}
> > +
> > +static int __init acpi_parse_rintc_pxm(union acpi_subtable_headers *he=
ader,
> > +                                   const unsigned long end)
>
> Please check alignment.
>

Sure.

> > +{
> > +     struct acpi_srat_rintc_affinity *pa;
> > +     int cpu, pxm, node;
> > +
> > +     if (srat_disabled())
> > +             return -EINVAL;
> > +
> > +     pa =3D (struct acpi_srat_rintc_affinity *)header;
> > +     if (!pa)
> > +             return -EINVAL;
> > +
> > +     if (!(pa->flags & ACPI_SRAT_RINTC_ENABLED))
> > +             return 0;
> > +
> > +     pxm =3D pa->proximity_domain;
> > +     node =3D pxm_to_node(pxm);
> > +
> > +     /*
> > +      * If we can't map the UID to a logical cpu this
> > +      * means that the UID is not part of possible cpus
> > +      * so we do not need a NUMA mapping for it, skip
> > +      * the SRAT entry and keep parsing.
> > +      */
> > +     cpu =3D get_cpu_for_acpi_id(pa->acpi_processor_uid);
> > +     if (cpu < 0)
> > +             return 0;
> > +
> > +     acpi_early_node_map[cpu] =3D node;
> > +     pr_info("SRAT: PXM %d -> HARTID 0x%lx -> Node %d\n", pxm,
> > +             cpuid_to_hartid_map(cpu), node);
> > +
> > +     return 0;
> > +}
> > +
> > +void __init acpi_map_cpus_to_nodes(void)
> > +{
> > +     int i;
> > +
> > +     /*
> > +      * In ACPI, SMP and CPU NUMA information is provided in separate
> > +      * static tables, namely the MADT and the SRAT.
> > +      *
> > +      * Thus, it is simpler to first create the cpu logical map throug=
h
> > +      * an MADT walk and then map the logical cpus to their node ids
> > +      * as separate steps.
> > +      */
> > +     acpi_table_parse_entries(ACPI_SIG_SRAT, sizeof(struct acpi_table_=
srat),
> > +                                         ACPI_SRAT_TYPE_RINTC_AFFINITY=
,
> > +                                         acpi_parse_rintc_pxm, 0);
> > +
> Alignment here as well.
>

Sure.

> > +     for (i =3D 0; i < nr_cpu_ids; i++)
> > +             early_map_cpu_to_node(i, acpi_numa_get_nid(i));
> > +}
> > +
> > +/* Callback for Proximity Domain -> logical node ID mapping */
> > +void __init acpi_numa_rintc_affinity_init(struct acpi_srat_rintc_affin=
ity *pa)
> > +{
> > +     int pxm, node;
> > +
> > +     if (srat_disabled())
> > +             return;
> > +
> > +     if (pa->header.length < sizeof(struct acpi_srat_rintc_affinity)) =
{
> > +             pr_err("SRAT: Invalid SRAT header length: %d\n",
> > +                     pa->header.length);
> Can we merge these into single line?
>
> > +             bad_srat();
> > +             return;
> > +     }
> > +
> > +     if (!(pa->flags & ACPI_SRAT_RINTC_ENABLED))
> > +             return;
> > +
> > +     pxm =3D pa->proximity_domain;
> > +     node =3D acpi_map_pxm_to_node(pxm);
> > +
> > +     if (node =3D=3D NUMA_NO_NODE) {
> > +             pr_err("SRAT: Too many proximity domains %d\n", pxm);
> > +             bad_srat();
> > +             return;
> > +     }
> > +
> > +     node_set(node, numa_nodes_parsed);
> > +}
> > diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
> > index 4f73c0ae44b2..a2cde65b69e9 100644
> > --- a/arch/riscv/kernel/setup.c
> > +++ b/arch/riscv/kernel/setup.c
> > @@ -281,8 +281,10 @@ void __init setup_arch(char **cmdline_p)
> >       setup_smp();
> >  #endif
> >
> > -     if (!acpi_disabled)
> > +     if (!acpi_disabled) {
> >               acpi_init_rintc_map();
> > +             acpi_map_cpus_to_nodes();
> Is it not possible to fill up both in single parsing of MADT?
>

I think it's not possible to fill both in a single MADT parse since
the NUMA info is provided in a separate SRAT table.

For RISC-V, currently we parsed 2 times of the MADT.
FIrst one in setup_smp()->acpi_parse_and_init_cpus() call to build up
cpuid_to_hartid_map.
Second one in acpi_init_rintc_map call to build the cpu_madt_rintc[]
cache structure.

Since the first one depends on the CONFIG_SMP, I am not sure whether
it's possible to combine
these two parts into one.

> > +     }
> >
> >       riscv_init_cbo_blocksizes();
> >       riscv_fill_hwcap();
> > diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
> > index 519b6bd946e5..b188d83d1ec4 100644
> > --- a/arch/riscv/kernel/smpboot.c
> > +++ b/arch/riscv/kernel/smpboot.c
> > @@ -101,7 +101,6 @@ static int __init acpi_parse_rintc(union acpi_subta=
ble_headers *header, const un
> >       if (hart =3D=3D cpuid_to_hartid_map(0)) {
> >               BUG_ON(found_boot_cpu);
> >               found_boot_cpu =3D true;
> > -             early_map_cpu_to_node(0, acpi_numa_get_nid(cpu_count));
> >               return 0;
> >       }
> >
> > @@ -111,7 +110,6 @@ static int __init acpi_parse_rintc(union acpi_subta=
ble_headers *header, const un
> >       }
> >
> >       cpuid_to_hartid_map(cpu_count) =3D hart;
> > -     early_map_cpu_to_node(cpu_count, acpi_numa_get_nid(cpu_count));
> >       cpu_count++;
> >
> >       return 0;
> > diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
> > index 503abcf6125d..1f0462cef47c 100644
> > --- a/drivers/acpi/numa/srat.c
> > +++ b/drivers/acpi/numa/srat.c
> > @@ -219,7 +219,8 @@ int __init srat_disabled(void)
> >       return acpi_numa < 0;
> >  }
> >
> > -#if defined(CONFIG_X86) || defined(CONFIG_ARM64) || defined(CONFIG_LOO=
NGARCH)
> > +#if defined(CONFIG_X86) || defined(CONFIG_ARM64) || defined(CONFIG_LOO=
NGARCH) || \
> > +     defined(CONFIG_RISCV)
> Please check alignment. Or make it single line if fits in 100 chars.
> Also, it looks it covers most of the architectures now. Is it possible
> to simplify / remove the condition? I hope IA64 is removed now?
>

Good catch!

Since IA64 support was removed in commit
cf8e8658100d4(https://lwn.net/Articles/923376/).
I think it's possible to remove the condition. Will fix it in v2.

Thanks,
Haibo

> May be you need to update the comment at #endif too.
>
> Thanks
> Sunil
>
> >  /*
> >   * Callback for SLIT parsing.  pxm_to_node() returns NUMA_NO_NODE for
> >   * I/O localities since SRAT does not list them.  I/O localities are
> > diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> > index a65273db55c6..be78a9d28927 100644
> > --- a/include/linux/acpi.h
> > +++ b/include/linux/acpi.h
> > @@ -269,8 +269,12 @@ acpi_numa_gicc_affinity_init(struct acpi_srat_gicc=
_affinity *pa) { }
> >
> >  int acpi_numa_memory_affinity_init (struct acpi_srat_mem_affinity *ma)=
;
> >
> > +#ifdef CONFIG_RISCV
> > +void acpi_numa_rintc_affinity_init(struct acpi_srat_rintc_affinity *pa=
);
> > +#else
> >  static inline void
> >  acpi_numa_rintc_affinity_init(struct acpi_srat_rintc_affinity *pa) { }
> > +#endif
> >
> >  #ifndef PHYS_CPUID_INVALID
> >  typedef u32 phys_cpuid_t;
> > --
> > 2.34.1
> >
