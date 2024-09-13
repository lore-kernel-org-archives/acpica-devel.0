Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849654776E
	for <acpica-devel@lists.linux.dev>; Fri, 13 Sep 2024 15:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726242234; cv=none; b=AFo52hMNlLAuNOX8MPNmC+VH/ibmoTQ8j3AAoeSx/Zvn8NV/ZzjmV60qK0v2yosBzleKl/V7s/L+DwWfsVLiDe2YbXhGHc+9//wqkGhHUyIieFFBw+UKaXUqqFSAytj83kjV2Z9A+jiiOE5sbHs8St4hRTZSSRKszStx/GmOGoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726242234; c=relaxed/simple;
	bh=UgejVN/99nwt2N3xq1SPwRkr/wpZolJE3Mk9WmbBWgo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U+7MoHE88RuxbWiBrqWJMaH+vEtWwqL4+ory/jRds2WPCxJraa6wISzAShuPpisRBCNoM+mohVuS84HU7mMDOcYMTYb4goLPn3TteBFGMEMMObKlnb3Ope6L+P6jGH2w2mzzA4uH26SPZYMO9hv7syR4gY/jRmy66wUBAJhUHFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=d7lW/41V; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="d7lW/41V"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2f74e468baeso14752951fa.2
        for <acpica-devel@lists.linux.dev>; Fri, 13 Sep 2024 08:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1726242231; x=1726847031; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=d1zLfAygLCX5nindDhcisFbkr71lDlDKqH7T8AVgiyk=;
        b=d7lW/41VCf2BxkN/kGrDCTY/CMD/Me4LY95eNBkRIwKYN41VnvbhACcJ0ySDDP72Cr
         8630uni0yqOdk69dn8yb1nLhu6iE2Oky8uwN9btabema1XPduMHcXMWb9987CKd1WG9d
         yLxORKw75YcgPgiN/cov74i4pXQyGVx0/6vrL7RPMN3/6VrXgqoG69hWnIzHUid/CgSn
         RoGx4AK1P4mmZ8o1/M2sHvUBvUX01GyP+br0Bg9KNFjnYZ7ZxZpikTmIh876hEI784Gk
         KMRQbeJoL9sjUNdGuN1pO0N1mqueLlvTOf7Df8M232IOBuphdR7JL/CKjuVwyxS3nEMd
         cTeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726242231; x=1726847031;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d1zLfAygLCX5nindDhcisFbkr71lDlDKqH7T8AVgiyk=;
        b=pWIYgUF3b38oelygyElad4cbkzDtEJI1upllWvAf9GoyilxXx28UyZFHPcNixLaEGH
         AmY1w6yPpJF3ELRDbC18VH0oz+EofVQyPXkQiszxCqlI0YZMq4JUqrMeyYtDeaRLxi6r
         SYS/QWlc0v2uVAA6N+ossvHM6skG0+ufh4QtMBtm7rB3wM59gh/pDYRSVFcwaRJMuNWb
         l4wDRn7QdWuDxG+f+GmTZPsyQd9PrwANsIGvqYw57hKKgSowIIDqPsWR5gbPuQiaX3BG
         N0nA/96cuynA8r4Ujv3gcYT6QgyH+nYb7TL6bpVvSCxmIL8xyt9QEy0dpDuxOflKMa35
         szOA==
X-Forwarded-Encrypted: i=1; AJvYcCUaz0D8OP8NbK+q7b/ioj+t9XXwNgZdx4Rxd79evp2gLmexoRjoF58rmBev1+6t9PnihQTCLdLMaloewsY=@lists.linux.dev
X-Gm-Message-State: AOJu0YxXjhso61QbxUMGshYXPq5tHYQqHl5kGQAJCkkNcfDa/2Fndj/q
	vAQWPaZkO3Fvoz+ccdMYJWUPdbkN9Ghq3P5/wiSwR0V2wfFHhI1XUEr1+g3qvIw=
X-Google-Smtp-Source: AGHT+IHjEojEFl9I+KdlNdjvlxdqRp6uQW0BMPVHLr049XIwfxrFRE+znIjnvIhA2A3Ivu37qd1QSQ==
X-Received: by 2002:a05:651c:b0f:b0:2f7:5914:c22e with SMTP id 38308e7fff4ca-2f7918e09e0mr20801991fa.6.1726242230552;
        Fri, 13 Sep 2024 08:43:50 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c3ebd76efbsm7768944a12.67.2024.09.13.08.43.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 08:43:50 -0700 (PDT)
Date: Fri, 13 Sep 2024 17:43:48 +0200
From: Petr Mladek <pmladek@suse.com>
To: Raul E Rangel <rrangel@chromium.org>
Cc: linux-serial@vger.kernel.org, rafael.j.wysocki@intel.com,
	ribalda@chromium.org, Len Brown <lenb@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Robert Moore <robert.moore@intel.com>, acpica-devel@lists.linux.dev,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] ACPI: SPCR: Add support for rev 3
Message-ID: <ZuRdtFNjFr1_-VEw@pathway.suse.cz>
References: <20240912173901.3969597-1-rrangel@chromium.org>
 <20240912113616.3.I1b7a5033a2191cb0cdbadc2d51666a97f16cc663@changeid>
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240912113616.3.I1b7a5033a2191cb0cdbadc2d51666a97f16cc663@changeid>

On Thu 2024-09-12 11:36:21, Raul E Rangel wrote:
> Revision 3 supports specifying the UART input clock. This allows for
> proper computation of the UART divisor when the baud rate is specified.
> 
> The earlycon code can accept the following format (See `parse_options`
> in `earlycon.c`.):
> * <name>,io|mmio|mmio32|mmio32be,<addr>,<baud>,<uartclk>,<options>
> 
> This change makes it so the uartclk is passed along if it's defined in
> the SPCR table.
> 
> Booting with `earlycon` and a SPCR v3 table that has the uartclk and
> baud defined:
> [    0.028251] ACPI: SPCR: console: uart,mmio32,0xfedc9000,115200,48000000
> [    0.028267] earlycon: uart0 at MMIO32 0x00000000fedc9000 (options '115200,48000000')
> [    0.028272] printk: legacy bootconsole [uart0] enabled
> 
> Link: https://learn.microsoft.com/en-us/windows-hardware/drivers/serports/serial-port-console-redirection-table
> 
> Signed-off-by: Raul E Rangel <rrangel@chromium.org>

Looks good to me:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
