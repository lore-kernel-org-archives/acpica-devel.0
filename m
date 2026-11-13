Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.174
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794569361;
	b=gbRk0pstNq7AwU6LS6FFJ0ODH06im7Q9FLBG4NfIqxYadIzbhLsx/TmwwkHmj6U1MwjQ
	 PuyT15p/UJnxJyVZH+ey1hQeZlpwCQZGDKJO/6AVaGmHcOp8k4IRG1cPWDTlaaeTX/1Xj
	 jSVpu5QEbbTerels8qjcfDBtVaJf7S4cj7Dqy/HnMKdcOddaO6DbgKgYI4tvp8vGuF9S5
	 DsZF9J9sFOkyz8tuRTCEkw0iaEooZaD7sAhlia37LTkR0EZN43Zv3AlucXnOsOt91iTNP
	 HxXMnR2wSFRaeq538uACUUaEMrB4hCFIn9t2nDubAerlW+DGUlL8+fbvGwXg1eG24KA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794569361;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=y5+YZN4kuYSMz/+TK8p/WErG9vs4h43P03FRIOTzw1c=;
	b=EOPvrOjeIH7TyqfZZ85Sx1A3thg4OU0xsUuE5rwRs1TN5UzN1m1sD8zBz5ynBllV3P6c
	 GzIpBYKMTKs8kjvmW3In+z5fh1zy9GaOBoeIsJmj9oFQjUvPON/LQjtwKzE15ykaryL+d
	 1Q33oceosqA/iXKGqoNc0ew07CE7XN2k6l5lbyUOoQUjz1X/qzS8Jzc3WojIgZm4iaP4L
	 LEGwVhHUgsg+te+VtfS/fQfGOo35fhOiAEO7bh5Vw755Z0OUyFJ7SWWo4rbHDhJCzk4cR
	 CQ/CB5sJBhuNIzJ7zfBRV+m+2IOZf5Pr8oCOrFNa8HhyI0KTmFg9KarOT8UTHQ3Ev0Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XI5axoC4;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.174
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0B2606A880
	for <acpica-devel@lists.linux.dev>; Fri, 13 Nov 2026 11:29:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EA0B2606A880
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XI5axoC4
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-8b335eeb340so7576727b3.0
        for <acpica-devel@lists.linux.dev>; Fri, 13 Nov 2026 03:29:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794569360; cv=none;
        d=google.com; s=arc-20260327;
        b=YEvVFPR4jCTLZxyo9BsNSmjSNe21YW9fLfN2JIyEmepc7U/39yJ3VjRBlOEXt5ch2Z
         MWWLsIqQpfYe/mOqIAW04B03HtwPeGcfbYKdr/MSYaK9Xx4PBDk1SG16tN4KpbNeovYe
         EE/MvjctYX8skqaa9iyRGSDj0WdEXSzGRBBp4zEdkfV11gRiDQuLAjmPvssaN0mGesy1
         ixwVfZZWgJnhkGNT5iVCXhb7zpkZlOKVuNtSUbSDodLZkd9TvMZWJOoQPfwUV1MdmwnA
         hrZ4o6j/fRw9nxQci7sR0DWO5FNjB5yrOTB0jcdeWPupTjvjmAoNfqHaflHfS5F4TJYK
         ohUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=y5+YZN4kuYSMz/+TK8p/WErG9vs4h43P03FRIOTzw1c=;
        fh=EC6ODMIs7bX5KwYq+W51qSmpP4XpPcmh47JxZGkxHcc=;
        b=BIMXQjToTp1/CSK9B5CVHmBpytBSVCuZWtfl7Jc6gpa4jto7eaA6iZ+v9p4HbmxFU6
         kn+KEvWLnnsdWW6H/PqOZbdNaT+GQXK4XJoJprTXo9gp7U4Yl4cWeSzjtOs7+poVQOFL
         jspyjRl4fHOXIScEz4l2q/fYf7XQG6nRA4aU7snsCw2XhPy/Q2A/Qu5PEy7GU7zmkGmK
         q/w9XrJOTJkMUj3LPp94H1VshqrqYPtn7e0YWx5pbiCaN+55qK/SN0CKOiySaOJd7LCw
         9ymRjcPC32c0UtkXCituBAN9CiQ32LutJEiQV77teLcnG4a+wr7xGnpqMMgrlcwwImsy
         YOJQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794569360; x=1795174160; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=y5+YZN4kuYSMz/+TK8p/WErG9vs4h43P03FRIOTzw1c=;
        b=XI5axoC43ytaiCApCq4EL0sO2Cl7cHvVRQzDmIp7qmonimQrfjqJffdK0ZhUpIHVqa
         a/TX9zTMZ5XNzfr/0DZJBhZC1BuoZmmUrau+Tjk+4QVryGIXkQDQAA8mVYftjmWexExQ
         eF226FkjaFHQ+nlWDstbatIm98dZD+DSiSNCEOYC9hcnEOnhbjEBc8Sw/2iovLSc4aYj
         kYUhsZpvrIz/JTxsw/8C/CrietM2YdLnl5IuyOCUE1khjgyzv0EMOYwpZSGrYZkvQ2a7
         CwPhjKZbB0vLFj84Aze8umBskT2E/zquMw5abPYGJphiU4F3kZ9Duf6LHMiVGryAzaiy
         qZjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794569360; x=1795174160;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=y5+YZN4kuYSMz/+TK8p/WErG9vs4h43P03FRIOTzw1c=;
        b=coCs8nrlm/RXpwEygaBIPKdE7nMqaX8tTRJgDygV5mK2YG8WhzUfYG2M94wnIrQgHe
         qYFoedxv0exjV6ai5gQlqXVO2jTrJawtm2qzgNqCYvajOAhEXl6CDceRioeaq9T+NJrL
         SJep0ZLZZrwkO4gA8z64/m0nygBloEvoShM85FE0YE+LogqVisTsRkiArtMUj2FCbVrs
         exVGY+IoFrZ+ak67a9L1lsAYBTAsS2OZxauIISr84LtDQ+6aWuKgXZcy6jtQqaMazJTe
         ZhQtqVADEVT3yK6YXCvptx3Hlqq6GXMAxledHlGyBOG9+KvZgkvJ92z9/3Rv5kXrz++j
         D+jg==
X-Forwarded-Encrypted: i=1; AL+hErG75Q57dSgdEvdJTYPQLZiCaYYqqDLZAf6mECM9zbUMHxZqSDW+MvgvAgInYOkZUUj02R20cAWQG+hagac=@lists.linux.dev
X-Gm-Message-State: APuU4Z/EvZ23bTiU0USF9MDMAmmnLKLECqcCu93szF154iLWJM1RgjCa
	r6scqtlCaByDvl2H6u6bBr1mVF+PbiXsHCe0altIfFmKTEn1UPJP2SuuJNGJR/icarVRIDLbAwV
	Z5O5214l+mJF1nqVG12hAsmYg1EAJkvo=
X-Gm-Gg: AYBFou0dMiYgXikHMB8xGiLLf3TWieC40HsbzoQv7fwWegtKd606C/ZLyJTWPkIUcxn
	11WEutler0LAUQ2qCLqXj62P8dDnx2jeMBh5HB98WWnOz0ZiDc8fHhdu2SkLfiblI9m1TZmXVPP
	k8+lt4dmpRMB9dLhZHqR4qa4EHSXn7WHAf69bXyzFn7MT8kKf4nDUSKSGechBhdeKYWIUepKdnW
	D/xq4hJ5tM6yec8vukmvI8d6OXGfi2JqqCGml+FdI/Vg+EA1vkoioPx8eX3fbjIhrpi5/iLI05j
	3jeu4ibA3s+DW7wRWBk+tER1/h4MFvqp4j5yfBo3qR7I0F+dRT3VWDDoSv85ovtRe+mtej12dSa
	8iCzHG8GPEcaqEerP3+RUrsQsmqGEsi5yfQhNh9DVkB9wOIgi8x4oaSzkRNtrNDL9TNf/23gVXm
	KA41OwwTS0AoU9WmL3YBPI4jKztS+5k/SEPDdoYrlkm5GNHTL+FmBXfCMtI1jmFd5pvtqaw0I95
	FI3zuuB1/yxuVM3Y0QZuietA5zt/gv0BEgj+f4yBRWnRkJ3WTbH9rB9Sb3biejD20sWtGZCNQWy
	uKoH2U4=
X-Received: by 2002:a05:690c:a05c:b0:8b3:b952:39db with SMTP id
 00721157ae682-8b4aa239ca9mr10091467b3.23.1794569359843; Fri, 13 Nov 2026
 03:29:19 -0800 (PST)
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Post: <mailto:acpica-devel@lists.linux.dev>
List-Help: <mailto:acpica-devel+help@lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:acpica-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261113104218.32566-1-farbere@amazon.com> <20261113104218.32566-4-farbere@amazon.com>
In-Reply-To: <20261113104218.32566-4-farbere@amazon.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 13 Nov 2026 13:28:42 +0200
X-Gm-Features: AclHuK_l7pbfT9WtHP2ajmhTcb5eCdGVukVYrSxkY0jj7LNvZaOiW8nn193laj0
Message-ID: <CAHp75VffC0+So4CErnh7eKX6_uMPqBJ8Q7Jz5yYZ2GSJv92amg@mail.gmail.com>
Subject: Re: [PATCH v6 3/7] ACPI: APEI: GHES: remove unused ghes_{,un}register_vendor_record_notifier()
To: Eliav Farber <farbere@amazon.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Hans de Goede <hansg@kernel.org>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Armin Wolf <W_Armin@gmx.de>, Sebastian Reichel <sre@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>, Tony Luck <tony.luck@intel.com>, 
	Borislav Petkov <bp@alien8.de>, Hanjun Guo <guohanjun@huawei.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Shuai Xue <xueshuai@linux.alibaba.com>, 
	Len Brown <lenb@kernel.org>, Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>, 
	Pawel Chmielewski <pawel.chmielewski@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>, Breno Leitao <leitao@debian.org>, 
	Terry Bowman <terry.bowman@amd.com>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, acpica-devel@lists.linux.dev, 
	Andy Shevchenko <andy@kernel.org>, Kai-Heng Feng <kaihengf@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 13, 2026 at 12:42=E2=80=AFPM Eliav Farber <farbere@amazon.com> =
wrote:
>
> Remove ghes_register_vendor_record_notifier() and
> ghes_unregister_vendor_record_notifier() along with their
> EXPORT_SYMBOL_GPL()s and ghes.h declarations, since there are no
> remaining in-tree callers - all users go through
> devm_ghes_register_vendor_record_notifier() instead.
>
> Inline the register/unregister calls directly into
> devm_ghes_register_vendor_record_notifier() and its destroy callback.

I'm just wondering, if you use --histogram diff algo when preparing
patches. I think it might look better for reading with that being
provided.

--=20
With Best Regards,
Andy Shevchenko
