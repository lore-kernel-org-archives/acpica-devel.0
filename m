Return-Path: <andriy.shevchenko@linux.intel.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C9C214116E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D0D64400BA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1697827365; x=1729363365;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=WMfwakjNhmNMrO7ju65Y5cogR7+j5gRlCvM47x+qd3o=;
 b=Ot9VgRz3E/MWvuFWLT6JXAQ5WvqCrOML7nvaJcLzQyJWc0j1RQFg0uIN
 BD/uspEMGw3bIkqg3wWrRvtYfJwQ/FmFQEwO/vGFI4heCMcATj9B7/5/y
 qPw6KEIABuCvA0kxHzS1rbzfhmPLStOJVzXGOOQrxlGGNjYT79cp3EROJ
 wlgW/DH+c1o1IrRitfb/oGfirFQfZAR8wCxXzZwjeT8Js6fMyRVskNA/V
 AydIP+OyJcBC2cMGbYxrBU9VHaiLKTGXOVoLf8WetNAyxUy6bhzVsyo4j
 fcVuju0KL6VyyLRcUYIdPcbrjq8OAQi8buz6N6BpkF6wtFwzYx+0yQKZ8 g==;
Date: Fri, 20 Oct 2023 21:42:37 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Message-ID: <ZTLKHULe1DlKs5BX@smile.fi.intel.com>
References: <20231020084732.17130-1-raag.jadav@intel.com>
 <20231020084732.17130-6-raag.jadav@intel.com>
 <ZTJYgnugWHwBhtxv@smile.fi.intel.com>
 <CAJZ5v0gqFgkhPHudqYUdg8ZgbEtF0Jf1ATbYACYEq3fNyaDW2w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0gqFgkhPHudqYUdg8ZgbEtF0Jf1ATbYACYEq3fNyaDW2w@mail.gmail.com>
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
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: mark.rutland@arm.com, len.brown@intel.com, linux-gpio@vger.kernel.org, mika.westerberg@linux.intel.com, Raag Jadav <raag.jadav@intel.com>, robert.moore@intel.com, bala.senthil@intel.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, mallikarjunappa.sangannavar@intel.com, acpica-devel@lists.linuxfoundation.org, linux-hwmon@vger.kernel.org, will@kernel.org, linux@roeck-us.net

On Fri, Oct 20, 2023 at 07:05:37PM +0200, Rafael J. Wysocki wrote:
> On Fri, Oct 20, 2023 at 12:38 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Fri, Oct 20, 2023 at 02:17:29PM +0530, Raag Jadav wrote:

...

> > > -                     if (!adev->pnp.unique_id ||
> > > -                         strcmp(adev->pnp.unique_id, override_status_ids[i].uid))
> > > +                     if (!acpi_dev_uid_match(adev, override_status_ids[i].uid))
> >
> > The check for NULL argument inside that API does not affect the behaviour as
> > otherwise it will be a crash with the current implementation.
> 
> What current implementation do you mean, exactly?

strcmp() against NULL will crash the system.

-- 
With Best Regards,
Andy Shevchenko


