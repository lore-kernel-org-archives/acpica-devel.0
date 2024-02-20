Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9710C151CDD
	for <acpica-devel@lists.linuxfoundation.org>; Tue, 20 Feb 2024 21:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708463081; cv=none; b=no0HfzRi5l3Pa3cgcMXKayN3zlCB/uWUBAfO58upWw8YkAjVEoa3cX5+Ko2KiCBm+Rg6mj+PDgpVQPlPbx91gTL55zTP2QGpTNENHdSNQqT/cN1N81akxOISE44Id8OFNpdXyu9OaM1jKcYDqsH6EP6w9XaTgO+wf1TRmbSImyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708463081; c=relaxed/simple;
	bh=CSn0rR47mTrgEc8Sk301bbhncZGvmRgYv2wKD0Szc6Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=d3xAgSzMNyegcGfwu3cq28pUaHLUdyxtoS5vJcANBa7b7WP5DkpWWQLeVp/dThQoy6v2jKQfH0Vot7ajJTiMdOJ6zOaXlLyx4YsQyXuiysKo9XKFFMCimVgpo58YSeLJ/AvBm/qPcDqmZuyG6mhF7Swwus9u57MckM7aFv6mpf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Xor8CRcT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vVXMvjvM; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Xor8CRcT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vVXMvjvM"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 325E640203
	for <acpica-devel@lists.linuxfoundation.org>; Tue, 20 Feb 2024 21:04:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.4
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rCQjUPpuRj0w
	for <acpica-devel@lists.linuxfoundation.org>;
	Tue, 20 Feb 2024 21:04:39 +0000 (UTC)
X-Greylist: delayed 324 seconds by postgrey-1.37 at util1.osuosl.org; Tue, 20 Feb 2024 21:04:39 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 62D2540311
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 62D2540311
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=Xor8CRcT;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=vVXMvjvM
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a0a:51c0:0:12e:550::1; helo=galois.linutronix.de; envelope-from=tglx@linutronix.de; receiver=<UNKNOWN> 
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 62D2540311
	for <acpica-devel@lists.linuxfoundation.org>; Tue, 20 Feb 2024 21:04:39 +0000 (UTC)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708462752;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u21hqSyJPPttI5Wdupn9KsZ7LFUwPOf3FZzwjE066uA=;
	b=Xor8CRcTwPTSqaxO4FKKslN2jk/ojHSNTHculGtpBB1jNcLDtzMdKPK63WYFU5RZ57HQnI
	1uUoRztjwmqAbJqm/zBXBUrDkRbHGYGSJrioW6qIirJEtOtpKudjOyABlOQf3CoTreafDe
	Ip6of8Jvp7Fnd4kqiY/lPPzvzRbjCqzEwA3ZSvyF2wWyf8xRuXexUeeA973E1shLXl40u5
	1Jryfkg+L42BhQshHC3pwvG/4XzuBLzJ4paCnYcWRjdAPk85/SkILxv9Y4Q4bGPMSRHj4d
	bNrxxtCnn5zexBkWu36nHZdJgSY5c3eXo9pVdGY+tbnLeTXm1yDR9PlOYu4SHQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708462752;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u21hqSyJPPttI5Wdupn9KsZ7LFUwPOf3FZzwjE066uA=;
	b=vVXMvjvMnysVR+MWyo88LUHR5L6hT2UjdH5RZFhI+vY6FsaskvDlA/wloCfWkR9QnRegP1
	fGX+SdVpvh9+a8DA==
To: "Rafael J. Wysocki" <rafael@kernel.org>, Russell King
 <rmk+kernel@armlinux.org.uk>
Cc: linux-pm@vger.kernel.org, loongarch@lists.linux.dev,
 linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-riscv@lists.infradead.org, kvmarm@lists.linux.dev, x86@kernel.org,
 acpica-devel@lists.linuxfoundation.org, linux-csky@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-ia64@vger.kernel.org,
 linux-parisc@vger.kernel.org, Salil Mehta <salil.mehta@huawei.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>, jianyong.wu@arm.com,
 justin.he@arm.com, James Morse <james.morse@arm.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH RFC v4 02/15] ACPI: processor: Register all CPUs from
 acpi_processor_get_info()
In-Reply-To: <CAJZ5v0iiJpUWq5GMSnKFWQTzn_bdwoQz9m=hDaXNg4Lj_ePF4g@mail.gmail.com>
References: <Zbp5xzmFhKDAgHws@shell.armlinux.org.uk>
 <E1rVDmU-0027YP-Jz@rmk-PC.armlinux.org.uk>
 <CAJZ5v0iiJpUWq5GMSnKFWQTzn_bdwoQz9m=hDaXNg4Lj_ePF4g@mail.gmail.com>
Date: Tue, 20 Feb 2024 21:59:11 +0100
Message-ID: <87h6i2hmxs.ffs@tglx>
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 15 2024 at 20:22, Rafael J. Wysocki wrote:
> On Wed, Jan 31, 2024 at 5:50=E2=80=AFPM Russell King <rmk+kernel@armlinux=
.org.uk> wrote:
>> diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
>> index 47de0f140ba6..13d052bf13f4 100644
>> --- a/drivers/base/cpu.c
>> +++ b/drivers/base/cpu.c
>> @@ -553,7 +553,11 @@ static void __init cpu_dev_register_generic(void)
>>  {
>>         int i, ret;
>>
>> -       if (!IS_ENABLED(CONFIG_GENERIC_CPU_DEVICES))
>> +       /*
>> +        * When ACPI is enabled, CPUs are registered via
>> +        * acpi_processor_get_info().
>> +        */
>> +       if (!IS_ENABLED(CONFIG_GENERIC_CPU_DEVICES) || !acpi_disabled)
>>                 return;
>
> Honestly, this looks like a quick hack to me and it absolutely
> requires an ACK from the x86 maintainers to go anywhere.

That should work, but yes I agree it's all but pretty.
