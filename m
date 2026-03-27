Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7085534EEF4
	for <acpica-devel@lists.linux.dev>; Fri, 27 Mar 2026 11:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774610265; cv=none; b=AsO5nM4YFbCAeOffwYs5CwvWAwWanSaKca2yISGA06Fn45isIUf4OCg5hpdzdRmvDNG1jK8D0DpHaBR2S2ojZIamHxJlOyKRnAdymc7NpS+ZhJ97kCOEBV6qyHBKIaahJcxJUVEvqD8H2pXBWN5E6K7Ul3snMuXIxg18bnRbQ5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774610265; c=relaxed/simple;
	bh=5uR5C4kSTeoXCPZLUNxgRU/+LYofizIx/Fn/xYRnPHg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j3r7jzDU87HYOzjsGQC+8G/HqqhqW0ZHHHOJZm4GolZMofSGo01ky1ZWzlIKhrfElSC1cE8xYPDfhk79zidJGTQ1obUvm2t4eMMosI7l7Yh1YBvwqlIAHDsA6s/INzJsDmDHdvCDMHlu7TAJ/upWgMFDtLAy+xov7rrcY+74pxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OsT8SEtw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OsT8SEtw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03D3EC2BCB3
	for <acpica-devel@lists.linux.dev>; Fri, 27 Mar 2026 11:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774610265;
	bh=5uR5C4kSTeoXCPZLUNxgRU/+LYofizIx/Fn/xYRnPHg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=OsT8SEtwadPhnwZTE1ggXVbQiZxizqURk0EGCRKSHCflGLbn9SrSjoNoLCo17M6eN
	 QqaJxV5dm7eNaZ/UMK7FUtHsJTLa8rcXwIAAHCZWYaiC5JhNgAKwOSmm4bGHINgNyF
	 TpE8sun9bkJGAMMBZAMUqILHCixu7rxbBNeiEIwmgeUmpwgrAZQZDyTuqvxKsojLJ7
	 7SZc4rQUYuGYAJGNM1ForxwWMtsx+JpgaS1ov3eFZC9+L65VjVlOqJlimc0XrqSSqs
	 10LU1fhrEsubR6eQKnF6SROCP3uvKecf3Rb/8OL0UdUjqIgk9nOiOZumLGjPF6zIHq
	 XRugmYf4WQDLw==
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7d9b1c57a4cso1600994a34.3
        for <acpica-devel@lists.linux.dev>; Fri, 27 Mar 2026 04:17:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX54gHVNPvfbpe8PF2iVnYwWSmqyMw+VXODq9ZHuQt9QJMwK3t2wKCaKIFFPAOc0NuUFQLM6KwnlgDQgqQ=@lists.linux.dev
X-Gm-Message-State: AOJu0YydRW/BbXd1DFkG90gnnTFcliGNqSZ0dJxDyViovNdefmxUdCL8
	6M8YaTfZqrOIHb+R+AY4e2FBjKIpcJFx/QM/wMpXh+WCIF9JRJ5xko7vItjXFlyLgGsUYNkv8Mj
	e/2srHjjyHJGCnau0rh+y7+W5HK6KYro=
X-Received: by 2002:a05:6820:8407:b0:67d:ebc4:1925 with SMTP id
 006d021491bc7-67e186ec870mr708977eaf.43.1774610263992; Fri, 27 Mar 2026
 04:17:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260326201830.3938-1-david.laight.linux@gmail.com>
 <acZNuoRmQ5BrfPPd@ashevche-desk.local> <20260327094508.1801bdf3@pumpkin>
 <CAJZ5v0inLkQrjBdvgXe8XmE53gWSfDcFHZFM4iEj=a1Wmz6xwg@mail.gmail.com> <20260327105851.5e124db8@pumpkin>
In-Reply-To: <20260327105851.5e124db8@pumpkin>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 27 Mar 2026 12:17:33 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gywDJaaATp8q9=zJAWEbZDp25U9SDRCzr9_pfXLFv=Jw@mail.gmail.com>
X-Gm-Features: AQROBzBq-QxOllv8ldhPMPaA3WeetHoMfq9Bn-hvPHItOgIZFm4LZxwH8QzCjKU
Message-ID: <CAJZ5v0gywDJaaATp8q9=zJAWEbZDp25U9SDRCzr9_pfXLFv=Jw@mail.gmail.com>
Subject: Re: [PATCH next] ACPICA: AML Parser: Remove spurious precision from
 format used to dump parse trees
To: David Laight <david.laight.linux@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Robert Moore <robert.moore@intel.com>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, 
	acpica-devel@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Masami Hiramatsu <mhiramat@kernel.org>, Petr Mladek <pmladek@suse.com>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Steven Rostedt <rostedt@goodmis.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 27, 2026 at 11:58=E2=80=AFAM David Laight
<david.laight.linux@gmail.com> wrote:
>
> On Fri, 27 Mar 2026 10:58:14 +0100
> "Rafael J. Wysocki" <rafael@kernel.org> wrote:
>
> > On Fri, Mar 27, 2026 at 10:45=E2=80=AFAM David Laight
> > <david.laight.linux@gmail.com> wrote:
> > >
> > > On Fri, 27 Mar 2026 11:28:26 +0200
> > > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > >
> > > > On Thu, Mar 26, 2026 at 08:18:30PM +0000, david.laight.linux@gmail.=
com wrote:
> > > >
> > > > > The debug code in acpi_ps_delete_parse_tree() uses ("%*.s", level=
 * 4, " ")
> > > > > to indent traces.
> > > > > POSIX requires the empty precision be treated as zero, but the ke=
rnel treats
> > > > > is as 'no precision specified'.
> > > > > Change to ("%*s", level * 4, "") since there is additional whites=
pace and no
> > > > > reason to indent by one space when level is zero.
> > > >
> > > > This is cross-platform code. Does the same applies to MS VC compile=
r, for
> > > > example?
> > > >
> > >
> > > Everything except the linux kernel will treat "%*.s" as "%*.0s".
> > >
> > > Regardless of anything else specifying a 'precision' when printing
> > > a constant string is entirely pointless - it limits the number of
> > > characters copied from the string.
> > >
> > > Basically "%*.s" is always a typo, either for "%.*s" or "%*s".
> >
> > So this change should be made in upstream ACPICA in the first place as
> > per Documentation/driver-api/acpi/linuxized-acpica.rst.
> >
> > Would you please send a PR to the upstream ACPICA project on GH?
>
> I'd have to go through a lot of hoops to do that.
> I've never used GH.

OK, we'll go for the second option then.

> > Alternatively, someone else may make that change upstream with a
> > Suggested-by tag pointing to you.
