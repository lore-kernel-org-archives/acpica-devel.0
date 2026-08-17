Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD703C661A
	for <acpica-devel@lists.linux.dev>; Mon, 17 Aug 2026 12:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786969127; cv=none; b=u/poSD793PEZKQ0AVVIcwC+LHJQ1e8jNP5j+wtDQEgMi7YjkxB/mDPghG8wwWEf2Yx/EEDVmG7iXBVSMt5WsmhawTQe6oKhwkQ0Ee5nn1XPEsl2bBkLPueFdBnDuAuR/J1aZ7cUSShzBy53kPbhPR5w88oz/DrqLm6CVHQU/LQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786969127; c=relaxed/simple;
	bh=kAeJX9Uec/6XKxjU9aI3iiCC/zao+WP5C5A6QEo6DTA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OERq7MXMuXZn2Vqw961ne1aGGma304+XQ+mnItjSINJPRyX1vOzK7mJnrVEKlrnqPzYz8/D80kmGv4PagIVc29uOiw+jVjcp937LNiN9BFf+1QRNuM5s6lZMfE1/xeK5bkQkJWNHyy9Mu2k1OEEBIQui5nQWF/Oq492gETV0eoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b83CipEf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b83CipEf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27C6B1F000E9
	for <acpica-devel@lists.linux.dev>; Mon, 17 Aug 2026 12:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786969126;
	bh=kAeJX9Uec/6XKxjU9aI3iiCC/zao+WP5C5A6QEo6DTA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=b83CipEf9f78zsrWgB6Jg+w01Jg4xxECulHdOZRcpNCNp0CjUG99P4QQKsAHGnkxK
	 Xnzrk1PlqIIE8v89GZiP5RjEbfTqTE6mEELCe/cGvzcNxPuNq7uuwh5Gm+TpFlUo7p
	 JqNME98tAoHwlFar6i6HpcGZzJYqwEZ3QdNmRenw5IG6Z6jI4c2b5Vup4faod3j23T
	 faAIdyexzIzRVGw2zAzG3o51A27crL1sve3K3uDm5AXp3E/9O2mZiJD+X9plivGHNv
	 DobJdSORY69Dk3ixvRdRozfB2N/t7fiY/sGfb4Hnp5dDo6H0AK4PEupjqeAlgzKOX2
	 8NuZAllSPXeeQ==
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-39faa67fabaso18603191fa.3
        for <acpica-devel@lists.linux.dev>; Mon, 17 Aug 2026 05:18:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rr9AP4OTz39ZUeQg7w1NYH+hicfu+8561wb3EMcscazsGUijwyYtFZ9PIlwCDsGp+88Jborwmegm7rH0DY=@lists.linux.dev
X-Gm-Message-State: AOJu0Yw6wEqW1fXf1XeA9RJe2qodSNKZj48DUC75pGdfUmjlOqFcs+Lp
	jThH6W8OdokS9VtmFUOIs0hW+laA5HgKIZwHccUpzznNj0/9aMrcvzOUEwDsGMDYPTXI/bS7Vx+
	cbDyEAhixt86U6wT+3lEBTL6orDLd0l8=
X-Received: by 2002:a05:6512:3985:b0:5b2:a55f:2ce1 with SMTP id
 2adb3069b0e04-5b45918bfbcmr2928871e87.37.1786968767385; Mon, 17 Aug 2026
 05:12:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260816060648.4030-1-farbere@amazon.com> <20260816060648.4030-12-farbere@amazon.com>
In-Reply-To: <20260816060648.4030-12-farbere@amazon.com>
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 17 Aug 2026 14:12:34 +0200
X-Gmail-Original-Message-ID: <CAD++jL=AXgHSR7TGFeAQv=7yu9VhSznQy99MKDTgM2rJjv5HNw@mail.gmail.com>
X-Gm-Features: AcwNN1UtCvrDpVC9uuvoUfBmhVJEvfMufMk34D8Z0GoJ1ENEbtfx026qmqKhJwc
Message-ID: <CAD++jL=AXgHSR7TGFeAQv=7yu9VhSznQy99MKDTgM2rJjv5HNw@mail.gmail.com>
Subject: Re: [PATCH v5 11/13] gpio: eic-sprd: use devm_atomic_notifier_chain_register()
To: Eliav Farber <farbere@amazon.com>
Cc: rafael@kernel.org, tony.luck@intel.com, bp@alien8.de, guohanjun@huawei.com, 
	mchehab@kernel.org, xueshuai@linux.alibaba.com, lenb@kernel.org, 
	laurent.pinchart@ideasonboard.com, brgl@kernel.org, orsonzhai@gmail.com, 
	baolin.wang@linux.alibaba.com, zhang.lyra@gmail.com, jic23@kernel.org, 
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, 
	dmitry.torokhov@gmail.com, hansg@kernel.org, ilpo.jarvinen@linux.intel.com, 
	W_Armin@gmx.de, ukleinek@kernel.org, fabio.m.de.francesco@linux.intel.com, 
	kaihengf@nvidia.com, ankita@nvidia.com, leitao@debian.org, pedro.pbg@usp.br, 
	paulmck@kernel.org, frederic@kernel.org, kees@kernel.org, 
	saket.dumbre@intel.com, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-pwm@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
	acpica-devel@lists.linux.dev, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 16, 2026 at 8:09=E2=80=AFAM Eliav Farber <farbere@amazon.com> w=
rote:

> Replace the atomic_notifier_chain_register() +
> devm_add_action_or_reset() pattern with a single call to
> devm_atomic_notifier_chain_register(), removing the
> sprd_eic_unregister_notifier() callback.
>
> Signed-off-by: Eliav Farber <farbere@amazon.com>
> Acked-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
