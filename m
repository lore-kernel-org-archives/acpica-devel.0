Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398156A02E
	for <acpica-devel@lists.linux.dev>; Wed, 20 Mar 2024 18:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710957679; cv=none; b=Amy1AfEhal0IVZkoBupM4wNVk0SIMToGtUmlsRc1tZyqGdhG5P+BsMaGxzuEeRbThFp0EZrDfhAesGqcbQoWN79LrL30Ndg1BycWagK6aG8ZJAkVbCJYMUGAZuY3tsYD8Q2vtFf04aJ/muhxS730iB+9uljnVNdlRpdZUHJs4wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710957679; c=relaxed/simple;
	bh=ymr1f2mMkgEncrgAlT2WiV0Xxzk7YqhUaIfael4pJrw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kDkw5yCizjGxSsnQsxVA+a5gmxl9mlhSOGtQqmzUVxCxIYLoPgJ87zhTJm7H+GT6OvS8bf7hpT4kDkK+/W0HrYOQHUJ9Ccoxhr0l4JbwaytnxNMwNhDVqY2+EAsZBBPk/42xo02QTbNRu4m0+EejuLdUMRwtu7sHAgECLMm+Q2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QS4bP8/p; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QS4bP8/p"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1def59b537cso413575ad.2
        for <acpica-devel@lists.linux.dev>; Wed, 20 Mar 2024 11:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710957677; x=1711562477; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j+EPj9HeAGH/gl0oSvfO1IUhtpAie7DUc9DIX8DS5vA=;
        b=QS4bP8/pPkKwk/KakHQy12U61gntoPffLfffza01vLeS6sDrhPHKj4b2NCbWL+/qIS
         10J/rhi4BT0livwtMGWtPEVEX6ecBLGHWRWnC0giXxOwUjf9pJDOrFuzIvAtdVJFJw7q
         QySvUnJbIUlE2gAKmcVkIaeRWq74HSU+CHYs+uM5CI7KnSlZn6dg0/PaWYHwDYDqIKqd
         RgLFy98eo2YW1BIKyc2hQtL/h1LaAEbl+KqLUXfN1ACTMTaUP8BTnO7HRi4+EpQ09GoS
         gJ8gk6NH2lO7v8kBnDItvf/ddL/+zi/Oz+Cpcd/CWPVKShqy2VJKwlV3rYyDPRn2j+AM
         CZ7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710957677; x=1711562477;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j+EPj9HeAGH/gl0oSvfO1IUhtpAie7DUc9DIX8DS5vA=;
        b=AGODrFUi7WWLLaZKJGKz681zU1F6h0kgLYNWeISElRw5DJKNP1N7Ob8Bn/nU5RkWYT
         5s41Cm/dolzOHXEaa+tovgejLs/AObOisv1OXCTMQAunKaNQR8Vb3++kesI9QsoPDery
         vzJqhaIGdGqgPtiGzaKT3uFDVNquCC7up/D2E/W+4e/qF0TnKOPp0b38RdpzHO1zUdCr
         FKqvGatk542FO4hoOlXRDzATmFsDE/5hVjXlZ39VQv1T1Yw+eTgn9DrVDUAjRp8Nkkwx
         U3UPDcLtGhLI8a8gqea9i++yC3+hybd7PyjldJ/JHDHY6C2rnzvB2ALbPCQx7h30Xf5q
         /OYg==
X-Forwarded-Encrypted: i=1; AJvYcCUuf/YN5Cjr82MXevT+/r9I1ZQCpnBzU9lkcoVWbVpnl7Tah4e2cBBw5WUDmdwmtGQRDvGgWZDek6ZmulYNWrxUWMyfE5twdEkISaJ6
X-Gm-Message-State: AOJu0YyGa+iawrNwvf3eke80vL+KcvtgJzENf4u1BhixnJu8p0kMMuUZ
	mvXwMTi4Q8IbUZzAEsgdwpapBwNO+uxtJjKET9vv0SrMXzKSlQ/x
X-Google-Smtp-Source: AGHT+IHM2XTem3JgVQP0IEX99GUflswwZbPvHTBC/KXEXyhYYIawJfvzbVQn5Y611HdY+Vb1VCov5g==
X-Received: by 2002:a17:902:7790:b0:1dd:8daf:99b2 with SMTP id o16-20020a170902779000b001dd8daf99b2mr14382250pll.13.1710957677502;
        Wed, 20 Mar 2024 11:01:17 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id jc14-20020a17090325ce00b001dd707d5fe6sm13937024plb.158.2024.03.20.11.01.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 11:01:17 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 20 Mar 2024 11:01:15 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: rafael@kernel.org, lenb@kernel.org, jdelvare@suse.com,
	robert.moore@intel.com, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
	acpica-devel@lists.linux.dev
Subject: Re: [PATCH v5 2/2] hwmon: (acpi_power_meter) Ensure IPMI space
 handler is ready on Dell systems
Message-ID: <9f6ee66e-f76d-46f3-8de2-516bad47311d@roeck-us.net>
References: <20240320084317.366853-1-kai.heng.feng@canonical.com>
 <20240320084317.366853-2-kai.heng.feng@canonical.com>
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240320084317.366853-2-kai.heng.feng@canonical.com>

On Wed, Mar 20, 2024 at 04:43:17PM +0800, Kai-Heng Feng wrote:
> The following error can be observed at boot:
> [    3.717920] ACPI Error: No handler for Region [SYSI] (00000000ab9e62c5) [IPMI] (20230628/evregion-130)
> [    3.717928] ACPI Error: Region IPMI (ID=7) has no handler (20230628/exfldio-261)
> 
> [    3.717936] No Local Variables are initialized for Method [_GHL]
> 
> [    3.717938] No Arguments are initialized for method [_GHL]
> 
> [    3.717940] ACPI Error: Aborting method \_SB.PMI0._GHL due to previous error (AE_NOT_EXIST) (20230628/psparse-529)
> [    3.717949] ACPI Error: Aborting method \_SB.PMI0._PMC due to previous error (AE_NOT_EXIST) (20230628/psparse-529)
> [    3.717957] ACPI: \_SB_.PMI0: _PMC evaluation failed: AE_NOT_EXIST
> 
> On Dell systems several methods of acpi_power_meter access variables in
> IPMI region [0], so wait until IPMI space handler is installed by
> acpi_ipmi and also wait until SMI is selected to make the space handler
> fully functional.
> 
> Since the dependency is inside BIOS's ASL code and it's not
> discoverable, so use this fixup is a hack to workaround BIOS issue.
> 
> [0] https://www.dell.com/support/manuals/en-us/redhat-enterprise-linux-v8.0/rhel8_rn_pub/advanced-configuration-and-power-interface-acpi-error-messages-displayed-in-dmesg?guid=guid-0d5ae482-1977-42cf-b417-3ed5c3f5ee62
> 
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

Applied to hwmon-next.

Please note that I'll push the branch after the commit window closed.

Thanks,
Guenter
