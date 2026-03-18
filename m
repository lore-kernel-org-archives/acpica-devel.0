Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD4C8462
	for <acpica-devel@lists.linux.dev>; Wed, 18 Mar 2026 18:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773860036; cv=none; b=YCGuYax+gLP8RfaTDjODWpbltJsiJwCNiu/f9DVQHllCjTEsuJdQGui+8uYuzbClqfGAADg76SdHjDTTai0Ov+33AxUjStEDU6rlgQ+gLQYAmTnQb2BPj1nmOONd6uisPlqNWrnWR/ziRmSlTksMmaVYEa924/809VeECZ0jqjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773860036; c=relaxed/simple;
	bh=4vwHuZhCBdWEo7/LYVTBkP2edEov7tQ4NKjrZQI1un0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=mkevCLhmCnLrEgF/yQEjf/KcDSaCkbfFCjaoUX1ZpqP47LHuvCz08yuW8UWtG0SzTgThw6a/rtftF61iA3AwrBEM8S8E1K7+1jgmI5mVkEN0WrzCqjNfDDNJXaNZ6DffbtzXa1JuNUCCfw9cnYnoL2xgZbt8vYOtE9t9ieHH23o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YCVw0WFn; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YCVw0WFn"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-829afe24fb5so211373b3a.0
        for <acpica-devel@lists.linux.dev>; Wed, 18 Mar 2026 11:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773860032; x=1774464832; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=hh3HXSaRNZYrgfFy6kO/5eGwrNgWsuUWpuE42iqN3sY=;
        b=YCVw0WFniJ2AlJIDQexIcZ6z9L4jnI8TTAfSL6SXQ3OwvnulN49LQtMwuxkhwNg9vE
         Klp4tgNo8rG+ej0oPd4PJI96HzBrZ+hHwrDSgJuI+Cs+6ioYBF58y3yhz+Ql4kFiHM1u
         RJGTMRZy4VD0UIIEY7Ia6xQX2vpCdRum08dh1G9b2+eL2hrokjcYbWyhslCYEGy7WFWl
         sGAwYLoMms+FLbLr7F4knBV4eYWulymhk/uUfCUEJdTxt7ovjoYBQXXSxvEg8orfdrnH
         bnxBlcvSU6P7c0sf9vb12fFuyX2nbYxQcF4F4q2X4Yj8wS/5VbDefdkjodlJJexlBiqR
         LWPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773860032; x=1774464832;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hh3HXSaRNZYrgfFy6kO/5eGwrNgWsuUWpuE42iqN3sY=;
        b=skZix7ZleezO5r4NPogWLlk8K4NEsLGjoskLL8YClKbw9tMORAQVcJOTwvXM8hoxu5
         Rg1a1NLdBS/2ULcDP+5NSQXvGUvAEUA1rheKuX/it2wBj0IcBBu/VNHAdk5d6zD2+TWu
         GnwHEm/F53WCBMmYrWRBI9hC7mDJks2UBhmRaA5pBGtZSJM21UmjLE1vXEDxuqzJqrQ9
         1TsyWwEAiknH64CqK4ujNS8A6t0ttGJtQk2llQKj0HK8yL2bRhwgmQPg8eKIIKCEvI/t
         c6uIR1fSsJ7+kga/xOyqKdHPBYpPq7mSMw0o0PG3v4qrkhY/RNm94Q4Nfh/tTNM89jZ7
         tqVQ==
X-Forwarded-Encrypted: i=1; AJvYcCXS3rTPLukuio6opzqdbhJc1fjIAI/qRhJDHYXnrtnMmd5buJykOUu5mw7VhIYrgPCjb7SaDsu5PuYQKQw=@lists.linux.dev
X-Gm-Message-State: AOJu0YwQWZ+BpatURUSgjsJcVp4CJ7u0EfAJFyRBDsdnHmX7+KmjHkjH
	M0eK9T0WfhsxV3bJejKOx9uXcPRg9evh46eSm/cM/YRigBnV62eHH/ci
X-Gm-Gg: ATEYQzxe2z7E7qO/LbkzWlXWwKqRzDmngeClVJezCYcRKLUbZ116eY/izgDyhB+BxeH
	Bye6Yf6s6d5XmryNm1ogFFhA8PLvtnmw2bsCkx1UwX/p1dsmLuBcTTHc5I7tjrHVlHh7UkXIx9Q
	A7Ye9S0RTHQkoYKyoliCgMmqlJJMbcYUD/pW4zd4ngFrryPDsOTjH/+ZPsQ40E8WUYCTLW306h4
	b/q6NbfGo+9Xa++cTIZ6kh6VaXQVQ7PstEdi79CaZ5K+6MVb11XSupaTdmuu5LvOlT3Hxi9OwG8
	Cv1yZyysYEp95+sWEyWusRarctan35LsONP2EP50IeJ8aVWUM1dMswLpK3XAiXiZFRXXv3/lb20
	FPI+9rUSqm/VlWpbZx0FgF1gatWcjwDxBh3gX3NTUlkIUXAmYbMAR5VA5DOFGrbczv7+5jMZJ+r
	/6U0RjT9f8H4ZR3G2eOkXOoEFCG/LKQ2qPTvvHapXGFWtRlQcurtMjhFjHHxT+f44FlBD6wjqDt
	PgEdGXtYZE=
X-Received: by 2002:a05:6a00:3698:b0:824:9848:b020 with SMTP id d2e1a72fcca58-82a6b26e7a3mr3958271b3a.52.1773860032113;
        Wed, 18 Mar 2026 11:53:52 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a6af06bd7sm3517633b3a.0.2026.03.18.11.53.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Mar 2026 11:53:51 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <df8086b1-8834-4bf2-ac4b-cb921beb8471@roeck-us.net>
Date: Wed, 18 Mar 2026 11:53:49 -0700
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/12] hwmon: spd5118: Add I3C support
To: Akhil R <akhilrajeev@nvidia.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Frank Li <Frank.Li@nxp.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>,
 Robert Moore <robert.moore@intel.com>, Len Brown <lenb@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>, Eric Biggers <ebiggers@kernel.org>,
 Fredrik Markstrom <fredrik.markstrom@est.tech>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Thierry Reding <thierry.reding@kernel.org>, Jon Hunter
 <jonathanh@nvidia.com>, Suresh Mangipudi <smangipudi@nvidia.com>,
 linux-tegra@vger.kernel.org, linux-i3c@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev,
 linux-hwmon@vger.kernel.org
References: <20260318172820.13771-1-akhilrajeev@nvidia.com>
 <20260318172820.13771-12-akhilrajeev@nvidia.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20260318172820.13771-12-akhilrajeev@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/18/26 10:27, Akhil R wrote:
> Add a regmap config and a probe function to support for I3C based
> communication to SPD5118 devices.
> 
> On an I3C bus, SPD5118 are enumerated via SETAASA and always require an
> ACPI or device tree entry. The device matching is hence through the OF
> match tables only and do not need an I3C class match table. The device
> identity is verified in the type registers before proceeding to the
> common probe function.
> 
> Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
> ---
>   drivers/hwmon/Kconfig   |  7 +++--
>   drivers/hwmon/spd5118.c | 66 ++++++++++++++++++++++++++++++++++++++++-
>   2 files changed, 70 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index 8af80e17d25e..23604c05ad22 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -2300,10 +2300,13 @@ config SENSORS_SPD5118
>   	tristate "SPD5118 Compliant Temperature Sensors"
>   	depends on I2C
>   	select REGMAP_I2C

I also had
	depends on I3C || I3C=n
in my version at

https://patchwork.kernel.org/project/linux-hwmon/patch/20250419161356.2528986-6-linux@roeck-us.net/

which I guess matches the more recent "depends on I3C_OR_I2C".

> +	select REGMAP_I3C if I3C
>   	help
>   	  If you say yes here you get support for SPD5118 (JEDEC JESD300)
> -	  compliant temperature sensors. Such sensors are found on DDR5 memory
> -	  modules.
> +	  compliant temperature sensors using I2C or I3C bus interface.
> +	  Such sensors are found on DDR5 memory modules.
> +
> +	  This driver supports both I2C and I3C interfaces.
>   
>   	  This driver can also be built as a module. If so, the module
>   	  will be called spd5118.
> diff --git a/drivers/hwmon/spd5118.c b/drivers/hwmon/spd5118.c
> index 5da44571b6a0..d70123e10616 100644
> --- a/drivers/hwmon/spd5118.c
> +++ b/drivers/hwmon/spd5118.c
> @@ -18,6 +18,7 @@
>   #include <linux/bits.h>
>   #include <linux/err.h>
>   #include <linux/i2c.h>
> +#include <linux/i3c/device.h>
>   #include <linux/hwmon.h>
>   #include <linux/module.h>
>   #include <linux/mutex.h>
> @@ -482,6 +483,25 @@ static const struct regmap_config spd5118_regmap16_config = {
>   	.cache_type = REGCACHE_MAPLE,
>   };
>   
> +/*
> + * I3C uses 2-byte register addressing -
> + *   Byte 1: MemReg | BlkAddr[0] | Address[5:0]
> + *   Byte 2: 0000   | BlkAddr[4:1]
> + *
> + * The low byte carries the register/NVM address and the high byte carries the
> + * upper block address bits, so little-endian format is required. No range
> + * config is needed since I3C does not use MR11 page switching.
> + */
> +static const struct regmap_config spd5118_regmap_i3c_config = {
> +	.reg_bits = 16,
> +	.val_bits = 8,
> +	.max_register = 0x7ff,
> +	.reg_format_endian = REGMAP_ENDIAN_LITTLE,

Should this be added to spd5118_regmap16_config instead, or is there reason
to assume that I2C 16-bit addressing differs from I3C addressing ?

> +	.writeable_reg = spd5118_writeable_reg,
> +	.volatile_reg = spd5118_volatile_reg,
> +	.cache_type = REGCACHE_MAPLE,
> +};
> +
>   static int spd5118_suspend(struct device *dev)
>   {
>   	struct spd5118_data *data = dev_get_drvdata(dev);
> @@ -770,7 +790,51 @@ static struct i2c_driver spd5118_i2c_driver = {
>   	.address_list	= IS_ENABLED(CONFIG_SENSORS_SPD5118_DETECT) ? normal_i2c : NULL,
>   };
>   
> -module_i2c_driver(spd5118_i2c_driver);
> +/* I3C */
> +
> +static int spd5118_i3c_probe(struct i3c_device *i3cdev)
> +{
> +	struct device *dev = i3cdev_to_dev(i3cdev);
> +	struct regmap *regmap;
> +	unsigned int regval;
> +	int err;
> +
> +	regmap = devm_regmap_init_i3c(i3cdev, &spd5118_regmap_i3c_config);
> +	if (IS_ERR(regmap))
> +		return dev_err_probe(dev, PTR_ERR(regmap), "regmap init failed\n");
> +
> +	/* Verify this is a SPD5118 device */
> +	err = regmap_read(regmap, SPD5118_REG_TYPE, &regval);
> +	if (err)
> +		return err;
> +
> +	if (regval != 0x51) {
> +		dev_err(dev, "unexpected device type 0x%02x, expected 0x51\n", regval);
> +		return -ENODEV;
> +	}
> +
> +	err = regmap_read(regmap, SPD5118_REG_TYPE + 1, &regval);
> +	if (err)
> +		return err;
> +
> +	if (regval != 0x18) {
> +		dev_err(dev, "unexpected device type 0x%02x, expected 0x18\n", regval);
> +		return -ENODEV;
> +	}
> +

I don't think this should dump error messages. Also, it might be desirable
to use a single regmap operation to read both values.

> +	return spd5118_common_probe(dev, regmap, false);

Why is_16bit=false ?

Thanks,
Guenter

> +}
> +
> +static struct i3c_driver spd5118_i3c_driver = {
> +	.driver = {
> +		.name	= "spd5118_i3c",
> +		.of_match_table = spd5118_of_ids,
> +		.pm = pm_sleep_ptr(&spd5118_pm_ops),
> +	},
> +	.probe		= spd5118_i3c_probe,
> +};
> +
> +module_i3c_i2c_driver(spd5118_i3c_driver, &spd5118_i2c_driver);
>   
>   MODULE_AUTHOR("René Rebe <rene@exactcode.de>");
>   MODULE_AUTHOR("Guenter Roeck <linux@roeck-us.net>");

