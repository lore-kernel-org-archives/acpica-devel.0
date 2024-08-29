Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F039E1B6553
	for <acpica-devel@lists.linux.dev>; Thu, 29 Aug 2024 12:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724935500; cv=none; b=VVBAZvqDVR37Sl7OPf4DKp3YoxhpWzPsiK20+mgLfsrrC+X0XOQtn+gi+yMJCDVIAUpc3c/hkAE5WSO17FPHIP/dW0GlPgKlKyrxMyJA7yeIFr4ToUjvfJ2jI+Cu32vwELB9fsKEKibROmcmQeImx3myarAKSiIk48yKKI1RQAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724935500; c=relaxed/simple;
	bh=bmThkBbfzGY/zRaA5TdivH5V4F0RokpFhyMV8XTIb00=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sOecrwR58s/+VqWgPTyHFoBj9jwo/pmMMPJs+4/sudjZ50hHFyRZdkwj+2kMHXndhq97FDOQmUEhpFS7YDAiqdyFt0EIyJd53ae6WEfBtV5mxhMsXXodkTYvHLT99UfcwV5ZeVgU3eJ6guZNkj4+VIuT6hGEJf1NSD3mNs6nrYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a0gX7Gvo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a0gX7Gvo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92265C4CEC1
	for <acpica-devel@lists.linux.dev>; Thu, 29 Aug 2024 12:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724935499;
	bh=bmThkBbfzGY/zRaA5TdivH5V4F0RokpFhyMV8XTIb00=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=a0gX7GvoH5EeSuChFPBYTlzCF1d1y934EjEzXpyy6OZlcF6s1mEvQVMCt+JnUkZ70
	 vpvAwc5My2WgNpTb0cFN3sq0tntq1RXKwsC2W0UkeQ/Sc+S5NDvmw3mIafGb/fq4NY
	 wzGe+nxwu9WmbChwDcKh1dG4VPdliq4kffaB3uQvUoKkeRsTSp90MJE8JtGD8f9N1H
	 BCitxjSiO9LzIf2jYy1CBs3GwAVCAdF5wSmoelXcc2esTqXKrpoSzgKOKZhGNvq8Uy
	 Ou2PalcCB7IRdLObKlmN0bJ4dTs1b2eNxDN1eBiIVPZdDpWUbDvd7txuZpmq5IBJRR
	 GRZ6z3yFC/8Ug==
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-2704b6a6fe6so321617fac.1
        for <acpica-devel@lists.linux.dev>; Thu, 29 Aug 2024 05:44:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXO9OKFYrUnjYiLrrz+JcSXt+P1mYnGf73kHBQdvPK8+XFKERwMIUimK4tBNEgyTwkLOVk+Eyajzn/hefY=@lists.linux.dev
X-Gm-Message-State: AOJu0Yx+c/tllVVO4rCFafa+jP6OjofexxeAd/yc8yG5Cs1JFQrEUokZ
	ad3qJvezJWKEjswoDbsSe8OWDt4reC1KwivneAvFvTl3rlkSPF1bMpKKDDceRrnZgno7xPU+k/0
	e4nFS8NTaiTFDHvNr/+lnejdqukQ=
X-Google-Smtp-Source: AGHT+IGwwcMeXsd6teP/NpzkS3WieVlJLs/+1rpwoZoBxyYX9HPJGboOAyMFF/OmSM2K7zH72Y53RWKmWyRG7LowxaQ=
X-Received: by 2002:a05:6871:2b2a:b0:270:184b:ccd9 with SMTP id
 586e51a60fabf-277902e2b7emr2814143fac.39.1724935497901; Thu, 29 Aug 2024
 05:44:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240827025821.2099068-1-jiaqing.zhao@linux.intel.com>
In-Reply-To: <20240827025821.2099068-1-jiaqing.zhao@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 29 Aug 2024 14:44:46 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jc7_k0GEVYD06v-VJ5Mc9af2MV4taXTxJ9SnZ6+Q3n3A@mail.gmail.com>
Message-ID: <CAJZ5v0jc7_k0GEVYD06v-VJ5Mc9af2MV4taXTxJ9SnZ6+Q3n3A@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] S3 wakeup support for hardware reduced model
To: Jiaqing Zhao <jiaqing.zhao@linux.intel.com>
Cc: Robert Moore <robert.moore@intel.com>, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, 
	acpica-devel@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 27, 2024 at 4:58=E2=80=AFAM Jiaqing Zhao
<jiaqing.zhao@linux.intel.com> wrote:
>
> S3 wakeup requires waking vector in FACS table, which is typically set
> by OS. This patchset enables FACS table support and allows setting
> waking vector in "Hardware-reduced ACPI support only" builds
> (CONFIG_ACPI_REDUCED_HARDWARE_ONLY=3Dy).
>
> Link: https://github.com/acpica/acpica/pull/960
> Link: https://github.com/acpica/acpica/commit/ee53ed6b5452612bb44af542b68=
d605f8b2b1104
>
> v2->v3:
> * Remove extra code style changes to align with original ACPICA commit.
> v1->v2:
> * Not removing acpi_hw_set_firmware_waking_vector() declaration in
>   hwxfsleep.c
> * Change was merged in ACPICA project, add links to it.
>
> Jiaqing Zhao (2):
>   ACPICA: Detect FACS in reduced hardware build
>   ACPICA: Allow setting waking vector on reduced hardware platforms
>
>  drivers/acpi/acpica/acglobal.h  |  6 +-----
>  drivers/acpi/acpica/hwxfsleep.c | 15 ++++++---------
>  drivers/acpi/acpica/tbutils.c   |  2 --
>  drivers/acpi/acpica/utxfinit.c  | 24 ++++++++++++------------
>  include/acpi/acconfig.h         |  1 -
>  include/acpi/acpixf.h           |  8 ++++----
>  6 files changed, 23 insertions(+), 33 deletions(-)
>
> --

Both patches applied as 6.12 material, thanks!
