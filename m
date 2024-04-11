Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86E713DDD4
	for <acpica-devel@lists.linux.dev>; Thu, 11 Apr 2024 07:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712822094; cv=none; b=fkBFruzYjTyJruwuME3RNNnh+npc9xufcizU8DdiY/lV+C7hvA23z8Drdqvnwi5YtI0rE7boo0485UQfew9w2HmvLwyA8gaiqcFKF05O6L0DldFNgR6++5zT+ed0Qzczc/ON75YZ0vKO6lK8BsJ2Ga3L7mmoo12to9dx0MGWyJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712822094; c=relaxed/simple;
	bh=3GwJ6a+xt5MhjVTAyBxA2Hie1entEBVCmWRnbxhmUP0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ePe6rlAsGokb6/lkyK63GiucMWIo6gepuUi0c58/wfSfN5/UvvO5hznontP4RyTh+D/sohHOAusto0Eb/MTuuY4mIkIFo89hWNB0Qind8hTQX6V78PTBytDA8jlSiPMn8eOHlBuODrHthKzZM11jOJDCtfB8eGDvlZUrS4WJ7ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=gk3CmgQN; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="gk3CmgQN"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1712822089; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=pQMBTYNynPA02Lriyi43s4JReicQAXRUl8F3FYNB6Rg=;
	b=gk3CmgQNvVjiEGhNoozoG0wzkWvtmqcNPsM7N9J2iXEotJRUAOXKO0xI31uYgrq8i/aR3p5mdNUM92Uja4OPjdqAd3S7WFatzkwZOAPzq+xuJj1bmeZBZpmXC7VxdkQzrMEV+U2i667MPqOCVxO+XhLXccKp3Gj0lJbnw+ngycA=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R821e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=tianruidong@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0W4KbUe6_1712822088;
Received: from 30.221.130.77(mailfrom:tianruidong@linux.alibaba.com fp:SMTPD_---0W4KbUe6_1712822088)
          by smtp.aliyun-inc.com;
          Thu, 11 Apr 2024 15:54:49 +0800
Message-ID: <e3c91a7b-4bcc-45ce-92e6-c6a50ad80479@linux.alibaba.com>
Date: Thu, 11 Apr 2024 15:54:48 +0800
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] ACPICA: AEST: Support AEST V2
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: robert.moore@intel.com, rafael.j.wysocki@intel.com, lenb@kernel.org,
 linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20240410063602.41540-1-tianruidong@linux.alibaba.com>
 <ZhZacAOVpAXK8lDE@bogus>
Content-Language: en-US
From: Ruidong Tian <tianruidong@linux.alibaba.com>
In-Reply-To: <ZhZacAOVpAXK8lDE@bogus>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/4/10 17:22, Sudeep Holla 写道:
> On Wed, Apr 10, 2024 at 02:36:00PM +0800, Ruidong Tian wrote:
>> AEST V2 was published[1], add V2 support based on AEST V1.
>>
> 
> Any changes to ACPICA has to get merged in the external ACPICA project.
> Refer [1] for details from Rafael. You can also refer [2] in the kernel
> docs.
> 

Patch1 is just a fix to follow kernel code style. Patch2 had merged to 
acpica project, PR link can be see in patch2 comment:

   Link: https://github.com/acpica/acpica/commit/ebb4979
