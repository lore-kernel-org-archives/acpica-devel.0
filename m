Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66CE1B4247
	for <acpica-devel@lists.linux.dev>; Thu, 17 Jul 2025 16:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752768404; cv=none; b=KI/auliIWw6OcACku5XI17enUKXZBiXgcIR+4NpA8yU2HK0uZLIOTD15heGssqJptj9aazRYlDHIRF4juf6NiAvDtagiq0smrrAKz/BnTWoYvqHIUxX2xwtoVR9PQr9XERa36u4E9p1b2cK/Id5qyFNWN8S2L+sTHE45iQZAIbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752768404; c=relaxed/simple;
	bh=AgSkia3vyN3wnXwEIc2WQexJs6VG3jfaUgZku52mIf8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eUQct9SdKimCgVLfJkewAC4PYdXmySqZn+Uzf+xcwQrrC74K0COASbIGDoeEEAC5iTqItZlBJqEEq1HSuv/YYPD+8GUPTkPOkGAzcTOqTRFexY6iooKfG5nTejktGbfRZ54wWCZqdtCntIFKN3Yichvqx5DsphpUORq3uBR5xTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6097d144923so2587675a12.1
        for <acpica-devel@lists.linux.dev>; Thu, 17 Jul 2025 09:06:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752768401; x=1753373201;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aRcpIrg/I+WIhRSf3upIuAZZeP3ZmwXXMCGjj+mtbZM=;
        b=ZeAUZtg0C+OjlpL20/pA6KrdPb42WEnMDz1cxK98Ju7y+2nKGnSHIu7LBpnPT6Cb8Z
         9r/HMYp5gpyDZNJP9vVLh83QUwat0NDykUwpuE22/VY63xBZLfI5hD1nW2jAi5aDIdwh
         VoXAD+JDwI0g5jps60yPRKFwHridd6qqnfK2keRJ43Sl9BNMkPzrRLcdNW3V05wsv0uH
         3wUkVyu5NVF7lH1iqQcXSJpqfZvLIf0x0OGIQrdyUMjksGH4lbg1HRinVOmt0Gn20I1O
         oI4+HZ0BCTvCA3N7hAkRSD9idds7Uf8XKsIHPaxYLIZJMMMSzcUrTYAQDlHxPLJ+m7rJ
         54lA==
X-Forwarded-Encrypted: i=1; AJvYcCWtROlrSVAGmhe171iSHNKB9zo0cewibnBLg+YLmvaNxfd9sgFuytLmhT+kTq14Q69GMGoCMjOfxZSwpwY=@lists.linux.dev
X-Gm-Message-State: AOJu0YxLApChBeRxciROa2ttljSOfSiBB3TIbYsDUPxZjN5E9nGafQS1
	YAtBWjIjKyy2Um4UIIEcra5+7r928H1/Vb11CaCL1In1bUQ3qt/I37z6NaHeWw==
X-Gm-Gg: ASbGncty6+l2xzvat7Q1K/5zTDNONSLKLvK5tAqyfjtISyp30k56P6i82vH3IztcK0z
	62ECfcUkPiT4iR3NSDxvos3CLMlStoznF50vL4ST7zzSvF3HD3wcLvotwmeM0qGiE+SRJmmg/s4
	VR4jXh1Daq9f59YLyoCU8UXtCc7uik4Un39lHFP6lNrrv8tptA/BUHgWoSKcy5FnB1wW3FSi1Dw
	J0B+LuqLowoQDNG1b43uOr+5yoE8LI1akmaemFROgcE60bNudbXr1CyDcp+gl2bQNOXs86kXlKw
	HsErf0TKQXjDGrXwR4xor7yACwxIcCf8kVuOuyzYQm9W2vPh0Qa7F8lO3FdF0wj5IWZRp5zB+iJ
	Ok6Ur/1svdJhWeA==
X-Google-Smtp-Source: AGHT+IFq+k4Lvk3YRgJ1AfwiC7Wnf6Jw82TtR1rviO/WaXX+XGf2dqe7+UYRpt7NBzp2yANpROMWRg==
X-Received: by 2002:a05:6402:34d3:b0:60c:679e:b957 with SMTP id 4fb4d7f45d1cf-612c01c2de9mr484303a12.1.1752768400806;
        Thu, 17 Jul 2025 09:06:40 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:70::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-611f7365c7bsm8670852a12.62.2025.07.17.09.06.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 09:06:40 -0700 (PDT)
Date: Thu, 17 Jul 2025 09:06:38 -0700
From: Breno Leitao <leitao@debian.org>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Borislav Petkov <bp@alien8.de>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, James Morse <james.morse@arm.com>, 
	"Moore, Robert" <robert.moore@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "acpica-devel@lists.linux.dev" <acpica-devel@lists.linux.dev>, 
	"kernel-team@meta.com" <kernel-team@meta.com>
Subject: Re: [PATCH] ghes: Track number of recovered hardware errors
Message-ID: <kw7mwmca3ir4nfyofumqiack5sht3aisdchevykdtmlio6xo7z@5xbdibpqvqix>
References: <20250714-vmcore_hw_error-v1-1-8cf45edb6334@debian.org>
 <20250714171040.GOaHU6EKH2xxSZFnZd@fat_crate.local>
 <SJ1PR11MB6083C38E6DA922E05E1748D6FC54A@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20250714173556.GQaHU__LL6IUIPCDIW@fat_crate.local>
 <aHWC-J851eaHa_Au@agluck-desk3>
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aHWC-J851eaHa_Au@agluck-desk3>

Hello Tony,

On Mon, Jul 14, 2025 at 03:21:44PM -0700, Luck, Tony wrote:

> > But for some reason Breno still wants that info somewhere else.
> 
> So what about something like:

This is a way better suggestion than what I propose and it seems that
Shuai also liked it.

That said, I am playing with it and it is looking promissing. I liked
Borislav idea of having an always-present array and use your error
sources to index the array.

> static struct recovered_error_info {
> 	int	num_recovered_errors;
> 	time64_t	last_recovered_error_timestamp;
> } recovered_error_info[ERR_NUM_SOURCES];

I know naming is hard. Playing with it, I thought about the
hwerror_tracking as the "name" for this feature. Does it sound ok?

> void log_recovered_error(enum recovered_error_sources src)
> {
> 	recovered_error_info[src].num_recovered_errors++;
> 	recovered_error_info[src].last_recovered_error_timestamp =
> 		ktime_get_real_seconds();
> }
> EXPORT_SYMBOL_GPL(log_recovered_error);

Where do you think this code should be? I suppose we have a few options:

  1) Maybe a driver called hwerror_tracking in drivers/ directory
    - Pro: Code is self-contained
    - Cons: This will require a CONFIG_HWERROR_TRACKING, around. Also
      it will create some inter dependency of drivers.
  
  2) A hwerror_tracking.c error in kernel/ and have it always enabled
    - Pro: This is always available, and doesn't depend on the CONFIG dance
    - Cons: There is no way to disable it (?)
  
  3) In some pre-existing file.

Any opinion about it?
Thanks
--breno

