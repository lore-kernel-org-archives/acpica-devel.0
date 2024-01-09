Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A29F39AEC
	for <acpica-devel@lists.linux.dev>; Tue,  9 Jan 2024 14:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3bbd9ce049fso343697b6e.1
        for <acpica-devel@lists.linux.dev>; Tue, 09 Jan 2024 06:27:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704810471; x=1705415271;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=speyU9W4fgWPfDREd0VxrelBC2TKMQY2s8f/k65X9Vw=;
        b=Ytrhdg9VZCMj0XwhP6g9eSqDazkBlEtXPZZwTwskeRSB9xPZ086oI6E491T3MOEmPt
         1mGz2Wc6ny3zrPeTwZ9sW6Wqbh52Q5ckBbt5PwoL5SHcsFTE4VybcF8guZh6G9SUVlGp
         90ymassGqeCGacELTSsrlmsqf2AuWV8RsGcr0qRtoAPS3afrQdpn1AGy0ae76Fh+ygJU
         TF+0b7EqWBNbYT6cx66oSnL9pG7+6X9sPld4GeN2oIHO5eGJQV68iZgSKZVaHte4R239
         d4A7xAY1pP+UgEvSoODK1oyo2R6+SrI4I3j9nvzoMUJ6JS6LuRZsc2sMSZ9HBhayFpbL
         hhcw==
X-Gm-Message-State: AOJu0YxJy4S7I8H7o4KYkBrSqSbyrh2ngWFEZEQTByW7a2E98xuONCIh
	nGzVAGm/D+3KJrNZTKePK00BksO3K1ijWgnn8MM=
X-Google-Smtp-Source: AGHT+IHY1jFISnsaNGMvSmCaJqgqyDbrcVYMQaLmXNN65Tot1RoyyJ/7Y1Qsx35HBWPmk/RBi3ZHclzvWQyOB3wOZ1s=
X-Received: by 2002:a05:6808:30a2:b0:3bd:3bf4:8a0f with SMTP id
 bl34-20020a05680830a200b003bd3bf48a0fmr2316881oib.4.1704810471272; Tue, 09
 Jan 2024 06:27:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230905104721.52199-1-lpieralisi@kernel.org> <20231227110038.55453-1-lpieralisi@kernel.org>
 <20231227110038.55453-2-lpieralisi@kernel.org>
In-Reply-To: <20231227110038.55453-2-lpieralisi@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 9 Jan 2024 15:27:40 +0100
Message-ID: <CAJZ5v0ik38AkaK6UVkSg9gOOztVzhFotCWBPhvowvRvozoAUVg@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] ACPICA: MADT: Add GICC online capable bit handling
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: linux-kernel@vger.kernel.org, Robert Moore <robert.moore@intel.com>, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-arm-kernel@lists.infradead.org, 
	linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev, 
	Mark Rutland <mark.rutland@arm.com>, Robin Murphy <robin.murphy@arm.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Fang Xiang <fangxiang3@xiaomi.com>, Marc Zyngier <maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 27, 2023 at 12:00=E2=80=AFPM Lorenzo Pieralisi
<lpieralisi@kernel.org> wrote:
>
> ACPICA commit 16f0befdeddf25756f317907798192bbaa417e5e
>
> Implement code to handle the GICC online capable bit management
> added into ACPI v6.5.
>
> Link: https://github.com/acpica/acpica/commit/16f0befd
> Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
> Cc: Robert Moore <robert.moore@intel.com>
> Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> ---
>  include/acpi/actbl2.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
> index 3751ae69432f..2b4dd2c3348f 100644
> --- a/include/acpi/actbl2.h
> +++ b/include/acpi/actbl2.h
> @@ -1046,6 +1046,7 @@ struct acpi_madt_generic_interrupt {
>  /* ACPI_MADT_ENABLED                    (1)      Processor is usable if =
set */
>  #define ACPI_MADT_PERFORMANCE_IRQ_MODE  (1<<1) /* 01: Performance Interr=
upt Mode */
>  #define ACPI_MADT_VGIC_IRQ_MODE         (1<<2) /* 02: VGIC Maintenance I=
nterrupt mode */
> +#define ACPI_MADT_GICC_ONLINE_CAPABLE   (1<<3) /* 03: Processor is onlin=
e capable  */
>
>  /* 12: Generic Distributor (ACPI 5.0 + ACPI 6.0 changes) */
>
> --

Applied as 6.8-rc1 material along with the [2/3].

Thanks!
