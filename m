Return-Path: <mika.westerberg@linux.intel.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 46B368477C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7BCBB84772
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1698139726; x=1729675726;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=TSB8pAAViMB/8p//BjKSeKwLOijnQ7uOJx1vlqPV8yg=;
 b=d2pycOIegWmaiBPuhL0h9V7Rwvf6X6JJnSDd7LFcZcEP+mQgcROs44xe
 FZVMWHkKU83iek/6+K3s5qtX4BwU7UbjUfUGbzWj6jOLbHXJCAl0C8+3W
 u92kotQVO487mJ13BTNdSKp4wb5PDv0x2VtaC2LZi44VGuQBg4dy0pDJU
 6Y033a/ed2f8KMgUPJTBeD0cumS7orMMBPIa49yhnSbsTY1s+avs5u+zs
 G5YOI42yKFQTrslzzrVB1IIWQyXvROqbPfODyrsOJh6+YkQMatK1gI6NM
 yav9LWgJerxpxlae412EFRx/KuSvMohp15v1L4m9PCqnT8BsCiGII9CzS w==;
Date: Tue, 24 Oct 2023 12:28:39 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
Message-ID: <20231024092839.GE3208943@black.fi.intel.com>
References: <20231024062018.23839-1-raag.jadav@intel.com>
 <20231024062018.23839-2-raag.jadav@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231024062018.23839-2-raag.jadav@intel.com>
Subject: Re: [Acpica-devel] [PATCH v3 1/6] ACPI: utils: Introduce
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
Cc: mark.rutland@arm.com, len.brown@intel.com, linux-hwmon@vger.kernel.org, linux-gpio@vger.kernel.org, mallikarjunappa.sangannavar@intel.com, robert.moore@intel.com, bala.senthil@intel.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jonathan.Cameron@huawei.com, acpica-devel@lists.linuxfoundation.org, andriy.shevchenko@linux.intel.com, will@kernel.org, linux@roeck-us.net

On Tue, Oct 24, 2023 at 11:50:13AM +0530, Raag Jadav wrote:
> +/**
> + * acpi_dev_uid_match - Match device by supplied UID
> + * @adev: ACPI device to match.
> + * @uid2: Unique ID of the device.
> + *
> + * Matches UID in @adev with given @uid2.
> + *
> + * Returns:
> + *  - %true if matches.
> + *  - %false otherwise.

Nit: these actually do not get formatted like above so you can just
write it as

Returns: %true in case UIDs match, %false otherwise.

If it is even needed, I think it is pretty obvious from the function
name what it returns.
