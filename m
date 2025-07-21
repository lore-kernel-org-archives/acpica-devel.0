Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1F8A94A
	for <acpica-devel@lists.linux.dev>; Mon, 21 Jul 2025 08:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753088169; cv=none; b=rASc49Q1WuWePFSKUct34Wbx3Rni6f0e3ZLkh9ZbGeNwyLy//7WHhNbEM1gQejqBTlbGhLmBAL32xNdvQiqybY7XJPw3SmA5oKZvn9oFItRyssxhrQL+XHDyjADTQMRukUztBTFg0akrWflaqpx7mbejV+/55qtIxBLwqzVPzIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753088169; c=relaxed/simple;
	bh=0Bp5A4Zfdt7s/FUBElE0pEEWRbgwFWQteCgTYa+GP/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eNwbWIeRkHosyTmXAIa04uYztGpYhmqL5BeUHCGvMBBPd8UKOSi191aAfSHADvkY2HA4oHGFYYUPYfJmdKEV5n5W7flaQp8yXqnWqstU7HEsGYAbb+kF2YyDiFIhfk7NBj65ytvO7XwXat0/VSOUApto20LLcVpBKuCD4ZnQsfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-607ec30df2bso7875808a12.1
        for <acpica-devel@lists.linux.dev>; Mon, 21 Jul 2025 01:56:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753088167; x=1753692967;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7a+mMHsMlXSHJfvHPELmbgN6W6iJdxKKlOu5d6bzUb0=;
        b=hjOHqxkEmba/r5SLOLUJIL37gnHPoJFt1HHCshH5bojNUxEok/s5XrdbtSaADpjNWP
         V8RTy4VkgNMxAFKK7TpOIKcJoidkNxXp1nfK1TPSpb1PXR+BZsXDTg68ljTzfoVC8oWm
         v7mkkkdpHj7dxt1zBtYMCJvV87nHSOh1jwr1bhGWQMY+7kjSspHQ7a02Xm4+DS2jYVam
         MqdiaYixd6j8Gb9LJFM2Ya9b0KmS3QZIAREc8pf5LaeBy4wC87S1gjIeimNluRFSFhTD
         fO8XnjqEswTXVPGzoSPqf/DRdxZW80PsrTi9W4J32Ua1E7A9lMocn1Iz3rM9WShouWBX
         y4aA==
X-Forwarded-Encrypted: i=1; AJvYcCU6vFNyaGKToF0SJhjz9A7Rg32tVuL8kB5fTS9SY3F6jZkPQ5U72BL0pnnyR+ZtXFiHq0IOPoQcvb8dfh4=@lists.linux.dev
X-Gm-Message-State: AOJu0YyM/xvNfS0S+O2SFT2HEXFv0wgFSplDXJ/h59IbAQEt3K3nOYbA
	C1p5NQdlZXr9ZfbqrULiyn0JboNFMvQ1cunh7WJwM92ea5aQcbCXRagy
X-Gm-Gg: ASbGncsdP80qb/hxEKr5m7vgvrFGjROJj4R39iZz52k4KR1Y6StoxTvXzHUm0XH7N3S
	b3YhCk618NOhWhuDKHgyhtOWoMWN+rHINcv4ClVNyoS1etu6WO4hCtOnOIAf5jurRz4qdyKi4TR
	+DcMukj+mrtcydK3EyIjhqFuOcJ2TdgKy7h5gTIGWE1KOgGtvJ6aaeQin7pwR9CzFB+gmPX2Gd5
	jI5FMy6IZPUIYXjX+P5UuzBwpljXhsiJGKxYm1J1euzHW9ozC3KR4fhTt68Z8XPpWNdNpmQ6389
	Kef1Oq1UWLmZIDM0w/DdLICy+2gi+BOXpi5iilM2Q9wa63stmrKdi/ywY9+WXIGkyerKr4jKlb+
	+i1H9FSXkiLV92Q==
X-Google-Smtp-Source: AGHT+IEO4SybCFLnv0FdYsHmbgrbP3TZ+2cOjGcDGUgtwCXqHHCS19zQvONNtXYlZVgWK8Y/lPeVZg==
X-Received: by 2002:a17:906:8c2:b0:ae3:f3c1:a5dd with SMTP id a640c23a62f3a-aec4fca259amr1202375766b.61.1753088166300;
        Mon, 21 Jul 2025 01:56:06 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:74::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aec6c79e16esm636036866b.15.2025.07.21.01.56.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 01:56:05 -0700 (PDT)
Date: Mon, 21 Jul 2025 01:56:03 -0700
From: Breno Leitao <leitao@debian.org>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: "xueshuai@linux.alibaba.com" <xueshuai@linux.alibaba.com>, 
	"mahesh@linux.ibm.com" <mahesh@linux.ibm.com>, "oohall@gmail.com" <oohall@gmail.com>, 
	Borislav Petkov <bp@alien8.de>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Len Brown <lenb@kernel.org>, James Morse <james.morse@arm.com>, 
	"Moore, Robert" <robert.moore@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "acpica-devel@lists.linux.dev" <acpica-devel@lists.linux.dev>, 
	"kernel-team@meta.com" <kernel-team@meta.com>, "osandov@osandov.com" <osandov@osandov.com>, 
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH] ghes: Track number of recovered hardware errors
Message-ID: <yk7ocbvfb7hswfdi2bft6lkatonn2ulu34kz44hypjwdagzeos@g6lmdncwrqhl>
References: <20250714-vmcore_hw_error-v1-1-8cf45edb6334@debian.org>
 <20250714171040.GOaHU6EKH2xxSZFnZd@fat_crate.local>
 <SJ1PR11MB6083C38E6DA922E05E1748D6FC54A@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20250714173556.GQaHU__LL6IUIPCDIW@fat_crate.local>
 <aHWC-J851eaHa_Au@agluck-desk3>
 <kw7mwmca3ir4nfyofumqiack5sht3aisdchevykdtmlio6xo7z@5xbdibpqvqix>
 <SJ1PR11MB6083CEAB23FCE85937DC5403FC51A@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <mazejvrglvtqdfsevduahqxvlvjv6hlo3apivossn2jnxpsuds@os6kxmmsq3xt>
 <SJ1PR11MB6083D08A2F94FAEE5261AA6CFC50A@SJ1PR11MB6083.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SJ1PR11MB6083D08A2F94FAEE5261AA6CFC50A@SJ1PR11MB6083.namprd11.prod.outlook.com>

Hello Tony,

On Fri, Jul 18, 2025 at 05:36:50PM +0000, Luck, Tony wrote:
> > I found that I don't need to expose the metrics in vmcore info at all to
> > be able to read them from vmcore, given crash/drgn can read those
> > symbols.
> >
> > Global variable hwerror_tracking will be write-only during kernel
> > run-time, and only read during post morten analyzes. I am still not sure
> > if the compiler might not get rid of them completely, given no on reads.
> > I am wondering if I should EXPORT_SYMBOL_GPL(hwerror_tracking) to avoid
> > any optimization there.
> 
> Thanks for fleshing this out into a patch. It looks very much like I
> imagined.
> 
> I'd be amazed if a compiler did elide all this code and data because it
> noticed it was written but never read.
> 
> Is the spinlock when logging really helping anything? You weren't
> worried about locking/atomics in your original patch because users
> mostly care about zero vs. non-zero (or maybe vs. "many"). If the
> count is slightly off when many logs happen, it may not matter.
> 
> The spinlock doesn't help with the timestamp part at all.

Agree, precise number is not important there, and if there are
conflicts, it will not hurt the message.

Let me remove the spinlock completely them and send a new version.

Thanks for your support,
--breno
