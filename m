Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042A42FE311
	for <acpica-devel@lists.linux.dev>; Thu, 17 Jul 2025 17:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752773997; cv=none; b=T6VeLTZg2FkmnnynSE+6LbNR28BMF7QGtmfOntddbUnvhWPmTWkv+R03eS0+RnrdUosyMt04XXXodWS7P0S8/VDYwRZ/rohpOQn++EG57Db2pxRzk+emYB1U6FlP09jykHYAiGCDyh+CRqPNOs7n6Xjy3J7RM3JWEvFSBDkh1g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752773997; c=relaxed/simple;
	bh=qkhhPed3/lpu6pQkUFh0Et55Y3tu/w9wjUEBEqiMqKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rHuYYso1/CpnnrMg6p4Es1g1pBB6FGjxzgdpt9y1j4Alhvas/TDJZR2PQFtHE24plpsmgqeJLtB5LLdY8wykzMvUEjjgoKf/AeYzGtu6RQzSyxadP3He2dq5SPWq/nXU5P9dktsB8iMZ+8tDL9ahMWtNh/Z672H+eeQhqGm38Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ae35f36da9dso242719666b.0
        for <acpica-devel@lists.linux.dev>; Thu, 17 Jul 2025 10:39:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752773994; x=1753378794;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N75hUCUnHzHAOQnR1X5WDi46d6HHqLedahkb72BGIp4=;
        b=se/RhBrPJWmLSc3QIg4pACuiat3lKLCmN1LzB6Fb6iyTiEcDwOUfLNrLeudzcSP/hm
         mb49zEIKAYzSON9Y4dP97Rb0kdJXnpVprgL8lydBencvpx/aqIfjrgm+XaY9n6YzyIQz
         90VbEfADzTDfWgP7KOaNSqLcnI2JzODCBnVNkHwRTyO2xgGcOpTKFuWqyly3Ur7hwgE+
         Acw6+uguTRE18+L7RM2L5bXCO62ISW/eGduKZeAI6ik0unFTd8XhRVTuhU2v5P4XXpRV
         WVAHlj+vARP58TIqL1J/JhpGWjw9LnBkgWOD8368ddhDKi7EYJjEiwKgJiC/FlxY9BrV
         JJYA==
X-Forwarded-Encrypted: i=1; AJvYcCU2+NpWayhrbzKCXUpUSVZb2Mjlo7c3km+gNaBScY6Qx0SWprgn1RsTvl0Doko5wHAnZ6ehfskOfRn2Fqs=@lists.linux.dev
X-Gm-Message-State: AOJu0Yyg6N6ALc5j+WdfhCin4Hm2Hd7/4L6k3QiTnvhQ0nF4VhdLWlCO
	kxf3blECP/+2qYN53SxKVWuaDpEZL093GAmxRL0+uecqjxzz6PHpcMI/
X-Gm-Gg: ASbGncudEwCnVSIaHQJFynWLfmxNLRexw3TLLjtElfpfwE/J3ovWVD02vuUQdoJJvFV
	kyXFMNXAiJWuV8MwqZxQgKpZZFe6CRk4uOklPq+clq/9BKbNts8AofsE+w67QYiMXBH6ITbvEFV
	VSxMSGURJPEweex/9kyKhMk8YMdhnt6hQ19BlOxRih5VEUFxQwqkMKuFD63XukuBf6ksND3x07f
	xqWJpfdynvwhJ8UPznYgMNoCFE9iWb5yU9xAuwnl78lXaFBX7QSP2KGHhx00T4gSo3MnaZquSDk
	osZMxihatU/YvGyt/uCfemAqUpisdAMd/N2MejOIi/c7CT1lYbuBvlmKvg2tbsQUtrrDhFVOfMy
	sDqg9cIEogRmSpQ==
X-Google-Smtp-Source: AGHT+IFzyhLjmPmu4cDWktpxpzqDvcGCAjasZsDpOpRd6cqtZ393AWPrIrHoAbTP5fUy+pRG6xJk/g==
X-Received: by 2002:a17:906:d28c:b0:ae3:ab68:4d7a with SMTP id a640c23a62f3a-ae9cde2e5f3mr674693866b.25.1752773994024;
        Thu, 17 Jul 2025 10:39:54 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:74::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e7ee4860sm1381138466b.47.2025.07.17.10.39.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 10:39:53 -0700 (PDT)
Date: Thu, 17 Jul 2025 10:39:51 -0700
From: Breno Leitao <leitao@debian.org>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Shuai Xue <xueshuai@linux.alibaba.com>, Borislav Petkov <bp@alien8.de>, 
	"Graf, Alexander" <graf@amazon.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, 
	Peter Gonda <pgonda@google.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Len Brown <lenb@kernel.org>, James Morse <james.morse@arm.com>, 
	"Moore, Robert" <robert.moore@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "acpica-devel@lists.linux.dev" <acpica-devel@lists.linux.dev>, 
	"kernel-team@meta.com" <kernel-team@meta.com>
Subject: Re: [PATCH] ghes: Track number of recovered hardware errors
Message-ID: <p2jxuwlierrzbgsdjdmiw5336mhj5s57vg77zkekix6fkjqbqi@sa6opsvnxv6d>
References: <20250715103125.GFaHYt_TnFQW6ti0ST@fat_crate.local>
 <vs5x5qvw2veurxdljmdiumqpseze2myx6quw3rmt7li7d3dbin@duoky4z44zzz>
 <20250715125327.GGaHZPRz9QLNNO-7q8@fat_crate.local>
 <68b6961c-4443-48a8-a7f7-ed94f3352d7d@linux.alibaba.com>
 <p2iytcdfvgm74zif6ihd7gs4kuaeza4b4p52cr5ya4upabiome@kr3yy7fjznwe>
 <b4c39a87-c5a4-4525-b598-61fc28a8dc36@linux.alibaba.com>
 <ckn7d3e3xynnup4bbombn7z7xxvld3a7xmqpg4pzp57qebywfc@t2yrn3zqmnje>
 <58f3242a-e52a-46a9-9a99-3887eeaa1285@linux.alibaba.com>
 <4fbreveuibi7q5nc2v4t3fpaxrgpwfd4f5c3ubfhssidqesax4@n7q4wrdpbfjv>
 <SJ1PR11MB60838F74FA06ED06C5D29FEDFC51A@SJ1PR11MB6083.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SJ1PR11MB60838F74FA06ED06C5D29FEDFC51A@SJ1PR11MB6083.namprd11.prod.outlook.com>

On Thu, Jul 17, 2025 at 05:19:48PM +0000, Luck, Tony wrote:
> >> Personally, I think this approach would be more helpful. Additionally, I
> >> suggest not mixing CEs (Correctable Errors) and UEs (Uncorrectable
> >> Errors) together. This is especially important for memory errors, as CEs
> >> occur much more frequently than UEs, but their impact is much smaller.
> 
> Total agreement on keeping corrected memory errors out of this special
> handling. They happen all the time in a large fleet, and are not significant
> unless the same address repeats.

Are these EDAC errors? Shouldn't we track CE errors in
edac_device_handle_ce_count()?
