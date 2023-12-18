Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348BE71477
	for <acpica-devel@lists.linuxfoundation.org>; Mon, 18 Dec 2023 20:35:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B5D7C40979
	for <acpica-devel@lists.linuxfoundation.org>; Mon, 18 Dec 2023 20:35:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B5D7C40979
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.398
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id e6r86nnZr7jY
	for <acpica-devel@lists.linuxfoundation.org>;
	Mon, 18 Dec 2023 20:35:28 +0000 (UTC)
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 1EAA84096E
	for <acpica-devel@lists.linuxfoundation.org>; Mon, 18 Dec 2023 20:35:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1EAA84096E
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-1fae54afb66so108519fac.1
        for <acpica-devel@lists.linuxfoundation.org>; Mon, 18 Dec 2023 12:35:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702931727; x=1703536527;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w5muLLdvnEWK5GQ123Z96eJyI+5glad1JcNNdF8H1Jg=;
        b=SYPPARLzh9TxfEAO+Zxtu0hA+uegfJPwBOPjPMTJ+ZBjeoA9+MhbEHDaRgGYCOmSPt
         U2Gx0jmhYbaZJhD6qrZdbaZHCxRqz/2UcU++6OYWyRi+misKgBJin5KYdGJVqRBfoHoZ
         zhcMHKeTnRyZceCttb7a3zjZbcMzHcepA5freOC1Z6m/2EEPGGuayp0e+jSqnZIKZosw
         Ho+MJUynxnHYNqQdHwuYdnM4mttkQImxePp2tcxF17phDPGgppF4UOrdRDKEYsVFB/Up
         42eUnpTD+4SiKLIMgvE2PsOdeIozh7kKryH8X1UeC24j0LhQvlcyKVFo5VaQrRT8Wl8D
         6cQQ==
X-Gm-Message-State: AOJu0YwAzXNfGfaID9AgOTJU1TLhg+Ke0jR/YDZVHClneXEaybNmUv2k
	Q7FqB1Uz/Cxr3d11PrCV5zWHusdaCZ3yBV0P0gI=
X-Google-Smtp-Source: AGHT+IF1MjB6QbmwWfc3T+5pLabp0AF+8g7RLCoeqeEABS9CAvETyoAN6o6rB15S5OlZOByT2E647igWVuJN9yCJ/4I=
X-Received: by 2002:a05:6870:71ca:b0:203:e75d:a2c2 with SMTP id
 p10-20020a05687071ca00b00203e75da2c2mr729668oag.1.1702931727130; Mon, 18 Dec
 2023 12:35:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <ZXmn46ptis59F0CO@shell.armlinux.org.uk> <E1rDOgD-00Dvk2-3h@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1rDOgD-00Dvk2-3h@rmk-PC.armlinux.org.uk>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 18 Dec 2023 21:35:16 +0100
Message-ID: <CAJZ5v0g9nfLrEf9u4Ksw6BOWJQ9iv8Z-O8RsLU6jR5zk0ahxRw@mail.gmail.com>
Subject: Re: [PATCH RFC v3 05/21] ACPI: Rename ACPI_HOTPLUG_CPU to include 'present'
To: Russell King <rmk+kernel@armlinux.org.uk>
Cc: linux-pm@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-riscv@lists.infradead.org, kvmarm@lists.linux.dev, x86@kernel.org, 
	acpica-devel@lists.linuxfoundation.org, linux-csky@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-ia64@vger.kernel.org, 
	linux-parisc@vger.kernel.org, Salil Mehta <salil.mehta@huawei.com>, 
	Jean-Philippe Brucker <jean-philippe@linaro.org>, jianyong.wu@arm.com, justin.he@arm.com, 
	James Morse <james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 13, 2023 at 1:49=E2=80=AFPM Russell King <rmk+kernel@armlinux.o=
rg.uk> wrote:
>
> From: James Morse <james.morse@arm.com>
>
> The code behind ACPI_HOTPLUG_CPU allows a not-present CPU to become
> present.

Right.

> This isn't the only use of HOTPLUG_CPU. On arm64 and riscv
> CPUs can be taken offline as a power saving measure.

But still there is the case in which a non-present CPU can become
present, isn't it there?

> On arm64 an offline CPU may be disabled by firmware, preventing it from
> being brought back online, but it remains present throughout.
>
> Adding code to prevent user-space trying to online these disabled CPUs
> needs some additional terminology.
>
> Rename the Kconfig symbol CONFIG_ACPI_HOTPLUG_PRESENT_CPU to reflect
> that it makes possible CPUs present.

Honestly, I don't think that this change is necessary or even useful.
