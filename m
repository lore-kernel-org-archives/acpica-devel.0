Return-Path: <andriy.shevchenko@linux.intel.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1523E4013F
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 37497414C5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1698060868; x=1729596868;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=tqBRMH+HCKcZFWm9PPVshLhZLM8RB9RreHNxWsejEpE=;
 b=GQLdDxaAMh4ciBIte+nFE1ifvBOIU2TkDW7alffnH2kzFJY6s0M36bgi
 lx28FefLCUclf5w7uqkgQPOBGIRa7MXrrkFQWyFz2zj69J4t9ENqIp7by
 fVVo4203OLxkOJ9eAqmP4oHPaYWVdZWgEF4uPfW7WgKlI7TTTF/0Kiy4X
 IHK8HKB76fwjzSR/CWXrewAfSHCk8QYQNuGxDSISxlKdHWF/tFGpZmXI7
 1cixyR8QpiIGrJQpOYEkdu+GaNowilIZIB+u/wfBVpyESI86i4xMlHyba
 OAlZqxpnhFhRIPX/WYl8+QFarWdQasNsFYHJSSUBpDDLUHhFml9Q/Dd7f w==;
Date: Mon, 23 Oct 2023 14:34:18 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Message-ID: <ZTZaOqCt7MbylTv+@smile.fi.intel.com>
References: <20231023053530.5525-1-raag.jadav@intel.com>
 <20231023053530.5525-2-raag.jadav@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231023053530.5525-2-raag.jadav@intel.com>
Subject: Re: [Acpica-devel] [PATCH v2 1/6] ACPI: utils: Introduce
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

On Mon, Oct 23, 2023 at 11:05:25AM +0530, Raag Jadav wrote:
> Introduce acpi_dev_uid_match() helper that matches the device with
> supplied _UID string.

...

> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Sorry, I suggested another helper. Please either drop this tag, or change
helper to what I suggested (as in your v1 I assume).

-- 
With Best Regards,
Andy Shevchenko


