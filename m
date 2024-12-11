Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E382010FD
	for <acpica-devel@lists.linux.dev>; Wed, 11 Dec 2024 09:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733908500; cv=none; b=eMJszlt3xFJBVlZ/xVDJ7pSCEuhhoXXEACJ+zZsZqrPl65xt6EwZSKWZL+aKAfeEe/7TyFM+kR7saqGIAIdu1OgAtlw5/OpQlihYOczyOwXm9G+OpBCXRKRtQ8FiSB7XWLIYd1SKsKyWOYulyYi7wdlmI4bSUu6WmY2IJtiE4yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733908500; c=relaxed/simple;
	bh=JUXrxkRS6ra3CHJ9SyF7bUw/4jbQj+KL0Fb1Fh2MyHA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I7vxLV0mltNNPxvny4/dKQniRF7oN5nG9yeX/40RLHjlLQbNffaIyKSb0JzlmaSlcwVmCmmsyPt1cl8iRKFI08WVibc2wudjyup0OTFVwPSlr87Hd2cemzz+KzBYi9VpuNwss7wDE31YIx8RqII6MnTi6IVucP3rkGy/Iy/ruiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=C1kCGB8P; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C1kCGB8P"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4361f664af5so2632845e9.1
        for <acpica-devel@lists.linux.dev>; Wed, 11 Dec 2024 01:14:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733908497; x=1734513297; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6FDO3wL3i1XscIg74LPG2N/BXo43Ca59PIHDAIDDUjg=;
        b=C1kCGB8PZVgYF2lsgbvSel2Dg0TU2HBTJOk1GqB/24+ExT/XH7CNWDaoO8m2G+V7DW
         xiqeNU0nRspn75Lllu6feG8grxLq/dsGvLA+obtifsk8pyLxdUxLFFU9pCgCRMcbRPPo
         D+pwzKAAvaerZAxAyYwZstj2mG7CIxlk8UB38jmrAhmxd1oeXO4h/limZn//0Bx520tX
         D7gSmRTuKCnhljsVczl2yKCLzzpRNoxaUZryhWFmte0V7Mw9cH8iMNV2pYJXjsjid8RY
         jgmKi5Vek6Ry9nNLLu7aly6WoiCmHknaOijtoNSPxpyLcX1B9C0Z/aVxWMAkQWzjEMiD
         lamg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733908497; x=1734513297;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6FDO3wL3i1XscIg74LPG2N/BXo43Ca59PIHDAIDDUjg=;
        b=mYF84MSPfjrP6lyxMeFWPiw52IndAe/vWBr15yVVdlJ6CBXP86/d3UB+1r7vQnZkqB
         s2npeY9V1ErhMkSKp2Bf0aHsVk4S8+HoYjrLJzJ+s5iVznqsqB5tOMAq9sxXyIW28+UC
         ZQxsZpLpzeaxDZyRpInvXLd5BhZG6X6ZJRe7uvEPFEaB9UiysMmcKK1sNxI46SXaeMCU
         gn1N2nZ5yAr3iitQX218ZUlx50o06AC0CPQb1TqWQ5GKq4DIzK4XFeZjxmv5s+20Are1
         v4s8QT9L8Rv48Rv/pYd9zFFZ5zGneUF7yO7C9aH7efnESEbRYOkA8P6jtF5cksBFR2Q6
         kHmQ==
X-Forwarded-Encrypted: i=1; AJvYcCVxFN5fmKGrnEelMFgHHlFY/M9pHYAyGKJA9xy94c0vBHOZ10F/UetTHnKbj9tY21XBdNZdtOkiVEDmRbI=@lists.linux.dev
X-Gm-Message-State: AOJu0Yx688z+RH6zbxml4fEhJUxxLRrPSZH4ZmXmzRrqL3I/Tqd8p/Gx
	raVWw+ZBTQCOf9CNaT5mHeFfgHmlNdqBuwwZRLigm4YxLPfh21uacBFdKEKea5Y=
X-Gm-Gg: ASbGncuFVrKftXzqHbSnMjIjfuUkMNMDmjAReE9MbmTrismNaYSa+XbIpqKkKDmbN3K
	bS9SGRisswhmRD26Hgcj2+FZoXMolLNc6Wqos/V3JxuJvhdjwPbR90ZWQK/vpWiqJfIRT5U9lSJ
	gTcqKsV3uT/GwuijqfBndMuQMPQHeh2FuFQvYaXc4twe115/cKNZntrUp/6/3HnbR7ODyWBAmd3
	PGN1IhGA4NMfqqGSwW9Jia5aiWqjrAJ6SGYdBwTrQZ0bPO4RhKnyHiM9Ok=
X-Google-Smtp-Source: AGHT+IHOLK/ljbtyNYazbMd4hvX84Qm4ErHQ/BEuJGZ5dGRRjqOpg37GnjWdhZty1q73L7x1DOcRRA==
X-Received: by 2002:a05:6000:178e:b0:386:3702:d2d8 with SMTP id ffacd0b85a97d-3864ced69c8mr1574947f8f.58.1733908496679;
        Wed, 11 Dec 2024 01:14:56 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38782514dd9sm803351f8f.69.2024.12.11.01.14.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 01:14:56 -0800 (PST)
Date: Wed, 11 Dec 2024 12:14:52 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Ricardo Ribalda <ribalda@chromium.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev
Subject: Re: [PATCH v3 7/7] media: ipu-bridge: Remove unneeded conditional
 compilations
Message-ID: <a91a3993-6c81-4abc-8609-8f41804fdf62@stanley.mountain>
References: <20241210-fix-ipu-v3-0-00e409c84a6c@chromium.org>
 <20241210-fix-ipu-v3-7-00e409c84a6c@chromium.org>
 <20241211091954.42a5c778@foz.lan>
 <Z1lOCGJvgFcqmR3R@kekkonen.localdomain>
 <CANiDSCvPNf2KiEpr6Tboon6bjUxwEkD=+_AQjhiOA7RDTTpnCw@mail.gmail.com>
 <20241211094854.407ddd54@foz.lan>
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241211094854.407ddd54@foz.lan>

On Wed, Dec 11, 2024 at 09:48:54AM +0100, Mauro Carvalho Chehab wrote:
> Yet, based on the title, enforced by its description:
> 
> 	> One of the quirks that we introduced to build with !ACPI && COMPILE_TEST
> 	> throws the following smatch warning:
> 	> drivers/media/pci/intel/ipu-bridge.c:752 ipu_bridge_ivsc_is_ready() warn: iterator 'i' not incremented
> 
> I don't think it makes sense to c/c stable, as this is just a smatch
> warning, for a configuration that will never be used in production.

Yes.  Plus that check has a lot of false positives if you don't have the cross
function DB enabled.  I thought I had fixed it, but I still need to work on it
more.

regards,
dan carpenter

