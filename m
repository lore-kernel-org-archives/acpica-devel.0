Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A6515AAD6
	for <acpica-devel@lists.linux.dev>; Wed, 10 Apr 2024 21:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712783590; cv=none; b=Ryogxj/U7qiYV7eBogE2HrWJTrH/FUtntZZUXcrjqv7kUNK5yhPL6VUxhj4LoV2IVLcfhAGpTgtqV+ym8EnAcC1/hv6n0Ubu4EbbBhSF8uxro5V0Y0r96STxpwEN2L/P8ajokPgEDVcM0jK7nOfZL6TND+UpcmsFjYnKR/GKWno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712783590; c=relaxed/simple;
	bh=5ydEIu4NwxWWsRaT80Gi5impoOhDMVhIgWRTaHPvrF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XVk7EamabXdcU6yvBWtEqgss3Pj3RaTHJEFz+shkbD2eFM08af2L8KXQGhTK89xLLINU6M/EN6oL2rxdhi0+Rie9asSwgMb8KxloVVlnwoB7gYvCkAbGarD8uwPB+voRvdb9ewT5DpaIZg0HBFowFaciApPvO5ZeneifH5wR4oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KX1PkAqr; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KX1PkAqr"
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-36a0f64f5e0so23251235ab.3
        for <acpica-devel@lists.linux.dev>; Wed, 10 Apr 2024 14:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712783588; x=1713388388; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=k5/mcIJWzR1Sz/R2oHW9ifvaeJ91v7JM0iP/2A/JiCg=;
        b=KX1PkAqr/duTEtRXxuRwRzIJm3TNcbGaI+ryO82bUKFcI0Yoz3amRc/ftGMX9zq6gf
         n236JGXrNtCGEG4tXKQ2cJfeQfM2EMH6807l4cCXLYRpOyysGw/y38QBehcA/lRmr063
         mf7+dPJTB4PDCzKJwmpkolNW7OYIlbWQsLZ93pezeaHZYpwC/KlI9M+fLhBP6K5SEwHj
         e4GfmkFw53u3umNxjAaW0StRhjAgea/SjuP16uqJ2SR5XTRm5Dogq8zMsbbcr5B1l49S
         r5jE3BHXCw7MM/CMYsh9PBgt71rB3LXZZM+H1GyZ2D9HwTtGM08jZrX2zmxgklbLV2Jm
         EjtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712783588; x=1713388388;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k5/mcIJWzR1Sz/R2oHW9ifvaeJ91v7JM0iP/2A/JiCg=;
        b=qt43NyGHxhf5SHrzA6k9v0cZUrvW+8K8XFAcIsZq7ICgUgXvQm4zAdkZTmEh7yXZBN
         TGCbjvhIXsmTxSd9L/0c9rkSypnXm5xpkFMAclU+LIHNsMnD4ggvqWLKDAHreYmqsWIJ
         CxfX5BFtMj7Vu1u3jDvJcOKt8EiJaOjYCZAQiDGvbaKDvF/rfoypws7LiF97p2pqbuUv
         7W52sbSf+PxCfTc4e2ljYcfHp3nxE376XFvAvzpqLSBe8fkpjSzbOm2g6rJwoI54eH10
         eKTKzeTglVAcKNZHr2kGa+06mg/EAx7kf1dSHKVTMJ6UZ6sKGD/JuZiWcRlfuzsNQQBe
         g7hQ==
X-Forwarded-Encrypted: i=1; AJvYcCUo4kYI0m2RsEUTGxf1IRXLfUusovzf/NpGzydfEDzccy5d0Gt/FIVwk0I2C08dooRVmbVScnIw7k4LNxSp3Vmo6F3tRed5TF6pw3JM
X-Gm-Message-State: AOJu0YzUdY87BMBag2OXserc5wfV8v3mHbNZDNFkCLdVlt9PqOHR/Im/
	JCnaGCSvoFxOmYXsiLKLw9SKY0tDlUZuFta4KaS9FG0Oqbso8Z6+d782ctoQWg==
X-Google-Smtp-Source: AGHT+IGpHuPTnJ+wxQMsV1XcgPUkjimJl+2RrlfGnCAGUQlqpTB1RQcYuHk2y6FkjRIkT4ntypW3jg==
X-Received: by 2002:a05:6e02:1d88:b0:36a:1eed:f105 with SMTP id h8-20020a056e021d8800b0036a1eedf105mr4448912ila.1.1712783588250;
        Wed, 10 Apr 2024 14:13:08 -0700 (PDT)
Received: from google.com (30.64.135.34.bc.googleusercontent.com. [34.135.64.30])
        by smtp.gmail.com with ESMTPSA id fg1-20020a056638620100b00482a9f7066csm1313094jab.151.2024.04.10.14.13.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 14:13:07 -0700 (PDT)
Date: Wed, 10 Apr 2024 21:13:05 +0000
From: Justin Stitt <justinstitt@google.com>
To: Arnd Bergmann <arnd@kernel.org>
Cc: linux-kbuild@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, 
	Richard Russon <ldm@flatcap.org>, Jens Axboe <axboe@kernel.dk>, 
	Robert Moore <robert.moore@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
	Len Brown <lenb@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Masahiro Yamada <masahiroy@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, 
	Lin Ming <ming.m.lin@intel.com>, Alexey Starikovskiy <astarikovskiy@suse.de>, 
	linux-ntfs-dev@lists.sourceforge.net, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] [v2] blktrace: convert strncpy() to strscpy_pad()
Message-ID: <ghua3jruo4xm3tj55wafwok4aveter2ychgu4lmw3k5rzkg656@np4aozq7mhbl>
References: <20240409140059.3806717-1-arnd@kernel.org>
 <20240409140059.3806717-5-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240409140059.3806717-5-arnd@kernel.org>

Hi,

On Tue, Apr 09, 2024 at 04:00:57PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> gcc-9 warns about a possibly non-terminated string copy:
> 
> kernel/trace/blktrace.c: In function 'do_blk_trace_setup':
> kernel/trace/blktrace.c:527:2: error: 'strncpy' specified bound 32 equals destination size [-Werror=stringop-truncation]
> 
> Newer versions are fine here because they see the following explicit
> nul-termination. Using strscpy_pad() avoids the warning and
> simplifies the code a little. The padding helps  give a clean
> buffer to userspace.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Justin Stitt <justinstitt@google.com>

> ---
> v2: actually use padding version of strscpy.
> ---
>  kernel/trace/blktrace.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
> index d5d94510afd3..8fd292d34d89 100644
> --- a/kernel/trace/blktrace.c
> +++ b/kernel/trace/blktrace.c
> @@ -524,8 +524,7 @@ static int do_blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
>  	if (!buts->buf_size || !buts->buf_nr)
>  		return -EINVAL;
>  
> -	strncpy(buts->name, name, BLKTRACE_BDEV_SIZE);
> -	buts->name[BLKTRACE_BDEV_SIZE - 1] = '\0';
> +	strscpy_pad(buts->name, name, BLKTRACE_BDEV_SIZE);
>  
>  	/*
>  	 * some device names have larger paths - convert the slashes
> -- 
> 2.39.2
> 

Thanks
Justin
