Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795804610;
	b=eXP1t68DYuV9y+ffi5DLMJXCUiuqbC8C+u/ZUUEfqqtepJMRLd6QFpTqaLP1OZuiq4NW
	 pZHhzhWoNLW9HFgCDCuwf8fLXwGv0WIf5gKO3obRmAHpsDb1e3pu51ANeG6k6W98eW1zS
	 scvz6aqj+qsS7nSuwMyc3Lp3bCeAUnhgjE8Fy+84YlKlO50LJyfhBQnd3JYZk/VzpnZVA
	 IsdUWmYi/L17k24fhTzW/ZrBWJc2akowio4dheYdLdllD8izO7qc2G7QWKF1Zkjv5yypt
	 V79fmQ0K1vwABlqMnJ1fNb3Id/ckmDeileTqsLo2zeHNUuIbS9Woo5IhS9SX9TDokfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795804610;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=+9Dw/wen6g6fWY32jCYKXg0uC2F+6Oaru/Dn4CTkyZM=;
	b=CHnGNCxo+ssWnH/DlvjPH1vBenoykvmAYbhoy8xFziIoyk1sK7/iXHVqm0wq+glrkxfI
	 ZY25WHeNzhziFc8X2wh0Ecv2irQK9EPfjFAAt/E367vMncY29hMW1W80a0DCECsNhhNBA
	 MjdpcZv4yA+mxX31pJjTsoGFmIuTp6RCIVq51hjrNZOrYUXDk4OLt2BCviChvLTyUwlby
	 8JzEzNuRJgT6y7yCwzpZHGfGq+2C8yzrps+egCKuS2Ix1aEBT8UNGQooS8PcjxObQCFDR
	 nYYmKHZXg8MQzI4DRFFmrfd1H//FkgMLJv7HcoAPwj/NCFxx3oMc80C/+vlkeA6KtGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=ntSVC3mD;
	arc=none smtp.remote-ip=209.85.219.50
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D1A606A329
	for <acpica-devel@lists.linux.dev>; Fri, 27 Nov 2026 18:36:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 73D1A606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=ntSVC3mD
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-91f0274f88cso109181796d6.0
        for <acpica-devel@lists.linux.dev>; Fri, 27 Nov 2026 10:36:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1795804609; x=1796409409; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+9Dw/wen6g6fWY32jCYKXg0uC2F+6Oaru/Dn4CTkyZM=;
        b=ntSVC3mD0F4dUIZ+F2qrWqaJ7S/quet1+EzBIzBADN6/G4nOjKkh/ULr4KyPxwTQ3f
         BGtnVZwUl7nstHgrLYbs1YV++x/VZICRSTwyzmsFYsbIlUhM74hFDxNv6AiISAp2+6jx
         LPtPq7gJJ3T76WgZY9bAnNBU7JFAwTmRqXkH64eO4clkacw1fDIlNRxdbOBClWJS91Yo
         JkDHpeMhGZcN0wBGWPVKcCQWPuWfkjHDLgdn6Yfjluco7xHkFD+CviFT8fVJPeNmRxKV
         9MoOa0ivYP66fdCTHoaCQauTRni5qeoNqxCWlo6XKEURY8Xmmgj/RyWXRZGFc5TZEK4+
         Yyqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795804609; x=1796409409;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+9Dw/wen6g6fWY32jCYKXg0uC2F+6Oaru/Dn4CTkyZM=;
        b=kE08c64d93NFnI4eyKl6vM0W2TGcgCJSVXvVNsv+KDxsp51GgLHXiNH+M2T2u5nhEl
         NlxHl6WWP8Fccu3T2BmI3rl8oQaGkQnrp+BCCQztVCY+0y4UnBd30L0tGKaRX8sESBwv
         3ylRNJCGgHdKbmwrCICP8Q01iCSwl8JUXU+RTXgn29m07DPtR98FuSY58DRXNLGsqjPW
         27dfp1DcG25VFbkqDZohyTWN1Q0Kydq4ZMYYjrz9yK5Gr7qUQFuIJGV4VXSQNFx1ZDzx
         6gmwuEQiRg0DK64y63/V4e2JXF3+i3WawBLmYYx4IUAX4UcoI0Y12duhvQ5eAhHtaSq/
         8OKQ==
X-Forwarded-Encrypted: i=1; AL+hErGogrRdeAS5JhoM5rkKLuVDKpXtVy2SS9hrH/aUtA09rwupaXJ5mgnwhRlMf4pGMG4jQ0G80Fzzy4L0Nuc=@lists.linux.dev
X-Gm-Message-State: APuU4Z9738uas6knhBkYJQrC1lZTYIuihEsquKS4vdz1id93+5wD0wjX
	24UxNeeOYLLX/cqJtbxP7XOfT+rPYLkeDQg5QhrxWUWpFmkmlaALdjn1tz2yxisgBZQ=
X-Gm-Gg: AZFdTZcWOC931cH19wRj+4EvGTutmsXiNOlcUFvj72zQMatns1F0ZNnTI3Mll7yta3p
	3Y4IPqCHoqXsLAR8VdS0cmDOCwvhvKLEyDygoPHUGwwn8cUGudC5ORAB5hCaEjUrSXxcG/ZWn47
	wyNFzDMNGC0RB6Z2FbKfECAlJP1S0x0nZ/Dl8oRj3vhfnn2k1DE+YUWmRptqiT7R+2B1whIj2Oa
	4lc13mhN3owDR8uOTK+IMN0gi6jHJX3ZF1HFxf3yaJNqrusZb0xVeBrQaxyKiFQ8I8EP37ymtqI
	qhSvSY2nuKanECQqGZx9Lv08aosjoobq5tS88wJCIEDUev1rSQ/0zqsJs2WB7A8M/LArpOp9AaS
	BNHQVcfHSUb23Dbil9C1c8m2svsbhADMErKiUfVLeQvw7w5kxGNksJxJuGcIKaBYrkdQsLEVLg0
	NjCg0nFPzyUD/DBrK6YuXK4hA+fYb2gLDVbypXaEcqyX9hSi1aK4WM+vE2SXG1rx/unWvRwUSUd
	Eho0sO9JnFT8bNM/SyTy7YktkqE6O9f8jwMjRqbMQAj9h7LgQADeJADBGqyJ1kWYClDz1fkYFlR
	Z03wDo0=
X-Received: by 2002:a05:6214:4686:b0:921:1ac1:34e2 with SMTP id 6a1803df08f44-921653a9042mr254285806d6.24.1795804609400;
        Fri, 27 Nov 2026 10:36:49 -0800 (PST)
Received: from ziepe.ca ([142.177.118.84])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-921349b253csm225559716d6.15.2026.11.27.10.36.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 10:36:48 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xX0oS-00000007aS6-1aU4;
	Fri, 27 Nov 2026 14:36:48 -0400
Date: Fri, 27 Nov 2026 14:36:48 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Suzuki Poulose <suzuki.poulose@arm.com>,
	Steven Price <steven.price@arm.com>,
	Sami Mujawar <sami.mujawar@arm.com>, thuth@redhat.com,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <shuah@kernel.org>, Len Brown <lenb@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH RFC v3 7/8] attestation: providers: introduce CCA Guest
 attestation provider
Message-ID: <20261127183648.GW246011@ziepe.ca>
References: <20261127-arm_cca_mr-v3-0-df3230afce8f@arm.com>
 <20261127-arm_cca_mr-v3-7-df3230afce8f@arm.com>
 <20261127170722.GT246011@ziepe.ca>
 <awnLgFZIhRZENiE4@e129823.arm.com>
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Post: <mailto:acpica-devel@lists.linux.dev>
List-Help: <mailto:acpica-devel+help@lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:acpica-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <awnLgFZIhRZENiE4@e129823.arm.com>

On Fri, Nov 27, 2026 at 06:27:12PM +0000, Yeoreum Yun wrote:
> [...]
> > 
> > > +static enum hash_algo cca_guest_attestation_algorithms[] = {
> > > +	HASH_ALGO_SHA512,
> > > +};
> > 
> > static const
> 
> No. it's a scaling issue since the attestion algorithms could be not
> only SHA512 but also SHA256 and SHA384....

Then don't init it here and do it entirely when you query the RSI to
learn the right value

Jason
