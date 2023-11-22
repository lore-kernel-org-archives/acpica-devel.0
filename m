Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7B61F618
	for <acpica-devel@lists.linuxfoundation.org>; Wed, 22 Nov 2023 10:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LJEFyScQ"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8846C402BB
	for <acpica-devel@lists.linuxfoundation.org>; Wed, 22 Nov 2023 10:12:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8846C402BB
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=LJEFyScQ
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.299
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WmZJ5sThdrlX
	for <acpica-devel@lists.linuxfoundation.org>;
	Wed, 22 Nov 2023 10:12:11 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5F4FF402A9
	for <acpica-devel@lists.linuxfoundation.org>; Wed, 22 Nov 2023 10:12:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5F4FF402A9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700647931; x=1732183931;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=ekVyR2LTJTYq3ZM1BPKwRkdTVcMVyNkfXXO7GdIDxpQ=;
  b=LJEFyScQlW1O5U69Gf1jjt1jY+c331WAefnuijez60zcisQU60X/8Oho
   NWAomh0MCqxqCQZzHwhkRAIEXYxYFMddokLefCWx2BMsdDa8RghA2s1rS
   7EspYGZ84Ohlp0wZ0w5CsUhTeN4sszwUNI38kvUbJdQYdQcLbKrVh7/kK
   T7i/K5dh9OZi2+LTZtfW/4/j51Dfot7w1loB/b0h73RTLgo5OOf4r7clf
   u+9WEGZhNSe8nqFW7Tll3HViQKeIeNWpBK13hhzxWeKFgqIAZEl0si5h4
   CRBrJwT4df4EpdmMP6AhvQts6R/DyDK9+4CCNmODAp4HTmaZEGLKI7VHN
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="395945574"
X-IronPort-AV: E=Sophos;i="6.04,218,1695711600"; 
   d="scan'208";a="395945574"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2023 02:12:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="832958152"
X-IronPort-AV: E=Sophos;i="6.04,218,1695711600"; 
   d="scan'208";a="832958152"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2023 02:12:04 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1r5kDB-0000000G3jf-2eSS;
	Wed, 22 Nov 2023 12:12:01 +0200
Date: Wed, 22 Nov 2023 12:12:01 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Raag Jadav <raag.jadav@intel.com>, mika.westerberg@linux.intel.com,
	lenb@kernel.org, robert.moore@intel.com, ardb@kernel.org,
	will@kernel.org, mark.rutland@arm.com, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	acpica-devel@lists.linuxfoundation.org, linux-efi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	mallikarjunappa.sangannavar@intel.com, bala.senthil@intel.com
Subject: Re: [PATCH v2 2/6] ACPI: bus: update acpi_dev_uid_match() to support
 multiple types
Message-ID: <ZV3T8c_1L77h5CsA@smile.fi.intel.com>
References: <20231121103829.10027-1-raag.jadav@intel.com>
 <20231121103829.10027-3-raag.jadav@intel.com>
 <CAJZ5v0jmaRQWfO_mM4GZ8mEFftuSNgt36=tJ5vC2Uw7MAcpYJg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0jmaRQWfO_mM4GZ8mEFftuSNgt36=tJ5vC2Uw7MAcpYJg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Nov 21, 2023 at 08:25:20PM +0100, Rafael J. Wysocki wrote:
> On Tue, Nov 21, 2023 at 11:38 AM Raag Jadav <raag.jadav@intel.com> wrote:
> >
> > According to ACPI specification, a _UID object can evaluate to either
> > a numeric value or a string. Update acpi_dev_uid_match() helper to
> > support _UID matching for both integer and string types.
> >
> > Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Suggested-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> You need to be careful with using this.  There are some things below
> that go beyond what I have suggested.

Same to me and actually I've asked several times to remove this tag of mine!

-- 
With Best Regards,
Andy Shevchenko


