Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101FF1F3BB5
	for <acpica-devel@lists.linux.dev>; Thu, 26 Jun 2025 19:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750964401; cv=none; b=p/zwkvRl4ofkzhDUuM2m7Uhi1eTTvIcQvIFdltxLXjBuyRxvVFdE3Li49IhQ0evnWNt6FuTEE5gMBYIsFW7dJ2pLtbwE7XlsZ1o7cIMMcZNafOxampxzG5t+H2LxE6DjArRJukx9fwM90Q7cb+hSXGgDi49sDXk3ptrJlnWjLYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750964401; c=relaxed/simple;
	bh=z8kEw7JJb2bp/MQgg2V6g++d3118nygEV9UNrHq9jUs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C0lp4jjtRSgsBK8uqqjbe1O3jbWnu2L7OT4PscOdFQTZHYcnS93F30V5ALwyLf2UFZesAHATGgg7R0uiBCvYwxIopLgK/GZfMkbrz2GQYjQDFn7VnftK+tZTO3OfaKKPtXc735z+VWvRxOgkFyA1g+bungmJxd/Cbf4Oey0ULOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BGpaWCXH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BGpaWCXH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5083C4CEF2
	for <acpica-devel@lists.linux.dev>; Thu, 26 Jun 2025 19:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750964400;
	bh=z8kEw7JJb2bp/MQgg2V6g++d3118nygEV9UNrHq9jUs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=BGpaWCXHuzGrqxch+wszKYgyYZce4/T9l3wP3+DUs6zBx2eQY2rwZrgGEDiecGOsE
	 qFIUho3AeU2KXktZ1CB4gtDXZpGGrIlo55Y4Ph8EFy2cSb5PpbSCZap6Kpn+BINsBW
	 Re/1Ttu8I6KOC/NVDg7Ygy4QTCuxv3vGhOX5fauR9Erra/X2N/SOCKsnXeOeArSgEX
	 3w5Ls4otSk8QODwJs50rB557WLbnIRBd1JFnZB0qiEbXAQwm3t+j5qP5McozATubwM
	 PDCf8tTymGbvuASg2l46CyEh/fcUzACNc6f6VkExi2sqp2NSSf9RosLgy9aGLB+Ktv
	 G3crkahYGGRRQ==
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-60be827f2b7so1418536eaf.0
        for <acpica-devel@lists.linux.dev>; Thu, 26 Jun 2025 12:00:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUtz7xJAfDPdy7456CGHdz817p6OUNs+wFdI9uqIzcmhH+UbivhuYRruPjWjaXeJiGNoCmXczF2o2goBjU=@lists.linux.dev
X-Gm-Message-State: AOJu0YxwnMGqG3DVyhcNinV/r98AeR9UfDKSB1m77QuHXAKc9lBP90Up
	sM2BGLRJhA92Beh+SLvvDPK2w2kc4JP1/yR0VZThtdBP0/9XlwJtzSizqw5jGIpbWEyq+QMoVcE
	smqqmh8HL7QH208sLoXo6M0vf/3ejX24=
X-Google-Smtp-Source: AGHT+IGRGm9V9G1/XQMXvowWQEj/txuJHawesLvcIIDcCfrtoyRYJniMPZfSR5r25D3cYeyp+04WTBWMD3OtV/C+qxM=
X-Received: by 2002:a05:6820:a09a:b0:603:f521:ff26 with SMTP id
 006d021491bc7-611aaeb14f9mr2576800eaf.1.1750964399625; Thu, 26 Jun 2025
 11:59:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250609032839.525087-1-superm1@kernel.org> <CAJZ5v0iNoT79e9RRraifMY84oR8QAcSeYwk+=vaRSuB9mGmtAA@mail.gmail.com>
 <2825b98d-1bbf-4312-899d-c0eea0854d51@kernel.org>
In-Reply-To: <2825b98d-1bbf-4312-899d-c0eea0854d51@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 26 Jun 2025 20:59:48 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0h-3L0Bh21_Z7QTEeWWgdQfW-8POKv5X+oL5HSLnKgaJA@mail.gmail.com>
X-Gm-Features: Ac12FXwRAH0vcdqhp1PRahTk8eDjUEaz50ONfTkDCH1IszkcO7Bfto-phzTJu7M
Message-ID: <CAJZ5v0h-3L0Bh21_Z7QTEeWWgdQfW-8POKv5X+oL5HSLnKgaJA@mail.gmail.com>
Subject: Re: [PATCH] Decrease `AcpiExTracePoint` verbosity
To: Mario Limonciello <superm1@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, mario.limonciello@amd.com, robert.moore@intel.com, 
	rafael.j.wysocki@intel.com, linux-acpi@vger.kernel.org, 
	acpica-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 9, 2025 at 2:48=E2=80=AFPM Mario Limonciello <superm1@kernel.or=
g> wrote:
>
> On 6/9/2025 4:31 AM, Rafael J. Wysocki wrote:
> > On Mon, Jun 9, 2025 at 5:29=E2=80=AFAM Mario Limonciello <superm1@kerne=
l.org> wrote:
> >>
> >> From: Mario Limonciello <mario.limonciello@amd.com>
> >>
> >> Early in kernel boot pointers can't be used and so %p shows up
> >> incorrectly:
> >>
> >> ```
> >> extrace-0138 ex_trace_point        : Method Begin [0x(____ptrval____):=
\M460] execution.
> >> ```
> >>
> >> Later in the boot %p works, but it's not really actually useful when
> >> the pathname can resolve properly. Adjust the debug print so that if
> >> the Pathname resolves that the pointer isn't also printed:
> >>
> >> ```
> >> extrace-0138 ex_trace_point        : Method Begin [\M460] execution.
> >> ```
> >>
> >> Link: https://github.com/acpica/acpica/pull/1013
> >> Link: https://github.com/acpica/acpica/commit/bdc2a4e646f097b693aa60f1=
f2c4228d1e31b0d1
> >> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> >
> > This is an ACPICA change, so it should be made upstream first unless
> > there is a good enough reason to make it directly in Linux.  In which
> > case that reason should be mentioned in the changelog.
>
> The patches were from ACPICA (I included the links above).

OK, applied as 6.17 material, thanks!
