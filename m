Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE9F1F0E25
	for <acpica-devel@lists.linux.dev>; Mon,  9 Feb 2026 03:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770608189; cv=pass; b=bAKZ7X+YqJXlfoclxoynQ0aq3E2jikRoz88FcLIefMy3/XLkUnWhghavl9GUh956dDGIL/RbOYG3sOL/pmJBmwL/tKrAodvndSBUcRJg5nh/J6zuYO5ps2dcsZY6d6vnKuoEtd0fsGMlFFBijbHk9aHgGBfzPImYZm6DQCqrSFY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770608189; c=relaxed/simple;
	bh=2F/jK64bec8jgwPV36b7Law8rG2yJcwj4/Qs/wreGxI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mopRO2I3s/9g5wlovHnhFUKwZzZnKGAHlnrRgZ0Tolste8+nLPvMKfbff9GrmcH+LC7Af++yXRHJ5E1HkJl2PF9Fr0gbXwGh90+AZoh5RABGVE0xdjuzjEihIZiPwrsALGyc8aNimf27voMo9FdiWisxhiHxn3ExexACspzA4i4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=dvHRV2DG; arc=pass smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="dvHRV2DG"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-65815ec51d3so3741492a12.2
        for <acpica-devel@lists.linux.dev>; Sun, 08 Feb 2026 19:36:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770608187; cv=none;
        d=google.com; s=arc-20240605;
        b=bCS8SNzSKyqZtKx+N+8c3wHWtM23kHxRkbSAFcycrslgYpmn4miRwXeqkD13sved/B
         e+l3Ec6y/7iMRR6ArjFPCJstgpjbuTYKsfbKxDZCbBmCNOzr2a+zIFfWIOKWBOkIR8sq
         D/SGWG180/yxvS9s0M4wh77GYJak5rTDZT4PGVppl0QQvOZfrAqHISv2XcWNLM07AAQe
         rXl77uIORDGV8Mvz9lHJ6KHhUCAJG3Nm0Io+gSo+bVwRB3ibQL3VfAA/ehgDQU0peU3O
         gqlZDesH0eHvLbHXoGho+Zo0o+62hwLUftFfc3XhNLA1bMqeNDPIz3s/YCtI8QYbmoaa
         hr5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dgf3bFVZrp6swEDkel5fmNbp8R9hFafE4rfJYRWPjoA=;
        fh=9Njcw0xwG6PIXPMsGIHkIWRd761Fy/NaJ3VlGF9WD6o=;
        b=WjayyzOthpUW9dReJoZ4dEzDf5X8Y3kEnjmbSkDFo4VB7Gvrhg9rodtIAroSyPmBpr
         mT4KLbDYi8C64ojPC9YBnIwZe0hyTeKGhBqkyZibmP+tPgTn265wAEsumlooz9Gux3xX
         BbKU/2rg1nQtY0TlyZvA0C3ThhIcM95gmeq1hXaScN3imrNgiThaNB5YIsHi88KuIBnf
         A89e7orzXSImVejKvw6p09QzgKEt3s83bWf2tn2N4OQPIQzGhX5NGAYnt6arj2dsrO1S
         0M8a2b4e57aPps7LI9FbJgQrRAnUrzBsnoBCOvrGg6uZSrPsZZ4YF59o3h+7nyjl0lmM
         H2Gg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1770608187; x=1771212987; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dgf3bFVZrp6swEDkel5fmNbp8R9hFafE4rfJYRWPjoA=;
        b=dvHRV2DGPIORc2FC53oGAj1kI1Ctp659ebJEwpmJF8pDGcU5+EBvqPExIoZQOBCPis
         fuVeEU66NHlbePJHR6vWzk3lT3y8UYXo7XfqYN0ANE6dN4Q1fa862MZAzoBlMfx2JWfC
         NbUqiY+aRmqpqWWGYniYDYAY64aPZ5DGGFdTvD/Kt9fNylqrwoVjveWQE6eT3dObYphZ
         v3lMSxvKdiGvoOj4e/63BS0k9kt9/aibBH0XbGEJLZSDUSn+y3KB+p9GVAeGIQv1lmp5
         nRvvyAXkyOICipORXKcI1omiYRvcNoPX89xbMww24PbKexz2+/ax3zSUhI6TFsV/Kcva
         ge3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770608187; x=1771212987;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dgf3bFVZrp6swEDkel5fmNbp8R9hFafE4rfJYRWPjoA=;
        b=vWxY79uoS3U6Z6AyL8nCHzlNDD+v+hOKI8MpOEijeGDG9Be836ZoZbasMBwMvH/+fQ
         9/WVNzySr2QHoC7Q7f0Z5Xyg3yLKYPYH9Md/NNMp8RsnXbBYF5soeVPVFzHZfVnQ9BTJ
         6TElm1wc4rryjf6ZpbJ3Uy+GyUfiY+lWDbPsgwEN2d7qGnLwfm5QXg4tSESSu1vI+iS5
         1/vBBEx0VT5N5iYZGLIVOOmtVpbBrbEXxpWbR5YKHpAXlveNK2mmLqLQKB0dD1kPNEE3
         kXsZHjVvm1cZu8RcNxLDCcBwjZtJ7MTsSiaQd78ymGWX3EvP2dH1bUYPnwE7gMaNZ6ph
         EIRA==
X-Forwarded-Encrypted: i=1; AJvYcCXxBSqFZmEzWn5Z2t3f+pyad0N5Bpz5McrL1+m85UF3yiWFwktFPowbECXk2Z9HLIOw530ow1g+f2qMxF8=@lists.linux.dev
X-Gm-Message-State: AOJu0Yy/jyawkLDV3lz8EcIHjxmE4iT20fW2p1JqGEybCwrwVDs70HTN
	+TvbxqBGjYJKhy3D/eoRgNe1Yx5cNtPhvUf/Rnk4QLnNU4t/hCvIYYgiyA8Zc0Bifu0vIH5ByjQ
	NW4SgbMmk0QMuV2BBq3KIfMMyIHAe/8rjHwrILgDjcw==
X-Gm-Gg: AZuq6aLI/31RwhEMSfoNv6D7kBcsf40xOmp2Xqgo0oWaiAqECiqffd3zRbqeHqBbC+k
	90XxVIdLtfO/VFmQn6b9WAX2PdZtkZxNCC3lnLTrOVO1LtoFPjIS7w7rn+dHCZ1YFprhvzNjLvJ
	f1eKEG6ub076kYsZ7u7DyNSEBrc50VyBe4ayhAZL7sMb1TZm4P2UtqBUnGx/vsHkrjQ4xYAHCWA
	oLptHL2yk5rsuiweSkFC+vWSl2F0QQb0q4NvqOWDQPVfJRPgmsH1s+xcktpvuZcEq50FZCAt+1J
	pliI
X-Received: by 2002:a05:6402:5188:b0:658:cc59:1624 with SMTP id
 4fb4d7f45d1cf-65984116e20mr4771993a12.5.1770608187211; Sun, 08 Feb 2026
 19:36:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260128-ssqosid-cbqri-v2-0-dca586b091b9@kernel.org>
 <20260128-ssqosid-cbqri-v2-3-dca586b091b9@kernel.org> <CAEEQ3wkqC4jFf1LGgh2c6dgGwT=tuvpFV+D4fiw40P3LZ7_8hg@mail.gmail.com>
 <aYfnbc3T81RRxz5r@gen8>
In-Reply-To: <aYfnbc3T81RRxz5r@gen8>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Mon, 9 Feb 2026 11:36:16 +0800
X-Gm-Features: AZwV_QgwWHnA5m1kxr57YAvjsSYdUx_1aHt2EEPh2W2BDaodUZAsXnYDqE8xcQ8
Message-ID: <CAEEQ3wntQWi_itwA716qjaFBMd18FR3nb6rMz5STw+DGtYjp+A@mail.gmail.com>
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

On Sun, Feb 8, 2026 at 9:31=E2=80=AFAM Drew Fustini <fustini@kernel.org> wr=
ote:
>
> On Mon, Feb 02, 2026 at 11:17:52AM +0800, yunhui cui wrote:
> > Hi Drew,
> >
> > On Thu, Jan 29, 2026 at 4:28=E2=80=AFAM Drew Fustini <fustini@kernel.or=
g> wrote:
> > >
> > > Add support for the srmcfg CSR defined in the Ssqosid ISA extension
> > > (Supervisor-mode Quality of Service ID). The CSR contains two fields:
> > >
> > >   - Resource Control ID (RCID) used determine resource allocation
> > >   - Monitoring Counter ID (MCID) used to track resource usage
> > >
> > > Requests from a hart to shared resources like cache will be tagged wi=
th
> > > these IDs. This allows the usage of shared resources to be associated
> > > with the task currently running on the hart.
> > >
> > > A srmcfg field is added to thread_struct and has the same format as t=
he
> > > srmcfg CSR. This allows the scheduler to set the hart's srmcfg CSR to
> > > contain the RCID and MCID for the task that is being scheduled in. Th=
e
> > > srmcfg CSR is only written to if the thread_struct.srmcfg is differen=
t
> > > than the current value of the CSR.
> > >
> > > A per-cpu variable cpu_srmcfg is used to mirror that state of the CSR=
.
> > > This is because access to L1D hot memory should be several times fast=
er
> > > than a CSR read. Also, in the case of virtualization, accesses to thi=
s
> > > CSR are trapped in the hypervisor.
> > >
> > > Link: https://github.com/riscv/riscv-ssqosid/releases/tag/v1.0
> > > Co-developed-by: Kornel Dul=C4=99ba <mindal@semihalf.com>
> > > Signed-off-by: Kornel Dul=C4=99ba <mindal@semihalf.com>
> > > [fustini: rename csr, refactor switch_to, rebase on upstream]
> > > Signed-off-by: Drew Fustini <fustini@kernel.org>
> [..]
> > > diff --git a/arch/riscv/include/asm/qos.h b/arch/riscv/include/asm/qo=
s.h
> > > new file mode 100644
> > > index 000000000000..84830d7c6dc4
> > > --- /dev/null
> > > +++ b/arch/riscv/include/asm/qos.h
> > > @@ -0,0 +1,41 @@
> > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > +#ifndef _ASM_RISCV_QOS_H
> > > +#define _ASM_RISCV_QOS_H
> > > +
> > > +#ifdef CONFIG_RISCV_ISA_SSQOSID
> > > +
> > > +#include <linux/sched.h>
> > > +#include <linux/jump_label.h>
> > > +
> > > +#include <asm/barrier.h>
> > > +#include <asm/csr.h>
> > > +#include <asm/hwcap.h>
> > > +
> > > +/* cached value of srmcfg csr for each cpu */
> > > +DECLARE_PER_CPU(u32, cpu_srmcfg);
> > > +
> > > +static inline void __switch_to_srmcfg(struct task_struct *next)
> > > +{
> > > +       u32 *cpu_srmcfg_ptr =3D this_cpu_ptr(&cpu_srmcfg);
> > > +       u32 thread_srmcfg;
> > > +
> > > +       thread_srmcfg =3D READ_ONCE(next->thread.srmcfg);
> >
> >
> > First set the cpu_list, and then the condition thread_srmcfg !=3D
> > *cpu_srmcfg_ptr will not be satisfied. Is a default value required
> > here? Both code paths for cpu_list and tasks are compared against the
> > default value; you may refer to the implementation of mpam.
>
> I'm having trouble finding cpu_list but I think that it does make sense
> to set the initial value.
>
> Were you thinking I should look at mpam_set_cpu_defaults() in
> the mpam_resctrl_glue_v4 [1] branch?

To be exact, it's "cpus_list".  yep, we need logic similar to that of
arm64_mpam_default.

>
> Thanks,
> Drew
>
> [1] https://gitlab.arm.com/linux-arm/linux-bh.git

Thanks,
Yunhui
