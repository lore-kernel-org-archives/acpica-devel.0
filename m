Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C682EF287
	for <acpica-devel@lists.linux.dev>; Fri, 25 Jul 2025 16:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753460196; cv=none; b=Ef6LDfubOn1o4JsLLD0+5MtAJj/APC4OzSZvHh5myaiELof8m3hsOKXXamTvnh0k1D0WHqaDv9nWvPs+Cyjx8TI8tU3RZ3PUDdhB3nq95Pwvaq7VpGEu3IuocFh23jgKLSw0DlKJVTVYfJzy/aoGby5+FLVpDYp3AO2xrylNq7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753460196; c=relaxed/simple;
	bh=VQ1Sb6bzClPJLyUB37odBN7nVHwdCTVLgyDv6w/LViw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sV9zTo5VQfFyVTEMVWu4neeLabrp2sQGCBd7sbRXIqdIXT4WsvXeN5X7cbmzBpayegyT0ATdgmS+m3WUqha++ZXS2ADRLQ9MfTVh7djjK2jip9GtD5RbhGplNoEkRqz0CUMWFb7d2F9/zjLm2hWj0hpOV8BbjB81HpXfFLrFOhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ae3cd8fdd77so468210766b.1
        for <acpica-devel@lists.linux.dev>; Fri, 25 Jul 2025 09:16:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753460192; x=1754064992;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k9lVzColSUbzoyzWK1v2ytYya9LR+3IJRUPOrRIrYkE=;
        b=r5/ZrXywQD/HudlAkwga5SIjOM7MUCq9eCaKfWR5E62qZa0jGx5EIrgWtj1NShuAet
         lyWfTHTXAgUfxSMlf0V49Uits3lHKeF9OQojXA7hRcHaDij/GSML8rlBDkcaBb/q1AHQ
         zBYV/gscT/rlosTdTTx5w5q2t4xK0AjQ+RP6BGWmOYMeRd8tpxFhxI0V9Z+v9idvpITv
         AyqFJV4NlaIU+Z/prqUylr9y7HThSrIdtgoXauAlh97TOmZSWd44lp/2Q2wIqcWzN4kd
         d6vzyeMjgykI3F0Gv+ABLY46n9PE2T/zuyvYO+kbF8hLKd5I0DilgpLu+XB67vRpJlrh
         IMdQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJJRqJpcPaRdCBG7Gtpj5+9s5fQAFUEUM0E3MJl67tVgxTyuXkgxCXdEt9jxCEPRBfMEsxtvpOwhawQ3o=@lists.linux.dev
X-Gm-Message-State: AOJu0Yz/3+Vf5O9b6aCtmHGV9NcMpfJ9PDngHMSjRNXd+Ud+AMOZiHp3
	lQKttGvlVMsLeBz6GUvBx8F+xylJzWXR1GW0AG2xbgPa9FpbWVqmNi6/
X-Gm-Gg: ASbGncskaYd17FJ6KI5LdrfSNB9KfGtvtZfJFveTV1Fw3R35svPnilBNhJc4ptjHm5j
	xKitN65ibq5AcMV3LLeetBq6JxmW658pLNUu//2r3MAUxVQx/egLmhsmXpRJX59XhZDXpJ+mkH3
	1J8y2xNBEYOiUtDYXGmwAoP3PQePon1czwStu1dkX28AVYNU7JVzUIFLpCrCGfgvveRU3HJeDsO
	5GQ86L6lLoIcGWZ8cun1h8L3PY9HuFtoMSvasHafydw9mES5UMS0PO5BY1legMb2L0+NCP7zd2o
	dJBYHNYq9a+KaX6T2vVRRP1I1E607ES+vhu/eVzcROqiy50pCukAmTHOHW+8sSzyvkI0YzXT5JK
	Fz/Yuo4p+dunabw==
X-Google-Smtp-Source: AGHT+IHbjaJ8cbbWsPvmFdchaHgB59gZMNGBegBtlGVNhjnCNqWbZSGSDTI+qaKic8T0W3LbKoDy/Q==
X-Received: by 2002:a17:907:7ea9:b0:ae0:9fdf:25e8 with SMTP id a640c23a62f3a-af61e6368d8mr274930166b.47.1753460191687;
        Fri, 25 Jul 2025 09:16:31 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:74::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af635af9967sm11514466b.131.2025.07.25.09.16.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 09:16:31 -0700 (PDT)
Date: Fri, 25 Jul 2025 09:16:28 -0700
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
Message-ID: <ldlansfiesfxf4a6dzp5z2etquz5jgiq6ttx3al6q7sesgros6@xh4lkevbzsow>
References: <20250722-vmcore_hw_error-v3-1-ff0683fc1f17@debian.org>
 <7ce9731a-b212-4e27-8809-0559eb36c5f2@linux.alibaba.com>
 <4qh2wbcbzdajh2tvki26qe4tqjazmyvbn7v7aqqhkxpitdrexo@ucch4ppo7i4e>
 <fdb5dced-ea5a-48b8-bbb4-fc3ade7f3df8@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fdb5dced-ea5a-48b8-bbb4-fc3ade7f3df8@linux.alibaba.com>

Hello Shuai,

On Fri, Jul 25, 2025 at 03:40:58PM +0800, Shuai Xue wrote:
> > > APEI does not define an error type named GHES. GHES is just a kernel
> > > driver name. Many hardware error types can be handled in GHES (see
> > > ghes_do_proc), for example, AER is routed by GHES when firmware-first
> > > mode is used. As far as I know, firmware-first mode is commonly used in
> > > production. Should GHES errors be categorized into AER, memory, and CXL
> > > memory instead?
> > 
> > I also considered slicing the data differently initially, but then
> > realized it would add more complexity than necessary for my needs.
> > 
> > If you believe we should further subdivide the data, I’m happy to do so.
> > 
> > You’re suggesting a structure like this, which would then map to the
> > corresponding CPER_SEC_ sections:
> > 
> > 	enum hwerr_error_type {
> > 	HWERR_RECOV_AER,     // maps to CPER_SEC_PCIE
> > 	HWERR_RECOV_MCE,     // maps to default MCE + CPER_SEC_PCIE
> 
> CPER_SEC_PCIE is typo?

Correct, HWERR_RECOV_MCE would map to the regular MCE and not errors
coming from GHES.

> > 	HWERR_RECOV_CXL,     // maps to CPER_SEC_CXL_*
> > 	HWERR_RECOV_MEMORY,  // maps to CPER_SEC_PLATFORM_MEM
> > 	}
> > 
> > Additionally, what about events related to CPU, Firmware, or DMA
> > errors—for example, CPER_SEC_PROC, CPER_SEC_FW, CPER_SEC_DMAR? Should we
> > include those in the classification as well?
> 
> I would like to split a error from ghes to its own type,
> it sounds more reasonable. I can not tell what happened from HWERR_RECOV_AERat all :(

Makes sense. Regarding your answer, I suppose we might want to have
something like the following:

	enum hwerr_error_type {
		HWERR_RECOV_MCE,     // maps to errors in do_machine_check()
		HWERR_RECOV_CXL,     // maps to CPER_SEC_CXL_
		HWERR_RECOV_PCI,     // maps to AER (pci_dev_aer_stats_incr()) and CPER_SEC_PCIE and CPER_SEC_PCI
		HWERR_RECOV_MEMORY,  // maps to CPER_SEC_PLATFORM_MEM_
		HWERR_RECOV_CPU,     // maps to CPER_SEC_PROC_
		HWERR_RECOV_DMA,     // maps to CPER_SEC_DMAR_
		HWERR_RECOV_OTHERS,  // maps to CPER_SEC_FW_, CPER_SEC_DMAR_, 
	}

Is this what you think we should track?

Thanks
--breno
