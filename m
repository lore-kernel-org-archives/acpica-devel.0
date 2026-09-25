Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB024D9F97
	for <acpica-devel@lists.linux.dev>; Fri, 25 Sep 2026 15:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790351772; cv=none; b=rJ0LUxMkFLpRm2Jm6iuEBylwrn47VjATmweYWPrUOWTfAkk2vvCKgVrHX8mqp6Puwi10fluquu6kTTZFMagEGls7iCnujggedCdc5YRZQdSW0fDts7PFC5OGGCj9S2oK0OsHRO4EFBh3qfqSKcQuMp64dDdz0vxE0BjVfvlSykk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790351772; c=relaxed/simple;
	bh=WK2Kb4trUvTX1tZh1hW/0OTwyC/ht0Q82YI7Tbtm118=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G4UCS+nlN+X5hF15qBtNiBeboHVWZXAiiOa7emFbVx2l294K248ImZKcjBpjT2H0YMQxNd16ulk4zTiNZyi8G4FIaM6ei7nUog3aBpeDCXP5N2E54DtbO+PdGakRggG7gTGrSqeX0V5V5/EFbJAI/y9XVmmUyGD+BO43mW38+7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TRQIiyPr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TRQIiyPr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E303D1F00898
	for <acpica-devel@lists.linux.dev>; Fri, 25 Sep 2026 15:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790351770;
	bh=+nYF4EIO+Bq9XVY57tp6rBN3ps4p8mApKL9MWsAAIVI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=TRQIiyPr+VhUt6Iw7WWjD2WcJeH+54GnshdwqdnDlujfC9ZtyTFITpP2i1zrVoWzv
	 h/T9rWW8YpyBLD46w5soan4ru6XJGpILGIIjFQ9BleEiekB58Cc9fg9GIMRO4YLKMW
	 YBECG7TOpRgV29Mmu+nEMYYVEN7TZmCzUG1xjjPb+IMbI9Iyu7yB6QgxchDLZkoCP9
	 OemPp+YxHlNnD+B5kfCARiI5kp0UXT4Y6M22bQ9uMY0GGGEIpZCO6ahy9MPSNNIb2c
	 zRd1fqzIWQ+8JMLZn8h6KVaTbGYAotLcDYGYPVHNNs9bIQu7LhaX2Bmo5fhkHCy4w9
	 RHfq/haD+ymrA==
Received: by mail-lr2-f35.google.com with SMTP id 38308e7fff4ca-3a49bc59559so7485671fa.2
        for <acpica-devel@lists.linux.dev>; Fri, 25 Sep 2026 08:56:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwqDnFAwwSfSOJwgSRrwGdu8R+bylDl473EBXZEYI096BRSsB7W6HRZRXeRH32CMrU0lk4Dv5F1j+vZab0=@lists.linux.dev
X-Gm-Message-State: AFuF++lamFWWO7jQsuh4nw6djHUQ+cd/fCXVpzLP9kibRZtpvLsz+s6Z
	ksxSPc4+jwljzhckcu+0dl6sCLWt21omVC7D6OvW/+rwNvJRhv0N7B8V9ewSNKTiRAMCSgbcYEy
	JhtVSwqzMI9pijPsxzA0xqruzlLNGcVI=
X-Received: by 2002:a05:651c:2107:b0:3a3:314:8c8a with SMTP id
 38308e7fff4ca-3a64c7a178bmr6034361fa.14.1790351769357; Fri, 25 Sep 2026
 08:56:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260925155220.4110300-1-mario.limonciello@amd.com>
In-Reply-To: <20260925155220.4110300-1-mario.limonciello@amd.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 25 Sep 2026 17:54:31 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0j99C7=w-umijjqL6dVqpWh1WSq_iHfk44asG9GLLAhxw@mail.gmail.com>
X-Gm-Features: AclHuK8-EoxphECUkCg4_AyOLQVXZvfr-jQog0VJnfosUnqG8DMaufA2TNyKFQ0
Message-ID: <CAJZ5v0j99C7=w-umijjqL6dVqpWh1WSq_iHfk44asG9GLLAhxw@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: Add stub for acpi_find_child_device()
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: rafael@kernel.org, lenb@kernel.org, maciej.wieczor-retman@intel.com, 
	pawel.chmielewski@intel.com, Arnd Bergmann <arnd@arndb.de>, 
	Liam Girdwood <lgirdwood@gmail.com>, Peter Ujfalusi <peter.ujfalusi@linux.intel.com>, 
	Bard Liao <yung-chuan.liao@linux.intel.com>, Daniel Baluta <daniel.baluta@nxp.com>, 
	Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Vijendar Mukunda <Vijendar.Mukunda@amd.com>, Kai Vehmanen <kai.vehmanen@linux.intel.com>, 
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>, sound-open-firmware@alsa-project.org, 
	linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 25, 2026 at 5:53=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> Provide a NULL-returning stub when CONFIG_ACPI is disabled so callers can
> be compiled without ACPI support.
>
> Reported-by: Arnd Bergmann <arnd@arndb.de>
> Closes: https://lore.kernel.org/linux-sound/20260925131104.118993-1-arnd@=
kernel.org/
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v2:
>  * Move to acpi_bus.h
> Cc: Liam Girdwood <lgirdwood@gmail.com>
> Cc: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
> Cc: Bard Liao <yung-chuan.liao@linux.intel.com>
> Cc: Daniel Baluta <daniel.baluta@nxp.com>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Jaroslav Kysela <perex@perex.cz>
> Cc: Takashi Iwai <tiwai@suse.com>
> Cc: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
> Cc: Kai Vehmanen <kai.vehmanen@linux.intel.com>
> Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>
> Cc: sound-open-firmware@alsa-project.org
> ---
>  include/acpi/acpi_bus.h | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> index 7dbe5d42c67e8..b7771b4f36c80 100644
> --- a/include/acpi/acpi_bus.h
> +++ b/include/acpi/acpi_bus.h
> @@ -954,6 +954,8 @@ u32 arch_acpi_add_auto_dep(acpi_handle handle);
>
>  #else  /* CONFIG_ACPI */
>
> +#define acpi_find_child_device(...)    (NULL)

Well, thanks, but I'd prefer a static inline stub.  Any issues with that?

>  static inline bool acpi_has_method(acpi_handle handle, char *name)
>  {
>         return false;
> --
> 2.43.0
>
