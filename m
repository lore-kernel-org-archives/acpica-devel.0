Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4983022157E
	for <acpica-devel@lists.linux.dev>; Tue, 15 Apr 2025 18:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744740302; cv=none; b=PTy14nwaiSHel9Z4s3t3LB3pSuSBHGyiYl3t6IER6PfGVAZcY8qCsx43QLsHupnT+STi5277uYDr2S0Wk7EW+LU8RW56hffYm54fq7Dl2svWs7EUM0LL1cScQTW8H7th9DBbVqNEiYggJY2dtcu8vWox6dQR4Ike44G8qFUSeDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744740302; c=relaxed/simple;
	bh=bSIH+zqpDkmwA6RNwqFHsidqqNTR1psChK3N90ojLYM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L8pWRICgv9LD1BUwRItbMacNRhdrWXmagM5TSHd2u/CWmjNs2IeotQUAWgxQJiJQLbqjGRlI+qRiwf4fVDOYXbCvtnFqYs80qwPvjCqfiGctf+XGOVB4o/nOdQiFDrB/O7NMk2F4R5s9AqsRxfpS68GUhj6tswFtC6uS+P6el4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ps/lYTrb; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ps/lYTrb"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43cebe06e9eso44758695e9.3
        for <acpica-devel@lists.linux.dev>; Tue, 15 Apr 2025 11:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744740299; x=1745345099; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RAA5GsUBd1AyUaSODfHnhDVrxDoRhK+SaJ6cRkLQ9hE=;
        b=Ps/lYTrbA6wpLfHgX26xXKc+ycsbmMH2RTo/B7vT1v32HNZL2jQ7BXBnKfhbvOIIt7
         FQyYY/PpxXxLc7MaCHd6s1mOJKktogltURQI3I0VuOdHivreTej0e53NFYHFivXcVcV3
         HbBGyx4b+p/1faoevJ7hQkSJe/Jqg064x/4NXhooLb+O5jTTqoQW51FqOxFLvj9uw1Fh
         fMsCvpdpMtlwn2jRM/qJAP8cvRPEpEtjZ3F+W0yiMFEopzOUt8kLIznBQuyozs13ws+O
         na5PjIrtMuleEGFJFDkYAY6o/Pn1XwOiWSdVCr3OEpLH5mbVz08qI/CFdhNZx5i8Sz9c
         VlLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744740299; x=1745345099;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RAA5GsUBd1AyUaSODfHnhDVrxDoRhK+SaJ6cRkLQ9hE=;
        b=eq7Bieb3qBgULS+dzTOCJ9O/T0Xe8CRMLUACkqcDuerQRVALcGz8E32uksAM2sGnSi
         tpkWseBRrqSdxJ45qonhUjW1N5s/EwDs1Y3U5iPA3I+gna9k/T4Swc+yXPK9YxTHMMzJ
         yv5S8TEpnlXvkLI4TsasRbAJgjUQFCcBmTJcJ3d/+JAAF+9cwFEKiOV6E7gYfgKFESVn
         iKiEBxhh5WJoPSsTJdmwDWFEzbqERqclZFDD7mH8oQ6l6ndoT1kATvHk8enZkYiaZSiC
         sjHWvHHI1M98+7TmEdQPmIzzz+i68DXWl91VSSDzz6LoSST4J7dxg6YWKPFjNBHnM8Bu
         OdRQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJiK8NOSltZg70q235+ybSIAnCgkK4/v5RRq+993UuxIPWbf608dLgyoPUEjoOzzYGe1P3CMzUVZmwXuE=@lists.linux.dev
X-Gm-Message-State: AOJu0YzzZJjS6d0eBbXhLFtsmH3QbI2rxkdDWB8OtjBsQY6kR3esB7Om
	N+ioMY4UDjT9qX9hYfnTKzOa1+cK5TuzMk8V9gGaC0OCuUp9lFwU
X-Gm-Gg: ASbGnctxSS00LtLQKqV8+TCjz5f6Z+oiocaWpJucx1UxHwjdITq88g3r0TXDSox2Y++
	gJyDt/inH60LF0MsECeaUm7WZPPNvJqtwTksw3aaUW692bz3xKIjEt/psrd24EJSik2riDptN7b
	SXsgjRP63ooQnve+7OWxf7JPadZ9c9MdCEdGLCauSKPqZcDdJ03lXLgOJoiaDOMdo8lXS6IQ0yh
	6zGItxqLNariTlDk9vmVFg32Ki/Zc/Ze1Eq3zoa8a/WGEKyAfJ40eW2PHNOtIUoG9J8xHABYVq5
	Dc4Nnu/jOc+hzHINoSuIxiN/3Fquqursng8gG3i1dbYh97XqYZGBUBemHxLxC7XFSEa9nNGVnXv
	F6cI=
X-Google-Smtp-Source: AGHT+IFc3g8QQ9k9lgukZ0sd7DIp2WxsNbtPZklAM2PLk9fBgcH1wwc0A6XRSO71CM8ag9ErKBZWTA==
X-Received: by 2002:a05:600c:1f8d:b0:43d:db5:7b1a with SMTP id 5b1f17b1804b1-4405a0064d6mr892895e9.12.1744740299439;
        Tue, 15 Apr 2025 11:04:59 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f2066d6e8sm225626635e9.23.2025.04.15.11.04.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 11:04:58 -0700 (PDT)
Date: Tue, 15 Apr 2025 19:04:57 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Brahmajit Das <brahmajit.xyz@gmail.com>
Cc: Robert Moore <robert.moore@intel.com>, "Rafael J. Wysocki"
 <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>,
 linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] ACPI: Fix building with GCC 15
Message-ID: <20250415190457.351e22a1@pumpkin>
In-Reply-To: <20250414161644.30400-1-listout@listout.xyz>
References: <20250414161644.30400-1-listout@listout.xyz>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 14 Apr 2025 21:46:42 +0530
Brahmajit Das <brahmajit.xyz@gmail.com> wrote:

> Since the Linux kernel initializes many non-C-string char arrays with
> literals. While it would be possible to convert initializers from:
>    { "BOOP", ... }
> to something like:
>    { { 'B', 'O', 'O', 'P' }, ... }
> that is annoying.
> Making -Wunterminated-string-initialization stay silent about char
> arrays marked with nonstring would be much better.
...
> diff --git a/drivers/acpi/acpica/aclocal.h b/drivers/acpi/acpica/aclocal.h
> index 6f4fe47c955b..d2cda1b35e59 100644
> --- a/drivers/acpi/acpica/aclocal.h
> +++ b/drivers/acpi/acpica/aclocal.h
> @@ -293,7 +293,7 @@ acpi_status (*acpi_internal_method) (struct acpi_walk_state * walk_state);
>   * expected_return_btypes - Allowed type(s) for the return value
>   */
>  struct acpi_name_info {
> -	char name[ACPI_NAMESEG_SIZE];
> +	char name[ACPI_NAMESEG_SIZE] __attribute__((nonstring));

Doesn't than generate an 'unknown attribute' error on older compilers?

Does:
	typedef char char_nonstring __attribute__((nonstring));
	char_nonstring name[4] = "abcd";
work?

If so the attribute could even be applied to 'u8'.

	David
