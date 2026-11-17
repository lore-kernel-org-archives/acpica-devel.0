Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794941858;
	b=Xla5xdAXkKXZQt6h/zhgAvRmKDmRq9davfjtqks2SS7uEfqK56cOUAU3fh4n66Yl9BlN
	 ub94d53sN9QXlDo5mSTKNkrQUJhbZMVnFXB9kTVUL7+jV2KqgWZug+dJ2Fp74wZVNk9vf
	 8ukWCfvkpVdDLhAqhvm/pTjpV3EPwA8IDOXR13Rv6y5vE2fPLMAfnfIRX0BHTQiTKi4iL
	 h52UrA010zrNe+W1K1VXcuBPgPgkAqOwByQl65a9TPprdCZJLCi8wojqTTvK7l2hFomnp
	 9yllMH30NemuAh3g5ScsGPSpSGg4tqNxLvO/20xRL5TBPEpuaGowsfCP1fYwij1hyEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794941858;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=HdkDes0ncCU4WGhgyR7YXxDGwX38qel+esSZ7Ve7TMg=;
	b=uTMb7+YlzqYh6zZ0v9XgMZLPs/1DqEFzZLP/9zDT/06/4UecqUDUcBzxVOhwBmwq99ag
	 3rDCfJ9qA2NuDPpNER8fgXGY+3YeOK0HUhFX0idYJJGzBG2tUfbYq6MgCMYu66EM7P078
	 XIYj6R2VJsHNMefJuXdF/ui1uH6WBjtxBvzO0t6a/gx9W4GLsfXrA+g56SwpeSro932Ws
	 TO3OrjdxJkbsIK8AyXHK/luDYsjs5rA2gfqCjnaFbchw/36e1NbWX7b/M78aGB87nC5eK
	 IATW/6aJTgI/V9UYVvYfbI1LYgvHMcplAs4Z3u/0VGWa9JFv6+sfpxlUk0ahyoBSDYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=klSK5K0f;
	arc=none smtp.remote-ip=192.198.163.18
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C65606A32C
	for <acpica-devel@lists.linux.dev>; Tue, 17 Nov 2026 18:57:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 92C65606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=klSK5K0f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794941857; x=1826477857;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=v1NsJvl2MeAn+U0ELjw0P121EwhLfFQaHMoHS8YBAvw=;
  b=klSK5K0f0e3+1quJ7DkyIFQuOFiFpnnIy6p0e27w4zes6se1eYYIj1g/
   7HdWUdl9/xggNSP3k2OM/8sSsdUPRZSluyFqh10kQS1wzjotVTS1C58Kg
   YV64PwdvW3btFMNeCsNmcOaH467m8nt4zxHNLd4PExb43NCVoW6JQ+8cc
   Z9CpIeyBhE/hIOUeS5eNZfEFVXpeXJ0oeP/XzsQgUu6lujc6ykOdiCdlB
   eIZ2UmSbx5C4BPEaU0NXKV616bplFNi3xEvv+u877gdZRuYjEfZpyV+n+
   EC1UfN2y549bMcOL9r72QYr+C5Zyh/O+JnOZvIziXahK0kdl9DTYGwRlj
   A==;
X-CSE-ConnectionGUID: rgkKr9z+TsqDtkwwTAyUrA==
X-CSE-MsgGUID: Te3L75txRNqaX1xpz6DGng==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3753803"
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="3753803"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 10:57:34 -0800
X-CSE-ConnectionGUID: DPWAMEErR3Kxtj4lkE/CAw==
X-CSE-MsgGUID: y3FAroW/Sx6yGrYcfClEAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="11733291"
Received: from skuppusw-desk1.jf.intel.com (HELO [10.24.80.125]) ([10.24.80.125])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 10:57:34 -0800
Message-ID: <28da8229-99f9-47c7-b2d6-d301ae34253f@linux.intel.com>
Date: Tue, 17 Nov 2026 10:57:33 -0800
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Post: <mailto:acpica-devel@lists.linux.dev>
List-Help: <mailto:acpica-devel+help@lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:acpica-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 19/19] PCI/ERR: Avoid NULL bridge pointer
To: Lukas Wunner <lukas@wunner.de>, Pierre Gondois <pierre.gondois@arm.com>
Cc: linux-kernel@vger.kernel.org, Ashok Raj <ashok.raj@oss.qualcomm.com>,
 James Morse <james.morse@arm.com>, Mark Brown <broonie@kernel.org>,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Tony Luck <tony.luck@intel.com>, Hanjun Guo <guohanjun@huawei.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Shuai Xue <xueshuai@linux.alibaba.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Oliver O'Halloran <oohall@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
 Pawel Chmielewski <pawel.chmielewski@intel.com>,
 Yazen Ghannam <yazen.ghannam@amd.com>, Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
 Avadhut Naik <avadhut.naik@amd.com>, Radu Rendec <radu@rendec.net>,
 Jonathan Cameron <jic23@kernel.org>, Dave Jiang <dave.jiang@intel.com>,
 Kai-Heng Feng <kaihengf@nvidia.com>,
 "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
 Breno Leitao <leitao@debian.org>, Terry Bowman <terry.bowman@amd.com>,
 linux-acpi@vger.kernel.org, linux-edac@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
 acpica-devel@lists.linux.dev
References: <20261117111444.4185512-1-pierre.gondois@arm.com>
 <20261117111444.4185512-20-pierre.gondois@arm.com>
 <avw_daENKPcY7_04@wunner.de>
Content-Language: en-US
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <avw_daENKPcY7_04@wunner.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/17/26 03:50, Lukas Wunner wrote:
> On Tue, Nov 17, 2026 at 12:10:29PM +0100, Pierre Gondois wrote:
>> Return PCI_ERS_RESULT_DISCONNECT when no upstream bridge is available,
>> avoiding a NULL pointer dereference in pci_walk_bridge().
> 
> How can that happen?  If it can happen (which I doubt), why isn't this
> patch tagged for stable?

One way I can see is a device without a PCIe capability on a root bus.
pci_pcie_type() returns 0, which is PCI_EXP_TYPE_ENDPOINT, and
pci_upstream_bridge() returns NULL. Native AER never gets there. Only
firmware-first can, through aer_recover_work_func(), and only if
firmware reports a PCIe error section for such a device. If that is
the case, skipping recovery for !pci_is_pcie(pdev) in
aer_recover_work_func() seems a better fit than a check in
pcie_do_recovery().

> 
> Why is it at the end of this series?  Does the series somehow make it
> possible that there's no upstream bridge?  Which patch does that?
> If the preceding patches are not the cause of a potential NULL
> pointer deref, why isn't this patch submitted separately from the series?
> 
> Thanks,
> 
> Lukas

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer

