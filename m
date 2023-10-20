Return-Path: <andriy.shevchenko@linux.intel.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 89FAC4ECA0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 108324EC9F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1697798196; x=1729334196;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=6qScAHtvAY25k9RrO1FlJ14eXJKmDYR3dgfhkSHrBIU=;
 b=kyNUnbiwmc7DspkJeSNvs81j9+ZjlH1I5iKYWXAWZGMzuyMeW5vNcO5b
 qkJcpx2PIlu4IDrRA6G06sgAKb+FXQgKZsd5pgXpnxXKzZLLdv1Jte55s
 phBOT9su6sWsMJwB9FcRrrfyiIU5wXJ7BYSlntxO+cAL92iuF3l/Cdm36
 KZNVgTG0ZOHHAYL0cuhWjy62KJ9eA7uxqEA12NX9imrFwksMNh41Y/2RP
 M447CNytqSXEXrp3ek+ic88N39yWZyuA5aefDGPNqh4U3tYXORU0MWIEd
 ef9hN3IyZhU63f8dMd1gsKoCqaa1PZwRz+a7yhDU3IFJwwZvyvQHlLYPy w==;
Date: Fri, 20 Oct 2023 13:36:27 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Message-ID: <ZTJYK02w8HZg26eI@smile.fi.intel.com>
References: <20231020084732.17130-1-raag.jadav@intel.com>
 <20231020084732.17130-5-raag.jadav@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231020084732.17130-5-raag.jadav@intel.com>
Subject: Re: [Acpica-devel] [PATCH v1 4/8] ACPI: utils: use
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

On Fri, Oct 20, 2023 at 02:17:28PM +0530, Raag Jadav wrote:
> Convert manual _UID references to use standard ACPI helpers.

Yes, while not so obvious this is the correct replacement.
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


