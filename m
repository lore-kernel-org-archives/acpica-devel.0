Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834073D65
	for <acpica-devel@lists.linux.dev>; Fri,  1 Mar 2024 14:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709303920; cv=none; b=ur3OeEu4hhR39Tc6wEcrZko5pP8QmP/GtWhKHAD0gUCeLNBBb/KocaxZMT7UKk5B5sSzN3wv29qhaWu0L0rZDGV2g0J6EGa6+WJGXjuypP75OFKi0Hu+uhAjBQfbz3iuSxQvafJYxvKqKeFThjQKV3x+658nH1ZrsQ1GIU843IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709303920; c=relaxed/simple;
	bh=X8ZIZZz6tfUgmhlnktpOJJ59LN5Nn7PzRITeojROZ6Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dfzyjJUw0AAUMogq0gaitkVW2shk0dMkFnFqu+gqZl4qHybIHe/QDt5kytwmMQcVEtApyg6V2jzxeBiMYsqyR8/bxWRqrlqHHe6rtNV/1PiGoL/QzQiBSE1YJ/HltOL9JIiJPvNQEgZnxlVENQga9Az3dBIDsuxVz4BBMvGc3fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cpp.in; spf=none smtp.mailfrom=cpp.in; dkim=pass (2048-bit key) header.d=cpp-in.20230601.gappssmtp.com header.i=@cpp-in.20230601.gappssmtp.com header.b=QX1hY0kL; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cpp.in
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cpp.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cpp-in.20230601.gappssmtp.com header.i=@cpp-in.20230601.gappssmtp.com header.b="QX1hY0kL"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-60978479651so15528747b3.3
        for <acpica-devel@lists.linux.dev>; Fri, 01 Mar 2024 06:38:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cpp-in.20230601.gappssmtp.com; s=20230601; t=1709303916; x=1709908716; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X8ZIZZz6tfUgmhlnktpOJJ59LN5Nn7PzRITeojROZ6Q=;
        b=QX1hY0kLhEiAnNEcAsmbnetPz+3e8M1yB0gDvJbk1XiItMLW09deUZlfWyw+v9nI7U
         ZjYihPHUM3R4bm6ZvNuqaNTk5p2CcTxl7xjuukqWZWOB56g5BrSVLZDm2JmPe8c6DmMZ
         9X8G5MjOqIdSNBac+q9yiTDVVzPs/OmgAxIkt/5xlVXOBVRnliw0FTAjvUoD1j55+dcr
         NwATsANYgJmyK0nabrZ8ZQ6OAGJ5b0xR783+/VIHsujO9Z21U8xnxl2d4P9bUYP8Cpbx
         PEYVb71ZG79alDgm/kcKN9MRveRftffR+RYv6uIKSxHrIp8p1bGnHBUAK0wT6OdsUQDU
         sM2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709303916; x=1709908716;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X8ZIZZz6tfUgmhlnktpOJJ59LN5Nn7PzRITeojROZ6Q=;
        b=Z/c17kPESlKjVPZJ3qcJENLzgqgTYiejfKblp02E58PsQzIqob0n9ZJpRvDvgb6jak
         sDVnUxgBzS611wkRtxRrAR6GaDmP6nPRzPT1ak5wGIBFtYwIZB/dhZeVGgZlJmnReVoF
         NgUVJgCrySIT8tMpbPo5japONhpLtrK6HIXEDM46hZFsV00o3P6ZwLjmZx/fBh8sWv+d
         nOxZw+EoWZptFzos9ocoOGJeGE0fdVzxaMiBhn8Sa/x8Ucu0fRtSIzvoc/d9JMs7BwDP
         NXvnjRLmLKB90Gii/kPJAWNx2d9ppN7nU8xbvdr/QzCxY5hissMc+YcmL1B8B9WlemC/
         CCFw==
X-Forwarded-Encrypted: i=1; AJvYcCXnFOhu20q3PIqILrOhYe4RXZX7d3bBQuTgHflV4s0mnwCX+ki4oPJtrfPfBTBLLMiHfUoEUSIbDt93DKEk0IIMFbKB5JP2TTGw83/9
X-Gm-Message-State: AOJu0YwdNenM6gIE2aUIVrWykgULOmYFZy1QM5aQ3EcaM9d3Jn1z76/w
	vo6ZliJZYqJPu7r1+VzSSnvHQCjXYmxM4Q+ATEYaeUL15yQDVbWc+YVNJjLs7cNKeuQBSZ9wSSd
	0SDI+oTBhFboshX6t6WnOOJs40DRTaNyRPZmS
X-Google-Smtp-Source: AGHT+IHkN6xOaUN9UECoQU+IRfaE0jc2wZukCIWfahyaN+qV06BLatN1ep7jb0o1NiV96VIBQsfEYuvljkgvuv2eZHE=
X-Received: by 2002:a25:ac68:0:b0:dca:e4fd:b6d5 with SMTP id
 r40-20020a25ac68000000b00dcae4fdb6d5mr1607076ybd.27.1709303916369; Fri, 01
 Mar 2024 06:38:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CABYkuAg3rcXT=0-=7EMX8NW3-mU0zYRvp+rOo5nq_7SHdb=cxA@mail.gmail.com>
 <20240216120211.GR8454@black.fi.intel.com> <CABYkuAhLYcLQp8PiBm-aTDC-AAV2NWVzN-79XLVcYvAfGtVhcQ@mail.gmail.com>
 <20240216144610.GS8454@black.fi.intel.com> <20240301074209.GM8454@black.fi.intel.com>
In-Reply-To: <20240301074209.GM8454@black.fi.intel.com>
From: aigilea <i@cpp.in>
Date: Fri, 1 Mar 2024 17:38:00 +0300
Message-ID: <CABYkuAi_vCc-kN_DSW0kPGACQKo+7B9GBckFiUsqGqTts7xXuQ@mail.gmail.com>
Subject: Re: Kernel panic in ACPICA on HP Spectre X360 (Meteor Lake 155H) laptop
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Robert Moore <robert.moore@intel.com>, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-acpi@vger.kernel.org, 
	acpica-devel@lists.linux.dev, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello.

Renaming the IC03 variable to the closest unused IC08 in the DSDT
overlay indeed fixes the crash.

Renaming/removing the device (as it looks like its only purpose is to
trigger Windows update to install some HP software) might be a cleaner
way but I'm not sure how to do this with overlays as this device is
declared in one of SSDT tables under the widely used _SB_.PC00.

For me personally this is good enough, but I'm not sure if it's a good
solution for a general case.

HP's attitude is unfortunate to say the least as the bug is so clear
and the fix is so simple. We've only bought a trial batch of ten
units, we'll return the ones that are still packed and go with some
other vendor from now on.

Thank you!




On Fri, Mar 1, 2024 at 10:42=E2=80=AFAM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> Hi again,
>
> On Fri, Feb 16, 2024 at 04:46:10PM +0200, Mika Westerberg wrote:
> > Hi,
> >
> > On Fri, Feb 16, 2024 at 05:36:21PM +0300, aigilea wrote:
> > > Hi.
> > >
> > > Booting with "modprobe.blacklist=3Dintel_lpss_pci" on the kernel comm=
and
> > > line indeed works around this panic.
> > > I will try to find out what hardware depends on this driver.
> > >
> > > Two years ago there was a similar issue with broken soundwire devices
> > > configuration in dsdt on tiger lake iteration of this laptop, it is
> > > not fixed by HP to this day.
> > > SOF guys in Intel ended up making a quirk for that case.
> > > So if the quirk (or some additional checks in parser?) path is not
> > > suitable for this issue I guess the most "proper" fix might be acpi
> > > overlay?
> >
> > I understood HP did this fix to their BIOS but it might take some time
> > to get the confirmation and the BIOS version (working on this).
>
> Unfortunately it turns out that HP only applied this fix for their Omen
> Transcent system and apparently there is not going to be updates on any
> other system that has this issue if it is not shipping with Linux :(
>
> So we probably need to figure out an alternative. The root cause is that
> the HP BIOS accidentally a device and a variable with the same name IC03
> and that gets resolved to the device instead of the variable in the
> _PS3() method where it calls Add(IC03, 1, 1).
>
> This was fixed by renaming the device into something else but I'm not
> entirely sure how this could be fixed in the kernel side or ACPICA.
