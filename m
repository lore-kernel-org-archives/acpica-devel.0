Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142D529E10A
	for <acpica-devel@lists.linux.dev>; Thu, 17 Jul 2025 12:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752754013; cv=none; b=a5Jh36MvWpFodQHfEsvrtVCPnbqork7s7RNVe063ICs0eTJF6LkVyKgKns90SSUX8NR92gvCaoluPSeeUntr86RyfLEXB+r7bjGHvKqc/otsGhmlqLY333OhiDCShbAHTs9o7LjyHk4gMxtvyW+WJbCJyQNLZX9qElWut8so6Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752754013; c=relaxed/simple;
	bh=RvHk/8vc9K69G8Z1QJNxwvCxdG7roCJFshWFPRjMRxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fCZ1jtHbiB3n7fdZgxcc42NsySqfVAxAh5h2CebxKk4cwoZ//8c7Bdc+CRzVedJUE0pKPsGIb5+hQGL7+vQpdvDxdympGyYHeKDlmujU+eZbxLrWowkxzu1uLDmCsmlB53GOIHY/jCwP3KPYoR4DK6ZLmacnHC79YiSQcQIqrw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ae04d3d63e6so168122666b.2
        for <acpica-devel@lists.linux.dev>; Thu, 17 Jul 2025 05:06:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752754010; x=1753358810;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rqBHQB/DAavtmQ1viryr8kROVdgd210A0X7P+0g/Z24=;
        b=WEAH2mBeQmsVoDQ9gg45usqn3n9GMNStzqCkIPBuxU00SSlvZQqYmypBRNdKKm/WkS
         Hz/McGRlHfTEeD0hslSQYE0Nk9TqZdvKlhj7ILz2F1TI+FgKzI5psuKQY2tmv47O9qu6
         9hoNIxykjbeaSchtVgHo70/gHXC8ZTIWZVAF4JaLyt2YmQ4LObWz6MmF/WtGE3aA9G45
         V0bhiG6DR06LLVeCipPBI3MwZmLp3OIXm1tJoFkoB0pXj8IhDps9t+ruImm1I97zDCC/
         P3a65MpZs5n6wBh1CXJHEyKbspRnMkpiQfIle0Gba/EDHjVvHxsgRYQUUZbxXDcrYCDs
         hBvg==
X-Forwarded-Encrypted: i=1; AJvYcCVIGFZDMOISLsDCft/y+tZBhpXNwnMsdeDuig/6IuneerTzkdq4t5h0ClaPlX9S7EicQGSCOaP5GH9Z3as=@lists.linux.dev
X-Gm-Message-State: AOJu0Yw2hVZeKQUIS7JoUvi3gwNJYTKE4HTPccabL261FbCjAmDXXq4G
	7duEgbuJ63D3BYdmbwAXsi1VV/NS9BXBqGax4gc5dguj4bRrrpkm3xvU
X-Gm-Gg: ASbGncs1IiEo++el3hrhwFCMPL+AjZ/jiC9WSKkiA4k5s+wvMy4uzJmcqp6m0nRTcJJ
	YP3wod9LTASphapOO0+WqB39BCErTzXctsotwdl6zzyL8gl00JQiKtsAWe+4jKsFuSwTKGd3AMY
	3cTpW7+cwO6xY0bzQSk85c5QFAMwikL86MOHxxH/m5oRv3dET7JUc9afGNCoZM9Cnte/y4qZLbl
	v4HLaG8bqBIbQob3k2Pu60ZRvQpbfftm2bYEz3ztNHN8/T/BpRqtDxua/+1k6eU9HSn0Z/sJ9Qy
	DlJ8wfXRKq3JsqP5icj4WFcrJNUwdUbwUefNFhRYrenZWZ1LKV/Dk8fbZ9FI8X89n2wJ9zzzBNZ
	CnSJR5eC/DVzK
X-Google-Smtp-Source: AGHT+IESbI2L8ZCImWm4+hywJ3SwpW8aqZ9LbkZTp2Ra1AJuh7M/Wt78D87mE6MQjYzvVePwpIvDfg==
X-Received: by 2002:a17:906:478f:b0:ae3:62cb:7654 with SMTP id a640c23a62f3a-ae9cde016d1mr640917566b.17.1752754010207;
        Thu, 17 Jul 2025 05:06:50 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:2::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae9cabc0b6dsm323426366b.111.2025.07.17.05.06.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 05:06:49 -0700 (PDT)
Date: Thu, 17 Jul 2025 05:06:47 -0700
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
Message-ID: <4fbreveuibi7q5nc2v4t3fpaxrgpwfd4f5c3ubfhssidqesax4@n7q4wrdpbfjv>
References: <20250715082939.GAaHYRc3Yn49jyvYzc@fat_crate.local>
 <kyprjdilgyz3xgw3slnrsemptnpp6h75mipv6a3lgp2dmwqekg@s7azbepy7nu2>
 <20250715103125.GFaHYt_TnFQW6ti0ST@fat_crate.local>
 <vs5x5qvw2veurxdljmdiumqpseze2myx6quw3rmt7li7d3dbin@duoky4z44zzz>
 <20250715125327.GGaHZPRz9QLNNO-7q8@fat_crate.local>
 <68b6961c-4443-48a8-a7f7-ed94f3352d7d@linux.alibaba.com>
 <p2iytcdfvgm74zif6ihd7gs4kuaeza4b4p52cr5ya4upabiome@kr3yy7fjznwe>
 <b4c39a87-c5a4-4525-b598-61fc28a8dc36@linux.alibaba.com>
 <ckn7d3e3xynnup4bbombn7z7xxvld3a7xmqpg4pzp57qebywfc@t2yrn3zqmnje>
 <58f3242a-e52a-46a9-9a99-3887eeaa1285@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <58f3242a-e52a-46a9-9a99-3887eeaa1285@linux.alibaba.com>

hello Shuai,

On Thu, Jul 17, 2025 at 11:03:51AM +0800, Shuai Xue wrote:
> 在 2025/7/16 20:42, Breno Leitao 写道:
> > That said, Tony proposed a more robust approach—categorizing and
> > tracking errors by their source. This would involve maintaining separate
> > counters for each source using an counter per enum type:
> > 
> > 	enum recovered_error_sources {
> > 		ERR_GHES,
> > 		ERR_MCE,
> > 		ERR_AER,
> > 		...
> > 		ERR_NUM_SOURCES
> > 	};
> > 
> > See more at: https://lore.kernel.org/all/aHWC-J851eaHa_Au@agluck-desk3/
> > 
> > Do you think this would help you by any chance?
> 
> Personally, I think this approach would be more helpful. Additionally, I
> suggest not mixing CEs (Correctable Errors) and UEs (Uncorrectable
> Errors) together. This is especially important for memory errors, as CEs
> occur much more frequently than UEs, but their impact is much smaller.

Yes, I totally agree. This would be even better than my original
solution. Let me spend some time on it and see how further I can go.

Thanks for your opinions,
--breno
