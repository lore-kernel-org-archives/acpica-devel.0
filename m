Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795799343;
	b=OdRBxMNCVQtxw7n0lO1NOV64/sgqvj4kWmRIFXIkU3MxqhMGPdsfJHYUje8IBkdru70n
	 u8N0gxZsuARYUZNk0chD8xlRytmOTqNK88jpa6huZPFY3QV6ZJhgao3r08RdIIi9M0LRa
	 6yIK34g8xKsjrl0ou67bWJpwnEPGaJDZp1nn67Mz4wAEkWegTPCXW9x7pVuENiIzP3oby
	 JbiVbmvONNO7ga52QtAlsXOGCci5x9Doz3J3aGMmIDfj75EhA+s1iKkL9iQvMW+gIehgC
	 kHutomBUcOtFa0y73pwHJ7f0lwwQ7PPq3ei9yuzDuaOwYqU4osWcqv1q14hOElAv38Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795799343;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=HB0ZTSdDDmOkIsTidMqTBiLshJg4ThGdlzLSWF0DBNU=;
	b=GdSRxTYhkme49Jq86KpffT65mF503kwZXDpcBrwlb+9Tp9src/FHDuePYkEdrQy+9L1h
	 9PLDxuNAczUYT8fUlytJP1+H8Y/qZngfTSqL1PcCDQfE4fCK7ZYlBwRobaZDcj4q6fPWL
	 nJlTQpEu7yVzwKRN6jygbD4eQ98S4tKg770cGM9mI7Jo0s1jSjCWsbM2xDSVWPGCBWHmF
	 YMbg07XTOu5sNV8qSta4UFZ5jBC1fwzjTtIdyXfdyoqO24k5vPrbKiD6yi/jyW59d+LzV
	 jlcj5jeqcSxi4hbG785OqXjIFXZoteuH29fcJaCscLohtV3VP5m+HbPXjur0eD3v+5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=irKHo4aD;
	arc=none smtp.remote-ip=209.85.222.174
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3661606A324
	for <acpica-devel@lists.linux.dev>; Fri, 27 Nov 2026 17:09:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A3661606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=irKHo4aD
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-949664ee41cso840114885a.3
        for <acpica-devel@lists.linux.dev>; Fri, 27 Nov 2026 09:09:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1795799341; x=1796404141; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HB0ZTSdDDmOkIsTidMqTBiLshJg4ThGdlzLSWF0DBNU=;
        b=irKHo4aDUlqCBkPQaXotDmCeSxggrL4rRsqfGaRAQfF2b7Ay/dhHBgIllPHnEpbypv
         x2cXSDL8gShG6yRAm/WQvuNjtDzLz0Kki+kNyvJEb4O9tH+XiHyKtiZFlDG2A+eL/W7i
         lemTsfDK/cMjgbqT3p0tyfxAJ7aNi4I8QYd1wAg8y/GYTDrIBqUOV2fySoS687zhxgdE
         10VvkZ20JHPDCb5/A610jj9m7eKSuEhmh53AA6UMZzsppWHXqOvgqjjnMvriK9RoKDca
         yw0LAD3iXTGzZ/HcxmT/m9c+BFIbVgaLWKt32gUso9LB4BdFxTD472uVD7uFrvF8WqS7
         zimw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795799341; x=1796404141;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HB0ZTSdDDmOkIsTidMqTBiLshJg4ThGdlzLSWF0DBNU=;
        b=YwMFthycSo+yzqlnPvC7znvBe8y+Q2VjRISNlawY28bipAI0vE7fSBJLIq90494ARv
         PAegzZobWs7nJEkYWya3qytkI00sfMp8bHZJ1iLpDqMV/S147198Pj2x3g1q6STE1kwG
         YHC5SnaNCs+SGVAFgiFVb+4njn1NlXzz+GRfql5b3XXPlGkvy88YYgBd/51aaBFzJIov
         tgDYOeVjQr3wMkm0CLGVQSq8OixowKxkKYDuMd4lwTI/qeIwSG2qYCr1+aRp3yMugnx3
         czSMpQ7A719JdOj8Z/TiJWMKm6vLKvQ8xJEFjQ0I58CCUj4BACfO9rM9Ke8UZ/BfEv2U
         /2mQ==
X-Forwarded-Encrypted: i=1; AL+hErFQ0cH+mqfmDmQ1vaGmMXIdLwjcLUXOQWkkUdQYfuFGKU7trwtp/uLYlfbQiKHfNH2t+rhwJOUFbmnh2FA=@lists.linux.dev
X-Gm-Message-State: APuU4Z8++ki/gXzjZ8beLZ5jsTHFdII/uRdHX+YThpBAe/v8tlY+DlNw
	gHL6/IHvk/3uV1FkLIrnACe7dXhH+Bt5/pKWmJNpZA+BSDcX+/0X4JtqDspozXIuWWQ=
X-Gm-Gg: AZFdTZfI4ZvS2JLvDyEg3/6QUQQnmENXBvTQlNp/B6ylMIMA0RQTFHm++Du+wg3ofgD
	lci8bOjjgmDGA45nIZgljXbJuXVs/nc8riLuf0Dld+gD7fc1hMr6iXP9TUCZ8/mt3cdrJPzSL0e
	//7eHvLQQqGb65n5puqaGgCEQxnXq1um9u6O4AsZuB2rcHORtls7I96t3v2OZByw3mcfPp74GTJ
	1Cow0DmfyTIhC7PLXDMCwIN0xZYG5Fkl8KmJvRetVIpqGiyAfXuonnwSI34No8kWpxe9dX1gdFZ
	VQJx6IlS3HFQn1drAzBICH+SWJaZLacQfKz3F9wE6Ezh2an60QC0NGfkZsrQz85xCUvU7DRO8Y3
	xwLY6czNFiQd+dniujH7A2ocXTqEW/sUVVh2sSkVod8sIeiAsww7D4IRlB2v80dDjTUU1KjUF/3
	j/uW6/o2p8pRr1UDWHZGHBtdHbCq7VqIBtXkQq1WLML9L1+GCmpOw3rF5Z+7eb6rSD6LnMSLLZc
	NNR/jkT2/DPNyo4T3eBAHOHeX7SAgZriv2WiyaH7MAG2h8sZa1ZAMqR23SGZufMgxhRhBoF4UG6
	OnxADA==
X-Received: by 2002:a05:620a:7206:b0:94a:889:5a33 with SMTP id af79cd13be357-94a08896165mr1311739085a.30.1795799341642;
        Fri, 27 Nov 2026 09:09:01 -0800 (PST)
Received: from ziepe.ca ([142.177.118.84])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-949bb41a341sm1875035285a.37.2026.11.27.09.09.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 09:09:01 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xWzRU-000000079ec-2Xcr;
	Fri, 27 Nov 2026 13:09:00 -0400
Date: Fri, 27 Nov 2026 13:09:00 -0400
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
Subject: Re: [PATCH RFC v3 8/8] selftest: attestation: add
 cca_guest_attestation_test selftest
Message-ID: <20261127170900.GU246011@ziepe.ca>
References: <20261127-arm_cca_mr-v3-0-df3230afce8f@arm.com>
 <20261127-arm_cca_mr-v3-8-df3230afce8f@arm.com>
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
In-Reply-To: <20261127-arm_cca_mr-v3-8-df3230afce8f@arm.com>

On Fri, Nov 27, 2026 at 03:33:03PM +0000, Yeoreum Yun wrote:
> Add CCA Realm Guest attestation selftest to test evidence-get, mr_read
> and mr_extend interfaces.
> 
> Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
> ---
>  tools/testing/selftests/attestation/.gitignore     |   1 +
>  tools/testing/selftests/attestation/Makefile       |   9 +-
>  .../attestation/cca_guest_attestation_test.c       | 517 +++++++++++++++++++++
>  3 files changed, 524 insertions(+), 3 deletions(-)

FWIW, I really want to have an attestation userspace project and there
is where stuff like this should end up living..

We haven't got to launching a github for it yet, but that's the plan
anyhow.

Jason
