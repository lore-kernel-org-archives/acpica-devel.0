Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 144FE47F65
	for <acpica-devel@lists.linuxfoundation.org>; Wed,  6 Dec 2023 19:44:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9BE0960B6A
	for <acpica-devel@lists.linuxfoundation.org>; Wed,  6 Dec 2023 19:44:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9BE0960B6A
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.398
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FWyBD4qXN0tI
	for <acpica-devel@lists.linuxfoundation.org>;
	Wed,  6 Dec 2023 19:44:30 +0000 (UTC)
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 01B8360AE4
	for <acpica-devel@lists.linuxfoundation.org>; Wed,  6 Dec 2023 19:44:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 01B8360AE4
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-1fae54afb66so26569fac.1
        for <acpica-devel@lists.linuxfoundation.org>; Wed, 06 Dec 2023 11:44:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701891869; x=1702496669;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=INtr6ESdMmvwrLweqn4CnFa4mFOayDNocnS5JvYQDSU=;
        b=r0KqQWTRom9vNZgsY+G+o1u2kq17wxk4Mqf+mRx95yOWNAaxJRftSLorOJdLoPz+qI
         Rk3d3HqDqe4lz2ZSp1jlCSxSgBkmKeTsJ82B1qH87CuzYYkjqsevUNn/6OJhfoskFoEb
         2WYRsD/GITjFTBgRmxWSw1gotlAHHDUIVcxLQFp5qXnrr1ODg2nBQtVqDIkbrY6eN6rk
         Sgc8oU+kVhT3md8+dN3XLDs9BZ78ec5+jxzLeIJOICapqlJNw0rV3whd4yPDeJb0E2YT
         vxt2wO+pc5fYjq9TVx3bZd44nqpJUyp8pfnPiAnAy2de9XEkdIs+Q/mj3MTsRMTfeV05
         CQfQ==
X-Gm-Message-State: AOJu0YxYolpVYKCa1w8P7FQSoxASULckafXQwLTQJKMHHOeMGcLTzxR2
	/b5ZuUEdXqOATPnfOnnExSsbCxOQVYW/hzhL0Uw=
X-Google-Smtp-Source: AGHT+IGfcNJZtvj9DnCjBMcbliiTnXjZvfx3KHgLDpGuqa+yvHvI5/TJ3VSssAQcSufAtX868tsRqdDp0XR0PnA3RQE=
X-Received: by 2002:a05:6871:d30c:b0:1fa:db26:78a6 with SMTP id
 pn12-20020a056871d30c00b001fadb2678a6mr2734246oac.1.1701891868973; Wed, 06
 Dec 2023 11:44:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231123100617.28020-1-raag.jadav@intel.com>
In-Reply-To: <20231123100617.28020-1-raag.jadav@intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 6 Dec 2023 20:44:18 +0100
Message-ID: <CAJZ5v0h7rSY7cD18pGTy9GuNB5s5EvVCNWngPKBtCCXrrNNW5A@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] Support _UID matching for integer types
To: Raag Jadav <raag.jadav@intel.com>
Cc: mika.westerberg@linux.intel.com, andriy.shevchenko@linux.intel.com, 
	rafael@kernel.org, lenb@kernel.org, robert.moore@intel.com, ardb@kernel.org, 
	will@kernel.org, mark.rutland@arm.com, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, acpica-devel@lists.linuxfoundation.org, 
	linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	mallikarjunappa.sangannavar@intel.com, bala.senthil@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 23, 2023 at 11:07=E2=80=AFAM Raag Jadav <raag.jadav@intel.com> =
wrote:
>
> This series updates the standard ACPI helpers to support _UID matching
> for both integer and string types, and uses them in a couple of places.
>
> Changes since v2:
> - Drop __builtin functions to reduce complexity (Rafael)
> - Update tags
>
> Changes since v1:
> - Fix build errors
>
> Raag Jadav (5):
>   ACPI: bus: update acpi_dev_uid_match() to support multiple types
>   ACPI: bus: update acpi_dev_hid_uid_match() to support multiple types
>   ACPI: LPSS: use acpi_dev_uid_match() for matching _UID
>   efi: dev-path-parser: use acpi_dev_uid_match() for matching _UID
>   perf: arm_cspmu: drop redundant acpi_dev_uid_to_integer()

All applied as 6.8 material, but I renamed the auxiliary macros in the
first patch and moved the kerneldoc comment below them.

TBH, I'm not entirely sure about the value of the second of those
auxiliary macros, but then I don't particularly dislike it either.
