Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1968B1D61AA
	for <acpica-devel@lists.linux.dev>; Sun,  3 Aug 2025 16:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754240082; cv=none; b=mKgc43wshoFuHgLtvm7b4XLfCHmoAnUEZLYomOHk/oq6I01BZ9ii94RwbTTT6fybCBfjUMmxBNi+jeZGfuDm1ZL2Uiu5ZKPdxcxXgqStcANxk0Phm2WRfEJDM/uctrxE0tfuwc/zL4jzeBQKkgmdgsctHSMS4I3MjkI33CHw/HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754240082; c=relaxed/simple;
	bh=013LWtY1z9ycHf9/jlJK5Gk4unBMj8NZDKNYsGQFV9Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h6RJtmumOh0tchoMB7av84LAGbkeMDNFzkUrVuV2GybQNdJUiaZYB77mt1JgpHIX/a6fttJpU0ShvgU5vAlzvqmR/LvICZDT3nplH1c5S1vhcbguPhdPqE+g1BCq/+F5v4fCYo878wwcHEoa7ScRIudNh15FB4T83EsnHH6NyK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GAxPBX5z; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GAxPBX5z"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-76b36e6b9ddso2937420b3a.1
        for <acpica-devel@lists.linux.dev>; Sun, 03 Aug 2025 09:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754240080; x=1754844880; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pV9w0CQoRcUYhHYMt23UhoOkZT5o/JoD/yUyCBLIk2k=;
        b=GAxPBX5zO43I3hU895pfIAxj3+jIugc6jnjCkWPzrEt1mbgPQV/CCBtVvtQuA7CIQZ
         V5lpqlMFUR2531JuAr25nG6A2vg9bET4/ha0ZIDO6VL0RdnJyLB1uMA6u1Wt1nHcaojZ
         tLE2uA0NbkbUI979xO7nxJV/UTswhpeWOsDppnIS7Incr78H3MQIhtemQP61ZRAHgsRI
         x2EkREVEEtYYwCbGr3Ol+QQBYNkFoawnJa2rUPzBVi+5wYkcUIuffbpf7wx54avdCZ7y
         OfroP0JRl8pHBnbn3FWIoPkVvg3NyzTqrzl/dMBGZXGz9RIEBNSd0KSqeo629Pq/bUot
         J1jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754240080; x=1754844880;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pV9w0CQoRcUYhHYMt23UhoOkZT5o/JoD/yUyCBLIk2k=;
        b=CgI4ChNM+eeId4aENhrvw37VJneTTyVb6+i3ZzS5SLAuabGociK9Y8baBEAt9JThTV
         6XCiU4IxPENg9dG7pkuIQ3ZAdxJ1KrmsP3BhsojJ73tHu/dTpkgG1cg7jYksEti+7xJA
         10AyVTxEEs9CKmh+hgeyjsP7pvr/Q4Vo3AnIfW2NBRSan9tsAt3lelVu9CrCABiaO9Ri
         EA+a3BQ6ux6qlQ5yInLHTVQp9FxEg8Ojt2LkLODAQrI2yzOFHWsPCuBciODHYU8LmH67
         IDe+piGhx7f2j4IGMGUxYOHwG4L7qc6Wp40CalFP9BP3N9gshsbdrvwERiuWZM6A8r+N
         JYNw==
X-Forwarded-Encrypted: i=1; AJvYcCVc4Jqw0o4lUEQedRAU/VNIAtZLwnoUUsJv4gy5NJvJ7qLskx/vfw9H0GDFcKObvhZ9O1/Trc+M2+xYJKQ=@lists.linux.dev
X-Gm-Message-State: AOJu0Yz6YkPd7gcs76yYefl3ctYmSJQCaiuQibNOfd9i4f2s1HTgo9wt
	F4Ljsk0jHLNWsYei/oIyvOPyC9HbiBytgtBUekXQoVsXs2d5egN73fU8
X-Gm-Gg: ASbGncsK1JVnSvFivIVvshtZfLMXzDx9cZ+lvAwhNjyZEWe1byMtdJVqnI3S3/5UTWN
	uLyqLgzUGCyyecOovTBtviF5jFhHWm87ZWZoqtbdKPcpKhHrs2e4ZGSEj7cv4ZOtt9WLaWVOECO
	Ub7lZk3IPqto6SHZC/k8UWoliEzmxnqpT9/rQRZnqevYcX8EODf4DeHkuFgq0RptKZxNj6doh92
	uD3PpRx0aVJYSpllgLxiSZKa2waXN/NGxyPO2Dfxp1GYOexKeza+QfeCNhvnnSlmsegNiY4UbC0
	QZFlzwxY39CbwSX4bSehcSuS12H0yabwgaOqe6gJ/b5UvjeTWh5u9dN4OOHAdLh2TwVYZfFMYSV
	ZQoUtxmfVsScNM04=
X-Google-Smtp-Source: AGHT+IEo1gq33O5aUys0+8ALaihfteRTIBvMO85xRSUFfSJcipaf9qogGiVbnN9HwPKG58PZb99ALw==
X-Received: by 2002:a05:6a20:734e:b0:238:3f54:78f2 with SMTP id adf61e73a8af0-23df91932cfmr10086332637.44.1754240080330;
        Sun, 03 Aug 2025 09:54:40 -0700 (PDT)
Received: from [192.168.79.25] ([49.207.53.32])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b422b7841besm7475766a12.3.2025.08.03.09.54.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Aug 2025 09:54:40 -0700 (PDT)
Message-ID: <b30ef694-56c2-4023-8d6e-de8f7b8e10e6@gmail.com>
Date: Sun, 3 Aug 2025 22:24:34 +0530
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] acpi: remove unnecessary parenthesis from return
 statement
To: Markus Elfring <Markus.Elfring@web.de>,
 Diksha Kumari <dkdevgan@outlook.com>, linux-acpi@vger.kernel.org,
 acpica-devel@lists.linux.dev
Cc: LKML <linux-kernel@vger.kernel.org>, Len Brown <lenb@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Robert Moore <robert.moore@intel.com>
References: <20250803153829.6545-1-dikshakdevgan@gmail.com>
 <a62ff710-4216-4c4a-9ca1-b376a3703531@web.de>
Content-Language: en-US
From: Diksha Kumari <dikshakdevgan@gmail.com>
In-Reply-To: <a62ff710-4216-4c4a-9ca1-b376a3703531@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 03/08/25 21:38, Markus Elfring wrote:
>> checkpatch.pl is generating a warning when return value is enclosed
>> in parenthesis. Remove the parenthesis to improve code readability.
>                               parentheses?
This is my first patch, so i am not sure what you mean by this.
>
> You propose to omit also some curly brackets, don't you?
ok, i will include this in the next version.
>
> …> ---
>>   drivers/acpi/acpica/dbconvert.c | 43 +++++++++++++++------------------
> …
>
> Did you overlook the addition of patch version descriptions?
> https://lore.kernel.org/all/?q=%22This+looks+like+a+new+version+of+a+previously+submitted+patch%22
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.16#n310

yes, went through the document, thanks for the information. I will add 
the change log in next version.


Thanks for reviewing the patch and feedback.

Regards,

Diksha

> Regards,
> Markus
