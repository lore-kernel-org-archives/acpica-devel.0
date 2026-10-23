Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792742403;
	b=EeBAjNPYRcemGGsdcWDs0nYEXAgvYf5p6ACXQceAtc3xm7BlEBzekj/RuxRgGeAjKLj6
	 FLQm/mmleHO5haTNr1ZihagRhJ3Ui96J3Pb5yeJ+tzgmI9i3jkSv/eLcw+m0i867PpnZl
	 5MZdIBuoGKXKbX1Kr4555ox/JD5fqqBKp0FUCM96wEQCrzli+3kUSPOicmIVAq/0H3ev+
	 kxaXs3U+WcWZ763lvAgp7m40+mW7SWBJSJnBzz56flnqnd7oxFHJ/K1rkbQbQoJ2SII1e
	 aH7oz+EAW/1e+qnPJ2MVzNJF7ZsUQtacnGLNUwuTxURPnQQFgDUSYSTO4/iNi1M44CQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792742403;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=QgLgPFRrKVTwPnbDlyKNGdrZlu/R3XqNjBOMrM54obE=;
	b=h+lBfNnofHmu6AxdwfcO9uW0WxnvWnZ8ukijvcY0LvxnXEEib/njEKxUJIu4kgt1dFhQ
	 dtOeiTlAFMHlbPia3tUcYGFBvII0UCy31JVCxxjnezIJvdmOgbL3CizRoMX3JLLJ8pWI9
	 d9JYgZ0XGlZq0TWnHg3Rm+3c24ETR7TIfi2CV3uzm97zKJowCztaxS/eOM6PpSIjcodBL
	 YhTS/wFKpSwBHMOSfLb4UY4IQP3Lpd0EKEDQ/Hnu+e67WCLQ4qStYdLNr7yYtMJrre8gs
	 QJ+N5BES0mYGlQyGlBsGTWIjd3UuQd6oqJG6MjzNrqR2SKoItctFWmgLQ5+Kcy+9c9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SQlZvZxB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52CA606A31E
	for <acpica-devel@lists.linux.dev>; Fri, 23 Oct 2026 08:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SQlZvZxB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92F621F031E0
	for <acpica-devel@lists.linux.dev>; Fri, 23 Oct 2026 08:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792742402;
	bh=QgLgPFRrKVTwPnbDlyKNGdrZlu/R3XqNjBOMrM54obE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=SQlZvZxBnaz0X8FrdTTOVa/U52A/EiOJUH1/2ZRQ2kIKeQukBAHv9q0l2M7TK1h0N
	 4sehVoe3SKKsqGljrurTjCnGOXisYVr1po984VJrW0avIgdX1M1DSCuvSbqZEZlQd+
	 ajWu6Y5X2sRcQN1YPbfykzQbQIWNrb1l+EV4c8x/dChfVpN8UNBthiRwcc6zpARRwQ
	 u+l4sPKO1pD5jrxRXFiM7WLJ2ASrkCR8L16rcUCK9j1l6qTZr74kl4nkUH5mAeViMQ
	 6vKIRVeWK3ThEdf05HsvkxgsSuKrkRXPMlWv5TaihlYwNDBhhnSwHCc3DA/OoY7wn1
	 TG9XjtOxZRMLQ==
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c434376dbebso101693066b.1
        for <acpica-devel@lists.linux.dev>; Fri, 23 Oct 2026 01:00:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByKAEty2NoA35M0j2fwa2QeYYAIm1X/zTtAPisPOmSZJq4A/AUz5zSuBxuZXT3qL7RMefY8+1wwDwP4PQ8=@lists.linux.dev
X-Gm-Message-State: AFq9FYK3AEtWALSa6kKL5kP88nPc7epSvMnVwu91Fthar7Y5LMl/yHPr
	pTEM6IppDFznj+I7AWrMxPha3UeVror/wAgYW4IxuazfaNieS+vFoyLeqdDNQDDQiVbMBgjP30s
	M5PuJM9RfR4fQzUUc9xGWvkcKfR0IQ9o=
X-Received: by 2002:a17:907:3f91:b0:c41:825d:ed8c with SMTP id
 a640c23a62f3a-c468d8a0100mr629756566b.26.1792742401137; Fri, 23 Oct 2026
 01:00:01 -0700 (PDT)
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Post: <mailto:acpica-devel@lists.linux.dev>
List-Help: <mailto:acpica-devel+help@lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:acpica-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20260922121058.972734-2-maobibo@loongson.cn> <10bd45f8-2d37-42f0-b7d2-a4a84933c9b3@loongson.cn>
In-Reply-To: <10bd45f8-2d37-42f0-b7d2-a4a84933c9b3@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Fri, 23 Oct 2026 15:59:48 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7Vq2ayLJNLRSo5RRiWOcmF2BXT_QOhEDg_jWOzYteqWw@mail.gmail.com>
X-Gm-Features: AclHuK9Hbbs1oZtjIaN_3zmQECDKlzgbV2qc7hsxNXCGEXmyEFHXP7muVxJYxG4
Message-ID: <CAAhV-H7Vq2ayLJNLRSo5RRiWOcmF2BXT_QOhEDg_jWOzYteqWw@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] ACPICA: actbl2.h: Add bit constants of the Flags
 field in the IOVT IOMMU structure
To: Bibo Mao <maobibo@loongson.cn>
Cc: rafael@kernel.org, linux-acpi@vger.kernel.org, 
	acpica-devel@lists.linux.dev, lenb@kernel.org, linux-kernel@vger.kernel.org, 
	lixianglai@loongson.cn, loongarch@lists.linux.dev, 
	maciej.wieczor-retman@intel.com, pawel.chmielewski@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Bibo,

Now I have applied this series but with some modifications, please
double check and test the code.

https://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.g=
it/log/?h=3Dloongarch-next

Huacai

On Mon, Oct 12, 2026 at 3:16=E2=80=AFPM Bibo Mao <maobibo@loongson.cn> wrot=
e:
>
> This change is already merged in acpica tree.
>
> slightly ping.
>
> On Tue, Sep 22, 2026 at 08:10:55PM +0800, Bibo Mao wrote:
>  > According to the IOVT specification, define macros for each bit of the
>  > Flags field in the IOVT IOMMU structure.
>  >
>  > Link: https://github.com/open-acpica/acpica/commit/352f750e4cc0
>  > Signed-off-by: Bibo Mao <maobibo@loongson.cn>
>  > ---
>  >  include/acpi/actbl2.h | 7 +++++++
>  >  1 file changed, 7 insertions(+)
>  >
>  > diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
>  > index baef525367b5..76e4a5bc79b4 100644
>  > --- a/include/acpi/actbl2.h
>  > +++ b/include/acpi/actbl2.h
>  > @@ -919,6 +919,13 @@ struct acpi_iovt_iommu {
>  >       u32 device_entry_offset;
>  >  };
>  >
>  > +/* Masks for Flags field above */
>  > +#define ACPI_IOVT_IOMMU_PCI_DEVICE           (1<<0)
>  > +#define ACPI_IOVT_IOMMU_PXM_VALID            (1<<1)
>  > +#define ACPI_IOVT_IOMMU_MAGAGE_BY_SEGMENT    (1<<2)
>  > +#define ACPI_IOVT_IOMMU_HW_CAP_SUPPORT               (1<<3)
>  > +#define ACPI_IOVT_IOMMU_MSI_INT_BYPASS               (1<<4)
>  > +
>  >  struct acpi_iovt_device_entry {
>  >       u8 type;
>  >       u8 length;
>  > --
>  > 2.39.3
>  >
>
