Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D46D3B893C
	for <acpica-devel@lists.linux.dev>; Tue, 13 Oct 2026 08:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791880803; cv=none; b=OUhOPDqqD57ZkkTIuGoM07ItvF1t3cLRBRUZwzCfUxFZAdnuWdzIC4LesPRvLjkDFrMrT5LMOLUDti2jC4xUNVRR47dF2P5ReRSXSeW1D5oNA/U93KcKmu4f4IH5zpBgroIFNBxuyocg4z7XFIssIHGSYMT9UmOItjedo1ytFlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791880803; c=relaxed/simple;
	bh=zYodpRJl2sTx4KeDMYM4tddxsAs05qKU0E+V6KZSlRU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B9W6+Onkt6OSrgvdaRgt7aRjJ6AjuXDsl+b7L1kvIpWpWr4Qfy/hHOYpGKB2iUCbtR8nSAfeP+jw9r3mQQ19wlHAqbAIujpNTTKUmzwkzVFAjbfYKO1pdtfgq8wd0/YLPQMUPi15RG2ttsV1SujTYMjv1x+NUCkmM5oLsDliVWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BdZedCPe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BdZedCPe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36C331F0089B
	for <acpica-devel@lists.linux.dev>; Tue, 13 Oct 2026 08:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791880802;
	bh=zYodpRJl2sTx4KeDMYM4tddxsAs05qKU0E+V6KZSlRU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=BdZedCPeO9CwxRpDFBDz0VYWDfdqBszx8mATvuUddMSxUC8P5SrgsNWNfs/NL/Q/O
	 4IdihQ+BPI1U9ApanBGuC58E8E0GpuWfGTlRXVhINRKt3vam9f9hf1JGy1sdRCYwtU
	 3uu3d0w0vLAk46rlX9NjZJNgsSWhzinzit3+wi0Fzud2N7iwCTeur3ew6NZ4uqoepZ
	 WxfSiqvYkPWfBmoBzyxfnM11tf931JjZzrN0nlRO6XP81RubAIujY+MVgWU80bLpE5
	 Lmm3yKl+feMBzVeBScHr+bKjF2fPWYZuft1o4z5ErZ/xvpWNYXl1RHD5OMwcyNKDDs
	 Zck+arstH/VHA==
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6b167ffd132so4024302a12.1
        for <acpica-devel@lists.linux.dev>; Tue, 13 Oct 2026 01:40:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxkrH6t+MAYZrpBPJegaIZC8BcHBetUSeCXVgL2JPEHHxSf8v9qvkS70c4yx4UZMhOUmcG+e+Q9HHvDxQY=@lists.linux.dev
X-Gm-Message-State: AFq9FYI7KzFmo3iyMf7JPybGewhOMXsOiJnj0G5Dar/ufBflgtnTBddw
	xTZHMtATK0IWgeOPtAdbvaeLhmNL2m18FrMs0tdOiWRo1QSA+SJ5D4X3Q5D57SOGjXw9vrIbJ05
	hddNl24rGGmbD2gen6V+xB8xpLvehjY8=
X-Received: by 2002:a05:6402:21cb:b0:6b1:c355:c7b3 with SMTP id
 4fb4d7f45d1cf-6b1c355cdf1mr3702607a12.25.1791880800689; Tue, 13 Oct 2026
 01:40:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260922121058.972734-2-maobibo@loongson.cn> <10bd45f8-2d37-42f0-b7d2-a4a84933c9b3@loongson.cn>
 <CAAhV-H40TW01vpaNSDgm86DVM4Mwf0sUvnAt2KEwUB=pPFhhqw@mail.gmail.com> <CAJZ5v0gpFDaS8sLdDBbS4tU-F7fKPKOkXtb7nqjfNhagEB_Cgw@mail.gmail.com>
In-Reply-To: <CAJZ5v0gpFDaS8sLdDBbS4tU-F7fKPKOkXtb7nqjfNhagEB_Cgw@mail.gmail.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Tue, 13 Oct 2026 16:39:49 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4hdq_2rGAw9LtCcxLUnQuKBgYTJeMXkAfjCuM+yck9HQ@mail.gmail.com>
X-Gm-Features: AclHuK9oQiH82PB9ry9ALpvacw_4qobdW-etWeXxZBWjotSguWim_HyWbwXpPU8
Message-ID: <CAAhV-H4hdq_2rGAw9LtCcxLUnQuKBgYTJeMXkAfjCuM+yck9HQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] ACPICA: actbl2.h: Add bit constants of the Flags
 field in the IOVT IOMMU structure
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: Bibo Mao <maobibo@loongson.cn>, linux-acpi@vger.kernel.org, 
	acpica-devel@lists.linux.dev, lenb@kernel.org, linux-kernel@vger.kernel.org, 
	lixianglai@loongson.cn, loongarch@lists.linux.dev, 
	maciej.wieczor-retman@intel.com, pawel.chmielewski@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 12, 2026 at 10:49=E2=80=AFPM Rafael J. Wysocki (Intel)
<rafael@kernel.org> wrote:
>
> On Mon, Oct 12, 2026 at 9:21=E2=80=AFAM Huacai Chen <chenhuacai@kernel.or=
g> wrote:
> >
> > On Mon, Oct 12, 2026 at 3:16=E2=80=AFPM Bibo Mao <maobibo@loongson.cn> =
wrote:
> > >
> > > This change is already merged in acpica tree.
> > >
> > > slightly ping.
> > I will merge the last three patches once the acpica changes are synced
> > to git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git.
>
> I've applied the $subject patch as 7.4 material.
>
> When it propagates to linux-next, I can expose it on an immutable
> branch if that helps, in which case please let me know.
If that commit is contained by the tag such as 'acpi-7.4-rc1', then it
is enough for me. The loongarch pull request is usually after the acpi
pull request.

Huacai

>
> Thanks!
