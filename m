Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23AF4181322
	for <acpica-devel@lists.linuxfoundation.org>; Wed, 10 Apr 2024 19:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712776103; cv=none; b=M7bxBQI64EIDABZncF3FxwiZOBy/LugBr71cGxv4+78QYrlNzJjK+snov6feojvL7ppYR1P+cwpx1SYO0hBokJiKBM11C4qMPFrVhbMMfatXvXn+BcOuUVOHnkyh+I3NL/Xf6dyLLeusk0sImUJVhaomXDndcDhlZEPbi9DcbEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712776103; c=relaxed/simple;
	bh=+eWLmlEP0bVT8/CZ2rvIUuWI74CBRr7mdsinkobDlzU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Amh7vP+HHF35JUeyQFjjr8nmaE1iJHiH6xVMbNvhq7jhM/AEH1s+dnklsklbamYsVzV+Ujos/7iExY8dA2EW8sKo4ZYa5I/uhP2hPpyidalSdW49CoOMRHA0LpU5fZswTLxLlxBGWbpAAydksg3nJAdGLvYmZw2hEpUf02I5/Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kBer6g/F; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kBer6g/F"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A082C813D0
	for <acpica-devel@lists.linuxfoundation.org>; Wed, 10 Apr 2024 19:08:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -7.101
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4XPSszIIcgXn for <acpica-devel@lists.linuxfoundation.org>;
 Wed, 10 Apr 2024 19:08:21 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=rafael@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org E84DD80E9E
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none) header.from=kernel.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E84DD80E9E
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=kBer6g/F
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	by smtp1.osuosl.org (Postfix) with ESMTPS id E84DD80E9E
	for <acpica-devel@lists.linuxfoundation.org>; Wed, 10 Apr 2024 19:08:20 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id A830861671
	for <acpica-devel@lists.linuxfoundation.org>; Wed, 10 Apr 2024 19:08:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46150C43390
	for <acpica-devel@lists.linuxfoundation.org>; Wed, 10 Apr 2024 19:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712776099;
	bh=+eWLmlEP0bVT8/CZ2rvIUuWI74CBRr7mdsinkobDlzU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=kBer6g/FSVcQNlQN/dT52LUBGg0hkyFCcgbXq3fUnv4hC2VilA1zuyGqPVGaoI9rz
	 0/MBcRSiQDjk5VbvTar8s1MII5Y0adKzNxjkxeYxriw3mc+K55GlJawuRxte3IPF3T
	 0yjLhDefgapwQ1FYh/ibQke8EUvsYSFf2Bt7tSkMULO3L6dgzwxMmS2ZrG0XpBh0qj
	 TZ6p5zrmOCPyTsntakq4I6xUnUrHcUgIY7EjynOD9Edj3qR4Uj1GT2QnyWxaffty1+
	 T4vEkU9e25UakyTkLUOKd2E5zgMj5xwEQfwgEcWbJ/DWijYATCohmlmkXXuvdqLrVa
	 rpMLs6ScIMD8Q==
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-22ed9094168so486561fac.1
        for <acpica-devel@lists.linuxfoundation.org>; Wed, 10 Apr 2024 12:08:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXPzAJl1bYpKwtlBDPu0eFFV5iAJL7yA+KWFCIW1Fy7h0Lq79olROzEckNSOSel7SJ1oNMqMSE3zW1S6QcFF2Hozm0wjaa6tvjhiLU5IWNh7/eCyoxoFw==
X-Gm-Message-State: AOJu0YwiZnloE7uS1Huv1Hv9fZU3ggH18nD0q7kkYEYO08nE5T24l2TY
	RlQ4xM4HU2Ca6+cqK7hEMR9IgvTek0JcPw53iq0fBG+K/6nbpRh1PrR3hecGNMSmSwx5VRUS6bC
	66x/BY+kcvJNCxu4nQBrcCCvJKMM=
X-Google-Smtp-Source: AGHT+IH4A92J5HCRnizSgBq3+DCMERDHMutgLTgDu/kxW+WK07c2IT8FOUNC46ZvoIhnKLsY7Mrt28XT6qdFy5OJWR8=
X-Received: by 2002:a05:6870:219d:b0:22e:b2ea:5758 with SMTP id
 l29-20020a056870219d00b0022eb2ea5758mr3756127oae.0.1712776098584; Wed, 10 Apr
 2024 12:08:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <Zbp5xzmFhKDAgHws@shell.armlinux.org.uk> <E1rVDmU-0027YP-Jz@rmk-PC.armlinux.org.uk>
 <CAJZ5v0iiJpUWq5GMSnKFWQTzn_bdwoQz9m=hDaXNg4Lj_ePF4g@mail.gmail.com>
 <20240322185327.00002416@Huawei.com> <20240410134318.0000193c@huawei.com>
 <CAJZ5v0ggD042sfz3jDXQVDUxQZu_AWaF2ox-Me8CvFeRB8nczw@mail.gmail.com>
 <20240410145005.00003050@Huawei.com> <ZhbgwBBvh6ccdO7x@shell.armlinux.org.uk>
In-Reply-To: <ZhbgwBBvh6ccdO7x@shell.armlinux.org.uk>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 10 Apr 2024 21:08:06 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gG0xLajHsWXVM+-V+fQZAudvojechUa-DzFgwCs2q8Dg@mail.gmail.com>
Message-ID: <CAJZ5v0gG0xLajHsWXVM+-V+fQZAudvojechUa-DzFgwCs2q8Dg@mail.gmail.com>
Subject: Re: [PATCH RFC v4 02/15] ACPI: processor: Register all CPUs from acpi_processor_get_info()
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	linux-pm@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-riscv@lists.infradead.org, kvmarm@lists.linux.dev, x86@kernel.org, 
	acpica-devel@lists.linuxfoundation.org, linux-csky@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-ia64@vger.kernel.org, 
	linux-parisc@vger.kernel.org, Salil Mehta <salil.mehta@huawei.com>, 
	Jean-Philippe Brucker <jean-philippe@linaro.org>, jianyong.wu@arm.com, justin.he@arm.com, 
	James Morse <james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 10, 2024 at 8:56=E2=80=AFPM Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
>
> On Wed, Apr 10, 2024 at 02:50:05PM +0100, Jonathan Cameron wrote:
> > If we get rid of this catch all, solution would be to move the
> > !acpi_disabled check into the arm64 version of arch_cpu_register()
> > because we would only want the delayed registration path to be
> > used on ACPI cases where the question of CPU availability can't
> > yet be resolved.
>
> Aren't we then needing two arch_register_cpu() implementations?
> I'm assuming that you're suggesting that the !acpi_disabled, then
> do nothing check is moved into arch_register_cpu() - or to put it
> another way, arch_register_cpu() does nothing if ACPI is enabled.
>
> If arch_register_cpu() does nothing if ACPI is enabled, how do
> CPUs get registered (and sysfs files get created to control them)
> on ACPI systems? ACPI wouldn't be able to call arch_register_cpu(),
> so I suspect you'll need an ACPI-specific version of this function.

arch_register_cpu() will do what it does, but it will check (upfront)
if ACPI is enabled and if so, if the ACPI Namespace is available.  In
the case when ACPI is enabled and the ACPI Namespace is not ready, it
will return -EPROBE_DEFER (say).
