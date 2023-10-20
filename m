Return-Path: <jonathan.cameron@huawei.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CA46F433AD
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 21685404F9
Date: Fri, 20 Oct 2023 16:49:33 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Message-ID: <20231020164933.00002f53@Huawei.com>
In-Reply-To: <20231020084732.17130-2-raag.jadav@intel.com>
References: <20231020084732.17130-1-raag.jadav@intel.com>
 <20231020084732.17130-2-raag.jadav@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
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
Cc: mark.rutland@arm.com, len.brown@intel.com, linux-hwmon@vger.kernel.org, will@kernel.org, linux-gpio@vger.kernel.org, mallikarjunappa.sangannavar@intel.com, robert.moore@intel.com, bala.senthil@intel.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, acpica-devel@lists.linuxfoundation.org, andriy.shevchenko@linux.intel.com, mika.westerberg@linux.intel.com, linux@roeck-us.net

On Fri, 20 Oct 2023 14:17:25 +0530
Raag Jadav <raag.jadav@intel.com> wrote:

> Introduce acpi_dev_uid_match() helper that matches the device with
> supplied _UID string.
> 
> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Raag Jadav <raag.jadav@intel.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
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

If there are other other users that need different behavior are they
buggy?  Also what behavior is this referring to?

I'd just drop the at last sentence as confusing and not adding much.

> + *
> + * Returns:
> + *  - %true if matches or @uid2 is NULL.
> + *  - %false otherwise.
>   */
>  bool acpi_dev_hid_uid_match(struct acpi_device *adev,
>  			    const char *hid2, const char *uid2)
>  {
>  	const char *hid1 = acpi_device_hid(adev);
> -	const char *uid1 = acpi_device_uid(adev);
>  
>  	if (strcmp(hid1, hid2))
>  		return false;
>  
> -	if (!uid2)
> -		return true;
> -
> -	return uid1 && !strcmp(uid1, uid2);
> +	return acpi_dev_uid_match(adev, uid2);
>  }
>  EXPORT_SYMBOL(acpi_dev_hid_uid_match);
>  
> diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> index 254685085c82..d1fe6446ffe0 100644
> --- a/include/acpi/acpi_bus.h
> +++ b/include/acpi/acpi_bus.h
> @@ -760,6 +760,7 @@ static inline bool acpi_device_can_poweroff(struct acpi_device *adev)
>  		adev->power.states[ACPI_STATE_D3_HOT].flags.explicit_set);
>  }
>  
> +bool acpi_dev_uid_match(struct acpi_device *adev, const char *uid2);
>  bool acpi_dev_hid_uid_match(struct acpi_device *adev, const char *hid2, const char *uid2);
>  int acpi_dev_uid_to_integer(struct acpi_device *adev, u64 *integer);
>  
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index afd94c9b8b8a..db3a33e19c97 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -787,6 +787,11 @@ static inline bool acpi_dev_present(const char *hid, const char *uid, s64 hrv)
>  
>  struct acpi_device;
>  
> +static inline bool acpi_dev_uid_match(struct acpi_device *adev, const char *uid2)
> +{
> +	return false;
> +}
> +
>  static inline bool
>  acpi_dev_hid_uid_match(struct acpi_device *adev, const char *hid2, const char *uid2)
>  {

