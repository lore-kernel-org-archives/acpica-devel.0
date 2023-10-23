Return-Path: <raag.jadav@intel.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 23F8A4172F
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4930C4170D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1698072193; x=1729608193;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=c+vwHWtU4SYe45hCSutTEEchOiP/C8YWbfE6MM6PUfQ=;
 b=YfkehWzvTdyPoYON0NAzNUmohHSxJVHJVkDGEMhVFXRSTu8TkbmAoQHx
 rUfz0W6KD6Yj/9AOo6PXpeGDa5acCu/2JtyU2ek1xEQ8+Q5ZC2RLJ7KEA
 PncLGSCDlw2YajwMUoP9WTbihYy/C1qVv+2ZXEy7eID97viV+fOM+l0D8
 BM/v5IeCyTgKRR+OTsuJFNfaSRppbdMDVzaUXgfqHL4vv38jZ0plqj5pP
 HiuJ1J0paGgM/m80wM4GgnVHb6b+lZ4fVJZVSwtg/6SRx1DdKOSccjTot
 o5863irtpjUt+Lhv2k+zahAGmtLWQ+a1IrpYu2HS7ktMCD61+IpR6pp/o w==;
Date: Mon, 23 Oct 2023 17:42:48 +0300
From: Raag Jadav <raag.jadav@intel.com>
Message-ID: <ZTaGaDweYpBlxBez@black.fi.intel.com>
References: <20231023053530.5525-1-raag.jadav@intel.com>
 <20231023053530.5525-3-raag.jadav@intel.com>
 <ZTZacR86hSmV04M9@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZTZacR86hSmV04M9@smile.fi.intel.com>
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
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: mark.rutland@arm.com, len.brown@intel.com, will@kernel.org, linux-gpio@vger.kernel.org, mallikarjunappa.sangannavar@intel.com, robert.moore@intel.com, bala.senthil@intel.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jonathan.Cameron@huawei.com, acpica-devel@lists.linuxfoundation.org, linux-hwmon@vger.kernel.org, mika.westerberg@linux.intel.com, linux@roeck-us.net

On Mon, Oct 23, 2023 at 02:35:13PM +0300, Andy Shevchenko wrote:
> On Mon, Oct 23, 2023 at 11:05:26AM +0530, Raag Jadav wrote:
> > Convert manual _UID references to use the standard ACPI helper.
> 
> > Signed-off-by: Raag Jadav <raag.jadav@intel.com>
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> It has a hidden logic that is not aligned with acpi_dev_hid_uid_match().
> Or revert to your v1 I assume.

I don't see how this has to be aligned with acpi_dev_hid_uid_match() or
if acpi_dev_hid_uid_match() implementation concerns this specific change,
since that's not what we intend to do here.

Also, I think acpi_dev_uid_match() implementation in v2 is actually more
aligned with the previous logic that we're replacing here, since it gives
us a guaranteed match result as originally intended with strcmp in this
case. And the "hidden logic" in v1 implementation (match with @uid2 == NULL)
is what ends up breaking it in my opinion.

Regardless, for any version (v1 or v2) the usage still remains the same
in this case.

> As I asked you, please drop this one.

But okay, as you wish :(

Rafael, should I send a v3 with dropped tags?

Raag
