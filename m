Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792691884;
	b=N9W/Sdj/HcdS1zpHew1FAyxZSf8kSDv0+fcxwtISERM+l+uvXwUmY2Jl9q/UomrQiuGb
	 BL1vqrCrQBL/rQTRt0q81YU5AfNVaWfHbDYlXzn2mR6hFSfEkYh1JjSOUsQGW4vEEOou2
	 oUT/W2MLgxNeMgJWxJp62VtDEZX4ZB+R/TMi4yDjH0RQQIL/yOttS6qylwJ0JVxV7OBDS
	 uIGQS6xion05/rizEMmSXksNkjQ26FIjmpWls2Es4YNYyC9rfQHtCbszQM170uyTCDthZ
	 Lymj5TNGgm4V9HGi0V0L+0rPE/SfzLVGIyIKPxJz9vJqI4WHYFHcQVIa7PyMlnVTT7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792691884;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=n1REvRKYYNfK5I+aUVJkrK0y0rIac5QSu0xgyudqYaQ=;
	b=ZRyHhnIcj8qSyoc/4rNEzyRlePAhgPgT96t4sXvHKlTu6ehrjmlDohtMHQp6yhxxW8Wk
	 s0KU1BKn4pp23lJsLm4NsM572FrTFDW7SDmxoCP/pR36GWChc6BjHGKG6qrauThP0ttF/
	 CChcJ5etfbZRpGWc0HGvj2QvI/cx7G4OapbiZauhrTmAt73hj6yMUpSpwDDphSE2e69Wz
	 vA4t4O569VXsXYyn02VWtEC6cSZddta/ZMv0rJDxg40ueuWvN5lyiV6w8cP+QojOgkeHQ
	 aYsvRCpGnChLBPfYEvLsJ+zcYE87XyzXkJu7SW3qwO4W2WQvM+12eHHfDBNlFi5v+Cw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ESPLJ8uy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AAF9606A321
	for <acpica-devel@lists.linux.dev>; Thu, 22 Oct 2026 17:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ESPLJ8uy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 432EE1F031F3
	for <acpica-devel@lists.linux.dev>; Thu, 22 Oct 2026 17:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792691883;
	bh=n1REvRKYYNfK5I+aUVJkrK0y0rIac5QSu0xgyudqYaQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=ESPLJ8uyn9I9Q8vwd0wftJM/00hPrIbl0LqcSweUdd9MNDyyY2z3cATHvF2GoN+AJ
	 JolU0v0O8/StGNwXLF9xfJMoMyA5fXGyLr5BHCM9gr4WPadC9qWc/rFh/LLwqZDL88
	 PY9kYsyM1a/a5b5YDekHDeHF5aQ4D/iRrF/A4wJTGDhZmr05fJXePpk85nWKUWf4Cs
	 5uxIIogHSGsYqvhE9XGaREvJJUVDFt0X2n1jkRdmGt0Knm5Ei0RoRdhQlXYolVTe+c
	 AsYmUduLKfMy2GnO0W7i7RGONQ0rPH25FD3922dA6l6IjhtQLIUpchvr52QOl4t+ay
	 s0d4PsRVFbxbw==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5ba36cc21cdso2557047e87.1
        for <acpica-devel@lists.linux.dev>; Thu, 22 Oct 2026 10:58:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxZRYc1ne8jEGymTY54tgnsxnjGiv1DiiFNMTLCg36/fLqGdZCqCmdwLOCgMT3C+y6b7se9mceGy8IoDLY=@lists.linux.dev
X-Gm-Message-State: AFq9FYJ2EsFc1XtmjLAo+Ml9RRmPwX0z0LvEccAB/zxGMlz8wIirdH6B
	TzTdo5m9xxu3FgnU2uBiiajGBuKDUksfW9V9z+3JICtywduck2XsISl6yMqJqFTfR2bKgPOmlku
	xpHYiw5DNW2ws7tqVZZsvh1tmelStBy0=
X-Received: by 2002:a05:6512:138a:b0:5bc:b67d:58d0 with SMTP id
 2adb3069b0e04-5bfa1bee863mr2387595e87.24.1792691881611; Thu, 22 Oct 2026
 10:58:01 -0700 (PDT)
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Post: <mailto:acpica-devel@lists.linux.dev>
List-Help: <mailto:acpica-devel+help@lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:acpica-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261018122220.678822-1-aliamemis@disroot.org>
In-Reply-To: <20261018122220.678822-1-aliamemis@disroot.org>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Thu, 22 Oct 2026 19:55:41 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hke5wNJSJvAmiA3ON4yPXcGL=v2n5ev6=MZuVs-=dSPg@mail.gmail.com>
X-Gm-Features: AclHuK9EPLLPC_-L6-IZdNf5QI0rsgLXOu6t35sNCcJB1-f2gYVIoB-IIxp3uJY
Message-ID: <CAJZ5v0hke5wNJSJvAmiA3ON4yPXcGL=v2n5ev6=MZuVs-=dSPg@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] ACPI: Serialize battery, INT3403 _TMP and ideapad methods
To: =?UTF-8?Q?Ali_Ahmet_Memi=C5=9F?= <aliamemis@disroot.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Hans de Goede <johannes.goede@oss.qualcomm.com>, 
	Rong Zhang <i@rong.moe>, Len Brown <lenb@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Ike Panhc <ikepanhc@gmail.com>, "Derek J . Clark" <derekjohn.clark@gmail.com>, 
	Mark Pearson <mpearson-lenovo@squebb.ca>, Armin Wolf <W_Armin@gmx.de>, 
	Charis Stratakis <c.stratakis@proton.me>, Avraham Hollander <anhollander516@gmail.com>, 
	=?UTF-8?Q?Jeffrey_W=C3=A4lti?= <jeffrey@waelti.dev>, 
	Rick <rickk1166@gmail.com>, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, 
	platform-driver-x86@vger.kernel.org, acpica-devel@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 18, 2026 at 2:22=E2=80=AFPM Ali Ahmet Memi=C5=9F <aliamemis@dis=
root.org> wrote:
>
> On ThinkPad P1 Gen2 and P53, INT3403 _TMP switches the EC page selector
> without taking the mutex the battery methods use.  On some Lenovo
> IdeaPad and Yoga models, the battery _BIX and the ideapad GBMD take the
> EC mutex and a serialized method in opposite order and deadlock until
> an AML mutex times out.
>
> As discussed in [1], add exclusive variants of the AML evaluation
> helpers and use them for the battery, INT3403 _TMP and ideapad methods.
> Patches 2-4 depend on patch 1.
>
> Changes in v3:
> - Also evaluate _TMP exclusively where int3403 and processor_thermal
>   probe for it
>
> Changes in v2:
> - Merge the follow-up series [2] and drop its EC query and UCSI patches
>   until they are shown to help
> - Add acpi_execute_simple_method_exclusive() for _BTP and ideapad
> - Make the helpers wrappers that take the lock around the existing ones
> - Join lines up to 100 columns, add a Link: for Suggested-by:
> - Drop Hans' Reviewed-by from patch 1 due to the rework
>
> Link: https://lore.kernel.org/all/CAJZ5v0gS4agVUkCO6M=3DVW4Wi2y1-s+k23bpz=
mX9aAZ0Rsv4z9Q@mail.gmail.com/ [1]
> Link: https://lore.kernel.org/all/20261014190544.150093-1-aliamemis@disro=
ot.org/ [2]
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D221065
> v2: https://lore.kernel.org/all/20261017130652.318778-1-aliamemis@disroot=
.org/
> v1: https://lore.kernel.org/all/20261014132703.93355-1-aliamemis@disroot.=
org/
>
> Ali Ahmet Memi=C5=9F (4):
>   ACPI: utils: Add exclusive AML evaluation helpers
>   ACPI: battery: Evaluate battery methods exclusively
>   thermal: intel: int340x: Evaluate _TMP exclusively
>   platform/x86: ideapad-laptop: Evaluate ACPI methods exclusively
>
>  drivers/acpi/battery.c                        | 12 +++---
>  drivers/acpi/utils.c                          | 41 +++++++++++++++++++
>  drivers/platform/x86/lenovo/ideapad-laptop.c  | 12 ++++--
>  .../intel/int340x_thermal/int3403_thermal.c   |  3 +-
>  .../int340x_thermal/int340x_thermal_zone.c    |  6 ++-
>  .../processor_thermal_device.c                |  2 +-
>  include/acpi/acpi_bus.h                       |  7 ++++
>  7 files changed, 68 insertions(+), 15 deletions(-)
>
>
> base-commit: 24a19b953e2a3d0ea5a8c4951a0ab8f32720c907
> --

Whole series applied as 7.4-rc material, thanks!
