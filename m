Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3B33AD532
	for <acpica-devel@lists.linux.dev>; Thu, 26 Mar 2026 08:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774513982; cv=pass; b=HQYq1NfMNybsrbEAV7bOCtzQ2/kixgLkye+2lLJhftLSCVIoBBO6KyHLivyEAqSjAoGqdb6vtge+bl8zQ41h6CZny/QXEJ4YCi2yIM2ry0dkQSel2esAD966mGq4KDJhVaEMlkt1SSS+Hiu6wu4ovsM8sanbpnt/GvkFJ1t+o6M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774513982; c=relaxed/simple;
	bh=y1dooAU1BdG3t77Ol/IyqzrIRk3RQ4SObO3++MueMSk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZYMTNgjSlmZUIzzetAv9ThF3FN6sa98C3cIgJ4B5+dTUddQGVQ6ZRO5wiDrx2VxgTdRB4z2Sq9sslYa4u45IYmPVuJ3I1zQC8f2CZYH4m8/m8AS3L2Vmv8SAN78Ag7NBOpPpOYXnNDCUBKZpAEhJR+ill28FdnGDZOyipb/yGxc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=lwVE6oBO; arc=pass smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="lwVE6oBO"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7d8b2703f37so613935a34.1
        for <acpica-devel@lists.linux.dev>; Thu, 26 Mar 2026 01:32:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774513978; cv=none;
        d=google.com; s=arc-20240605;
        b=Trl+Csf8UPm4e/IC4XSZl+z7L0t7xeo0p1BkaUAf9WPPegw1j1XM9g4EVYfG2TQ4/Y
         u+tk74Q9QdAIIG+UC/OFpGK+nrJDcVERKskh5YGpmNhlzTaWSUmeVskwuRcUDRyW2n32
         4Qwf84vgkAsmCYKv2kUxE+XVM81VYHnsPeIU4Fp7E9E5xHPYiuiPn90oR7mCbbh7YJep
         jc5kf9Nfsyz0It4h/My0835UDDuIGLLBMp0JJ3LJp0DcswkqxZPArbwKNMUo8lxhiasr
         czB0/WCzi1dge5B1LeUc4dBaZhpWT8C7FgJEwYyXfY9szMh7DgtCT3+8jVddCMKZNJNT
         zX2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mePLymdm4A/01lEY7TSspPJxPyHHrcq2b7WusiYGL2A=;
        fh=3ouQHFgYC3r8d37qHpxOlnS8aDUdsQ7/5IlpoiobQRc=;
        b=HpsMfbOxp4lfIDcZSAT97WpHR1WEo4Qke24xpedw6v7Qoo3vXpI1phF7g9Dq2jS2Rr
         uFkdF4Zo7aZtuehnShbVmfEI0xF1oiq0+xIdhHLFhB47lFmkud/PLHG/j7TResD56RRo
         6/hv4pH8UiXUmvcXy5eqf26gIr0LybSh7hc4Z453w4pldCKko6ORrk6DsJWckp9ikBrG
         B+3F5ZYHis5mpgQVwu64kgyNvG/v7ZOD6hPZETo3JSoDgCwx6hC1pyCjDDPpEOxVRu+F
         5AcL0xmu4qqSXRt08+3SU79LAmH9/HEw/7TC+w0cRX17p0vJRyjQaCxp4tqXCLVDY0R0
         v9cg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1774513978; x=1775118778; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mePLymdm4A/01lEY7TSspPJxPyHHrcq2b7WusiYGL2A=;
        b=lwVE6oBOXvKKK3ipuqTM+gRqyOPvVALjtYhhBG9G6tkYq80h3Oa52mhGaTQy9GbGM4
         hUN0cwXWtlbjDkemrysHVx3n/w4D5DQviKvd+YoPJ8FZbGugLrb9grdHDA2joTw4k7JT
         yDJ10zUgugczL4J1as26ytCzgRU79i0efJoexrNrOtAJ4WTDv07PreBvl/dvXo9BxUtu
         uU0bbtfhVrWH4Ats/edgOIBD4krNGqRZSitc/GXZYxIHl83PbSKnVzWl14ly/Wb+WJ4t
         rFAiN54TCd6xUwx5AWwa6sicJmIJs4yeG9hZtnh9pmyZWKWF4vdBg7KQ1wSTOzx+AYd+
         iBUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774513978; x=1775118778;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mePLymdm4A/01lEY7TSspPJxPyHHrcq2b7WusiYGL2A=;
        b=BACoR6eMoPIRJbWWsh5Tx9uWBNt+Pq/OHzSqTcA7EpycUtYJAHUde6xRgJ9iT7nevm
         t/d00B2/56U9Z48m7ljSx5swSOCNO8HRmsyR/yf0OIGguXWgKs91ml+SMe66VqZgBx5z
         G41nN197mXJMc7sUztUqJt+4qzVdHUrwJ/3SehChCHaMYAL/j+f4pIFwPOze7ag4Y+6e
         X+euO5bf2uBJ7R2K0MStdd14UhkZqZoI9IaSQ8h3npSGaCKgriD/Rz1zA9lWi0GMT6XQ
         0gf4XSWHz+QnGK40Qvabk3BKIhPG25l3niHsV3B8QuJUKoomfGpg0MjMyhlBWC8AFtme
         vRhQ==
X-Forwarded-Encrypted: i=1; AJvYcCXuSeRv5v1De0DJNTyHirjulGvD5AeDQ3df7RDb24F1uJkPf6RL2QPDR18fm08ZF9Lwy5E0u1D7N+SipHU=@lists.linux.dev
X-Gm-Message-State: AOJu0YwsbZYPgyPf0FEq7WgLpEMMjeUibrLAQ2xJyO1op3bOGsnuXB9I
	j5utpZREkJYbO7S2gGGyF4oyeN6sUnOPOZ1FImj6evP1qUPiM/Z2g68K91TV91qRQ7rv6Q8t/ti
	yxtZSoqgQ2Z99FdFRg1Smai6qbn+ETdw+/5uJu4dbWg==
X-Gm-Gg: ATEYQzykeFRU1NV4B/EA7GuIsfBsXHdaNXbfLB13BDfVX7H+igTFQgpK1Kk7DgMgbE1
	T5rubx1xjtN6kXFB+zijcZTdEyRdqx9twT41NN7ZKNYnM4sy6TETTrLTBAuQvFUBBpBGwObkSoE
	aFSkiL46h3rmJEC642PkiwzxEp6d9k4qHDAyJjA7WwKU55UirAPrOWhS0cYUSA7T/V1FRgJlyqC
	T5tTWJY4zL9Jfy15rLITF5KBYqKocZBE47ZxhsGtr9Sru60XUpYQl+MNG/JmyxXLS/NFrUjlJKN
	OuGl4w==
X-Received: by 2002:a05:6830:3988:b0:7d7:de7f:1216 with SMTP id
 46e09a7af769-7d9d6a2ee3fmr4210937a34.34.1774513978540; Thu, 26 Mar 2026
 01:32:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260128-ssqosid-cbqri-v2-0-dca586b091b9@kernel.org>
 <20260128-ssqosid-cbqri-v2-6-dca586b091b9@kernel.org> <CAEEQ3wmuAnHU1VBFDwbCBFb8j63ZcizJ3jEC2SiVWnoMPc4=SA@mail.gmail.com>
 <acOFef6f9og1hft2@gen8>
In-Reply-To: <acOFef6f9og1hft2@gen8>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Thu, 26 Mar 2026 16:32:47 +0800
X-Gm-Features: AQROBzDH3jYcjM2CiSfjVYp26hEHF6X2ANXFbNRUWifhxguxrWvAlswpTfv9uY4
Message-ID: <CAEEQ3w=zV1k+uea5D9tnO=O5X5LQUpyNVZi8V8TOANxXJQbg=w@mail.gmail.com>
Subject: Re: [External] [PATCH RFC v2 06/17] RISC-V: QoS: define CBQRI resctrl
 resources and domains
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

On Wed, Mar 25, 2026 at 2:49=E2=80=AFPM Drew Fustini <fustini@kernel.org> w=
rote:
>
> On Wed, Mar 25, 2026 at 10:31:39AM +0800, yunhui cui wrote:
> > Hi Drew,
> >
> > On Thu, Jan 29, 2026 at 4:28=E2=80=AFAM Drew Fustini <fustini@kernel.or=
g> wrote:
> > >
> > > Define data structures to encapsulate the resctrl resource
> > > and domain structures.
> > >
> > > Co-developed-by: Adrien Ricciardi <aricciardi@baylibre.com>
> > > Signed-off-by: Adrien Ricciardi <aricciardi@baylibre.com>
> > > [fustini: rebased current upstream]
> > > Signed-off-by: Drew Fustini <fustini@kernel.org>
> > > ---
> > >  arch/riscv/kernel/qos/internal.h | 27 +++++++++++++++++++++++++++
> > >  1 file changed, 27 insertions(+)
> > >
> > > diff --git a/arch/riscv/kernel/qos/internal.h b/arch/riscv/kernel/qos=
/internal.h
> > > index ff2c7eff50be..c0402dd06cfa 100644
> > > --- a/arch/riscv/kernel/qos/internal.h
> > > +++ b/arch/riscv/kernel/qos/internal.h
> > > @@ -65,6 +65,11 @@
> > >  #define CBQRI_BC_ALLOC_CTL_OP_READ_LIMIT   2
> > >  #define CBQRI_BC_ALLOC_CTL_STATUS_SUCCESS  1
> > >
> > > +int qos_resctrl_setup(void);
> > > +void qos_resctrl_exit(void);
> > > +int qos_resctrl_online_cpu(unsigned int cpu);
> > > +int qos_resctrl_offline_cpu(unsigned int cpu);
> > > +
> > >  /* Capacity Controller hardware capabilities */
> > >  struct riscv_cbqri_capacity_caps {
> > >         u16 ncblks; /* number of capacity blocks */
> > > @@ -125,4 +130,26 @@ struct cbqri_controller {
> > >         bool mon_capable;
> > >  };
> > >
> > > +struct cbqri_resctrl_res {
> > > +       struct rdt_resource     resctrl_res;
> > > +       struct cbqri_controller controller;
> > > +       u32 max_rcid;
> > > +       u32 max_mcid;
> > > +};
> > > +
> > > +struct cbqri_resctrl_dom {
> > > +       struct rdt_domain_hdr       resctrl_dom_hdr;
> > > +       struct rdt_ctrl_domain  resctrl_ctrl_dom;
> > > +       struct rdt_mon_domain   resctrl_mon_dom;
> > > +       u64 cbm;
> > > +       u64 rbwb;
> > > +       u64 *ctrl_val;
> > > +       struct cbqri_controller *hw_ctrl;
> > > +};
> > > +
> >
> > Can we trim down some fields? For example:
> >  struct cbqri_resctrl_res {
> >         struct rdt_resource     resctrl_res;
> > -       struct cbqri_controller controller;
> >         u32 max_rcid;
> >         u32 max_mcid;
> >  };
> >
> >  struct cbqri_resctrl_dom {
> > -       struct rdt_domain_hdr       resctrl_dom_hdr;
> >         struct rdt_ctrl_domain  resctrl_ctrl_dom;
> >         struct rdt_mon_domain   resctrl_mon_dom;
> > -       u64 cbm;
> > -       u64 rbwb;
> >         u64 *ctrl_val;
> >         struct cbqri_controller *hw_ctrl;
> >  };
>
> Can you explain why you don't think these are needed??

The functionality works well without those fields, feel free to try.

Btw, when do you plan to send the next revision?

>
> Thanks,
> Drew
>

Thanks,
Yunhui
