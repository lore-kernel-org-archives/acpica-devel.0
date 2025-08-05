Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505BD2566E9
	for <acpica-devel@lists.linux.dev>; Tue,  5 Aug 2025 16:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754411269; cv=none; b=ebDx1aDDOJrEo8W21z+peKmpXicRCyM39Raky40cYkkGab2PVMzGOP3zcTuwB693kufgh8f5Dxi5bVSmUuQwkRX6t8ICKxHmuxrhx6C7YCt/irVY5Ad/e7F1hzh38snBz3sxgoiWPVWSYYD3/EY5s0ZV53MC1QKM4pk/U2m9XoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754411269; c=relaxed/simple;
	bh=5BJyQyJpgV+yQh2Ditn8oy8a04n9ISc9q8hHHgTLqBU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KxcgI26KbH86DT62jSjVOBRObHDGtj394/UbH4GSrBdGRpopqQEquYZx+lefyHnhCCyBMSfn+ss3segzSXLVTn6hs9UAL7gFuNITnmRwq02viWnLtKLqqEPZl87b/fhtdYbxKkXkVmFbSt4TLGwinB2EZ4hSRohUkAzlRZzmTpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F8gDg5Pi; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F8gDg5Pi"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-24031a3e05cso374115ad.1
        for <acpica-devel@lists.linux.dev>; Tue, 05 Aug 2025 09:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754411267; x=1755016067; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+3O50zNUML0rXrgIz2L4u9X6MchbPe/SOppfxHs5UVY=;
        b=F8gDg5PiPQA78vzIogu68++cpJs5w/PZw4rTvMyaO3Ri1SLccontc830kHbcYgxgu0
         sN4egSLPGhvRApJvJYUIi5DUgAn8CynuKhvdQFMNhYmT9pUC5ZqMYFMR3Qi42xWNuJrA
         3o/b1WTEBGee1oNiEQP13HQjNrLU1JbQUTZHyAj+IwNdkKXGFs+h9aHOtYVyQsa2wWJ4
         f8q3vFEHY2OEpiytg+DtCdKijpF525hp+WN9BA1L2esYqpUJ8rFttI0/hYsmOwNrcsf1
         LUA145Bg9iQ7VkcPdl4fR8NA4dl/SnfYjfHrcRAksQtEeXhLtupjDCqM6M2HXxlmQAfl
         JV+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754411267; x=1755016067;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+3O50zNUML0rXrgIz2L4u9X6MchbPe/SOppfxHs5UVY=;
        b=cLehpF/UVNtcEXtqb9pLbG+Wg1sTief0V23BsCgSN047WUTf41HxK83WDQI7uqXSZa
         txtsj5a4bRqD/176wjioRLLPwTDQ10JL+6ZppmM9CzBugln2RUmpxKh1ywZGjNTm6WVO
         +AfPxf8ZZfyEnquxVOwUcJcfpSZDKtlbqgfR1qiNzQDGBZqVDm5ZPT0xfdwS+r4wr2LU
         2r7QxFK2HA5y/G21W8wxNPrPgJFwK4b4rThRRnMuMYiOZkBYlwTfQKVih8qzmuvtZPA3
         Vcymg9izl2qgKqxBXc063EgfrOUbU9MOa8jjDx7od1mAUis4RWcolP9hQ5bGuWlKUJmt
         ++Vg==
X-Forwarded-Encrypted: i=1; AJvYcCWAeNMbU0ywb90Wfki3ws1r484RfViFQhG+dYRrkGsIrbpNZe4sfDvLvGi5zQar2HffV8NGRL4N2r0Pffo=@lists.linux.dev
X-Gm-Message-State: AOJu0Yxl9PSGhJaopZLypJiLjhd+h9G8LNw/XuElO24yp83mTtX5phD6
	hD1P4xxCXrbbNDWupSJQak9MEc53c2/QZO3+GBz1y1KCQ5m4g8r/tIy2
X-Gm-Gg: ASbGncu1XelixMIl71V/K9aA5Zv5TfKu7OGdJaQlikNHkh5usYcWSW5If2NZIUI9jY1
	B6qLvVYBCbblldUyd4TwgQ1qz1QSfADY1Kj9RxmnhqiXT1xivSXVmiysBQbU/tMcjr+gsLj+Rei
	JMjRETMLyb92wOnxL9DVBWL1oYNxDVipNRrcRsRqIVUxJfYDlE3KDYmGP4yd1Ow566vNri5T8jQ
	wLLb7vstTLHiC1gav2FkozxE7KCN7f4AleM+z3GGnxPTNLgr1RyNoLANAnWKPPWzpgNdQRsHlh1
	LfAmYglooBGDt5T0jLHzJ+JB4vqFziH8pvS7zUGSwh13Vd8SDqDUb3qXRU9Ho6cDpa9KFZqYx/x
	JFMXLmAhySQ8i9lj6sfoBYU68q9iCVu7eE+2Hq7fRUinQyYgDo/wHUmBtLUxzClVtOa6JCNlQd+
	2r
X-Google-Smtp-Source: AGHT+IHd19vjUFBW1J+x03NMEuyJK581n036vQ9x7nKm3KkZ/4nVoUzKV04IA+ulDj2XieVTIyuOvA==
X-Received: by 2002:a17:902:d508:b0:215:b1e3:c051 with SMTP id d9443c01a7336-24288d2ef67mr49304575ad.11.1754411267413;
        Tue, 05 Aug 2025 09:27:47 -0700 (PDT)
Received: from ?IPV6:2401:4900:1f27:8800:d28b:e1ed:c83b:1281? ([2401:4900:1f27:8800:d28b:e1ed:c83b:1281])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1f0f7bfsm137074095ad.41.2025.08.05.09.27.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Aug 2025 09:27:47 -0700 (PDT)
Message-ID: <4dc74bbe-da7b-4f40-a5e4-130ef20dbaa8@gmail.com>
Date: Tue, 5 Aug 2025 21:57:42 +0530
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3] acpi: remove unnecessary return parentheses and
 conditional braces
To: Markus Elfring <Markus.Elfring@web.de>, linux-acpi@vger.kernel.org,
 acpica-devel@lists.linux.dev
Cc: LKML <linux-kernel@vger.kernel.org>, Len Brown <lenb@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Robert Moore <robert.moore@intel.com>
References: <20250804185826.29723-1-dikshakdevgan@gmail.com>
 <927e03af-6682-44c5-9225-fb269b0a6e1c@web.de>
Content-Language: en-US
From: Diksha Kumari <dikshakdevgan@gmail.com>
In-Reply-To: <927e03af-6682-44c5-9225-fb269b0a6e1c@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 05/08/25 01:54, Markus Elfring wrote:
>> This patch removes …
> See also:
>
> * https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.16#n94
>
> * https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.16#n658
>
ok, i will do the changes in the next revision.
> …
>
>> These changes address checkpatch.pl warnings and improve code readability.
>>
>> v3:
>> - Updated commit message
> …> ---
>>   drivers/acpi/acpica/dbconvert.c | 43 +++++++++++++++------------------
> …
>
> Please move your patch version descriptions behind the marker line.
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.16#n784

ok, will do the changes in the next revision.


Thanks again for the feedback.

Regards,

Diksha

> Regards,
> Markus
