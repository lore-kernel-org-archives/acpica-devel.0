Return-Path: <andriy.shevchenko@linux.intel.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2E70341768
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8E3B14175F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1698060922; x=1729596922;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=oxQ99Lbr0YPXctAU2ZPK0KvWToc8S5g7FWzgOBc/tco=;
 b=QWrKUow+jFqrLzXHv4IDTJhzD73Gi6KQ6MlihK4encHmex+ZyJfKy3M9
 Wd6/Ip10maDr1TpRaxA7c79xkpIxAzgZxE5seYNdo1Wr5LHD08OiHichq
 HNeP7iPWLXqzwGTYKkmc+JGsTEcBBFsUHN/jxts78skVdgyWrjHgR/89z
 wGrmRbyYMVJTJRL64PCXskUwEqGJqeD//sD9I72Es1DpoTAO9x01rPwqo
 kQ2fPeQRk13IbwtGQ3hCXvzjzdVHjfyzPTlcPC/FBiHdFDzJTA6J9ycB3
 +lZmuNdzs5OCubbSnSLmmNDUcAQngY/2lMJyQWnBQjGjLgdblfStt5rIU A==;
Date: Mon, 23 Oct 2023 14:35:13 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Message-ID: <ZTZacR86hSmV04M9@smile.fi.intel.com>
References: <20231023053530.5525-1-raag.jadav@intel.com>
 <20231023053530.5525-3-raag.jadav@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231023053530.5525-3-raag.jadav@intel.com>
Subject: Re: [Acpica-devel] [PATCH v2 2/6] pinctrl: intel: use
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
Cc: mark.rutland@arm.com, len.brown@intel.com, will@kernel.org, linux-gpio@vger.kernel.org, mallikarjunappa.sangannavar@intel.com, robert.moore@intel.com, bala.senthil@intel.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jonathan.Cameron@huawei.com, acpica-devel@lists.linuxfoundation.org, linux-hwmon@vger.kernel.org, mika.westerberg@linux.intel.com, linux@roeck-us.net

On Mon, Oct 23, 2023 at 11:05:26AM +0530, Raag Jadav wrote:
> Convert manual _UID references to use the standard ACPI helper.

> Signed-off-by: Raag Jadav <raag.jadav@intel.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

As I asked you, please drop this one. It has a hidden logic that is not aligned
with acpi_dev_hid_uid_match(). Or revert to your v1 I assume.

-- 
With Best Regards,
Andy Shevchenko


