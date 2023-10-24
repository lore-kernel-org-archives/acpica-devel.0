Return-Path: <andriy.shevchenko@linux.intel.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C9691430E7
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0212A43059
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1698145267; x=1729681267;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=75KjUTqZS/fnnT7oRhWogkQjn6g67+ZS64Oru9+MmVU=;
 b=OVTqXZ9pp95xjiBXRzhrbaV7HNWBCvOGuY24b7tfKXFGm1sCQWg9bzb7
 2aooeQKN3o3ImrclTd9wZ5UT80sLLYDtWENwfFscV70fbyFSlNLI4HAbT
 nG3D21rVAlmfLhx364LaluN8VtE9NE3kNT+2jSZvwmWzjMkSJAJYUkyEf
 trwLe6qbVUBLpCUiu0be35wq5gN2Cd8WwQgKMgaOwvDEjFzBOpgb8mSkE
 REW8B7YLG8o/J17L/DOLfsuz9j1+erfv7Logx0vqXWGmiyiHkHa7kYHTB
 56lykVIcR3Uud24GvGj/422LDaYNLTqSRv1X0BAb2Sq1sy6d5f/v9zp4O A==;
Date: Tue, 24 Oct 2023 14:00:58 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Message-ID: <ZTej6hlCCYFRCNtl@smile.fi.intel.com>
References: <20231024062018.23839-1-raag.jadav@intel.com>
 <20231024093010.GF3208943@black.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231024093010.GF3208943@black.fi.intel.com>
Subject: Re: [Acpica-devel] [PATCH v3 0/6] Refine _UID references across
	kernel
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

On Tue, Oct 24, 2023 at 12:30:10PM +0300, Mika Westerberg wrote:
> On Tue, Oct 24, 2023 at 11:50:12AM +0530, Raag Jadav wrote:
> > This series refines _UID references across kernel by:

...

> >  drivers/pinctrl/intel/pinctrl-intel.c |  2 +-
> 
> This pinctrl one is also fine by me so if Andy does not have objections,
> feel free to add my,

TL;DR: I had, but Rafael seems wanted your opinion. Whatever, I'm not
preventing this from happening, but I still consider that the uid check
for NULL in the helper should mimic the same logic as in
acpi_dev_hid_uid_match(). That's why I asked to drop my tags from this
series.

-- 
With Best Regards,
Andy Shevchenko


