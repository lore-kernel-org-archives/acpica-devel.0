Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB41E675CF
	for <acpica-devel@lists.linuxfoundation.org>; Thu, 14 Dec 2023 17:47:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5ECC760B3F
	for <acpica-devel@lists.linuxfoundation.org>; Thu, 14 Dec 2023 17:47:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5ECC760B3F
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.398
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hjR6WyLpMZ3U
	for <acpica-devel@lists.linuxfoundation.org>;
	Thu, 14 Dec 2023 17:47:12 +0000 (UTC)
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	by smtp3.osuosl.org (Postfix) with ESMTPS id AEC0660B2A
	for <acpica-devel@lists.linuxfoundation.org>; Thu, 14 Dec 2023 17:47:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AEC0660B2A
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6d9d6f8485eso1160414a34.0
        for <acpica-devel@lists.linuxfoundation.org>; Thu, 14 Dec 2023 09:47:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702576031; x=1703180831;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jCI4p6q1rK4WR6fVDr3BUQoNcZe5c1Ddy3SGZDHoC9U=;
        b=vODTy34h9cqcgGCi9ko0vcWv+xY0TKn+cVVRR7NuTeDUS/IfniOnRpoyLNXnE0tjV0
         u8FCPkowcnZiml1CJvI5hmh2heZATZsVgXpVGDQ15J9OAXXqMLqU8Z5aQV4rMXrdcGAH
         DWfknyc05M9GD+kf87cKoe7HbKwDU7K/ygAXXs4shNVJy6VHsuedeo1Y7+ug/cmR5pGL
         2xGjHXw36ZeucOx/CttS7kGF2irJodJFY6thVxmu6MVyfbfFzmjZ0/LoymYnqnI6zVzm
         ywNadiwH8Rq1p27aWgTQegL4gOeTdPpSsJxVb8Yx0CKlvNmopNNEWqK68NH4rca1P5O1
         4x8A==
X-Gm-Message-State: AOJu0Yxc0na7MD4u78qzWSVgZD6Q8vsLlqT+miem2m/QQ/rN3zaSeovv
	Pw2fy0o+bTkhLgMh962Fllx/1TJD8X2blqVlFLA=
X-Google-Smtp-Source: AGHT+IGurc+SThWqv6P5Uf59nE4Wm9v4g9qg7EdGZTjEpgesMiWT90sz1j7aRR9N4IauQQSUFNdIYafJpqeTsCWmoDQ=
X-Received: by 2002:a05:6870:20b:b0:203:5389:5afd with SMTP id
 j11-20020a056870020b00b0020353895afdmr1641660oad.5.1702576031481; Thu, 14 Dec
 2023 09:47:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <ZXmn46ptis59F0CO@shell.armlinux.org.uk> <E1rDOfs-00DvjY-HQ@rmk-PC.armlinux.org.uk>
 <20231214173241.0000260f@Huawei.com>
In-Reply-To: <20231214173241.0000260f@Huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 14 Dec 2023 18:47:00 +0100
Message-ID: <CAJZ5v0jymOtZ0y65K9wE8FJk+ZKwP+FoGm4AKHXcYVfQJL9MVw@mail.gmail.com>
Subject: Re: [PATCH RFC v3 01/21] ACPI: Only enumerate enabled (or functional) devices
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, linux-pm@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-acpi@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org, 
	kvmarm@lists.linux.dev, x86@kernel.org, 
	acpica-devel@lists.linuxfoundation.org, linux-csky@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-ia64@vger.kernel.org, 
	linux-parisc@vger.kernel.org, Salil Mehta <salil.mehta@huawei.com>, 
	Jean-Philippe Brucker <jean-philippe@linaro.org>, jianyong.wu@arm.com, justin.he@arm.com, 
	James Morse <james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 14, 2023 at 6:32=E2=80=AFPM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Wed, 13 Dec 2023 12:49:16 +0000
> Russell King (Oracle) <rmk+kernel@armlinux.org.uk> wrote:
>
> > From: James Morse <james.morse@arm.com>
> >
> > Today the ACPI enumeration code 'visits' all devices that are present.
> >
> > This is a problem for arm64, where CPUs are always present, but not
> > always enabled. When a device-check occurs because the firmware-policy
> > has changed and a CPU is now enabled, the following error occurs:
> > | acpi ACPI0007:48: Enumeration failure
> >
> > This is ultimately because acpi_dev_ready_for_enumeration() returns
> > true for a device that is not enabled. The ACPI Processor driver
> > will not register such CPUs as they are not 'decoding their resources'.
> >
> > Change acpi_dev_ready_for_enumeration() to also check the enabled bit.
> > ACPI allows a device to be functional instead of maintaining the
> > present and enabled bit. Make this behaviour an explicit check with
> > a reference to the spec, and then check the present and enabled bits.
> > This is needed to avoid enumerating present && functional devices that
> > are not enabled.
> >
> > Signed-off-by: James Morse <james.morse@arm.com>
> > Tested-by: Miguel Luis <miguel.luis@oracle.com>
> > Tested-by: Vishnu Pajjuri <vishnu@os.amperecomputing.com>
> > Tested-by: Jianyong Wu <jianyong.wu@arm.com>
> > Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> > ---
> > If this change causes problems on deployed hardware, I suggest an
> > arch opt-in: ACPI_IGNORE_STA_ENABLED, that causes
> > acpi_dev_ready_for_enumeration() to only check the present bit.
>
> My gut feeling (having made ACPI 'fixes' in the past that ran into
> horribly broken firmware and had to be reverted) is reduce the blast
> radius preemptively from the start. I'd love to live in a world were
> that wasn't necessary but I don't trust all the generators of ACPI tables=
.
> I'll leave it to Rafael and other ACPI experts suggest how narrow we shou=
ld
> make it though - arch opt in might be narrow enough.

A chicken bit wouldn't help much IMO, especially in the cases when
working setups get broken.

I would very much prefer to limit the scope of it, say to processors
only, in the first place.
