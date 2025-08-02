Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F93FBE4A;
	Sat,  2 Aug 2025 00:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754095935; cv=none; b=n7hHp3TBGwlk08HiMCOwZDLwe2lpxh0b5yjVcGkkY8vc7ieht3aVgvDcPD50nktrObAwxJOONDpUN1jV9/FzE8PlICKzBFLW+LLhSRdHOP3vpX9ACtuajFTDL+sRSaBXd73F1MGal/tYSDNaZbAuVFAWyUxHR1KDUnSKMGhD6Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754095935; c=relaxed/simple;
	bh=cLiV1YAVc0XpLVydFzX5qDQFT8RxMUqUxFC45R3+Hu0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E35/dql52jj4hHtz5wU84Y6Hb9dnRaor9AmGawZTA5Brz3T03K0edE8D6ypePKJu6b3XwOTHz2JPb992Z/LeYrSSXojBCDQuCztyF99qPhrYaSbXLRDKP7Yo7OTGa5TqJBtQsQ9sXXaJLWUiBoZrqabCwhsOiHlp+R50gin4THE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oCHl+gS4; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oCHl+gS4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754095933; x=1785631933;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cLiV1YAVc0XpLVydFzX5qDQFT8RxMUqUxFC45R3+Hu0=;
  b=oCHl+gS46wcfHNb9atlGMbxXFjfbzGkwoEDqkZXcDpkswKcSwJ5TIlmt
   S1B0tI61HVhUJwdJ91CYhPMwnEfcDYd0Pue8p7wy7wMkvyGAhNcnGpx6R
   BW/vUG7GNciYXbUJ1sFOYSzW/rKUJnscu8mVDh0qWPd7KEzH4WKdZmh14
   KkY/7n6ZTxUZO2Y05UouCMDWpq184IC9kytQpTcBss4AerBiUgOWHNhHd
   2vk42IPezlyDi1nx3tvSUQt4jxsc0NCKDto8Swnd8I86Djlen25Rz1FSM
   MzyjgoD6pzsVQgHm5kUXs7yW16sM9ntezfJsXKNodkxAoPENZocxa9zpF
   Q==;
X-CSE-ConnectionGUID: 0FZYLOLVRXu7l7vZdZDgnw==
X-CSE-MsgGUID: gNkU2WPsSmGkJwuIJWyE0Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11508"; a="67020065"
X-IronPort-AV: E=Sophos;i="6.17,258,1747724400"; 
   d="scan'208";a="67020065"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2025 17:52:13 -0700
X-CSE-ConnectionGUID: rhpO9yacQcSx45fuiX/l8g==
X-CSE-MsgGUID: +seHoRPmSrS3nDsJ+5KE6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,258,1747724400"; 
   d="scan'208";a="164083746"
Received: from lkp-server01.sh.intel.com (HELO 160750d4a34c) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 01 Aug 2025 17:52:07 -0700
Received: from kbuild by 160750d4a34c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ui0Tk-000536-2p;
	Sat, 02 Aug 2025 00:52:04 +0000
Date: Sat, 2 Aug 2025 08:51:49 +0800
From: kernel test robot <lkp@intel.com>
To: Breno Leitao <leitao@debian.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, James Morse <james.morse@arm.com>,
	Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
	Robert Moore <robert.moore@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Hanjun Guo <guohanjun@huawei.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Bjorn Helgaas <helgaas@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-media@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	acpica-devel@lists.linux.dev, osandov@osandov.com,
	xueshuai@linux.alibaba.com, konrad.wilk@oracle.com,
	linux-edac@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-pci@vger.kernel.org, kernel-team@meta.com, osandov@fb.com,
	Breno Leitao <leitao@debian.org>
Subject: Re: [PATCH v4] vmcoreinfo: Track and log recoverable hardware errors
Message-ID: <202508020814.lzX1CZpj-lkp@intel.com>
References: <20250801-vmcore_hw_error-v4-1-fa1fe65edb83@debian.org>
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250801-vmcore_hw_error-v4-1-fa1fe65edb83@debian.org>

Hi Breno,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 89748acdf226fd1a8775ff6fa2703f8412b286c8]

url:    https://github.com/intel-lab-lkp/linux/commits/Breno-Leitao/vmcoreinfo-Track-and-log-recoverable-hardware-errors/20250801-211624
base:   89748acdf226fd1a8775ff6fa2703f8412b286c8
patch link:    https://lore.kernel.org/r/20250801-vmcore_hw_error-v4-1-fa1fe65edb83%40debian.org
patch subject: [PATCH v4] vmcoreinfo: Track and log recoverable hardware errors
config: x86_64-defconfig (https://download.01.org/0day-ci/archive/20250802/202508020814.lzX1CZpj-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250802/202508020814.lzX1CZpj-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508020814.lzX1CZpj-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> vmlinux.o: warning: objtool: hwerr_log_error_type+0x23: call to ktime_get_real_seconds() leaves .noinstr.text section

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
