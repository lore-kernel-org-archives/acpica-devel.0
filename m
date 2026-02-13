Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8CDB67A
	for <acpica-devel@lists.linux.dev>; Fri, 13 Feb 2026 13:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770989468; cv=none; b=OOCAllMHN+sSqZJihVY+2o4Me1vJVs+uSoveaLlOgBt/58kuadZuXs+b/UYgzfv94vQhKpz9OqGDJHBth9ctHmxl1FkkEu3y89s5CKiV4l5AIBR3HHXROR4itdJ/ga+H4doBOPADYhFdwxeaYPheYumyNgNVu7frcXQFOGQnnzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770989468; c=relaxed/simple;
	bh=wqMmN4tHpz1pEvJQ7qQAWgMQEiExFl/FmqHIqMMAv1s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FYJEsjCuEioA56pIpWt79zQPMOTbNcYPuA02bznIYiE10fFugvUqq4l0EkH7ZsBcNsz+2zhSoL4b8FTgy6OphuUOXRdJOFgE3P8Rk72OaPBdoVVJwIsHuVk7D6ocS9wUG1plP9+lIuOmrgBUiI/zHLi+uaDD1amw7+YdJn8oLhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KkQMpamR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KkQMpamR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E50CCC116C6
	for <acpica-devel@lists.linux.dev>; Fri, 13 Feb 2026 13:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770989467;
	bh=wqMmN4tHpz1pEvJQ7qQAWgMQEiExFl/FmqHIqMMAv1s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=KkQMpamRcn6B3VpTS2qZrsug8il18+/oISoNKRrYCyp/O5njP2+zQNMDs0B+8VzOV
	 G0ueyOu8eGb1IfbQwHdQznkYUsfsjhA3M6wmeWQXLT1+SWgjiruDJJHiLgTYDmEWGw
	 eRnZVogqZ3Gep5sxALno5Yhwb4DMrLWAvleITXeqm1eTLLfGmuo2o9aT+/Yoc6KfZk
	 N1plcCf864Ids87YAoXflKgjJnUA5NPoXVzXcdIuzX0elmCNwi2D3HisLjT1gtp73v
	 8/MswD9Bz1FnYKPJPphYeoTN4h+EQS6fi+5zXRkvr5Z+DiAo7EQGgBn8GnM0t/CVNy
	 4DGtwJ/h76ekA==
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-404263bd58fso2185699fac.1
        for <acpica-devel@lists.linux.dev>; Fri, 13 Feb 2026 05:31:07 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWNdNt9CNzAbJye5YbNEdefLteBkNUdha3nT7v1nteVPA94q/L+ZiEO764qo2vUpQNebX5RzyNkQdTYreM=@lists.linux.dev
X-Gm-Message-State: AOJu0Yz97VrlvHHfZUMlyeveuPgA0AIlVanr7Soux3Y4AYcpoiTADC88
	bWqVoCYXo1BYGMK9zmilCjpiw9sY6yR4F8zYEfl3UsD9DXa8DnbGfEm+XVqPhKWeszguhFg9Wiy
	5xem52jipS3Ha3w6WSyZJ9eHd1WvIg9M=
X-Received: by 2002:a05:6870:90d4:b0:3ff:48b3:30b7 with SMTP id
 586e51a60fabf-40f08aafd87mr58113fac.29.1770989467080; Fri, 13 Feb 2026
 05:31:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260201181620.4964-1-sumeet4linux@gmail.com>
In-Reply-To: <20260201181620.4964-1-sumeet4linux@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 13 Feb 2026 14:30:55 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0h_tOvLwUEkVTrcOVepFZkObRJAkgtQgjSRnfocuqFSAQ@mail.gmail.com>
X-Gm-Features: AZwV_QgnOmfGN8b-Gky2JP6yU3bWbjRmJbUS3kFSnyN3xzPtwj87PGy-uf9dMlM
Message-ID: <CAJZ5v0h_tOvLwUEkVTrcOVepFZkObRJAkgtQgjSRnfocuqFSAQ@mail.gmail.com>
Subject: Re: [PATCH] tools/power/acpi: Replace strcpy/strcat with snprintf in osunixdir.c
To: Sumeet Pawnikar <sumeet4linux@gmail.com>
Cc: rafael@kernel.org, robert.moore@intel.com, lenb@kernel.org, 
	linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 1, 2026 at 7:17=E2=80=AFPM Sumeet Pawnikar <sumeet4linux@gmail.=
com> wrote:
>
> Replace unsafe strcpy() and strcat() calls with snprintf() in
> osunixdir.c to prevent potential buffer overflow vulnerabilities
> when constructing file paths.
>
> The snprintf() function performs automatic bounds checking to ensure
> the destination buffer is not overflowed.
>
> No functional change.
>
> Signed-off-by: Sumeet Pawnikar <sumeet4linux@gmail.com>

The ACPI tools come from ACPICA, so if you want to make changes to
them, you need to do that in upstream ACPICA.

Refer to Documentation/driver-api/acpi/linuxized-acpica.rst for more
information.

Thanks!

> ---
>  .../power/acpi/os_specific/service_layers/osunixdir.c  | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/tools/power/acpi/os_specific/service_layers/osunixdir.c b/to=
ols/power/acpi/os_specific/service_layers/osunixdir.c
> index b9bb83116549..5dc960c6b376 100644
> --- a/tools/power/acpi/os_specific/service_layers/osunixdir.c
> +++ b/tools/power/acpi/os_specific/service_layers/osunixdir.c
> @@ -113,9 +113,8 @@ char *acpi_os_get_next_filename(void *dir_handle)
>                                 return (NULL);
>                         }
>
> -                       strcpy(temp_str, external_info->dir_pathname);
> -                       strcat(temp_str, "/");
> -                       strcat(temp_str, dir_entry->d_name);
> +                       snprintf(temp_str, str_len, "%s/%s",
> +                                external_info->dir_pathname, dir_entry->=
d_name);
>
>                         err =3D stat(temp_str, &temp_stat);
>                         if (err =3D=3D -1) {
> @@ -137,8 +136,9 @@ char *acpi_os_get_next_filename(void *dir_handle)
>
>                                 /* copy to a temp buffer because dir_entr=
y struct is on the stack */
>
> -                               strcpy(external_info->temp_buffer,
> -                                      dir_entry->d_name);
> +                               snprintf(external_info->temp_buffer,
> +                                        sizeof(external_info->temp_buffe=
r),
> +                                        "%s", dir_entry->d_name);
>                                 return (external_info->temp_buffer);
>                         }
>                 }
> --
> 2.43.0
>
>
