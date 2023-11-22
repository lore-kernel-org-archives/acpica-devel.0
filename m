Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAAEE3D969
	for <acpica-devel@lists.linux.dev>; Wed, 22 Nov 2023 14:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O8jYNfJm"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-5cb8440a23cso21851377b3.3
        for <acpica-devel@lists.linux.dev>; Wed, 22 Nov 2023 06:56:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700665000; x=1701269800; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DlRpn0YExbwmZYTM470D32GCVHZUUU3U4GDP0MEdp30=;
        b=O8jYNfJm1MFw8VXBQivGazV/ANSObszP/laaRHUJ5qp/Fwa+TywUuQKas9bJz9Qun9
         To1uGZovSGywLAm4AZ3PC9/5L9CG2iT2pLrO2EMXmwrr1j+tulyiyJ9HS8n60vGJgxRy
         UINwnYddNvd2g3moNEe7IDpOqbaZ2zHJtmZq3BhzJ0S4v1cvRlMkZQrZw7F6gx/by6BY
         PKQVbz+nKefG5jYHEVFBwVDegk2tRubio0diDMapmBTM26YNnkXUgYwXTbfDC2W9kDI8
         Tdhj1tE88x+IJ6AnrDLneMFscYIvTgXqm1iOSNI0jV7qp7zWy8SoEjNG1Hi7sM+oCsLb
         PjZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700665000; x=1701269800;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DlRpn0YExbwmZYTM470D32GCVHZUUU3U4GDP0MEdp30=;
        b=Q+HalsuySfFonG7JtLrGbEW4GEsdegIugIS3njiOcb332JMo/fIMJtoy4YNijNGVSj
         3KQlv8+aW4FrGiY2ZaDAaZzwVHestGF66Lat70i/s9GbxI+6njhVWaYcQFtYZYOkoDBg
         m4Mk4aY/Un8gkq41NrPPJ8T00ieHMpfGFYNYRYIDKitcRE+jGtLr4fbaQ8XXABwP6jbP
         34kFDMz2aLa6XMFGnDGIlccHzsn5cDVAW3IRWRuiN/yG22FakJqJMLEMdNyanwj9e+sc
         VxrQTr77iWjFRglHK6rLkrqk/6/+sDgFValvneGK2ikHoHl6fEl06/rt1JQO9kWQJkux
         dmxw==
X-Gm-Message-State: AOJu0YxXJ8WzrQgQuB6nC84vbvjhc/O4ZJWgkOIGyUQl4syBuznRXNxZ
	GaZ+MuhcazYqtURLRKFSn3LAkmHmnoQ3AiYAD1SrJQ==
X-Google-Smtp-Source: AGHT+IETkyDkyc+qmERQdITDeir1SD3U7sHru8ZIboVSSWeeQw5dcf2O6tuEhcqqPh/BIaHsLICfH+aUOCCIoZE93wc=
X-Received: by 2002:a0d:d692:0:b0:5c9:e98c:a6ae with SMTP id
 y140-20020a0dd692000000b005c9e98ca6aemr2364566ywd.4.1700665000626; Wed, 22
 Nov 2023 06:56:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <170060515641.2447486.11798332619205301829.stgit@djiang5-mobl3>
In-Reply-To: <170060515641.2447486.11798332619205301829.stgit@djiang5-mobl3>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 22 Nov 2023 15:56:28 +0100
Message-ID: <CACRpkda-YFDH6JB=V5n4QXMAHyHc22pfhUfW97hj7WaHX7-mpg@mail.gmail.com>
Subject: Re: [PATCH v2] acpi: Fix ARM32 platforms compile issue introduced by
 fw_table changes
To: Dave Jiang <dave.jiang@intel.com>
Cc: rafael@kernel.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, lenb@kernel.org, 
	robert.moore@intel.com, Jonathan.Cameron@huawei.com, dan.j.williams@intel.com, 
	guohanjun@huawei.com, arnd@arndb.de, linux-acpi@vger.kernel.org, 
	acpica-devel@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, cfsworks@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 21, 2023 at 11:19=E2=80=AFPM Dave Jiang <dave.jiang@intel.com> =
wrote:

> Linus reported that:
> After commit a103f46633fd the kernel stopped compiling for
> several ARM32 platforms that I am building with a bare metal
> compiler. Bare metal compilers (arm-none-eabi-) don't
> define __linux__.
>
> This is because the header <acpi/platform/acenv.h> is now
> in the include path for <linux/irq.h>:
>
>   CC      arch/arm/kernel/irq.o
>   CC      kernel/sysctl.o
>   CC      crypto/api.o
> In file included from ../include/acpi/acpi.h:22,
>                  from ../include/linux/fw_table.h:29,
>                  from ../include/linux/acpi.h:18,
>                  from ../include/linux/irqchip.h:14,
>                  from ../arch/arm/kernel/irq.c:25:
> ../include/acpi/platform/acenv.h:218:2: error: #error Unknown target envi=
ronment
>   218 | #error Unknown target environment
>       |  ^~~~~
>
> The issue is caused by the introducing of splitting out the ACPI code to
> support the new generic fw_table code.
>
> Rafael suggested [1] moving the fw_table.h include in linux/acpi.h to bel=
ow
> the linux/mutex.h. Remove the two includes in fw_table.h. Add include of
> linux/acpi.h in fw_table.c before the fw_table.h include.
>
> Link: https://lore.kernel.org/linux-acpi/CAJZ5v0idWdJq3JSqQWLG5q+b+b=3Dzk=
EdWR55rGYEoxh7R6N8kFQ@mail.gmail.com/
> Fixes: a103f46633fd ("acpi: Move common tables helper functions to common=
 lib")
> Reported-by: Linus Walleij <linus.walleij@linaro.org>
> Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

This works fine on my end.
Tested-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
