Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794425510;
	b=zTzhBXIaZfGr7ddzeXlxBQx8OYFkD9M4ml6YTAtmgF1OZa7iFDwVyx+Q1pQfhxkJPoPc
	 +FV8WDmQS/OHm/Parj9RFqczaC869/T+JGGSIlj/bmYgXdyzV8IZytvIabB5CUvyqR0os
	 5ipcJea5uEDaZ1GNNAh2EC+8t6V3LUl4GI4JiaErkVv7XGmPmRF73YdOYB8BuO8OKS9o9
	 Z8opGOZPqHaT1M1Y4hO+n/PL9IkXEfhN2YYvPxFDH32ETuD6zMHGbBrISAhicHlJZVBKo
	 vMyWZkhCthvCiuX+V9VTQVy0gnaMIshOCrI0aFBuaQlv813SamK8M1EyjlvIy+OArqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794425510;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=Ihmjpaq362zzdxmp/sT8AuTP1S4oabw2RE04rYS9y5E=;
	b=UyLlX54nb+HsxRaJyYBSjC2qxHenKuRxjRpWWeEat4l2H6xa8ksmDCzCn6gK/bSHwQOO
	 HCmlBRF0nV/TqeH9rj1t8nOf9Ded5fSjLJCp2ZeFzfEAQo5Jl0UOlub9o731C9pfE1TWN
	 lBGroGzaa5CH9deZAoqmmzMB1RGvXL7N7ve60nNHkyi7imw3ryaBsZjuIRs+9HbgzKtkH
	 52Y7VrEQAqDY4BJY3bVqMJHdk3h+OgIYhpV8H3hgiVn9J28lEF9qQVyn3p+7X2SoRKQkp
	 Xsh8HKePT7blYNK36xUzoBurpLlpNM103p2C7cVEnI7HuXqbb0OtSlm5LTPggig43Nw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=T0dFk7c9;
	arc=none smtp.remote-ip=198.175.65.11
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12F9606A333;
	Wed, 11 Nov 2026 19:31:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A12F9606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=T0dFk7c9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794425510; x=1825961510;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DcTofesJFT1jeKz+4gvXAC2F9ujJKAM96Sgs1nkt01o=;
  b=T0dFk7c9m3m7kFV4rOmhFdAQVhA4EAKbMnU6tKzTmHNAY9tSf3moFCM2
   KkW5lZZ0vJm/Sdy3Mpyq97CUwZeVBDRGwU55IDYyn3+QWvUnibJ475new
   XNKJRvOONmrAXiN9Ya6Kas+JuQQcSNLY0T5XGbySWLtI0ZbEr4mYBKIlO
   xRn9rPoLbS+RM9SnsWUCkSSxCbP0QcvT5mmziO/mvcQGZRzzoeKxSAeBF
   rAdgh2ioWxHtf0/etD4GifkhI9WuSA6XFkBsr2UIznCeuNn1y3TkuGOpJ
   pLTwhmpP6xYYJU8SN6iEfRpQMa2nax60vhzL2L2FswsxD8TRKsUpHjr0q
   Q==;
X-CSE-ConnectionGUID: iyKSmpnzSlyDwx4qiwLvmQ==
X-CSE-MsgGUID: LWMCpU3qTT6ccSin4DAGpA==
X-IronPort-AV: E=McAfee;i="6800,10657,11963"; a="3099043"
X-IronPort-AV: E=Sophos;i="6.27,208,1787036400"; 
   d="scan'208";a="3099043"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2026 11:31:49 -0800
X-CSE-ConnectionGUID: 7Qov/K15S6C/fBiJhfO24g==
X-CSE-MsgGUID: l+vjy1i3SXmfMFLMolRq8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,208,1787036400"; 
   d="scan'208";a="8820410"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 11 Nov 2026 11:31:44 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xRE2n-00000000zZl-2KpJ;
	Wed, 11 Nov 2026 19:31:41 +0000
Date: Thu, 12 Nov 2026 03:30:51 +0800
From: kernel test robot <lkp@intel.com>
To: Xueqin Luo <luoxueqin@kylinos.cn>, rafael@kernel.org,
	viresh.kumar@linaro.org, sudeep.holla@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	zhanjie9@hisilicon.com, christian.loehle@arm.com,
	zhenglifeng1@huawei.com, sumitg@nvidia.com, lenb@kernel.org,
	maciej.wieczor-retman@intel.com, pawel.chmielewski@intel.com,
	gregkh@linuxfoundation.org, dakr@kernel.org, johan@kernel.org,
	ionela.voinescu@arm.com, pierre.gondois@arm.com,
	linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, acpica-devel@lists.linux.dev,
	driver-core@lists.linux.dev, Xueqin Luo <luoxueqin@kylinos.cn>
Subject: Re: [PATCH v6 3/3] arch_topology: Add topology_update_cpu_capacity()
 for runtime updates
Message-ID: <202611120358.5eM3xOiA-lkp@intel.com>
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
config: arm-defconfig (https://download.01.org/0day-ci/archive/20261112/202611120358.5eM3xOiA-lkp@intel.com/config)
compiler: clang version 24.0.0git (https://github.com/llvm/llvm-project e73e336290028f26553b46c9fba844c13da38c9c)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261112/202611120358.5eM3xOiA-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202611120358.5eM3xOiA-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/base/arch_topology.c:232:21: warning: unused variable 'raw_capacity_lock' [-Wunused-variable]
     232 | static DEFINE_MUTEX(raw_capacity_lock);
         |                     ^~~~~~~~~~~~~~~~~
   1 warning generated.


vim +/raw_capacity_lock +232 drivers/base/arch_topology.c

   230	
   231	static u32 *raw_capacity;
 > 232	static DEFINE_MUTEX(raw_capacity_lock);
   233	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
