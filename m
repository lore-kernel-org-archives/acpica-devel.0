Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952754DA1F
	for <acpica-devel@lists.linux.dev>; Tue,  5 Mar 2024 08:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709628163; cv=none; b=AtSkdQSInAWuFADNVZkRkj/D2IIICITTJOug1Wd6qv7aB3tPh+vK1co5M4f4qlFsgR8FkYxDDsGUax2QUFZV5FE/vCm/nT/JpvzmeOg4KSNXFDeWZDAOSdy/tJpYQORS7qqoK0s9rQqucApVpUYQvJj4KSXTT0z40VzWuFIVaOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709628163; c=relaxed/simple;
	bh=mEeddxrjFkmA6mwZyPNUY/CC4aHVGrqxynRg91/k4TE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bD/U5vu6Yz/kIDbvnUGS+Yd5UY2umQDO0/yX0KJGuHPfy1sUqc9sWf6g10xj481MDuyrNLxTBEFHMPKP/gQDLLoEEW/mtdXe/2csGG7+apqHKQk3bQDTW3eoEybahtytO9pa6y3oxsniEASJUqkY/uubpNqlA0HmJ9EpU3TwWvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D5oHtYSp; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D5oHtYSp"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2d09cf00214so67408581fa.0
        for <acpica-devel@lists.linux.dev>; Tue, 05 Mar 2024 00:42:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709628159; x=1710232959; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F/6peNBdk69VycNv0NnzT94cpIyuuvaLqCVKnWNPdGI=;
        b=D5oHtYSplj9QzXPkwygUdOBgcv/5yRxslURBjGApBEkquXFAwNaUrKgJD2+OOsm0bj
         s4WMwmOcu+dcbgcXWO1G7DRRj0vToD62z47obfzUiIm3qDB1qIffyAFapOhl6J3k5lsS
         SeLYhEx6SanHQvsyyhF3+Jipk9QVfCyqeV0vosSd52PCboTKFDdfLdbEt3BqDndcTPxl
         q3iScNDJgmKSmj8iNDcwQ7nL+qdgG9UVqrBgIjanucw9HQb5t0a1yyO1q0QW4ofLoFAx
         SmYlQj9y21Yge07a5QtiBDVVYWhU0/3ewSZEMMVNYZK+YLaFrOiIxine/HAefI+26cc5
         jTwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709628159; x=1710232959;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F/6peNBdk69VycNv0NnzT94cpIyuuvaLqCVKnWNPdGI=;
        b=bo3KcqUJDHLgsVsnjgyQ9Nqef7p5yxKA3Dfx3vvzFMxNGe9s/TODJRtI+8QX3k1KgA
         mAj3m27KmwoWTsxyCbmWMP1V5rKifNW45wavWwXlGwXmr4bOTbQsEX4xIedvZIPCDCC+
         fm0Wh0dWVlnixwbUTSttggAtT83hmLop/9ULDmJl6U1tmqciWzbJPYtAd1NXuAcGOKJV
         HBv8BeREltid9DQA06Rtq7POjoA8L85o+XAfV/QnJNVQsZOwHJAIjtu2FzGrHfz/BQ1B
         oD8jsR6QTeiEJBBA+AxQLoZ9au6EWsz2aBBZHtzcpYUjeZTm2fO67jILjHq0LWkRH66Z
         VbaA==
X-Forwarded-Encrypted: i=1; AJvYcCUzKrmQg/Qz+JMD41spgdLPrn0YpyW27lbwv5hDgJPURRSLGo3L9yClCq/MHdwE+E5XmWh1iBI9vkkW1+yeBow1ZDHqmyFEN84Px6O2
X-Gm-Message-State: AOJu0Yx6JsYiBnzd0ln6/nmgYJOTGtxDu2+t3ht8FCnDinl1WNv1HTMi
	zyvRK+tegUWhOaMIJlqY9AWZ4wrgmeaociAQ0WkWJ3iOqkGvQBoxo0V+q5ntEIitjSqRCmH74iB
	fK95NfLgH8nw/pPlZ+L+YSfyqLWs=
X-Google-Smtp-Source: AGHT+IHyY77JiYRLDD6eQqOVrpXJRS94mPpqIWxOA1v3+O5DjbZ2B6MqEj48fOLN0m3u1rRN77VrKtOPvZSR6dDTTyc=
X-Received: by 2002:a2e:b0e5:0:b0:2d3:ba52:f878 with SMTP id
 h5-20020a2eb0e5000000b002d3ba52f878mr812382ljl.0.1709628158807; Tue, 05 Mar
 2024 00:42:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1706603678.git.haibo1.xu@intel.com> <a1e20de53156f50385c7609507982f08866e859b.1706603678.git.haibo1.xu@intel.com>
 <ZeailF+UYf/+4NQq@sunil-laptop>
In-Reply-To: <ZeailF+UYf/+4NQq@sunil-laptop>
From: Haibo Xu <xiaobo55x@gmail.com>
Date: Tue, 5 Mar 2024 16:42:27 +0800
Message-ID: <CAJve8okkwtvheMMURhsuboLwA+jMtryf-fn0nOvYzTMGX63yvA@mail.gmail.com>
Subject: Re: [PATCH 2/4] ACPI: NUMA: Add handler for SRAT RINTC affinity structure
To: Sunil V L <sunilvl@ventanamicro.com>
Cc: Haibo Xu <haibo1.xu@intel.com>, ajones@ventanamicro.com, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Robert Moore <robert.moore@intel.com>, Conor Dooley <conor.dooley@microchip.com>, 
	Guo Ren <guoren@kernel.org>, Anup Patel <apatel@ventanamicro.com>, 
	Alexandre Ghiti <alexghiti@rivosinc.com>, Greentime Hu <greentime.hu@sifive.com>, 
	Baoquan He <bhe@redhat.com>, Jisheng Zhang <jszhang@kernel.org>, 
	Sami Tolvanen <samitolvanen@google.com>, =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, 
	Chen Jiahao <chenjiahao16@huawei.com>, James Morse <james.morse@arm.com>, 
	Evan Green <evan@rivosinc.com>, Samuel Holland <samuel.holland@sifive.com>, 
	Ard Biesheuvel <ardb@kernel.org>, Tony Luck <tony.luck@intel.com>, Yuntao Wang <ytcoode@gmail.com>, 
	Alison Schofield <alison.schofield@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 5, 2024 at 12:42=E2=80=AFPM Sunil V L <sunilvl@ventanamicro.com=
> wrote:
>
> Hi Haibo,
>
> On Wed, Jan 31, 2024 at 10:31:59AM +0800, Haibo Xu wrote:
> > Add RINTC affinity structure handler during parsing SRAT table.
> > The ARCH specific implementation will be added in next patch.
> >
> > Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
> > ---
> >  drivers/acpi/numa/srat.c | 32 +++++++++++++++++++++++++++++++-
> >  include/linux/acpi.h     |  3 +++
> >  2 files changed, 34 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
> > index 0214518fc582..503abcf6125d 100644
> > --- a/drivers/acpi/numa/srat.c
> > +++ b/drivers/acpi/numa/srat.c
> > @@ -165,6 +165,19 @@ acpi_table_print_srat_entry(struct acpi_subtable_h=
eader *header)
> >               }
> >       }
> >       break;
> > +
> > +     case ACPI_SRAT_TYPE_RINTC_AFFINITY:
> > +             {
> > +                     struct acpi_srat_rintc_affinity *p =3D
> > +                         (struct acpi_srat_rintc_affinity *)header;
> > +                     pr_debug("SRAT Processor (acpi id[0x%04x]) in pro=
ximity domain %d %s\n",
> > +                              p->acpi_processor_uid,
> > +                              p->proximity_domain,
> > +                              (p->flags & ACPI_SRAT_RINTC_ENABLED) ?
> > +                              "enabled" : "disabled");
> > +             }
> > +             break;
> > +
> >       default:
> >               pr_warn("Found unsupported SRAT entry (type =3D 0x%x)\n",
> >                       header->type);
> > @@ -448,6 +461,21 @@ acpi_parse_gi_affinity(union acpi_subtable_headers=
 *header,
> >  }
> >  #endif /* defined(CONFIG_X86) || defined (CONFIG_ARM64) */
> >
> > +static int __init
> > +acpi_parse_rintc_affinity(union acpi_subtable_headers *header,
> > +                      const unsigned long end)
> Alignment doesn't look right. Could you please run checkpatch on all
> the patches?
>

Seems something is wrong with my vim configuration.
Will fix it in v2.

> > +{
> > +     struct acpi_srat_rintc_affinity *rintc_affinity;
> > +
> > +     rintc_affinity =3D (struct acpi_srat_rintc_affinity *)header;
> > +     acpi_table_print_srat_entry(&header->common);
> > +
> > +     /* let architecture-dependent part to do it */
> > +     acpi_numa_rintc_affinity_init(rintc_affinity);
> > +
> Is it required to have this commit first prior to architecture
> functionality? I am wondering whether it is logically better to
> implement the function first and then consume in next commit?
>

No dependency between this commit and the next commit.
Will change the order in v2.

> > +     return 0;
> > +}
> > +
> >  static int __initdata parsed_numa_memblks;
> >
> >  static int __init
> > @@ -501,7 +529,7 @@ int __init acpi_numa_init(void)
> >
> >       /* SRAT: System Resource Affinity Table */
> >       if (!acpi_table_parse(ACPI_SIG_SRAT, acpi_parse_srat)) {
> > -             struct acpi_subtable_proc srat_proc[4];
> > +             struct acpi_subtable_proc srat_proc[5];
> >
> >               memset(srat_proc, 0, sizeof(srat_proc));
> >               srat_proc[0].id =3D ACPI_SRAT_TYPE_CPU_AFFINITY;
> > @@ -512,6 +540,8 @@ int __init acpi_numa_init(void)
> >               srat_proc[2].handler =3D acpi_parse_gicc_affinity;
> >               srat_proc[3].id =3D ACPI_SRAT_TYPE_GENERIC_AFFINITY;
> >               srat_proc[3].handler =3D acpi_parse_gi_affinity;
> > +             srat_proc[4].id =3D ACPI_SRAT_TYPE_RINTC_AFFINITY;
> > +             srat_proc[4].handler =3D acpi_parse_rintc_affinity;
> >
> >               acpi_table_parse_entries_array(ACPI_SIG_SRAT,
> >                                       sizeof(struct acpi_table_srat),
> > diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> > index b7165e52b3c6..a65273db55c6 100644
> > --- a/include/linux/acpi.h
> > +++ b/include/linux/acpi.h
> > @@ -269,6 +269,9 @@ acpi_numa_gicc_affinity_init(struct acpi_srat_gicc_=
affinity *pa) { }
> >
> >  int acpi_numa_memory_affinity_init (struct acpi_srat_mem_affinity *ma)=
;
> >
> > +static inline void
> > +acpi_numa_rintc_affinity_init(struct acpi_srat_rintc_affinity *pa) { }
> > +
> I think this can be fit in single like as we can have upto 100
> characters.
>

Sure. will fix it in v2.

Thanks,
Haibo

> >  #ifndef PHYS_CPUID_INVALID
> >  typedef u32 phys_cpuid_t;
> >  #define PHYS_CPUID_INVALID (phys_cpuid_t)(-1)
> > --
> > 2.34.1
> >
