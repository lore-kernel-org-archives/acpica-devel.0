Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3939216D339
	for <acpica-devel@lists.linux.dev>; Thu, 18 Apr 2024 14:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713450034; cv=none; b=K2Rl34ytSA2mxXjMCdKzx0fmlTXL7n6EISdlH061bmqNon5TgJr4GWS+exod+glIkkNCOyGfsqXH+4QEUssL6u4BpYZIFGzaa3PeDyx6KglP/2V2viwP5ukq/H7H+Y2HKYTG9bJha0KMfhoCuaFoR5BQ4MmCMBt+n9/N/ID7vx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713450034; c=relaxed/simple;
	bh=gAa7Kq1mYFyz8jqtnXVIe79COqi9Rf6W5LHAFGe3mjc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QKJVedJjPYYbxpce6YY3QsEnrgZbj2Wv2vzEOqyUf9EP12kdjGX0hnNsoMetrvsToj+r7QgIXug3quW+1SZTaaX+yQwLvgqv+azNwhUimkpsnrYtId+lw1CoiA7ZSl6Ic0JZwWX/RwdflWj1NS2LaXCZH2zmu747qtdO2SEM7S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=fvbI6H5q; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="fvbI6H5q"
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 25D413F68F
	for <acpica-devel@lists.linux.dev>; Thu, 18 Apr 2024 14:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1713450030;
	bh=6MdH0R6Fh42BcaDDw8FV00JACUmgNVaSlcHYQMVpZWk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=fvbI6H5qEJyOKKXg7sMdwyQPj8Pgv4iI0ilE1qO82dS3NLZ2XpSkWx54aE5Sm1wwh
	 CB3WJHpsMQgwi0J3tejoQZBN1jjxZoKSfsNYMbr27uICGeNPvvW4JPXo9zOVf5gsYw
	 eyRYqYhx70tqGGf8nIGsObMKkyUM7k9z7knHs3UdsLTbwlnZmqC5D9oGlB7KvJv8Lf
	 sCcHI+U5QK8eZu17sBn0DjuB1IIuEMSY1kPKQWiu0ENJWCsesAB5hykLd4rAELmVox
	 0YYN+xKE8werAeh+OJUR0hB6YRRq8X8wUOQi+/QzQyy4FgRDziNpwmRB2Kd0nWJtGI
	 rNZOqDfGkKf8A==
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4183d08093bso5594935e9.1
        for <acpica-devel@lists.linux.dev>; Thu, 18 Apr 2024 07:20:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713450030; x=1714054830;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6MdH0R6Fh42BcaDDw8FV00JACUmgNVaSlcHYQMVpZWk=;
        b=JKdzDhcyrrwJr7+K4BfdRmZwLNIrR/uKmux2+3AWqvp1PpWxoSj21k79cA1loRfaek
         LkovvxF+em525xcH9Y+8SuzzF6K+s4pFpPJiZtiwLq8NM7oxyx5+xXKWqdposV5J5c/W
         T7UBqNu6vOTS4XmSDJ0BHlaBKm3jm6Btm/TtXcAdjrPWhhgKoYqEat+O9sgcrABmomQz
         OzjBA0ezej6GWDck28hiIq+/lRyRVuHOP0tMmtKz7MgKRegHv3eRzwUcRFv0/b3Zm5Ia
         tdJyP9JowcRm9DPe6xgXSQ7gMS+8oM331qQquf5eEzZPqwP3/Wf3/F2gj1Z+IncGRUYa
         MDnw==
X-Forwarded-Encrypted: i=1; AJvYcCUNWVsF8TIMmLE8XgBylSIKNkrlx23HfP4etxjgHfrUvoZiFA8V28h9XYfUMX/PP1srb8b9cN4wPGz7e85iD7RRTkiMDW2dV/MQMN9A
X-Gm-Message-State: AOJu0YzJKkjPh9NLhuEzNyXmqiXrYPm2h1IsSaJF1PFAJAnuahC5y2Fg
	qQtJRER1M8xEACtheloe4pW6KwT87rCAstgmsJUV++WHPQW8DJEwtzIMy3JjVw4cJmYaqCASR7z
	IPgz6gBYJ0LzevqUFthg9bk7giLSJ9maqlKzB08g/c9o/5LIrcARTCwZCXML4x0sAoeGuX4Asm+
	rq8Q==
X-Received: by 2002:a05:600c:4e87:b0:418:d077:2cbd with SMTP id f7-20020a05600c4e8700b00418d0772cbdmr2340907wmq.40.1713450029748;
        Thu, 18 Apr 2024 07:20:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFT2UI5195uUHY+LxtGsmAza41kuNxu3PsqfU28U6vm2gIhE1ZKzhOvItctvv3fW1IYrvOjmg==
X-Received: by 2002:a05:600c:4e87:b0:418:d077:2cbd with SMTP id f7-20020a05600c4e8700b00418d0772cbdmr2340875wmq.40.1713450029353;
        Thu, 18 Apr 2024 07:20:29 -0700 (PDT)
Received: from [192.168.123.126] (ip-062-143-245-032.um16.pools.vodafone-ip.de. [62.143.245.32])
        by smtp.gmail.com with ESMTPSA id u17-20020a05600c19d100b00416b163e52bsm6658726wmq.14.2024.04.18.07.20.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Apr 2024 07:20:28 -0700 (PDT)
Message-ID: <ef065a0e-1996-4ca2-b6f0-3a152edd3540@canonical.com>
Date: Thu, 18 Apr 2024 16:20:26 +0200
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 00/20] RISC-V: ACPI: Add external interrupt
 controller support
To: Sunil V L <sunilvl@ventanamicro.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
 linux-pci@vger.kernel.org, acpica-devel@lists.linux.dev,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Anup Patel <anup@brainfault.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Samuel Holland <samuel.holland@sifive.com>,
 Robert Moore <robert.moore@intel.com>, Haibo1 Xu <haibo1.xu@intel.com>,
 Conor Dooley <conor.dooley@microchip.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 Atish Kumar Patra <atishp@rivosinc.com>,
 Andrei Warkentin <andrei.warkentin@intel.com>, Marc Zyngier
 <maz@kernel.org>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
References: <20240415170113.662318-1-sunilvl@ventanamicro.com>
 <87a5lqsrvh.fsf@all.your.base.are.belong.to.us>
 <ZiEnHtWbT04bXYmP@sunil-laptop>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <ZiEnHtWbT04bXYmP@sunil-laptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 18.04.24 15:58, Sunil V L wrote:
> Hi Björn,
> 
> This is cool!. I was not aware that u-boot also supports ACPI on
> RISC-V. Many thanks!
> 
> Thanks,
> Sunil

For RISC-V and ARM we have

* pass-through for QEMU ACPI tables
* pass-through for QEMU SMBIOS tables
* generation of SMBIOS tables

Generation of ACPI tables in U-Boot has up now only been implemented for 
x86 but would be feasible for RISC-V boards too.

Cf. https://docs.u-boot.org/en/latest/board/emulation/acpi.html

Best regards

Heinrich
