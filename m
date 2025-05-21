Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1684F232785;
	Wed, 21 May 2025 07:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747813405; cv=none; b=aObH7SEjCcRe27lR0nmzovF4mqyvjYK+RNIKalFN66vqlPO+dpFXZAiQZwN3kBSf9BP2oEkJBYGgyjRjJYNIdcHdLTugqSz7LhsEn2biU2hc9X/apyVHQiCqJ+wN10H6RSoghiHcDCpxcj9lOtnXjw+DTB0zokGBcHV3t5gc9XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747813405; c=relaxed/simple;
	bh=w1Dg5RsBUc18F5v8ye2RlpbIpog0I4kAhq9mtswyzPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fpje05cE4O9j3aodC09Y2EOlUKREZWEUdy4IUv05wiID2VZxdZehz49lWcjdMnpmFx1C4hMrrGVB6bRH/1oLYKoHfmEhlLt7qvImcPM46dXy5/e27VE32cleQJshwPIzzkafGsHTrlJliHlLax0pwf3g0w/9hRSxdOAKva5RfVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HksF6l3E; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HksF6l3E"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ad5574b59c0so651728266b.2;
        Wed, 21 May 2025 00:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747813393; x=1748418193; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=J84xNzRgQa8mrQOkYbumbzzgj0ybXamBQeiJjclSyrA=;
        b=HksF6l3EveuER/wyl6bH5APGsc3LEYBswjSHFqMuLzYVsbMjilJlnsmbq92H1CFinL
         5779XiB/SrlplpM3A599066FvoeaKewPp0o16oYCWXt3lE6Zo28XSCShKYqWCjLqoJI0
         UILxaa20Mf5exAUGyrUnwSFpti7O6haysvAJazO14hYN0ey2eQy6ES9WcGPHErGbubfx
         7t/lm5YngCLjUy18xHrmo5jz1UeF27ENVae2CEwceBdAAcf3U0N/d/DWYmh57mu8nPdW
         fYZ3hATznoE6LGF5fBHWiHqKp/0OxLMfRSEwT7AvONx0YJDWEmp9IcbORmE9wg7a2TFM
         mcxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747813393; x=1748418193;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J84xNzRgQa8mrQOkYbumbzzgj0ybXamBQeiJjclSyrA=;
        b=ETbogwY2cMxaUuxDUE3XyvxpKEJrMAe3TsaFuzdJx8eEYB46MtThV9s8CRJuIIQ7OI
         I6opjGObV0ndl4nTmBbFKVrmd1Lyspserrgk+shhsD/QfUl9ZLZTCK+XKsgD515fCn3l
         xKXohOZ+/7boJGX3hNDGJ/+k4pydouQJCSygOOTH29CmHVm5nR+HjBWOWzUKVvYxj4/M
         s+8KD+jb5CAzsFQwJZq1rS8GwMI8BEOfa+MOPNgYDD+mwGJ63XnYayRcxLouiIQipXFl
         J1Wc6ORHek71mSD/g375wLRnqO2IkqiddkOJrbmVRBiB+EbRxgCX1yIMx+sPjZ3uCrZI
         kLHQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxadVjvRlQpu57qgbzmjU9EvjqM5dXxryuz7+brWYg38jz8Y+vDvqv287sKbWEN3llXvWJto6jHR2LNN4=@lists.linux.dev, AJvYcCXZzXh5VRSlE445/MphQ9frKn/uhPjmmrBeE+Czn863JwqEUJiB1nEHp2a5/OVlT56i0FYkKp6X@lists.linux.dev
X-Gm-Message-State: AOJu0Yyhh5WpJg3OrBFUCGmurtWvdiSlbbnAmhEVEEpDi5MyKLJhRARg
	ayIZzgDd9Mk0BXF4GwxcKNFgXEvv94JFT8RFtgTs+okXMDbSQ7xEzUrr
X-Gm-Gg: ASbGncuaTor3xeU7GCM7AFxbhAADbxtgk4QCRHDBS2od7awAmrmdTpw0DXtapU2Y5ry
	W7VancH54RJMZtdWb209HYDv2jYH2SnM2zo4QjYhBdXwTCo8vfoRXCq1LlPWo7ahxIyOs7NYUNT
	4f5CZSNxshC9sDmu90Pw+zEtlsZ9oZ7hjT81CidnhiRmsGO2oQwAJDKVmPWGszEDL5UYb5AlJIc
	ijVqyOMEpF1pUArKVNKHXaTTZv1i6z6G9Z4C1yVgcbn0fEOw5+tvyxXgQX2BSLybjuiAwb+zEya
	5MDhPM/V/Dfepav34OOdFLCICzWOzL5aX3JPCB6JlDcaAml77fWTCqtXWPKcBLXf
X-Google-Smtp-Source: AGHT+IH5tn7Yh9xi/YcQ/171T3oryvhz9qm9/H/Z6ntY23ewvFkuclGodMzYYPJIYuU9jlPXxMJw+A==
X-Received: by 2002:a17:907:3d4e:b0:ad5:e0f:7850 with SMTP id a640c23a62f3a-ad536bde688mr1648749566b.23.1747813392931;
        Wed, 21 May 2025 00:43:12 -0700 (PDT)
Received: from f (cst-prg-94-60.cust.vodafone.cz. [46.135.94.60])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad52d06dc6csm868357266b.53.2025.05.21.00.43.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 May 2025 00:43:11 -0700 (PDT)
Date: Wed, 21 May 2025 09:43:01 +0200
From: Mateusz Guzik <mjguzik@gmail.com>
To: Baris Can Goral <goralbaris@gmail.com>
Cc: oliver.sang@intel.com, acpica-devel@lists.linux.dev, lenb@kernel.org, 
	linux-acpi@vger.kernel.org, lkp@intel.com, oe-lkp@lists.linux.dev, 
	rafael.j.wysocki@intel.com, robert.moore@intel.com, skhan@linuxfoundation.org, 
	kees@kernel.org
Subject: Re: [PATCH acpi] Replace strncpy with strscpy
Message-ID: <rkc452hxtxcaym55croa5uvtjjsulbl25bhdk2mw2ce5fwqx4p@guhdxk6eogqj>
References: <202505191014.718ca1d6-lkp@intel.com>
 <20250520163540.6893-1-goralbaris@gmail.com>
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250520163540.6893-1-goralbaris@gmail.com>

On Tue, May 20, 2025 at 07:35:40PM +0300, Baris Can Goral wrote:
> Hi,
> Rafael I dont understand your question. This patch replaces
> strncpy which is vulnerable with strscpy. As it stated in Link I shared.

Uses of strncpy are not inherently buggy, rather there is a corner case
where the string might happen to end up not terminated.

Rafael asked if that's what is being patched here.

> It seems it works to fix somethings.

If anything it seems to /break/ something.

In all reported cases the idle time went down significantly, which I
looks like an unexpected outcome.

So interestingly (to my reading anyway) this particular consumer
explicitly wants the target string to NOT be nul terminated.

The copied to struct is:

struct acpi_table_header {
[snip]
        char oem_id[ACPI_OEM_ID_SIZE];  /* ASCII OEM identification */
        char oem_table_id[ACPI_OEM_TABLE_ID_SIZE];      /* ASCII OEM table identification */
[/snip]
};

Later the thing is NOT treated as a string, instead it is handled with
memcmp:
 !memcmp(acpi_gbl_root_table_list.tables[i].pointer->
		oem_table_id, header.oem_table_id,
		ACPI_OEM_TABLE_ID_SIZE))) {

So, for "table ids" which occupy the entirety of ACPI_OEM_TABLE_ID_SIZE
(and which end up not null terminated), your patch changes the behavior
as they end up suddenly truncated by 1 to nul terminate, which then
makes them fail memcmp.

So the patch is not a nop and it breaks stuff afaics.

I thing the real bug here is that strscpy does anything of the sort.
Instead it should fail *and* be annotated with __must_check or whatever
the name it has on Linux so that consumers don't unknowingly introduce
truncated strings..
