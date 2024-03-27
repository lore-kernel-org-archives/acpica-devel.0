Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6B71B813
	for <acpica-devel@lists.linux.dev>; Wed, 27 Mar 2024 05:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711518604; cv=none; b=bl9+PCjkBE6q4UmsMj0t4NiEIzGCEEbO+pfVNCipLN9Vxj7PiSbAIVGsrBcrq/8i1jNyN2CpQXfDMTxGI0i1hpGn9kci+ywOQWOQDYFu9fqNYoxP2YGW3R0iOP6vnPX9pGWtq8pH4SD14QFuUxP6c4TChRGS8C3UhGmKBp7vVeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711518604; c=relaxed/simple;
	bh=NGhsAu+sz1EG8a0MGs6ihEvAoXlJ1KKzmRjwQND6aHU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SVOFnYzEBGirMggmOTG4kjiV8/rorOalcJjw8iufXjglH46meHGX8m4kdIF9qhxM58Igxq1DibQwlcUxVf1sIplQWoBkLi01KbdeGUpkWPF56cyJf6/n4XV/qT7zhehCBHVGFDvfr5ks4p+iZEr3JxWLiwLbrg1rW/RX7OwRvqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PT+Fg3NF; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PT+Fg3NF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711518602; x=1743054602;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=NGhsAu+sz1EG8a0MGs6ihEvAoXlJ1KKzmRjwQND6aHU=;
  b=PT+Fg3NF0C7oH+QLXjD+oLG2Fngukc7N2cQ+dlTxE5VMxxep7qXstjQK
   CEWTgDTOcrvW8t395o249MaTB0+IxEKntOAIQtcehK0eU985B1i+ktF2p
   rBP+YnZRsn3+mJNXi1dAlrkFS9W9bfkjXN95if3qtinaxFEHPIF2RiZRP
   nXyUA2a63aBJP92We17G+gs1279X9u/xqMadcL33laFi86I2Ue6oA8Je6
   1h+D8Ty6QBiUvjqby3Kh8ZWSX5BrJGJDTucBHmOA4l1nZat2Nh2rVJ+2z
   5zLpSOECZCKgJdjxTYjIdLdDvtJEbQ8PLuvxMnv/AXYDN0ArH+DSMOCSk
   w==;
X-CSE-ConnectionGUID: 1mJ6wZKnSsqvpmmfsiZsTg==
X-CSE-MsgGUID: wGLKV8arRaWLiXO67iYv5g==
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="9563590"
X-IronPort-AV: E=Sophos;i="6.07,157,1708416000"; 
   d="scan'208";a="9563590"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 22:50:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,157,1708416000"; 
   d="scan'208";a="16833210"
Received: from xuezengd-mobl.amr.corp.intel.com (HELO [10.209.17.216]) ([10.209.17.216])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 22:50:01 -0700
Message-ID: <3cad4f7f-382e-4898-8867-d48340a2ed01@linux.intel.com>
Date: Tue, 26 Mar 2024 22:50:00 -0700
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/7] ACPI: scan: A few ad-hoc cleanups
Content-Language: en-US
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 acpica-devel@lists.linux.dev
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Robert Moore <robert.moore@intel.com>
References: <20240325123444.3031851-1-andriy.shevchenko@linux.intel.com>
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20240325123444.3031851-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 3/25/24 5:32 AM, Andy Shevchenko wrote:
> While looking for something else in the scan.c I noticed the room
> of improvement. Hence this series. Also bus.c patches, which some
> how were related to my research, but I think are independent from
> the scan.c improvements.

Changes looks good to me.

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>
> Andy Shevchenko (7):
>   ACPI: bus: Make container_of() no-op where it makes sense
>   ACPI: bus: Don't use "proxy" headers
>   ACPI: scan: Replace infinite for-loop with finite while-loop
>   ACPI: scan: Use list_first_entry_or_null() in acpi_device_hid()
>   ACPI: scan: Move misleading comment to acpi_dma_configure_id()
>   ACPI: scan: Use standard error checking pattern
>   ACPI: scan: Introduce typedef:s for struct acpi_hotplug_context
>     members
>
>  drivers/acpi/dock.c     | 48 +++++++++++++++--------------------------
>  drivers/acpi/scan.c     | 42 +++++++++++++++++-------------------
>  include/acpi/acpi_bus.h | 28 +++++++++++++++---------
>  3 files changed, 55 insertions(+), 63 deletions(-)
>
-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer

