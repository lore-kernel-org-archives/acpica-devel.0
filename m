Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63FC74D6C4A
	for <acpica-devel@lists.linuxfoundation.org>; Mon, 12 Oct 2026 18:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=140.211.166.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791829285; cv=fail; b=gC72FkOF6Gzds2EsyLTvDTVhUCgIfCH9+oxzHfYL41elkcecOABnxLsbd8hoqlIIVGmE+8kAWdHk5TQR2CyLhyWZJH/++3W+UnPf6zQtwGo3VJa99tYbReXfiOFpjMHYnCOyViYh1fYPYk0CD6zujtbJGLM+2Qg47iVdTeGUW9o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791829285; c=relaxed/simple;
	bh=RnY8lPHIFP3jmQr3m+6xqpYC8Mv4DIN5BZGA5Z0IwSI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qAA6sy72yxWfV95oLpns3tJd2BVqCgjvn2rs7pSiOhkYCvZ0otj8E5fDbUk0xWtRMyo6xAbjWldlS+RGqV74yXXKakd69h6gM5URmqKNDRWFW3CS5DAvDyll8QjFL4EmH+ThEnK15zcESXeV4xvyPdv8QG7tj1ZNf9SVcjL9IXE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nytZ1PIK; arc=fail smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nytZ1PIK"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EF957605FA
	for <acpica-devel@lists.linuxfoundation.org>; Mon, 12 Oct 2026 18:21:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -0.59
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hmK5pcIvVcRy for <acpica-devel@lists.linuxfoundation.org>;
 Mon, 12 Oct 2026 18:21:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D9A2C605E8
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791829283;
	b=tTPHKYJxiGRGbz0fVs07mzB+ObCLW8EhXr2n3Of65W201aMGou2mJ04Jf4beuOD+QaCB
	 vVWShVRtu7aR2FoxI3Zsx1ORsrPGEPwtBFRRdSbmcWK2jGgtZMRgHTDZtyZzsPqKS5YjY
	 26LH2flSdFDlo55JcGQa0GYwaf6CMV4ZVRk9wfT9BFkkX2JdHssi60yOJ/m1pw+3MMaDf
	 88yNDZs/oxeedCEHyrFYeR4sXL5w6biePLPHKASReLyeCg17C4jAOOcrhBxulUbohH8Ry
	 PBOvBMv5SvQYrmmkvdY466tTI7o1M+6DHT5Eh4+twf42FGXZWufiWfroy1z2k/jRbrg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791829283;
	h=Received-SPF:Received:Received:DKIM-Signature:Received:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gmail-Original-Message-ID:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=GCKWXxEM7wbFA/APNv4BotWXro/we/hiP8BlFU4oiJg=;
	b=orwt2L3/V+LIjx5fB0W+8K+Rm4MER13RSD82xxTYfZ2t4k0W1N8H2URRW3BKkho9dGT2
	 Y4hW6a4S98vf6gq8nrFfbktOjn5TTvQd+olbBx+igxTO5PI3tyeWWrLpihaWYBhqtD6w6
	 BXTbOFuY2jZ47ELvmccqNYFNqDBJMKL/aLkmmaHh/ygDxrXVtthkyAsZU9Jj+/bmzEGsH
	 KRM4wHYaIQjwIUtit1vn7p7wnrhJnsWQ2e9Z9YT0ARTxhHAIWd86QxGbO9MU3JRi9IFX9
	 bfbxlu6dhMEmG0wWd9nAT8KzN/XkSNYMITnVzdYuqvl8dh328IYpTwPtsIKMr05suww==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nytZ1PIK;
	arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=rafael@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nytZ1PIK
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	by smtp3.osuosl.org (Postfix) with ESMTPS id D9A2C605E8
	for <acpica-devel@lists.linuxfoundation.org>; Mon, 12 Oct 2026 18:21:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 98E57405A6
	for <acpica-devel@lists.linuxfoundation.org>; Mon, 12 Oct 2026 18:21:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C0281F008A3
	for <acpica-devel@lists.linuxfoundation.org>; Mon, 12 Oct 2026 18:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791829281;
	bh=GCKWXxEM7wbFA/APNv4BotWXro/we/hiP8BlFU4oiJg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=nytZ1PIKnwCbPznACBxrltd7zXVnlXHe7vXlu4KnDV6S4JEkc++0mecKRXOgWTKAA
	 BmYLzxnqv/rRXhkR4HLdhBWE/JEl0NpxOJF5n95GLHBXY2UANSSZWvEGPxolIxWX47
	 ibW3X9hontKkdy+xyhO24vF/agUqArY/XeLlzYmxJ+iFfwCyeaNuFTvRf8Y36sX8sz
	 tvV02kCdP3y305fAN2kHYF+abE2OQY6fN43pGf3HhoqXmp0THtt8+yA9H48kAU7QZC
	 DEuzu83sPzYYTenAad1Dydub/KMExPXUsF2V4o885i0Lydm3l+PEx2VtuPq+/xlRQj
	 IuQdtxEh+Immg==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5bcb440d1cbso1027561e87.1
        for <acpica-devel@lists.linuxfoundation.org>; Mon, 12 Oct 2026 11:21:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzMBjN9c9Ab/GbTtqRJS8WHcyHVoZhACnk7pqE/xS3YVqEcRYnuQLBujAQOKIkr7t3bdo5PSE7QDla9aJE=@lists.linuxfoundation.org
X-Gm-Message-State: AFq9FYIH24mdXV2UjjBOm+haoA6Ar/4VYMOl6asimUdTbJnQyBYE/612
	4zgYE/zTbIEJFzHTPR9ihpuQw2KqjlZb9nYqmUJ6g1/7W5K6HUZnoP4jGl54z4NxeBCTjVAMmKU
	O9GY5ypx5TTAM8uRPwF4PdUtbJ8KXipI=
X-Received: by 2002:a05:6512:158b:b0:5bc:db4b:930e with SMTP id
 2adb3069b0e04-5bcdd5317a8mr3088103e87.28.1791829279852; Mon, 12 Oct 2026
 11:21:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260922024232.816-1-baorliu@amd.com> <20261012060847.486-1-baorliu@amd.com>
In-Reply-To: <20261012060847.486-1-baorliu@amd.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Mon, 12 Oct 2026 20:19:16 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0h_136ACZzxQ=MdvRx_7iYRu3L3z1tY01ONfkSz5JEXzw@mail.gmail.com>
X-Gm-Features: AclHuK_tHMLoic4JTE_J6o2cp2lr4wxlud2cMNMVANjSB0lQNuZd5IoVuv9XxXI
Message-ID: <CAJZ5v0h_136ACZzxQ=MdvRx_7iYRu3L3z1tY01ONfkSz5JEXzw@mail.gmail.com>
Subject: Re: [PATCH v5] ACPI: button: Report wakeup key only for power button wakeups
To: "Baorui.Liu" <baorliu@amd.com>
Cc: rafael@kernel.org, lenb@kernel.org, robert.moore@intel.com, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	acpica-devel@lists.linuxfoundation.org, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 12, 2026 at 8:09=E2=80=AFAM Baorui.Liu <baorliu@amd.com> wrote:
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
> case.
>
> When the fixed power-button status bit is set during early S3 resume,
> clear it to avoid a deferred KEY_POWER delivery to userspace, and mark
> wakeup_pending so button resume can still report KEY_WAKEUP. Also clear
> wakeup_pending before setting suspended to avoid a race with a power
> button SCI during suspend entry.
>
> Declare acpi_button_power_wakeup_pending() with IS_REACHABLE so that
> CONFIG_ACPI_BUTTON=3Dm does not leave an unresolved reference in built-in
> sleep.c.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/r/202609290454.LJrhMCb3-lkp@intel.com/
> Signed-off-by: Baorui.Liu <baorliu@amd.com>
> ---
> Changes since v4:
> - Fix LKP build ERROR when CONFIG_ACPI_BUTTON=3Dm by declaring
>   acpi_button_power_wakeup_pending() with IS_REACHABLE().

Please see the Sashiko feedback on this patch:

https://sashiko.dev/#/patchset/20261012060847.486-1-baorliu%40amd.com

and let me know what you think about it.

Thanks!

>  drivers/acpi/button.c | 46 ++++++++++++++++++++++++++++++++++++++++++-
>  drivers/acpi/sleep.c  | 27 +++++++++++--------------
>  include/acpi/button.h | 13 ++++++++++++
>  3 files changed, 70 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
> index cdbb1023a8ee..c07de417df5d 100644
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
> @@ -397,6 +398,34 @@ static void acpi_lid_forget(struct acpi_device *adev=
)
>  }
>
>  /* Driver Interface */
> +/**
> + * acpi_button_power_wakeup_pending - Mark fixed power button wakeup pen=
ding.
> + *
> + * Used when the fixed power-button status bit is observed and cleared d=
uring
> + * early S3 resume, so KEY_WAKEUP can still be reported from button resu=
me
> + * without delivering a deferred KEY_POWER to userspace.
> + */
> +void acpi_button_power_wakeup_pending(void)
> +{
> +       struct acpi_device *adev;
> +       struct device *phys_dev;
> +       struct acpi_button *button;
> +
> +       adev =3D acpi_dev_get_first_match_dev(ACPI_BUTTON_HID_POWERF, NUL=
L, -1);
> +       if (!adev)
> +               return;
> +
> +       phys_dev =3D acpi_get_first_physical_node(adev);
> +       if (phys_dev) {
> +               button =3D dev_get_drvdata(phys_dev);
> +               if (button && button->type =3D=3D ACPI_BUTTON_TYPE_POWER)
> +                       button->wakeup_pending =3D true;
> +       }
> +
> +       acpi_dev_put(adev);
> +}
> +EXPORT_SYMBOL_GPL(acpi_button_power_wakeup_pending);
> +
>  int acpi_lid_open(void)
>  {
>         guard(mutex)(&acpi_lid_lock);
> @@ -476,6 +505,9 @@ static void acpi_button_notify(acpi_handle handle, u3=
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
> @@ -498,6 +530,11 @@ static void acpi_button_notify_run(void *data)
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
> @@ -507,6 +544,12 @@ static int acpi_button_suspend(struct device *dev)
>  {
>         struct acpi_button *button =3D dev_get_drvdata(dev);
>
> +       /*
> +        * Clear wakeup_pending before marking suspended. Otherwise a pow=
er
> +        * button SCI between the two stores could set wakeup_pending and=
 then
> +        * be overwritten here, losing a real wakeup.
> +        */
> +       button->wakeup_pending =3D false;
>         button->suspended =3D true;
>         return 0;
>  }
> @@ -523,12 +566,13 @@ static int acpi_button_resume(struct device *dev)
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
> index 132a9df98471..30e268987e37 100644
> --- a/drivers/acpi/sleep.c
> +++ b/drivers/acpi/sleep.c
> @@ -22,6 +22,7 @@
>  #include <linux/syscore_ops.h>
>  #include <asm/io.h>
>  #include <trace/events/power.h>
> +#include <acpi/button.h>
>
>  #include "internal.h"
>  #include "sleep.h"
> @@ -504,12 +505,11 @@ static void acpi_pm_finish(void)
>
>         acpi_resume_power_resources();
>
> -       /* If we were woken with the fixed power button, provide a small
> -        * hint to userspace in the form of a wakeup event on the fixed p=
ower
> -        * button device (if it can be found).
> -        *
> -        * We delay the event generation til now, as the PM layer require=
s
> -        * timekeeping to be running before we generate events. */
> +       /*
> +        * If woken by the fixed power button, provide a wakeup event on =
that
> +        * device. KEY_WAKEUP input reporting is handled by the button dr=
iver
> +        * via wakeup_pending; do not synthesize KEY_POWER here.
> +        */
>         if (!pwr_btn_event_pending)
>                 return;
>
> @@ -626,14 +626,11 @@ static int acpi_suspend_enter(suspend_state_t pm_st=
ate)
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
> +       /*
> +        * ACPI 3.0 (P62): OSPM should clear the fixed power-button statu=
s bit
> +        * so the event does not reach userspace as KEY_POWER. Remember t=
hat a
> +        * power-button wake occurred so button resume can report KEY_WAK=
EUP
> +        * and acpi_pm_finish() can emit a PM wakeup event.
>          */
>         if (ACPI_SUCCESS(status) && (acpi_state =3D=3D ACPI_STATE_S3)) {
>                 acpi_event_status pwr_btn_status =3D ACPI_EVENT_FLAG_DISA=
BLED;
> @@ -642,8 +639,8 @@ static int acpi_suspend_enter(suspend_state_t pm_stat=
e)
>
>                 if (pwr_btn_status & ACPI_EVENT_FLAG_STATUS_SET) {
>                         acpi_clear_event(ACPI_EVENT_POWER_BUTTON);
> -                       /* Flag for later */
>                         pwr_btn_event_pending =3D true;
> +                       acpi_button_power_wakeup_pending();
>                 }
>         }
>
> diff --git a/include/acpi/button.h b/include/acpi/button.h
> index af2fce5d2ee3..c909c00664c7 100644
> --- a/include/acpi/button.h
> +++ b/include/acpi/button.h
> @@ -15,4 +15,17 @@ static inline int acpi_lid_open(void)
>  }
>  #endif /* IS_ENABLED(CONFIG_ACPI_BUTTON) */
>
> +/*
> + * sleep.c is built-in and calls this helper. Use IS_REACHABLE so that w=
hen
> + * CONFIG_ACPI_BUTTON=3Dm the call site gets an inline stub instead of a=
n
> + * unresolved vmlinux link reference (0day/LKP ERROR).
> + */
> +#if IS_REACHABLE(CONFIG_ACPI_BUTTON)
> +extern void acpi_button_power_wakeup_pending(void);
> +#else
> +static inline void acpi_button_power_wakeup_pending(void)
> +{
> +}
> +#endif /* IS_REACHABLE(CONFIG_ACPI_BUTTON) */
> +
>  #endif /* ACPI_BUTTON_H */
>
> base-commit: 4a819ee5f2834330656d6ac168c4c8cf27fdeec2
> --
> 2.34.1
>
