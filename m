Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C77040852;
	Thu, 28 Mar 2024 17:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711648512; cv=none; b=CYTMQS/zoUyc2RZxSMYR4qelqGW5bf/x5sjQ62QTm+uRnPLf8nDDPEqioJwoyl00mxBL4fQ5rf72IZh7VuxPQI1J5Yoyj7JQjuNNKArMgXiXJRyzrAFoiIvoG/zapt7CEzpIrTWNj9wczmuP5/ZIW18a3Vgq91Ivc3tAzHD/EXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711648512; c=relaxed/simple;
	bh=o/ViFlzn9DcSB6zcA7kLtK65QCPH/Ss4D4l1HH9emKY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qp3gRY+mBkqKv6pmLXP6ISa1//f9MbZliapH+/irw3ssTL02eMwD/AVllUrx6yRDq6OO+holO5Y+mf5v7ScJUN7LY7TthnoWS6HbwZjgVm6yy8iXHwGW+32KpKDoBXUSxLb4d0AjiruXxcZKihacu6ewvgWSShA6rfOdnhLFeY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E+m1YKOP; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E+m1YKOP"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-5cddfe0cb64so739441a12.0;
        Thu, 28 Mar 2024 10:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711648511; x=1712253311; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yWQ5s/MasTSk4jjQrdrW05L8Qpoj2heGIDr+tGSERBM=;
        b=E+m1YKOPeD+ocO+LjdpZ1c0sYd44o0N0iH29BCIQpeP5uCXkl7JY+TzjvM27fhn1fr
         1Osg6egtcCtZyhR+wTQ9k50/fuoX7eXEqNSlPm3ny50dORi87nWEdTxGdPrH4Uxgch5V
         afRkqeP7cV2Tbf9nXGLcMegWUo5kpaBGrx7ZruTDNIaXiLT+Tr6HXxvpghw2Ui/g0vZw
         p/9SFG5V9S5IlYycnHxVex8LRXrZFFMjngQRCK2C88OZWh/ah1t5oLWGFtzd2IBMzdzD
         NfhxR54FM9Tr3sAFUqwAHQXtCw6GY5ywLM80AGN+EgJxWORxt+LNK2TTTZJcHJ+ZlEZJ
         SrzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711648511; x=1712253311;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yWQ5s/MasTSk4jjQrdrW05L8Qpoj2heGIDr+tGSERBM=;
        b=RHB179moB5pzMnKUPUFJp8iN+/9R6uDb0/RIBu7wMfVpj/D9nQZtTUNltXfZ4iS3+8
         u8/Q2wbIEUW/t+QNpO1MheVcGbaVYMmyGiRuke2JMlfozk44BDm2/z+C43lcPNKD9B6p
         +ba1HKYdQvNL4dqKbok6y3pclQT9K12rh9huBInHKPl7GPRoi2GzIe+55NgB8yhZYHKX
         XXf+G0SYvHAV4pTQFOH5nFICWcJ4K3jmJV+R/4LoxtLdq/OT5z272pEB20VvdkknI6qz
         xZQ1Dwjy2n9YemLEZvSPSXoPXW+WqPsWIZzwG5/N4+pkP2oIHci9Ce/ehYEsvYbwmMj6
         pIUQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0oDjgk+Eiv3hQwqiNa6rsd1ttWtPXZXny1yRAgSbh606kwtWWyVOzxAJFLRiNMC5Bt61rcvlJPRaUhxzGZjOKpZdxJs73YQCsMzOsAXk6VwWBbQHhqhfJ8HlV/TsW+JmzK/rP3/i/8GFt1oMN
X-Gm-Message-State: AOJu0Yw4dpK6NA8QDzsvjrZAUsiKxbV481pEx2UlVIAgZyDF+ldyT6s6
	3nfuWn0K8QkoZWBQUZWidTkqQZspkaTR+7Zlab3tjK2417rTdXDQ
X-Google-Smtp-Source: AGHT+IEL2KsBed1zz8v9qIzuDDeEt0qqVBch3QKL5XMgY1v1rvbtZioXqmZcYbMTotvgHuw38SY6bw==
X-Received: by 2002:a17:90a:e7c6:b0:29b:d748:fae5 with SMTP id kb6-20020a17090ae7c600b0029bd748fae5mr155051pjb.32.1711648510684;
        Thu, 28 Mar 2024 10:55:10 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:493e:82a3:49f9:d88])
        by smtp.gmail.com with ESMTPSA id z2-20020a17090ab10200b0029c7963a33fsm3791215pjq.10.2024.03.28.10.55.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 10:55:10 -0700 (PDT)
Date: Thu, 28 Mar 2024 10:55:07 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	Robert Moore <robert.moore@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Benson Leung <bleung@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Corentin Chary <corentin.chary@gmail.com>,
	"Luke D. Jones" <luke@ljones.dev>,
	Hans de Goede <hdegoede@redhat.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>,
	Daniel Oliveira Nascimento <don@syst.com.br>,
	Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
	Matan Ziv-Av <matan@svgalib.org>,
	Mattia Dongili <malattia@linux.it>,
	Azael Avalos <coproscefalo@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Jeff Sipek <jsipek@vmware.com>, Ajay Kaher <akaher@vmware.com>,
	Alexey Makhalov <amakhalov@vmware.com>,
	VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
	Theodore Ts'o <tytso@mit.edu>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	acpica-devel@lists.linux.dev, linux-input@vger.kernel.org,
	netdev@vger.kernel.org, chrome-platform@lists.linux.dev,
	platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH 02/19] Input: atlas: - drop owner assignment
Message-ID: <ZgWu-33aKyCOjRBX@google.com>
References: <20240327-b4-module-owner-acpi-v1-0-725241a2d224@linaro.org>
 <20240327-b4-module-owner-acpi-v1-2-725241a2d224@linaro.org>
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240327-b4-module-owner-acpi-v1-2-725241a2d224@linaro.org>

On Wed, Mar 27, 2024 at 08:43:49AM +0100, Krzysztof Kozlowski wrote:
> ACPI bus core already sets the .owner, so driver does not need to.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

But please fix the stray colon in the subject.

> 
> ---
> 
> Depends on the first patch.
> ---
>  drivers/input/misc/atlas_btns.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/input/misc/atlas_btns.c b/drivers/input/misc/atlas_btns.c
> index 3c9bbd04e143..5b9be2957746 100644
> --- a/drivers/input/misc/atlas_btns.c
> +++ b/drivers/input/misc/atlas_btns.c
> @@ -127,7 +127,6 @@ MODULE_DEVICE_TABLE(acpi, atlas_device_ids);
>  static struct acpi_driver atlas_acpi_driver = {
>  	.name	= ACPI_ATLAS_NAME,
>  	.class	= ACPI_ATLAS_CLASS,
> -	.owner	= THIS_MODULE,
>  	.ids	= atlas_device_ids,
>  	.ops	= {
>  		.add	= atlas_acpi_button_add,
> 
> -- 
> 2.34.1
> 

-- 
Dmitry
