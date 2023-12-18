Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316F67205F
	for <acpica-devel@lists.linuxfoundation.org>; Mon, 18 Dec 2023 13:14:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CE8FE416A4
	for <acpica-devel@lists.linuxfoundation.org>; Mon, 18 Dec 2023 13:14:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CE8FE416A4
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.398
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IqrNo15vhxNI
	for <acpica-devel@lists.linuxfoundation.org>;
	Mon, 18 Dec 2023 13:14:47 +0000 (UTC)
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 16FF2415AB
	for <acpica-devel@lists.linuxfoundation.org>; Mon, 18 Dec 2023 13:14:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 16FF2415AB
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6da6576064dso458672a34.1
        for <acpica-devel@lists.linuxfoundation.org>; Mon, 18 Dec 2023 05:14:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702905286; x=1703510086;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7pNpyU2ryow+CaLgg5WjtqJLreEscZp2rrpn9BXxGtI=;
        b=ljLinxBx27njS2/CRyvYeBwg+ccQX/XF0KMrPXcqmujzv6DDkus866om6YZlq4edHE
         9Vi5xMeT7q9TbKVWx3NLy9N64gAy32YoZbgVXuuwnFO2zS8czwHrYAqWTuCrjZsku1qA
         lofwSVHL9+6njVebrkRolopvFryDj3ylPLZlhH4FCpdjKlWgNV325bYkHCQh5+WTdv2F
         jL7j6IplJyBv5YlAfPFMUpFoPRgk9laMKGCiFtAxQ9eUeAEa3ijvhqzEHVPM3lJMCiFf
         f/L1RNSSWaF7fTqb8JhRa+/eEINJ+l7iFRZYzJAotipw64SlliiZvyZEDKkmjB71rAO+
         QaCg==
X-Gm-Message-State: AOJu0YzbeB7R7bIyfUjUWPd2g+hvifvQEbE6blJQ0lKXrv5J8jZpllDx
	2HCajiL6jJgbOZ3bcoa7LmbfFW/zOUeDmt7VroQ=
X-Google-Smtp-Source: AGHT+IGUbGitVTHQvmgL9TrX5vuBwIcknqlxcDjvg6GX7UZ1bnRcd/SOCXRu68x81Op7UDAQkGoBQI9yiRAPn8sEAhY=
X-Received: by 2002:a05:6871:2284:b0:1fb:648:5207 with SMTP id
 sd4-20020a056871228400b001fb06485207mr29349775oab.2.1702905285904; Mon, 18
 Dec 2023 05:14:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <ZXmn46ptis59F0CO@shell.armlinux.org.uk> <E1rDOgs-00Dvko-6t@rmk-PC.armlinux.org.uk>
 <20231215162322.00007391@Huawei.com> <ZXyEiHLFBsoUkfNI@shell.armlinux.org.uk> <ZYAPhlwPUT/7dN4n@lpieralisi>
In-Reply-To: <ZYAPhlwPUT/7dN4n@lpieralisi>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 18 Dec 2023 14:14:30 +0100
Message-ID: <CAJZ5v0hyUqJspPbGTgTMSVHVBe=wHR6swPx-O3UcsH5dXDFpTA@mail.gmail.com>
Subject: Re: [PATCH RFC v3 13/21] ACPICA: Add new MADT GICC flags fields
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	linux-pm@vger.kernel.org, loongarch@lists.linux.dev, 
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

On Mon, Dec 18, 2023 at 10:23=E2=80=AFAM Lorenzo Pieralisi
<lpieralisi@kernel.org> wrote:
>
> On Fri, Dec 15, 2023 at 04:53:28PM +0000, Russell King (Oracle) wrote:
> > On Fri, Dec 15, 2023 at 04:23:22PM +0000, Jonathan Cameron wrote:
> > > On Wed, 13 Dec 2023 12:50:18 +0000
> > > Russell King (Oracle) <rmk+kernel@armlinux.org.uk> wrote:
> > >
> > > > From: James Morse <james.morse@arm.com>
> > > >
> > > > Add the new flag field to the MADT's GICC structure.
> > > >
> > > > 'Online Capable' indicates a disabled CPU can be enabled later. See
> > > > ACPI specification 6.5 Tabel 5.37: GICC CPU Interface Flags.
> > > >
> > > > Signed-off-by: James Morse <james.morse@arm.com>
> > > > Tested-by: Miguel Luis <miguel.luis@oracle.com>
> > > > Tested-by: Vishnu Pajjuri <vishnu@os.amperecomputing.com>
> > > > Tested-by: Jianyong Wu <jianyong.wu@arm.com>
> > > > Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> > >
> > > I see there is an acpica pull request including this bit but with a d=
ifferent name
> > > For reference.
> > > https://github.com/acpica/acpica/pull/914/commits/453a5f6756778652202=
1d5f6913f561f8b3cabf6
> > >
> > > +CC Lorenzo who submitted that.
> >
> > > > +#define ACPI_MADT_GICC_CPU_CAPABLE      (1<<3)   /* 03: CPU is onl=
ine capable */
> > >
> > > ACPI_MADT_GICC_ONLINE_CAPABLE
> >
> > It's somewhat disappointing, but no big deal. It's easy enough to chang=
e
> > "irqchip/gic-v3: Add support for ACPI's disabled but 'online capable' C=
PUs"
> > to use Lorenzo's name when that patch hits - and it becomes one less
> > patch in this patch set when Lorenzo's change eventually hits mainline.
> >
> > Does anyone know how long it may take for Lorenzo's change to get into
> > mainline? Would it be by the 6.8 merge window or the following one?
>
> I wish I knew. I submitted ACPICA changes for the online capable bit
> since I had to add additional flags on top (ie DMA coherent) and it
> would not make sense to submit the latter without the former.
>
> I'd be great if the ACPICA headers can make it into Linux for the upcomin=
g
> merge window, not sure what I can do to fasttrack the process though
> (I shall ping the maintainers).

If your upstream pull request has been merged, I can pick up Linux
patches carrying Link: tags pointing to the upstream ACPICA commits in
that pull request.

Thanks!
