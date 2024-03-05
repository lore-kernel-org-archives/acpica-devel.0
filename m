Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27787E0E8
	for <acpica-devel@lists.linux.dev>; Tue,  5 Mar 2024 07:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709624568; cv=none; b=NmoYnOZ/tTQzq9tZVFm36bd6PY+l17UzwuFtnX0bJ2poQcG9qFvldPqLSJtf0olSGgIQhFzM3DyS9PqiCIfpvLGsJhGlN2GeJZXjhrOQ8EUqjHCKPNWYcMyEmhPQdfbXNt4o3AGXa2EztFq6y/5eRQzooRcmHQxvbHKPd/3ZH2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709624568; c=relaxed/simple;
	bh=1yacK9hpiPuhyJxzTeAxFGss0ekxT9wkeTcOYVFT5O0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jcEdjm/GgziEzb6JEwKjeN8HEz/SCiE3GNEPKJZR86n25Veq2NRBOE5eejG/0m/tc/kf/ij7txgVuShomENobYBmWHLx8BLk3aYMGdVLrOnGtQEJGnytEIRs92f46py91j9y2tvx6v8pXrrBcrYy76jCfXq2qtenZmJPAs9Xmb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RV9o0Oek; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RV9o0Oek"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2d27184197cso73951841fa.1
        for <acpica-devel@lists.linux.dev>; Mon, 04 Mar 2024 23:42:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709624565; x=1710229365; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1yacK9hpiPuhyJxzTeAxFGss0ekxT9wkeTcOYVFT5O0=;
        b=RV9o0OekxUatJ+22kUvYwDE+BgyWkF+UjwQGt1s55ZLdX/cm4NctgUuy8hi44ixqIV
         1U47D2mEnmGRqCA6o2H6HJUBW0TnRJbVfdaiybyU8R60j22NSvxgiTnnm3ytkSvIah3O
         lKoyEPj+T2rTIzZzfJRcrEf1UYO+AGykaPCTvqfwcxTWNb808L0wa9xPPuR0GMIDWr3H
         pi+2wUjUT+30z8FWrW7hOYltEO02nQ7XJduNBMRsd/HVFYas37DRvgExQMcVkmgS0YrB
         06WnBkJuaWUnfMpC2exB52dLPyRGqlaIW0nIWyPy0qr8OcnuGKFtevNKVGVP4ehiKmzZ
         dHbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709624565; x=1710229365;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1yacK9hpiPuhyJxzTeAxFGss0ekxT9wkeTcOYVFT5O0=;
        b=jJYZFsclMPWZ9oNewq+nXQnwE8s+vkJwiHMCZ+9fNDf2tFGLstFlIwgDNIJqeNuLAu
         k5yhLgTGW2Yl8V/xdjnLys1sp0U+Dmqa90iUC8hDVlEDjC+Q1mJxts/P0IxSDfO2MLSf
         iAht93z9U6TzFXmwTGhpbpQl0SaedifHyjgIhp2E0DyuoQaHCNlxA8W0tdY5wt1sZpxx
         nHvZEAlpHMjoci+L2lTOaVXzgP044rFPNmMUsqFObMMDyHPLJu22NBFwn8zr6jo4qIHE
         V9TVgAi8tZG9c7OuN+zEnGa5/LC1AdpU8PQyNOL73a8BMpdvwc3M9bp9wJqJSsN85J+d
         G1gQ==
X-Forwarded-Encrypted: i=1; AJvYcCX3ZQiKW0lO31FDuL8IdzCo+xmFHwJpmtPR24YHg41Rqzbm2V0Nbwu2l12B1Mf58WT5Ny2mW5R3wPXy9w2t3bCYr9o2v8rJJD+YVDMv
X-Gm-Message-State: AOJu0Ywepvew/XFM0GjlJm4VBE1OMgc4nDBRUJOVLE4HmBYKeAucZVAV
	MFrsr+Y8zVGrhlHqgZNKo/CVvLeuE04zQjSJnEr76cfMx5xkkRYsErB/4EqH61+h9qa6PEUXiUW
	RLRXoqjTiEmqLo0gbjeqFWCGSHBU=
X-Google-Smtp-Source: AGHT+IH3ogEE3gS9kmBu6JCdtMvf/PW5rL/fmSyuLCQWSV1sV1Mmkgo71z6sH2+EquAbsW+oxtRPML/1nmNxh73v3b8=
X-Received: by 2002:a05:651c:1683:b0:2d2:ef14:593e with SMTP id
 bd3-20020a05651c168300b002d2ef14593emr506670ljb.48.1709624564715; Mon, 04 Mar
 2024 23:42:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1706603678.git.haibo1.xu@intel.com> <ZeajHkn6dTQ3krsL@sunil-laptop>
In-Reply-To: <ZeajHkn6dTQ3krsL@sunil-laptop>
From: Haibo Xu <xiaobo55x@gmail.com>
Date: Tue, 5 Mar 2024 15:42:32 +0800
Message-ID: <CAJve8on1B7psLYX+Qei0Uxc=GbrGYq52OqV+ZFND9PkPMnyj=g@mail.gmail.com>
Subject: Re: [PATCH 0/4] Add ACPI NUMA support for RISC-V
To: Sunil V L <sunilvl@ventanamicro.com>
Cc: Haibo Xu <haibo1.xu@intel.com>, ajones@ventanamicro.com, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Robert Moore <robert.moore@intel.com>, Conor Dooley <conor.dooley@microchip.com>, 
	Guo Ren <guoren@kernel.org>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>, 
	Alexandre Ghiti <alexghiti@rivosinc.com>, Greentime Hu <greentime.hu@sifive.com>, 
	Anup Patel <apatel@ventanamicro.com>, Sami Tolvanen <samitolvanen@google.com>, 
	Jisheng Zhang <jszhang@kernel.org>, =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>, 
	Baoquan He <bhe@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Arnd Bergmann <arnd@arndb.de>, James Morse <james.morse@arm.com>, Evan Green <evan@rivosinc.com>, 
	Samuel Holland <samuel.holland@sifive.com>, Yang Li <yang.lee@linux.alibaba.com>, 
	Tony Luck <tony.luck@intel.com>, Ard Biesheuvel <ardb@kernel.org>, Yuntao Wang <ytcoode@gmail.com>, 
	Dan Williams <dan.j.williams@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Alison Schofield <alison.schofield@intel.com>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
	acpica-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 5, 2024 at 12:44=E2=80=AFPM Sunil V L <sunilvl@ventanamicro.com=
> wrote:
>
> Hi Haibo,
> On Wed, Jan 31, 2024 at 10:31:57AM +0800, Haibo Xu wrote:
> > This patch series enable RISC-V ACPI NUMA support which was based on
> > the recently approved ACPI ECR[1].
> >
> > Patch 1/4 is generated from the acpica PR[2] and should be merged throu=
gh
> > the acpica project. Due to this dependency, other 3 patches can only be
> > merged after the corresponding ACPICA patch was pulled into linux.
> >
> > Patch 2/4 add the common SRAT RINTC affinity structure handler.
> > Patch 3/4 add RISC-V specific acpi_numa.c file to parse NUMA informatio=
n
> > from SRAT and SLIT ACPI tables.
> > Patch 4/4 add corresponding ACPI_NUMA config for RISC-V Kconfig.
> >
> > Based-on: https://github.com/linux-riscv/linux-riscv/tree/for-next
> >
> > [1] https://mantis.uefi.org/mantis/view.php?id=3D2433
>
> Please avoid providing mantis link. It is not useful for people who are
> not UEFI members. Better to provide the link to the PDF version of the
> ECR approved.
>

Sure. Will update with a PDF link in v2.

Thanks,
Haibo

> Thanks,
> Sunil
