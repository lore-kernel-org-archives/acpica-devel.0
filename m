Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97EB22FACA
	for <acpica-devel@lists.linux.dev>; Wed, 15 Jan 2025 11:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736939590; cv=none; b=kgZHt3dwYeRKLLG+h/6i9s7y4CblTDCdbX9rlqllh1md1NZsxF+zUR2EwAFAsjZ1QT5pxQCrd2zQh0Jr7S4YTKJELFfioH26uj3sM53kwXgWkXl/yn8dw6+Uo/9l9JzZ0jJV0zZMLIGNewIGrCGALUox0HEsicvuywYyxAqU7TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736939590; c=relaxed/simple;
	bh=6jO4WiPBhFzgyb9GhdkgahEyUDYbh3P2ioXyxGAwVdw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EafT8FThzUq0pgubIblZdyaV1cDRk6qQuvq1n6GkvfgBGqLM2Mn38A8SN6392jud7Wgiyi5eLCAooM5/+Wnlxc6+tRVK5lYuZawjeNxOUuNXrJW1BXgnCMqG6v6E7hiJdfOwv1DVYlXPDn7uLSKhjEiZmy3/jtOnIrpZ2w473xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=djdd+Tiv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="djdd+Tiv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53C7DC4CEE6
	for <acpica-devel@lists.linux.dev>; Wed, 15 Jan 2025 11:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736939589;
	bh=6jO4WiPBhFzgyb9GhdkgahEyUDYbh3P2ioXyxGAwVdw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=djdd+TivZehmhPLpPa4kJZz1+1z7/jt7y/q8s7pcUVQ0XE7AgDNQ/c3m+ICnbvMuD
	 lRMAXCi4jKbjH8de34O9BIT+bRBJQOnltJD655VBtdT3Qfpp1+EZROiWBA38Ybsm5s
	 gSrjMZRaz1X9yEsSyrZbf4Cc5j5xsUPq5EnxgpDn/pIHhUySnXPj/MBeon4a4BLEp3
	 JpDZpuNsiz3YRiu3fDY4IcRO1q0/nZVaEuWzxjM4xTMEo9aeG4/mzPN9AO518PCLoz
	 NFfYVo/qtARRITXmuRpsHpE300Ql2UVV018us7d6KeA6xTL//cWAg8jx7WU1+urNEN
	 vql5fiqTXQm9w==
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3eba347aa6fso4099148b6e.3
        for <acpica-devel@lists.linux.dev>; Wed, 15 Jan 2025 03:13:09 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVcZKfrf9H+QaOlC67ZnQv0fQYIhm2Uuw4T3fkRGsPeLrYu1yqm3C6UmCu3QHtkn45EzPTNoHHbY9Bt3dw=@lists.linux.dev
X-Gm-Message-State: AOJu0YyTF+LjQ+IdRkhcE5w/JVw0HCSfc9YcmiAZxknUPb7AM/KotjLd
	DglcLbC9ByxssJB+eSMi7T2L+rCiOQ5o+7NODKYW3re4+TZ9m77krWBjK4Qm3RQNArsn5WLDkZL
	/+awqikcTDoi9UInsna14HF4Ee/U=
X-Google-Smtp-Source: AGHT+IHnnDdSk0+UGjbtKgUlEIzX22igfm/NGfH82JBFguw7/RwNA1HP/MBV1bCC8lSJ8ui81Ri8tBig7u5Nt4aXNpU=
X-Received: by 2002:a05:6808:3095:b0:3eb:a602:62b1 with SMTP id
 5614622812f47-3ef2ec43a84mr18858448b6e.17.1736939588258; Wed, 15 Jan 2025
 03:13:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250113122104.3870673-1-zhenglifeng1@huawei.com>
 <20250113122104.3870673-4-zhenglifeng1@huawei.com> <CAJZ5v0jwqZ4A=eeHSXGHKpj-g+KFNWvgLB_yjM55Yk37LryrwQ@mail.gmail.com>
 <10a624c3-66c1-420c-860d-2ef9104b59d8@huawei.com>
In-Reply-To: <10a624c3-66c1-420c-860d-2ef9104b59d8@huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 15 Jan 2025 12:12:57 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jmZy0tNO7Btc9-A0rfzL5jPp2ZEH99bEX00cEi3z+XcQ@mail.gmail.com>
X-Gm-Features: AbW1kvbIZPwFXAmyiLrc7Lroo3xglhf9zN2VVd-BjjjHc-QrsQ-2BYDR3RYvtEs
Message-ID: <CAJZ5v0jmZy0tNO7Btc9-A0rfzL5jPp2ZEH99bEX00cEi3z+XcQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/6] ACPI: CPPC: Add macros to generally implement
 registers getting and setting functions
To: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, lenb@kernel.org, robert.moore@intel.com, 
	viresh.kumar@linaro.org, mario.limonciello@amd.com, gautham.shenoy@amd.com, 
	ray.huang@amd.com, pierre.gondois@arm.com, acpica-devel@lists.linux.dev, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linuxarm@huawei.com, jonathan.cameron@huawei.com, 
	zhanjie9@hisilicon.com, lihuisong@huawei.com, hepeng68@huawei.com, 
	fanghao11@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 15, 2025 at 9:59=E2=80=AFAM zhenglifeng (A) <zhenglifeng1@huawe=
i.com> wrote:
>
> On 2025/1/15 1:58, Rafael J. Wysocki wrote:
>
> > On Mon, Jan 13, 2025 at 1:21=E2=80=AFPM Lifeng Zheng <zhenglifeng1@huaw=
ei.com> wrote:
> >>
> >> Add CPPC_REG_VAL_READ() to implement registers getting functions.
> >>
> >> Add CPPC_REG_VAL_WRITE() to implement registers setting functions.
> >>
> >> Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
> >
> > I don't particularly like these macros as they will generally make it
> > harder to follow the code.
> >
> >> ---
> >>  drivers/acpi/cppc_acpi.c | 14 ++++++++++++++
> >>  1 file changed, 14 insertions(+)
> >>
> >> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> >> index 571f94855dce..6326a1536cda 100644
> >> --- a/drivers/acpi/cppc_acpi.c
> >> +++ b/drivers/acpi/cppc_acpi.c
> >> @@ -1279,6 +1279,20 @@ static int cppc_set_reg_val(int cpu, enum cppc_=
regs reg_idx, u64 val)
> >>         return cpc_write(cpu, reg, val);
> >>  }
> >>
> >> +#define CPPC_REG_VAL_READ(reg_name, reg_idx)           \
> >> +int cppc_get_##reg_name(int cpu, u64 *val)             \
> >> +{                                                      \
> >> +       return cppc_get_reg_val(cpu, reg_idx, val);     \
> >> +}                                                      \
> >> +EXPORT_SYMBOL_GPL(cppc_get_##reg_name)
> >
> > What about if defining something like
> >
> > #define CPPC_READ_REG_VAL(cpu, reg_name, val)
> > cppc_get_reg_val((cpu), CPPC_REG_IDX(reg_name), (val))
> >
> > (and analogously for the WRITE_ part), where CPPC_REG_IDX(reg_name) is
> >
> > #define CPPC_REG_IDX(reg_name)    CPPC_REG_##reg_name_IDX
> >
> > and there are CPPC_REG_##reg_name_IDX macros defined for all register
> > names in use?
> >
> > For example
> >
> > #define CPPC_REG_desired_perf_IDX   DESIRED_PERF
>
> What about keeping these two macros but replace reg_idx with
> CPPC_REG_IDX(reg_name)? With this, the only needed parameter for these tw=
o
> macros is reg_name.

The problem is that looking up functions defined through macros is
hard when somebody wants to know what they do, so I'd prefer to avoid
doing that.
