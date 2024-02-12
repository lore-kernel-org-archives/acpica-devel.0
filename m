Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2EF43CF7E
	for <acpica-devel@lists.linux.dev>; Mon, 12 Feb 2024 13:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707745468; cv=none; b=gnwo+kLuRNE4otnzo639NxIGFb5et3OUe6IxLoOBnrS9uDN5Z8SxB/QiXkm6gBs/GVfMzQAChuYi0oKo3fRUJQkBezCKWdJ8UL+lSqHYUM+ScewIgsna2yJhJ60U9s1cp/eEnThj8TN1bzxeiAsoSTcKPgpb7S8H1O0FAZNnYtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707745468; c=relaxed/simple;
	bh=ppWjXqvOz7E5NKyhtw98QvPMgUwleYBISgwi5Vq2qHk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wt/c01UIRgr7NtbdXHHjaoUEN4slpNrPgwip3Z586+zILPZW04SlRkcEVzzlRq7sXeUflr/YwJmGq/TaGKSZByQBceRgJnU8x3/UlNhtke3kdeYpz/epX46iwcMiE6wlmgQ1jmn3Jz7f4/J4q1vJlqVyT9OqB7rYn37ZvrOtZAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-59d29103089so95619eaf.0
        for <acpica-devel@lists.linux.dev>; Mon, 12 Feb 2024 05:44:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707745465; x=1708350265;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ppWjXqvOz7E5NKyhtw98QvPMgUwleYBISgwi5Vq2qHk=;
        b=LVyukXhSXIFtGRWymKjGWMt9Gw8DyWlcJUCzpVW3oFkOT/qnx0EuxYIU8Rlr4l+XK6
         zHk4Sf6LcewbLsmIRr23hft5yor0xKig9nPkYiH0/ZXW5mfaAoyA4PuSOT2LFGLu9BOF
         YBWIEPR4Ytclod+SihgDQcGEMawBK1jkBhNvpf1mJfDDBmuxijCOTBuMY5H749HHGyU6
         RGMpTVWmDj1aiWO2V5pAfe5OdkFELYy9DrA7uRLSXsde4eqHQHgBI4p7eWThcGQh3M0V
         2CXCXi0doawieFcIydAlAXmpf5NR6a9UjipHUvRCn0MnJc98adR6MsD4Ck0T52/JUoNo
         pVCA==
X-Forwarded-Encrypted: i=1; AJvYcCUfhrNj5saPzVUG/Q3J9EesPXfy7fkRed2xgOw8lchGMT89nbmBN4NOFNkQS0y7bbZLVpi79+HZXahs3N2dM8i1Wibk1ARE2rwtHOjG
X-Gm-Message-State: AOJu0YygbnoRLXnsu+ZFyZocIw50sHLbACU32GFbi65eNz+tEsm3DM5u
	lY7/bw5OR8BA5TeKPv/zPTnwV9E6oGQZXz/4tW76slbMwqPCGVz0g1bFOiPLM1xibktY3DwpX5j
	d+qVLN9i99YY1Yri3+gjO0qAm0zY=
X-Google-Smtp-Source: AGHT+IFt5zZFUHvxaPO9xM2x/WE9iUUFA8RIXi0YERKym3ViZ6pXarboaXioZcO82blmx8jq0lZVwjFNXcBjvAMgJE8=
X-Received: by 2002:a4a:ee91:0:b0:59c:7c63:928f with SMTP id
 dk17-20020a4aee91000000b0059c7c63928fmr4934727oob.0.1707745465516; Mon, 12
 Feb 2024 05:44:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240211-bus_cleanup-acpi-v1-1-08540c6e9458@marliere.net> <2024021222-overhead-kudos-3565@gregkh>
In-Reply-To: <2024021222-overhead-kudos-3565@gregkh>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 12 Feb 2024 14:44:14 +0100
Message-ID: <CAJZ5v0i3Qa+i2jx_G-0B3dYuD5av2NbCpXe=pGfrSFtSch3f-g@mail.gmail.com>
Subject: Re: [PATCH] ACPI: bus: make acpi_bus_type const
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Ricardo B. Marliere" <ricardo@marliere.net>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Robert Moore <robert.moore@intel.com>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, acpica-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 12, 2024 at 11:44=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Sun, Feb 11, 2024 at 12:37:11PM -0300, Ricardo B. Marliere wrote:
> > Now that the driver core can properly handle constant struct bus_type,
> > move the acpi_bus_type variable to be a constant structure as well,
> > placing it into read-only memory which can not be modified at runtime.
> >
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Applied as 6.9 material, thanks!
