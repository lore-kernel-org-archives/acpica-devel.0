Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.137
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793656083;
	b=yM64ezweuAdOl/lYYiBnVUsZlJqrDXhlF/nX4GZpSyfREBrgPbW8it5Py5lUlIK0WEv2
	 ia1/ouIqH4osWlF5VVNWedBdpHXBOBXEOXhaR3los1Ae8dv9gOvuKfjVrWBOpN4HdCusV
	 NjFwWPjC2II7CkS8+YC8Zo1dNG5BAHVVevkh5hZFPEvy25uHVSx4czlF9H+gnKyD+6DTf
	 2XK/0uH8GDzEbec0s+wTOuZTJ7o1q7BZES85mNvTgj3SSyBzg92PBVoklYkJrHcjK7C40
	 Q3mZXnFSx3r0hXKpodWrOr5O5if8LG1vwcm7QLN0Q+sWJ9BTxDw6E1TgLaXd5bxi5cA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793656083;
	h=Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=aUDLACHlyrxhpmZGNWGB4QTE3dHwiL05kQfWOo8WH70=;
	b=SjwwuianG9zUanjnGIVd14Tb0sTKqLzZAaiy3hfrtRdIXoLNZmaxgo1HB27Mnz4PCb1Y
	 J7J0ou1EoLNeUoWQSG8qXhZ3qyOJ479keeS9z+JTqASZVZWh5nRf0Z+14HC4A0m1hhNSy
	 Je2Z+JfPstP/XI4dNGjXQhzmQJLI2b0sFXW3MgvYX0uN/MHkDj4Co/Qis/w7bagueai/i
	 pW1Epylz25Lxaf2qsiDX5UYCnEydLScclf5L9XAq2HDdPMiq+7k2jP+y1TJWg+gGD2hc9
	 U6nNN1HY+qI6FUlLj2mb4i3hEg1Fxc6oxM0VSj/de4oia/LQDCtMvONVEF4yX2HQktA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=RyhR0L4I;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.137
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24DA4606D825
	for <acpica-devel@lists.linuxfoundation.org>; Mon,  2 Nov 2026 21:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=RyhR0L4I
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BD36E40525
	for <acpica-devel@lists.linuxfoundation.org>; Mon,  2 Nov 2026 21:48:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.649
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BcZZJlg6Xsi0 for <acpica-devel@lists.linuxfoundation.org>;
 Mon,  2 Nov 2026 21:48:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 8EEF04052D
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=198.175.65.15
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793656081;
	b=suW7t7lAdTLZ5LOC2Km0xcd8Go1dpnUz59sWEPgMSFsyFf1sIyApHBWModerOZm0Yu51
	 jh8rRAgmjnWSFdsYzJFObQW/PrgyHwzQOt1paqbUMBS2R4NPI2CPAWQZdtV21IEeD8xzO
	 Y+YN1dctJTeRElPjmNDNjCSP8WE7rlW33PF2hXjDsYnfmJxoIb20jGnXhzgK+WAa1ENfh
	 zYVLWe1BNzbtDK3TrtvVHqkeC5FWq46SpQ80haR1Xr++vl5+n6MqGh3bnUjFXtS57qDF6
	 I2El8jMdIB00LpGsIIqyWYEpNXABg+LGeOfDxsGSuUOxfVbHuVJpsaZ7+eurHPdCRsA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793656081;
	h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=aUDLACHlyrxhpmZGNWGB4QTE3dHwiL05kQfWOo8WH70=;
	b=pCfdpEBwusQosw1gcHXcOiHM3w23y40NlKLB5oKrrFgLbfhSYkEjJS3phnDDeZp9rBqp
	 ckfKNoU90lnaD8QQ+OFCvEMszLXk3Upm9QZyrf2BRO+Do1kqaRLCuz97L142U2MLvjFt6
	 o0RpDWsD1bXhOWmgsgIPxNwvHJ5Ssk9Gwysgf2cOPw4HOOtNPmAlOQ2YlbqGUTkhLfDDK
	 AhCnI2tB4LVFq8eg0JppRAdqdqWFe1b0tIf+nfBOH/7tZWuVIzgNbTBSKPNozNFvkB33G
	 D8febe1oW3ADXu0I6XF/LQd9bu56Xz65/Q50CcJ/dNKz+JGxqrzoVsnjXl7hwRoy2oQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=RyhR0L4I;
	arc=none smtp.remote-ip=198.175.65.15
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.15; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=RyhR0L4I
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 8EEF04052D
	for <acpica-devel@lists.linuxfoundation.org>; Mon,  2 Nov 2026 21:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793656081; x=1825192081;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+k5sFKZYE6g5VogYmHeXbYF3Ix0grhxDoNMr2/mr34A=;
  b=RyhR0L4ImdHCGe5jS8ZGbKkmUbqttPzagX7fJKhYrfrVza+rScZbsWEO
   Al1551FyrCuCsaUE4dSZrwQRXqumXwfMHdfZTL/XaAkJ3YALZtYm+QTU0
   V112Y0FdAcIiN70WILEi6eKEl4eDHx1G8Vg1FQ+2olfpNJ9R4MQw89oOe
   LBLGFe6sKKQMqnZ8331+gBccbfXFhBWRjEauHYnV82UzNJ5wjcub+Qfpq
   qX/FtIZYL2YI8a34J4aQ7nf0IGy1Ui5xqmLFGMPtPJ5Nq6aeeA+w67ztK
   C6PKXmcL+2KxwbnTKfujNuzPawBtGEdgBCxzYd2Ipqj6LOeYRIHCk6Ivy
   g==;
X-CSE-ConnectionGUID: Z5t+B63uS8eOnbkjONiosQ==
X-CSE-MsgGUID: GKCWC8MgRDurhRCrq/mhTA==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2373264"
X-IronPort-AV: E=Sophos;i="6.27,192,1787036400"; 
   d="scan'208";a="2373264"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 13:47:59 -0800
X-CSE-ConnectionGUID: wkZDEhLfRpyproKLtvzocw==
X-CSE-MsgGUID: ZcDCcwAfR72GqeNUK/o4Cg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,192,1787036400"; 
   d="scan'208";a="8069525"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa013.fm.intel.com with ESMTP; 02 Nov 2026 13:47:57 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xNzsg-00000000htI-0DiS;
	Mon, 02 Nov 2026 21:47:54 +0000
Date: Tue, 3 Nov 2026 05:47:16 +0800
From: kernel test robot <lkp@intel.com>
To: "Baorui.Liu" <baorliu@amd.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	acpica-devel@lists.linuxfoundation.org,
	kernel test robot <lkp@intel.com>, "Baorui . Liu" <baorliu@amd.com>
Subject: Re: [PATCH v6] ACPI: button: Report wakeup key only for power button
 wakeups
Message-ID: <202611030545.3st9p1ha-lkp@intel.com>
References: <20261102091049.856-1-baorliu@amd.com>
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
In-Reply-To: <20261102091049.856-1-baorliu@amd.com>

Hi Baorui.Liu,

kernel test robot noticed the following build errors:

[auto build test ERROR on rafael-pm/linux-next]
[also build test ERROR on rafael-pm/bleeding-edge linus/master v7.3 next-20261030]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Baorui-Liu/ACPI-button-Report-wakeup-key-only-for-power-button-wakeups/20261102-171049
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/20261102091049.856-1-baorliu%40amd.com
patch subject: [PATCH v6] ACPI: button: Report wakeup key only for power button wakeups
config: arm64-randconfig-1001-20261102 (https://download.01.org/0day-ci/archive/20261103/202611030545.3st9p1ha-lkp@intel.com/config)
compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd708029e0b2869e80abe31ddb175f7c35361f90)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261103/202611030545.3st9p1ha-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202611030545.3st9p1ha-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/gpu/drm/nouveau/nouveau_connector.c:27:
   include/acpi/button.h:28:15: error: unknown type name 'bool'
      28 | static inline bool acpi_sleep_pwr_btn_wakeup_pending(void)
         |               ^
   include/acpi/button.h:30:9: error: use of undeclared identifier 'false'; did you mean 'else'?
      30 |         return false;
         |                ^~~~~
         |                else
>> include/acpi/button.h:30:9: error: expected expression
   In file included from drivers/gpu/drm/nouveau/nouveau_connector.c:29:
   In file included from include/linux/pm_runtime.h:11:
   In file included from include/linux/device.h:32:
   In file included from include/linux/device/driver.h:21:
   In file included from include/linux/module.h:20:
   In file included from include/linux/elf.h:6:
   In file included from arch/arm64/include/asm/elf.h:133:
   In file included from include/linux/fs.h:5:
   In file included from include/linux/fs/super.h:5:
   In file included from include/linux/fs/super_types.h:13:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:7:
   include/linux/signal.h:98:11: warning: array index 3 is past the end of the array (that has type 'unsigned long[1]') [-Warray-bounds]
      98 |                 return (set->sig[3] | set->sig[2] |
         |                         ^        ~
   include/uapi/asm-generic/signal.h:62:2: note: array 'sig' declared here
      62 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from drivers/gpu/drm/nouveau/nouveau_connector.c:29:
   In file included from include/linux/pm_runtime.h:11:
   In file included from include/linux/device.h:32:
   In file included from include/linux/device/driver.h:21:
   In file included from include/linux/module.h:20:
   In file included from include/linux/elf.h:6:
   In file included from arch/arm64/include/asm/elf.h:133:
   In file included from include/linux/fs.h:5:
   In file included from include/linux/fs/super.h:5:
   In file included from include/linux/fs/super_types.h:13:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:7:
   include/linux/signal.h:98:25: warning: array index 2 is past the end of the array (that has type 'unsigned long[1]') [-Warray-bounds]
      98 |                 return (set->sig[3] | set->sig[2] |
         |                                       ^        ~
   include/uapi/asm-generic/signal.h:62:2: note: array 'sig' declared here
      62 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from drivers/gpu/drm/nouveau/nouveau_connector.c:29:
   In file included from include/linux/pm_runtime.h:11:
   In file included from include/linux/device.h:32:
   In file included from include/linux/device/driver.h:21:
   In file included from include/linux/module.h:20:
   In file included from include/linux/elf.h:6:
   In file included from arch/arm64/include/asm/elf.h:133:
   In file included from include/linux/fs.h:5:
   In file included from include/linux/fs/super.h:5:
   In file included from include/linux/fs/super_types.h:13:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:7:
   include/linux/signal.h:99:4: warning: array index 1 is past the end of the array (that has type 'unsigned long[1]') [-Warray-bounds]
      99 |                         set->sig[1] | set->sig[0]) == 0;
         |                         ^        ~
   include/uapi/asm-generic/signal.h:62:2: note: array 'sig' declared here
      62 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from drivers/gpu/drm/nouveau/nouveau_connector.c:29:
   In file included from include/linux/pm_runtime.h:11:
   In file included from include/linux/device.h:32:
   In file included from include/linux/device/driver.h:21:
   In file included from include/linux/module.h:20:
   In file included from include/linux/elf.h:6:
   In file included from arch/arm64/include/asm/elf.h:133:
   In file included from include/linux/fs.h:5:
   In file included from include/linux/fs/super.h:5:
   In file included from include/linux/fs/super_types.h:13:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:7:
   include/linux/signal.h:101:11: warning: array index 1 is past the end of the array (that has type 'unsigned long[1]') [-Warray-bounds]
     101 |                 return (set->sig[1] | set->sig[0]) == 0;
         |                         ^        ~
   include/uapi/asm-generic/signal.h:62:2: note: array 'sig' declared here
      62 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from drivers/gpu/drm/nouveau/nouveau_connector.c:29:
   In file included from include/linux/pm_runtime.h:11:
   In file included from include/linux/device.h:32:
   In file included from include/linux/device/driver.h:21:
   In file included from include/linux/module.h:20:
   In file included from include/linux/elf.h:6:
   In file included from arch/arm64/include/asm/elf.h:133:
   In file included from include/linux/fs.h:5:
   In file included from include/linux/fs/super.h:5:
   In file included from include/linux/fs/super_types.h:13:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:7:
   include/linux/signal.h:114:11: warning: array index 3 is past the end of the array (that has type 'const unsigned long[1]') [-Warray-bounds]
     114 |                 return  (set1->sig[3] == set2->sig[3]) &&
         |                          ^         ~
   include/uapi/asm-generic/signal.h:62:2: note: array 'sig' declared here
      62 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from drivers/gpu/drm/nouveau/nouveau_connector.c:29:
   In file included from include/linux/pm_runtime.h:11:
   In file included from include/linux/device.h:32:
   In file included from include/linux/device/driver.h:21:
   In file included from include/linux/module.h:20:


vim +30 include/acpi/button.h

    17	
    18	/*
    19	 * Set in acpi_suspend_enter() when the fixed power-button status bit is
    20	 * observed (IRQ-disabled context). Consumed by the button driver on resume
    21	 * so KEY_WAKEUP can be reported without calling into the button driver from
    22	 * that early path. Implemented in sleep.c (built-in); safe when
    23	 * CONFIG_ACPI_BUTTON=m.
    24	 */
    25	#ifdef CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT
    26	bool acpi_sleep_pwr_btn_wakeup_pending(void);
    27	#else
    28	static inline bool acpi_sleep_pwr_btn_wakeup_pending(void)
    29	{
  > 30		return false;
    31	}
    32	#endif
    33	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
