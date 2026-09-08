Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6897538D64
	for <acpica-devel@lists.linux.dev>; Tue,  8 Sep 2026 12:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788869307; cv=none; b=Bq8hQOCOt2FTRJaIbeornYk3l8D19woLr2Ta5xn8g6IaFTDULPOGfYIPxPl0xl+9lwi582B/z4F6USOBcDmjXLBCSPtarSD3tslgBy4YkGLRbQwMhmVtpqgGzRumDZ+a4cfBLup8TOm8tTY+7y6CjjHjR/L2Mu+0/Wnkp0b7wWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788869307; c=relaxed/simple;
	bh=JHMWfsW5CyNQs5sLAnfEG7ermVzW+vcIzePTWPMKrvk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XAt6EgOe9jpRJpJbOClEBa9fXGKluC1x98c7ItStozlZw2mj0AAOI2pHw3svB6j2KBVd4b9P/+uaS4L8QoUd951Sn96F0hfu+Ydn2Ps05mcrs5JYLiOpR6pgO90c3vET23DCDlr10Dy0OoI/ewuySlkJx3+TmTn+CVcDizJwvAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YgPS9ksB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YgPS9ksB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D21561F00AC4
	for <acpica-devel@lists.linux.dev>; Tue,  8 Sep 2026 12:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788869292;
	bh=e1BflZLG/y41ig4kA0DqIwNP4dQBVnCs0NJUnHjdC2Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=YgPS9ksBdXP+/aHZxVGu7xhv26E/3Yo5qgHJEgn1jzHlVjLU/W4rUjBcQ8VNG509A
	 FWliMWAyhPOQMol6ax30dbPS4lXCc8ZcpVOROjKPRBcIe0xqzEJxpfOQfWzToIo7XI
	 PaE6n0yVOga5QS28LinH+062Im9icyhoW44v5KkMIVeMhcbe9YTPpXjs1KTHOcPmn3
	 NKK3QW165n1UQ1fFgZlIfwkKVkohD5DFfDeX81hGqIKhZ+lp/1GKzeIWo81rfUO9dp
	 ZeqnMTyx9DEKTneLSByLCz8QEh4IVrbUQyGZg0h48/q4p3Ry89aFhuJX5dddJGoHp+
	 ErVQ6oalKVtyg==
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-5bfa4c51c2aso1839199e0c.0
        for <acpica-devel@lists.linux.dev>; Tue, 08 Sep 2026 05:08:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzhLcioo9rWjVN1gj/uJZ1rnFEuxVEV4W9h8c8YPV19uYybcBjutFjhaXQ5owPmmqFaWlMS/3mpAnjLHAg=@lists.linux.dev
X-Gm-Message-State: AFuF++kcwk/v/k1jLnABFbo1veqjBP4qvL1IvVnIhUAk6qQlb+Opl7YJ
	tReeOE52jcbo/ydrYM10s9Y3MuXGYaUDETUhkaL6FkcUcZWqgZdVhT3Vh/4etKwiPq7SJJ4d6T1
	HP/DpOjVmiWioiHqkbaRjtrZJLAEzoH0=
X-Received: by 2002:a05:6122:32cc:b0:5bd:aba5:3830 with SMTP id
 71dfb90a1353d-5c7ed0c4c20mr15328463e0c.0.1788869291010; Tue, 08 Sep 2026
 05:08:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260908043124.53175-1-mario.limonciello@amd.com>
In-Reply-To: <20260908043124.53175-1-mario.limonciello@amd.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Tue, 8 Sep 2026 14:07:01 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iMjdmjEoHFB8W3Do_qqLqfuJJYA-R_rGG3qhZBEekuiQ@mail.gmail.com>
X-Gm-Features: AcwNN1WaDQywLkU6MV1NZpHwLD3dHl8GMTPwTm6V5Fc_2wQqMaGrHpaJvnSmK3I
Message-ID: <CAJZ5v0iMjdmjEoHFB8W3Do_qqLqfuJJYA-R_rGG3qhZBEekuiQ@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: utils: Ignore leading root scope prefix in
 string _UID match
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Saket Dumbre <saket.dumbre@intel.com>, 
	Len Brown <lenb@kernel.org>, 
	"open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <linux-acpi@vger.kernel.org>, 
	"open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <acpica-devel@lists.linux.dev>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 8, 2026 at 6:32=E2=80=AFAM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> Firmware may express an ACPI namespace path used as a _UID with or
> without the leading root scope character ('\'). For example, an AMD
> IVRS IVHD ACPI HID device entry may carry a character UID of
> "\_SB.MHSP" while the corresponding device's _UID evaluates to
> "_SB.MHSP" (or vice versa).  This semantic difference is due to how
> Windows PnP enumerates and uses devices.
>
> acpi_str_uid_match() compared the two strings verbatim, so such
> entries failed to match on the UID even though they refer to the same
> object. In the AMD IOMMU case (get_acpihid_device_id()) this caused
> the exact HID+UID match to be missed and the code to fall through to
> the HID-only path, spuriously raising a FW_BUG.
>
> Skip a single leading '\' on either string before comparing so that
> paths that differ only by the root scope prefix are treated as a
> match. The integer _UID path is unaffected.
>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v2:
>  * Add kdoc
>  * Make sure the string is at least two characters long to normalize
> ---
>  include/acpi/acpi_bus.h | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
>
> diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> index a10a591c18b23..cfc3c8a21cb8e 100644
> --- a/include/acpi/acpi_bus.h
> +++ b/include/acpi/acpi_bus.h
> @@ -826,11 +826,29 @@ static inline bool acpi_dev_hid_match(struct acpi_d=
evice *adev, const char *hid2
>         return hid1 && hid2 && !strcmp(hid1, hid2);
>  }
>
> +/**
> + * acpi_str_uid_match - Compare ACPI string _UID values
> + * @adev: ACPI device providing the primary _UID
> + * @uid2: Secondary _UID string to check against
> + *
> + * Returns true when both _UID strings match after optionally removing a
> + * leading root scope character ('\') when the string contains additiona=
l
> + * characters. Returns false if either _UID is missing or differs after =
the
> + * normalization.
> + */

I'd rather update the existing kerneldoc comments of
acpi_dev_uid_match() than add a new one here.

You can say something like this in there:

"If both the UID in @adev and @uid2 are strings, they are compared
after optionally skipping a leading backslash ('\') when the given
string contains additional characters."

>  static inline bool acpi_str_uid_match(struct acpi_device *adev, const ch=
ar *uid2)
>  {
>         const char *uid1 =3D acpi_device_uid(adev);
>
> -       return uid1 && uid2 && !strcmp(uid1, uid2);
> +       if (!uid1 || !uid2)
> +               return false;
> +
> +       if (*uid1 =3D=3D '\\' && uid1[1])
> +               uid1++;
> +       if (*uid2 =3D=3D '\\' && uid2[1])
> +               uid2++;
> +
> +       return !strcmp(uid1, uid2);
>  }
>
>  static inline bool acpi_int_uid_match(struct acpi_device *adev, u64 uid2=
)
> --
> 2.43.0
>
