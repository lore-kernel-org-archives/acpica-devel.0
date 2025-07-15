Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3034257431
	for <acpica-devel@lists.linux.dev>; Tue, 15 Jul 2025 12:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752580969; cv=none; b=io36N362rJz7AFjwlh8FJDXTlCsp1TbMvlSXrQxpiCgNEo9jZHcQHJKdJUuOqG1CeCnGBhtT/4YwjefQRHBK6/0oX/tjLzVDouHE8hdeN260nWt47QcxiLHGlwNYMfMntRh5x6R83Wwh2Zz4fDI8J15QItapL/Y25CtZfeHAGcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752580969; c=relaxed/simple;
	bh=Jbdvt3BF3hAniD3y/5avEGNEsscSdz4sfbtK6Ng3HFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UhdHuev7+VcnRWCkUwla5j50XyDhV6HJufFknVnKoB6Dd8qVI7IFo+DEfNAARenqJnjqls+WeIi2AsMX2vrcd+UPaGvUhikkKdUf8e35vL+ekHjoawdyEIWv0Va5iYd8K1vfrrjXB2KZMEEddXBgNZwlsntg6f8AqQUvARvjf3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-606b58241c9so8943001a12.3
        for <acpica-devel@lists.linux.dev>; Tue, 15 Jul 2025 05:02:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752580965; x=1753185765;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XIvf/Fr3LIxkhupGT2xSFgDQIhAUf4dr39mOfS5w4F0=;
        b=NnND+UMUNrWN9AzcVFBBTDr9nCrtSc+Qn2Omyduz3fMhzhvHuIEmnucKrQNm5t6rFS
         RUrm0i7qQAjD6p9oa09nrc+Vf6ewTb1tZbETFuulX0lZ0l4DJ+eLGEGD5lXxbUbrSFOl
         6FBh5oa4XWQU3zDBFu2nzI13xlkkySC2enHPfngsJ3XmwPK6DD6EmDgUUIlDqrtmlcCs
         hc5jDQvR9NxixrctRA2fygd/dUQxtfwNn774akW0GhzZFE3Jy/BxkwQRUYizOUQ+CKuv
         O6HAs7nKeOD+1tXEqed/fvsAdIfLcKKP6QXwjPcDLw28oNH/x4qehb6HvYRyrbTC5g97
         72IA==
X-Forwarded-Encrypted: i=1; AJvYcCUpH3YQwniCUzkSiKir2bNeEyfY/zDF6SJquAgzL5Xp24mgjf2bRlUcZkMgJ50ncvfmIPUww9rXgp3Qq1w=@lists.linux.dev
X-Gm-Message-State: AOJu0Yy/vasWLd1ft8DhAiuLHT1xUVVSIjMJvwWOoCezdNA8f43siy+u
	JcggmaGyNsDkBbUuqm/OlVg1TTGlLefwYzggkxc0KiDTsFpLeyvaYyd2
X-Gm-Gg: ASbGnctSc4b97/qmSHV8AEK37tRnZGGRaCZ8RJWUYE3YivCkR1QnttwaB8hGEU74NIe
	ECRSRmhOwGbfp9PbaTARlm8yNWC18Up97xkmJUZMetS/JRchrJY2NVbEDGa+5e02+FAxXm+uyjc
	JQoyqfVdikkSOvbxSrZEnDTqrsusqj0kT4SfdrC4hrukyRD4D5Dxli8lMioJndVnuH4C1tOW0nB
	pAuhvJQs5MnLDh5nkqjo94y+Bal5Bdfq1NaMVDSDPPxjNX9lAzWlf77HzugzRVgAx8KepP1KUtb
	cLyLn0V7TI5GQMcp8xL7fYduqn9Zp7GM2QNgb5agUvyUyRgDOqxYT2ozj5sHqhB60BFz/Bi8sOA
	w4VNb9v2jVb290HXeSOfRAOc=
X-Google-Smtp-Source: AGHT+IGUq0hZMtYifjv/NwhfoQLLm0esSBGSGW2VDcjkCBhU/Fx4Um4vVqrpGWYQ74pVvuWAqovoTQ==
X-Received: by 2002:a05:6402:292:b0:60c:3cca:651a with SMTP id 4fb4d7f45d1cf-611e84f72b5mr12587375a12.33.1752580963098;
        Tue, 15 Jul 2025 05:02:43 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:1::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-612067f7ca6sm4969050a12.55.2025.07.15.05.02.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 05:02:41 -0700 (PDT)
Date: Tue, 15 Jul 2025 05:02:39 -0700
From: Breno Leitao <leitao@debian.org>
To: Borislav Petkov <bp@alien8.de>
Cc: "Luck, Tony" <tony.luck@intel.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, James Morse <james.morse@arm.com>, 
	"Moore, Robert" <robert.moore@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "acpica-devel@lists.linux.dev" <acpica-devel@lists.linux.dev>, 
	"kernel-team@meta.com" <kernel-team@meta.com>
Subject: Re: [PATCH] ghes: Track number of recovered hardware errors
Message-ID: <vs5x5qvw2veurxdljmdiumqpseze2myx6quw3rmt7li7d3dbin@duoky4z44zzz>
References: <20250714-vmcore_hw_error-v1-1-8cf45edb6334@debian.org>
 <20250714171040.GOaHU6EKH2xxSZFnZd@fat_crate.local>
 <SJ1PR11MB6083C38E6DA922E05E1748D6FC54A@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20250714173556.GQaHU__LL6IUIPCDIW@fat_crate.local>
 <aHWC-J851eaHa_Au@agluck-desk3>
 <20250715082939.GAaHYRc3Yn49jyvYzc@fat_crate.local>
 <kyprjdilgyz3xgw3slnrsemptnpp6h75mipv6a3lgp2dmwqekg@s7azbepy7nu2>
 <20250715103125.GFaHYt_TnFQW6ti0ST@fat_crate.local>
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250715103125.GFaHYt_TnFQW6ti0ST@fat_crate.local>

Hello Borislav,

On Tue, Jul 15, 2025 at 12:31:25PM +0200, Borislav Petkov wrote:
> On Tue, Jul 15, 2025 at 03:20:35AM -0700, Breno Leitao wrote:
> > For instance, If every investigation (as you suggested above) take just
> > a couple of minutes, there simply wouldn’t be enough hours in the day,
> > even working 24x7, to keep up with the volume.
> 
> Well, first of all, it would help considerably if you put the use case in the
> commit message.

Sorry, my bad. I can do better if we decide that this is worth pursuing.

> Then, are you saying that when examining kernel crashes, you don't look at
> I find that hard to believe.

We absolutely do examine kernel messages when investigating crashes, and
over time we've developed an extensive set of regular expressions to
identify relevant errors.

In practice, what you're describing is very similar to the workflow we
already use. For example, here are just a few of the regex patterns we
match in dmesg, grouped by category:

    (r"Machine check: Processor context corrupt", "cpu"),
    (r"Kernel panic - not syncing: Panicing machine check CPU died", "cpu"),
    (r"Machine check: Data load in unrecoverable area of kernel", "memory"),
    (r"Instruction fetch error in kernel", "memory"),
    (r"\[Hardware Error\]: +section_type: memory error", "memory"),
    (r"EDAC skx MC\d: HANDLING MCE MEMORY ERROR", "memory"),
    (r"\[Hardware Error\]:   section_type: general processor error", "cpu"),
    (r"UE memory read error on", "memory"),

And that’s just a partial list. We have 26 regexps for various issues,
and I wouldn’t be surprised if other large operators use a similar
approach.

While this system mostly works, there are real advantages to
consolidating this logic in the kernel itself, as I’m proposing:

    * Reduces the risk of mistakes
    	- Less chance of missing changes or edge cases.

    * Centralizes effort
	- Users don’t have to maintain their own lists; the logic lives
	  closer to the source of truth.

    * Simplifies maintenance
	- Avoids the constant need to update regexps if message strings
	  change.

    * Easier validation
	- It becomes straightforward to cross-check that all relevant
	  messages are being captured.

    * Automatic accounting
	- Any new or updated messages are immediately reflected.

    * Lower postmortem overhead
	- Requires less supporting infrastructure for crash analysis.

    * Netconsole support
	- Makes this status data available via netconsole, which is
	  helpful for those users.


> Because if you do look at dmesg and if you would grep it for hw errors - we do
> log those if desired, AFAIR - you don't need anything new.

Understood. If you don’t see additional value in kernel-side
counting, I can certainly keep relying on our current method. For
us, though, having this functionality built in feels more robust and
sustainable.

Thanks for the discussion,
--breno
