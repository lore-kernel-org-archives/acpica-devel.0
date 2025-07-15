Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E1B271466
	for <acpica-devel@lists.linux.dev>; Tue, 15 Jul 2025 10:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752574042; cv=none; b=TBby84QEKZuD6STaka7zkJk0/NwOHDFFoxQbsF+rEHtNZvnmEnaoD/zwg1mI6MLk8BPNwXUYn3wConwl1s5jPKlzRiE/Iqr9zV2WQskgUkhgsKBkd07odFxgeMARQHkqMODtMPOKzJDEc3jQRtBqC+2cHm0zeseItH0j8wUKR6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752574042; c=relaxed/simple;
	bh=CEsVDuk89VpKmAPWQ5Lc9vHgl5qUJQIeXFI8iRVERSo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dQdOpfV6CxcSuPbhnBkNdzrhs3rzc9KqxDsI07Jg6yhr47ZeepW0xofiHRZSVoXp/dEC9azU5RNf6vDq/zQ29aqhkIJueMJtS/x36KaJVl0Gn+ONw6qyerTGAST7PieNPOJLuBT9kvu2ffpR1Tik5DwXrIn9kSAvQ/lzojV0Av0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ae9be1697easo56322466b.1
        for <acpica-devel@lists.linux.dev>; Tue, 15 Jul 2025 03:07:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752574039; x=1753178839;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9CyqsNhV6AOPqrjCx0s1BS/XfJpNNVBgBdd+x3YjLSA=;
        b=wBU6HzNN/yqZJowBk4vsDGLLRv65AnTVhA4EEs9rj4xEwcG/xwiPPCMbfMndA1MdL/
         u/+xeqNcl+3AQPYzpKuywzByIEeOOGR2sQf/u4Qn5ECTcodystDdK/Xxd0C3fjc1pfOO
         pJFk3by5CagZKbn6qeX/u/uLx8JW8fvAwL973SCLZMbUt0d0nykb1CejgltuDAh9Bmwu
         LOo5GGpXLsL4mdGuI3tG0NEnivTYQ0yZzOXqA0bWVDHHsgt7Qwlrl1eFsgxpQ7M1Shlv
         g/zGcCUVCwbveVeNKeVK7rc4puBh0ZvWfHa4ivhSurSWTVtWCN+D3beLE1nZZ1gUCycM
         2MWA==
X-Forwarded-Encrypted: i=1; AJvYcCUmhSqLZw2O0S1jpmhmUQ/FJSi/tnFOKz0MxBcPQz+BdVb8hRiArWmrby3O8qppUh0xzHJywCyxsiTbJjQ=@lists.linux.dev
X-Gm-Message-State: AOJu0Yzj/2U326hfdiJwJSXatUImiva5hLV16rdJEXrddq5LFGusudSF
	QZkobuOf5NPJnJL3GRL9Iamuo2cZzIA/XgUN8KTWesdHi4UH35gDeEwZ
X-Gm-Gg: ASbGncvwRzmREkDpWwqQcz/jZqVyOetBG6cjH//Rj4e+PHB3LECS8A6GUeHZVR79clV
	hNwAEFNG2nkojJRfz9Gf4nwWZ3Is5SHSa6gpcXH3OGRz4P/J2CR83YkEQw746uFTVNsSgb/Dk4C
	ee2gpJZh2ACpLKGyVcZj+A6up8Hshn/ZhcYF92IH/N00W7DhvqqejvcxEjSX2j35Ie9m6tgKrQd
	+Ywfr1LU6Cip64IDJQzLqW+U2zi1Lrs5WxQ6vaeTOFQL1p9UXRpuXIS5PDvhZWu9jH20fvn5GYB
	Qwiqtej/C4d81PuNAa0Z+GpOaFErfisGXTrEE1f8h4iCGD90+1QbyR8vaxTp5QypQN5ekDdvubO
	ld+IxNE1u97fctrGKpNY7Q2I=
X-Google-Smtp-Source: AGHT+IGAZs6WyRVig7C1YfRiiiEkEK4uMkpC8Yd4rgpV4X4+QdVS5c4fnynPR/MaJfKvgMAJayrtSg==
X-Received: by 2002:a17:907:78a:b0:ae3:6fdb:6e9d with SMTP id a640c23a62f3a-ae9b5bd5291mr266858166b.1.1752574038322;
        Tue, 15 Jul 2025 03:07:18 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:5::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e82dedd3sm972662566b.150.2025.07.15.03.07.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 03:07:17 -0700 (PDT)
Date: Tue, 15 Jul 2025 03:07:15 -0700
From: Breno Leitao <leitao@debian.org>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Borislav Petkov <bp@alien8.de>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, James Morse <james.morse@arm.com>, 
	"Moore, Robert" <robert.moore@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "acpica-devel@lists.linux.dev" <acpica-devel@lists.linux.dev>, 
	"kernel-team@meta.com" <kernel-team@meta.com>
Subject: Re: [PATCH] ghes: Track number of recovered hardware errors
Message-ID: <cw6miesl6kwlpf4p4zjbeemam47n5sljtwbut6qpsadmfykwym@x55nztp5e7ln>
References: <20250714-vmcore_hw_error-v1-1-8cf45edb6334@debian.org>
 <20250714171040.GOaHU6EKH2xxSZFnZd@fat_crate.local>
 <SJ1PR11MB6083C38E6DA922E05E1748D6FC54A@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20250714173556.GQaHU__LL6IUIPCDIW@fat_crate.local>
 <aHWC-J851eaHa_Au@agluck-desk3>
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aHWC-J851eaHa_Au@agluck-desk3>

On Mon, Jul 14, 2025 at 03:21:44PM -0700, Luck, Tony wrote:
> On Mon, Jul 14, 2025 at 07:35:56PM +0200, Borislav Petkov wrote:
> > On Mon, Jul 14, 2025 at 05:33:45PM +0000, Luck, Tony wrote:
> > > > If you're going to do this, then you can perhaps make this variable always
> > > > present so that you don't need an export and call it "hardware_errors_count"
> > > > or so and all machinery which deals with RAS - GHES, MCE, AER, bla, can
> > > > increment it...
> > > 
> > > Not sure I'd want to see all the different classes of errors bundled together
> > > in a single count.  I think MCE recovery is quite robust and rarely leads to
> > > subsequent kernel problems.
> > 
> > That's what I said. And a RAS tool can give that info already.
> 
> There's some value in it being in the kdump file, rather than having
> to correlate data from multiple places. That's both time consuming
> and error prone.

That's precisely the aim: I want to streamline the process without
duplicating detailed error reports, since we already have specialized
tools for in-depth analysis.

Even a brief value in the crash dump alerting the reader that errors
occurred would be a valuable aid for anyone diagnosing the issue.

> > But for some reason Breno still wants that info somewhere else.
> 
> So what about something like:
> 
> enum recovered_error_sources {
> 	ERR_GHES,
> 	ERR_MCE,
> 	ERR_AER,
> 	...
> 	ERR_NUM_SOURCES
> };
> 
> static struct recovered_error_info {
> 	int	num_recovered_errors;
> 	time64_t	last_recovered_error_timestamp;
> } recovered_error_info[ERR_NUM_SOURCES];
> 
> void log_recovered_error(enum recovered_error_sources src)
> {
> 	recovered_error_info[src].num_recovered_errors++;
> 	recovered_error_info[src].last_recovered_error_timestamp =
> 		ktime_get_real_seconds();
> }
> EXPORT_SYMBOL_GPL(log_recovered_error);
> 
> 
> PLus code to include that in VMCORE.
> 
> Then each subsystem just adds:
> 
> 
> 	log_recovered_error(ERR_GHES);
> or
> 	log_recovered_error(ERR_MCE);
> etc.
> 
> in the recovery path.
 
Thanks. Let me play with this suggestion.
--breno
