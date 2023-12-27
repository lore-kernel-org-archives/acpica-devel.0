Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09EA147F6A
	for <acpica-devel@lists.linux.dev>; Wed, 27 Dec 2023 21:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fPg6yV15"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6d77c6437f0so1867902b3a.2
        for <acpica-devel@lists.linux.dev>; Wed, 27 Dec 2023 13:58:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703714281; x=1704319081; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WcrTUU3J9IYWoGMPmIQJtF7pUh/F9a2hMtGQGPiYA/E=;
        b=fPg6yV15ywFd0VVyU+NI02vjL04ehEt+mHDkxmTN/ydG/vhrKvize/sbGmYyEZdzAF
         ziupP89OnH9xEC8/5pSlALKaNVVz0Ox2VZaVG0+25uEk0dwOMhhoDk9w0OEqIik0pWA5
         e6SOIJJVI9ceDWcVz8YwVdkWaOzHqocI7ZeewK9vo9rGdt0GlCvW7co80elkZOILSlfG
         Q9rP1zKz881L5ythMCM6uImPC1heZVR661UCt3vvJhm+4WS+vunaAgG/h3xexNXFCy2N
         vO17gBOCEnR0pApt0GbTgPVEC6olycl42Z0gFa71xoocY69gpCRGC7f5ar+0DxvbqvFc
         Q9sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703714281; x=1704319081;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WcrTUU3J9IYWoGMPmIQJtF7pUh/F9a2hMtGQGPiYA/E=;
        b=XCj5YsHzyswGGfb7HYFz7mHmGa9hjmpBQwa9Cs8fx7YdyX66P0+c1btkfhxyOIuId2
         BeZ4jNddcUlG3+oHq4RVYhPgl/WKq494nMYx+mcl475Dn0ucaK3DEfR/eGqIbRiKH9nM
         82MXJ7Gex88otXp27vo9ZNA/VFrGk0qNmAySM1NTchUlRs9DWJvRztE17u4jOKwHCGit
         Xb7WMM+uXsNT8EqZEnyhdDQu1V+mRYjWou9DLkS7AgWQgjus5bnnHjIcOMkQkkIvrJlS
         Jzdebs+xvEXo9WV54hp779D1qdIPMSWXpqS2fB3OjAX2GIFHXeUUIt9XD6l0BgRToaiX
         rR7Q==
X-Gm-Message-State: AOJu0Ywb1paf6rClvvZUBFk7/8gKbhu5T/XbybN6vMP1lj1aBzZpeGJa
	voyEdPj4pAQ1E56CgIy12BDZrKuAN6Q=
X-Google-Smtp-Source: AGHT+IFaUJt40Jl7/C+6hDDHl+ZjSjoLEKjiR1w28CN8CQDGYNNzjEbfZHhBTqEmqWurqzgLoMuQSg==
X-Received: by 2002:a17:902:ce89:b0:1d4:13ca:ab26 with SMTP id f9-20020a170902ce8900b001d413caab26mr4726110plg.68.1703714281029;
        Wed, 27 Dec 2023 13:58:01 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y18-20020a170902b49200b001d0ce267eaesm12497692plr.250.2023.12.27.13.58.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Dec 2023 13:58:00 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 27 Dec 2023 13:57:59 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: jdelvare@suse.com, "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org, acpica-devel@lists.linux.dev
Subject: Re: [PATCH v2] hwmon: (acpi_power_meter) Ensure IPMI space handler
 is ready on Dell systems
Message-ID: <40694180-cc87-4ae2-9929-8451d43f428d@roeck-us.net>
References: <20231227040401.548977-1-kai.heng.feng@canonical.com>
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231227040401.548977-1-kai.heng.feng@canonical.com>

On Wed, Dec 27, 2023 at 12:04:00PM +0800, Kai-Heng Feng wrote:
> The following error can be observed at boot:
> [    3.717920] ACPI Error: No handler for Region [SYSI] (00000000ab9e62c5) [IPMI] (20230628/evregion-130)
> [    3.717928] ACPI Error: Region IPMI (ID=7) has no handler (20230628/exfldio-261)
> 
> [    3.717936] No Local Variables are initialized for Method [_GHL]
> 
> [    3.717938] No Arguments are initialized for method [_GHL]
> 
> [    3.717940] ACPI Error: Aborting method \_SB.PMI0._GHL due to previous error (AE_NOT_EXIST) (20230628/psparse-529)
> [    3.717949] ACPI Error: Aborting method \_SB.PMI0._PMC due to previous error (AE_NOT_EXIST) (20230628/psparse-529)
> [    3.717957] ACPI: \_SB_.PMI0: _PMC evaluation failed: AE_NOT_EXIST
> 
> On Dell systems several methods of acpi_power_meter access variables in
> IPMI region [0], so wait until IPMI space handler is installed by
> acpi_ipmi and also wait until SMI is selected to make the space handler
> fully functional.
> 
> [0] https://www.dell.com/support/manuals/en-us/redhat-enterprise-linux-v8.0/rhel8_rn_pub/advanced-configuration-and-power-interface-acpi-error-messages-displayed-in-dmesg?guid=guid-0d5ae482-1977-42cf-b417-3ed5c3f5ee62
> 
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
> v2:
>  - Use completion instead of request_module().
> 
>  drivers/acpi/acpi_ipmi.c         | 13 ++++++++++++-
>  drivers/hwmon/acpi_power_meter.c |  4 ++++
>  include/acpi/acpi_bus.h          |  4 ++++

This needs to be split into two patches.

>  3 files changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/acpi_ipmi.c b/drivers/acpi/acpi_ipmi.c
> index 0555f68c2dfd..2ea8b7e6cebf 100644
> --- a/drivers/acpi/acpi_ipmi.c
> +++ b/drivers/acpi/acpi_ipmi.c
> @@ -23,6 +23,8 @@ MODULE_LICENSE("GPL");
>  #define IPMI_TIMEOUT			(5000)
>  #define ACPI_IPMI_MAX_MSG_LENGTH	64
>  
> +static struct completion smi_selected;
> +
>  struct acpi_ipmi_device {
>  	/* the device list attached to driver_data.ipmi_devices */
>  	struct list_head head;
> @@ -463,8 +465,10 @@ static void ipmi_register_bmc(int iface, struct device *dev)
>  		if (temp->handle == handle)
>  			goto err_lock;
>  	}
> -	if (!driver_data.selected_smi)
> +	if (!driver_data.selected_smi) {
>  		driver_data.selected_smi = ipmi_device;
> +		complete(&smi_selected);
> +	}
>  	list_add_tail(&ipmi_device->head, &driver_data.ipmi_devices);
>  	mutex_unlock(&driver_data.ipmi_lock);
>  
> @@ -578,10 +582,17 @@ acpi_ipmi_space_handler(u32 function, acpi_physical_address address,
>  	return status;
>  }
>  
> +void wait_for_acpi_ipmi(void)
> +{
> +	wait_for_completion_interruptible_timeout(&smi_selected, 2 * HZ);

wait_for_completion_interruptible_timeout) returns an error code which
should be returned to the caller.

> +}
> +EXPORT_SYMBOL_GPL(wait_for_acpi_ipmi);
> +
>  static int __init acpi_ipmi_init(void)
>  {
>  	int result;
>  	acpi_status status;
> +	init_completion(&smi_selected);
>  
>  	if (acpi_disabled)
>  		return 0;
> diff --git a/drivers/hwmon/acpi_power_meter.c b/drivers/hwmon/acpi_power_meter.c
> index 703666b95bf4..acaf1ae68dc8 100644
> --- a/drivers/hwmon/acpi_power_meter.c
> +++ b/drivers/hwmon/acpi_power_meter.c
> @@ -883,6 +883,10 @@ static int acpi_power_meter_add(struct acpi_device *device)
>  	strcpy(acpi_device_class(device), ACPI_POWER_METER_CLASS);
>  	device->driver_data = resource;
>  
> +	if (dmi_match(DMI_SYS_VENDOR, "Dell Inc.") &&
> +	    acpi_dev_get_first_match_dev("IPI0001", NULL, -1))
> +		wait_for_acpi_ipmi();

wait_for_acpi_ipmi() should return an error code which
should be handled here.

> +
>  	res = read_capabilities(resource);
>  	if (res)
>  		goto exit_free;
> diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> index 1216d72c650f..ed59fb89721e 100644
> --- a/include/acpi/acpi_bus.h
> +++ b/include/acpi/acpi_bus.h
> @@ -655,6 +655,7 @@ bool acpi_device_override_status(struct acpi_device *adev, unsigned long long *s
>  bool acpi_quirk_skip_acpi_ac_and_battery(void);
>  int acpi_install_cmos_rtc_space_handler(acpi_handle handle);
>  void acpi_remove_cmos_rtc_space_handler(acpi_handle handle);
> +void wait_for_acpi_ipmi(void);
>  #else
>  static inline bool acpi_device_override_status(struct acpi_device *adev,
>  					       unsigned long long *status)
> @@ -672,6 +673,9 @@ static inline int acpi_install_cmos_rtc_space_handler(acpi_handle handle)
>  static inline void acpi_remove_cmos_rtc_space_handler(acpi_handle handle)
>  {
>  }
> +static inline void wait_for_acpi_ipmi(void)
> +{
> +}

Something with the conditional is wrong. See 0-day report.

Guenter
>  #endif
>  
>  #if IS_ENABLED(CONFIG_X86_ANDROID_TABLETS)
> -- 
> 2.34.1
> 
> 
