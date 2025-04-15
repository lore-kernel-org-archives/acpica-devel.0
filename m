Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1892DFA5E
	for <acpica-devel@lists.linux.dev>; Tue, 15 Apr 2025 20:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744749043; cv=none; b=eCGgu6FpgtvssebRRpHH7GqHLSnaPC/+s+TS+I08lq2hQ3wlDJsWjJ1bM6CTV+QdeP+ysS/QzLSWLpI1oxv0VoDNyN8TzOhSxrd6KxM1T2eW8izx2KoviUyjcQa/P4To5jMFEN5PRnmxOB9D5T5XZ6TbIbJ0JgybvpcaUaE7HyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744749043; c=relaxed/simple;
	bh=wCxBeybE6qJRE3pXHWxqErGRwtA/zocP0Tj2YURCkZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DyrREKbzJnlyst3V8+Ri8plLYn0WU3vwjdWkvX3sjm4/3WVzxjXHaQ81UrmQYlj+pFK4VMd59f+G1w1IMPhNxQi16tJxfcRqrGVA/LXdxY7LhGw1KBysleGasmsE61vyVkCHvkeKn65UhZF23MQB2EwVCt/N6vxb+QkWLxg0q58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bsIM1+Lb; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bsIM1+Lb"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ac7bd86f637so8077166b.1
        for <acpica-devel@lists.linux.dev>; Tue, 15 Apr 2025 13:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744749039; x=1745353839; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2EnaYYq5VpNpfq3jhDm3c5QMz4PJIrMHZNekW0Qvzd4=;
        b=bsIM1+LbDZdWUAYvpvHoNoSmcUgm46HFHUqZYXLjnT0GD35Oln+PlDVXtuuFeEEJYw
         4vM5KmzAF/aLg6y75IBDOB25px1X/flPDj1DQ4CSdEwDmchYjISe5s579iBt6KmB0CO4
         /icocF+QhyMdlxH/UQpspjiCSX2+EZ73Jf/Ar89shH+IPk2ZupfnU9BSFoDvXeVdwsOl
         n3wmFQbh5Y3/yRiagrWP0fkF9naOPD915DIjUUVPrQV8q8yVkc51Ls7B9Pjvn624aGdr
         Qq0xWPwgeUuicY94SV3qYZBGv05eN8i1veF0yafzEoRKB/SAEXtKLKvetKEJ4HXhtcij
         35BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744749039; x=1745353839;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2EnaYYq5VpNpfq3jhDm3c5QMz4PJIrMHZNekW0Qvzd4=;
        b=wK24Ab1JUkiDshh5HpZ82amANz127oJM94BDcGcLZmTDGdDW6HGrjvVCoEZ7b6sh4N
         NzN8vUIAwiRAAC7xeIaCIJHX+0xm9ktFvWSiP9L4DUfBSQ94jZj08Jcd64GyOQSkmpRO
         Sim0Bep8tNDncT0Ht/t3TdRq7FOkWqyuZdBwwzATLer6ZtsP50XtwARzCwpG0hbW33re
         RZEc4PYHOjYjrm2MtkqAiviTPTSKiJLuxH30RJJT9lhUae3FivfySYsqIgvhlgkzCK+2
         pdHDs/I+AL9ioKXlwdq2pZjsaTW8ZoDUkaXaz0n2r/eEZCeyJodHv1Z8IMKamx8De7Ht
         bkNA==
X-Forwarded-Encrypted: i=1; AJvYcCUY78EyCDOgdbubTkRiv3idGTROfIxYqsUGuEDk+3gcQD/SVxLd9jyQ8DI1khxzKiCQ2G7MYxtRE6hGqS0=@lists.linux.dev
X-Gm-Message-State: AOJu0Yyok+LUYsUADv/D0ViH7Z/EQ5tY8BSVtMPgq7FpyVgbzWCfe2gf
	e0kRBpApS+FKBc5BKsvkONy1qDwrJ5b8QNuMtb1G16VwOOOEadJq
X-Gm-Gg: ASbGncuvRvkI5kqs3mpfz+qrjiH5WEYgGeKizm6OHJRAvaZFjTLy/nOWYAJBqz0oIFP
	3y+56Ss7fZtT8qSU+wiR3E7+zGIyI0wyj69w8mcSRgwdH5csjct3kx71A9d1uA4NIRWRI+KHCMQ
	5Rnj28KOw440mMCFvo7UU0XdAAAIi72ZLfpnzYpw4QXReqnCHII9CEKetMYbE4NXU2NdgN5G8SZ
	ZUs+mvh2PuAcbgEJm7yEMElIMp/C46ROKMPBlY6CXzTyWthHq3yYf+VhaZc5D/HQseuUFMdabP1
	nS6Nrs8bqpmb/rtMJ2Ce0jNc6mJr+WowEkd53S5Vi1Nu
X-Google-Smtp-Source: AGHT+IFpMejbMKxwYVP3ClTbtsxDAvjUr56x/paNPdsUiAiUOxhFmTaY2rFqndunam8jIBSsD9BHVQ==
X-Received: by 2002:a17:907:3f99:b0:aca:aeb4:938e with SMTP id a640c23a62f3a-acb357fd0f8mr75255766b.8.1744749038369;
        Tue, 15 Apr 2025 13:30:38 -0700 (PDT)
Received: from gmail.com ([103.210.134.105])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acaa1bed98esm1149894366b.72.2025.04.15.13.30.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 13:30:38 -0700 (PDT)
Date: Wed, 16 Apr 2025 02:00:26 +0530
From: Brahmajit <brahmajit.xyz@gmail.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: Robert Moore <robert.moore@intel.com>, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, 
	acpica-devel@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] ACPI: Fix building with GCC 15
Message-ID: <gwmtns3c6lxgsxtbit2vwjr64yqlp3wlmvj4p3o6oqi34bng5h@tenldomcival>
References: <20250414161644.30400-1-listout@listout.xyz>
 <20250415190457.351e22a1@pumpkin>
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250415190457.351e22a1@pumpkin>

On 15.04.2025 19:04, David Laight wrote:
> 
> Doesn't than generate an 'unknown attribute' error on older compilers?
> 
> Does:
> 	typedef char char_nonstring __attribute__((nonstring));
> 	char_nonstring name[4] = "abcd";
> work?
> 
> If so the attribute could even be applied to 'u8'.
> 
> 	David

David, what if I used the __nonstring attribute from
include/linux/compiler_attributes.h which defines the following

#if __has_attribute(__nonstring__)
# define __nonstring                    __attribute__((__nonstring__))
#else
# define __nonstring
#endif

Which I came across from
https://www.kernel.org/doc/html/latest/process/programming-language.html#attributes
Also the checkpatch.pl scripts suggests using that instead.

I guess this would work from older compilers as well.

-- 
Regards,
listout
