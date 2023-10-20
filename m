Return-Path: <andriy.shevchenko@linux.intel.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0E6F5432D4
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2ADAD432B9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1697798114; x=1729334114;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=RxoqXyv0zETKYqwyH5UYMhDM7joOC36tuvjkJay4FOU=;
 b=enHCQ5XDL8T0yM4TsE1VbEhpCfGkG1RUFLKJLMXBkz1CdB1l0UL4aFeV
 rq+HDznoh8VwplDklYf7IL38w6HYiBWBQImJ4lVjGd8CmUBcFccehn2bD
 XxpthMOy9LEYFaC2L3sGxpFN7Ss/l0pc2bTPWtQIa20+bk6FjGx3Va663
 p+hxMnSSMs9Ry4EC0gh9q3n210UDExJ20bYhIfKSsOyfacgwAgTBJyMpQ
 9WIofqKI+3RwiDC2ikNlPSdzE0hLvYfDRW/hSXFTJdWGCKZGyIBncGzIJ
 dgBimbXg2F6i/JjAoaU3yevmNYyfOfgoD5NxKTyNGsFl2uUSoBSLziw5z A==;
Date: Fri, 20 Oct 2023 13:35:03 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Message-ID: <ZTJX1ytv2aEcHULA@smile.fi.intel.com>
References: <20231020084732.17130-1-raag.jadav@intel.com>
 <20231020084732.17130-2-raag.jadav@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231020084732.17130-2-raag.jadav@intel.com>
Subject: Re: [Acpica-devel] [PATCH v1 1/8] ACPI: utils: Introduce
 acpi_dev_uid_match() for matching _UID
List-Id: "This is the central place for ACPICA developer discussions and
 issues." <acpica-devel.lists.linuxfoundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/acpica-devel/>
List-Post: <mailto:acpica-devel@lists.linuxfoundation.org>
List-Help: <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=subscribe>
To: Raag Jadav <raag.jadav@intel.com>
Cc: mark.rutland@arm.com, len.brown@intel.com, will@kernel.org, linux-gpio@vger.kernel.org, mallikarjunappa.sangannavar@intel.com, robert.moore@intel.com, bala.senthil@intel.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, acpica-devel@lists.linuxfoundation.org, linux-hwmon@vger.kernel.org, mika.westerberg@linux.intel.com, linux@roeck-us.net

On Fri, Oct 20, 2023 at 02:17:25PM +0530, Raag Jadav wrote:
> Introduce acpi_dev_uid_match() helper that matches the device with
> supplied _UID string.

...

> +/**
> + * acpi_dev_uid_match - Match device by supplied UID
> + * @adev: ACPI device to match.
> + * @uid2: Unique ID of the device, pass NULL to not check _UID.
> + *
> + * Matches UID in @adev with given @uid2. Absence of @uid2 will be treated as
> + * a match. If user wants to validate @uid2, it should be done before calling
> + * this function. This behaviour is as needed by most of its current users.

The "current" internally I applied to the result of the series. So reading this
again I think the better wording is "potential".

> + *
> + * Returns:
> + *  - %true if matches or @uid2 is NULL.
> + *  - %false otherwise.
> + */

...

>  /**
>   * acpi_dev_hid_uid_match - Match device by supplied HID and UID
>   * @adev: ACPI device to match.
>   * @hid2: Hardware ID of the device.
>   * @uid2: Unique ID of the device, pass NULL to not check _UID.
>   *
> - * Matches HID and UID in @adev with given @hid2 and @uid2.
> - * Returns true if matches.
> + * Matches HID and UID in @adev with given @hid2 and @uid2. Absence of @uid2
> + * will be treated as a match. If user wants to validate @uid2, it should be
> + * done before calling this function. This behaviour is as needed by most of
> + * its current users.

Ditto.

> + * Returns:
> + *  - %true if matches or @uid2 is NULL.
> + *  - %false otherwise.
>   */

-- 
With Best Regards,
Andy Shevchenko


