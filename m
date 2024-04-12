Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F4B134CC
	for <acpica-devel@lists.linux.dev>; Fri, 12 Apr 2024 02:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712889704; cv=none; b=vBna7zcTRp+YcKTIEzAvfdXbriZVVkcthK65KYhF7tTHhFi88SVKXmjW46NAsg53+2HaTIhRkQgEQXQTVej5ajms77cAM5C0Ss3u0aCM8ADp4PJqMQpJrU5OrAzK7eKRmjFo4XHYcAapDNCUnHbs0W8GA8WZCEKEmCnZyzspRQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712889704; c=relaxed/simple;
	bh=kPTWyd27qtpz0j7CiJ8MLUsJpEDcMvRcWprNNYOooUM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gQnZIAJ2R0mcUv5RuJ0mOfgx06b9jGQLCHB6n/P+HhKd1ZYRAR2rOOvE/eV+zb6LJlzvSx1KT39zu0wIA8Ty4yOE5lWoXfS0gsM2/dRRgO5CP3qXwtPEuAuXID2lJkBnxsLRJverIn59NnM10a0bv75xxmQPp46JJsat8fVrhZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=BDohIcd+; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="BDohIcd+"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1712889693; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=YjwBFUKfQzATV8MN0CZKmv5/RE4aS2y4MQlXc0URcto=;
	b=BDohIcd+BA1HWdfhgGDJAB4OvcRuI7Bm+8EGF0jJ3kxgDTZWRqtV6H2voAk90PRsZaJRHLsQBXgdXFba11+Jeb5m1zR7jdryVSmgFdvcwkMqcwSvhFHJm0fn6atpRyOQwowrId6DC/kycD9UfLkhihsPa7Gr66MuuRwohPm0bVU=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=tianruidong@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0W4MgPBj_1712889692;
Received: from 30.221.130.139(mailfrom:tianruidong@linux.alibaba.com fp:SMTPD_---0W4MgPBj_1712889692)
          by smtp.aliyun-inc.com;
          Fri, 12 Apr 2024 10:41:32 +0800
Message-ID: <8ff4deab-13ab-4fdf-b418-fbfefe46c087@linux.alibaba.com>
Date: Fri, 12 Apr 2024 10:41:31 +0800
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
 <e3c91a7b-4bcc-45ce-92e6-c6a50ad80479@linux.alibaba.com>
 <Zhep-UCqqPlg9BIh@bogus>
Content-Language: en-US
From: Ruidong Tian <tianruidong@linux.alibaba.com>
In-Reply-To: <Zhep-UCqqPlg9BIh@bogus>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/4/11 17:14, Sudeep Holla 写道:
> On Thu, Apr 11, 2024 at 03:54:48PM +0800, Ruidong Tian wrote:
>>
>>
>> 在 2024/4/10 17:22, Sudeep Holla 写道:
>>> On Wed, Apr 10, 2024 at 02:36:00PM +0800, Ruidong Tian wrote:
>>>> AEST V2 was published[1], add V2 support based on AEST V1.
>>>>
>>>
>>> Any changes to ACPICA has to get merged in the external ACPICA project.
>>> Refer [1] for details from Rafael. You can also refer [2] in the kernel
>>> docs.
>>>
>>
>> Patch1 is just a fix to follow kernel code style.
> 
> IIUC such changes are not allowed as ACPICA changes are always imported
> from the external project. So you have to take same route as patch2

In ACPICA, all struct use typedef which is not allowed in kernel:

     It's a **mistake** to use typedef for structures and pointers[1].

I see all other structs in actbl2.h follow this rule, so I fix all 
typedef in AEST struct to follow kernel code style. But i can not apple 
this fix in ACPICA. Patch1 is just a kernel patch.

[1]: Documentation/process/coding-style.rst

> 1
>> Patch2 had merged to
>> acpica project, PR link can be see in patch2 comment:
>>
>>    Link: https://github.com/acpica/acpica/commit/ebb4979
> 
> Thanks, this will then get imported into kernel next time ACPICA changes
> get merged which usually happens regularly.
> 
