Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1852AD25
	for <acpica-devel@lists.linux.dev>; Sun,  3 Aug 2025 15:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754234343; cv=none; b=gfGz5+0gQ29yukI4e7o4Wye+RFyq3OXmreAYQrIDecvy5jYS0xXmxH+SdC4/BtMOJQhwFyfdNJHlFLMM1DV3sHNOuFbXIrJGDecq4keHJqI5l1RHbbDUpkgIa/liJk82r0vUb42ytxEik4NyhU3QNVJPucIJt2lL59txDkTw9B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754234343; c=relaxed/simple;
	bh=d3H2Jph/g4WDb6GqjR/EPGGTLoQy6mxK0lPyvJAmrM0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=appkktG7oyC+31+BYpvnWNOqziAybBNPo0rld9eEU0hjAGoEGpvFsr4hKiiqKzN+4rocckA6fpoYXeV5/v0/p42kBpnE5dfGjlrfyV8rUg8Tw8A+UQwod7sdmK2ELqDOjhaZoATic+sXozt15PCPo10J+PNliq1JF1qZ7I8HoVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ML0HutL8; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ML0HutL8"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2403c13cac3so35465825ad.0
        for <acpica-devel@lists.linux.dev>; Sun, 03 Aug 2025 08:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754234341; x=1754839141; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=06WlQZvc95e6tu1m31wg2n9UbhWFSIaIxMCBHlx+fTI=;
        b=ML0HutL8miZFn/8BxTUpVqlWf8nfx0TAYiG3wbe/5eHKxbxOtFpUDQPWizTCm8kp19
         UOv/luxUtZS7Ku42vFWnGHy/1e5qf3jZ4nY/W5Xp1GsQEmqOjSgGv115Z+hYvlxfJUAd
         8zvWOJoDCvZHXvZfhXXFgCdagRJ7sJeBRuTfIVSpxkfOUqqrK5kHaywWG1PAEmZ2Vxua
         p7QKpfB9sT3/GVBQfqpKlq1fMtWamjvUYXNQdgj0JNll0w/88ALOeFVd65D0gOWvK1Q+
         gETTKIwTKHpxpLyX7Nj57tu/d8T/xuUZxfjNIIQiOdaS4CD8eqwjXvEa4CcZckeeZ7QD
         aTYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754234341; x=1754839141;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=06WlQZvc95e6tu1m31wg2n9UbhWFSIaIxMCBHlx+fTI=;
        b=sX+cRgY9VYF8eE5C+Eb08uH7scXjnCBppk4sXC1Rakcl7o0kVke9tda3pQGDxHRaUc
         rucLOav378zvyzp1Zbwncs2hfmlt+FXk+BwBig5mnTclsy/JLecFroh+coFptEBOspdl
         MmxcBDRX8v3NdyRTp/yFiFc0twriT3bC0zcMAQbX/lhJn0O3hNSJHJdAwTxINC2MBuST
         sBIy+M9hoh1uj30csZhrV3NeRsvEr/iBATxITnkVnHNunr1nq+D+F/iuq6SdjpQA9wBp
         +5skc41tIn5RVH2rhCqSWWugG6i0Pj2xoseZioYUjR0+bnJn7J/iYLJZYGaXeiCCrXkb
         CrEQ==
X-Forwarded-Encrypted: i=1; AJvYcCW3duy83XOxACaCMGTB9oOCQUlbT25KOjqxntkxQjw9yF3cydOsaTte280zU4K5hVOu9ziqFrE6tGfy82w=@lists.linux.dev
X-Gm-Message-State: AOJu0Yzw30qnFJfgOudjA850cekLCUQLtTFe5f3ToZD+XJI7OJzp+Vg/
	sX3G/z4DrFrcwLiK/RxYbo3XTlblg0TWm9VTSbouWTD7XlWamqe9T5Ww
X-Gm-Gg: ASbGncs2GJu/vs39sJ4jaoM3QywPymkbAqvuT7yJ7MFjyoXv8wqBMuAh9juYtxoWX97
	a8VRLMTcprqXuDAqc9hwsfO+Vc/B6Y3TI6uN+GqF0/JXVwS9yBWSiQiu5mOi9fcPgzXcDOtlY5C
	gRg8hBa8P3TRjXBWVUKt8QrpCaVJlusQBSX6cmmr92uczYCZrgICB28OJMvsfY/R2UJaN0KIJ3f
	MeY0jbCHM0DCXMj7C8s0DfMtn9IBdEMfgbxkuAc3O9tZcxfFVZT/mK3b+CucJ4LtdXuIvZ//VNN
	Mh78yax23haqf9L6irh61unHehm45b+ML+3B/8hacv1dM+smXY+MbBPhif3PysXfu3JIkFUGjlD
	SjKO76+JIaj2izhZ3Y4mjx5ZvIA==
X-Google-Smtp-Source: AGHT+IH8z5C4cgFVB46EZ6EcLxXVP2IuAJ73Mv0m6YfE7gDH8wiOl+kj7/uI2bRLax+fa2YqBaV36w==
X-Received: by 2002:a17:903:2f88:b0:23f:c760:fe02 with SMTP id d9443c01a7336-24200a610bcmr182344905ad.9.1754234341352;
        Sun, 03 Aug 2025 08:19:01 -0700 (PDT)
Received: from [192.168.79.25] ([49.207.53.32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e89771e2sm89000425ad.88.2025.08.03.08.18.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Aug 2025 08:19:01 -0700 (PDT)
Message-ID: <9b3fe152-2798-4c3c-8fc5-29cbdc7c336b@gmail.com>
Date: Sun, 3 Aug 2025 20:48:55 +0530
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] acpi: remove unnecessary paranthesis from return
To: Markus Elfring <Markus.Elfring@web.de>,
 Diksha Kumari <dkdevgan@outlook.com>, linux-acpi@vger.kernel.org,
 acpica-devel@lists.linux.dev
Cc: LKML <linux-kernel@vger.kernel.org>, Len Brown <lenb@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Robert Moore <robert.moore@intel.com>
References: <20250803113820.16578-1-dikshakdevgan@gmail.com>
 <50cafc07-563e-41a7-9286-54db8a7ac731@web.de>
Content-Language: en-US
From: Diksha Kumari <dikshakdevgan@gmail.com>
In-Reply-To: <50cafc07-563e-41a7-9286-54db8a7ac731@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 03/08/25 20:06, Markus Elfring wrote:
>> checkpatch.pl is generating a warning when return value is
>> enclosed in paranthesis. Remove the paranthesis to improve
> …
>
>                parenthesis?
will fix this in next revision.
>
> You may occasionally put more than 58 characters into text lines
> of such a change description.
Noted.
> Please avoid a typo also in the summary phrase.
>
>
> …
>> +++ b/drivers/acpi/acpica/dbconvert.c
>> @@ -32,7 +32,7 @@ acpi_status acpi_db_hex_char_to_value(int hex_char, u8 *return_value)
>>   	/* Digit must be ascii [0-9a-fA-F] */
>>   
>>   	if (!isxdigit(hex_char)) {
>> -		return (AE_BAD_HEX_CONSTANT);
>> +		return AE_BAD_HEX_CONSTANT;
>>   	}

will fix this in next revision.

Regards,

Diksha

> …
>
> See also:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/coding-style.rst?h=v6.16#n197
>
> Regards,
> Markus
