Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25397232390
	for <acpica-devel@lists.linux.dev>; Tue, 10 Dec 2024 21:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733866071; cv=none; b=swIuQlrF0IIlZBvVNF9AlaeaAKbeCbmhyP3qpnD3WZJMh6cRV/Gmq8C1xsproyouz03k8K7LL+CMLWq80IMdRtqaKSI4TW2D4Nf4LpBL+zANojh7QV8mjabdLuw4bojMKVFSlPvuwt8ig0maFinvUTynShtZT48gHj3KgWdBrqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733866071; c=relaxed/simple;
	bh=Wj6GJ2swJpdXPIA55sjM7Y0DDbLPXovMHvENa2EydwA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CgJBx8RZgiFq+eaaUgDgzwErUwH1XQD+yw9NoIdH1kjJTDwAzHULdOT85OwrZpCtJ2H3JxHhfemHJcsGuuzyreVTT8uKWgDSjncFZmfTgkTTtd9oF+IC10tjTO1NeOOTFr+lPyjgfr3H8I185HGyegdHOqlC/0xd2ZKiSy5jsdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ZTpms7lK; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZTpms7lK"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-21631789fcdso337835ad.1
        for <acpica-devel@lists.linux.dev>; Tue, 10 Dec 2024 13:27:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733866069; x=1734470869; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=s/YuPzifs9jEt0j1RwPUAZ3kuyk16V3hz+9XJwFbKNE=;
        b=ZTpms7lKf251cly/s6xv2jAN7YbLCIKhvjRxBkbK3wRbezIjVhBIQ9KT/zLxzXJ3UU
         1U2BnIq9JJJ34WmIHgQhO9MMRnbbKS0SF/HqCbdnIZ/Eh+gAKwCfGW+PoEXlH0lF2/ai
         9ZPwcBj9YpO7E5FF4nB3dnBnjvjjM+t3yK3Sw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733866069; x=1734470869;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s/YuPzifs9jEt0j1RwPUAZ3kuyk16V3hz+9XJwFbKNE=;
        b=UY3aM2Pd+18kTrcVdFCWH0sZU1XarklsCJuFzg/acXWfmL6t/Rx5udrS+b1ycmvKeR
         ZXFpJZnAXqPQ9MIw7TxVAcGg7yD+PvWNPcFqxt/Mkv7OwwOPqmjOfEnIP8gox7HAbYag
         uv8fw4FIpVip5dm6VqXSXVGU+MRoSDwirx/5capOMcID4NNZNi/LKT0zlDKHJa3Dyx64
         jw1aWRmaMI0K02Eeclv4QkLRCEijYveURxBbL5CQ0fEg3reptrdFn70CT/2DOUf6R/0K
         WDivpOn9+4qEOo37qGWJMykrX35HGJgakGhb7JeDXMqPx359mamyOKXUhgZ8TNltpCqF
         6kZg==
X-Forwarded-Encrypted: i=1; AJvYcCXv6qiJWLHaPJX3D7TszD60WDANVcGa6iJR/XB3EBFOvJVDmM+fozhW0N0JJHvLv2bKSM7oBh+CKqbcps4=@lists.linux.dev
X-Gm-Message-State: AOJu0YxOMCQHk4MNKxlCV5KEOq6Ke3sj6uy/rEELIodpFVa12IbF9g8M
	aesf4mfANP+Z0cxCGuVzIjxd7rJSO/ER56cTITxz/Z+Gv8RMe5eu64B7KJQAX12FCJDcr1OgnEY
	=
X-Gm-Gg: ASbGncsFQ+Rh61d5xk8cZwjVj0kAtKcqvw4jeXmttfBjChd06vQBabwn6EBKk5VejP3
	taxuQeNEa1uPZcfipcJdjqt1S5LxPeZ1vr7V1e5anVmqvg6Y0oKa+iKH1aCrnq9uQHGTRXLU9F1
	NCinxKzC5/cvoKfwoCobWbah065wi1FhQy0uoQe9IlANQ8MbjFHoWe6y+zYCAiLleRj0lz9+YXz
	QhVYJ9vcz71yBptHMuwhvrLu3oG9tO9qeW8TieIwUOFP1TLeOAogtc26EjKokCoIu/xatpYIHsI
	dj62bIgtshtXfNvB
X-Google-Smtp-Source: AGHT+IGS2YmoLEUxjDCZX0N2llGOdnKIqLMm134UB0eFtPruatYjgcEppWIDRUhoo2Hbkg4WTDxasw==
X-Received: by 2002:a17:902:e80f:b0:215:7e49:8202 with SMTP id d9443c01a7336-21779e5c992mr4799025ad.13.1733866069316;
        Tue, 10 Dec 2024 13:27:49 -0800 (PST)
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com. [209.85.216.45])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215f8e3f900sm94345275ad.54.2024.12.10.13.27.45
        for <acpica-devel@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2024 13:27:45 -0800 (PST)
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2ef714374c0so50536a91.0
        for <acpica-devel@lists.linux.dev>; Tue, 10 Dec 2024 13:27:45 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXfBl8JpuccNJPfYq2CFR6iW1xAE/TLtcphR0OSjI8IFZjfGdaOdF5O7JW89f/Ooem6bp+QqeGuGp/oAxY=@lists.linux.dev
X-Received: by 2002:a17:90a:b389:b0:2ef:ad27:7c1a with SMTP id
 98e67ed59e1d1-2f12878d1d1mr437693a91.2.1733866064580; Tue, 10 Dec 2024
 13:27:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241210-fix-ipu-v3-0-00e409c84a6c@chromium.org>
 <20241210-fix-ipu-v3-1-00e409c84a6c@chromium.org> <Z1isvGLLwr7jmW5k@kekkonen.localdomain>
In-Reply-To: <Z1isvGLLwr7jmW5k@kekkonen.localdomain>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 10 Dec 2024 22:27:32 +0100
X-Gmail-Original-Message-ID: <CANiDSCtFQBNjJoLF1VKR_M4zNHQWwWATu3p=-QQS-d3fY+9KUA@mail.gmail.com>
X-Gm-Features: AZHOrDm_vFiL0dGEzWST540Nxq4R6kmbJ8O_IagFBELPZMZsnuRVzRl-QCxx5C0
Message-ID: <CANiDSCtFQBNjJoLF1VKR_M4zNHQWwWATu3p=-QQS-d3fY+9KUA@mail.gmail.com>
Subject: Re: [PATCH v3 1/7] media: ipu-bridge: Fix warning when !ACPI
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Robert Moore <robert.moore@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
	Dan Carpenter <dan.carpenter@linaro.org>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
	acpica-devel@lists.linux.dev, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 10 Dec 2024 at 22:04, Sakari Ailus <sakari.ailus@linux.intel.com> wrote:
>
> Hi Ricardo,
>
> On Tue, Dec 10, 2024 at 07:55:58PM +0000, Ricardo Ribalda wrote:
> > One of the quirks that we introduced to build with !ACPI && COMPILE_TEST
> > throws the following smatch warning:
> > drivers/media/pci/intel/ipu-bridge.c:752 ipu_bridge_ivsc_is_ready() warn: iterator 'i' not incremented
> >
> > Fix it by replacing the condition.
> >
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/r/202411221147.N6w23gDo-lkp@intel.com/
> > Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> > Closes: https://lore.kernel.org/r/202411221147.N6w23gDo-lkp@intel.com/
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
>
> I've picked this to my tree and I'll take the last one, too, once the rest
> reaches the media tree.

Thanks!

If you do not mind, I will keep sending 1/7 when I send v3, to make
sure it is tested by the CI. I will mark it as duplicate in patchwork.

Thanks!

>
> --
> Regards,
>
> Sakari Ailus



-- 
Ricardo Ribalda
