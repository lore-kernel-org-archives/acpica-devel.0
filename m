Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096FE2192F4
	for <acpica-devel@lists.linux.dev>; Wed, 25 Mar 2026 01:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774402477; cv=pass; b=BLeYXVhnXfxMaPjEF7juWz6F9M37tb2/P0qs4TU/gLQ09ETVdCNSA6ygBsZ8Eg816G4oUG8qxur0JDfFtFgF8e5Xfm6fKNOWdRmf6jLIfEBYhkRB1WekNOZ232oRakAnt+WbxKToE4DvsZCAVFtiAkDHOjq/iqFkD2MNEkoK09U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774402477; c=relaxed/simple;
	bh=rdSvCP52jZz7SDxDuWHrEpzIrkFP71B3BSjjo54bZpw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OE0y4yh9ea0SPhID+XhhrRNWhGqOGDGfKHD1Yx251XdnJVHGqhoiEyITcd+GmZ2w7Qa0EbPo2ix97KRWU90vVBKKwwiY9fMmHRxzzu+De13ikzzdp79sab/yL2edKdr6Z32EirfO6OTfuWM9OwlRHHdz8H6YRKSmic7xVFji2Zs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=hJEV8nRQ; arc=pass smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="hJEV8nRQ"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7d7eb85fb81so2102496a34.0
        for <acpica-devel@lists.linux.dev>; Tue, 24 Mar 2026 18:34:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774402474; cv=none;
        d=google.com; s=arc-20240605;
        b=AN3mpjhCdZ5GogF6jKFqAhepPZTPjSHmGaSwYtvMLxGo8qTjmM987X/FA5OwgxmZ3L
         zvMwCsGjeMsFeA992HIEG2nPJPI6UV4k+PFqm/nbESWFD+FrJFOOEFqXWJPcGUJScSTO
         vLc5WYSoVsGE9PsZq+VuiLT7ic8imQ9CL5MD+dClbPL8XghuMuZzUqENFlFEBKEAg/1Z
         vHllwxP/bZBRDKYj76xMbSq6E82RR/4nff0OV1k+Z2KBzq7Id2oQI9uBsQPZ8SRjZQyG
         +ts33Cn/AfmHJbNEY4Ulx6Pch37sH3jxL1c3cyepHl/yfEURtGmd72ph8mSEyNXc7QO5
         550Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nMJSXWHElAalaVGIQXtj4XQ2QzHBElxpVqzpZTWIIiA=;
        fh=MVaWg7WQRuYWGMRKWhwUOe6uAQeUiji0M863MLNREdU=;
        b=DTbYYdlE0hxYZiWDiF27IsyDvbHvjEwP0qr7fzZOAo1pvUj6mMG6eFJGY0Yh+VvAw9
         avAbDdKj1+SMoUF/tBCRM91b6nd/kWDTdd04WHuU06zNSaliqv6kXfTBCQZ+KsBsdVyN
         okUitD1OgefoXoN+nSYI63IiONoPEORwFqqZVKJ6Q6YQNSisO6iAOkSgM1NmolIxgjZQ
         sckGY9htg0VHmqzeVG3GWP6mliGfb5DXRoiWIyyrfGv5Ibk9lKOobNPWMiZTgeB7+vW1
         1UXHcjTWD5ROS7IsTAhiDpi+3g4wLGTKCk1s44iX6uhsRdiXi1Lrt0QWHKe15Br12TTn
         Gt+w==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1774402474; x=1775007274; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nMJSXWHElAalaVGIQXtj4XQ2QzHBElxpVqzpZTWIIiA=;
        b=hJEV8nRQMlzMX5lozT/QF+J3jUtM6+CF1Af0fSgo45lkb23M0Xv4ZKbhIDzU1w40Yp
         IXVQVwRYiKb3j5AAIcw3Xf+oigqmy87EEosPOnMqxm6I8wHhMQRqc5P977O1RWs3KC8T
         naGqqLuLPBAcuLOvKsQX30O5aQefZ+NbqvA5TT/QAoj/wcILTorUErPIONtnB7HDBhJo
         yJaQv+BZ5lH4cDi0TkXbAzp4Rj8W2wz/7fmgpzIe4XU3yIETtEgDIeZcFWxoZ+0uXqHS
         61NjjXrkZWmtH+j9UQ0WJYKNyz+LW3ZRVXpRbw93l4EtciIDu9jRBcBmtVYZR5Mx8Fto
         xULg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774402474; x=1775007274;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nMJSXWHElAalaVGIQXtj4XQ2QzHBElxpVqzpZTWIIiA=;
        b=a3W2ASU4wQZFK2ltAO9hGxf8aQBW1zG0wyNI2OUxr4vldB3krl9kUgjFtmUNt4AKT8
         QiW5bNwDADK2HVInIgWGgmnQXtIEFiRW5T2C3fRla8DFALKcn5SAo5XQKwlyDzBF1EIf
         9VAPB3LQhlTwv7gI7qEwQ2glfwnwbtwTEZRIjyVkS86i2sYG6Zkq3+qGPjqy7kxudNsL
         2SxuT+9n1sWpDSaVZZGe+aP9QsREmD8tdUdJ/7kmeOWvzPYy2g3N2dyVdgkdjE3ALZZ5
         xMtYsX3FMkZFNQ3JfpMqjmHB6HEghLwsr+BM1ovY6/1Y4LvHRYtXRa1JgazKOzz2gUE5
         AsMg==
X-Forwarded-Encrypted: i=1; AJvYcCWSct+mYYn40sCAUPDvR1mbjW5OlaH2aOvdnKIj7aDrza+lrGK2/05T7s6TkGsHmdN9gocdKzjKad/VHEM=@lists.linux.dev
X-Gm-Message-State: AOJu0YwNsLkcCWIDi7kVBRGuuMZYG/aUxr4XEJeTUYehrluKv574UcxD
	d14ASnWl7Omh39dFhVEqxPNCn0XLUDpRe6vOyMqJvrQIbSpphATpae3JBMDCxDMiwaBLtgqQz8V
	y0jABh9kKViGbHoydVwBQJ/5YuTeGZ0Fzc8vKAmsdXw==
X-Gm-Gg: ATEYQzyzxRflI0LOtYQ6REQ4ExoXE4TYj771ME5xGe1uQkat39Do4NuFSv/+JVzTXjE
	ocgnCg1DgP5kALFOOB5v202V/cUWprff+9y/t8eEHr0Qn13cLLw7VRGeytHJQREL6qhsgas9/2s
	iV9V1+fqIIaBohDfJ1jg8jrYavpKXKL2ifvpJlHyJWmNrS9wPBRSbYYcRE9oHDy5vzbHbeaB5As
	zgJnDlwVCBwi9Yv7yGz3ja0dQGkHeRWSRojifLn3r1XlBfDzK3ZGQIj2P34uClYYl+Hg4bI4nD5
	hVnPJdktgOatznuk1u2OSJ2o
X-Received: by 2002:a05:6808:1786:b0:467:254:ba8 with SMTP id
 5614622812f47-46a5c559a3fmr976022b6e.11.1774402473754; Tue, 24 Mar 2026
 18:34:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260128-ssqosid-cbqri-v2-0-dca586b091b9@kernel.org> <20260128-ssqosid-cbqri-v2-13-dca586b091b9@kernel.org>
In-Reply-To: <20260128-ssqosid-cbqri-v2-13-dca586b091b9@kernel.org>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Wed, 25 Mar 2026 09:34:22 +0800
X-Gm-Features: AaiRm50-EQhX5eRfy8n3fhONNShK5GtzIxF13pcKegKveCXY8vae28POGPRFJcE
Message-ID: <CAEEQ3wka26n8koB3tErRE=rgE1Bxnn7PDCjnXp2j67gdkp-=Zg@mail.gmail.com>
Subject: Re: [External] [PATCH RFC v2 13/17] acpi: pptt: Add helper to find a
 cache from id
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
> Add function to find the pointer to an instance of acpi_pptt_cache.
>
> find_acpi_cache_from_id() is based on find_acpi_cache_level_from_id()
> from commit c4170570cc7f ("ACPI / PPTT: Find PPTT cache level by ID") in
> the morse/mpam/snapshot/v6.14-rc1 branch.
>
> TODO: find_acpi_cache_level_from_id() has changed since then so this
> function should be updated. In additon, there may be a simpler way for
> acpi_parse_rqsc() than adding this function to get a pointer to
> acpi_pptt_cache.
>
> Signed-off-by: Drew Fustini <fustini@kernel.org>
> ---
>  drivers/acpi/pptt.c  | 63 ++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  include/linux/acpi.h |  8 +++++++
>  2 files changed, 71 insertions(+)
>
> diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
> index de5f8c018333..d1002673dc39 100644
> --- a/drivers/acpi/pptt.c
> +++ b/drivers/acpi/pptt.c
> @@ -1063,3 +1063,66 @@ int acpi_pptt_get_cpumask_from_cache_id(u32 cache_=
id, cpumask_t *cpus)
>
>         return 0;
>  }
> +
> +/*
> + * find_acpi_cache_from_id() is adapted from find_acpi_cache_level_from_=
id()
> + * introduced by c4170570cc7f ("ACPI / PPTT: Find PPTT cache level by ID=
")
> + * in the morse/mpam/snapshot/v6.14-rc1 branch.
> + *
> + * TODO: find_acpi_cache_level_from_id() has changed since then so this
> + * function should be updated. In additon, there may be a simpler way fo=
r
> + * acpi_parse_rqsc() than adding this function to get a pointer to
> + * acpi_pptt_cache.
> + */
> +struct acpi_pptt_cache *find_acpi_cache_from_id(u32 cache_id)
> +{
> +       u32 acpi_cpu_id;
> +       acpi_status status;
> +       int level, cpu, num_levels;
> +       struct acpi_pptt_cache *cache;
> +       struct acpi_table_header *table;
> +       struct acpi_pptt_cache_v1 *cache_v1;
> +       struct acpi_pptt_processor *cpu_node;
> +
> +       status =3D acpi_get_table(ACPI_SIG_PPTT, 0, &table);
> +       if (ACPI_FAILURE(status)) {
> +               acpi_pptt_warn_missing();
> +               return NULL;
> +       }
> +
> +       if (table->revision < 3) {
> +               acpi_put_table(table);
> +               return NULL;
> +       }
> +
> +       for_each_possible_cpu(cpu) {
> +               num_levels =3D 0;
> +               acpi_cpu_id =3D get_acpi_id_for_cpu(cpu);
> +
> +               cpu_node =3D acpi_find_processor_node(table, acpi_cpu_id)=
;
> +               if (!cpu_node)
> +                       break;

break or continue?


> +               num_levels =3D acpi_count_levels(table, cpu_node, NULL);
> +
> +               for (level =3D 1; level <=3D num_levels; level++) {
> +                       cache =3D acpi_find_cache_node(table, acpi_cpu_id=
,
> +                                                    ACPI_PPTT_CACHE_TYPE=
_UNIFIED,
> +                                                    level, &cpu_node);
> +                       if (!cache)
> +                               continue;
> +
> +                       cache_v1 =3D ACPI_ADD_PTR(struct acpi_pptt_cache_=
v1,
> +                                               cache,
> +                                               sizeof(struct acpi_pptt_c=
ache));
> +
> +                       if (cache->flags & ACPI_PPTT_CACHE_ID_VALID &&
> +                           cache_v1->cache_id =3D=3D cache_id) {
> +                               acpi_put_table(table);
> +                               return cache;
> +                       }
> +               }
> +       }
> +
> +       acpi_put_table(table);
> +       return NULL;
> +}
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index fbf0c3a65f59..fee6a5059a46 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -1546,6 +1546,7 @@ int find_acpi_cpu_topology_package(unsigned int cpu=
);
>  int find_acpi_cpu_topology_hetero_id(unsigned int cpu);
>  void acpi_pptt_get_cpus_from_container(u32 acpi_cpu_id, cpumask_t *cpus)=
;
>  int find_acpi_cache_level_from_id(u32 cache_id);
> +struct acpi_pptt_cache *find_acpi_cache_from_id(u32 cache_id);
>  int acpi_pptt_get_cpumask_from_cache_id(u32 cache_id, cpumask_t *cpus);
>  #else
>  static inline int acpi_pptt_cpu_is_thread(unsigned int cpu)
> @@ -1570,10 +1571,17 @@ static inline int find_acpi_cpu_topology_hetero_i=
d(unsigned int cpu)
>  }
>  static inline void acpi_pptt_get_cpus_from_container(u32 acpi_cpu_id,
>                                                      cpumask_t *cpus) { }
> +
>  static inline int find_acpi_cache_level_from_id(u32 cache_id)
>  {
>         return -ENOENT;
>  }
> +
> +static inline struct acpi_pptt_cache *find_acpi_cache_from_id(u32 cache_=
id)
> +{
> +       return NULL;
> +}
> +
>  static inline int acpi_pptt_get_cpumask_from_cache_id(u32 cache_id,
>                                                       cpumask_t *cpus)
>  {
>
> --
> 2.43.0
>

Thanks,
Yunhui
