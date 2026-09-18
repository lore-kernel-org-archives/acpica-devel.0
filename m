Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92013DF008
	for <acpica-devel@lists.linuxfoundation.org>; Fri, 18 Sep 2026 14:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=140.211.166.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789742286; cv=fail; b=NfjVAG4Lbf0wrGPEN8Fd+TupCEgo1VbdzBDrySa5lylxEt942aOR/rkJNCQzKZvQT0xN0LuhP+D7zemLjZU2IjoKdeWc4Ipwp4FvSWQJM6JnP1AiT5yc9iSOeyaYfzGRZxrDKz148PXmuJPeehkPVPYCqbJytn4xBjCxfe0CbB8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789742286; c=relaxed/simple;
	bh=4ZilZJNHHY87uCtwLNAsqLEpobd2WFMMgoU4Rj3aqPI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oVZtShiNezNRHtug5YlPojYas4FefJhhxDD8Oiby6AH+mZIlq7lPdS4+hjcBNlBelYNTN5j9zeNQ+5YKY/WiyLTzc2jTC5RFWsG+GF7wJNPewMKGmWxlfCO16xNJEZyRsn/y0DMFL/0v9KUfgR4txBnbFsO+5PEkYCuVjMTlnws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m2dv6BPy; arc=fail smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m2dv6BPy"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A4B4240530
	for <acpica-devel@lists.linuxfoundation.org>; Fri, 18 Sep 2026 14:38:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -0.35
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kDeotJoKqXKz for <acpica-devel@lists.linuxfoundation.org>;
 Fri, 18 Sep 2026 14:38:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 0B87A40524
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789742283;
	b=Tq0nVUsxKmJIyCpCP7V7HVwczJcAbS5Cc7jhIc1epmfWmiBXJ1gz9w3pMWjMnevAuy2y
	 YCvQfRKUNETqutuvD0SpY3fXoDKIIuKe5sbYnMCN7bv5AGmq3Z6kI+e32HJxS93uXq4Vi
	 puPkamHV77XeDy9yLewMjSOylmGmPJCHVeg6yt0U0Is1AyqFH27sWiq+yzwiSuEn7vcfj
	 ux9hjIo16yvb1UQmRMHHTqkx9gblgmFVw9UX+ipq6I27z75dCw9018l4CEPL5RQMmf2ZL
	 7F26rZRk/jl6PN6gTxCAZ9I0WFNh3xfhdWsXPKUgx3963fOi1FXGAwK+LcTkHQRXiKA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789742283;
	h=Received-SPF:Received:Received:DKIM-Signature:Received:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gmail-Original-Message-ID:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=KBw1bExSXtsJEi/GDDkJ47SHkVdg0QHT3EHGaCOfe8o=;
	b=T70sv2EmlmgWhIM/W/2fIVBjnhvsYnxCQ0q1pVZU063R7ltrTjz34DlLjOq/0nSLO4yb
	 RyrXVzb51s7wwhU/tvfS0dIFZbq26S+zlmbxtuooSc9lKnrGSKEVauxjQmS5rc3oUhz83
	 dvTa3y35EWQwx9Gl2m5tgXu67FKcYuQbDAVBxwbiEKrNrUrfZAG0GY8DkUhIkliP9R4E3
	 jTc2GhJM9kM9cNehXMkTF0d6z32tz6DQxvspLtC5t2anropLyfh6nZP3KE4xu2jAS11GO
	 UPzLiVgcQHabU8k/afwKcWLPYBBhGaZMRWPHoVLYUFpeb1dmVMlRLjTsh0HpvpOlR+g==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m2dv6BPy;
	arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=rafael@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m2dv6BPy
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 0B87A40524
	for <acpica-devel@lists.linuxfoundation.org>; Fri, 18 Sep 2026 14:38:02 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id B45086053B
	for <acpica-devel@lists.linuxfoundation.org>; Fri, 18 Sep 2026 14:38:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CD9C1F00898
	for <acpica-devel@lists.linuxfoundation.org>; Fri, 18 Sep 2026 14:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789742280;
	bh=KBw1bExSXtsJEi/GDDkJ47SHkVdg0QHT3EHGaCOfe8o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=m2dv6BPyx3Zy0FMn6TPuVg7/QX11VEhW37M9oxxdKp0jNtCn17z/OrIpFaV/c10vJ
	 Wb8255I3NUyDZSP0NtNYbHkOgKimMPPu9LGMjgs1XaFefwD5l11n58XV94KQoFi0FY
	 OdoEUzjtdG3sOL5VhWAjcV7u6opNo3CXZh5pWdJLny8dJ2wqQgBEjxt6d8tdncdY0X
	 r2yUAJOFHG7mpFrxJcr9xDqYaz/OteVE3u9Ybb1TIZOdtVDokQ6svAY8y4tG5byVI0
	 mH/b1Tlk+H/xlq0fv9GEPDU/QL7VR9podspu67YlGNX46TjUsu6ZzgK+uMw0+iwh49
	 JQ0nzmAcAd+0Q==
Received: by mail-lr2-f12.google.com with SMTP id 38308e7fff4ca-3a5b2864f1cso7576951fa.3
        for <acpica-devel@lists.linuxfoundation.org>; Fri, 18 Sep 2026 07:38:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxPjsDEKsEv9VEtBOGk69EHOZZPoWvcw1c6Sn8CtYe3EEM6yyx+7gZrBDn9WLiRH7E9y9V9RPOxU7VBY4M=@lists.linuxfoundation.org
X-Gm-Message-State: AFuF++kbG4MVubnEfBpR2zgwZqGlCV6gOzIl2s1W8El8S8G39w+sd47l
	QFQDM3X1gliEOVredv/bL9SxTrn5aWY17nJGfVI9YPo2m/JCFanEo+c2aiWe07huPIyPTyZnB0p
	AuS2hLIGgPxsGQqaQ+CWUNJ4Fpl76dcY=
X-Received: by 2002:a2e:be1b:0:b0:39a:da70:2c77 with SMTP id
 38308e7fff4ca-3a5fbf05d53mr6133881fa.3.1789742278585; Fri, 18 Sep 2026
 07:37:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260819085528.575-2-baorliu@amd.com> <20260917143116.445-1-baorliu@amd.com>
In-Reply-To: <20260917143116.445-1-baorliu@amd.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 18 Sep 2026 16:36:31 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jb7QNF32To0AoOBxXHObUAS7QCrFAGObFJU1=VtOqm+w@mail.gmail.com>
X-Gm-Features: AcwNN1V21dznaWjpABNHjALTzsqliOCTgu4KiEbEf1Vn8RT6Yw4NYIp6-UdFsSY
Message-ID: <CAJZ5v0jb7QNF32To0AoOBxXHObUAS7QCrFAGObFJU1=VtOqm+w@mail.gmail.com>
Subject: Re: [PATCH v3] ACPI: button: Report wakeup key only for power button wakeups
To: "Baorui.Liu" <baorliu@amd.com>
Cc: rafael@kernel.org, lenb@kernel.org, robert.moore@intel.com, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	acpica-devel@lists.linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 17, 2026 at 4:31=E2=80=AFPM Baorui.Liu <baorliu@amd.com> wrote:
>
> The ACPI button driver reports KEY_WAKEUP from the Power Button input
> device to let userspace know that the system was resumed by a power
> button wakeup.
>
> However, reporting KEY_WAKEUP from generic system resume paths can make
> userspace observe a Power Button wakeup even when the system was resumed
> by a different wake source.
>
> This is reproducible on an AMD Android 15 Xen guest. With a kernel
> without this fix, a non-power-button S3 resume:
>
>   echo mem > /sys/power/state
>   xl trigger android s3resume
>
> makes the Power Button input device report KEY_WAKEUP. The same test on
> a kernel with this fix no longer reports KEY_WAKEUP from the Power Button
> input device.
>
> Track whether a power button event/notify is observed while the ACPI
> button device is suspended, and report KEY_WAKEUP on resume only in that
> case. Do not synthesize a Power Button input event from generic ACPI
> sleep resume code.
>
> Signed-off-by: Baorui.Liu <baorliu@amd.com>

Please see

https://sashiko.dev/#/patchset/20260917143116.445-1-baorliu%40amd.com

and tell me what you think.

Thanks!

> ---
>  drivers/acpi/button.c | 13 ++++++++++++-
>  drivers/acpi/sleep.c  | 41 -----------------------------------------
>  2 files changed, 12 insertions(+), 42 deletions(-)
>
> diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
> index cdbb1023a8ee..7a708fe351fb 100644
> --- a/drivers/acpi/button.c
> +++ b/drivers/acpi/button.c
> @@ -191,6 +191,7 @@ struct acpi_button {
>         bool last_state;
>         ktime_t last_time;
>         bool suspended;
> +       bool wakeup_pending;
>         bool lid_state_initialized;
>         bool gpe_enabled;
>  };
> @@ -476,6 +477,9 @@ static void acpi_button_notify(acpi_handle handle, u3=
2 event, void *data)
>
>         acpi_pm_wakeup_event(button->dev);
>
> +       if (button->type =3D=3D ACPI_BUTTON_TYPE_POWER && button->suspend=
ed)
> +               button->wakeup_pending =3D true;
> +
>         if (button->suspended || event =3D=3D ACPI_BUTTON_NOTIFY_WAKE)
>                 return;
>
> @@ -498,6 +502,11 @@ static void acpi_button_notify_run(void *data)
>
>  static u32 acpi_button_event(void *data)
>  {
> +       struct acpi_button *button =3D data;
> +
> +       if (button->type =3D=3D ACPI_BUTTON_TYPE_POWER && button->suspend=
ed)
> +               button->wakeup_pending =3D true;
> +
>         acpi_os_execute(OSL_NOTIFY_HANDLER, acpi_button_notify_run, data)=
;
>         return ACPI_INTERRUPT_HANDLED;
>  }
> @@ -508,6 +517,7 @@ static int acpi_button_suspend(struct device *dev)
>         struct acpi_button *button =3D dev_get_drvdata(dev);
>
>         button->suspended =3D true;
> +       button->wakeup_pending =3D false;
>         return 0;
>  }
>
> @@ -523,12 +533,13 @@ static int acpi_button_resume(struct device *dev)
>                 acpi_lid_initialize_state(button);
>         }
>
> -       if (button->type =3D=3D ACPI_BUTTON_TYPE_POWER) {
> +       if (button->type =3D=3D ACPI_BUTTON_TYPE_POWER && button->wakeup_=
pending) {
>                 input =3D button->input;
>                 input_report_key(input, KEY_WAKEUP, 1);
>                 input_sync(input);
>                 input_report_key(input, KEY_WAKEUP, 0);
>                 input_sync(input);
> +               button->wakeup_pending =3D false;
>         }
>         return 0;
>  }
> diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
> index 132a9df98471..7296e4bb0e4d 100644
> --- a/drivers/acpi/sleep.c
> +++ b/drivers/acpi/sleep.c
> @@ -104,8 +104,6 @@ u32 acpi_target_system_state(void)
>  }
>  EXPORT_SYMBOL_GPL(acpi_target_system_state);
>
> -static bool pwr_btn_event_pending;
> -
>  /*
>   * The ACPI specification wants us to save NVS memory regions during hib=
ernation
>   * and to restore them during the subsequent resume.  Windows does that =
also for
> @@ -484,7 +482,6 @@ static int acpi_pm_prepare(void)
>   */
>  static void acpi_pm_finish(void)
>  {
> -       struct acpi_device *pwr_btn_adev;
>         u32 acpi_state =3D acpi_target_sleep_state;
>
>         acpi_ec_unblock_transactions();
> @@ -503,23 +500,6 @@ static void acpi_pm_finish(void)
>         acpi_target_sleep_state =3D ACPI_STATE_S0;
>
>         acpi_resume_power_resources();
> -
> -       /* If we were woken with the fixed power button, provide a small
> -        * hint to userspace in the form of a wakeup event on the fixed p=
ower
> -        * button device (if it can be found).
> -        *
> -        * We delay the event generation til now, as the PM layer require=
s
> -        * timekeeping to be running before we generate events. */
> -       if (!pwr_btn_event_pending)
> -               return;
> -
> -       pwr_btn_event_pending =3D false;
> -       pwr_btn_adev =3D acpi_dev_get_first_match_dev(ACPI_BUTTON_HID_POW=
ERF,
> -                                                   NULL, -1);
> -       if (pwr_btn_adev) {
> -               pm_wakeup_event(&pwr_btn_adev->dev, 0);
> -               acpi_dev_put(pwr_btn_adev);
> -       }
>  }
>
>  /**
> @@ -626,27 +606,6 @@ static int acpi_suspend_enter(suspend_state_t pm_sta=
te)
>         /* Reprogram control registers */
>         acpi_leave_sleep_state_prep(acpi_state);
>
> -       /* ACPI 3.0 specs (P62) says that it's the responsibility
> -        * of the OSPM to clear the status bit [ implying that the
> -        * POWER_BUTTON event should not reach userspace ]
> -        *
> -        * However, we do generate a small hint for userspace in the form=
 of
> -        * a wakeup event. We flag this condition for now and generate th=
e
> -        * event later, as we're currently too early in resume to be able=
 to
> -        * generate wakeup events.
> -        */
> -       if (ACPI_SUCCESS(status) && (acpi_state =3D=3D ACPI_STATE_S3)) {
> -               acpi_event_status pwr_btn_status =3D ACPI_EVENT_FLAG_DISA=
BLED;
> -
> -               acpi_get_event_status(ACPI_EVENT_POWER_BUTTON, &pwr_btn_s=
tatus);
> -
> -               if (pwr_btn_status & ACPI_EVENT_FLAG_STATUS_SET) {
> -                       acpi_clear_event(ACPI_EVENT_POWER_BUTTON);
> -                       /* Flag for later */
> -                       pwr_btn_event_pending =3D true;
> -               }
> -       }
> -
>         /*
>          * Disable all GPE and clear their status bits before interrupts =
are
>          * enabled. Some GPEs (like wakeup GPEs) have no handlers and thi=
s can
> --
> 2.34.1
>
