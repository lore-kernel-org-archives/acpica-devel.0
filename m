Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795804552;
	b=bgZhMi3gEUqU0kavtGrUnVRc01Ro7+QfDVDvwlmBrefxAYTTinSUaQ1vEgt1U4Rx83XW
	 M/8syJNnXLOXSgncrURv6xQSJl080pnoiaV5OaGYonEchF4MefkPgeorgZ1haWo5h9ajw
	 oAwVGZjcTRskhJyDrsOtZg2SG6Xjdh/GveN/QE9a1yTdIWZt4akj6iVVwlR+Qq/IOcfqa
	 Sn00kTtioBsyWMKzD3e7hfSeRZ2Mba/LQscc79Z75qfeaUgfGkVaZSqb+jncZtiynHpGA
	 ZaZ5/yS8f3uaLpMrPGrS+2Fw6Iuel2Q/1m2VgH/0ETDwQgyoXLN8sfYfN1mvZlz218Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795804552;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=tF50Nzkiz8TetU3KuqsmLR2UYlH9w5XpGjZivIOBBHo=;
	b=HfxT9HeVnweqDJHoTMXCiNjmLHj2D0oir+I5Vmjk+a/NOxY9ZSQEPIX+ZUSFBu+US3PC
	 WPyzgoP2F2RZQ91q4q/bHgroTTgVvBRfgvh0K4xrxyJXYOvEL4EDSbMRt9gY5hQZLwbKL
	 t/md/TNuuSkRMHcxw0Jog/B+Qy9t5c01SAA301nTlurjJn5GgL8ypFaQ/Fk5B7NTUEMWD
	 K7K9O2+4SECgTqjggGxdAe1ZhX1ZaXaWLteRpbw98o37aTo/vtAYMTPNMIfhfqFfUYYMn
	 5nbpXWQe0yuaRmue00HTFREtSASGFIlbf7maNT5CVma4tiDioGuW27anjF2gIQVFZlw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=hwapNDCS;
	arc=none smtp.remote-ip=209.85.160.170
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6FA606A321
	for <acpica-devel@lists.linux.dev>; Fri, 27 Nov 2026 18:35:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5A6FA606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=hwapNDCS
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-55c48582654so91997341cf.0
        for <acpica-devel@lists.linux.dev>; Fri, 27 Nov 2026 10:35:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1795804551; x=1796409351; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tF50Nzkiz8TetU3KuqsmLR2UYlH9w5XpGjZivIOBBHo=;
        b=hwapNDCSargd4nvDBQe65iT0HRVfWiaf9nvSSXRpH3fJPbMydGi0fD0UFrfAyPmjsn
         Gf5NLdbY69SVQzllt1dMEkAUouy0cSWVKeV/KxQi2rnBF1wVmZP2gmyRrMXQBxqdFstl
         alreFBvk2w1V7pKv/AMpjfcys3BxzvX6HlRpRKP+LUAyWExQN5AWi2dVzGJdNm5npFZx
         6bOVJFpR13E6shGc4w+H2cEACKQQqOspaHYwdusKguDBWlChTJcjEWJ7AOcUDSABeaKe
         eVGhLSC/ArzAMS/IdiPyKscfAh8YioHPQxpj4AyoXNTsMpPOmnfzCvoAyJj/weQiJIHh
         IrdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795804551; x=1796409351;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tF50Nzkiz8TetU3KuqsmLR2UYlH9w5XpGjZivIOBBHo=;
        b=Cqi72ZJ5zGoJMt2SmweieL6bAWsUExbeUYe6AT0MUGWzV6uIGLKDILilmwXbG7R2FM
         Q6Bxbr6zISgUysOZOSHhFDjleX270Lb3hExDErO+/LEE1fXZHDlUbJGK1CLT0VesUu/3
         6hYPCfGZbk+u6Ldl0j/bDXR9XTIW07tkA72qCYbJdg40NiXVAvbbdSbELwNEGgIW5cDh
         w3FFzJxm2XfGL+tnWwTn1rvgkm+2KRYB83KdTR09fkYfT7KnTIOq/wV6YrmwlQ1JXsgw
         rLikTNnUIRdS1Y0sI3tT4+iTBnuQKS/mWOA9NeKyvAtBYWwsi5g2CBvU6kUM0MXkUFZC
         +BGg==
X-Forwarded-Encrypted: i=1; AL+hErGd2JKK+WK0FMYofMsd1gtbGEl6zaerv27Go9fD+gvwZPaEv+z4Io28Kfzz4hpmxDr8K50ykwMHabW18SI=@lists.linux.dev
X-Gm-Message-State: APuU4Z9aCCInsOMafiHkdzbwjxZmnfZ3FlXXpmDOLGzaZXZ/Bv/Ba89s
	KHlbOJe5afBEvYPiEc/8hyj6zeDB9jbgvJykX+TBHX/bfo02muoKRya2FhTA7+VJ7/w=
X-Gm-Gg: AZFdTZe2UUEOKGhDW7Kew41RuJOg5XrlzEMM7CzSaNFrBbxwWmJCoFSCZ8xU2CS4uso
	8+6KBokGuozDFeHcYDAZC7Dt2ZLJzmFsq09svZOGVDU5jGB4zofoKo+/O17NOvFwY/ZxpEMmbmj
	xYwzuBNzItBZXB94yiddIu0XqOfOL6v9Ggvrh9KvgN19cfddEHnbxvcxeCLGBNUPquhy4bpt9J6
	E1t61dnHeYl7PGueLZJN0suZOSpCk5UuqpF+6Y7eF96qLB9ig1yJ0w2sZqMT2chObZi7JrXjvXk
	6gqOiUnHYG4l2DG5NN+nQnKcddmjK6EYFrb9FPGupESzq8BPy/STm5CkoYYKqDgKCcjw4NbmMp3
	W0c+yynLmn5OxHZk5aQUBXkHZZxbwekjvtWeVEeT1xL4JW+j1eTAm6G+t9KPZIa0iX+aXJ/M/Xv
	Yx/vwTLe1CQQni96yv5zLhtcNRe3bwXaixUJ6TSvZjiASBOa3sqwenyP2sGK2x9AcysfhshK0a0
	szzpy/hocOBzTp5PUkQFxMW6TJ9gZv07clOICSpKdODChWx5Sgjreq+pkafG1ElgcIyyGFQ5vUg
	Rku5rQ==
X-Received: by 2002:a05:622a:5a0c:b0:54d:812b:ac2 with SMTP id d75a77b69052e-55d76aa5123mr463929871cf.28.1795804551241;
        Fri, 27 Nov 2026 10:35:51 -0800 (PST)
Received: from ziepe.ca ([142.177.118.84])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55dc8895b8bsm36322411cf.10.2026.11.27.10.35.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 10:35:50 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xX0nW-00000007aGg-0jpi;
	Fri, 27 Nov 2026 14:35:50 -0400
Date: Fri, 27 Nov 2026 14:35:50 -0400
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
Message-ID: <20261127183550.GV246011@ziepe.ca>
References: <20261127-arm_cca_mr-v3-0-df3230afce8f@arm.com>
 <20261127-arm_cca_mr-v3-7-df3230afce8f@arm.com>
 <20261127170722.GT246011@ziepe.ca>
 <awnK2c3kMq8p2a_7@e129823.arm.com>
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
In-Reply-To: <awnK2c3kMq8p2a_7@e129823.arm.com>

On Fri, Nov 27, 2026 at 06:24:25PM +0000, Yeoreum Yun wrote:
> > > +static const struct attestation_evidence_format cca_attestation_token_formats[] = {
> > > +	{ .vendor = true, .value = CTLV_ATTESTATION_CCA_GUEST_EVIDENCE_VENDOR_FORMAT_CCA_ATTESTATION_TOKEN },
> > > +};
> > 
> > should be the generic EAT token type
> 
> Is there?

That's the idea. TDX uses EAT as well.

> but the content seems to be different according to vendor, So would
> it be better to keep it as vendor type format?

EAT is intended to be self describing, so if you parse the EAT then
you should understand what the vendor and content is.

Knowing the EAT came from RMM won't even tell you which ARM profile
version it follows, so I'm feeling like maybe we just need to tell
userspace it is an EAT and then userspace can parse it deeply to learn
exactly what it is??

> > What is this and the related work? That isn't making sense to
> > me. If the token size is not absolutely fixed when the driver starts
> > then it should be fully dynamic and this just streams the variable
> > sized token.
> > 
> > Ideally directly into user memory so we don't need to allocate a kvmalloc.
> 
> In case of live-activation. I think in that case CCA-Realm token could be
> different by activating the new RMM.

Then the size isn't static and you need to just stream it to userspace
whatever you have.

I'm expecting these unsized tokens to work by streaming them into a
memfd so that userspace doesn't have to try to guess how much space is
required.

I also think it is pretty broken if LFA is changing the token for
realms that are already running. How is that even going to work with
an RSI API like that gets the length then tries to fetch into the
allocated buffer? Token silently truncates? You need to loop?

> > This isn't OK.. We only get one struct device per RSI and it gets to
> > bind to only one driver. Given there are other drivers that will need
> > to use the RSI, like the TSM and others, this needs some other
> > solution?
> 
> Currently, this attestation driver is enabled when !ARM_CCA_GUEST only
> (IOW, when this driver can be built only when TSM arm-cca-guest
> disabled).

I saw in your FIRME series a solution to this problem, I think that
would be good to get out on its own and apply it first to RSI as
well. We will have the core RSI stuff, the realm attestation and TSM
driver at a minimum..

Jason
