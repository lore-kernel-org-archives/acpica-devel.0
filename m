Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E044726E6F1
	for <acpica-devel@lists.linux.dev>; Tue, 15 Jul 2025 10:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752574841; cv=none; b=njZFk88Tl2JLoSg74H5O6PIGEEXIDuF7DF8W0WkQlLFgE3bcwzUddzwRcoqcHGz09L62GoRbYTlZT9ZFy6rXrF1W0t4AnBpyzHEu0AjE8CqLpuagL8Gm2sceDdu7pb5ibb37/iEuJ58q3PQh3gIMPFzlklREVNoA/QKxQp3eIWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752574841; c=relaxed/simple;
	bh=yd41TFE712Y/bFRqCxiGmx0ghvtl3Xu3zBj9HG9TbaY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pBj0+GuMzHj+GqaZ210HjSumOWUHVvEFNKyRoEXgwaSPAMqa7bqqF1gDWwXPSi3kJKX/i1CW+yCZZ72gO24V4t5N5l6UCmyYtxatsa7g8rx9ZGH2REExPvYbH2t3E9Q2oN4WfcZP011GKqcxVo5+LM5yo4Xxe5fHNsjJva/IhF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-60c01b983b6so1749495a12.0
        for <acpica-devel@lists.linux.dev>; Tue, 15 Jul 2025 03:20:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752574838; x=1753179638;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YdbUlKo89GUT2GFFy0xJ3nknbIlOKbofILyfW59SRy0=;
        b=bkztL5ZaNxgkFTk7EpN1Ary3592pLzhtm2rFmrR1vg7RegnKXWFjF2RssP2U7J9beJ
         1RrjEToQcH6ivC0Hc2dzgknWMyygFLauqNoPR2fHErWD1lSfpCZpeziEBP6bA3tAg45T
         LEyD4h5UkunkJnLZMvi+HZMLVEaOvJgwSvFGc9pI7FvcpVH41JWdZc+ewn7SuJTQ42u1
         7/JzUsn6bJZ7xt1eF78UX4wK+2apq7bewI16iE2ZzUPSobz/4Hx5VmodBMLYl6lo2+K7
         h9Y8tqx7UMf3E8JhKuD9qww7BofHSP7EsoUR7CWbqWcvpN81/CkguulsqAUnxn6X4jyN
         /h/g==
X-Forwarded-Encrypted: i=1; AJvYcCWWwcG+hZO/qYKuAYg+vPqPDFTlRJl8zkQ7lDjXzCXnxgYHMnRg0hFtA+BglsTa0GPkKb40FwMvd8aNSjM=@lists.linux.dev
X-Gm-Message-State: AOJu0YzOOY9SAIG4Y7ijs651nsU+3rwN3TQJ1Tvpv8EnxuITiAK4a9NE
	JN8MOuBwmT03MypZN0ZRWyE80fCFD46kTsf5BYifzTgzL8Mav4bQLvsW
X-Gm-Gg: ASbGncvky73gWVUt+8DSfUkSRO4baf9s6J2QRT+pCAGztoVMu/PtKzdhA4dWNwGjDRA
	0bHBXbaan6mKpj3Z+uqguzmP2EKWeWyQ0ueyVsHhe37Qisv8ejoD4VX17t1Q/q4x14ny11q6bWz
	cuystPeOJASh0XJKv1Z+NAFZCfkNHj3pV2+2z6eWipzqslKynfutlTXrryrci46hA9kuQcNS+Qj
	aFeuS+4nTzRxwSWwIiip2xdF5aGT+Mg/RScbLEqY+nWgHQLnkpgP6AVkVKw5VXCoi4wKw7tixby
	7X3L4zPTYlrSt7JW6pk8ZGSZkS/xFYhgOncOdaaA9agVPDY/+udaLrvk3rPTiRwfzYiBSISCPoF
	D2f3wsULwPnrwp1ua+P4r
X-Google-Smtp-Source: AGHT+IGS6mBNikdxOB0R7A3Wc1cgRVtqHvOiuCHl17RaVwd6varOAGIQu/ykD7SPjndmuYx4FDWTOw==
X-Received: by 2002:a05:6402:40d6:b0:600:129:444e with SMTP id 4fb4d7f45d1cf-6126648d8e3mr2488643a12.4.1752574837792;
        Tue, 15 Jul 2025 03:20:37 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-611c94f4587sm7018897a12.5.2025.07.15.03.20.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 03:20:37 -0700 (PDT)
Date: Tue, 15 Jul 2025 03:20:35 -0700
From: Breno Leitao <leitao@debian.org>
To: Borislav Petkov <bp@alien8.de>
Cc: "Luck, Tony" <tony.luck@intel.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, James Morse <james.morse@arm.com>, 
	"Moore, Robert" <robert.moore@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "acpica-devel@lists.linux.dev" <acpica-devel@lists.linux.dev>, 
	"kernel-team@meta.com" <kernel-team@meta.com>
Subject: Re: [PATCH] ghes: Track number of recovered hardware errors
Message-ID: <kyprjdilgyz3xgw3slnrsemptnpp6h75mipv6a3lgp2dmwqekg@s7azbepy7nu2>
References: <20250714-vmcore_hw_error-v1-1-8cf45edb6334@debian.org>
 <20250714171040.GOaHU6EKH2xxSZFnZd@fat_crate.local>
 <SJ1PR11MB6083C38E6DA922E05E1748D6FC54A@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20250714173556.GQaHU__LL6IUIPCDIW@fat_crate.local>
 <aHWC-J851eaHa_Au@agluck-desk3>
 <20250715082939.GAaHYRc3Yn49jyvYzc@fat_crate.local>
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250715082939.GAaHYRc3Yn49jyvYzc@fat_crate.local>

Hello Borislav,

On Tue, Jul 15, 2025 at 10:29:39AM +0200, Borislav Petkov wrote:
> We have all of that info in rasdaemon. If the machine explodes, one can simply
> read out its database from the core file. 
> 
> And if you don't run rasdaemon, you can read out dmesg from the vmcore where
> the errors should have been dumped anyway.

I approach this from a slightly different perspective, given my
experience overseeing millions of servers and having to diagnose kernel
problems across such a massive fleet.

To be candid, when you’re operating at that scale, kernel crashes and
hardware errors are unfortunately a common occurrence.

For instance, If every investigation (as you suggested above) take just
a couple of minutes, there simply wouldn’t be enough hours in the day,
even working 24x7, to keep up with the volume.

Thanks for the review and suggestions,
--breno
