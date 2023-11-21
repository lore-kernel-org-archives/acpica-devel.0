Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B16DF5A0F3
	for <acpica-devel@lists.linuxfoundation.org>; Tue, 21 Nov 2023 16:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qQnYJ74n"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3D56D610E9
	for <acpica-devel@lists.linuxfoundation.org>; Tue, 21 Nov 2023 16:20:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3D56D610E9
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=qQnYJ74n
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.401
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jHtRrZSkjEqR
	for <acpica-devel@lists.linuxfoundation.org>;
	Tue, 21 Nov 2023 16:20:02 +0000 (UTC)
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 459EB610E7
	for <acpica-devel@lists.linuxfoundation.org>; Tue, 21 Nov 2023 16:20:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 459EB610E7
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by ams.source.kernel.org (Postfix) with ESMTP id 6A34AB822A0
	for <acpica-devel@lists.linuxfoundation.org>; Tue, 21 Nov 2023 16:20:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD339C433C7
	for <acpica-devel@lists.linuxfoundation.org>; Tue, 21 Nov 2023 16:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700583599;
	bh=/ftsIOr6PtvXmwDXJG2lgHpbTRDyOZqNHqOkYX1msmg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=qQnYJ74n8oQzVtLAxKlA0npDWvAXMG5BczCbtm8Q7r1U9tmCrT/NYDhrCDJgV4dxH
	 FpzqPbjUjkeuZ1oqf8JbcXboxg0/5HF3aXuCOud2H9tRy3N1oeJO28yQVzyEPboON7
	 tHv97fMIje/U8dP08iA6XHgtkk/cXHcezhCVMTdr2aJ0F/tAE2VrMR+7xF82QLBeUn
	 ELAtG3qCN7qEO9ahwWMgIlGiuJby3jBl04eev+q+T54u5IjB0I2A3PEj3YfbuSFFmc
	 05pobXOY9fPL66pCFy2QE3Tq5YI8vodE9OrSts1ygetRcZ6fP85P+BVaydWq75EdPz
	 CeAb/VRx+JLbw==
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2c8880f14eeso20478311fa.3
        for <acpica-devel@lists.linuxfoundation.org>; Tue, 21 Nov 2023 08:19:59 -0800 (PST)
X-Gm-Message-State: AOJu0YyDseGL3iFFhOD7N0aQPNZMaukoH4vKtJxpeU/JxVSGfCcOPXyl
	q6haB7W3OCHHnbexIp9kxE8v3gCK7LnE8oL+ecM=
X-Google-Smtp-Source: AGHT+IEtMGQDvBsJOPcKtWdelsFIWrHMFFYwL5uPNIQYz3nN/aRSQXRn2eA7w9M9xQKYjfsRUgSQym1LFQCd9rSwY0M=
X-Received: by 2002:a2e:9e1a:0:b0:2c5:1f92:b464 with SMTP id
 e26-20020a2e9e1a000000b002c51f92b464mr6822339ljk.10.1700583597994; Tue, 21
 Nov 2023 08:19:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231121103829.10027-1-raag.jadav@intel.com> <20231121103829.10027-6-raag.jadav@intel.com>
In-Reply-To: <20231121103829.10027-6-raag.jadav@intel.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 21 Nov 2023 11:19:46 -0500
X-Gmail-Original-Message-ID: <CAMj1kXEr2O8LZNq1r0zr1ZHPhtpbNu0PmZBk=UQvp7m0=ETodA@mail.gmail.com>
Message-ID: <CAMj1kXEr2O8LZNq1r0zr1ZHPhtpbNu0PmZBk=UQvp7m0=ETodA@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] efi: dev-path-parser: use acpi_dev_uid_match() for
 matching _UID
To: Raag Jadav <raag.jadav@intel.com>
Cc: mika.westerberg@linux.intel.com, andriy.shevchenko@linux.intel.com, 
	rafael@kernel.org, lenb@kernel.org, robert.moore@intel.com, will@kernel.org, 
	mark.rutland@arm.com, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, acpica-devel@lists.linuxfoundation.org, 
	linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	mallikarjunappa.sangannavar@intel.com, bala.senthil@intel.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 21 Nov 2023 at 05:39, Raag Jadav <raag.jadav@intel.com> wrote:
>
> Now that we have _UID matching support for integer types, we can use
> acpi_dev_uid_match() for it.
>
> Signed-off-by: Raag Jadav <raag.jadav@intel.com>

Reviewed-by: Ard Biesheuvel <ardb@kernel.org>

> ---
>  drivers/firmware/efi/dev-path-parser.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/firmware/efi/dev-path-parser.c b/drivers/firmware/efi/dev-path-parser.c
> index f80d87c199c3..937be269fee8 100644
> --- a/drivers/firmware/efi/dev-path-parser.c
> +++ b/drivers/firmware/efi/dev-path-parser.c
> @@ -18,8 +18,6 @@ static long __init parse_acpi_path(const struct efi_dev_path *node,
>         struct acpi_device *adev;
>         struct device *phys_dev;
>         char hid[ACPI_ID_LEN];
> -       u64 uid;
> -       int ret;
>
>         if (node->header.length != 12)
>                 return -EINVAL;
> @@ -31,10 +29,9 @@ static long __init parse_acpi_path(const struct efi_dev_path *node,
>                         node->acpi.hid >> 16);
>
>         for_each_acpi_dev_match(adev, hid, NULL, -1) {
> -               ret = acpi_dev_uid_to_integer(adev, &uid);
> -               if (ret == 0 && node->acpi.uid == uid)
> +               if (acpi_dev_uid_match(adev, node->acpi.uid))
>                         break;
> -               if (ret == -ENODATA && node->acpi.uid == 0)
> +               if (!acpi_device_uid(adev) && node->acpi.uid == 0)
>                         break;
>         }
>         if (!adev)
> --
> 2.17.1
>
