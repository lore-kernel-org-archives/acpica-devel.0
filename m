Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA413A9014
	for <acpica-devel@lists.linux.dev>; Thu,  5 Feb 2026 13:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770297016; cv=none; b=nZ57MKXZv22q9WZRdoUEmBgnpF81u73ruInxddDb/SPh1LjjifJfO1ZbOgwQmCnV+CUvQF2LjYWKJnmxS7yRt0Wf0gcGCJT8JkGasT5T8MNJVdeD999tnqbXb0PJRtHENnHkmXogTrB4prLcOTn1CnUu3JTKzD/VSAsrfaUHnFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770297016; c=relaxed/simple;
	bh=g06hxuxEUhC4yKf7OWaLtDoSkFebbaVKoScO/qtaIEo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=h++8UFdLNcMggE5bL6dF/pI2EoTW4SGK+CMWllUOqTgyFMbMhREP5ayh+bbooprffo1bcDLTrKsUaDXsLnsRjjhmnJsuOLuln2xJfOKFmeiaonLRWfogXTRRuJiqnVXXnVQ98StsS27gabsucOtOOdjFRc6kGSfdY5iUhPNL4KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e4CcLtHa; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e4CcLtHa"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-48068ed1eccso9817475e9.2
        for <acpica-devel@lists.linux.dev>; Thu, 05 Feb 2026 05:10:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770297015; x=1770901815; darn=lists.linux.dev;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=g06hxuxEUhC4yKf7OWaLtDoSkFebbaVKoScO/qtaIEo=;
        b=e4CcLtHakUwkk9Omr3i7kN8rw8YgZ4T32ZmDCxNpnYBgK0xdvDOba3oNqXrtOjXeD2
         pb1uinTtYTPG1xYe26Fg0qNPPbDMx3vXxozbKXc91MmWLyMrKdJjAcabtSOx4HjPMF5B
         jXaD/AQLnVR/7SwU2vJHcnAxSv+y+/JAbUWSExkapJgXM8vdA2mk279xM6rOdC/ctk4J
         JSS0x0GK+06IYsyFzees1XQJMNgKvFzunC/XaofRJiltNYXzSoCCSTmIJkClw/HXv1xo
         apAFGoGxNgMfii30GqBJIIP+pRS8BS/Pft2HtBhIcaqzHFQSjc7ZDa1aZl5RwI1UzBtP
         I1FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770297015; x=1770901815;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g06hxuxEUhC4yKf7OWaLtDoSkFebbaVKoScO/qtaIEo=;
        b=rLLXXYfagY+FygFkfoTDsTFjVARbOO+S7pTU4Paw0D6t2A/pUspHwAk5bNDHoxF7V+
         FtpRLUhmNikL3FjSQHcQOtSAN9Hgm0kPD6WvhzRVzzw2pvuYI5Pam492Eq3snacYFKTs
         SyyMeypELDOMlaQWEcvabecRYG0VQb/zNT1lRSt4kl8B8Noa9a9oGuLncf2hi237qS0P
         /rV3uChRXuouvWhUSyccoUlatEvb8gG0tmWPdC/t/m/tTO7BzS/V42atAGeu9oh2aNWX
         8A0uGCY/YYXN5E9OBP/A8HOjKDiZl1WYPKGGWD1zlqP4eDen7mpcL/Sb4x3IjouHbhAY
         69RQ==
X-Forwarded-Encrypted: i=1; AJvYcCUE9UQKqmHD6Bfvkj9Daj+Ml/ZC/OvDdzDA+nazA0NjoVMZkT2NL6/7lS/IFdYX5YxzSWvJQ5uaOmMTcIM=@lists.linux.dev
X-Gm-Message-State: AOJu0YwlQYSHdbWwhU+qwuW4FyQNBtCzqtC8NrG+JQ4l3Fa+ELZkIzPi
	rJzeFYX5oIzieHauggCvYR2o0CXCihEH/eqEkO7H+TH0rc8Su8R5F9DO
X-Gm-Gg: AZuq6aJOqYDKUrxxkoEfQA+agNoRmWoabcogou9IMO7g78ujWlb2rooTm71xXS2JCbN
	dS8lnmjV1W4SyDsHY3vUGPG2PMyrxnYeCFlen7FIhLuv1U/n2zeLJcpP3F4U6IWtUx1LxiivkZZ
	X0xyR43NDnhHZy9KtH1uzHXaUT7LXm554aHhW+j6lfI5ViX3XTsbTCKe7WepnC5NkFFtXV7vwBU
	eBH4wWGNaTLq3jbTMH1ThBgs5dHySpKgOTapZOwoqNiS1WChlW7hq51vmAs5uTYyu6PArSdg9Bk
	+JwB/9t8Vfa5bsv4h9StxA87QMwbiw5Tw9Gi15vndi21PQsoFvNXIkZYsso8j5vkjNdGOS4lYOG
	ZmegBF4dbRUN1ArtEni5r4wIFji4NY2YnSki7hveKXTQYSMov5/B46IbsDXddav+Nb8XMJ9oH0Z
	mOp3cxCZXp44FeeI8=
X-Received: by 2002:a05:600c:3549:b0:475:da1a:5418 with SMTP id 5b1f17b1804b1-4830e9351f5mr99191295e9.1.1770297014494;
        Thu, 05 Feb 2026 05:10:14 -0800 (PST)
Received: from [10.245.244.111] ([192.198.151.45])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4830ffc9f3asm46238925e9.19.2026.02.05.05.10.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 05:10:13 -0800 (PST)
Message-ID: <acebbfddad686122c4aee9d1a87b048379dffbab.camel@gmail.com>
Subject: Re: [PATCH v7 4/7] ACPI: CPPC: add APIs and sysfs interface for
 min/max_perf
From: Artem Bityutskiy <dedekind1@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Sumit Gupta <sumitg@nvidia.com>
Cc: viresh.kumar@linaro.org, pierre.gondois@arm.com,
 zhenglifeng1@huawei.com, 	ionela.voinescu@arm.com, lenb@kernel.org,
 robert.moore@intel.com, corbet@lwn.net, 	rdunlap@infradead.org,
 ray.huang@amd.com, gautham.shenoy@amd.com, 	mario.limonciello@amd.com,
 perry.yuan@amd.com, zhanjie9@hisilicon.com, 	linux-pm@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-doc@vger.kernel.org, 
	acpica-devel@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-tegra@vger.kernel.org, treding@nvidia.com, jonathanh@nvidia.com, 
	vsethi@nvidia.com, ksitaraman@nvidia.com, sanjayc@nvidia.com,
 nhartman@nvidia.com, 	bbasu@nvidia.com
Date: Thu, 05 Feb 2026 15:10:09 +0200
In-Reply-To: <CAJZ5v0gBHrGf4TpjqV+W5YynM+9_xWpepgrOiRegSYS9CvPV1g@mail.gmail.com>
References: <20260129104817.3752340-1-sumitg@nvidia.com>
	 <20260129104817.3752340-5-sumitg@nvidia.com>
	 <CAJZ5v0gBHrGf4TpjqV+W5YynM+9_xWpepgrOiRegSYS9CvPV1g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

On Tue, 2026-02-03 at 13:43 +0100, Rafael J. Wysocki wrote:
> On Thu, Jan 29, 2026 at 11:49=E2=80=AFAM Sumit Gupta <sumitg@nvidia.com> =
wrote:
> >=20
> > Add cppc_get/set_min_perf() and cppc_get/set_max_perf() APIs to read an=
d
> > write the MIN_PERF and MAX_PERF registers.
> >=20
> > Also add sysfs interfaces (min_perf, max_perf) in cppc_cpufreq driver
> > to expose these controls to userspace. The sysfs values are in frequenc=
y
> > (kHz) for consistency with other cpufreq sysfs files.
>=20
> But this is not cpufreq and it is not consistent.

Just my 2 cents to add:

CPPC and Intel CPUs don't use kHz for performance scaling. We should
avoid introducing additional kHz-based interfaces where possible, since
the performance units <-> kHz translation may become more complex over
time than today. Future implementations could involve non-linear
relationships and reduced accuracy. Minimizing kHz interfaces now may
help reduce future work.

Thanks,
Artem.
