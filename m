Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1233CF688
	for <acpica-devel@lists.linux.dev>; Fri, 27 Mar 2026 09:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774605301; cv=none; b=URLvbThcVwPJJLmaf+JC0ptzZe0swf1yvLIkJD9OGPMxoI8Bj/ATyZSgpJUl/6zGBGePtUFYQ4MqiDIQRiwM49VKMx/eMPvMEiDqdgFG8NVLwBc3UADPflyV61Xij33xfa8TobdOF+QKBQBY267t07nsB8ZYLs0ETBEyU05c6lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774605301; c=relaxed/simple;
	bh=G/QB1JNOHcc+vsbxLMISXhWfq90+5X/vEx02XOqeVIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WlkNAgJB/fRCAZic4aaeyywFOdY5EHXA2ZtLyUDl4nzERliPPcIhjQpkQzGArVoq+Su1AkkHp4/relUikdYKZfxGlN1Bck0GSg3K6e42Mp6MxYH/mtYFblOLSIge2B8n6ttvIY9REQwYH84FmI1g6azx8TDx4/bYFUmLa9LafpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=VxIZ0VPK; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="VxIZ0VPK"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-439cd6b0aedso1225502f8f.1
        for <acpica-devel@lists.linux.dev>; Fri, 27 Mar 2026 02:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1774605296; x=1775210096; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1KfOjXOUPA7aUNexnAO30qRyN744gIjbadETuO1mA9w=;
        b=VxIZ0VPKvAvO8q74T0vZ42ew0XbKQ6ej7DQv4iVFKADEuA/y0TDiOmdvywXVva/+2a
         snaR+YR1l/N9hTbDtZa4STzuDx+2SCULOFR0SHBj/PkeMnSYY9L6yXbo9NSXkhYW4ovt
         lcKc+sl8zCvCSvTFEUaDDBdsZNL2FLvA7WoUb0jBwAxYlCzvRsYO/G7ItUrZpSJY5kLx
         SG0B+98TPWHIii8qGow1NmVTpqjQJVbBHJ9SdUw90PR9AZtKyZI6YGbHzZk5bQhFggMj
         CmmCLTHDp679iDgdMpUk8YiUlY+kA1mtAli3gXGiygsniVJNNRmu+9bvyPLrdPPTICJB
         Z90Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774605297; x=1775210097;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1KfOjXOUPA7aUNexnAO30qRyN744gIjbadETuO1mA9w=;
        b=Ema/+5xyBuiQjjCaxZaiPjkK1n2+Tm97AMsByT9sM+ZyFmQaWI20g/VIevKpSXCgHb
         Hg/WhtrUj1G7gQzhlIiUUKtoWpc9C+RpdvfJYWO5q9M1VR2MqLjPD6e11O0JhwRQGhvf
         PgdeyYzbXnvIe7EY12eUnq/9QISVS5D8nNql+RZ9NrwFscZd26gXSjShboceGS/BtqC5
         4ECQSzUp33g/QnlQcuUfE8NDNm1Qlb0+UWNP9mzRpQPtW2eErUb88Q1JDPo97O7fPTrC
         lYlz9cdVn0kfgKeBx64qsb2N8ARDoxWaefoTnJ0KY8Mswp9D1K3siuIZjLNaFEQicG0C
         LX1A==
X-Forwarded-Encrypted: i=1; AJvYcCUbTsKcIAONWFqfDSDw11T4Klg1fn4CM7cnhr2IASglk9uABvyK+lftmdIVaVADEeM5l2j+q5zAGUp52UY=@lists.linux.dev
X-Gm-Message-State: AOJu0YyundMAExw533HLM0B2kMjxOiH5NCG6kt1me30Bx1zExiLHXMlV
	UShMR5VHOSsZ/TUnTrzMMsWr4VFMAZ3/Dhgp8TsyUexF0QUSOp9PTkXkvb9KGKt1tYI=
X-Gm-Gg: ATEYQzwolWi+HfT10u2Ack6g1Fgj+eGBLZLI7W/bDvVqLgr9H4TZBFGr8VgHmiwrVxp
	ejEwLcFCT0xo7w4OcNCq/B5GagCc0Uc09v7IVWQdpGkWNZjRPuTg1mTBzbCrS0qDu7C5Q+JXjHS
	/fVSBwCmXB48uUgdc1VcuewFwgCGQUXthYIjxZrBYzDMJfUfBHZco3nl/3CKc43IDzQLLcRhSeV
	HhVCrH2jDO25tZx/G74iYJb4cr41cpiZgd9lQA4yp2zh4wG18YxJZxYE2cmau9dH+fekk/nY8qj
	oIdr6HH75mS6azfR8CPZWmDlSs7ZL5oPbiN2zIrYnO9mxk6+/aEzrFvMZ0maz9bWDas3GR9Ik2s
	CVpJLcMnvIubT8m0jonRFzx2dGe5gDaeLPDeq3iR4vcqk0GQX013xZwZZohas5+9WHCm2V4ANtL
	XZpgr3hogrIvqHwpWpTNH/THyf5A==
X-Received: by 2002:a5d:64e6:0:b0:43b:8fa4:1937 with SMTP id ffacd0b85a97d-43b9e9d5ea1mr2872332f8f.5.1774605296458;
        Fri, 27 Mar 2026 02:54:56 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b919df7e7sm13463368f8f.26.2026.03.27.02.54.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 02:54:56 -0700 (PDT)
Date: Fri, 27 Mar 2026 10:54:54 +0100
From: Petr Mladek <pmladek@suse.com>
To: david.laight.linux@gmail.com
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Robert Moore <robert.moore@intel.com>, Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH next] ACPICA: AML Parser: Remove spurious precision from
 format used to dump parse trees
Message-ID: <acZT7vZ-4GZdDh3f@pathway.suse.cz>
References: <20260326201830.3938-1-david.laight.linux@gmail.com>
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260326201830.3938-1-david.laight.linux@gmail.com>

On Thu 2026-03-26 20:18:30, david.laight.linux@gmail.com wrote:
> From: David Laight <david.laight.linux@gmail.com>
> 
> The debug code in acpi_ps_delete_parse_tree() uses ("%*.s", level * 4, " ")
> to indent traces.
> POSIX requires the empty precision be treated as zero, but the kernel treats
> is as 'no precision specified'.
> Change to ("%*s", level * 4, "") since there is additional whitespace and no
> reason to indent by one space when level is zero.
> 
> --- a/drivers/acpi/acpica/pswalk.c
> +++ b/drivers/acpi/acpica/pswalk.c
> @@ -49,8 +49,7 @@ void acpi_ps_delete_parse_tree(union acpi_parse_object *subtree_root)
>  
>  				/* This debug option will print the entire parse tree */
>  
> -				acpi_os_printf("      %*.s%s %p", (level * 4),
> -					       " ",
> +				acpi_os_printf("      %*s%s %p", (level * 4), "",
>  					       acpi_ps_get_opcode_name(op->
>  								       common.
>  								       aml_opcode),

The change has no visible effect. The precision defines how many
characters are copied from the given string. It does not matter
here because the given string is empty "". The number of added
spaces ' ' is defined by the field width parameter (level * 4).

Anyway, the change makes sense:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
