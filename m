Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7573BFAEE
	for <acpica-devel@lists.linux.dev>; Fri, 19 Jun 2026 17:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781891199; cv=none; b=JBhPVzMJjA8wxnKxZUy3JZEhdQGXmWRlPvL71Qe2qDL8JKpmBQbavC8tzXeP3piophtOh3SaSk9TAExopvLDktRBTs6p7jcFQ/stxep+MedQLfAHO9k2XEu5Rb9Q3YMbegWCQ6049yfsCzPkYu3TeqNSKZBWe6WSEqTGnk7cGTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781891199; c=relaxed/simple;
	bh=H7f14CYwNP46ECpdeY80MJ+vB0wytZ/WUeIVEgw1f+A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i03CR3On5I/ZkA6/3i2SAz9R3o4ucFB7SoDG9zMnrlrLILXZ4ABhHp6tjTEddVY0rPqEwMc8ryQywODt1aRmK34/UIwSi5jr4FkC0VE889PyRYlRIO6kCP0i3141ax2RQQtjbOBRXH8csdR14/t6pYTOr0hEXZ8xdfhCp0GSFD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=em1mFc5a; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="em1mFc5a"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4923139e940so14114795e9.3
        for <acpica-devel@lists.linux.dev>; Fri, 19 Jun 2026 10:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781891196; x=1782495996; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=H7f14CYwNP46ECpdeY80MJ+vB0wytZ/WUeIVEgw1f+A=;
        b=em1mFc5a9DAdHnko9MmXhbsHEjfUMg7X5aq8c5lwyiLcMlN8Upzm3ibja5gZbIvB+u
         JBigKzHQqhqvvCBCucFQlRkifZVGrQ3tL/I2VC/33UZNUJbBKVL2zJJBO0iR8uQD1TYF
         j9T06+4rq/tE44z++YpkZzHH9CZ355cRToYdCnl3kOQjbjh4J5iJHFJGi28/9y1YBW02
         AKQ2AsQ8A5IwJOa903HkEQ4eL9lacE+UgYFAsBL60phXMhd6Cooadlu3JaZU0PFf3X6g
         N3u3+VRFRbkrOwEU1FMFjKQ6leRdpL3Pb4iQe2T5Fap1PYLbt1wiiLOLMPhgXjAabD/G
         uEPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781891196; x=1782495996;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H7f14CYwNP46ECpdeY80MJ+vB0wytZ/WUeIVEgw1f+A=;
        b=cRnu+FFd5EIWZPCLSRTWGlFb6AHLs2vbXwLbxkcMs+ay9DlafOfHp7tFesAgOI5ALJ
         Elhwk3gd6fiR6GIi3e1MJFx6Rs5BNrRWgnjjYJJF+CKKJrow9JUUWlkyKDRW5gaNOxXH
         4PEh/jU2EThX7ZymVDhp5V1f4kafO/XIM0LPr5Mjh1Vma5/S4kW5KCA3JEUh2tEjxXEB
         RFU7LsdnysSXSPUWFwhraN6jjz14qd5ESPBuHJ3wf8XWFXM4FlaeDkuHC9i9FnhXK3Gc
         Q/5dHmbqbshptsBMzdOb77+ihN84xI9pIFlvox58N833dioIvzV8VxMhMK9lIo+TwpgS
         ELyA==
X-Forwarded-Encrypted: i=1; AFNElJ8GMTf/a2Zvmrq2XfIeSRL0DIna6UKYlR8KqomBTnW2ZvnZojm79fSxzv+B7ZmW/zChTl1v3wXwsOqFs1k=@lists.linux.dev
X-Gm-Message-State: AOJu0Yzg0s3VnUfuHYA+mAsXAelbbJC4PJ/krkYSEv0lyxH5naqwGjE9
	a90Hc69nWCM85M2XDpJ9V0h5QxEGGdGscN3h+klO0rMVKCe+fA5wA6KOyII2puxUjT8=
X-Gm-Gg: AfdE7clYt7sRX4zBidMz1tryOP4hpN32fOwCXYspCNiGWIME65eCeIzTXdpLxgpU0TP
	NvWFAXZ1/cTiIBpZOj/BVdlHfM0v06nnClDgIVd2R6WFDdcPnjZjPgc9mY2gQ/NE6O2aJCSOAk7
	LhNVXb+T1ZUkG7I+bAbrlQpbd8ob5i5WRxoKYT3n8sWpj8Xj6Up+bpt3t9AwcaZ81iTXw2BFKvi
	T4hppLhp4oUS/RKNGtk2iP6b54hgkSKyceianK93wjQK698CJ2kBOfejLBTJp02nYd8BzT9qv4Q
	uZgTvSWIlCSjqbiGqEf/iw/W6sP1Ibc0pfXq8URL7wj2ItPGoLhhJtnNs5WHcp5bkDcxa2zvozw
	o8sAXrC+3wmQfbNVfWomxaYTC2o3FYY2uSx7AFoPYGzVPsCScaMsI+67382TgVLvNa+TRAYrCIl
	X+8BeFF6gS1K0hfoFd92MIHUmGioGUAJfNbTNmLIP5tZ8B56HNNz9j8a/siX5wJMV4px1DHCGwX
	iEGLo0=
X-Received: by 2002:a05:600c:a15:b0:492:39b6:5a30 with SMTP id 5b1f17b1804b1-49242591d5dmr53790795e9.35.1781891196410;
        Fri, 19 Jun 2026 10:46:36 -0700 (PDT)
Received: from [10.128.11.42] (195-23-151-163.net.novis.pt. [195.23.151.163])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49249238bfbsm1569755e9.5.2026.06.19.10.46.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jun 2026 10:46:36 -0700 (PDT)
Sender: Julian Braha <julian.braha@gmail.com>
Message-ID: <84dabe49-8405-4213-8b73-433cf736ded9@gmail.com>
Date: Fri, 19 Jun 2026 18:46:34 +0100
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
 <58f7163f-2fce-41e9-bc35-d1d8e6f4a298@gmail.com>
 <81dd6d0d-427f-49ae-9573-fbe84dc2185a@arm.com>
Content-Language: en-US
From: Julian Braha <julianbraha@gmail.com>
In-Reply-To: <81dd6d0d-427f-49ae-9573-fbe84dc2185a@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/19/26 16:45, Ahmed Tiba wrote:
> GHES_CPER_HELPERS is intended for both the ACPI GHES path and the DT
> firmware-first provider, so I do not want to tie it to ACPI.

So what's the plan to fix the build error when ACPI is disabled:
https://lore.kernel.org/all/0f131ee4-d335-45d2-b6ae-49c18df1353b@gmail.com/

- Julian Braha
