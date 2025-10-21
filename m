Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF64342C81
	for <acpica-devel@lists.linux.dev>; Tue, 21 Oct 2025 15:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761059173; cv=none; b=E8j8zh0cf5TP6ej//YKuxtnWyDt4rNN0RcIHYhskSuihZkssJEyPFxuPSzjIht+ZLLhP+9NXv0Il1/ENjW9HMsendsJYctBjaKv6Wf7aCCjjrucSWaiKuTCJGlxePiHBzjXdOViR/v1YqHvxRC7C/YYa/FHokxfJE70+8U8RGlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761059173; c=relaxed/simple;
	bh=XvTwGNFuSfbqy6vW3WT4GVwL8451owX3V6vI14/b4+M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uoUmNKyGOraNktG9JhmulmJ/hHV0Esq17NcsH66+0ipNHjknIoEdvAT2y9R/aZ4NDUa1mDFWNQn6Ved1GTWkCaHEoKsgqm4EKfxNKWWTYU2OmoIHc+qFDKysA0Yqjna2I9DuhQtcUdZcNKK234vLpdvu1pc5e9vLd+hWEeGesf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aYknvFXf; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aYknvFXf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761059173; x=1792595173;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=XvTwGNFuSfbqy6vW3WT4GVwL8451owX3V6vI14/b4+M=;
  b=aYknvFXf3KxFpfpYo5p/QXXge8C+31gS7jsGXW/0Rh6Od7mSyD043Tvk
   uZ/NgqNVJw9zZPhbB35Aws4t3kyY/dOl4tCvh9hg9o8OznH8tCowieG5X
   X8pOaQLHjF6F40qqWtAemuR/h52XwmMcN+7LvmcqMyLbb5bFhd9/nE41H
   gmpmVbME+4rmu78EbKIe8NV9LRk6OV1LWEs2IPzIjgRKY+zrjiRiOAsZl
   8NG2onoAiNq5VihSSKX8s4jF2bKrXY/hfptyFSHy6tvSCApdkF6ZhuMlD
   V4WxPKL102VoXsD+5Pil/Mu3/VquiK+HZARFOESimmBG05h+KhZbqk9AK
   A==;
X-CSE-ConnectionGUID: oSjE1JheQPaF1WukL37dLg==
X-CSE-MsgGUID: oVdzXggHQ/2DhRqDG7SUKw==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="67023215"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="67023215"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2025 08:06:12 -0700
X-CSE-ConnectionGUID: hPdaPEAhRSSL3lr8QNk2Bw==
X-CSE-MsgGUID: 5dPLaha8S0Obp9mkoJFipA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,245,1754982000"; 
   d="scan'208";a="188016523"
Received: from schen9-mobl4.amr.corp.intel.com (HELO [10.125.108.169]) ([10.125.108.169])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2025 08:06:10 -0700
Message-ID: <2ee6c734-7a6e-4888-b00f-17de1c0f5e5a@intel.com>
Date: Tue, 21 Oct 2025 08:06:09 -0700
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] acpi,srat: Fix incorrect device handle check for
 Generic Initiator
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Shuai Xue <xueshuai@linux.alibaba.com>
Cc: lenb@kernel.org, robert.moore@intel.com, andrew@kernel.org,
 bfaccini@nvidia.com, eahariha@linux.microsoft.com, dan.j.williams@intel.com,
 thorsten.blum@linux.dev, gourry@gourry.net,
 nunodasneves@linux.microsoft.com, wangyuquan1236@phytium.com.cn,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 acpica-devel@lists.linux.dev,
 "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
References: <20250913023224.39281-1-xueshuai@linux.alibaba.com>
 <20250915093549.00006109@huawei.com>
 <45d5e6a9-d561-4df9-96d4-285f2ca12888@linux.alibaba.com>
 <CAJZ5v0grihVDor12BXU3-tAiQ5WH6rK+AZK8aTtaUa3cq1i0jA@mail.gmail.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <CAJZ5v0grihVDor12BXU3-tAiQ5WH6rK+AZK8aTtaUa3cq1i0jA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 10/21/25 6:30 AM, Rafael J. Wysocki wrote:
> On Tue, Oct 21, 2025 at 8:55 AM Shuai Xue <xueshuai@linux.alibaba.com> wrote:
>>
>>
>>
>> 在 2025/9/15 16:35, Jonathan Cameron 写道:
>>> On Sat, 13 Sep 2025 10:32:24 +0800
>>> Shuai Xue <xueshuai@linux.alibaba.com> wrote:
>>>
>>>> The Generic Initiator Affinity Structure in SRAT table uses device
>>>> handle type field to indicate the device type. According to ACPI
>>>> specification, the device handle type value of 1 represents PCI device,
>>>> not 0.
>>>>
>>>> Fixes: 894c26a1c274 ("ACPI: Support Generic Initiator only domains")
>>>> Reported-by: Wu Zongyong <wuzongyong@linux.alibaba.com>
>>>> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
>>>
>>> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
>>>
>>> Thanks!
>>>
>>>> ---
>>>> changes since v1: drop changes in actbl3.h to make it easy to progress per Jonathan
>>>> ---
>>
>>
>> Hi, Rafael,
>>
>> Gentle ping.
>>
>> Are you happy to pick this bugfix up in this cycle?
> 
> drives/acpi/numa/ is maintained by Dave.

Applied to cxl/fixes
7c3643f204edf1

