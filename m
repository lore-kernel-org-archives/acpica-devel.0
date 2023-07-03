Return-Path: <andriy.shevchenko@linux.intel.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 257F5408B6
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9FD4240004
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1688389789; x=1719925789;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=QZ/zCTxgUvgYpyM9lZeEIyhV+aOwlC3KMlPBTVwkteI=;
 b=ZwjY7PIuL4SQS5ltb6/Z56ntKRjjkfl2DuPlK+36PwFe8VRtoghSLeQC
 nhPVLvq+IseiwJZNdomn/LvDKsrDfc13zw4T4nOkZ5NKvrwK//v3hoJGC
 sdCLX5zZt+ONYK5pyc3NRNnwc6ujlRrAhLCFx0i1fRPL8VPTowKp9rfy+
 DJXbue7D2/y7zDrDbmK2z9D8OEYGFD4YT28MTLgCS9sPGUzyxCZzZm5gc
 R3oNgfmHCB0L8T777Drw1Oq5vNhsov9SoFdF/4W8Ev7/d2ydYZYOhhc3A
 od0SVDxjyYsqH/D1kaZg+JWhBvm3n5k9BD8ascqt5ZIxEFcZNuo2oIGLM A==;
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Message-ID: <ZKLIjAgJ5p/usyK3@smile.fi.intel.com>
References: <20230703121411.69606-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230703121411.69606-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [Acpica-devel] [PATCH v4 0/5] ACPI: platform: Fix SMB0001
 enumeration on Kontron devices
List-Id: "This is the central place for ACPICA developer discussions and
 issues." <acpica-devel.lists.linuxfoundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/acpica-devel/>
List-Post: <mailto:acpica-devel@lists.linuxfoundation.org>
List-Help: <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=subscribe>
Date: Mon, 03 Jul 2023 13:09:51 -0000
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Wolfram Sang <wsa@kernel.org>, Andi Shyti <andi.shyti@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, acpica-devel@lists.linuxfoundation.org
Cc: Michael Walle <michael@walle.cc>, Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>

On Mon, Jul 03, 2023 at 03:14:06PM +0300, Andy Shevchenko wrote:
> After switching i2c-scmi driver to be a plaform one, it stopped
> being enumerated on number of Kontron platforms, because it's
> listed in the forbidden_id_list.
> 
> To resolve the situation, add a flag and check if there are resources
> privided for the forbiden device. If it is the case, the device must
> be skipped.

...

> Changelog v4:
> - dropped applied patch
> - added kernel doc for new helper (Rafael)
> - rewritten the commit message for the reason of a new helper (Rafael)
> - added a couple of patches for ACPI scan.c that can be applied later on

- converted to use boolean instead of integer (Rafael)
- added tag (Andi)

> Changelog v3:
> - provided completely rewritten solution (Rafael)
> - due to above, added two new patches
> - due to above, dropped tags from patch 3

-- 
With Best Regards,
Andy Shevchenko


