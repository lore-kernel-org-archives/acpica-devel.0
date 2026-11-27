Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795807105;
	b=uOh19EnvrJzn+lokzlaeBERbguYAR5dyEJRywPVHZOM0+3ZOdY5mrNmOh/KpxJM1z5Ue
	 u2uFdowtCg5UZ9lMEq87jEfDRsxiFzHhmfQ6hmfSVo1bUXidC4qQxxt4oQ2Wxh0WWYZRz
	 rIK2GzVGAkueNyFjLw4fYeUIiVYRQUTBd14EgM2QACCASd1O0XMaLBRmlWzxrpKpTItY1
	 bGLl92NBqH1sDB/MH8DFYoos+JI6d7TW2tGcCdTRHMDkDwtScmOaUOzAVmdcf0LeqS+bM
	 xrbR1uEOPjErUpWSz9g0huizECLQMTEQcq9lAZVhK+6VyVBN/abdLoWq2FJlw68FS1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795807105;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=W1FdGtSZDb7NmxvDylEt54duEw4UgMOOnUX7lvsLEnY=;
	b=4BKvB+j/mENjltdl8d/JkcTMHX4Mx34aGJ8iu6FeMWVAVd/yk9gOtnlr5L94iLHW8WSO
	 FIek2j+l3GYB93t16YQxIyXmofpUZVq9ObgzVJ1VG4W+kgUkJthnCeTitr4Xomliph1fK
	 JNAkVYoaQoBGlcvvq+tbjcEcgNZqXp/BP9eGLB5ThgWkNpDLqmOadhPSSSdw4YB1u+BP0
	 yTtOAEW4Lw1lDUkofc4jbaWF6xMX9hbVL64EUlyUCeia5g1IGGdchbcx0kRHFg3JTQ/jA
	 xtXhE2TKb10KiVB4cSldlKVCCMNhorsM8Rwp1/QDIQbqqjk600fj2xyQnqJrUE28fbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=BNGDyDIR;
	arc=none smtp.remote-ip=209.85.160.171
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9351606A321
	for <acpica-devel@lists.linux.dev>; Fri, 27 Nov 2026 19:18:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E9351606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=BNGDyDIR
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-55c4e670fc6so63617591cf.0
        for <acpica-devel@lists.linux.dev>; Fri, 27 Nov 2026 11:18:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1795807104; x=1796411904; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=W1FdGtSZDb7NmxvDylEt54duEw4UgMOOnUX7lvsLEnY=;
        b=BNGDyDIR3NCf6F/Sm0ZSV71gSEZ2BlUcw4hfYYwMaD5AK3NtGn6AX074TT8PKAMCKy
         OgKvCQ8jMFkMCmxNd56jfVda8rr3O7FSJJvl6c7BqSAjC06HBwHPW4o2Yki06Rg7Vpku
         ruj6XGXnazALwM+1gA3fEy+Z5Njc1m5t5aP32msEmdoeQMk3osKxLyp/d4gCrLkc2dDY
         dtW5S/iVemTg3EiG+1Mj1e24/NNvqIsbGrqyOBXDRzWGVDje4G1XJbgJCIm/vAEBSGHD
         oKz4F0psoIDNiMrJUALDDx05RQ9CBikJ1Y53cDcTuQBCUJ9Wpwovz2ZrRW20sZSrGuXI
         mU7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795807104; x=1796411904;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=W1FdGtSZDb7NmxvDylEt54duEw4UgMOOnUX7lvsLEnY=;
        b=ffefyx6ZO4LHFFV29wyz2X1NrLtrjLXElmrR+eGgTYFJSKbKH2Ank3wXY+MhHjzeok
         vGux3mS67fyS8Mf2HN29lJCY1Dt8JfIDpNF9+Du1tayZ0W6SMQWwzH7WOX/qpZzYF5ym
         U4cwLsevdhBa35ZgwKG0IJpwOp8ovNph70ioiJR/7q++047s/V3OJ1A0KgAJXv27YGof
         El8fhpe6qsguRAUZW6drk1mZ6yDYpDljIr4FJSskDuR+abNXnC+kCsXpbpgIg8uh0hPn
         UXLUD00NmsJz5STSPdxQMA7CM0qepS/DnSbyL0dLkNuQ2kX8UY/DDrku7aSKsbNs7F/E
         RlVw==
X-Forwarded-Encrypted: i=1; AL+hErHB3YJ154u42f6neWaauWBlaMzc7v5PmmeWbvMi/6R/rWRmQZo1ktIaAfILkimekqGfnGWZCv28wCV+y90=@lists.linux.dev
X-Gm-Message-State: APuU4Z99ts9IaW3ViI4Ad8/IAjt6jojOiLXxGrOeTYAumXnDL2/FSF1a
	afIOChIkab+SGBAKa4sLAnIo6CGH8CGjbYs0M1Tidq6lfvyrG1/hionTwyCcP25v8o4=
X-Gm-Gg: AZFdTZeZUDCH1BdpPRVQ5iU5u0xYClNB6apnWV/Du8CqyE8zZXfZ2J1uFJ/ieGz/PO3
	glra20lH2eEUlo92+HqxSLQGthHLH9zbKWDBnvzyGbqyZTi2SFrP5Keq85+/G2QQ4nKYqVNhxvM
	KJwezK8d/o1HDj8UY/lSVVvfzIDr1bwE05wbKoldwaXtPIBO2PITEjHwju2ivxwjypg8lM/Bj5n
	8SXlCvqn4Yl9mY1HPaFWBSAOZGuFn41/9kYcLVqIfRhYihgFBrKDS3Ny8xRY6CfcrQV3qrO7OoB
	E7YI4kETyKYQejWcZUUhVN5lvkmnnB10duY+O0f834g4mgnhi0uopBS6GcLYXjVxVFgKV+F2FEx
	+E7ARmq39u9CyNP904yXgqZ25SxDs+OF98jCe+oUi1V0gTmr9FNFe/l/iNpiNVGYDB9IX8xITaX
	+2CnjSEmpFO95TCcYp2krYFwizvp+0PxSnZB6bIMjtM1kXDtiBTcpguj7To7olGKLIt840FwNHd
	ndJB0jD8wItHlfbx6n7r4lNVLmbY31zg/PKIQ5Kd7FFwWe/N2yIgqO3Mhd24jrIkMwZFEI6YBI+
	sJdEsg==
X-Received: by 2002:a05:620a:6f0d:b0:939:6dea:374d with SMTP id af79cd13be357-949ba9d1fa6mr4395559985a.49.1795807103939;
        Fri, 27 Nov 2026 11:18:23 -0800 (PST)
Received: from ziepe.ca ([142.177.118.84])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-949bb418241sm1867466985a.38.2026.11.27.11.18.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 11:18:23 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xX1Sg-00000007nGK-3YSV;
	Fri, 27 Nov 2026 15:18:22 -0400
Date: Fri, 27 Nov 2026 15:18:22 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Suzuki Poulose <suzuki.poulose@arm.com>,
	Steven Price <steven.price@arm.com>,
	Sami Mujawar <sami.mujawar@arm.com>, thuth@redhat.com,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <shuah@kernel.org>, Len Brown <lenb@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH RFC v3 7/8] attestation: providers: introduce CCA Guest
 attestation provider
Message-ID: <20261127191822.GA1856591@ziepe.ca>
References: <20261127-arm_cca_mr-v3-0-df3230afce8f@arm.com>
 <20261127-arm_cca_mr-v3-7-df3230afce8f@arm.com>
 <20261127170722.GT246011@ziepe.ca>
 <awnK2c3kMq8p2a_7@e129823.arm.com>
 <20261127183550.GV246011@ziepe.ca>
 <awnV5S703Rgf5sh5@e129823.arm.com>
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Post: <mailto:acpica-devel@lists.linux.dev>
List-Help: <mailto:acpica-devel+help@lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:acpica-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <awnV5S703Rgf5sh5@e129823.arm.com>

On Fri, Nov 27, 2026 at 07:11:33PM +0000, Yeoreum Yun wrote:
> I think the problem is the *max-token-size* could be changed.
> once the LFA updates the Realm definitely the contents of hash of
> firmware binary can be changed. this means the token's content could be
> change including the *max-token-size*.

I think that is broken, there is no good way to make that work in a
sane manner.

LFA must stay under the hard wired max-token-size limit, not try to
change it while a realm is running. Take this to your spec team.

> For this, the RSI host call interface has the way to get LFA eventlog.
> IOW, after LFA, there will be LFA log is genreated and then for the
> time of re-attestation, it should deliver the LFA logs together.

The detached event log is even more reason the token should not ever
be changed by a LFA.

> > I saw in your FIRME series a solution to this problem, I think that
> > would be good to get out on its own and apply it first to RSI as
> > well. We will have the core RSI stuff, the realm attestation and TSM
> > driver at a minimum..
> 
> Hm,, Does this mean do we need to create two device one for TSM and
> one for attestation even the functionality same?

They won't have the same functionality. It will be the same as you had
with FIRME where there is a driver doing CPU attestation and another
one (the TSM driver actually) doing link IDE.

Jason
