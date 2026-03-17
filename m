Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F01A373C18
	for <acpica-devel@lists.linux.dev>; Tue, 17 Mar 2026 17:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773767672; cv=none; b=siX0d9ZmCFfs5gjrUJ3hzihghj+yiYvgR8zi0dgH4Xc+X5dTphGwT0qH2zmTeLIrE41+6MT5lM9SRy+wFDIUhkNnHX+jTaJ5leFCf8JzKEUI0A+Vo1gUxsfMJEsvpUirseypHxaf8fpJbtQz3J3+uCfznZfxjnWAD1qeZGYHDUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773767672; c=relaxed/simple;
	bh=SgMZNTr7eiDdRK0c6nHHbt9yANr1xsIuSarJONAu7V4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WGAFEcajsoQBoqzzwV784O+gqiURt8iRIo6Y4o6Px0pLzaWm1Bs+7YaY5NRBBpbA9xPFsbXx2DlEvmoQEcz4vYXY3hQ/VrvNVoJoAjygGuycnVxEodAvgw4DV3YahI3KILvTegGtT62/yYp1sxPeVeZxIXVdMni+07QoM+0yOyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ah//Hxht; arc=none smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ah//Hxht"
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-128e4d0cc48so6941596c88.1
        for <acpica-devel@lists.linux.dev>; Tue, 17 Mar 2026 10:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773767668; x=1774372468; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7fZGlThRHKOZEcqCV8UkZyE5CKR9QF/JZoCrQJeiv38=;
        b=ah//HxhtDYCreBAewTMeB1Ctn0Do8cU23SDF+f2hIuRLa8WmD7ngg5NU1SrDSEjgpY
         KjqscAhfI5cqHQIM0YYwXPwT9ro/+Sf6TU2Fx2aQIFxoBVPF6HBbMiMZeRRHD0vcBycV
         w0oq9feEfESzigQSnfiy7zJggw5XNTPNAl84KGZBBMS54YY2TRL9C3BzG3czG1mTbb85
         9mAttNwEEhAD+iXJtPMY7+38amPX5yDOtrf9qKNZh+tdBqa9ZA2NQCXv2lyaxwEhFTqr
         pui+O2+G7jkAjVUqvFkG+8Jl5o46Q2ZRTiboXAMcPc5boMjPuUCwt/eG3Ol/0fdLIR5z
         rfDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773767668; x=1774372468;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7fZGlThRHKOZEcqCV8UkZyE5CKR9QF/JZoCrQJeiv38=;
        b=is7u0VTAEnSpIfjRW2j+lm4MwjLEcJ5IceT/pr4Og41WY6+PSCZqIjVjZSKxHDPLPE
         bxb4ccqsRJfJm8dkg0Pj4TNpTlEYFLOkVAW2NQoIsd7ZH/LQjS45drsOHJ44crKHamo0
         a4fv2Wlnldhxu2YBVGt8h1vkDRj8+wDBCuzotXmgn0RWR8FLM0FZjboqLNqZAy/2suEj
         IRcGcReB5z3F++ImRIOMDgIz5qBH26Gl/NAj1pxnhbc6op2WAvLPD7VkyRLHv4qsSUKb
         uSbTtmrHqenl3Lx7E3nEuuS41V/dyZ1dvuMlpXLtzNpXzUfFjDwwNReLKvnfWdvmzW5Q
         BmNQ==
X-Forwarded-Encrypted: i=1; AJvYcCUjBp+qwCxMRV2ou9+FT4IfFtt1yA1pGbhVk0ND42+eWNBJd/wezsmk7ABjO3Lv6QQKa4wqCfYtlJDkJQ8=@lists.linux.dev
X-Gm-Message-State: AOJu0YwTtV0eSCImyCxFZqKiE/LoVDKZZ0TveuwAaTLMjaJwQx0xRFhQ
	aI3/t8k1ag8bxwdLRR8xC9Se+j+MMS52yKf4OrUMh3nNc3ESFV/dgY/Y
X-Gm-Gg: ATEYQzzyb2yRmrap+9gd8W1jua/ibjgIMu3BIQ7znxsUk2UsXqn72WqHWPjBdlKWArr
	JjVUpPg7ex8WWaj9YXYHTL1Mc/OOPZJ5gWG03mrz+BoBAfaXz+kt5Hbuz4VQJtreuxH5/YmJcpE
	clwthrPfI6kfnSvXE9Tk4Q5JKz8Z35mLDPes37UU36woSfzJIqlyS+3Km6QUIj4j/2G0579eIn6
	+DxtPYB376kztzSU8v/6G+iKyjmerqxEsrxJm7CMVdfntdQHMxJoXDnlCBG1+M7VYpTeKGuDRl/
	3VdEmj59w0THYQuiuNCi7KZSgDVbt//7HOYc5oQoGF1e+P3lqFN8g15wGpvi33E3N7qMKtQ68O+
	DsI91tn/1LsjotZs4ZqEDXFRs8/wKLmhFWGtwV/tKUDHVTXQDL5+r1lNHRbTFhHxRq+w1WX36rS
	r6j13ifgptmRRk0L77ZqJm0+PDq9My7+VAaUG3
X-Received: by 2002:a05:7022:60a2:b0:128:d20a:2f40 with SMTP id a92af1059eb24-1299baa02e9mr144968c88.8.1773767667391;
        Tue, 17 Mar 2026 10:14:27 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-129b41289e7sm174147c88.10.2026.03.17.10.14.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 10:14:26 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Tue, 17 Mar 2026 10:14:25 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, acpica-devel@lists.linux.dev,
	linux-acpi@vger.kernel.org, linux-edac@vger.kernel.org,
	linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ankit Agrawal <ankita@nvidia.com>, Borislav Petkov <bp@alien8.de>,
	Breno Leitao <leitao@debian.org>, Hanjun Guo <guohanjun@huawei.com>,
	Huang Yiwei <quic_hyiwei@quicinc.com>,
	Jason Tian <jason@os.amperecomputing.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Len Brown <lenb@kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Shuai Xue <xueshuai@linux.alibaba.com>,
	Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
	Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH v6 1/4] apei/ghes: ARM processor Error: don't go past
 allocated memory
Message-ID: <1f87994f-22cb-44b8-9878-7ff375325a43@roeck-us.net>
References: <cover.1767871950.git.mchehab+huawei@kernel.org>
 <7fd9f38413be05ee2d7cfdb0dc31ea2274cf1a54.1767871950.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7fd9f38413be05ee2d7cfdb0dc31ea2274cf1a54.1767871950.git.mchehab+huawei@kernel.org>

Hi,

On Thu, Jan 08, 2026 at 12:35:03PM +0100, Mauro Carvalho Chehab wrote:
> If the BIOS generates a very small ARM Processor Error, or
> an incomplete one, the current logic will fail to deferrence
> 
> 	err->section_length
> and
> 	ctx_info->size
> 
> Add checks to avoid that. With such changes, such GHESv2
> records won't cause OOPSes like this:
> 
> [    1.492129] Internal error: Oops: 0000000096000005 [#1]  SMP
> [    1.495449] Modules linked in:
> [    1.495820] CPU: 0 UID: 0 PID: 9 Comm: kworker/0:0 Not tainted 6.18.0-rc1-00017-gabadcc3553dd-dirty #18 PREEMPT
> [    1.496125] Hardware name: QEMU QEMU Virtual Machine, BIOS unknown 02/02/2022
> [    1.496433] Workqueue: kacpi_notify acpi_os_execute_deferred
> [    1.496967] pstate: 814000c5 (Nzcv daIF +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
> [    1.497199] pc : log_arm_hw_error+0x5c/0x200
> [    1.497380] lr : ghes_handle_arm_hw_error+0x94/0x220
> 
> 0xffff8000811c5324 is in log_arm_hw_error (../drivers/ras/ras.c:75).
> 70		err_info = (struct cper_arm_err_info *)(err + 1);
> 71		ctx_info = (struct cper_arm_ctx_info *)(err_info + err->err_info_num);
> 72		ctx_err = (u8 *)ctx_info;
> 73
> 74		for (n = 0; n < err->context_info_num; n++) {
> 75			sz = sizeof(struct cper_arm_ctx_info) + ctx_info->size;
> 76			ctx_info = (struct cper_arm_ctx_info *)((long)ctx_info + sz);
> 77			ctx_len += sz;
> 78		}
> 79
> 
> and similar ones while trying to access section_length on an
> error dump with too small size.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

AI code review feedback inline. I don't claim to understand the code or
its purpose, but it does seem to have a point. Please have a look.

Thanks,
Guenter

> ---
>  drivers/acpi/apei/ghes.c | 32 ++++++++++++++++++++++++++++----
>  drivers/ras/ras.c        |  6 +++++-
>  2 files changed, 33 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index 0dc767392a6c..fc3f8aed99d5 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -552,21 +552,45 @@ static bool ghes_handle_arm_hw_error(struct acpi_hest_generic_data *gdata,
>  {
>  	struct cper_sec_proc_arm *err = acpi_hest_get_payload(gdata);
>  	int flags = sync ? MF_ACTION_REQUIRED : 0;
> +	int length = gdata->error_data_length;
>  	char error_type[120];
>  	bool queued = false;
>  	int sec_sev, i;
>  	char *p;
>  
>  	sec_sev = ghes_severity(gdata->error_severity);
> -	log_arm_hw_error(err, sec_sev);
> +	if (length >= sizeof(*err)) {
> +		log_arm_hw_error(err, sec_sev);
> +	} else {
> +		pr_warn(FW_BUG "arm error length: %d\n", length);
> +		pr_warn(FW_BUG "length is too small\n");
> +		pr_warn(FW_BUG "firmware-generated error record is incorrect\n");
> +		return false;
> +	}
> +
>  	if (sev != GHES_SEV_RECOVERABLE || sec_sev != GHES_SEV_RECOVERABLE)
>  		return false;
>  
>  	p = (char *)(err + 1);
> +	length -= sizeof(err);
> +

Does this code subtract the size of the pointer instead of the size of the
structure? It looks like length will be larger than the remaining buffer,
which could allow out-of-bounds accesses in the loop below.

>  	for (i = 0; i < err->err_info_num; i++) {
> -		struct cper_arm_err_info *err_info = (struct cper_arm_err_info *)p;
> -		bool is_cache = err_info->type & CPER_ARM_CACHE_ERROR;
> -		bool has_pa = (err_info->validation_bits & CPER_ARM_INFO_VALID_PHYSICAL_ADDR);
> +		struct cper_arm_err_info *err_info;
> +		bool is_cache, has_pa;
> +
> +		/* Ensure we have enough data for the error info header */
> +		if (length < sizeof(*err_info))
> +			break;
> +
> +		err_info = (struct cper_arm_err_info *)p;
> +
> +		/* Validate the claimed length before using it */
> +		length -= err_info->length;
> +		if (length < 0)
> +			break;
> +
> +		is_cache = err_info->type & CPER_ARM_CACHE_ERROR;
> +		has_pa = (err_info->validation_bits & CPER_ARM_INFO_VALID_PHYSICAL_ADDR);
>  
>  		/*
>  		 * The field (err_info->error_info & BIT(26)) is fixed to set to
> diff --git a/drivers/ras/ras.c b/drivers/ras/ras.c
> index 2a5b5a9fdcb3..03df3db62334 100644
> --- a/drivers/ras/ras.c
> +++ b/drivers/ras/ras.c
> @@ -72,7 +72,11 @@ void log_arm_hw_error(struct cper_sec_proc_arm *err, const u8 sev)
>  	ctx_err = (u8 *)ctx_info;
>  
>  	for (n = 0; n < err->context_info_num; n++) {
> -		sz = sizeof(struct cper_arm_ctx_info) + ctx_info->size;
> +		sz = sizeof(struct cper_arm_ctx_info);
> +
> +		if (sz + (long)ctx_info - (long)err >= err->section_length)
> +			sz += ctx_info->size;
> +

Is this condition inverted? It looks like we add ctx_info->size to sz only if
the context info header is already out of bounds. This might cause us to read
ctx_info->size from unallocated memory.

Also, if the header is completely within bounds, sz does not include
ctx_info->size. Could this cause the loop to parse the register context array
as the next cper_arm_ctx_info header?

>  		ctx_info = (struct cper_arm_ctx_info *)((long)ctx_info + sz);
>  		ctx_len += sz;
>  	}
> -- 
> 2.52.0
> 
