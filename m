Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4034F2F34;
	Thu, 13 Jun 2024 19:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718307248; cv=none; b=XNP94k8FX/JK2Noc9v3GLTic0/WaykWmGFAJ2XGqlIBntecgdPieYYCB1yLjXP3H7EDS5pPRRfNVwpbxKcJ8KEVfnlgqzgbBXlUCIPXdOIYo4DbMSMZDsdrE8edWEDJvQZjBXRn/b25kUpyUzEWPAdp/yIoPG14FjFt+aNJIcls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718307248; c=relaxed/simple;
	bh=bbhYqO6arj3VX7+rFvR2uC0Q/DGG5UGkw2Zn5smw2UQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PAyETDcKcfQ1p53f9kc2GPmolnMDIJigLrhsPVxVrjGZHYQv+xu+hN9gO7GMDGJL4z0zuMrtomFfwXpxgvMB2QYWB5N1h17+HieKEqAfb3LOLWCo1tVCJP8HixrriW3Eyonyi23TL9OMlRCPo5YMJ+/upWDQ/d7W6Wgqw6QY6mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J/jAt8L4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J/jAt8L4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2CF7C32786;
	Thu, 13 Jun 2024 19:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718307247;
	bh=bbhYqO6arj3VX7+rFvR2uC0Q/DGG5UGkw2Zn5smw2UQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=J/jAt8L4oCpQ1YVxKKZ28siux+nVS6qHGx3AtTokDUVX3mw5kOcBIm611//FsrK71
	 y6VuYeuM3vqnVbCp/cjbFh7Bq4N5XCDxAVL+Ktq9KmA/tRn4syVx7fgp9uKyJY6c7i
	 X/SpAeUAvm20OcrAnYw7foQLMA2pp7UJX+mjcHNvkztzTahN2qftaaOvigOP0EIr/k
	 q9H+YPRIIz/TApswNj6EVGkeaadOP3TAKfMG9DRC3/eTWQ0qe6wvngIOH/Z/iRaU7j
	 YhzvlSgSqdZQOCiEgSxhS22a6kFCT1ZC4x2V1H3dESgMSjD6usDExgR+q7bJKI7QeC
	 ltTAJDO0dfV2Q==
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5b99ba97d89so77890eaf.1;
        Thu, 13 Jun 2024 12:34:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXbFkvTmeC+T1T76WN7CuQdebU4hFKyaRr5t4mOjXyHHXl90UsGRpsFN6nQTZvXoj3c0w/udZSgP5cRtscKYvmaOblkdmWdINf75+urCtZICXMiQf91pqL7RT+Y7WXKd81i4R9zWWgjnsiGQSjf
X-Gm-Message-State: AOJu0YwHMQ1MBxlp3kOiwhFnkwSb4mzBoLr+J0XWabWjyPtkP5MT+ltz
	O4AwZrdZixVXa1TpNI+XMRbDDZldkhCDFsegdek/zn8cMfvt+dZ7Z1oXAEWqkJ+M/JO99BbbfCn
	HMQlw/czo4SNPH1vvHLyQvfgR1qU=
X-Google-Smtp-Source: AGHT+IG0G9y36mr+Dlfv2THcm6PYAW/FOqGLOg/QX0txRvOhtSWL6wvDXmnU00jM0TAGeT4jIFVoyY40op2reHRrX9s=
X-Received: by 2002:a4a:e1da:0:b0:5ba:ead2:c742 with SMTP id
 006d021491bc7-5bdad9f0343mr742290eaf.0.1718307247027; Thu, 13 Jun 2024
 12:34:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240610-cros_ec-charge-control-v3-0-135e37252094@weissschuh.net> <20240610-cros_ec-charge-control-v3-1-135e37252094@weissschuh.net>
In-Reply-To: <20240610-cros_ec-charge-control-v3-1-135e37252094@weissschuh.net>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 13 Jun 2024 21:33:56 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iUjvrs+57_meCkK7fcokH0j8sTAG3xXai5av_n5OHJwA@mail.gmail.com>
Message-ID: <CAJZ5v0iUjvrs+57_meCkK7fcokH0j8sTAG3xXai5av_n5OHJwA@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] ACPI: battery: add devm_battery_hook_register()
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>, 
	Sebastian Reichel <sre@kernel.org>, =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@weissschuh.net>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Robert Moore <robert.moore@intel.com>, Tzung-Bi Shih <tzungbi@kernel.org>, 
	chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, Mario Limonciello <mario.limonciello@amd.com>, 
	Dustin Howett <dustin@howett.net>, Stephen Horvath <s.horvath@outlook.com.au>, 
	Rajas Paranjpe <paranjperajas@gmail.com>, linux-acpi@vger.kernel.org, 
	acpica-devel@lists.linux.dev, Matt Hartley <matt.hartley@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 10, 2024 at 5:52=E2=80=AFPM Thomas Wei=C3=9Fschuh <linux@weisss=
chuh.net> wrote:
>
> Add a utility function for device-managed registration of battery hooks.
> The function makes it easier to manage the lifecycle of a hook.
>
> Signed-off-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>

Please feel free to add

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

to this patch and route it along with the rest of the series as needed.

Thanks!

> ---
>  drivers/acpi/battery.c | 15 +++++++++++++++
>  include/acpi/battery.h |  2 ++
>  2 files changed, 17 insertions(+)
>
> diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
> index b379401ff1c2..6ea979f76f84 100644
> --- a/drivers/acpi/battery.c
> +++ b/drivers/acpi/battery.c
> @@ -756,6 +756,21 @@ void battery_hook_register(struct acpi_battery_hook =
*hook)
>  }
>  EXPORT_SYMBOL_GPL(battery_hook_register);
>
> +static void devm_battery_hook_unregister(void *data)
> +{
> +       struct acpi_battery_hook *hook =3D data;
> +
> +       battery_hook_unregister(hook);
> +}
> +
> +int devm_battery_hook_register(struct device *dev, struct acpi_battery_h=
ook *hook)
> +{
> +       battery_hook_register(hook);
> +
> +       return devm_add_action_or_reset(dev, devm_battery_hook_unregister=
, hook);
> +}
> +EXPORT_SYMBOL_GPL(devm_battery_hook_register);
> +
>  /*
>   * This function gets called right after the battery sysfs
>   * attributes have been added, so that the drivers that
> diff --git a/include/acpi/battery.h b/include/acpi/battery.h
> index 611a2561a014..c93f16dfb944 100644
> --- a/include/acpi/battery.h
> +++ b/include/acpi/battery.h
> @@ -2,6 +2,7 @@
>  #ifndef __ACPI_BATTERY_H
>  #define __ACPI_BATTERY_H
>
> +#include <linux/device.h>
>  #include <linux/power_supply.h>
>
>  #define ACPI_BATTERY_CLASS "battery"
> @@ -19,5 +20,6 @@ struct acpi_battery_hook {
>
>  void battery_hook_register(struct acpi_battery_hook *hook);
>  void battery_hook_unregister(struct acpi_battery_hook *hook);
> +int devm_battery_hook_register(struct device *dev, struct acpi_battery_h=
ook *hook);
>
>  #endif
>
> --
> 2.45.2
>
>
