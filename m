Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6788817A31D
	for <acpica-devel@lists.linux.dev>; Mon,  9 Jun 2025 09:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749461503; cv=none; b=nDS3Sx/Z285MboGIgnbG3+wGHkmSddPSwdssDbs+2reCnzdwHCnF5aLIgEdmnQm86xPvPPoXjLy6iEE4iQ+Fe3XL1aUooxJiArf+b58W45gAXKLZ0p0TchFvoEmPV82me+lOfuunyDxu3hTiBfcQmvUWdizNN9R7GDAA/61F/lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749461503; c=relaxed/simple;
	bh=zNtDPa5n/PwAJ80qPuI7OgznWoPABWfiRViVY8gCA2A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I4Qa/al+jflsDL4P7hE8+mSc2p2peROj4RpDLObDHdoCt33NIherJeCeUKjS0hoYLSKbhLz9Txjp6en5mzv6z4YmeGK+K5prtDka8Mcs/7NSvD4fC4y9W8f6iPYXb3kdQ/T2CiLLuohVNvyDFRGrfm3vChVfq1H4ky9thhKKVXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pKSWh2qG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pKSWh2qG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04755C4CEEB
	for <acpica-devel@lists.linux.dev>; Mon,  9 Jun 2025 09:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749461503;
	bh=zNtDPa5n/PwAJ80qPuI7OgznWoPABWfiRViVY8gCA2A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=pKSWh2qGfwVn+IK3t+CJQ2GsWOBOqvWhAdQk15BpeMy40zlijvYtKMgRUgJx6CkH4
	 j2Kru+F4i/1qnVWxVkUBU4kLDvIdqO97F3PdT1axjt39es+zIZt7A9W/8jCzPP8FE2
	 JQ+xuxGTfS/J7IIKm9QGPxYjjP8dzljao4V1UBkJNIwU6PfxRjrdfQF+eZBd5N42VM
	 qMEQMPhAfnRvzdK/3GjH6HHOrUGteikO4gl/PPld72nT3VKNXxhHEhNAbcsJz7fGYC
	 rCUp/v2Oi7D8JuwOTeXkmhTKAqlvc1Lsu0ItLMZSq3e5FJtTWUbPGRC88C8E+ZA95l
	 ONK+fHWvZ4xEw==
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-60be8b6f1e2so2286023eaf.1
        for <acpica-devel@lists.linux.dev>; Mon, 09 Jun 2025 02:31:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUFEflD6gS2gFvAKNuQImHuiRzVVuGCrdUqDUguwgZ0Rjqvjw/lFXej1tGKEKGW5TF9bdZ4idyY9RDhtJk=@lists.linux.dev
X-Gm-Message-State: AOJu0YxeeNJ7y6gMDJmD3QJmiDQ014W6Vum/lXBLGIdvkdwKQOLGiGvM
	TdxT+xb8BTyvp2LGBfXNDs+joA/3l1P/0TJnUIr9zL0EemSafzI6VYUinRlol//KEEiOO8U/7Fu
	78qwVE2MeBwa63oVVUsPzKSGFFS+g/OE=
X-Google-Smtp-Source: AGHT+IFYuDhhac9sF/tr7yvmttGCvHxnpq9sJAWKSYAgPWS7lSyASuhm3jm70idMIqYDbMZrow/nJqZpm9CdGlVVTMw=
X-Received: by 2002:a05:6820:1897:b0:610:d415:46bc with SMTP id
 006d021491bc7-610d4154a57mr1601813eaf.7.1749461502397; Mon, 09 Jun 2025
 02:31:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250609032839.525087-1-superm1@kernel.org>
In-Reply-To: <20250609032839.525087-1-superm1@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 9 Jun 2025 11:31:27 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iNoT79e9RRraifMY84oR8QAcSeYwk+=vaRSuB9mGmtAA@mail.gmail.com>
X-Gm-Features: AX0GCFsbyF9TF4nfYaLxr0fDuQLJ6TbH04x0LuYGlMzf0gVsYgB1yvXx2Mjd0ZY
Message-ID: <CAJZ5v0iNoT79e9RRraifMY84oR8QAcSeYwk+=vaRSuB9mGmtAA@mail.gmail.com>
Subject: Re: [PATCH] Decrease `AcpiExTracePoint` verbosity
To: Mario Limonciello <superm1@kernel.org>
Cc: mario.limonciello@amd.com, robert.moore@intel.com, 
	rafael.j.wysocki@intel.com, linux-acpi@vger.kernel.org, 
	acpica-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 9, 2025 at 5:29=E2=80=AFAM Mario Limonciello <superm1@kernel.or=
g> wrote:
>
> From: Mario Limonciello <mario.limonciello@amd.com>
>
> Early in kernel boot pointers can't be used and so %p shows up
> incorrectly:
>
> ```
> extrace-0138 ex_trace_point        : Method Begin [0x(____ptrval____):\M4=
60] execution.
> ```
>
> Later in the boot %p works, but it's not really actually useful when
> the pathname can resolve properly. Adjust the debug print so that if
> the Pathname resolves that the pointer isn't also printed:
>
> ```
> extrace-0138 ex_trace_point        : Method Begin [\M460] execution.
> ```
>
> Link: https://github.com/acpica/acpica/pull/1013
> Link: https://github.com/acpica/acpica/commit/bdc2a4e646f097b693aa60f1f2c=
4228d1e31b0d1
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

This is an ACPICA change, so it should be made upstream first unless
there is a good enough reason to make it directly in Linux.  In which
case that reason should be mentioned in the changelog.

> ---
>  drivers/acpi/acpica/extrace.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/acpi/acpica/extrace.c b/drivers/acpi/acpica/extrace.=
c
> index d34497f3576a4..36934d4f26fb4 100644
> --- a/drivers/acpi/acpica/extrace.c
> +++ b/drivers/acpi/acpica/extrace.c
> @@ -136,9 +136,9 @@ acpi_ex_trace_point(acpi_trace_event_type type,
>
>         if (pathname) {
>                 ACPI_DEBUG_PRINT((ACPI_DB_TRACE_POINT,
> -                                 "%s %s [0x%p:%s] execution.\n",
> +                                 "%s %s [%s] execution.\n",
>                                   acpi_ex_get_trace_event_name(type),
> -                                 begin ? "Begin" : "End", aml, pathname)=
);
> +                                 begin ? "Begin" : "End", pathname));
>         } else {
>                 ACPI_DEBUG_PRINT((ACPI_DB_TRACE_POINT,
>                                   "%s %s [0x%p] execution.\n",
> --
> 2.43.0
>
>
