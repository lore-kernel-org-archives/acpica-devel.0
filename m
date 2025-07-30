Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0903FE5
	for <acpica-devel@lists.linux.dev>; Wed, 30 Jul 2025 17:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753895793; cv=none; b=Z2GMOP4M4fpV5ZizOp2JsL5Pa2kSRZjhNcbKQEpGvPDCrddandc2Q5jAlk/DCPv3Nq6ke8BHpNpNSIcRDPLllIZvtTYNvyRg/h7yt8Dj9ciBY+LDStghjsvn+BpclObz0v1C2MU+qkadY621FxhHHUdm+5CJjBIxFi2W4XCwP5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753895793; c=relaxed/simple;
	bh=5dgWE8kGKN0+BBI5HchFbQBXxau1BlUs1gU3Amh3ayM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tsG052AQAPKQERbPMGZ+5TsIX5zGquhgfFi4GRlA0/hFwgA0aXdCG0EbBx8NaWrfLkacuau9SiwQpQK2tq8e4NhnOcCS+81B6Ix9h/G3n/waKuXDKsDYH8MugMssAXjPkrtI5vWUrClwQczfyHSYjzea0UAju1Bppo1mCfnn91Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-615378b42ecso480a12.0
        for <acpica-devel@lists.linux.dev>; Wed, 30 Jul 2025 10:16:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753895790; x=1754500590;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QnBLTSAmqLEpz+AnF+mqUYEiUlYclERoRLZ14/+NMT0=;
        b=BBQfbohFFqDvVaOYZyITcHmWZUFLXEUNzePpC23+8qn8XVkEgmWgKz6UGchiOr/2oJ
         abNXbgEq9J3aA8gC3JO2B/JBZZQHQK9NcFufAAL+RyE/jouBgYRLz0Dc9gYTZNfK08s4
         S9kgQFMezlg4vRFQ5+OalCPh85fvOcCfX80CMhaemPmbWDNVtXP5CYHkWJuWOxOlNxy1
         elBWjfFx+4dK0UvRMiif4GAFa8JJIMy+3rhX31Ig7/MuP8fziNjyLTo8D04MKgYvrO6Y
         YpPJcLiSA0leldbSb6F7EonMNon2j2eUt++f0w9IuDkW4aNtPk1F6VtFjWubkeMpw/5Z
         DcvQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVXEX15GRuh/Aw+Jm7hM4i7ufaNgwxyoi8mDirRCzdtMJSundL58UE5NUWuSuauJRPTjTDPThCGIq6Tg0=@lists.linux.dev
X-Gm-Message-State: AOJu0YzfIGP3eTKrhe73+K1HGQ0DWQg1eVXK0uvUq1YYyKIC3RqGJBXB
	4Lz8QOVvI7OYtK1T1Kp7CU87Rqr/0CVh1IIWrlE2jmG02QKeePleVKjh
X-Gm-Gg: ASbGnctbxB0Wf/fTQSphVylrtXydSE4sMoxwPeLhqnDxoet8nk+9QgzKpKNI8LBqRKL
	hY7h9vGUKHE4BiHlmXNuhD88cdoPTJxoktwU0ZEG54a1NWp/3oC9uVniPx0pBuAwPcU7ZhqMesV
	6WCXGDXj8pC92pvjLFtBxrd09TpQu0ok8yzqon7vDjqJ0v8xA+OKizrQEt85kJAPoSuNm4fIcpF
	haByudSoIiURhNCz4Gd6RPn2lSEDQBYHrRYIUML9JjHRFvsoA7I/rXC25SPtSACwyS8O5y9dGmp
	44LdUm4oyjM4UeN9o1QjkAALVE8W9j+7LECuhma2lPyFfBKvZJWtSwNCbnYZrZvqpx6ai+yyRae
	4Lp0E+69hMhRS
X-Google-Smtp-Source: AGHT+IEiGi0ZE+hn6nJPN3xAPRd7sUfNkdea1puk9Js+8BUSU2zNcBVIaxaV6D3y2/hqS+gwsWTE+g==
X-Received: by 2002:a05:6402:5245:b0:615:7703:e0a7 with SMTP id 4fb4d7f45d1cf-615872098ccmr4788798a12.26.1753895789412;
        Wed, 30 Jul 2025 10:16:29 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:3::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61548bca6acsm3819155a12.17.2025.07.30.10.16.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 10:16:28 -0700 (PDT)
Date: Wed, 30 Jul 2025 10:16:26 -0700
From: Breno Leitao <leitao@debian.org>
To: Shuai Xue <xueshuai@linux.alibaba.com>
Cc: Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, James Morse <james.morse@arm.com>, 
	Robert Moore <robert.moore@intel.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Hanjun Guo <guohanjun@huawei.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>, 
	Oliver O'Halloran <oohall@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, acpica-devel@lists.linux.dev, osandov@osandov.com, 
	konrad.wilk@oracle.com, linux-edac@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-pci@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v3] vmcoreinfo: Track and log recoverable hardware errors
Message-ID: <yhfoip6ihr5r75pa7vnz3x53nifaxvi6rbin32nhwqx4hu7gnn@taj22iria3aa>
References: <20250722-vmcore_hw_error-v3-1-ff0683fc1f17@debian.org>
 <7ce9731a-b212-4e27-8809-0559eb36c5f2@linux.alibaba.com>
 <4qh2wbcbzdajh2tvki26qe4tqjazmyvbn7v7aqqhkxpitdrexo@ucch4ppo7i4e>
 <fdb5dced-ea5a-48b8-bbb4-fc3ade7f3df8@linux.alibaba.com>
 <ldlansfiesfxf4a6dzp5z2etquz5jgiq6ttx3al6q7sesgros6@xh4lkevbzsow>
 <4ef01be1-44b2-4bf5-afec-a90d4f71e955@linux.alibaba.com>
 <2a7ok3hdq3hmz45fzosd5vve4qpn6zy5uoogg33warsekigazu@wgfi7qsg5ixo>
 <a87c5e74-082f-4be6-bbfd-4867bf72ddcc@linux.alibaba.com>
 <zc4jm3hwvtwo5y2knk2bqzwmpf7ma7bdzs6uv2osavzcdew3nk@lfjrlp6sr7zz>
 <a0839ff9-ea8d-44b9-8289-fcd5039e9263@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a0839ff9-ea8d-44b9-8289-fcd5039e9263@linux.alibaba.com>

Hello Shuai,

Thanks for the review,

On Wed, Jul 30, 2025 at 09:50:39PM +0800, Shuai Xue wrote:
> 在 2025/7/30 21:11, Breno Leitao 写道:
> >
> > @@ -1690,6 +1691,9 @@ noinstr void do_machine_check(struct pt_regs *regs)
> >   	}
> > 
> >   out:
> > +	/* Given it didn't panic, mark it as recoverable */
> > +	hwerr_log_error_type(HWERR_RECOV_MCE);
> > +
> 
> Indentation: needs tab alignment.

No sure I got what it the alignment process. The code seems to be
properly aligned, and using tabs. Could you please clarify what is the
current problem?

> The current placement only logs errors that reach the out: label. Errors
> that go to `clear` lable won't be recorded. Would it be better to log at
> the beginning of do_machine_check() to capture all recoverable MCEs?

This is a good point, and I've thought about it. I understand we don't
want to track the code flow that goes to the clear: label, since it is
wrongly triggered by some CPUs, and it is not a real MCE.
That is described in commit 8ca97812c3c830 ("x86/mce: Work around an
erratum on fast string copy instructions").

At the same time, the current block of MCEs are not being properly
tracked, since they return earlier in do_machine_check(). Here is
a quick 

   void do_machine_check(struct pt_regs *regs)
   ...
          if (unlikely(mce_flags.p5))
                  return pentium_machine_check(regs);
          else if (unlikely(mce_flags.winchip))
                  return winchip_machine_check(regs);
          else if (unlikely(!mca_cfg.initialized))
                  return unexpected_machine_check(regs);

         if (mce_flags.skx_repmov_quirk && quirk_skylake_repmov())
                  goto clear;

	  /* Code doesn't exit anymore unless through out: */

    }

Given that instrumentation is not enabled when those return are called,
we cannot easily call hwerr_log_error_type() before the returns.

An option is just to ignore those, given they are unlikely. Another
option is to call hwerr_log_error_type() inside those functions above,
so, we do not miss these counters in case do_machine_check() returns
earlier. 


--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1481,6 +1481,7 @@ static void queue_task_work(struct mce_hw_err *err, char *msg, void (*func)(stru
 static noinstr void unexpected_machine_check(struct pt_regs *regs)
 {
        instrumentation_begin();
+       hwerr_log_error_type(HWERR_RECOV_MCE);
        pr_err("CPU#%d: Unexpected int18 (Machine Check)\n",
               smp_processor_id());
        instrumentation_end();
diff --git a/arch/x86/kernel/cpu/mce/p5.c b/arch/x86/kernel/cpu/mce/p5.c
index 2272ad53fc339..a627ed10b752d 100644
--- a/arch/x86/kernel/cpu/mce/p5.c
+++ b/arch/x86/kernel/cpu/mce/p5.c
@@ -26,6 +26,7 @@ noinstr void pentium_machine_check(struct pt_regs *regs)
        u32 loaddr, hi, lotype;

        instrumentation_begin();
+       hwerr_log_error_type(HWERR_RECOV_MCE);
        rdmsr(MSR_IA32_P5_MC_ADDR, loaddr, hi);
        rdmsr(MSR_IA32_P5_MC_TYPE, lotype, hi);

diff --git a/arch/x86/kernel/cpu/mce/winchip.c b/arch/x86/kernel/cpu/mce/winchip.c
index 6c99f29419090..b7862bf5ba870 100644
--- a/arch/x86/kernel/cpu/mce/winchip.c
+++ b/arch/x86/kernel/cpu/mce/winchip.c
@@ -20,6 +20,7 @@
 noinstr void winchip_machine_check(struct pt_regs *regs)
 {
        instrumentation_begin();
+       hwerr_log_error_type(HWERR_RECOV_MCE);
        pr_emerg("CPU0: Machine Check Exception.\n");
        add_taint(TAINT_MACHINE_CHECK, LOCKDEP_NOW_UNRELIABLE);
        instrumentation_end();

