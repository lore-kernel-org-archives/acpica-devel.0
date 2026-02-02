Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D349235F8CF
	for <acpica-devel@lists.linux.dev>; Mon,  2 Feb 2026 11:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770030543; cv=pass; b=jmPPAa/AExaByh0VwX9AKTn+9o50OmPco6waXCpggwaMe4fxlJ/3iBZNNgoXoNhM+dTaIxPj87uR6A9UqbQjOlz4Mh5aMBiuFnM3VLEBeeCeolJqC1PE8IPCJWos55CCr+yyRU2SDzGlXCth31JOmOteLOjRaHDuxAuR47G7oPU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770030543; c=relaxed/simple;
	bh=yX2BFHpOk9prwEk0tuLWfmquAHMWjjQf84eyNI+WYFI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qY6x8NKiw6iHbkriHr48hW8OkB6vyRmNMg6avpFPxSrtX+4wJUJe5Reho3E/sSJ/B/ueS6ilUTwl3biWy5Lr5sTnJ+iKieKWqwfIz20gjkIGdZtM8NZvgLhSXB+D8T6P+k8K+pW2QRz83Vq3DaXqwL8TtNhMQaMF9eJsRN2aZ6E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=KHk3Rojg; arc=pass smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="KHk3Rojg"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b8849dc12f6so620577366b.1
        for <acpica-devel@lists.linux.dev>; Mon, 02 Feb 2026 03:09:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770030540; cv=none;
        d=google.com; s=arc-20240605;
        b=Dbr+Tyzf8nfZok0mVElPwj2/XqlbpH6WEVXYkZLieg6oz1n6RGv0BV4JUM5VQnYmB3
         6FI55zArrWsXQ9R4YVbJOq1F/RI2qpYMzjukeSMawv7XSeasynZVgsbcQDuSDXyXDAhj
         r3/xH5B4bBnQp9L0zfbH2oFsUxChda0cXpVYoW1yrjHC0Ws47EeV7t5ja20bQYTQo3Kv
         efZT49yvnqYqJdc6SXjXAIFcPYOJnhfmO5zlErvflq0eVlnVK/6ooi1W1j7qu/vXiHSc
         WFQ9Dus2Rx33MnH9cRAZ3y+VE0Y1KO4ibFYh70ZSl83LRjiCjn+SxhqeAXvMrKJcRiqN
         INiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MoxmKC3AEBhB/kOsYxXfyqRCe6TK6YEU6RcRE5k82eE=;
        fh=9VseWrOiPUspXuoEsptXqG7hCop/lAbz0HxhVaU2DnQ=;
        b=OLjY5sIH9JSIaBGW8Iy5UTrdP9w3SHRtlZtowvjHnpxyQ+uiv7w1KXcG5Va4geAmWZ
         B4/Uf3QHFL+QwNIt+sajORYqP/nCNhRtL/STppC2Q/tjPBWpGVz/L+zXW52KdkYaOG0X
         b88keB+45Ix9nFWJAm2nEb9576gBPdxA8j5k0K3CqxrjgsZAk6f2UXnvToRiR+zm+HXo
         57xYh9uT+qy2Ry7A78J3p3SCiTUA/NePteaWmutiSe+loYqv6GKnZJwi5JoF2GRi5pHj
         xMr7LpjJh2LY2jZIMqTv+4dYPwITwCt99slCXvD631eTsbEKF+x+FPbFO/PN9QIAB8yR
         jZAQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1770030540; x=1770635340; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MoxmKC3AEBhB/kOsYxXfyqRCe6TK6YEU6RcRE5k82eE=;
        b=KHk3RojgU7qYz3Ehm2f46rzII8K9UXj0CiDgC/TPW2tORslYRay4dnaly5aT4rmDUa
         7qgIcvkZ+b0XBZ1BmiSmeH+cBO4+1BrQlJW0BK2/AAJXqgjpNE8Oy+qjPiXPCohrO8Fl
         ZrtVgElLb9dDXXEVenfPOX6I3srGp1w0KxFDCnuopv9tjAabg1fPAgsyihX8iyMTLqMa
         +JYVfoeb84tB62Lrp7cnhHxsLdimiuzRdg3mNG4ssx0n7hiUud8CUQfHB1S5mpo0Toxr
         BhfIw8XynNYHQ+hOGbls3va7aS0ZBEniRcK62NChe0SHJKELtRK34n9YuptRlmOONmpS
         Ux/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770030540; x=1770635340;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MoxmKC3AEBhB/kOsYxXfyqRCe6TK6YEU6RcRE5k82eE=;
        b=C9B/v6qSYtGX+us5i+uSzw4PNNikkpHorbDD0Q0ix0YY8g5xIP8UFS+BCMktc+NVSJ
         S4FjMvE/QhcenQH0mHANXdcll1veUq3BVEb8PwnKfzJUhx8KqdLWOgVxuzR4Nt6P5HHD
         NBsO4fT5lEbo5KQ2NIG5isFN6+Glk6OzWdU0HwOTD6Sl60OXW8bSuGBdz97H9K9Y5Wfz
         jNWOtvQaohkq6z7tpZF/kSm0lj38HYVHHqpeB14ZC1u9i83ymN8+i+DD7a7NwYWiiFSA
         q7b2k8zYCcIg57ReccjRGtwGyXl+7cJlR7Z183Rm7StzSxEwKuafa7M9vKDMo+cFGsj7
         YZFw==
X-Forwarded-Encrypted: i=1; AJvYcCVGeQdGT7YbZa1GQF/aWYiKojj/gPctcLO8oANRhXMpVaNctG1+LBlzB3+v8uuwxUJ//x9OcnFAl+Wrqug=@lists.linux.dev
X-Gm-Message-State: AOJu0Yzs3bZUqiOt0ibVaXr8rc1G95HfNKbbOenWa4JJh5cA1D725SEc
	dsKB39BhssSKS2Wt1c8Aq/oSav0Ff4eK1BtnzT/1HserUDB6XSlR6sFQ9ClDoaRbAXPL2sSkGi1
	cektr0N4gr7HcS5I5sI9a9iMRURh/lXd+YXWA6zt1Cg==
X-Gm-Gg: AZuq6aLo+GSE8Nf2UcJ07HDCnuuOOvLcwUOHmgAmiySskyN4bd++MHXjAYC7fgwTqMs
	rlcvkwAx2Np+x+3EgN2gyTQd9FqJH1mKbqzshuc2uZdk+iBuCYSOj5/hG6J5qJmsbEV/qjpHeuq
	XYJeNp/L5lss3AnZO5CeuTP/C5bdrL+6qMs7IREkpIcHrrg222GG97JPNMK3vXB5fP8culNLiVa
	b2oIaGHob2GxK8eyfNBDbLJWc8ua6mTY4XoBq/QIeq4Hu/AuSr1EPrKkDHAi4+5OTPwk/D1s/tz
	lg==
X-Received: by 2002:a17:906:6a29:b0:b88:6c85:6284 with SMTP id
 a640c23a62f3a-b8dff5488d5mr604091766b.15.1770030539874; Mon, 02 Feb 2026
 03:08:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260128-ssqosid-cbqri-v2-0-dca586b091b9@kernel.org> <20260128-ssqosid-cbqri-v2-16-dca586b091b9@kernel.org>
In-Reply-To: <20260128-ssqosid-cbqri-v2-16-dca586b091b9@kernel.org>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Mon, 2 Feb 2026 19:08:48 +0800
X-Gm-Features: AZwV_QhzRM-HhD39oxnkszZgHj-oBq0usZXp2z8CIfC66bnYNgWIMZ8r9zOmvVI
Message-ID: <CAEEQ3wnAqSFUhezyUmJQut8eXThGJ1zxtdNTbFtJusyDstgVUg@mail.gmail.com>
Subject: Re: [External] [PATCH RFC v2 16/17] acpi: riscv: Parse RISC-V Quality
 of Service Controller (RQSC) table
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
> Add driver to parse the ACPI RISC-V Quality of Service Controller (RQSC)
> table which describes the capacity and bandwidth QoS controllers in a
> system. The QoS controllers implement the RISC-V Capacity and Bandwidth
> Controller QoS Register Interface (CBQRI) specification.
>
> Link: https://github.com/riscv-non-isa/riscv-cbqri/releases/tag/v1.0
> Link: https://github.com/riscv-non-isa/riscv-rqsc/blob/main/src/
> Signed-off-by: Drew Fustini <fustini@kernel.org>
> ---
>  MAINTAINERS                   |   1 +
>  arch/riscv/include/asm/acpi.h |  10 ++++
>  drivers/acpi/riscv/Makefile   |   2 +-
>  drivers/acpi/riscv/rqsc.c     | 112 ++++++++++++++++++++++++++++++++++++=
++++++
>  4 files changed, 124 insertions(+), 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 96ead357a634..e96a83dc9a02 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -22512,6 +22512,7 @@ S:      Supported
>  F:     arch/riscv/include/asm/qos.h
>  F:     arch/riscv/include/asm/resctrl.h
>  F:     arch/riscv/kernel/qos/
> +F:     drivers/acpi/riscv/rqsc.c
>  F:     include/linux/riscv_qos.h
>
>  RISC-V RPMI AND MPXY DRIVERS
> diff --git a/arch/riscv/include/asm/acpi.h b/arch/riscv/include/asm/acpi.=
h
> index 6e13695120bc..16c6e25eed1e 100644
> --- a/arch/riscv/include/asm/acpi.h
> +++ b/arch/riscv/include/asm/acpi.h
> @@ -71,6 +71,16 @@ int acpi_get_riscv_isa(struct acpi_table_header *table=
,
>
>  void acpi_get_cbo_block_size(struct acpi_table_header *table, u32 *cbom_=
size,
>                              u32 *cboz_size, u32 *cbop_size);
> +
> +#ifdef CONFIG_RISCV_ISA_SSQOSID
> +int acpi_parse_rqsc(struct acpi_table_header *table);
> +#else
> +static inline int acpi_parse_rqsc(struct acpi_table_header *table)
> +{
> +       return -EINVAL;
> +}
> +#endif /* CONFIG_RISCV_ISA_SSQOSID */
> +
>  #else
>  static inline void acpi_init_rintc_map(void) { }
>  static inline struct acpi_madt_rintc *acpi_cpu_get_madt_rintc(int cpu)
> diff --git a/drivers/acpi/riscv/Makefile b/drivers/acpi/riscv/Makefile
> index 1284a076fa88..cf0f38c93a9f 100644
> --- a/drivers/acpi/riscv/Makefile
> +++ b/drivers/acpi/riscv/Makefile
> @@ -1,5 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0-only
> -obj-y                                  +=3D rhct.o init.o irq.o
> +obj-y                                  +=3D rhct.o rqsc.o init.o irq.o
>  obj-$(CONFIG_ACPI_PROCESSOR_IDLE)      +=3D cpuidle.o
>  obj-$(CONFIG_ACPI_CPPC_LIB)            +=3D cppc.o
>  obj-$(CONFIG_ACPI_RIMT)                        +=3D rimt.o
> diff --git a/drivers/acpi/riscv/rqsc.c b/drivers/acpi/riscv/rqsc.c
> new file mode 100644
> index 000000000000..a86ddb39fae4
> --- /dev/null
> +++ b/drivers/acpi/riscv/rqsc.c
> @@ -0,0 +1,112 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2025 Tenstorrent
> + *     Author: Drew Fustini <fustini@kernel.org>
> + *
> + */
> +
> +#define pr_fmt(fmt) "ACPI: RQSC: " fmt
> +
> +#include <linux/acpi.h>
> +#include <linux/bits.h>
> +#include <linux/riscv_qos.h>
> +
> +#ifdef CONFIG_RISCV_ISA_SSQOSID
> +
> +#define CBQRI_CTRL_SIZE 0x1000
> +
> +static struct acpi_table_rqsc *acpi_get_rqsc(void)
> +{
> +       static struct acpi_table_header *rqsc;
> +       acpi_status status;
> +
> +       /*
> +        * RQSC will be used at runtime on every CPU, so we
> +        * don't need to call acpi_put_table() to release the table mappi=
ng.
> +        */
> +       if (!rqsc) {
> +               status =3D acpi_get_table(ACPI_SIG_RQSC, 0, &rqsc);
> +               if (ACPI_FAILURE(status)) {
> +                       pr_warn_once("No RQSC table found\n");
> +                       return NULL;
> +               }
> +       }
> +
> +       return (struct acpi_table_rqsc *)rqsc;
> +}
> +
> +int acpi_parse_rqsc(struct acpi_table_header *table)
> +{
> +       struct acpi_table_rqsc *rqsc;
> +       int err;
> +
> +       BUG_ON(acpi_disabled);
> +       if (!table) {
> +               rqsc =3D acpi_get_rqsc();
> +               if (!rqsc)
> +                       return -ENOENT;
> +       } else {
> +               rqsc =3D (struct acpi_table_rqsc *)table;
> +       }
> +
> +       for (int i =3D 0; i < rqsc->num; i++) {
> +               struct cbqri_controller_info *ctrl_info;
> +
> +               ctrl_info =3D kzalloc(sizeof(*ctrl_info), GFP_KERNEL);
> +               if (!ctrl_info)
> +                       return -ENOMEM;
> +
> +               ctrl_info->type =3D rqsc->f[i].type;
> +               ctrl_info->addr =3D rqsc->f[i].reg[1];
> +               ctrl_info->size =3D CBQRI_CTRL_SIZE;
> +               ctrl_info->rcid_count =3D rqsc->f[i].rcid;
> +               ctrl_info->mcid_count =3D rqsc->f[i].mcid;
> +
> +               pr_info("Found controller with type %u addr 0x%lx size  %=
lu rcid  %u mcid  %u",
> +                       ctrl_info->type, ctrl_info->addr, ctrl_info->size=
,
> +                       ctrl_info->rcid_count, ctrl_info->mcid_count);
> +
> +               if (ctrl_info->type =3D=3D CBQRI_CONTROLLER_TYPE_CAPACITY=
) {
> +                       ctrl_info->cache.cache_id =3D rqsc->f[i].res.id1;
> +                       ctrl_info->cache.cache_level =3D
> +                               find_acpi_cache_level_from_id(ctrl_info->=
cache.cache_id);
> +
> +                       struct acpi_pptt_cache *cache;
> +
> +                       cache =3D find_acpi_cache_from_id(ctrl_info->cach=
e.cache_id);
> +                       if (cache) {
> +                               ctrl_info->cache.cache_size =3D cache->si=
ze;
> +                       } else {
> +                               pr_warn("%s(): failed to determine size f=
or cache id 0x%x",
> +                                       __func__, ctrl_info->cache.cache_=
id);
> +                               ctrl_info->cache.cache_size =3D 0;
> +                       }
> +
> +                       pr_info("Cache controller has ID 0x%x level %u si=
ze %u ",
> +                               ctrl_info->cache.cache_id, ctrl_info->cac=
he.cache_level,
> +                               ctrl_info->cache.cache_size);
> +
> +                       /*
> +                        * For CBQRI, any cpu (technically a hart in RISC=
-V terms)
> +                        * can access the memory-mapped registers of any =
CBQRI
> +                        * controller in the system.
> +                        */
> +                       err =3D cpumask_parse("FF", &ctrl_info->cache.cpu=
_mask);

Hardcode? acpi_pptt_get_cpumask_from_cache_id(ctrl_info->cache.cache_id,
&ctrl_info->cache.cpu_mask); ?

> +                       if (err)
> +                               pr_err("Failed to convert cores mask stri=
ng to cpumask (%d)", err);
> +
> +               } else if (ctrl_info->type =3D=3D CBQRI_CONTROLLER_TYPE_B=
ANDWIDTH) {
> +                       ctrl_info->mem.prox_dom =3D rqsc->f[i].res.id1;
> +                       pr_info("Memory controller with proximity domain =
%u",
> +                               ctrl_info->mem.prox_dom);
> +               }
> +
> +               /* Fill the list shared with RISC-V QoS resctrl */
> +               INIT_LIST_HEAD(&ctrl_info->list);
> +               list_add_tail(&ctrl_info->list, &cbqri_controllers);
> +       }
> +
> +       return 0;
> +}
> +
> +#endif /* CONFIG_RISCV_ISA_SSQOSID */
>
> --
> 2.43.0
>

Thanks,
Yunhui
