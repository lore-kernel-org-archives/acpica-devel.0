Return-Path: <andriy.shevchenko@linux.intel.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 84AF18479D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9FA7584799
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1698145071; x=1729681071;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=rGtYObcuetOYR9kP/9TpGIdMtWpvP56ffO2o63DEo7o=;
 b=lnf6reSfBpGc/epMkdnfLkcFl4qMDmkP8tthQUnLWIzFH2vKLHc47cvr
 AUjhNrezJHhp8lmqFFTy7nFQOQUr2zBNHIGhSndh+ammmgkNzWBy7pDUD
 hyhiGIeZJS19MiS+G4hT6r+4i/tc7Tuk3ZmbjF6QNmR9a3kTI4ujLR26m
 2+7cBZC4wl9EjqqiDhYY3FLNYVSgWDebrVXedHMwEwlehyU573NvnMDHO
 PujqNBh9akwUOBLDosLMjvevYSGFUuIY1Z9cM/CYaFm2xWQfbDprsdjFe
 //E2jNKu+1WsLyLSUJpIx9kY6z57HkntoNm0Fjr34UPY/0rfT9d1vAl2i A==;
Date: Tue, 24 Oct 2023 13:57:42 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Message-ID: <ZTejJo6io91n7e4H@smile.fi.intel.com>
References: <20231024062018.23839-1-raag.jadav@intel.com>
 <20231024062018.23839-2-raag.jadav@intel.com>
 <20231024092839.GE3208943@black.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231024092839.GE3208943@black.fi.intel.com>
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
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: mark.rutland@arm.com, len.brown@intel.com, mallikarjunappa.sangannavar@intel.com, linux-gpio@vger.kernel.org, Raag Jadav <raag.jadav@intel.com>, robert.moore@intel.com, bala.senthil@intel.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jonathan.Cameron@huawei.com, acpica-devel@lists.linuxfoundation.org, linux-hwmon@vger.kernel.org, will@kernel.org, linux@roeck-us.net

On Tue, Oct 24, 2023 at 12:28:39PM +0300, Mika Westerberg wrote:
> On Tue, Oct 24, 2023 at 11:50:13AM +0530, Raag Jadav wrote:

...

> > + * Returns:
> > + *  - %true if matches.
> > + *  - %false otherwise.
> 
> Nit: these actually do not get formatted like above so you can just
> write it as
> 
> Returns: %true in case UIDs match, %false otherwise.
> 
> If it is even needed, I think it is pretty obvious from the function
> name what it returns.

kernel-doc complains if there is no Return: section in the text.

-- 
With Best Regards,
Andy Shevchenko


