Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D839429C343
	for <acpica-devel@lists.linux.dev>; Wed, 30 Apr 2025 20:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746043401; cv=none; b=Vk9S17XcgWTGpYTmECSL2nKAlr95aZ6aeJOZaMBL0zgiduailFdNkK7Peg9uMGRbZG0L//U2H10mkJoDfKIlVBnuFik3sZwCUt7cvEfYk81PO3V4RmZkWlFpQD4kRfUdJY180pGhkU2ENvvTGoVrdqxRU6BDDsXXEBQA1yjwcD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746043401; c=relaxed/simple;
	bh=NwkGTVS0PocVVimFJdrGAK87WACDEWoHwAWZ4ywRzNo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F3oy3tKRQUuJWBX3iFfldWPD2xzyVlAZjAeb6w8dFxDEVTIFEBP/xu6CVBaY5bthlRwsAfQ9fFgaIDX6sdOIEKlVMs5pA11kh/5aTi5KpsuukGtV3/PXFuivaeZX/6bSFA0zc4/xnkvv2jF28rKiHOeDPIog+1OetNA4Y6eomhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sGXtdOIs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sGXtdOIs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58310C4CEEF
	for <acpica-devel@lists.linux.dev>; Wed, 30 Apr 2025 20:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746043401;
	bh=NwkGTVS0PocVVimFJdrGAK87WACDEWoHwAWZ4ywRzNo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=sGXtdOIsh95cJHlMJ2UvMYNq00VI1k0tUOUT8o+jwmfNBOiBD5Hz43nN12KbD+z1A
	 WJh8s/CwSa4vKwQyieZf4GpmaGw1DibvLQyYrAcawmxZ5u8T9z5fpOhnCVUKDx5+dZ
	 VUCHdTS+Xporl7tISdbYNDtETZHm0ffNF9LD5pjz/oMQW9U6LiiJb/wzo4r2Kzxpqm
	 96whW6qML7A3aFOUj2zlxPbO44i2YU1VeyrmWycr39pjqvd9y977mil+s0iCQeOyIJ
	 iI3//MkPerjXdl6K5HHd+Jya+nDST2Apv8BzB1DtdRIwJPsdiyloj4TM/MC5VYojRW
	 cTkLNGVDCXIag==
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-72fffa03ac6so169457a34.3
        for <acpica-devel@lists.linux.dev>; Wed, 30 Apr 2025 13:03:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUYpa832u5VCIC8LnR9dJWzeBHcjwVSpTtB0UjNRwp1YUpwlKkpp+7Lz2vyVIUiTRF6N3R3EdZ5cbsgrqk=@lists.linux.dev
X-Gm-Message-State: AOJu0YznQYweRnHHO4LVDTwLGBBT7Lp/Kn5bTjM07ZMikC1gbXQKMUQY
	3NdqFteHcQAfyMv93A3hNBkAypVokh2irxLHywy74IFUFMCc/nyVUcQtaapJfYKK9ueIAV9VBdI
	k0ItkuWP3/3YwFvAAcSyORNK67tU=
X-Google-Smtp-Source: AGHT+IGhmLyBRn0IZdPfK6KM97JS9uw2zTeIkkXouEb91STcAV8rAa4Gk6jixae6PbBFOGyZRuGtQUMmrj+NP/8P2CA=
X-Received: by 2002:a05:6870:71cb:b0:2b3:55b3:e38 with SMTP id
 586e51a60fabf-2da69f21b34mr2403838fac.21.1746043400613; Wed, 30 Apr 2025
 13:03:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250411093855.982491-1-zhenglifeng1@huawei.com> <f6904bb1-f41f-4be9-92bb-92fec509a821@amd.com>
In-Reply-To: <f6904bb1-f41f-4be9-92bb-92fec509a821@amd.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 30 Apr 2025 22:03:09 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gNZsv+sJ8OweGYE6bFTqD48g3JUJn_kL2m17Q2QX6p1w@mail.gmail.com>
X-Gm-Features: ATxdqUFlzi9fK4g3MpOxGzQvjbOGdDgFxNB6hIBF5J0ky9zNPfIg6Ulnwvdr2WA
Message-ID: <CAJZ5v0gNZsv+sJ8OweGYE6bFTqD48g3JUJn_kL2m17Q2QX6p1w@mail.gmail.com>
Subject: Re: [PATCH v7 0/8] Add functions for getting and setting registers
 related to autonomous selection in cppc_acpi
To: Mario Limonciello <mario.limonciello@amd.com>, Lifeng Zheng <zhenglifeng1@huawei.com>
Cc: lenb@kernel.org, robert.moore@intel.com, viresh.kumar@linaro.org, 
	gautham.shenoy@amd.com, ray.huang@amd.com, perry.yuan@amd.com, 
	pierre.gondois@arm.com, sumitg@nvidia.com, acpica-devel@lists.linux.dev, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linuxarm@huawei.com, jonathan.cameron@huawei.com, 
	zhanjie9@hisilicon.com, lihuisong@huawei.com, cenxinghai@h-partners.com, 
	hepeng68@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 11, 2025 at 8:18=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> On 4/11/2025 4:38 AM, Lifeng Zheng wrote:
> > The patch series is organized in two parts:
> >
> >   - patch 1-6 refactor out the general CPPC register get and set functi=
ons
> >     in cppc_acpi.c
> >
> >   - patches 7-8 add functions for getting and setting values of auto_se=
l,
> >     energy_perf and auto_act_window in cppc_acpi.c
> >
> > Changelog:
> >
> > v7:
> >
> >   - Fix some typos
> >   - Add check of null pointer in cppc_get_reg_val(),
> >     cppc_get_auto_act_window() and cppc_get_auto_sel()
> >   - Replace ternary operator with logical expression in cppc_get_reg_va=
l()
> >
> > v6:
> >
> >   - Remove the last patch, will resent it in the future after reaching =
an
> >     agreement with Sumit
> >   - split patch 3 into 2 smaller patches
> >   - Remove the printing of reg_idx in cppc_get_reg_val() and
> >     cppc_set_reg_val()
> >   - Change the logic for determing whether a register is supported in
> >     cppc_get_reg_val() and cppc_set_reg_val()
> >
> > v5:
> >
> >   - add more explanation to the commit logs and comments
> >   - change REG_OPTIONAL from bin to hex
> >   - split patch 2 into 3 smaller patches
> >   - remove CPPC_REG_VAL_READ() and CPPC_REG_VAL_WRITE() macros
> >   - move the modification part in patch 5 into a separate patch
> >   - rename the sysfs file from "energy_perf" to
> >     energy_performance_preference_val
> >
> > v4:
> >
> >   - add REG_OPTIONAL and IS_OPTIONAL_CPC_REG to judge if a cpc register=
 is
> >     an optional one
> >   - check whether the register is optional before CPC_SUPPORTED check i=
n
> >     cppc_get_reg_val() and cppc_set_reg_val()
> >   - check the register's type in cppc_set_reg_val()
> >   - add macros to generally implement registers getting and setting
> >     functions
> >   - move some logic codes from cppc_cpufreq.c to cppc_acpi.c
> >   - replace cppc_get_auto_sel_caps() by cppc_get_auto_sel()
> >
> > v3:
> >
> >   - change cppc_get_reg() and cppc_set_reg() name to cppc_get_reg_val()=
 and
> >     cppc_set_reg_val()
> >   - extract cppc_get_reg_val_in_pcc() and cppc_set_reg_val_in_pcc()
> >   - return the result of cpc_read() in cppc_get_reg_val()
> >   - add pr_debug() in cppc_get_reg_val_in_pcc() when pcc_ss_id < 0
> >   - rename 'cpunum' to 'cpu' in cppc_get_reg_val()
> >   - move some macros from drivers/cpufreq/cppc_cpufreq.c to
> >     include/acpi/cppc_acpi.h with a CPPC_XXX prefix
> >
> > v2:
> >
> >   - fix some incorrect placeholder
> >   - change kstrtoul to kstrtobool in store_auto_select
> >
> > ---
> > Discussions of previous versions:
> > v1: https://lore.kernel.org/all/20241114084816.1128647-1-zhenglifeng1@h=
uawei.com/
> > v2: https://lore.kernel.org/all/20241122062051.3658577-1-zhenglifeng1@h=
uawei.com/
> > v3: https://lore.kernel.org/all/20241216091603.1247644-1-zhenglifeng1@h=
uawei.com/
> > v4: https://lore.kernel.org/all/20250113122104.3870673-1-zhenglifeng1@h=
uawei.com/
> > v5: https://lore.kernel.org/all/20250206131428.3261578-1-zhenglifeng1@h=
uawei.com/
> > v6: https://lore.kernel.org/all/20250409065703.1461867-1-zhenglifeng1@h=
uawei.com/
> >
> > Lifeng Zheng (8):
> >    ACPI: CPPC: Add IS_OPTIONAL_CPC_REG macro to judge if a cpc_reg is
> >      optional
> >    ACPI: CPPC: Optimize cppc_get_perf()
> >    ACPI: CPPC: Rename cppc_get_perf() to cppc_get_reg_val()
> >    ACPI: CPPC: Extract cppc_get_reg_val_in_pcc()
> >    ACPI: CPPC: Add cppc_set_reg_val()
> >    ACPI: CPPC: Refactor register value get and set ABIs
> >    ACPI: CPPC: Modify cppc_get_auto_sel_caps() to cppc_get_auto_sel()
> >    ACPI: CPPC: Add three functions related to autonomous selection
> >
> >   drivers/acpi/cppc_acpi.c     | 313 +++++++++++++++++++++-------------=
-
> >   drivers/cpufreq/amd-pstate.c |   3 +-
> >   include/acpi/cppc_acpi.h     |  30 +++-
> >   3 files changed, 219 insertions(+), 127 deletions(-)
> >
>
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

All patches in the series applied as 6.16 material, thanks!
