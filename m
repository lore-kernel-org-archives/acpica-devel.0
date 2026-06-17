Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163C13385AA
	for <acpica-devel@lists.linux.dev>; Wed, 17 Jun 2026 17:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781716678; cv=none; b=eHa/BYuPXvTLuxvZjHs0pLoI9uyWN6lRxbxc6RcBIBnQkpWzZNNn5tMkA8MR5OwN/I5S+TQEn5k8C/Fndpv142cWyk6enjg8llar7tbL90Pu1n0qx8qumU1UL5tR4SfPKJgh5zGEOcGzxNlwnSQ9ByX6OMOmSqP7y1bblv37z6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781716678; c=relaxed/simple;
	bh=V3CcxOLia9CY0H8zjb+ZTGSXWDv/g65LFKetUF1X0Sg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Be3m7z+z6gM4OoULgHa/IQKr3hYoROC2fJvvD72mRT0xuQvlhCyLfhBEw6FSodzKR0i43dhu3u9qBe8uH66Lhu1BU5OaJU8t94ajJ3extwox+IC5oEEZjMu7WOUCjyq97X6HaUuV9xH1d8djkd+m1w/xLbUiFL9ovWaC8IrOcGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dRUE2k/x; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dRUE2k/x"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-461a15cce0bso59646f8f.0
        for <acpica-devel@lists.linux.dev>; Wed, 17 Jun 2026 10:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781716673; x=1782321473; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=DHkZUMk1sAqmgYkyu6MiPiSjqHXH7Sbq1n0RCyPRFfc=;
        b=dRUE2k/xugtqCmhDKwTorjoad4aJEyU/BkjHQ9MfAXW+gW1QlS5B3D9yQcE0wObp7Z
         FkTvE4Zi1eu+XYCOFO3Z/lj01BFLOHEnRrtfGLc/hJ3R8Uf1fIR4n+F5LkJCuCbz0yD2
         bhr25WlH6u9vzSCJlWWTFOo2w9lmiJuAWe3gzQDvUpYwSIk0GwCXcp2r5+QC4fQSw69V
         OUN19Ddr1LDMAb+z1UgbsxSzN3U4WkVBzzB9xslBkB7gfqzDjga7osGjzSD6vmQ6pZ+p
         WEoSkxwl8c22j98MIQ+27zHYTdawuOvEc8WWdE78tOE43Z68o04jv216gr+eqkVSDf7l
         M8vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781716673; x=1782321473;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DHkZUMk1sAqmgYkyu6MiPiSjqHXH7Sbq1n0RCyPRFfc=;
        b=Pt1mlbZIrnhFilhQhhlm0NBhiCDN0KapiYe7B6yt9X4iB+jMO4pRAkmP3ZrpL2Xg5E
         Bog/MZXon+0QApii1NnPRgpJN6eoZc3AturHv+ORLVQv8u82qUCoBS76Ue1tECfs6YPl
         a34Jq3AlwlMvjXsIGRfkm5BIM/p3kPJvDHgtXh1zjesrE5Hpw+/8VhNMa167wBCAgJJm
         aSyvLHWRRYtsLhVfjpxdfGwA/orcPX+EGcF96aqzH1of8vCtg+RxAMT8amPH8nb+MwPI
         /hI/FcSI/4WA4m4DdVzqCIOITqno8QQ4y/WT8q4hQ/3V4MAjCmkk8ruAGs1O+noZCBhY
         5Jpg==
X-Forwarded-Encrypted: i=1; AFNElJ+Na5R2IOyQonXGcX6yGhS3O5T1l8y4WszRS1O/NuCEEzvPGH6Sd8Tz2vcrZEpTKOfyW48mD4KcwvG6FFo=@lists.linux.dev
X-Gm-Message-State: AOJu0YzxBXJF0j1E7U9lChFVL/EyYFcXw9xp3AaAr4i1IyH5MDAXrq0a
	QD043yH3Iy1EMPBVKMkCA7tS6rUFxWpBd9Ot8LKXldyFSYRWfNiwB6cB
X-Gm-Gg: Acq92OGGDBewOkX6qm65KfNrZ6/Bi7XNGqIRaMyLuOoVh8TKtV9xosB7bMi9kY2vy1i
	p9p7ItD9joqFKNWDfnh//NdwErMIB/S+sAoLhJKXFYCddcqS2sFj9jzYgY7G9HUxg3fpbNrYwAh
	EmE+ESIr96jKZ3ngF96qXmQZ6oYHbFd87iyooAJUREpQr+VZV0iV4oAyswk8IfJCHbLAh0jDqSJ
	9bUCWPomIXN5fDMSqr4PIENCKIGK77hDyqosINhP6n5kTWa6SRb16WJQ+rqBfUlq0u8HZ3x2Xsj
	FC9e9hasSQBUZFnKtjCzK9PaQaHtSRKwaVkF+Vli3Q1fIaFA/3TloHcOgdAYQbPXJf8APupKYfN
	scNcJFUaJ1u6Q+qpnEHq6y3E0p0yjF5/8MsYBPIBO8bRJVCaUf3BGjcnRWqwVVFXFWZ+nfJHscb
	TnzNt7G4vWdkB1QbiNTk5QeAApgyUZuAlHmX7GdTn0Nizku/r1YwmkPe+g7c1m3d4yRTCzj5UIC
	ezC+GE=
X-Received: by 2002:a05:600c:1394:b0:490:b8e6:be40 with SMTP id 5b1f17b1804b1-4923821bef1mr5753465e9.21.1781716672843;
        Wed, 17 Jun 2026 10:17:52 -0700 (PDT)
Received: from [10.128.11.42] (195-23-151-163.net.novis.pt. [195.23.151.163])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f2dbfb1sm58928836f8f.35.2026.06.17.10.17.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jun 2026 10:17:52 -0700 (PDT)
Sender: Julian Braha <julian.braha@gmail.com>
Message-ID: <58f7163f-2fce-41e9-bc35-d1d8e6f4a298@gmail.com>
Date: Wed, 17 Jun 2026 18:17:50 +0100
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 07/10] ACPI: APEI: introduce GHES helper
To: Ahmed Tiba <ahmed.tiba@arm.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
 Hanjun Guo <guohanjun@huawei.com>, Mauro Carvalho Chehab
 <mchehab@kernel.org>, Shuai Xue <xueshuai@linux.alibaba.com>,
 Len Brown <lenb@kernel.org>, Saket Dumbre <saket.dumbre@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
 Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <djbw@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
 acpica-devel@lists.linux.dev, linux-cxl@vger.kernel.org,
 devicetree@vger.kernel.org, linux-edac@vger.kernel.org,
 linux-doc@vger.kernel.org, Dmitry.Lamerov@arm.com
References: <20260617-topics-ahmtib01-ras_ffh_arm_internal_review-v6-0-91f725174aa0@arm.com>
 <20260617-topics-ahmtib01-ras_ffh_arm_internal_review-v6-7-91f725174aa0@arm.com>
Content-Language: en-US
From: Julian Braha <julianbraha@gmail.com>
In-Reply-To: <20260617-topics-ahmtib01-ras_ffh_arm_internal_review-v6-7-91f725174aa0@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Ahmed,

On 6/17/26 14:54, Ahmed Tiba wrote:

> +config GHES_CPER_HELPERS
> +	bool
> +	select UEFI_CPER

This config option should probably also depend on ACPI (could just move
it into the if ACPI..endif block), or at least have a comment that
selector options ensure ACPI is enabled.

- Julian Braha
