Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8593322CBC8
	for <acpica-devel@lists.linux.dev>; Tue, 10 Dec 2024 20:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733864094; cv=none; b=ZOsLbto7JTE/0s3fhKWpRggKqIRnvqsP2MvSFNw9PI2rVc4GvL2qT950Zd6yoWUdFkw5OLlTW9MMv2ClJ55mtsMuTOq9SiRct8u7PdA9nMw7a2QpWuquISfiuCZ8zig3BvoK7/tHgc99d6tHozYKevQzKoyQjSWtD7ealLBTXsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733864094; c=relaxed/simple;
	bh=mYCw5zFdaYamjNq7yWm1N3ddyHnywTLmXo/dBHAWXWY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NTk3d68ZJX2wcXvc/NM1Pkp10/WtYiQb+Up6TetYdRqgIEnkwJk1Xk68aNM+1dPlTELJg95Qfqlfuexcy8TtQNToJ6KX1X8AYaHNnTXFbzIguUpmnBJMdeDnOhXqAB8GbVxBIEFIaklosAcHJSxZ8sIm9toJmphF8EuI7h1Co8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=HGHsUJ+m; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HGHsUJ+m"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2156e078563so45511615ad.2
        for <acpica-devel@lists.linux.dev>; Tue, 10 Dec 2024 12:54:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733864090; x=1734468890; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Q4ORuy0JI3fjhylUMikWO4DqO9jPwo1uX07vpSEDYjw=;
        b=HGHsUJ+mLT8aBT2gzKLSNg9yfB6nsshHUZxovB9DGlLdxpUnInigxGJqWGY2XL+THe
         Kil+DaUKET2oBxCzftVUTA60cuvghtX87fIJ28Vrn6FP5FaqJeQ8yNfg3/Sajmkh222L
         ym8eQ+fVnOem+qtzVIO+b4KWk7tjC130/fuQg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733864090; x=1734468890;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q4ORuy0JI3fjhylUMikWO4DqO9jPwo1uX07vpSEDYjw=;
        b=qTjQq0J3V2PjX/b0HhHP6ddTuwA8yYa38JeME3Sp9YqEaiWGwCLcEz3hVzFLNkor1A
         AXD6/YleVBsIRmHOqfbR+mmbHcVFYNjC2K0iQnG2LD7nm7EM/pRFoQG5N7d2k8kdocb1
         JklW8BdttzicsyCuJZ3FU4GQ/nQSYP7Dxv5TEuX7D9HwADQamEQ8zEWSHmTrBWkf4zrA
         CQ/7pnMYyQK01O+JNeEoY3auYhbWRjmJvchrW33Wf/t1RFWAd0mQJfJEeg6Mss7rXtM/
         +GeODHsRDqoskaK+2zvRpKbtC5+7LJWtunbq0ednRldAri1KGLm+lFyEqGBWEOlYkBNO
         HbYg==
X-Forwarded-Encrypted: i=1; AJvYcCXJ8apL2U7JKkc9iXuq74+VgdDuWMoN1BbsasCmxm4grlfGfYFIjbVXNE7JxlZYpQSBAl2J6jfIBSe6PE8=@lists.linux.dev
X-Gm-Message-State: AOJu0YyM4S4SGIP83C1/yY9jGh/kOZjFfGG9K4WPetN7jQScaGROwret
	lfM5XvC+cnwFz8JO5RiKq8De9kR9hFCy/Vfd/biJW65GCK3c23m4OQzoQlkcNgsVTFdolzYj4GU
	=
X-Gm-Gg: ASbGncsvn2+/n/eTOjplBkyRDVMKKBWin5pg5Za8WT7Y+GdmFqhGdyB6UJ1TxlhcLqI
	6Um3O3l/MkfKCUVlxF6V6GPg1JTDDYGQFsnlmQ6HZQRYZsbaGPBLJrKvUr8j3DL/sHav1v2equt
	+ix/ZiOgj4D3ZmfZ4BhApkC+A05OfiGx4xlhcQqqsyF+LpVzKo6bzta4Ao2w6OsWCTU/g5yH790
	M4g95QH3UshdcMme+izyw5ooXcsepw6LKnufUZ0hKOWJ2n+v7EN2DiIm7eLI6iUHxsqmhq219Dd
	YJtAPYDa2j9tfiaOnpCh
X-Google-Smtp-Source: AGHT+IEnziERpcS8fSeIMpIMfoMMkSi+Y3lTuaKa36pZyMGZnmo4+Ql2/npMHFIoeCpX6qxda+Pd4g==
X-Received: by 2002:a17:903:32c7:b0:216:69ca:7714 with SMTP id d9443c01a7336-21778398351mr7038685ad.11.1733864090485;
        Tue, 10 Dec 2024 12:54:50 -0800 (PST)
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com. [209.85.215.181])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fd564f6703sm2428344a12.49.2024.12.10.12.54.49
        for <acpica-devel@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2024 12:54:49 -0800 (PST)
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7fd51285746so1808996a12.3
        for <acpica-devel@lists.linux.dev>; Tue, 10 Dec 2024 12:54:49 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVeZ4pa++DWFxJY1mdXxcjSwNDi7cvgg4nG7sJWI37MrUzPfOyrrLVoz1Cx1Qan5KHSagd7SBYv4hHhFiA=@lists.linux.dev
X-Received: by 2002:a17:90b:1847:b0:2ee:e317:69ab with SMTP id
 98e67ed59e1d1-2f127e2ad4amr750621a91.0.1733864088749; Tue, 10 Dec 2024
 12:54:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241210-fix-ipu-v3-0-00e409c84a6c@chromium.org>
 <20241210-fix-ipu-v3-3-00e409c84a6c@chromium.org> <Z1iqTe5_tiJ_ehzU@kekkonen.localdomain>
In-Reply-To: <Z1iqTe5_tiJ_ehzU@kekkonen.localdomain>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 10 Dec 2024 21:54:37 +0100
X-Gmail-Original-Message-ID: <CANiDSCtPg7i_xfUuC7fR+c8A6-EQEoyEDttKP0U1HMg_BUrSdg@mail.gmail.com>
X-Gm-Features: AZHOrDnfdIek0WgcOyPHb9bMVRu7gZ-lsusONuIHTchFVSzbluwkZ1W9KCGCwsI
Message-ID: <CANiDSCtPg7i_xfUuC7fR+c8A6-EQEoyEDttKP0U1HMg_BUrSdg@mail.gmail.com>
Subject: Re: [PATCH v3 3/7] ACPI: bus: implement acpi_get_physical_device_location
 when !ACPI
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Robert Moore <robert.moore@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
	Dan Carpenter <dan.carpenter@linaro.org>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
	acpica-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Tue, 10 Dec 2024 at 21:53, Sakari Ailus <sakari.ailus@linux.intel.com> wrote:
>
> Hi Ricardo,
>
> On Tue, Dec 10, 2024 at 07:56:00PM +0000, Ricardo Ribalda wrote:
> > Provide an implementation of acpi_get_physical_device_location that can
> > be used when CONFIG_ACPI is not set.
> >
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> >
> > dasadsd
>
> Yes?
Leftovers from a squash :)

I will fix it on the next version if needed.
>
> Apart from this,
>
> Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
>
> >
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
>
> --
> Regards,
>
> Sakari Ailus



-- 
Ricardo Ribalda
