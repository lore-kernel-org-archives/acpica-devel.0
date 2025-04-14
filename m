Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A077813D531
	for <acpica-devel@lists.linux.dev>; Mon, 14 Apr 2025 16:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744647907; cv=none; b=DIRUuAJfOrF+7zge2MY6k4LutIzmY3vlLUmY+JAsfk+DyWFPjEu2ASDiJrEP2H7fIF3v5RB10O9ea8kTNQioAtqk814f8u/MG7vPFcech1exgyAzFEGVw5CWiL2fxcMfXXnh4CoTPFrc7bryQWeNv0UOeGARZu5y0+CdtdSRWFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744647907; c=relaxed/simple;
	bh=4GavI1+TUHaY/auGcGgl6ajFXeqZhKPy5GPSBRjguLc=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SgQ88IMDLGK3o9uZyErBG2XUn79xaFupm3uLoEpK3tmIx061pqMGKVRatcGK96UwXv0A9P9j2SRvHOG53Th3S6ysy3OztUTYwfC0srbwrk/8Lob53Knu+a6ocHi0LlqnaZTkoMdTyPF/uCAhQZ5i1OLFs65UHI+oWW2i/btuNfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gbuVtqXf; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gbuVtqXf"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-39c2688619bso2976169f8f.1
        for <acpica-devel@lists.linux.dev>; Mon, 14 Apr 2025 09:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744647904; x=1745252704; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J6TzHB9wqI4Z4IjYX+qsyY6yAP8RRCz8SzAbLTK3QFM=;
        b=gbuVtqXfVWEo9OPGvbpqtdpRR9bUqVraaCjjeXx91hPmj0kjaQGYildFe/NYkdYnlk
         5c8Zk5RdjYFomvUAuNCKa9s3Gpf4EA+RWcSaDUFbxnvKkltMUlukg5V5aGbWf3yNshFw
         ewTa9yv96g+PIpuDGzFvU/psEbFtr6/vkTqK2BTKa8fFEdyEuxHJm9fo0HuF6LJS4MJV
         nOzDoTUIu0j78WBvRU26WHnJU7m+dOt70Ky2+wb6ckg6ey+QYrkgAIFrzeKzQkOZ6YY7
         6Yu32FonnlIleLnB6nwvvT9gn7EUfEQelh9NDXDzJdKr+mHNi103VOP3TPZdg238parj
         LayQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744647904; x=1745252704;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J6TzHB9wqI4Z4IjYX+qsyY6yAP8RRCz8SzAbLTK3QFM=;
        b=wHLuBPPkTTPumO+cuyDpICwAni8CFkzU3kHAyAyHz1xSygfl+VwQovWjTyrRaxPbYz
         JxpfU0Q1pVJuHxj7qBf32A3wU1a/Y94nCV0F8u+OGOmD0UDHSS6xwXXSw3v6Mvzn8U3d
         TGuMwNOuDicsM4LqzhccgQ2b152c3EYOvSHgDMi1i5pDYjyaExasX6BwEAohXTN3IYtg
         vnpZeZFC9WL7Cd2DIJ/thYSF/Gmn67yUziymji6Z3i7H0qWIvfyS3FsZBVeZK0WpO2Da
         I6pkMwJtSdSKyg+D7ot4iOQ21n/OROkVJTi2srBHl2Y3Z1UW5DCeL3y08z8uohRsw1mk
         uvwA==
X-Forwarded-Encrypted: i=1; AJvYcCWIXqsNbKcwBQ1rJajMFuWyUXpoMXucSgU8KeIMJg2UyV1UqPH2hv06AQ4Y0bmweTrFmO0re/dIzvi8wX0=@lists.linux.dev
X-Gm-Message-State: AOJu0Yze1whvWpc1i00BhRKSzYn7eVvKHnrLBQzQ8ProqM5zAM9DhiK3
	z7L7L+m9z9rOi7bF97Xx/r2CDlduUQQ3GwaZ1/PVlEm4uG7DxbOQ
X-Gm-Gg: ASbGncsHWk897LHJm3CfvqvTWGaKnNygz5pe0K15giytxAP9NPIj2sxHK+XmMZL6O9Y
	u0HkeXBBWRWk6zSB1gUxhjvp0JV5eJ+22mUZkr9/nd2zZCmrkNrbbfbFoq0yQoxRhHJZr+KK4HQ
	OXdNWs/qSgvBH9oyCECgr3BMXLDu3SaUqXBUr1Tge80qTTz8m8x7vku97pMuPaIvc0VDdYeLfKy
	9J/981MAYGK8tiJww5AJXcWBbabBk/FMReSFQOz7QjfE71xRSCJv2peYrtCSmHoGmQjUAYpTPvZ
	j2eth2bSt1/oDe7AClx1SnOMh/x05MEegdbMog9lMduE
X-Google-Smtp-Source: AGHT+IHkZKXxX+remWMvdQHLVO0MZupgIBRz8YvABVN+xIyy4Qq2XhC0HDU5CGN3jzT6yP507wdd8g==
X-Received: by 2002:a05:6000:400a:b0:38d:b325:471f with SMTP id ffacd0b85a97d-39ea52035eemr10832220f8f.15.1744647903429;
        Mon, 14 Apr 2025 09:25:03 -0700 (PDT)
Received: from gmail.com ([103.210.134.105])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39eaf43ce0asm11508888f8f.70.2025.04.14.09.24.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 09:25:03 -0700 (PDT)
Date: Mon, 14 Apr 2025 21:54:52 +0530
From: Brahmajit <brahmajit.xyz@gmail.com>
To: Robert Moore <robert.moore@intel.com>, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, 
	acpica-devel@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] ACPI: Fix building with GCC 15
Message-ID: <kjxkqexdkyesepwtyjsp2uuo73r65msvhl7ccxt77wv722gw3j@7ekim6v5clrh>
References: <20250414161644.30400-1-listout@listout.xyz>
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250414161644.30400-1-listout@listout.xyz>

On 14.04.2025 21:46, Brahmajit Das wrote:
> Since the Linux kernel initializes many non-C-string char arrays with
> literals. While it would be possible to convert initializers from:
>    { "BOOP", ... }
> to something like:
>    { { 'B', 'O', 'O', 'P' }, ... }
> that is annoying.
> Making -Wunterminated-string-initialization stay silent about char
> arrays marked with nonstring would be much better.
> 
> Without the __attribute__((nonstring)) we would get the following build
> error:
> 
> ...
> drivers/acpi/acpica/acpredef.h:903:11: error: initializer-string for array of ‘char’ truncates NUL terminator but destination lacks ‘nonstring’ attribute (5 chars into 4 available) [-Werror=unterminated-string-initialization]
>   903 |         {{"_S3D", METHOD_0ARGS,
>       |           ^~~~~~
> drivers/acpi/acpica/acpredef.h:906:11: error: initializer-string for array of ‘char’ truncates NUL terminator but destination lacks ‘nonstring’ attribute (5 chars into 4 available) [-Werror=unterminated-string-initialization]
>   906 |         {{"_S4D", METHOD_0ARGS,
>       |           ^~~~~~
> 
> and,
> 
> ...
> drivers/acpi/acpica/nsrepair2.c:115:10: error: initializer-string for array of ‘char’ truncates NUL terminator but destination lacks ‘nonstring’ attribute (5 chars into 4 available) [-Werror=unterminated-string-initialization]
>   115 |         {"_ALR", acpi_ns_repair_ALR},
>       |          ^~~~~~
> drivers/acpi/acpica/nsrepair2.c:116:10: error: initializer-string for array of ‘char’ truncates NUL terminator but destination lacks ‘nonstring’ attribute (5 chars into 4 available) [-Werror=unterminated-string-initialization]
>   116 |         {"_CID", acpi_ns_repair_CID},
> ...
> 
> Upstream GCC has added this commit
> 622968990beee7499e951590258363545b4a3b57[0][1] which silences warning
> about truncating NUL char when initializing nonstring arrays.
> 
> [0]: https://gcc.gnu.org/cgit/gcc/commit/?id=622968990beee7499e951590258363545b4a3b57
> [1]: https://gcc.gnu.org/cgit/gcc/commit/?id=afb46540d3921e96c4cd7ba8fa2c8b0901759455
> 
> Thanks to Jakub Jelinek <jakub@gcc.gnu.org> for the gcc patch.
> 
> Signed-off-by: Brahmajit Das <listout@listout.xyz>
> ---
>  drivers/acpi/acpica/aclocal.h   |  4 ++--
>  drivers/acpi/acpica/nsrepair2.c |  2 +-
>  drivers/acpi/tables.c           | 28 +++++++++++++++-------------
>  include/acpi/actbl.h            |  3 ++-
>  4 files changed, 20 insertions(+), 17 deletions(-)
> 
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
>  	u16 argument_list;
>  	u8 expected_btypes;
>  };
> @@ -370,7 +370,7 @@ typedef acpi_status (*acpi_object_converter) (struct acpi_namespace_node *
>  					      converted_object);
>  
>  struct acpi_simple_repair_info {
> -	char name[ACPI_NAMESEG_SIZE];
> +	char name[ACPI_NAMESEG_SIZE] __attribute__((nonstring));
>  	u32 unexpected_btypes;
>  	u32 package_index;
>  	acpi_object_converter object_converter;
> diff --git a/drivers/acpi/acpica/nsrepair2.c b/drivers/acpi/acpica/nsrepair2.c
> index 1bb7b71f07f1..a28b1fa2b1ea 100644
> --- a/drivers/acpi/acpica/nsrepair2.c
> +++ b/drivers/acpi/acpica/nsrepair2.c
> @@ -25,7 +25,7 @@ acpi_status (*acpi_repair_function) (struct acpi_evaluate_info * info,
>  				     return_object_ptr);
>  
>  typedef struct acpi_repair_info {
> -	char name[ACPI_NAMESEG_SIZE];
> +	char name[ACPI_NAMESEG_SIZE] __attribute__((nonstring));
>  	acpi_repair_function repair_function;
>  
>  } acpi_repair_info;
> diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
> index 2295abbecd14..27104cbb48b5 100644
> --- a/drivers/acpi/tables.c
> +++ b/drivers/acpi/tables.c
> @@ -396,19 +396,21 @@ static u8 __init acpi_table_checksum(u8 *buffer, u32 length)
>  }
>  
>  /* All but ACPI_SIG_RSDP and ACPI_SIG_FACS: */
> -static const char table_sigs[][ACPI_NAMESEG_SIZE] __initconst = {
> -	ACPI_SIG_BERT, ACPI_SIG_BGRT, ACPI_SIG_CPEP, ACPI_SIG_ECDT,
> -	ACPI_SIG_EINJ, ACPI_SIG_ERST, ACPI_SIG_HEST, ACPI_SIG_MADT,
> -	ACPI_SIG_MSCT, ACPI_SIG_SBST, ACPI_SIG_SLIT, ACPI_SIG_SRAT,
> -	ACPI_SIG_ASF,  ACPI_SIG_BOOT, ACPI_SIG_DBGP, ACPI_SIG_DMAR,
> -	ACPI_SIG_HPET, ACPI_SIG_IBFT, ACPI_SIG_IVRS, ACPI_SIG_MCFG,
> -	ACPI_SIG_MCHI, ACPI_SIG_SLIC, ACPI_SIG_SPCR, ACPI_SIG_SPMI,
> -	ACPI_SIG_TCPA, ACPI_SIG_UEFI, ACPI_SIG_WAET, ACPI_SIG_WDAT,
> -	ACPI_SIG_WDDT, ACPI_SIG_WDRT, ACPI_SIG_DSDT, ACPI_SIG_FADT,
> -	ACPI_SIG_PSDT, ACPI_SIG_RSDT, ACPI_SIG_XSDT, ACPI_SIG_SSDT,
> -	ACPI_SIG_IORT, ACPI_SIG_NFIT, ACPI_SIG_HMAT, ACPI_SIG_PPTT,
> -	ACPI_SIG_NHLT, ACPI_SIG_AEST, ACPI_SIG_CEDT, ACPI_SIG_AGDI,
> -	ACPI_SIG_NBFT };
> +static const char table_sigs[][ACPI_NAMESEG_SIZE] __initconst
> +	__attribute__((nonstring)) = {
> +		ACPI_SIG_BERT, ACPI_SIG_BGRT, ACPI_SIG_CPEP, ACPI_SIG_ECDT,
> +		ACPI_SIG_EINJ, ACPI_SIG_ERST, ACPI_SIG_HEST, ACPI_SIG_MADT,
> +		ACPI_SIG_MSCT, ACPI_SIG_SBST, ACPI_SIG_SLIT, ACPI_SIG_SRAT,
> +		ACPI_SIG_ASF,  ACPI_SIG_BOOT, ACPI_SIG_DBGP, ACPI_SIG_DMAR,
> +		ACPI_SIG_HPET, ACPI_SIG_IBFT, ACPI_SIG_IVRS, ACPI_SIG_MCFG,
> +		ACPI_SIG_MCHI, ACPI_SIG_SLIC, ACPI_SIG_SPCR, ACPI_SIG_SPMI,
> +		ACPI_SIG_TCPA, ACPI_SIG_UEFI, ACPI_SIG_WAET, ACPI_SIG_WDAT,
> +		ACPI_SIG_WDDT, ACPI_SIG_WDRT, ACPI_SIG_DSDT, ACPI_SIG_FADT,
> +		ACPI_SIG_PSDT, ACPI_SIG_RSDT, ACPI_SIG_XSDT, ACPI_SIG_SSDT,
> +		ACPI_SIG_IORT, ACPI_SIG_NFIT, ACPI_SIG_HMAT, ACPI_SIG_PPTT,
> +		ACPI_SIG_NHLT, ACPI_SIG_AEST, ACPI_SIG_CEDT, ACPI_SIG_AGDI,
> +		ACPI_SIG_NBFT
> +	};
>  
>  #define ACPI_HEADER_SIZE sizeof(struct acpi_table_header)
>  
> diff --git a/include/acpi/actbl.h b/include/acpi/actbl.h
> index 451f6276da49..88ba1b978053 100644
> --- a/include/acpi/actbl.h
> +++ b/include/acpi/actbl.h
> @@ -66,7 +66,8 @@
>   ******************************************************************************/
>  
>  struct acpi_table_header {
> -	char signature[ACPI_NAMESEG_SIZE];	/* ASCII table signature */
> +	char signature[ACPI_NAMESEG_SIZE]
> +		__attribute__((nonstring)); /* ASCII table signature */
>  	u32 length;		/* Length of table in bytes, including this header */
>  	u8 revision;		/* ACPI Specification minor version number */
>  	u8 checksum;		/* To make sum of entire table == 0 */
> -- 
> 2.49.0
> 

Do I need to send the acpica part to GitHub first?

-- 
Regards,
listout
