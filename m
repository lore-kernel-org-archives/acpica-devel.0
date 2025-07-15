Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF546A8D2
	for <acpica-devel@lists.linux.dev>; Tue, 15 Jul 2025 17:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752600353; cv=none; b=KFL9TSj1mgTxYEC1bEv1lpDi4+Qm94w/vB70Es0MqFE0gvqU5JDk8UIIsqOVpPEB27u9KjTKZcljtatqCbM/fwLHWhO53wRxXWFbmL21OsbrvZ1eQBwvIYRnpszTw5If8qoAo1h7J3IiYppXT84ir6Em3HbTU34THyyf5+kE1zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752600353; c=relaxed/simple;
	bh=ObNJkp8w8dckS4HfYzBEO63j0fpZbJAJtHbLUzQTMHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uqzxqV1ycOq7NglZWJpqQHgXfv/uilYLE+o57hlAbbssO81ZoWR2kFUjoDWJu+AxiH/FIdjRjKdSoHtaEfxyQq0YbWM5bj0YyDRVXt3kdJ2jrPyl67MC4AgcfI0GKpJOoV6F7qtRoLaP4mMuKY9VWwOSN5mjSKP8bM/FZhTAriI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ae0c571f137so1072419766b.0
        for <acpica-devel@lists.linux.dev>; Tue, 15 Jul 2025 10:25:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752600350; x=1753205150;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xf1dUxpG80FVASwwBORzwwbeN/v/ksSLNBI/P0k3Gcc=;
        b=ox125THh1ZYHTlV8qAup+XClF4D1mZd5UTYayHPr7tuxktlKBMJ72WItc+bfXiugOy
         RHKeysr8BD5gLxxG9C2IzHnJmO6LaJvezGSgioq8TpDTUddCpXpjtAJ5Op82FHhdkm+x
         mP0B5HIcIb52HRUz4vlxzkfrj/vDlcG2woQ9cnk86cZMQYEH7fClN1eWugsAwPab6Fty
         mCIWF46B+AhxkPRyfqWlucAh671iTsXas5F5+zy8qRNaaMRcicZEa1V0LuYUIcJvIgqG
         I9fokoT2qLe+q2FHqt0ylFrOK2KpaTYe4sxtPsyZJHnwZoMlWb87FuZEC54+6t81ZLcU
         38cQ==
X-Forwarded-Encrypted: i=1; AJvYcCUlbEfcap9k4UbbzjyOrAlVY6QLWt0SC4PABPD9sCpaAkl20ziJYigDvEpgncK2UyKazuLtGWN7VMQKE6c=@lists.linux.dev
X-Gm-Message-State: AOJu0YyY3BwNzWOpfDEIps8XW+OHI3A5OpE/9f9JFxBf9czAsHVAjA62
	DNYXu8jqpp7iFxhOn94PXl0GFnEt+GBba+CQoHnhDLMSerMx791pklQj
X-Gm-Gg: ASbGncsL4kLMoXt3iU9mAllTE5RDRz9Tga/3ZC8ArYzvm7nu5yv/s6DEErzdTxhHBG/
	mqLRN9b26oWrQmetQt5/y8ge5I5iAkZx+klcVJS0nHIkoKuN6S4xxMAknZbQD4A4hmh15scMhAZ
	i0RBi56DS5WedoH5rW2KXY6uXUv1U5fmob0/aTpFJh4PjN3S22wXqRkK5UR3XRCyFt2B0oWjv9J
	Aoy0RcON+A1M1v2zGvleQfZeqBJt4lcBmOj3e6fOED0huLFXvBRRJX+TsU1GLGvZzJnm4+obsU8
	kZdngDE4+ORv6aDFcGTLC++HdCLcNvIWSdXrIY5h8VVXP8Xb9IAfCnKBNPMExB9f34VusvPGhbh
	gPi9JgEK6xsFC
X-Google-Smtp-Source: AGHT+IFeQYyxja+cmVPhs40k5Cb0GxRCsVCO/YLoPe8/dy4NpmE659Cs2eUBxOmp8tWCHkW96xjcFQ==
X-Received: by 2002:a17:906:b212:b0:ae0:b7c8:d735 with SMTP id a640c23a62f3a-ae9c9b6c4dfmr25479566b.42.1752600349578;
        Tue, 15 Jul 2025 10:25:49 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:8::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e826651csm1035756866b.101.2025.07.15.10.25.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 10:25:49 -0700 (PDT)
Date: Tue, 15 Jul 2025 10:25:46 -0700
From: Breno Leitao <leitao@debian.org>
To: Shuai Xue <xueshuai@linux.alibaba.com>
Cc: Borislav Petkov <bp@alien8.de>, Alexander Graf <graf@amazon.com>, 
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Peter Gonda <pgonda@google.com>, 
	"Luck, Tony" <tony.luck@intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Len Brown <lenb@kernel.org>, James Morse <james.morse@arm.com>, 
	"Moore, Robert" <robert.moore@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "acpica-devel@lists.linux.dev" <acpica-devel@lists.linux.dev>, 
	"kernel-team@meta.com" <kernel-team@meta.com>
Subject: Re: [PATCH] ghes: Track number of recovered hardware errors
Message-ID: <p2iytcdfvgm74zif6ihd7gs4kuaeza4b4p52cr5ya4upabiome@kr3yy7fjznwe>
References: <20250714171040.GOaHU6EKH2xxSZFnZd@fat_crate.local>
 <SJ1PR11MB6083C38E6DA922E05E1748D6FC54A@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20250714173556.GQaHU__LL6IUIPCDIW@fat_crate.local>
 <aHWC-J851eaHa_Au@agluck-desk3>
 <20250715082939.GAaHYRc3Yn49jyvYzc@fat_crate.local>
 <kyprjdilgyz3xgw3slnrsemptnpp6h75mipv6a3lgp2dmwqekg@s7azbepy7nu2>
 <20250715103125.GFaHYt_TnFQW6ti0ST@fat_crate.local>
 <vs5x5qvw2veurxdljmdiumqpseze2myx6quw3rmt7li7d3dbin@duoky4z44zzz>
 <20250715125327.GGaHZPRz9QLNNO-7q8@fat_crate.local>
 <68b6961c-4443-48a8-a7f7-ed94f3352d7d@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68b6961c-4443-48a8-a7f7-ed94f3352d7d@linux.alibaba.com>

Hello Shuai,

On Tue, Jul 15, 2025 at 09:46:03PM +0800, Shuai Xue wrote:
> > It would be really good to sync with other cloud providers here so that we can
> > do this one solution which fits all. Lemme CC some other folks I know who do
> > cloud gunk and leave the whole mail for their pleasure.
> > 
> > Newly CCed folks, you know how to find the whole discussion. :-)
> > 
> > Thx.
> 
> 
> For the purpose of counting, how about using the cmdline of rasdaemon?

How do you manage it at a large fleet of hosts? Do you have rasdaemon
logging always and how do you correlate with kernel crashes? At Meta, we
have an a "clues" tag for each crash, and one of the tags is Machine
Check Exception (MCE), which is parsed from dmesg right now (with the
regexp I shared earlier).

My plan with this patch is to have a counter for hardware errors that
would be exposed to the crashdump. So, post-morten analyzes tooling can
easily query if there are hardware errors and query RAS information in
the right databases, in case it seems a smoking gun.

Do you have any experience with this type of automatic correlation?

Thanks for your insights,
--breno
