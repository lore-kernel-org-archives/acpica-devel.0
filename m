Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794406508;
	b=HDvgCnef4uUR4FPaZZKFbS9mOBMdFyVtyzwEfEeZ60TzEbuIKMR/qnc1iEy0j1ZFybu3
	 gpguA83paEuUu26CFq7LHKKZqnnDYCcC9ZCwBunJe3WKR4Z8IAm2LAssz7JSNdBi25gqQ
	 AtBc1+iJ0N+7pu4s35qzDxgGVtTK8AlUWcreojDPsRcdm2wp+O5Rm1V6aocvt4XQ2EZto
	 eSGSwtwF+mc7wT5T5M5JrXTcfCHMJl89s1Ny8INmWpY76vcw89Wy75dULv0B2uNFgBYXe
	 Kwk9xTJO60aCnm5awtVgyAlEuki1k9amnocoRS6Rc5N1Lx6IMZ0aoQxWw1BO2M4KOVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794406508;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=RRKrPiiXLxIqqSj5iQKbou4siQUwjTukbqJQ8BaYzM0=;
	b=vldnCKhV26ceSYtDEHbzuqkUQhaJJA5nASujW4w8lN1e1T5BZHtAO7D+0gep8bmOCXc3
	 9ZyvCxfngrFleJyf1ty2w7rRKjpogxEn1gM4eObylzcEy6ThnhRUBh0WxeO9JR6JGw9Gz
	 T90Pv6R/mDXmr15/m3DCUHh2XmH+pB8q5Q6M03O7pcfv4bFOnVhjmJv08NfBVDhulu3Mn
	 IMcvJ31yibrXfqU0URhpwqsfdhXDSduBW6052sVEcG2UKspFFKX8dBWBdkSnU8WS9vLUi
	 kWSPov2wEQmSQhsod9aI0P4PQ5JdAVYr/nY876F8b+2VOVyo2jeaTj9eGmmW6zjtvvw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=G+997Pf0;
	arc=none smtp.remote-ip=192.198.163.13
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048F2606A339;
	Wed, 11 Nov 2026 14:15:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 048F2606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=G+997Pf0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794406508; x=1825942508;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FYWLjmEyrSr5TGZ1v1f2UI6FyVNvdj9IceZa13vfjIY=;
  b=G+997Pf0U9AVu+jFxIv0KKFzwWYUTef+mRyLr1sKnfV4BWi/y8G+jIBf
   fBPOIWP2ej+eh1FKqESnyEMvj0spWZ+bEZonIOHxoc9c6U/AMZrnf+nqj
   l/p/i4WkJEDlviyoAxsCViIuWBxgULLCzc3DTOh8R6DwEFwzEsDYJmkc6
   9bz+i555TUsCMBNo5QH0Dc7yBULNQqB3fgQRWpxZ7N2SFW2JyH03GHmcd
   07+nOz7glsrm3iIc1XwCa7M1Pb/DrFJU2yfkRJJ7Orf66S2aupg+EOP4U
   mkuvkWmbkwtTp9NVHIhvsOSYNM5TuOeQUdD0HfIubQIqiPJGxMFMOxk7L
   Q==;
X-CSE-ConnectionGUID: XfXINgJXTUGW2TtNGqTtIQ==
X-CSE-MsgGUID: Hj5LS1RHTpeBrPuToKg4/g==
X-IronPort-AV: E=McAfee;i="6800,10657,11963"; a="3175624"
X-IronPort-AV: E=Sophos;i="6.27,207,1787036400"; 
   d="scan'208";a="3175624"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2026 06:15:01 -0800
X-CSE-ConnectionGUID: fJ2hYlQmRhGtC2EHUopSdg==
X-CSE-MsgGUID: 641PaO2GQqyGf0BX8BN1Qg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,207,1787036400"; 
   d="scan'208";a="8424156"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 11 Nov 2026 06:14:57 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xR96E-00000000yzd-0mnJ;
	Wed, 11 Nov 2026 14:14:54 +0000
Date: Wed, 11 Nov 2026 22:14:12 +0800
From: kernel test robot <lkp@intel.com>
To: Xueqin Luo <luoxueqin@kylinos.cn>, rafael@kernel.org,
	viresh.kumar@linaro.org, sudeep.holla@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, zhanjie9@hisilicon.com,
	christian.loehle@arm.com, zhenglifeng1@huawei.com,
	sumitg@nvidia.com, lenb@kernel.org, maciej.wieczor-retman@intel.com,
	pawel.chmielewski@intel.com, gregkh@linuxfoundation.org,
	dakr@kernel.org, johan@kernel.org, ionela.voinescu@arm.com,
	pierre.gondois@arm.com, linux-pm@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	acpica-devel@lists.linux.dev, driver-core@lists.linux.dev,
	Xueqin Luo <luoxueqin@kylinos.cn>
Subject: Re: [PATCH v6 3/3] arch_topology: Add topology_update_cpu_capacity()
 for runtime updates
Message-ID: <202611112222.Q0bXZAjq-lkp@intel.com>
References: <20261111085022.1229866-4-luoxueqin@kylinos.cn>
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Post: <mailto:acpica-devel@lists.linux.dev>
List-Help: <mailto:acpica-devel+help@lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:acpica-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261111085022.1229866-4-luoxueqin@kylinos.cn>

Hi Xueqin,

kernel test robot noticed the following build warnings:

[auto build test WARNING on driver-core/driver-core-testing]
[also build test WARNING on driver-core/driver-core-next driver-core/driver-core-linus amd-pstate/linux-next amd-pstate/bleeding-edge linus/master v7.4-rc2]
[cannot apply to rafael-pm/linux-next rafael-pm/bleeding-edge next-20261110]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Xueqin-Luo/cpufreq-cppc-Add-update_limits-support-for-Highest-Performance-changes/20261111-165020
base:   driver-core/driver-core-testing
patch link:    https://lore.kernel.org/r/20261111085022.1229866-4-luoxueqin%40kylinos.cn
patch subject: [PATCH v6 3/3] arch_topology: Add topology_update_cpu_capacity() for runtime updates
config: riscv-allnoconfig (https://download.01.org/0day-ci/archive/20261111/202611112222.Q0bXZAjq-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 16.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261111/202611112222.Q0bXZAjq-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202611112222.Q0bXZAjq-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/seqlock.h:20,
                    from include/linux/mmzone.h:17,
                    from include/linux/gfp.h:7,
                    from include/linux/slab.h:17,
                    from include/linux/resource_ext.h:11,
                    from include/linux/acpi.h:14,
                    from drivers/base/arch_topology.c:9:
>> drivers/base/arch_topology.c:232:21: warning: 'raw_capacity_lock' defined but not used [-Wunused-variable]
     232 | static DEFINE_MUTEX(raw_capacity_lock);
         |                     ^~~~~~~~~~~~~~~~~
   include/linux/mutex.h:87:22: note: in definition of macro 'DEFINE_MUTEX'
      87 |         struct mutex mutexname = __MUTEX_INITIALIZER(mutexname)
         |                      ^~~~~~~~~


vim +/raw_capacity_lock +232 drivers/base/arch_topology.c

   230	
   231	static u32 *raw_capacity;
 > 232	static DEFINE_MUTEX(raw_capacity_lock);
   233	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
