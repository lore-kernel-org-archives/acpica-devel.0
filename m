Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34AE3644D3
	for <acpica-devel@lists.linux.dev>; Thu,  9 Apr 2026 14:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775743874; cv=none; b=fxr7g+HZSP7rMhFeAVuwKXK0XXc+H2PwYtTMTJikJBtOxBRuaasOkgOBeDHePmMqwIX64rYvBCdBGlW47hU6uhJzB/stDak+e8aezTG28RKEKOzONA9z5+Uzd3l/m97uVrIMD1hpcLsI7ojZRHbWqrus3B11yYdVCA0leSqD2CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775743874; c=relaxed/simple;
	bh=2kme6vq0CMdYGhS5j7KGCDSRfyaFsU4TVNgDqJJ/oi0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=UUkF8lOD+kSU4mQISDraPtWOh4/KW2xijdzKmcFJcTuO2Y4ECsTsnrxJj3qStaSJaAvg33C7OPxH/gncY4Z10yAvrzbeSS6Mr0xLe/Jcr96qG70JSb/TeG6+iZJgG/EFPxFDsyI5zowLkBg5dEHWMKfZwne+DopiH69cEGVUDO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VaEm+Thz; arc=none smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VaEm+Thz"
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-12bfa7fe691so864360c88.0
        for <acpica-devel@lists.linux.dev>; Thu, 09 Apr 2026 07:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775743870; x=1776348670; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=iBWvy/3k/KSqMZVabRNYGr2KZN8bRWRMbJnLKam4a1I=;
        b=VaEm+ThzAWms1nPDy6gB1+YhV1img2SWaqv/qrXDydx5H8cJer0pj5OPSbwvrY00Mn
         ucjuIPnZHE9nkH5SeWgdj//zjVAmjpT6YMwYnpFWSP5ZlPTMeiKl5QVgs5t4nbays0S2
         5EHA2PRZXrhIewBQiVbQlYnAWbaWbqWlJknx3BYaryI6fcWbe6kBctOTbTw2p9Ew+PVh
         omdm4pG9cAIlL6lwrzxKrzvUusTZJpcOFtAQhPlDzdkkXl7J9FctU0/6LbGQ9Tr1XS/I
         QkzAD5JS38Gnt4Jv/u7ph59IZrmskxQ/f9NvJXwszPjpmemlNYspYKmL91Oh9SlLFcEV
         eH+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775743870; x=1776348670;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iBWvy/3k/KSqMZVabRNYGr2KZN8bRWRMbJnLKam4a1I=;
        b=QxP9boUFCNXJcDnZfbIGxzXJSsvwxxRN0BZVLesqEAAzUhxJdta3QPRFQ8kZBN23wZ
         lft1/7cozmjpEnXSQJwHHq5z+HK1yfB6LEg6TuaTiQSTliZwRgFjmSs3QRulyq6HjT6M
         S1zQYGAD2AASDcY4iGyivETWi3HCJuLCCdik7kqhUdJh9ebY6SrmVIiww+B3MZ4Sm53Q
         UitKmzO5WU22nsP9ZIW8WUiJvTm5mcrL7hNp2wTNUvGvgVqIM+EU5jyulc25huVfxbqi
         uUM9AJUCpAhVICieET8YilUgsAhGPwWz2etOY5xXyYyHydDX4CaMTzq5AepOLLsS06++
         9E3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVli6/wecBJ7hUZ1SDPKv1+9UIXQG/V3PgDMt1Is4P54eS+k+ZC+tI2XPbzQbdzHytGCbNpJZ7XYux+h7c=@lists.linux.dev
X-Gm-Message-State: AOJu0YyMna/E2YFhFcPmpiEOVSsEv+t9yaiSoYweRN2GBu5HsM66eg+4
	p6ZM7iM2mx+7YFvwQ2dD+6NYmgDSRt8oTzoKg2sSIlvw5TPI0wb79cDl
X-Gm-Gg: AeBDietMT6q3kXqATSMZztR0ErA+WwpfrP/gU4L1ILnrQ8JzfWrcdKrZ7N5+bXfMZvi
	1DUe5GE2YjEDRIHeCqhzWjVD2wd3MYsDavm/B/1t9YCMxqd5RHZkjcSevtScjvsZC2YU7UQUzRO
	T14KG861z7FoaXusAf/U2p6GJW5U4MtIRkGR7zUkPlhrycwSHXoWsUT0mOW2wL7PlglHNOWZOtG
	ZNUtuTq2/sX3yE2vBNC9cF+AJQSplUXlK/7gfXK4OE11ov6LCFfbEzkgiOdjIuMNQat5xDGIeg9
	ZJpgyaKV9JPdNp7utjkh6hSj2bzfioHEL9dZuvSXOme8bwhoiI5jeNXcuI3UvPiaaCXxuzUG0Pr
	szFphYn1Lvwfz2Fpz9NlryjmtM762iSSf1fNi2ETJWuLFZO8+yDZis7AZyEu7oJ5cNSsc8EF+Yg
	rYYzRH7F0wJB3+X6IS0lR9E43FSlHKljxSeYO7nHaUXUid5aHdl3ms5Cb1hCIU3tWgx6fuEo9P
X-Received: by 2002:a05:7022:3d0b:b0:12a:6fbb:3353 with SMTP id a92af1059eb24-12bfb6e8cd5mr14610433c88.3.1775743870201;
        Thu, 09 Apr 2026 07:11:10 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12bfea5f860sm24752869c88.2.2026.04.09.07.11.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Apr 2026 07:11:09 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <56c69966-797b-4f5a-b24f-2409b3cf5e30@roeck-us.net>
Date: Thu, 9 Apr 2026 07:11:07 -0700
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/13] hwmon: spd5118: Remove 16-bit addressing
To: Akhil R <akhilrajeev@nvidia.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Frank Li <Frank.Li@nxp.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>,
 Robert Moore <robert.moore@intel.com>, Len Brown <lenb@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>, Eric Biggers <ebiggers@kernel.org>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, linux-i3c@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev,
 linux-hwmon@vger.kernel.org
References: <20260409105747.48158-1-akhilrajeev@nvidia.com>
 <20260409105747.48158-12-akhilrajeev@nvidia.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20260409105747.48158-12-akhilrajeev@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/9/26 03:57, Akhil R wrote:
> The intent of introducing 16-bit addressing was to support I3C, but it
> turns out to be that I3C do not require to read the Legacy Mode register
> nor any specific encoding for page translation. The testing of 16-bit
> code was limited and there are no known users for this feature. Remove
> the sections which are there to support 16-bit addressing and prepare the
> driver to support I3C appropriately.
> 
> Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
> Suggested-by: Guenter Roeck <linux@roeck-us.net>

Acked-by: Guenter Roeck <linux@roeck-us.net>

