Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A412E1944A
	for <acpica-devel@lists.linux.dev>; Thu, 23 Nov 2023 08:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V5+Wi02P"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-5cd2f1a198cso4380667b3.0
        for <acpica-devel@lists.linux.dev>; Thu, 23 Nov 2023 00:18:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700727482; x=1701332282; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WvQyz8WUbCXXcHlGWxMEoDuZxvoCOtrHTLLemanVJpw=;
        b=V5+Wi02PKwGn+4OLSDke5h4W/xK1r/XNksGW+aHzSG2Yj+kzFKo6YzGwyv5G6zffY1
         H/6jHvx4RhakRO6Nuk6Qkcsdken+IDQtb2wBOGmSMcfaeGDeXU45/zlGpjoihyehV6Jc
         7KIzdplK60/2EJeRLowBE31TMqh6fpKPJaksZgBVPLCDZm0Lc3KxN4qrvOXudRiZKSyB
         XKDbQjiOq+x4MAGlrnIKqa48e9uZnXmoO2WGDswaTJNK50NRDo/0aSYNniJgjPgb/pPF
         MjGuiwLv3Yk6keiwOn+8bOAzkZQiXaClsz3wNhi3ur+DHf0N94NiGVzP8HXleLlf+fLv
         GY6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700727482; x=1701332282;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WvQyz8WUbCXXcHlGWxMEoDuZxvoCOtrHTLLemanVJpw=;
        b=PrzmPjiCtIgZxbYqG4QztxE1vpyX6fnKPDjLhusZBL0DceLBonP2DsrYDBRtP1aPUa
         +RmQT9UymyXu2jJpeSikuTXQxhyFgiYv931CebQekFEl0J/xA8TuIA3i5dXi/MvEjguR
         EqoqdaXf+3JChxm34bVFbfgLKNaspedJMAf69Y8OFHgqkOg29Y06SfG+t72fezSP/fC0
         3aj+bQen/XyYFrorQKscANlYZnanJzPRgKJddcezGzr/JtCU+TpEMsL8BgwAl4nrir1A
         gktumE789rIe5S07Y7FvykcIv/zjnk6UPGsk5LqJbEO7mJlnFlXMvAFYL4SnbETP8+ey
         Pdvg==
X-Gm-Message-State: AOJu0YwCrZGV2i5bdI5+qWE2pnpFsr0lFfIWLBsslui+Ne8X2rSFRhAm
	CK6Q9MvPjWjX34+ezLecQhmPjPwWd3VcYVhiabEIHw==
X-Google-Smtp-Source: AGHT+IEwql/FgZ2i8ySsNVBR/Nowgs8VsmzDvaDcvugx+PF9f25ta/GIkylxpBoLVtMa8WZ+CpZvXGDmbeZBOafDiZ8=
X-Received: by 2002:a0d:df0d:0:b0:5c9:e7f8:ba03 with SMTP id
 i13-20020a0ddf0d000000b005c9e7f8ba03mr4532566ywe.4.1700727482614; Thu, 23 Nov
 2023 00:18:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <170066723324.2477261.2506149141979712937.stgit@djiang5-mobl3> <655e7361d6ce_b2e8294b9@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <655e7361d6ce_b2e8294b9@dwillia2-xfh.jf.intel.com.notmuch>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 23 Nov 2023 09:17:49 +0100
Message-ID: <CACRpkdYjEgsyCznNwkSaStk+DMtjH3_oGeX4f4BJzpo5eXHm2g@mail.gmail.com>
Subject: Re: [PATCH v3] acpi: Fix ARM32 platforms compile issue introduced by
 fw_table changes
To: Dan Williams <dan.j.williams@intel.com>, Arnd Bergmann <arnd@arndb.de>
Cc: Dave Jiang <dave.jiang@intel.com>, rafael@kernel.org, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, lenb@kernel.org, robert.moore@intel.com, 
	Jonathan.Cameron@huawei.com, guohanjun@huawei.com, linux-acpi@vger.kernel.org, 
	acpica-devel@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, cfsworks@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 22, 2023 at 10:32=E2=80=AFPM Dan Williams <dan.j.williams@intel=
.com> wrote:

> It concerns me that neither linux-next nor 0day robot exposure reported
> this problem.
>
> Does ARM32 require manual compilation coverage these days or was this
> just a series of unfortunate events that the build bots missed this?

It's not just ARM32, I saw it on ARM64 as well and I'm pretty
sure it appears on any bare metal "none" compiler.

kernel.org host "nolibc" cross compilers (Arnd makes these):
https://mirrors.edge.kernel.org/pub/tools/crosstool/
and those WORK, because they use the kernel minimal
libc which defines __linux__.

So a "nolibc" compiler works but not "none" compilers.

I think the test robots all use Arnds nolibc compilers or the
compilers from distributions so they don't see this.

A typical example of breaking compilers: ARMs supported
"none" compilers:
https://developer.arm.com/downloads/-/arm-gnu-toolchain-downloads

Yours,
Linus Walleij
