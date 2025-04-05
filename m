Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9821B042E;
	Sat,  5 Apr 2025 07:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743836773; cv=none; b=NTvR2gK6I/tPheTQTqCp1GkD8hgYwAkJ6/biKhf98oxf8up8went51gyrvDbvJGP+Hh/RLx0fFg95gIO3ubGCZ0iD/jOmqkOIMVIiCs474S/G42WHGZQSIGKqDDLTYk8bksFFizagTiFv+v3/tZwxjlNqxTu9pQH4YFpeaE0KaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743836773; c=relaxed/simple;
	bh=c6pVeoNRFL0+YVb4Jo8fBY1tS3Gnyl5Tlg2+CQkLYkI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e6gwe3efLOXYSyV7Xf53DwqJmh9LAF40K3D+K40llk4THxb3lAIQyTvhCVeBRwY8BNT87LLTVas/xsVA1X/dwSfE3FJN3x6I0GTidMs7lGdZjVVAHOPPy1IlS5KuUeorntKRy2RpRwf28u1WXIbC7vZHG0QYwYIhpEP3nxJSYU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PCSAIY7v; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PCSAIY7v"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743836772; x=1775372772;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=c6pVeoNRFL0+YVb4Jo8fBY1tS3Gnyl5Tlg2+CQkLYkI=;
  b=PCSAIY7vkz4YMMHlD8H/2W513+60eolcXmKvJaWbcB0x/hh04vr5WJ9E
   bWLIQbTabAj5lsHwsMYVKro+s0rOj0MPF/qUzhjlqMLSDTzi1R8msvHDZ
   yP8WO4XAWehSNs4PWsqCjZ/bYh0uvJygkpoedytY+O55nRpNR3xP7+rU2
   +lmFjhSUdkyCGH7DTzZ9AQit94vWoDZCsg3PksH9D1VVPrQ03Uow1lJLn
   5G1HJEBMo6a5wGVABamZooa0Zo6zBXlBTP/fKYmBm+qOynDWy9xsXdBXP
   Rs15826WEtZDLG2UGYWm1K3FWpaCj2BhdeRkpCnf9eT4gVe4xv212oRoF
   A==;
X-CSE-ConnectionGUID: 7CX3l2GERw6KNBCuDhz45A==
X-CSE-MsgGUID: akPDMciRQoCIMZGJcTWLJA==
X-IronPort-AV: E=McAfee;i="6700,10204,11394"; a="49072309"
X-IronPort-AV: E=Sophos;i="6.15,190,1739865600"; 
   d="scan'208";a="49072309"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2025 00:06:09 -0700
X-CSE-ConnectionGUID: gAUA3IfzRCe9ESoQV2bv5Q==
X-CSE-MsgGUID: +NpNIIZ+TPOZvAzfnJgRgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,190,1739865600"; 
   d="scan'208";a="132472871"
Received: from lkp-server01.sh.intel.com (HELO b207828170a5) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 05 Apr 2025 00:06:02 -0700
Received: from kbuild by b207828170a5 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1u0xbC-0001sB-2q;
	Sat, 05 Apr 2025 07:05:50 +0000
Date: Sat, 5 Apr 2025 15:04:55 +0800
From: kernel test robot <lkp@intel.com>
To: Ahmed Salem <x0rw3ll@gmail.com>, robert.moore@intel.com,
	rafael.j.wysocki@intel.com, lenb@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] ACPI: sysfs: apply ACPI_NONSTRING annotation
Message-ID: <202504051453.3rcptolF-lkp@intel.com>
References: <dcc3a018fb28899b277df2e154740d59d4e404af.1743754416.git.x0rw3ll@gmail.com>
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dcc3a018fb28899b277df2e154740d59d4e404af.1743754416.git.x0rw3ll@gmail.com>

Hi Ahmed,

kernel test robot noticed the following build errors:

[auto build test ERROR on b3c623b9a94f7f798715c87e7a75ceeecf15292f]

url:    https://github.com/intel-lab-lkp/linux/commits/Ahmed-Salem/ACPI-PRM-apply-ACPI_NONSTRING-annotation/20250404-162651
base:   b3c623b9a94f7f798715c87e7a75ceeecf15292f
patch link:    https://lore.kernel.org/r/dcc3a018fb28899b277df2e154740d59d4e404af.1743754416.git.x0rw3ll%40gmail.com
patch subject: [PATCH 2/2] ACPI: sysfs: apply ACPI_NONSTRING annotation
config: i386-buildonly-randconfig-004-20250405 (https://download.01.org/0day-ci/archive/20250405/202504051453.3rcptolF-lkp@intel.com/config)
compiler: clang version 20.1.2 (https://github.com/llvm/llvm-project 58df0ef89dd64126512e4ee27b4ac3fd8ddf6247)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250405/202504051453.3rcptolF-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202504051453.3rcptolF-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/acpi/sysfs.c:310:30: error: expected ';' at end of declaration list
     310 |         char name[ACPI_NAMESEG_SIZE] ACPI_NONSTRING;
         |                                     ^
         |                                     ;
   drivers/acpi/sysfs.c:312:49: error: expected ';' at end of declaration list
     312 |         char filename[ACPI_NAMESEG_SIZE+ACPI_INST_SIZE] ACPI_NONSTRING;
         |                                                        ^
         |                                                        ;
   2 errors generated.


vim +310 drivers/acpi/sysfs.c

   307	
   308	struct acpi_table_attr {
   309		struct bin_attribute attr;
 > 310		char name[ACPI_NAMESEG_SIZE] ACPI_NONSTRING;
   311		int instance;
   312		char filename[ACPI_NAMESEG_SIZE+ACPI_INST_SIZE] ACPI_NONSTRING;
   313		struct list_head node;
   314	};
   315	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
