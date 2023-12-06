Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41F537144
	for <acpica-devel@lists.linux.dev>; Wed,  6 Dec 2023 16:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="Dus5xfvC"
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 998193FB5A
	for <acpica-devel@lists.linux.dev>; Wed,  6 Dec 2023 16:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1701880654;
	bh=Zi682t5K7EyE6/V/tMw8fdaNtybN1Zt94trKteMb2ew=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=Dus5xfvCGTSVwTXHnaJehUfoNjDrBwMxrLb2oaTpoeAOfk8HPtqMgWEt56B1ZG/IR
	 jE8/j1YTcdXAQaJpV6i9pYvj15ywSB+kuSsCQb/jgGnGDDVmc96AQcxmpzRdcmuNlo
	 MbRXgr/tiuMo8W1BtjI6KnuxINNPRVBYh2ijZ1Elo+wsJpOvLxopX6SSBWZ648Aw91
	 MzTBpj8oJsHLcU3sJMs2ccE8qqKCZw6/+3AQYLRe5WC21Zy9KrsW5OOjnBZnTz+C7g
	 YVMsdfOgqr3UIyb/KxH4kbz5gfGwVJcKH1sB5EdbAO5VAkiX7iKj5JCPdjZl07gtVc
	 MnV1bfT6wMkgQ==
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-40b4096abc8so54787415e9.0
        for <acpica-devel@lists.linux.dev>; Wed, 06 Dec 2023 08:37:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701880654; x=1702485454;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zi682t5K7EyE6/V/tMw8fdaNtybN1Zt94trKteMb2ew=;
        b=V6q8ryazMWBxCwpINUmDK9KeWnYaOfgyHDNuCe8E4crhDAVcbYjWJLsc9hofK7NL0E
         PloOH2tIUFv+dyWtchIUuTNhN4+MA2HMmnkOVxKZHABbbQjxYVT/dHpi7+xyrW/aVI3I
         PtN1Y52IlWzS8YSrSi5efINcBhBBmnkduZBKStB4WneRGGmDKlwhFpFYCl94FhpGb8CU
         AWX7rNmbeLsH/DAM2LfL7f3xAWc9PiyCEWt7T0pkR7PDjr0FCeS0kXXCLkyLdCVlEq0B
         xYPEwTOTg0oZ4iPTDxj9Jka2wJxLKMMeoR020jSjSy64BezadZRtWJakGLW7wvqpVZmx
         jX0A==
X-Gm-Message-State: AOJu0Yz08JzjXLgcwkiOLJz5zJthgppGojO6M3dWGyG+ZRuVRvkoHKEP
	KN25QipUGkD7SXOF3CZ8CaF4qicW4UkLJSVmQlUFTVwCwTmnA4r6a6ZAGv4NQf31/R+Gg03IU2u
	ri5mXNBP9ymEqh1fbE7c5pE1VHCHo8JzqwijwdOCF8Q==
X-Received: by 2002:a05:600c:1c1d:b0:40c:1c2a:ee6e with SMTP id j29-20020a05600c1c1d00b0040c1c2aee6emr538670wms.61.1701880654317;
        Wed, 06 Dec 2023 08:37:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFMgacecIbMy3255zcVF0NByF8i+K7PORe5RRs8XOmBlXXH3pVjexVFuK5qZmbqjxuH1mYOYw==
X-Received: by 2002:a05:600c:1c1d:b0:40c:1c2a:ee6e with SMTP id j29-20020a05600c1c1d00b0040c1c2aee6emr538664wms.61.1701880653964;
        Wed, 06 Dec 2023 08:37:33 -0800 (PST)
Received: from [192.168.123.67] (ip-178-202-040-247.um47.pools.vodafone-ip.de. [178.202.40.247])
        by smtp.gmail.com with ESMTPSA id g20-20020a05600c4ed400b0040b4c7e1a65sm214908wmq.13.2023.12.06.08.37.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Dec 2023 08:37:33 -0800 (PST)
Message-ID: <a3ea149b-adad-4680-bb59-ae460e8eda04@canonical.com>
Date: Wed, 6 Dec 2023 17:37:27 +0100
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] ACPI: XSDT: struct acpi_table_xsdt must be packed
Content-Language: en-US
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Robert Moore <robert.moore@intel.com>, Len Brown <lenb@kernel.org>,
 linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20231111134827.174908-1-heinrich.schuchardt@canonical.com>
 <CAJZ5v0gGKuBNBvDj2fNMyCvKTrt2SWfusxyaf7W4jvvfL0nxUg@mail.gmail.com>
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAJZ5v0gGKuBNBvDj2fNMyCvKTrt2SWfusxyaf7W4jvvfL0nxUg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 06.12.23 17:30, Rafael J. Wysocki wrote:
> On Sat, Nov 11, 2023 at 2:48 PM Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
>>
>> According to the ACPI 6.5 specification the component Entry starts at
>> offset 36 in the XSDT table which is not a multiple of 8. Hence we must
>> mark the structure as packed.
> 
> There is #pragma pack(1) at the beginning of actbl.h.  Is it not sufficient?

Sorry I missed that pragma.

> 
>> We did not see an error due to the incorrect packing yet as in
>> acpi_tb_parse_root_table() we use ACPI_ADD_PTR() to find the address of
>> Entry.
>>
>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>> ---
>>   include/acpi/actbl.h | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/include/acpi/actbl.h b/include/acpi/actbl.h
>> index 451f6276da49..1a37ac378765 100644
>> --- a/include/acpi/actbl.h
>> +++ b/include/acpi/actbl.h
>> @@ -148,7 +148,7 @@ struct acpi_table_rsdt {
>>   struct acpi_table_xsdt {
>>          struct acpi_table_header header;        /* Common ACPI table header */
>>          u64 table_offset_entry[1];      /* Array of pointers to ACPI tables */
>> -};
>> +} __packed;
>>
>>   #define ACPI_RSDT_ENTRY_SIZE        (sizeof (u32))
>>   #define ACPI_XSDT_ENTRY_SIZE        (sizeof (u64))
>> --
>> 2.40.1
>>

