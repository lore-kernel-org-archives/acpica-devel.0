Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4AA3A4510
	for <acpica-devel@lists.linux.dev>; Fri, 25 Sep 2026 16:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790354864; cv=none; b=Mil+/GRJ2af/L7RisBH44719SPJga2/GVzPGRAxp5LXbtf4eWF/Mo4CEcgy+YWF+qDlrRlkUzVahmKogKe+vjRLoUkrG4T5csu6kPPUDkVS7jii7pLz8+xtS62zdke2ntke9H+TCw/zszpeHpJZKrQDaHlHBuFaZVI6xm1zMTQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790354864; c=relaxed/simple;
	bh=yRNP7JJv8DMYuaMMrI3ydSH+CiAcUV1fiK68z0Rucrc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=upJGPF28RSNAdOa4DSwPQNzosi89TwQ8Vae+5qYeMYrZIA9SUUPXqRwbdh4rfhIXrkDHXELhicMVqyUKXO1QPirLKUKlub8VqJPW40EK7xA8JLk5imY1pPoHAenUxC6gHpzuex51Yf61w9AphiniQ85sMLAyi3HjD76dmzc/C7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YTmZ5eGT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YTmZ5eGT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DCEA1F008A0
	for <acpica-devel@lists.linux.dev>; Fri, 25 Sep 2026 16:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790354851;
	bh=iim/I3m/pOfA3+/sEqVuINrhYNfhRuff5X8WU9Eq7f4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=YTmZ5eGT7ienYC4lxZLBjuZcEysyr/QoeaALVmPUPJ47OgdrvD9uydSMHj1TPFNNr
	 N09tQONS3+FF8ZtQIr9uP6EMPmrc27WihNlic7X88JyYug+ueZXTyT02unGiioF9Px
	 Xqx8VcCGQ6tlps1PqcMJu0NvWBoK1kplkwL5+UworeVrFOn81xgKsEvAiUuVsXhaSS
	 akUphil96Een5DVhXIHKYYSbB5+H8M6fiAczGUCKXLKT2ySo3tL0fjYWSB2YFYOUf6
	 hgEiNwYonLPKYi701HV4Pzmsdov5OVLlOSkhCPgm1i6lV4elVkFFV4lbEBSaWzzgT2
	 KHaEq9oreOApA==
Received: by mail-lr2-f34.google.com with SMTP id 38308e7fff4ca-3a652b710a5so6118141fa.3
        for <acpica-devel@lists.linux.dev>; Fri, 25 Sep 2026 09:47:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzQRuFu7HBQkHHjJCE6iqAnWQub5I31eAqtUWERdhv103FHsG0Prn+WMgrZN5rmb+pvzf88QHKzRUtWaEI=@lists.linux.dev
X-Gm-Message-State: AFuF++k+rXRLaVWAQAqMpa7ARB9HgpIK83OwWS8YUMsQcTrVV1/uxqzf
	eolHWKb9FhrXUuzP9AnmK5duLW9G6SpF6FwK99fh8o+L4IoyB591qdiMdLZaiVJgOJKLi+ODzfm
	FCg/D0bK+mnd6s1mjQ931wqsB/IPBJGc=
X-Received: by 2002:a05:651c:41c8:b0:3a5:b50c:43a0 with SMTP id
 38308e7fff4ca-3a63dd6254fmr11868391fa.5.1790354849626; Fri, 25 Sep 2026
 09:47:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260925162628.4142365-1-mario.limonciello@amd.com>
In-Reply-To: <20260925162628.4142365-1-mario.limonciello@amd.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 25 Sep 2026 18:45:51 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gOVtss255tHW_rR3=Rj6YCWk4sPDs4XwsuasfemwODkw@mail.gmail.com>
X-Gm-Features: AclHuK9wxscB15bVOwor1gAh2AHWU4bYe3jFfO0hSArQkqVd11eVNB4jHYCO2WM
Message-ID: <CAJZ5v0gOVtss255tHW_rR3=Rj6YCWk4sPDs4XwsuasfemwODkw@mail.gmail.com>
Subject: Re: [PATCH v3] ACPI: Add stub for acpi_find_child_device()
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

On Fri, Sep 25, 2026 at 6:26=E2=80=AFPM Mario Limonciello
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
> v3:
>  * Use static inline instead
>    Note: this relies upon
>    commit e7280ab196ba4 ("ACPI: bus: Use acpi/acpi_bus.h without CONFIG_A=
CPI")
>    when cherry-picking to sound/for-next
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
>  include/acpi/acpi_bus.h | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> index 7dbe5d42c67e8..a755b15af9db9 100644
> --- a/include/acpi/acpi_bus.h
> +++ b/include/acpi/acpi_bus.h
> @@ -954,6 +954,13 @@ u32 arch_acpi_add_auto_dep(acpi_handle handle);
>
>  #else  /* CONFIG_ACPI */
>
> +static inline struct acpi_device *
> +acpi_find_child_device(struct acpi_device *parent, u64 address,
> +                      bool check_children)
> +{
> +       return NULL;
> +}
> +
>  static inline bool acpi_has_method(acpi_handle handle, char *name)
>  {
>         return false;
> --

Applied as 7.4 material, thanks!
