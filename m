Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC8E4D9F94
	for <acpica-devel@lists.linux.dev>; Fri, 25 Sep 2026 16:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790353263; cv=none; b=M5B1nrdZ1bug8zSbhu2UsFKbw2sKNfmjvMXuWzM3SlkwMAx17z48O/ymTvQv/v5yw1AzG0Cq507Gg9Cw4tEsmvXpUS1kJj3p/QbGo7bCTI1S93G5/DwPmdiwufD8MRXeZ2BVCnyBi4e/HTK7amzdevcsd7xtHZZd9T3q4NpiPTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790353263; c=relaxed/simple;
	bh=RRM+VB+F1ascDixIQw+zwiO/hfMUWl2mAv/XmiU27Sk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ul98W1eTtvpYY1h5LteifLfqXOrSNrEsw2nWv16eA7uej/cO7b19sW39T9JgbfVAeIg+SFYRshEVhsZ4TA6Oml42rZ/utbJmjO9juYqFrndM84wgOhuZG7vC7vkulx/61G5hNzWo2FtCNb2zWav6jmCy504hjsq95CA3oKZx2mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bvhk/D7S; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bvhk/D7S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 397E41F0089B
	for <acpica-devel@lists.linux.dev>; Fri, 25 Sep 2026 16:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790353261;
	bh=vE6pHmAARuBSk/teCX6R9gtYXPmWhOiA/W20iT/3xPY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=bvhk/D7SryMGcCFPPjFp1EbPY5inbtvr7w9x12h+nrCopGV23dliw+5APgDk0q8pS
	 nQmD+AJ4bJou1FUCAFHYBPZbF7LEl0yzYnfPOP52fsqmZBAZorkv+2ctt7+B1iR5dc
	 B8FIR2gcFdKR3w4+yF6qMvVYfLWKKtseDqC+fYiQCngPV1zOOmBkRTuDz3kC5gULLm
	 1vOtRhpV7FlY5xlPb9Iu2nZBGl64IITEAMcjQXdtN6A+nTmC6eR59c8lZCWu+VF2xK
	 Q3KIIryyZEo6Z4eTl7dL036Yx57r0asKKlWDGqWp9AkGseET87YkNlgkZox+6k1msg
	 GyZvQBZGYSqGw==
Received: by mail-lr2-f34.google.com with SMTP id 38308e7fff4ca-3a6502af787so6494551fa.0
        for <acpica-devel@lists.linux.dev>; Fri, 25 Sep 2026 09:21:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxRiWAHkb6ppC2oexnEU9dDgRqQkHyrT5Ts41dNgcZNKvGdbcbadOoxhEWyahbi9obt6lBzXif2CCdVD/E=@lists.linux.dev
X-Gm-Message-State: AFuF++kMkHA22OpRr/fkIen6qCNj/thsnPxd0g9jQ9wMhtFwqidb8W1w
	5w9dzLH6t8civnqbuz2rpKHVzWKm3HOmgZgEiroEwHhnri1dQ97CDI9cACZjpIvCs3G21HlyPOW
	TsiX08AHtTheyg2zz2R/zRfE419iHlMo=
X-Received: by 2002:a2e:be05:0:b0:3a6:4a45:df84 with SMTP id
 38308e7fff4ca-3a64a45e134mr8339091fa.1.1790353259567; Fri, 25 Sep 2026
 09:20:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260922144302.3847593-1-sudeep.holla@kernel.org>
In-Reply-To: <20260922144302.3847593-1-sudeep.holla@kernel.org>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 25 Sep 2026 18:19:20 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0j63FKQQRq+RtwU6SpMCKXw1edM5baddKjZNtN1YARheQ@mail.gmail.com>
X-Gm-Features: AclHuK-fZa4xCmBsrQOI0lyEp4RFj0UN4TMr8-VlKx6GgSTP3x-5L-hTNIVXvZs
Message-ID: <CAJZ5v0j63FKQQRq+RtwU6SpMCKXw1edM5baddKjZNtN1YARheQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] ACPI/PCC: Correct PCC OperationRegion handling
To: Sudeep Holla <sudeep.holla@kernel.org>
Cc: linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>, 
	Pawel Chmielewski <pawel.chmielewski@intel.com>, Huisong Li <lihuisong@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2026 at 4:43=E2=80=AFPM Sudeep Holla <sudeep.holla@kernel.o=
rg> wrote:
>
> Hi,
>
> This series corrects the handling of PCC OperationRegions and their
> shared memory.
>
> ACPI 6.3 states that a PCC OperationRegion describes the shared memory
> following the PCC signature. Consequently, COMMAND fields at raw shared
> memory offsets 4 and 12 appear at OperationRegion offsets 0 and 8.
>
> The first patch corrects those offsets in ACPICA. This change has already
> been submitted upstream:
>
>   https://github.com/acpica/acpica/pull/1205
>
> The ACPICA patch is included here only to document the complete
> dependency and aid review and testing. It must enter the kernel through
> the ACPICA pull/import process and will not be merged directly through
> the Linux ACPI tree.
>
> The remaining Linux patches:
>
> - Preserve the platform-populated PCC signature when copying
>   OperationRegion data.
> - Release the mailbox channel and region context when ACPICA
>   deactivates an OperationRegion.
> - Compute and cache the command timeout during channel setup.
>
> There is no strict build dependency in case ACPICA and other 3 changes
> need to be merged at different timeline or via different branch.
>
> Regards,
> Sudeep
>
> ---
>
> Changes in v3:
>  - Updated the ACPICA patch to the version accepted as part of
>    https://github.com/acpica/acpica/pull/1205
>  - Rebased other patches to v7.3-rc4
>  - v2: https://lore.kernel.org/all/20260722131553.2117835-1-sudeep.holla@=
kernel.org/
>
> Changes in v2:
>  - Updated the commit message to include correct example of PCC Opregion
>    as the example added by original commit 77e2a04745ff ("ACPI: PCC:
>    Implement OperationRegion handler for the PCC Type 3 subtype")
>    incorrectly included the signature as an OperationRegion field.
>  - v1: https://lore.kernel.org/all/20260717081005.470013-1-sudeep.holla@k=
ernel.org/
>
> Sudeep Holla (4):
>   ACPICA: Fix PCC OperationRegion command offsets
>   ACPI: PCC: Preserve shared memory signature in OpRegion handler
>   ACPI: PCC: Free channel on OpRegion deactivation
>   ACPI: PCC: Cache OpRegion command timeout
>
>  drivers/acpi/acpi_pcc.c       | 55 ++++++++++++++++++++++++++---------
>  drivers/acpi/acpica/exfield.c | 11 +++----
>  2 files changed, 48 insertions(+), 18 deletions(-)

Applied as 7.4 material, but please note that Sashiko reports
pre-existing issues in this code:

https://sashiko.dev/#/patchset/20260722131553.2117835-1-sudeep.holla%40kern=
el.org

Thanks!
