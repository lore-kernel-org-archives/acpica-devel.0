Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.136
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793639698;
	b=Ss1h/sMeL0lDtFt+pIFHIOstGdl5+gU5ZkN1umaYM+XKJdH/Hsz6lmBbAbNQRKmZTPcG
	 U51ItjWlVlnrCR6LpvC/bkRFnUtW4gop0RI0cqWfBFJED/gRVeVBv/IPFcvIwDfProc7P
	 d4Je7CLOKJKe/keWZuS4JPORE1E/wCXNNGzenRaw8UBq7a/IAoT3fnTgCfEssv8AfywII
	 dpNYctXaOZcIS2R1d2dmOsDmgXwIyDeuMFpz17kyYHllEWWxI8GPb0xyCVHTIEuKp0+1L
	 AZtir0V22wsxlPMQkAFqwxKR2I4RVBCKfxR/eegSWq9OGIuVpv8/22iu62zg/Czx7dA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793639698;
	h=Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=VfgSp3cgsfqtOO3clcrfty+qD2Zy4jlWdWJ9kVouLvk=;
	b=ZnbYZhVqZb5QWjHT78pmKYOlcOAykjsOy7quPyd8HRwxWFFf/NhTdgcR0t/qriwGej+r
	 kuk4jO8eaIcRCj9rCECnA37eWMoDrC9Ocm9QAD6ZvvmK3zGJeDsMkeVl0Pw20qHMas3Jy
	 GBNLkH8DRvsJUJG4+Ty5pYyCp1bTXK1L46q4CbM4Lx1YE3FCclYBfdWYlBMX91RjT+5yr
	 /hSPIVJJLuKuriDTY0zaHE611NCapfSGLLrCz2cj5LRpCjM1UI5ai8d8mWtUV/ntlM64r
	 18VKnFiy9uluBohSXvzZpfaxldNBaHKUSRtsCC7HiPAQSgyQbPSidFFvlcHLF5N0VUQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=nyqkyan8;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.136
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF012607039F
	for <acpica-devel@lists.linuxfoundation.org>; Mon,  2 Nov 2026 17:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=nyqkyan8
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 594AA605E8
	for <acpica-devel@lists.linuxfoundation.org>; Mon,  2 Nov 2026 17:14:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.649
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HnsF1Q_gIH0r for <acpica-devel@lists.linuxfoundation.org>;
 Mon,  2 Nov 2026 17:14:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 48A68605E4
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=198.175.65.14
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793639696;
	b=gH8CW7hKgTncx9UjroWmYIokXQozzIJ+GClrjytZq/m4kmJEiadzyjMf5p7xM6FXCaFR
	 EI8FJe3LItYE5AcjhbfKd8lo4iEvRJD6Dpd8WTY1kGtrcOLDol42IYydhJU59w+zsNn13
	 dML4XAEpGFywVTeAS6Kp/seq/V0HqtKww7w7M7nHvOCdcCVEJvSz6qfraYq9O5f4cPHbC
	 q5byuNpch2Jaf9dCSWrc9doFEOY89AhdxCrUEB3nG3i0Siqej+1oVmc6V8DtM3im1fEYc
	 mShen13KGEyODPdU/J7u7jYOOr5KE8VFaoh+hPwlMUWg+F/jdDvzXyMrsZVcpZO5Abg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793639696;
	h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=VfgSp3cgsfqtOO3clcrfty+qD2Zy4jlWdWJ9kVouLvk=;
	b=V5SHHlG7/LL0x11lzt/WPexy+kit822PBbwoxvXVxnYvc2ZSgZwX2bgSaKdCMehYUlVe
	 Mo895l+bPzYI9mD2ZQ5emBOS3yZhuWzAaCnkSMzm5rtGsC7e5Pyc/XPzfvBWUi2VxgCuc
	 fWB6mySuIWxDl4GWolIbvrr7fIUqvQP9DTL/3JBaDVqMxgHg7FRcuwH4c2VnarIQGBmHk
	 X1CtQqDDxY8AC4ZI1OAHhKWZ3YipDEWgPnYwKRW6iomn8Nn25go/yTE4tLniASvSBB5W/
	 1MHtPuznXFbTo0urOF9oV3NuHlZ2GGyJWNp8scn2ClrAB2+mTL+7XFPxjfpoGJYAKJA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=nyqkyan8;
	arc=none smtp.remote-ip=198.175.65.14
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.14; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=nyqkyan8
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 48A68605E4
	for <acpica-devel@lists.linuxfoundation.org>; Mon,  2 Nov 2026 17:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793639697; x=1825175697;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nqQzviCw5HLUlkzPdxIrNo2VwlVDrJt0aA/SRwJ9iM0=;
  b=nyqkyan8Ub5r4dTxgwA0r878SdvZBC24qffGMu/tzO9dLaitLEFYufDz
   82b3S4CJBnODXqP7QAeOiqIJtv+k8dipVqAo0OURXLWMnCtgCjkguQACW
   qVJgDaoH7tA3wBFDnQwQZDbDT/NV4vq7h5HPFKL9XUpxT7mMSzRPSclTF
   1xUQX+wTYV+eopnK56p0O7zmk71GVGFmHhwOq9uDhm8hN/jPuhYVFP43z
   1diq8KCimU5U6D1zeW0UdRKylBdr4sGfEcnmwj3kf/SJMDlXKIYJpks7M
   d8wJxi8fQ56VMCVpAingfiFXR7LQtkxmSVfpnQC+KZTNaqj7ZOdeQekse
   w==;
X-CSE-ConnectionGUID: orkEkywbTDmu9LF4BtJzyw==
X-CSE-MsgGUID: nVjUaID3QrGyMjMS6LfgTg==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2225039"
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="2225039"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 09:14:54 -0800
X-CSE-ConnectionGUID: TEisa5mfRCas7EY00UyDFA==
X-CSE-MsgGUID: K8D+DgofRzKhGujlSLaQqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="6055091"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 02 Nov 2026 09:14:52 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xNvcP-00000000hYa-2VbF;
	Mon, 02 Nov 2026 17:14:49 +0000
Date: Tue, 3 Nov 2026 01:14:24 +0800
From: kernel test robot <lkp@intel.com>
To: "Baorui.Liu" <baorliu@amd.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	acpica-devel@lists.linuxfoundation.org,
	kernel test robot <lkp@intel.com>, "Baorui . Liu" <baorliu@amd.com>
Subject: Re: [PATCH v6] ACPI: button: Report wakeup key only for power button
 wakeups
Message-ID: <202611030112.cVsBZFFE-lkp@intel.com>
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
config: parisc64-defconfig (https://download.01.org/0day-ci/archive/20261103/202611030112.cVsBZFFE-lkp@intel.com/config)
compiler: hppa64-linux-gcc (GCC) 16.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261103/202611030112.cVsBZFFE-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202611030112.cVsBZFFE-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/gpu/drm/nouveau/nouveau_connector.c:27:
>> include/acpi/button.h:28:15: error: unknown type name 'bool'
      28 | static inline bool acpi_sleep_pwr_btn_wakeup_pending(void)
         |               ^~~~
   include/acpi/button.h:1:1: note: 'bool' is defined in header '<stdbool.h>'; this is probably fixable by adding '#include <stdbool.h>'
     +++ |+#include <stdbool.h>
       1 | /* SPDX-License-Identifier: GPL-2.0 */
   include/acpi/button.h: In function 'acpi_sleep_pwr_btn_wakeup_pending':
>> include/acpi/button.h:30:16: error: 'false' undeclared (first use in this function)
      30 |         return false;
         |                ^~~~~
   include/acpi/button.h:30:16: note: 'false' is defined in header '<stdbool.h>'; this is probably fixable by adding '#include <stdbool.h>'
   include/acpi/button.h:30:16: note: each undeclared identifier is reported only once for each function it appears in


vim +/bool +28 include/acpi/button.h

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
  > 28	static inline bool acpi_sleep_pwr_btn_wakeup_pending(void)
    29	{
  > 30		return false;
    31	}
    32	#endif
    33	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
