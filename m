Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5FF83AA4F1
	for <acpica-devel@lists.linux.dev>; Thu, 30 Apr 2026 10:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777543250; cv=none; b=ncpw+d9DYs73mIJxhOxE15o0c0Xg0vwAgT+CVxHeGT2Hkc/yHstOK/CkYJu2Ld1DOxo5TYORyfIKzqvCMR+lI04xLQyRXO0VjaiphyIUF5ep27dtRXPKRMvfBac/c5LN82rA47ukMSuXkXo1tQNOtto3ZvF62h81EgbkZVpRzNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777543250; c=relaxed/simple;
	bh=cG5mm5L1DMdDHae99z2sjBPEaKaBSG9Y2UhpIA83xPQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=cSn6veOMT0QFmAgFZcgy48aRZaUrrfhkWR+aKVp1WLo7/ErsZo9SR7YmvOU97sGL6QT//Y4Ok/CN3gP846apkJlPT3qfbLQ4YusP0TLpy6hbZ5yKM2brD7trDSI2rNfQiGohmDhGG5Tjvi07uQfnszHgN9EGRTAQgFYM+OBcHwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=5DhB24bF; arc=none smtp.client-ip=113.46.200.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="5DhB24bF"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=WwwpkRJwkZezUuyadC6pFLx+PVDNGEiT19B/YITflFU=;
	b=5DhB24bFvvGN0JfZCRxg/8DOOEZLKWNzogjjgdaQa8VOk03uLUKMMos83Kajwjd4ZU5THwYtA
	uyddoWHhasNOgtD+WczcsMc4G8ZfTnA8lDL7yaRL+u7hXJuYriJVl1f2MVvBug/e4KVITObXavG
	7eEvBZ5yz0zJyoXGMkiQHyo=
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4g5qJR6Tmrz1prLm;
	Thu, 30 Apr 2026 17:54:15 +0800 (CST)
Received: from kwepemr200004.china.huawei.com (unknown [7.202.195.241])
	by mail.maildlp.com (Postfix) with ESMTPS id 27C3140561;
	Thu, 30 Apr 2026 18:00:46 +0800 (CST)
Received: from [10.67.121.62] (10.67.121.62) by kwepemr200004.china.huawei.com
 (7.202.195.241) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 30 Apr
 2026 18:00:45 +0800
Message-ID: <aa1284c1-ea26-48ca-a7d7-022027c8228a@huawei.com>
Date: Thu, 30 Apr 2026 18:00:44 +0800
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] CPPC: reduce FFH feedback-counter sampling skew on
 arm64
To: <catalin.marinas@arm.com>, <will@kernel.org>, <rafael@kernel.org>,
	<lenb@kernel.org>, <robert.moore@intel.com>, <beata.michalska@arm.com>,
	<zhenglifeng1@huawei.com>, <zhanjie9@hisilicon.com>, <sumitg@nvidia.com>,
	<cuiyunhui@bytedance.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <acpica-devel@lists.linux.dev>,
	<linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<prime.zeng@hisilicon.com>, <wanghuiqiang@huawei.com>, <xuwei5@huawei.com>,
	<lihuisong@huawei.com>, <yubowen8@huawei.com>, <wangzhi12@huawei.com>
References: <20260410094145.4132082-1-zhangpengjie2@huawei.com>
From: "zhangpengjie (A)" <zhangpengjie2@huawei.com>
In-Reply-To: <20260410094145.4132082-1-zhangpengjie2@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemr200004.china.huawei.com (7.202.195.241)

Hi all,

Gentle ping on this thread. It has been a while since I posted it.

Could someone please take a look when you have time? If there is anything
I should revise or any additional information needed, I'd be happy to
update it.

Thanks!

On 4/10/2026 5:41 PM, Pengjie Zhang wrote:
> The legacy CPPC feedback-counter path reads the delivered and reference
> performance counters separately.
>
> On arm64 systems using AMU-backed CPPC FFH counters, each FFH read is
> served through a cross-CPU counter read helper. Reading the counters
> separately therefore widens the sampling window between them and can
> skew the delivered/reference ratio used by cpuinfo_cur_freq. Under heavy
> load, the skew is observable as transient values that may exceed the
> platform maximum, as discussed in [1] and [2].
>
> This series adds a small generic hook for architectures that can obtain
> both FFH feedback counters in one operation, while preserving the
> existing per-register read path as the fallback.
>
> Patch 1 adds the generic CPPC hook and uses it from cppc_get_perf_ctrs().
> Patch 2 implements the hook on arm64 by sampling both AMU counters in a
> single operation on the target CPU.
>
> [1] https://lore.kernel.org/all/20231025093847.3740104-4-zengheng4@huawei.com/
> [2] https://lore.kernel.org/all/20231212072617.14756-1-lihuisong@huawei.com/
>
> Signed-off-by: Pengjie Zhang <zhangpengjie2@huawei.com>
>
> Pengjie Zhang (2):
>    ACPI: CPPC: add paired FFH feedback-counter read hook
>    arm64: topology: read CPPC FFH feedback counters in one operation
>
>   arch/arm64/kernel/topology.c | 75 ++++++++++++++++++++++++++++++++----
>   drivers/acpi/cppc_acpi.c     | 58 +++++++++++++++++++++++++---
>   include/acpi/cppc_acpi.h     |  7 ++++
>   3 files changed, 127 insertions(+), 13 deletions(-)
>
