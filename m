Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D00426F50D
	for <acpica-devel@lists.linux.dev>; Thu,  7 Mar 2024 09:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709803697; cv=none; b=DZy6JR/flVVeahV0jrT2eLm/QYTYEbI0cLJ43gCwV7zmyTgg0f7EGgO4kNn7khAKpxoqEsJE4IytzE512Q/jVduafvTZxuIi87wBA1nTMs3QlqJBPV/f7zAj4Yzzat5FJJOSCqCMl8XK00WXUSBbQBnGbgWxatM79IjuJEqGz9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709803697; c=relaxed/simple;
	bh=D9TARgVfvKxiTfXSCd37HBbIyUqk+XaFYYpnT4+b3YA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oRXzDgfe67BlZ2zmLB0ELAyPGQgX0mQeQrhH+zNPuxeMBGJGMdZDU310gCXzxHRcv4HD5hSQ0MmLNFmpUo8ap2EMWbmb3on6uGVE52qqt9wySCh4dHk6wswYgzAE0FM023NwbxDlbWObh4jHxWmgMrz9U6/k8SkDkffxNMkKB08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZmnRgIge; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZmnRgIge"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2d240d8baf6so7090881fa.3
        for <acpica-devel@lists.linux.dev>; Thu, 07 Mar 2024 01:28:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709803694; x=1710408494; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tqElFMkTvBicMVdZ7SEelWOQGbRnANtN0YyyYb/TJwk=;
        b=ZmnRgIgev6L2VuKR/5XVLY4HsKDCaZL1KwOKrzQUse8f4h66j7gkYE9oP3T29WJeeE
         roP+QfZ5M3MA83uzWatnwO15TNQOZ2+TYy6TxVc6EPapWKxUTJo1FedKUmAyMKRhKAgd
         AIi2C73udveb6XbX6a5xojGEiPbneEsWE/rSdGkRFZBz7oiJ87vyxWCmLG33TfeUOtTT
         Aw6OJs0CUm3N1PzqQW6pmASolWq+FC693/EEmvjfjfTLLoafcBhFT1xe/3WxE2xxjXbr
         rHdNo5RTgDDLYCzvlCkAQcNODnVTM5NLuA2Z+1GDzYSDFwPpCubDiskyvhegGHpHvyI0
         yfqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709803694; x=1710408494;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tqElFMkTvBicMVdZ7SEelWOQGbRnANtN0YyyYb/TJwk=;
        b=G6eHRvvnltCajD/NwIfW7pPrjRY9pZ+CMpY4D3bUWPcLbehayhrySYQ1l5mABm0lnQ
         a3zfOBfrP+7lgEZ6k5LE2VDzy4bRC3En4yrdug+us5/vyBbtzCHyrHOiCrl9eio05HkZ
         12co3gITpkJfxHBpAF+riShLTcC/R8VH6RjD21fpOppMgmgu0PJJqBu6CNNaXlGu72fq
         caUrAp82GmEeyn/X6XYAE1KpTDrhI/Xy0vyY3zGh5XoeWqLHytcTmetgEXJGryTFKT7b
         nT8H9RX8k5E9+LlMLFlSnr22dgZQsMWs6fThm7ploQCnKcB/5ipvGcGw2D8aekL8LNFI
         IQfg==
X-Forwarded-Encrypted: i=1; AJvYcCWVVo6pcBj3QAA62TmoVDt/GFCIdEUEurr/A2U0sD+zWaQcfUHqA3uEAZHO9RHWuzF+ABcRsQjLxM6QNfz10O2CW4IEEmVYlzcDe1D3
X-Gm-Message-State: AOJu0Yz/ZgOeyngIOLOeJNgJ+tkPt00FO0nwZ1U1tk8T6w4njrvJ6mUm
	12kNQ7YG4vvsXgbtMY0lSgzc1lcqhl48R0vW1JfSbCCATJID5upqZGEggjC6VbD9Qbg4fJ/e5T2
	A0o1da4ozGkjZFN6j9cC/bVieKx4=
X-Google-Smtp-Source: AGHT+IHjiV486p3sDeAH/QYQK+UU0DDVMP/fjkLCxIHtvcvLxZRd6CYQ+zyuZllwi3vJwxDlj6y9NUHPpGfSmrapx9A=
X-Received: by 2002:a2e:9787:0:b0:2d3:fae3:d7d5 with SMTP id
 y7-20020a2e9787000000b002d3fae3d7d5mr862143lji.48.1709803693441; Thu, 07 Mar
 2024 01:28:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1709780590.git.haibo1.xu@intel.com> <f23da383a8fdbee15acd41fdcd38ef3a89045a43.1709780590.git.haibo1.xu@intel.com>
 <c9e9da9f-ff81-48eb-beec-4f54921cd268@app.fastmail.com> <CAJve8o=BsR1SG0k_7mb61Jj1fb+9rc4V9Y=MMX004fpAWE4vjg@mail.gmail.com>
 <460338ee-c8d5-4f43-9bab-4c35e417e4ad@app.fastmail.com>
In-Reply-To: <460338ee-c8d5-4f43-9bab-4c35e417e4ad@app.fastmail.com>
From: Haibo Xu <xiaobo55x@gmail.com>
Date: Thu, 7 Mar 2024 17:28:02 +0800
Message-ID: <CAJve8o=SKkV1oE__4waY8gx0OoYptPNH3a2UzL37a=-+wcbcDA@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] ACPI: NUMA: Remove ARCH depends option in
 ACPI_NUMA Kconfig
To: Arnd Bergmann <arnd@arndb.de>
Cc: Haibo Xu <haibo1.xu@intel.com>, Alison Schofield <alison.schofield@intel.com>, 
	Jisheng Zhang <jszhang@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Dave Hansen <dave.hansen@linux.intel.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>, 
	"Conor.Dooley" <conor.dooley@microchip.com>, guoren <guoren@kernel.org>, 
	Zong Li <zong.li@sifive.com>, James Morse <james.morse@arm.com>, 
	linux-riscv@lists.infradead.org, Ard Biesheuvel <ardb@kernel.org>, 
	Baoquan He <bhe@redhat.com>, acpica-devel@lists.linux.dev, 
	Robert Moore <robert.moore@intel.com>, linux-acpi@vger.kernel.org, 
	Sami Tolvanen <samitolvanen@google.com>, Greentime Hu <greentime.hu@sifive.com>, 
	Dan Williams <dan.j.williams@intel.com>, Len Brown <lenb@kernel.org>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alexghiti@rivosinc.com>, 
	Charlie Jenkins <charlie@rivosinc.com>, Yuntao Wang <ytcoode@gmail.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>, 
	Anup Patel <apatel@ventanamicro.com>, Tony Luck <tony.luck@intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, 
	Samuel Holland <samuel.holland@sifive.com>, Evan Green <evan@rivosinc.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Andrew Jones <ajones@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 7, 2024 at 5:23=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Thu, Mar 7, 2024, at 10:19, Haibo Xu wrote:
> > On Thu, Mar 7, 2024 at 4:44=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wr=
ote:
> >> On Thu, Mar 7, 2024, at 09:47, Haibo Xu wrote:
>
> >> If we make it
> >>
> >>       def_bool NUMA && !X86
> >>
> >> then the select statements except for the X86_64_ACPI_NUMA
> >> can also go away.
> >>
> >
> > Good idea!
> > Shall we include the ACPI in the def_bool definition?
> >
>
> No need, because this is inside of an 'if ACPI' block.
>

Cool! Let me have a try.

Thanks,
Haibo
>        Arnd
