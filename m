Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F15584E6
	for <acpica-devel@lists.linuxfoundation.org>; Tue,  5 Dec 2023 11:58:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2EF6A6106F
	for <acpica-devel@lists.linuxfoundation.org>; Tue,  5 Dec 2023 11:58:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2EF6A6106F
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.398
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VcQwSgdddOaa
	for <acpica-devel@lists.linuxfoundation.org>;
	Tue,  5 Dec 2023 11:58:57 +0000 (UTC)
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 919E8607C0
	for <acpica-devel@lists.linuxfoundation.org>; Tue,  5 Dec 2023 11:58:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 919E8607C0
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-1fb1620a00eso708910fac.1
        for <acpica-devel@lists.linuxfoundation.org>; Tue, 05 Dec 2023 03:58:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701777536; x=1702382336;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wSL9QExZG9P5l4mTBqjK/DgzgISuVuBfkBZthiusuiI=;
        b=X/AHibt5iZJHWG8xyQiqP5FXw/y4O41Vw14lE1QVBL7/wzsYrIecQCeK7I78mcJE/1
         zkBO3llPX/IYevXOAiDLUd8/k9TXO8crzV55I+bKk3hRJaehKZy5KqOLBNFRdlvP0Epn
         260E5gWTjyngMTjGKAS4dk5taA3jrj1L20RSWEz/XDC+j8hYKiam9bAh7UxTZquPhaSH
         M8rhqvjdC0U3MFJm06a2oBvcb+a4jdWBNvfo6EsMKpsvlu5Zu+kE37x43AwtyLkqmCo8
         Z0a8ogV/oDh8FsL/YHY3kQzTGaXOIkQyB+hVVNK0ljvpj3oYHnI50aHUIHl9XZXt2S1J
         FyOA==
X-Gm-Message-State: AOJu0Yy8Uxa2oLmTVbEUZuR/B6eoo1+U7df2z0YyAVgWJXP+gT11vBqB
	aQortdeykVjv2RYqZG9qkz8Km9Hl8QCIwjWSSd0=
X-Google-Smtp-Source: AGHT+IHNvB+T2rSjyBIGY6W2fYh/tu7ZWbs0fYLgN59gg8mrmMBnUYzBo/0dnMSnKAfDL/kEmG943bfYLJuumz5dNps=
X-Received: by 2002:a05:6870:440b:b0:1fb:23ec:3318 with SMTP id
 u11-20020a056870440b00b001fb23ec3318mr8617620oah.0.1701777536336; Tue, 05 Dec
 2023 03:58:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231123100617.28020-1-raag.jadav@intel.com> <ZW6iyu4qF0V7wCXG@black.fi.intel.com>
In-Reply-To: <ZW6iyu4qF0V7wCXG@black.fi.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 5 Dec 2023 12:58:44 +0100
Message-ID: <CAJZ5v0iCjD7hwBmFVZ7VcN=FMXhbTJ4Gvm=7X5tXBg3g0j1puA@mail.gmail.com>
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

On Tue, Dec 5, 2023 at 5:11=E2=80=AFAM Raag Jadav <raag.jadav@intel.com> wr=
ote:
>
> On Thu, Nov 23, 2023 at 03:36:12PM +0530, Raag Jadav wrote:
> > This series updates the standard ACPI helpers to support _UID matching
> > for both integer and string types, and uses them in a couple of places.
> >
> > Changes since v2:
> > - Drop __builtin functions to reduce complexity (Rafael)
> > - Update tags
> >
> > Changes since v1:
> > - Fix build errors
>
> Bump.
>
> Anything I can do to move this forward?

It is on my list of pending material, I'll get to it this week (I think).

Thanks!
