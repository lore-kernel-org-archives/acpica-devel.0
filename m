Return-Path: <andriy.shevchenko@linux.intel.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7D585704A3
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C5565704A1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1697798300; x=1729334300;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=n2cOUeXLOnt7d3XcD9ICk5Zxiu/d4trpmElUizd98rw=;
 b=STaAb8g5ilcT8fvVlFWc4iTwGzvZh/dPiITmbiXzh7xCiRq+08FNpXdF
 YzaXrGD79YaWDI/UJgZOst7iMXm5sEqvDe5V53haSoRu9MPGiBa2lRG/J
 xQgaHW/I6SIsixV8MbLkP9BUBqLTwGM+XBSo4HG/Yfuvnqr6rj6DjzamI
 yLxgFyopfDXSuuZG+14/3YEj+FrDoGPICwkF1Wdb3ZVpJ+/4v4yliA8Fx
 ReNolGSuZS9t12gcX/5LYaVo306JDl4OdY7bAdGgTqNIcdz3uPYWTos6I
 uOjOR8VIdZSprje0X8TRwaNGpYTcb4cBK0uNPMXRT8KApe1Q1IwDA2rDU w==;
Date: Fri, 20 Oct 2023 13:37:54 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Message-ID: <ZTJYgnugWHwBhtxv@smile.fi.intel.com>
References: <20231020084732.17130-1-raag.jadav@intel.com>
 <20231020084732.17130-6-raag.jadav@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231020084732.17130-6-raag.jadav@intel.com>
Subject: Re: [Acpica-devel] [PATCH v1 5/8] ACPI: x86: use
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

On Fri, Oct 20, 2023 at 02:17:29PM +0530, Raag Jadav wrote:
> Convert manual _UID references to use standard ACPI helpers.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

...

> -			if (!adev->pnp.unique_id ||
> -			    strcmp(adev->pnp.unique_id, override_status_ids[i].uid))
> +			if (!acpi_dev_uid_match(adev, override_status_ids[i].uid))

The check for NULL argument inside that API does not affect the behaviour as
otherwise it will be a crash with the current implementation.

>  				continue;


-- 
With Best Regards,
Andy Shevchenko


