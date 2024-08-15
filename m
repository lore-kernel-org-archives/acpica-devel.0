Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A4219D8B4
	for <acpica-devel@lists.linux.dev>; Thu, 15 Aug 2024 13:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723727083; cv=none; b=eZL0dgtmgNo5BggTGX6oAGEhU8Rs+Ue9VmQGkiO+B2nqky1plNtTc8+APzGJ2wYBEicYbp9Q/MrqWjoMfoSjGxGhdI/AYZN5nH571ptOWuLXpEuGrh1urKzn7Frcdo5usy7pQ579UMH82ndsl0RVUJVrjFrAcANLMiUDSB/rvvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723727083; c=relaxed/simple;
	bh=CDgGq5qU3Wr0Pir/YqVs7Al/PZ/iVw/ki/I4EssR9Gs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Oxh2i9Rki4tB9HqnNUIzTnX64cC0i0ZJR8nNbthAoHD/bwDGO8PGE5xVn37iFspLi6CPDQ1y4zcFxGblVTHXE4RptgdZgKpWif1nnNcfrmWf+0NL1BQP+z2EOHTEBc/45vuJFBrHT9OPKlLHpn7HVTTposuG/qhDYEN4e7BxGUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CTM2D4Pn; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CTM2D4Pn"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7b594936e9bso632692a12.1
        for <acpica-devel@lists.linux.dev>; Thu, 15 Aug 2024 06:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723727081; x=1724331881; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ia3t2Va5NtSu3BetvUd2KwI5mB/axZOmAEnZeyG3umQ=;
        b=CTM2D4PnfZeRse8ck/IjCkaQonTfqvLcll7MlBTRcEovWDNonvkfB++20nD43NaB0f
         kMgriUCMoarzmh97JSRNS7omPj1qGfZKxoiQ6NLypJwsk57TjCwFARDDo+HCjSQingyG
         U+BW6+RbOdJFi6ElpydV3pbMI/VPu94wzeQC3NeGIfDZVOBvm6W0UGolf8XwiwQo2Yo5
         SMsOkzpoTVuKGT1GtnY8+kSskfBzlEBB4mMc1gg2yGUCf827ztUQUEtyfPpl9TczXD7t
         u1D9ldDNB5q15MnnJEfMc5Q1KfMItjRfhvTbTu/0+fsRtZ2hmbM+Sc+BEil77DIRlVt4
         l44A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723727081; x=1724331881;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ia3t2Va5NtSu3BetvUd2KwI5mB/axZOmAEnZeyG3umQ=;
        b=qczlWcD5DE+PpNcPmhKA2waKoOWDOGOGtMlvvIJoMG97FHfdCGkuhdfIyBTEJTXUVh
         O7jV8Qhbu9QtelJitbAMu+1HS82vHrP4FztSqCeP8W56iwCQhoYAOd5i3Qhyqaf2tCJ6
         2IFTi0fqzqwpj5Iu6jrG6pjn8+Wv9V4S16mHjD09V/lLDBYtZRuHRI2dI3ty8A0OhQXw
         +KceQRV6ehJeBf8jmvpxUuERYAHCpl9llUSieeaYk8XC+2oIpqdr9yeK/npPKJoiFDbR
         4GnjImUOllZUQCmKjGnvRu0AWBnlpLgL+7NUA3QAZS/nDLVc6WdUJAxvISfRQioJMuux
         LjMg==
X-Forwarded-Encrypted: i=1; AJvYcCXDVcIwqMNjubcoHWC/YvawETYf7NeE8MXDiAZPllMYMdVDDGbmdplK0NB9Hk2DzMnxjmFT0NBS1Yd9RHi663LV63eo2RBQP6k+oxzr
X-Gm-Message-State: AOJu0YwGPJYQKiH0Rg3qEapqKTZSUix18oz6GGW9GGO4M33XuvL6uf5N
	7zG4pJFRSqE8zNRRbV2hD4kf+L83WwlT84DHC7FnpJHIFV5FZGRisTjyDVCTvjXP6kqESyqscib
	LoP4QiwLhNVY/JTF+BHh9iAxQBDU=
X-Google-Smtp-Source: AGHT+IGSrLrwuM5RhDoD7uxpi1mK7ij3LB5lI6V4fRyA+cAlhCiR6Vgro+l7Mk/y4jnJPGmGy0vvDkvDt+x+XsPj1nk=
X-Received: by 2002:a17:90b:4c51:b0:2d3:d0b7:da4 with SMTP id
 98e67ed59e1d1-2d3d0b70f31mr1146539a91.19.1723727080832; Thu, 15 Aug 2024
 06:04:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240815082916.1210110-1-pierre.gondois@arm.com> <20240815082916.1210110-7-pierre.gondois@arm.com>
In-Reply-To: <20240815082916.1210110-7-pierre.gondois@arm.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 15 Aug 2024 15:04:27 +0200
Message-ID: <CANiq72mjvE7h_aH5tYnuuzdPHAzDUpioMi-h44HNCro8qFfDSw@mail.gmail.com>
Subject: Re: [RFC PATCH 6/6] rust: cpufreq: Add rust implementation of
 cppc_cpufreq driver
To: Pierre Gondois <pierre.gondois@arm.com>
Cc: linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Len Brown <lenb@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Robert Moore <robert.moore@intel.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, Martin Rodriguez Reboredo <yakoyoku@gmail.com>, 
	Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, 
	FUJITA Tomonori <fujita.tomonori@gmail.com>, Thomas Bertschinger <tahbertschinger@gmail.com>, 
	Danilo Krummrich <dakr@redhat.com>, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, 
	acpica-devel@lists.linux.dev, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 15, 2024 at 10:31=E2=80=AFAM Pierre Gondois <pierre.gondois@arm=
.com> wrote:
>
> In an effort to add test/support the cpufreq framework in rust,
> add a rust implementation of the cppc_cpufreq driver named:
> `rcppc_cpufreq`.

Similar to what Greg said -- is this intended to be something like a
"Rust reference driver" [1] for the subsystem?

[1] https://rust-for-linux.com/rust-reference-drivers

> +       depends on ACPI_PROCESSOR
> +       depends on ARM || ARM64 || RISCV

`depends on RUST`?

Also, I imagine you skipped all safety comments etc. since it is an
RFC, but I thought I would mention it nevertheless.

Thanks for experimenting with Rust!

Cheers,
Miguel
