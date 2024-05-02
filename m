Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A431557877
	for <acpica-devel@lists.linux.dev>; Thu,  2 May 2024 10:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714644162; cv=none; b=X/5Qil6JS1amOKhQif/ZHWeADlvBjTja3dMD3DM6iv5fERg8JJSLpzPjUSOnpBwvKHW9c4mio4oMG5warYZPo3GRhlKSwdmjwZPuaFbpXvkc8tEdjc0BP5GMp3lP30WJmv5bdTFiyEIzpSsETZQjAkZcZR80vrF2cFDZQC9T+ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714644162; c=relaxed/simple;
	bh=Jyakk2Re/yXumSvffFIqIAQUyky6V4gBP2YcQa+LJI8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gHGcNltu2y/fu+ryPutdOcpbuiSdU2JnBCWFbFZ0Pw0ht14BoPnq7/dYOx97LEVgKv/7IT+4NlVs6+PKwFNzEVGH+7q2acsi7qnAazys967uvMfY7w8gdL4mfLhl2OWvVhRkX+1GlmVtge4yqFL2YRlMrihUmkZjdbn9qTZ3F58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=djAC9vWI; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="djAC9vWI"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1ecd3867556so7506665ad.0
        for <acpica-devel@lists.linux.dev>; Thu, 02 May 2024 03:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1714644160; x=1715248960; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+kMTT3PzTLyPVaeH+DM1bYJEhGQDgrI4wH+0p7ikXNM=;
        b=djAC9vWI0LQw/HZ9z2aCJYSLj/Q4x3mnU1pOyhOqUXttqI6myA/AIcM8lc+HWU2tBw
         dsOIawzzlEQJaw0XK/kVWqeSIq5Wn3EUzqgdNGeIlfquYkDe4+7UW1ifkf0W/tJVvzd0
         WyMWkfwstTe8NZtCFCTnmSxUokgsMg6m6eP8hSdMH/OhNQIZyXRWdDqXHuBMMbNl0FzB
         t1CeuJ4quYWVbrWr1rBvGciLqMUrCGKaSgDsFiDyoOd1iIsJsdv1vAQd+tRdkHKhmg4t
         eXBdgUicb3uuBKz+SWXE+ERYJMAYDRPM0XsINdC1kLh+Uv4c/piH7DLu2g9hNpcxpMMi
         UV2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714644160; x=1715248960;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+kMTT3PzTLyPVaeH+DM1bYJEhGQDgrI4wH+0p7ikXNM=;
        b=Ry7cdxKoVGs/evvqxU6pcZd8bztaXvPEZ6Qdd1ON+2ZKTs8z7elVohf/ApW8SpjP3G
         wHimeVT7gqwzej3ew3HoFRuToO4MuJ/kxQ3+4BQaUM6AlGyvBTCe6WpLnODeXCblnTDG
         9WSIkZgfsbIrGpgDn4CYVHHlCpYDfAHaqMjBJO+vmE7bUoh/SZatmtMcIxiGmoS8ZmMj
         rxf7j2RfQHbOf1hqvxpk1yYrPg8tcBdBON5+wWniMmUEWKs6sr5ZN6GFIz7nrq1Xum6r
         DIPNuQ9tJLnUawZO/zdAcfhEWeOuY2Mls3tjqog5zaS10mB7FQrVuYzJcY73R7BKaGWq
         nwog==
X-Forwarded-Encrypted: i=1; AJvYcCXbA3+A0aSl9Ii18TUbXlc3DJ4WM9eeDqrDgVW4gkluaFyfNzZ69AWkYAwDfIyx1OHaklkM2XWBMD4KRm3lyqdf7hDE3jW7gpUh4qEp
X-Gm-Message-State: AOJu0YzZFUEf6NkxkVatkflW2qPYg32Z+zKXetCwiji6EHub9wsvxBm2
	mirxOJ758mpi0M8XQs52Rylab3+pZqF7c58PIEqGDwt7HAq1v2fEtkMAhXBsQck=
X-Google-Smtp-Source: AGHT+IFMGhdu0SIDQn/0fGRllf2r0ZaqwxTF1S1fhXPFoF9kfSM7pOtZuP9eC/v0lBtCNsAcHvZnOg==
X-Received: by 2002:a17:902:ce8e:b0:1eb:5323:c320 with SMTP id f14-20020a170902ce8e00b001eb5323c320mr7103763plg.56.1714644157999;
        Thu, 02 May 2024 03:02:37 -0700 (PDT)
Received: from sunil-laptop ([106.51.190.19])
        by smtp.gmail.com with ESMTPSA id u9-20020a1709026e0900b001e604438791sm896026plk.156.2024.05.02.03.02.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 03:02:37 -0700 (PDT)
Date: Thu, 2 May 2024 15:32:25 +0530
From: Sunil V L <sunilvl@ventanamicro.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-serial@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Anup Patel <anup@brainfault.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Samuel Holland <samuel.holland@sifive.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Robert Moore <robert.moore@intel.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Marc Zyngier <maz@kernel.org>,
	Atish Kumar Patra <atishp@rivosinc.com>,
	Andrei Warkentin <andrei.warkentin@intel.com>,
	Haibo1 Xu <haibo1.xu@intel.com>,
	=?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Subject: Re: [PATCH v5 03/17] ACPI: bus: Add acpi_riscv_init function
Message-ID: <ZjNksbTQF1lMQ0k0@sunil-laptop>
References: <20240501121742.1215792-1-sunilvl@ventanamicro.com>
 <20240501121742.1215792-4-sunilvl@ventanamicro.com>
 <ZjNbvlUoCfa5UUHF@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjNbvlUoCfa5UUHF@smile.fi.intel.com>

On Thu, May 02, 2024 at 12:24:14PM +0300, Andy Shevchenko wrote:
> On Wed, May 01, 2024 at 05:47:28PM +0530, Sunil V L wrote:
> > Add a new function for RISC-V to do any architecture specific
> > initialization. This function will be used to create platform devices
> > like APLIC, PLIC, RISC-V IOMMU etc. This is similar to acpi_arm_init().
> 
> What is the special about this architecture that it requires a separate
> initialization that is _not_ going to be in other cases?
> Please, elaborate.
> 
This init function will be used to create GSI mapping structures and in
future may be others like iommu. Like I mentioned, ARM already has
similar function acpi_arm_init(). So, it is not new right?

Thanks,
Sunil
