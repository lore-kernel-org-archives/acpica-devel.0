Return-Path: <andriy.shevchenko@linux.intel.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 30C20610A2
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AA6F360FD1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1698060994; x=1729596994;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=1hNtJkrhOMeQ/kBhDBZ7GUWDWrwRTz6hQAoZ3cKYKLo=;
 b=mrUFr9SR0trvZbbSuEd1JXgO/S8z0yDkXU/MDBlkqybdAn82A9VDDJTa
 XplmhOq+jzttv/jiRuaaz0q96quBH+LX0zjzRz3fdw/kMQi/Dsjj4T74w
 uMTuDUyIydACbHSuRCvmhrhS/Aau1uLtgk6C8fGl6eI6srSB1POe2ytn8
 UCNC5DGEENs75XRMi95hDfo1DhGmY3VC/PnJQKrKv2DTlK4p55pOmIQcS
 Ibnj6gIb4xmvahTyKiGtqHtqaykPKfOxsUzhMkg61Sa8+FBC2hIp7f0Yy
 UHBRLu93FeSRQYGmdsIblMb0+wI171OQtmvK2NTrbd4tmHtGe6ElJ+oCT g==;
Date: Mon, 23 Oct 2023 14:36:09 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Message-ID: <ZTZaqf6Y+kDJOWK6@smile.fi.intel.com>
References: <20231023053530.5525-1-raag.jadav@intel.com>
 <20231023053530.5525-5-raag.jadav@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231023053530.5525-5-raag.jadav@intel.com>
Subject: Re: [Acpica-devel] [PATCH v2 4/6] ACPI: x86: use
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

On Mon, Oct 23, 2023 at 11:05:28AM +0530, Raag Jadav wrote:
> Convert manual _UID references to use the standard ACPI helper.

> Signed-off-by: Raag Jadav <raag.jadav@intel.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Please, drop this tag, since I disagree with patch 1 implementation.

-- 
With Best Regards,
Andy Shevchenko


