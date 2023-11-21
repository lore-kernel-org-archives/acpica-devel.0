Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B241101
	for <acpica-devel@lists.linuxfoundation.org>; Tue, 21 Nov 2023 16:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iqJNH/g7"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 91ED1610F3
	for <acpica-devel@lists.linuxfoundation.org>; Tue, 21 Nov 2023 16:50:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 91ED1610F3
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=iqJNH/g7
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.999
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Es5l0_w7PI5w
	for <acpica-devel@lists.linuxfoundation.org>;
	Tue, 21 Nov 2023 16:50:52 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 99C99610EB
	for <acpica-devel@lists.linuxfoundation.org>; Tue, 21 Nov 2023 16:50:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 99C99610EB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700585453; x=1732121453;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JTdRqF+yP9i6uEWuxlLEu23get1OZ+Y4sxPkDDh2+QM=;
  b=iqJNH/g7ITYlXJ6u/xqgdCCqLOQhuM1Oho4BnE0JkxSyj5g61xtu2xyj
   6YnekkhxX9r8qW9DgLFw7jkZwUtAs2Pplv7ro8oPNyd9JRMi2XbpObJ9C
   B/TgHUMmBA/NJWe4ojIbGuVL1m6NokGcfWAtkjQySuY4BrOmq2W938dKY
   /bMUXSxPCwJtLPdoqsORrwYp3PYeNY5fV9Ap3Og05+iKXSCs1iDvqmCpG
   tXLHj3lEMM8OVp7H3/IFTAXmjOzyiHkOK1+O6zAyZBA5QrL90wMPyaKiI
   wH9JN5Xn0H2Fd1NZ+QxX+6qaMuaY8Nv8nmPIyaHGYDEEnwyz9NJjjX1yV
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="13422926"
X-IronPort-AV: E=Sophos;i="6.04,216,1695711600"; 
   d="scan'208";a="13422926"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 08:50:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="795842221"
X-IronPort-AV: E=Sophos;i="6.04,216,1695711600"; 
   d="scan'208";a="795842221"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 21 Nov 2023 08:50:46 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id A498513A; Tue, 21 Nov 2023 18:50:45 +0200 (EET)
Date: Tue, 21 Nov 2023 18:50:45 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Raag Jadav <raag.jadav@intel.com>
Cc: andriy.shevchenko@linux.intel.com, rafael@kernel.org, lenb@kernel.org,
	robert.moore@intel.com, ardb@kernel.org, will@kernel.org,
	mark.rutland@arm.com, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	acpica-devel@lists.linuxfoundation.org, linux-efi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	mallikarjunappa.sangannavar@intel.com, bala.senthil@intel.com
Subject: Re: [PATCH v2 2/6] ACPI: bus: update acpi_dev_uid_match() to support
 multiple types
Message-ID: <20231121165045.GQ1074920@black.fi.intel.com>
References: <20231121103829.10027-1-raag.jadav@intel.com>
 <20231121103829.10027-3-raag.jadav@intel.com>
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231121103829.10027-3-raag.jadav@intel.com>

On Tue, Nov 21, 2023 at 04:08:25PM +0530, Raag Jadav wrote:
> According to ACPI specification, a _UID object can evaluate to either
> a numeric value or a string. Update acpi_dev_uid_match() helper to
> support _UID matching for both integer and string types.
> 
> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Suggested-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
