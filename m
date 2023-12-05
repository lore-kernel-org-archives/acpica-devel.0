Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F708BE0
	for <acpica-devel@lists.linuxfoundation.org>; Tue,  5 Dec 2023 04:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JKyY577J"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5D38740901
	for <acpica-devel@lists.linuxfoundation.org>; Tue,  5 Dec 2023 04:18:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5D38740901
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=JKyY577J
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.101
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0M_jaC6YvQUG
	for <acpica-devel@lists.linuxfoundation.org>;
	Tue,  5 Dec 2023 04:18:05 +0000 (UTC)
X-Greylist: delayed 427 seconds by postgrey-1.37 at util1.osuosl.org; Tue, 05 Dec 2023 04:18:05 UTC
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2E0C840900
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 2E0C840900
	for <acpica-devel@lists.linuxfoundation.org>; Tue,  5 Dec 2023 04:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701749886; x=1733285886;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BgAKyIE8Taig/P+FmUDkLxkyIqxSRk5PyzxoVtR/DZI=;
  b=JKyY577JNAb3IcRdyhdUQTQcoovp+SRTgkDh7r07k+3Y8t/3/2DEbLMw
   23PHSxi2bgSjoRHdfdZkJAoucpuUVPfOGqSZpJBqUBeA9KIfLpKL3yBm/
   ygZjEW2Qf+txKp/AyyfzPQsGcXuuzkgZEy5n0uTKASXoqtbCiGyVD1Oau
   m2UHyTMEjdw3oZ4YiETk9NjUwydB0mF86EK4z4SYsvYF2uJXJDXLdojjC
   3Eip65qGuKTyRH8tWOhkpju1rmXvUDy+FowlSAQMGyOigZg+TA5JM4ay4
   l3E6hRo9H15A5L0fjCUlHBYQf5IZBfjGl3AzHQ/EMnbkjA15jpz8tg3kv
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="716330"
X-IronPort-AV: E=Sophos;i="6.04,251,1695711600"; 
   d="scan'208";a="716330"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2023 20:10:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="747079121"
X-IronPort-AV: E=Sophos;i="6.04,251,1695711600"; 
   d="scan'208";a="747079121"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2023 20:10:53 -0800
Date: Tue, 5 Dec 2023 06:10:50 +0200
From: Raag Jadav <raag.jadav@intel.com>
To: mika.westerberg@linux.intel.com, andriy.shevchenko@linux.intel.com,
	rafael@kernel.org, lenb@kernel.org, robert.moore@intel.com,
	ardb@kernel.org, will@kernel.org, mark.rutland@arm.com
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	acpica-devel@lists.linuxfoundation.org, linux-efi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	mallikarjunappa.sangannavar@intel.com, bala.senthil@intel.com
Subject: Re: [PATCH v3 0/5] Support _UID matching for integer types
Message-ID: <ZW6iyu4qF0V7wCXG@black.fi.intel.com>
References: <20231123100617.28020-1-raag.jadav@intel.com>
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231123100617.28020-1-raag.jadav@intel.com>

On Thu, Nov 23, 2023 at 03:36:12PM +0530, Raag Jadav wrote:
> This series updates the standard ACPI helpers to support _UID matching
> for both integer and string types, and uses them in a couple of places.
> 
> Changes since v2:
> - Drop __builtin functions to reduce complexity (Rafael)
> - Update tags
> 
> Changes since v1:
> - Fix build errors

Bump.

Anything I can do to move this forward?

Raag
