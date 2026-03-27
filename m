Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1BA03E3DA9
	for <acpica-devel@lists.linux.dev>; Fri, 27 Mar 2026 10:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774609140; cv=none; b=NAqJB8wGiLtXtumGZxoSiFWOj1YwTqWCrIABKYtdRenmWrxxvrB4x+ORJT7xmoqz2/sgc+0Dew9k7NCaJ5GPG/lBilQW9jIj7O7DN9yXfTG3JmfKrzqOhjnS5MLh0zP2viRxRdLoMdZsH5TNYy4ZOjnXptxxmtUxzgwnAaL5/pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774609140; c=relaxed/simple;
	bh=9S4NhEG8RujM2YnZlDBff7wpoBOOAI4mTDhINuqmJcU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a0TC8in/jBIDXFOsjazmJx6UolvCfUkl2Ncwx7c3P+cwXO3pP2qYdszNec71lMn5F6D2sWn6xL9fOCnqFqO58pQFJBxv7r/8n1qjn5Y7wuhhnIop1FTbVPWUp1vSZmyeV5SvP68VGR+caw000x47zCYkVZ4WU4NZVuygnxSJwqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L5W9CQLp; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L5W9CQLp"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-43b949bf4easo1153160f8f.0
        for <acpica-devel@lists.linux.dev>; Fri, 27 Mar 2026 03:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774609133; x=1775213933; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vynPpevJ7/+7bmxgSv8Zl+8u89rQ+Nu0RRVPSUGsJ3g=;
        b=L5W9CQLp2IDfqXyTkFWzC4uE09V1s8jg5FwLcKYGiyMQTCTvTx89/6/8/l7Klk9VwJ
         90gCdhSJGYRoa3ctzV0ulx6O/7Ebv3mE3yIF2eaiZ25tSR/GIFkz5puc5LYcbpp8G34r
         XPuTDzSxvtaqbP2cJfUHWsyjsffe3W7nYk0DotsMQiKV5dpFUPsuIxIq51BSmKPOLNPa
         xXLtvuXjhp74ayahXXQtHZKFTuOj9eWHj6YZTCFmrXg/TuuraxTu8Nm2Zz0yavU7U8cq
         sv+DogHNfWysdpeNO91sz2wNYz5kyFKnP/Uz15ZjG8AJvkxG2KElSTCc0gwUxQ9T4DUM
         JbKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774609133; x=1775213933;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vynPpevJ7/+7bmxgSv8Zl+8u89rQ+Nu0RRVPSUGsJ3g=;
        b=gCo9NyompdY+lO2t9YUngP/F0Yl3B5JGbDN0kiVU7rTiFGB5xl/+Oy9eSyC9ssG52G
         7eCG2evsLiLDkVstE1Gm1fy7C3J9tjbqdpnty9jtI/NTjsb2dzcNBwYQUNuxOPT4x4qi
         TL4L2mkZwSkTJaDU4hKH0ap9CbiYtuV3ft92S8urDvNYJBnuZYfVeiUaFDqJtnVsp1NJ
         BRHVlPImiDs0YoOeiOdVVWukvNoLtiCqPb8c5Su7Kv7hagRyKjo3JG53s+pp1LCKyjgf
         Cd+j5ctb2RNTL++w+q3IoZ8wjtW0BOSoejHTIVSLI93q4i7gRQcXFVKDrAcWip0LYL2S
         a/Tw==
X-Forwarded-Encrypted: i=1; AJvYcCXSfKpslhZLsypNExN3UYVdCrLz2zA8Ksh5sEjZdU02u+xoBw5/t+OiYQ4ffXkrG+wtjJ3P2Vkb5Sc53Wc=@lists.linux.dev
X-Gm-Message-State: AOJu0YzqyHJqaGbfEnzSmUftD2BmUsYg3PNDAhp7Oz8lEkn9rPRFc1tD
	Vm02jLu34oHsRw5A7ZB+9jRgYSRpkWpNbvUpi8U/xoF4IE7F2BzF4dSx
X-Gm-Gg: ATEYQzyq7XugyiyXUpEdRKDh4RZwdZpLk7lpCGvTOnDCZE0r6STkIGjweziCOolKsF8
	LinQcwtcEYGWFmNxLxCq9cX9+j8Tx2vgDgDHIQe+8R0CxZGzNjZ4/i1SPjoRCdE0CDXs/WHUZj/
	Hgt80taKhi9qUQuPZss51uxy7swyMltjws7CJs22VmuRUi5OclvWPRACAq/EvEnBDb9PX0feZK2
	d8Q2hW+DVnfxdeZOpcZ19XWFZSbeiQphGbovQ9ciBk7ml0PdD+WgdrVhQH13kT7Eh9KoBLUNBKl
	Os5vZn1xMkykhWHazIrCGk06VwPOQhs9NZ1EE+sURZpOCyoYvyb2z6eZ2O5foBZsDEh1mD/N8VE
	tam6AHRk45mJWgdVKyNsofWzO1ty5ayOEpr9DOjQ9srDLbtVmcXCQIel6Rm0zVAMRVw/nkWMR2X
	evffTK7vrR6Z41rXlaj5+aQkIWn+QDapW256oczM/a1DPIQMBNsDlB4UvjFPBp824I
X-Received: by 2002:a05:6000:653:b0:43b:a16b:ee69 with SMTP id ffacd0b85a97d-43ba16befacmr1536640f8f.24.1774609133106;
        Fri, 27 Mar 2026 03:58:53 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b9192e3e8sm16605099f8f.5.2026.03.27.03.58.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 03:58:52 -0700 (PDT)
Date: Fri, 27 Mar 2026 10:58:51 +0000
From: David Laight <david.laight.linux@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Robert Moore
 <robert.moore@intel.com>, Len Brown <lenb@kernel.org>,
 linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev,
 linux-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, Petr
 Mladek <pmladek@suse.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Steven Rostedt <rostedt@goodmis.org>, Sergey Senozhatsky
 <senozhatsky@chromium.org>, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH next] ACPICA: AML Parser: Remove spurious precision from
 format used to dump parse trees
Message-ID: <20260327105851.5e124db8@pumpkin>
In-Reply-To: <CAJZ5v0inLkQrjBdvgXe8XmE53gWSfDcFHZFM4iEj=a1Wmz6xwg@mail.gmail.com>
References: <20260326201830.3938-1-david.laight.linux@gmail.com>
	<acZNuoRmQ5BrfPPd@ashevche-desk.local>
	<20260327094508.1801bdf3@pumpkin>
	<CAJZ5v0inLkQrjBdvgXe8XmE53gWSfDcFHZFM4iEj=a1Wmz6xwg@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 27 Mar 2026 10:58:14 +0100
"Rafael J. Wysocki" <rafael@kernel.org> wrote:

> On Fri, Mar 27, 2026 at 10:45=E2=80=AFAM David Laight
> <david.laight.linux@gmail.com> wrote:
> >
> > On Fri, 27 Mar 2026 11:28:26 +0200
> > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > =20
> > > On Thu, Mar 26, 2026 at 08:18:30PM +0000, david.laight.linux@gmail.co=
m wrote:
> > > =20
> > > > The debug code in acpi_ps_delete_parse_tree() uses ("%*.s", level *=
 4, " ")
> > > > to indent traces.
> > > > POSIX requires the empty precision be treated as zero, but the kern=
el treats
> > > > is as 'no precision specified'.
> > > > Change to ("%*s", level * 4, "") since there is additional whitespa=
ce and no
> > > > reason to indent by one space when level is zero. =20
> > >
> > > This is cross-platform code. Does the same applies to MS VC compiler,=
 for
> > > example?
> > > =20
> >
> > Everything except the linux kernel will treat "%*.s" as "%*.0s".
> >
> > Regardless of anything else specifying a 'precision' when printing
> > a constant string is entirely pointless - it limits the number of
> > characters copied from the string.
> >
> > Basically "%*.s" is always a typo, either for "%.*s" or "%*s". =20
>=20
> So this change should be made in upstream ACPICA in the first place as
> per Documentation/driver-api/acpi/linuxized-acpica.rst.
>=20
> Would you please send a PR to the upstream ACPICA project on GH?

I'd have to go through a lot of hoops to do that.
I've never used GH.

	David

> Alternatively, someone else may make that change upstream with a
> Suggested-by tag pointing to you.

