Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7481750A63
	for <acpica-devel@lists.linux.dev>; Fri,  4 Oct 2024 17:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728063957; cv=none; b=l6eFk8aZRGmL0SlH3vvItJyA24kLoqtlb6LjP/3v/U1MQ6cYpqdNZpmmAy2ZtG+BOf01ibuFeOB+O258A9VHNKaOR9dkskGnyNtyidSW90zBeSTH5ytEauKHP6Z+ZEmGY0+rzOgxRtNsrdJbkcxGZXzvr1WrgoX93gJK1HstEFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728063957; c=relaxed/simple;
	bh=TI6mcXb4V5s95OY28ThDa+Nttx+DA0b7i9XYbIv6P9Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fZ2QG56JT5+kzk8d9YekmdmZJD1DqE25Y8NW1NgHUj1bUx3CTMsc3YI41UuzVUmiLqGS6XO7YHqBJ85i4xq59es1w6XVaxeqT/1Y/TijavBmDizrU6pDOHez93PoZuJuH7LNOppUjenCI7+tdbO+pCK/XS21mU8voe1x956GPIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=FheA6Zvu; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FheA6Zvu"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2e09fe0a878so1779901a91.1
        for <acpica-devel@lists.linux.dev>; Fri, 04 Oct 2024 10:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1728063955; x=1728668755; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1hTEi2pGCxMRGUpF5+1bzMouLoBbQyVgP6nKgujfGZc=;
        b=FheA6ZvuWalnpCrzaEFmRr7PCWtm9t4cRkwfJ04osyhakUzJurjC2avdIli/M8JyRI
         XNpQGeGzUj0Q6r1nKS38uYxqKKpgsJfvSDmbxhcnw82UNau7BjmcQtD3buvHttDvvhsO
         w4G7ZYM1rMySrPg4FPoHY+0CPDwEvTHEj4zG8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728063955; x=1728668755;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1hTEi2pGCxMRGUpF5+1bzMouLoBbQyVgP6nKgujfGZc=;
        b=vMRSwDX++rw6K6UCluEc/wviCgTZmxcu5Af/NqjVWhtGHnGh+U8GoqQqM804RiY7IM
         Ol9DrlQ2CTqV7m5imJbgxcjPXybU0CJrBIN6TTb5X3L0UEMp41rXTIRweXCOMNk8DZW0
         E+mvwz3S48XIcN5zk2/TXhgOlaaLx5Wub9ks9O0IWuzmkOgzf705+7v0eafFHZdAiv14
         lHQXcTtnWSlusyaMLDh7wPOhrPnmxjmVBXqijOfJhwuFvsoUMF9rot49NPgfa00vnSl+
         hs2aBQWFa/yohAg959HOCq1yTyNHJqYxdXH2w1rMGBSjG2FI76Q1rb5h3+1EuQ5yLP+O
         S8og==
X-Forwarded-Encrypted: i=1; AJvYcCWLwspyvCN63+G2GmuxRwSHqWEnNIS66sggaYoTsX/T9x9H9GDOGiypMZnZDRl+uZkb8OVGfSy6KgxB2Pw=@lists.linux.dev
X-Gm-Message-State: AOJu0Yyqr6Kb6ilJ6FQxDf3AO7ygD6UBl3iBjH8hBo5D/RbA8YU9D9dI
	/uHQHDzMo+XOUNhsNKZHaEtffP8Syd+/X+9e63pemFfEODCyBpkhACODV7w64Glz8tE9UWHnLrk
	=
X-Google-Smtp-Source: AGHT+IGZhHQVOoEadX4WDxCmCjkF7rqXtNEyAvkpx9c97pJlVJMvbFBqEEdxjdkF2j1mRjvxyjM1Ug==
X-Received: by 2002:a17:90b:1645:b0:2e0:a9e8:b9c1 with SMTP id 98e67ed59e1d1-2e1e6296d3fmr4008714a91.22.1728063955416;
        Fri, 04 Oct 2024 10:45:55 -0700 (PDT)
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com. [209.85.215.180])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e20b0f6380sm183893a91.40.2024.10.04.10.45.53
        for <acpica-devel@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Oct 2024 10:45:54 -0700 (PDT)
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-7d916b6a73aso1467251a12.1
        for <acpica-devel@lists.linux.dev>; Fri, 04 Oct 2024 10:45:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUwqasZ+gt+R1Wrws9UK62iOoNv8lhYp0fdy4TKbZT3JAnd8DWhy1WPIQ5OqqkFuJ2avlU7c0muI8LsmxE=@lists.linux.dev
X-Received: by 2002:a05:6a20:9f8f:b0:1d2:e1b5:2b51 with SMTP id
 adf61e73a8af0-1d6dfa1e516mr5534269637.8.1728063952820; Fri, 04 Oct 2024
 10:45:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240912173901.3969597-1-rrangel@chromium.org>
 <20240912113616.3.I1b7a5033a2191cb0cdbadc2d51666a97f16cc663@changeid> <CAJZ5v0hmf55OA1f4egzE7F0ET+7af_+pcxmnOSxO5Snd6L5CrQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0hmf55OA1f4egzE7F0ET+7af_+pcxmnOSxO5Snd6L5CrQ@mail.gmail.com>
From: Raul Rangel <rrangel@chromium.org>
Date: Fri, 4 Oct 2024 11:45:39 -0600
X-Gmail-Original-Message-ID: <CAHQZ30CRYoH_-rY7hMgasbkyqEBpgVfH6PZRzuaU=2g4S_oGtA@mail.gmail.com>
Message-ID: <CAHQZ30CRYoH_-rY7hMgasbkyqEBpgVfH6PZRzuaU=2g4S_oGtA@mail.gmail.com>
Subject: Re: [PATCH 3/3] ACPI: SPCR: Add support for rev 3
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-serial@vger.kernel.org, pmladek@suse.com, rafael.j.wysocki@intel.com, 
	ribalda@chromium.org, Len Brown <lenb@kernel.org>, 
	Robert Moore <robert.moore@intel.com>, acpica-devel@lists.linux.dev, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 2, 2024 at 12:13=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> On Thu, Sep 12, 2024 at 7:39=E2=80=AFPM Raul E Rangel <rrangel@chromium.o=
rg> wrote:
> >
> > Revision 3 supports specifying the UART input clock. This allows for
> > proper computation of the UART divisor when the baud rate is specified.
> >
> > The earlycon code can accept the following format (See `parse_options`
> > in `earlycon.c`.):
> > * <name>,io|mmio|mmio32|mmio32be,<addr>,<baud>,<uartclk>,<options>
> >
> > This change makes it so the uartclk is passed along if it's defined in
> > the SPCR table.
> >
> > Booting with `earlycon` and a SPCR v3 table that has the uartclk and
> > baud defined:
> > [    0.028251] ACPI: SPCR: console: uart,mmio32,0xfedc9000,115200,48000=
000
> > [    0.028267] earlycon: uart0 at MMIO32 0x00000000fedc9000 (options '1=
15200,48000000')
> > [    0.028272] printk: legacy bootconsole [uart0] enabled
> >
> > Link: https://learn.microsoft.com/en-us/windows-hardware/drivers/serpor=
ts/serial-port-console-redirection-table
> >
> > Signed-off-by: Raul E Rangel <rrangel@chromium.org>
> >
> > ---
> >
> >  drivers/acpi/spcr.c   | 5 ++++-
> >  include/acpi/actbl3.h | 6 +++---
> >  2 files changed, 7 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/acpi/spcr.c b/drivers/acpi/spcr.c
> > index cd36a97b0ea2c7..67ae42afcc59ef 100644
> > --- a/drivers/acpi/spcr.c
> > +++ b/drivers/acpi/spcr.c
> > @@ -209,9 +209,12 @@ int __init acpi_parse_spcr(bool enable_earlycon, b=
ool enable_console)
> >         if (!baud_rate) {
> >                 snprintf(opts, sizeof(opts), "%s,%s,0x%llx", uart, ioty=
pe,
> >                          table->serial_port.address);
> > -       } else {
> > +       } else if (table->header.revision <=3D 2 || !table->uartclk) {
> >                 snprintf(opts, sizeof(opts), "%s,%s,0x%llx,%d", uart, i=
otype,
> >                          table->serial_port.address, baud_rate);
> > +       } else {
> > +               snprintf(opts, sizeof(opts), "%s,%s,0x%llx,%d,%d", uart=
, iotype,
> > +                        table->serial_port.address, baud_rate, table->=
uartclk);
> >         }
> >
> >         pr_info("console: %s\n", opts);
> > diff --git a/include/acpi/actbl3.h b/include/acpi/actbl3.h
> > index 8f775e3a08fdfb..afe45a2379866a 100644
> > --- a/include/acpi/actbl3.h
> > +++ b/include/acpi/actbl3.h
>
> The part of the patch below is outdated - SPCR v4 is supported already.
>
> Please rebase on the current mainline kernel source.

Oh awesome. Should I send out all three patches again? Or just this
one? I think patches 1 and 2 can be merged.

>
> > @@ -92,10 +92,10 @@ struct acpi_table_slit {
> >  /*********************************************************************=
**********
> >   *
> >   * SPCR - Serial Port Console Redirection table
> > - *        Version 2
> > + *        Version 3
> >   *
> >   * Conforms to "Serial Port Console Redirection Table",
> > - * Version 1.03, August 10, 2015
> > + * Version 1.08, October 7, 2021
> >   *
> >   *********************************************************************=
*********/
> >
> > @@ -120,7 +120,7 @@ struct acpi_table_spcr {
> >         u8 pci_function;
> >         u32 pci_flags;
> >         u8 pci_segment;
> > -       u32 reserved2;
> > +       u32 uartclk;
> >  };
> >
> >  /* Masks for pci_flags field above */
> > --
> > 2.46.0.662.g92d0881bb0-goog
> >
