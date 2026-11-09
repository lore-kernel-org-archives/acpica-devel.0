Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.136
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794258732;
	b=DO1+v8rrnzANOnXmKog9N5wCAjo8PPn3lmJXR/0P35cJPpIikGijivchvgxVETgRKCyu
	 9dbSEExKwBBBHVKDgLVy7gAvhdxUrs3y6RbrxZYi420GbCF413FSW4HsK2I1aDKGvU7fP
	 h/Dm+BIRtAqUZueHSyp7SDv3pZEieFdwHA0FXcNL/QpVpFbvuaZfz+E4rUCmBNNd8wEFR
	 hZHKur/WiUJaVcXCN/IzZ+rsJgBtXcYn1y8rAV0oGydI5OIZ22fWj7YOxdFZEfkgRvlUU
	 TRDZMt3LxVQdCKaTWQvXYuh3Y7zvmxaQwzQgsMudD0a4qJWE0GJOD9g1WGl3tlLj47w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794258732;
	h=Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=81LJPDvx89CoZT4hf8Pu1pH44fBggMLuvFdmRZ6jqX8=;
	b=s3QkJ/G3PL2/ZWMv1wmujoj+FOchZ0jlVp3IPiTPGY2g8AUCwFVZ9U2oOVCnlUWje9lH
	 hgDjOBBMIdo3EDMOqE9jlhfHOfn3oI+ZUl3+kI/ayMyEyKvibCPYBNYe35Hp0Noua2zXt
	 TISEoPnfQYD6Un1BZTfQcYYTo1/0bKDdY/6ib1PwUInmmYNlSj3b/SdRgt01E2z46cc7J
	 ZEk3iAA6H59ckL4TbP3wg33d3JdjVlXnRmmpuua1zjl4jQ+Bs5Yy9f8z443jAPcRsY4Pc
	 xxWWZO2UkcNDIF3CyOIBOtMAlIRawC6lNCD32weAMd5QnejwML38FPuKvj+xC3xmJyg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=AUw7E9Kc;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.136
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E42606A337
	for <acpica-devel@lists.linuxfoundation.org>; Mon,  9 Nov 2026 21:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=AUw7E9Kc
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D6D8660790
	for <acpica-devel@lists.linuxfoundation.org>; Mon,  9 Nov 2026 21:12:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.649
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id l_BaRa2NiiZ8 for <acpica-devel@lists.linuxfoundation.org>;
 Mon,  9 Nov 2026 21:12:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org CC8F76067A
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=198.175.65.15
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794258731;
	b=KqC7YFknNXMrTZ9p8x1ERZ+AmI/UCt1rwlOqhm3WaqoXULErrZE1a4Z1Qnd7EZJCx/dU
	 pyuhgqxU6ctSTSNEelVogHq7pFIym7zBqoLMtK5bgmNeLNboNd0t/X6yXH/HrliT4aZpA
	 JfR6yu33d/tgIs/Fwa+dWRZ+9tqhrrShhyqOrvj+Jt+UFe+qbqIrWyhwslweHDtu89FTS
	 o6Pv3cWSAZs8ejEHkQo/9NTgWj2+ehgz6RcUbmpHRhuLyJiWdJAjOQ3fxWs+Qau/U+WGj
	 wWDy0mkU/Y+Mc/YUovk6k+r+c8YB+nuHvzm9jjCDf1fi9dour99N8SwAjzK2tR+hXnA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794258731;
	h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=81LJPDvx89CoZT4hf8Pu1pH44fBggMLuvFdmRZ6jqX8=;
	b=PmpwC5KCB8I/CWF2tgDflnJ3cCIW3c/cdkUWGy+IJOIxr1clRiH/ULh2fmybYLDYIjJA
	 VKfjU2rYbJZuxRy/1bfQXlllZbvgi+yVvsnAfVdUhXma9DY9w1sFCv2evikLU3cBFQAfP
	 m9ovGExHnP3/Qg9r2Cs56eT339ev9Y9Ag4/0loVesUBjRJhV67HlmmDyc3KlDyM61Ivju
	 dP7d1AxlNYnnNT6mZlBv2Cb8zWqZxK3N+GcGPxHelXz4mus0HdIInbergPSU14cedffkC
	 KFw4Ph4SKDELUa0AbGxobVo1gPA/dKnLxYxWCE5Iba5Il1uWzWHa39maNKtmrfdz3Wg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=AUw7E9Kc;
	arc=none smtp.remote-ip=198.175.65.15
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.15; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=AUw7E9Kc
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	by smtp3.osuosl.org (Postfix) with ESMTPS id CC8F76067A
	for <acpica-devel@lists.linuxfoundation.org>; Mon,  9 Nov 2026 21:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794258731; x=1825794731;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gxYtxO+2eMGpONGrNp4PBU06L5SiPEzU67NeCyIQNk4=;
  b=AUw7E9Kcat7Fsg2JwJzl3pA57IWMAeOzfvRe9Te414Fe+fhqmWEELu88
   XKBNeo16oKYCiqjbyWCu1WgMmCLoKrb0629X68vp1NDm+6MmDwsMilTgK
   a0x+d2Vccp4HzkqqXa4PTQNeML1Yzn4pvghYEaKHcUZg7NSXQdp3eAjv/
   Romd2J0s+BORUftnqnoJlzmyPN0IgWQY+9zTDRDuQUz+K5Gc7wSZgXPNz
   ALlmWNybceAR7ezHB/HPUT1AdzpusKLkxHYVH8nbC7gk4k1/GyED/y9ML
   ZAUNkddklA9i5RlVGdchltBasDbIJIU/Yq86FGq/tCUhqZ8gqbnosdqEw
   g==;
X-CSE-ConnectionGUID: zVAx6bkVSz6go4VtF2uVqw==
X-CSE-MsgGUID: cyHRy9ceQmy5dGiwDL6TUg==
X-IronPort-AV: E=McAfee;i="6800,10657,11961"; a="2992805"
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="2992805"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 13:12:10 -0800
X-CSE-ConnectionGUID: WWEop3DfSBmVu73bsAIzIw==
X-CSE-MsgGUID: uTY2yx17T9id0b+s2yJ5Jw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="8279553"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 09 Nov 2026 13:12:07 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xQWeq-00000000vKd-2HSm;
	Mon, 09 Nov 2026 21:12:04 +0000
Date: Tue, 10 Nov 2026 05:12:02 +0800
From: kernel test robot <lkp@intel.com>
To: "Baorui.Liu" <baorliu@amd.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	acpica-devel@lists.linuxfoundation.org,
	kernel test robot <lkp@intel.com>, "Baorui.Liu" <baorliu@amd.com>
Subject: Re: [PATCH v7] ACPI: button: Report wakeup key only for power button
 wakeups
Message-ID: <202611100542.1xljQv20-lkp@intel.com>
References: <20261109082832.496-1-baorliu@amd.com>
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
In-Reply-To: <20261109082832.496-1-baorliu@amd.com>

Hi Baorui.Liu,

kernel test robot noticed the following build errors:

[auto build test ERROR on ee3b82351a306b559fd132b9b168185fee641a18]

url:    https://github.com/intel-lab-lkp/linux/commits/Baorui-Liu/ACPI-button-Report-wakeup-key-only-for-power-button-wakeups/20261109-162832
base:   ee3b82351a306b559fd132b9b168185fee641a18
patch link:    https://lore.kernel.org/r/20261109082832.496-1-baorliu%40amd.com
patch subject: [PATCH v7] ACPI: button: Report wakeup key only for power button wakeups
config: x86_64-randconfig-1015-20261109 (https://download.01.org/0day-ci/archive/20261110/202611100542.1xljQv20-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261110/202611100542.1xljQv20-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202611100542.1xljQv20-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: drivers/acpi/button.o: in function `acpi_button_resume':
>> drivers/acpi/button.c:568:(.text+0x2384): undefined reference to `acpi_sleep_pwr_btn_wakeup_pending'


vim +568 drivers/acpi/button.c

   544	
   545	static int acpi_button_resume(struct device *dev)
   546	{
   547		struct acpi_button *button = dev_get_drvdata(dev);
   548		struct input_dev *input;
   549		bool report_wakeup = false;
   550	
   551		/*
   552		 * Drain notify work queued while suspended so a late power-button
   553		 * notify still observes suspended == true, sets wakeup_pending, and
   554		 * does not synthesize KEY_POWER for userspace.
   555		 */
   556		acpi_os_wait_events_complete();
   557	
   558		/*
   559		 * Sample and report KEY_WAKEUP before clearing suspended. Otherwise a
   560		 * notify that arrives after sampling but before suspended is cleared
   561		 * can set wakeup_pending and then be dropped without KEY_WAKEUP or
   562		 * KEY_POWER. Clear suspended before wakeup_pending so a new SCI sees
   563		 * suspended == false and takes the normal KEY_POWER path; barrier()
   564		 * keeps that store order.
   565		 */
   566		if (button->type == ACPI_BUTTON_TYPE_POWER) {
   567			report_wakeup = READ_ONCE(button->wakeup_pending) ||
 > 568					acpi_sleep_pwr_btn_wakeup_pending();
   569			if (report_wakeup) {
   570				input = button->input;
   571				input_report_key(input, KEY_WAKEUP, 1);
   572				input_sync(input);
   573				input_report_key(input, KEY_WAKEUP, 0);
   574				input_sync(input);
   575			}
   576		}
   577	
   578		WRITE_ONCE(button->suspended, false);
   579		barrier();
   580		WRITE_ONCE(button->wakeup_pending, false);
   581	
   582		if (button->type == ACPI_BUTTON_TYPE_LID) {
   583			button->last_state = !!acpi_lid_evaluate_state(ACPI_HANDLE(dev));
   584			button->last_time = ktime_get();
   585			acpi_lid_initialize_state(button);
   586		}
   587	
   588		return 0;
   589	}
   590	#endif
   591	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
