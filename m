Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 186173D75A0
	for <acpica-devel@lists.linux.dev>; Fri, 27 Mar 2026 09:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774604713; cv=none; b=UPDfFp7ZnS5lVpTIndgCR+cGDwK5exEdfjoGcTA/V4l/FsgeygcZvK5uMhmusqHefede7s10jEdNo1UXRfLESGnQCOXeXMwAHOY+VAGvMspmEPD7e+qe8xcU3PjUqwIs1lZcRbGboHiXrDQ01/TB6IWOnmD0Zk/to6xghIIydkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774604713; c=relaxed/simple;
	bh=7uR5ZfLw9g5I/+7SbxvKw/jw1IUzAD9quAniYX3R718=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sXp5bVTt134gaV0QOUyzYO+d0to28b1xFDCcCd/jZO/6ly2fxNjkUMc8ORkU/+PK/EykeKHmdganPjcMjtFsEiE8zMZY4iBwL0JW4ejX0IjFkyOV0wQyMlPPv7/v67XY/rC+Sco+8sCyOSbQqAc+/lEobkeaWFzT+F+mHmFxzHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XcPbjPkz; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XcPbjPkz"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-486507134e4so22233635e9.0
        for <acpica-devel@lists.linux.dev>; Fri, 27 Mar 2026 02:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774604710; x=1775209510; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kj+hauZNh7iMjr443ejLDbgySbpC+BhPH2ZS5nH/CB0=;
        b=XcPbjPkzvDfDR+XpI+z0jjtdWMaf1QEAdAsdUwcNprEBF1mbVwo8oDgMJx8ijNGj8v
         W/5Z/iv2IYxPidJL5mex3WAcm3ZIan9VGhkoJAtibJhbirF12/kB5eLjDaFOCRRyguWx
         bGEfdpT5W7sqbWFDU+aqVyelxiNYjSWGnd1digwToanfYLtfUh5na/dcHfDv5pyABxvQ
         Y/MbtflHek4fUxoeW9wxcXfT/hhdhsHXWJjTJK+CSJY2GOtwqX6odifz30wsTa9TOO0/
         2MNORnNCw5EE33L322r/lNB8zgH9uVOaE0NY6pYzaXTJFJyht3QKXTXG3NmVKL5myeeZ
         c8Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774604710; x=1775209510;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Kj+hauZNh7iMjr443ejLDbgySbpC+BhPH2ZS5nH/CB0=;
        b=bXen04hJiP2UIltV7WB19d5NDldeOKsyYwmYR2mXRRjcX6icbsM9Ww8woG3b0A0uS5
         p/kBMM4uJrw2mcEZBj1T3eTUFPa5ss9v0Er2fHr2UQC3d4ktYIEb2SvNHIyXREkzFpAY
         xBtUoZdAYH25kVl4h5TPV4/tayCNYNiq5aquE/I4kp+Ho0zHnEPdTKqFdzmGhpqpMlhw
         PLRfoKtTQCjobPLpsUjZ197igsELvrlIZV3PWuPoZMgALsdEvBPZjfx8xiYXfWwcgLvw
         q0PyPBX5NbmQ/wYDoz9rD7H896fapOzqeuz79k1JjkC2LjFTAanVXPp3R4ByxFYUqvlA
         GmOA==
X-Forwarded-Encrypted: i=1; AJvYcCVG2tu/4W10Vft7iaxT+chSpdjKhq1ti6qEgQD4v7G8grPl2o3ycUIVItjf+jlBRrnslkK2CoM37M+0Hx4=@lists.linux.dev
X-Gm-Message-State: AOJu0YyWfjNFsL6sRzL7vEbi0Lmz9tVknCaLQRsEpTSSgK8hdRhleY66
	Q9KRMFYO1YRopA+lijMEPu01+s9Qz+untB0N3IzzbeSBrcObEMo/EV2O
X-Gm-Gg: ATEYQzw/fW7KDOWoVoXyi4eVqYVafehaRYoFFs8XegUHRDo0T0AoqQhVzHUbzH79xVk
	AqtpMiKo0ufxCUrU9t645NJxnH20fFQDik/yabiMptG5VtsBknf3gux0VVdUOeKY/Ex72VMvtax
	8xfYF3nYi/M9mqwPuZrpjDrv+cCEbPRNS1lOIiaqJwIMlYovjUvDggq/SjFglj78tobTVStBLpy
	b2ZOY596kv5cqlmwmPBWcAAM4ZuTHrJs8VE+HQuB9q1DbpPIsa7mhi8sFCd5GuK1xJHA+RW0eBS
	adH5OLSZg2Bcv/TLRyMFYnN57cZ30BsM+qdmX6BSQywJpQMaV+52gd62BD9F+TfydFq+9iINCZe
	xektsuLxQi9tfc/ACX24tUTe0SNJcIDrLweZfZ4gS2QepJ5tV9DRxh10O3/D5cYxh8Ut4kJgUJv
	4LuNPaH8NlxTn9PIXBPdXs2EA/0djE35siShDNiJDmi9xaZfRWiX8Jrf1S+SIzXuhBdZ7TAKUaW
	eQ=
X-Received: by 2002:a05:600c:6819:b0:485:40fd:8390 with SMTP id 5b1f17b1804b1-48727f238d9mr31232695e9.26.1774604710226;
        Fri, 27 Mar 2026 02:45:10 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4872718dfdfsm12370055e9.30.2026.03.27.02.45.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 02:45:09 -0700 (PDT)
Date: Fri, 27 Mar 2026 09:45:08 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Robert Moore
 <robert.moore@intel.com>, Len Brown <lenb@kernel.org>,
 linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev,
 linux-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, Petr
 Mladek <pmladek@suse.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Steven Rostedt <rostedt@goodmis.org>, Sergey Senozhatsky
 <senozhatsky@chromium.org>, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH next] ACPICA: AML Parser: Remove spurious precision from
 format used to dump parse trees
Message-ID: <20260327094508.1801bdf3@pumpkin>
In-Reply-To: <acZNuoRmQ5BrfPPd@ashevche-desk.local>
References: <20260326201830.3938-1-david.laight.linux@gmail.com>
	<acZNuoRmQ5BrfPPd@ashevche-desk.local>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 27 Mar 2026 11:28:26 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Thu, Mar 26, 2026 at 08:18:30PM +0000, david.laight.linux@gmail.com wrote:
> 
> > The debug code in acpi_ps_delete_parse_tree() uses ("%*.s", level * 4, " ")
> > to indent traces.
> > POSIX requires the empty precision be treated as zero, but the kernel treats
> > is as 'no precision specified'.
> > Change to ("%*s", level * 4, "") since there is additional whitespace and no
> > reason to indent by one space when level is zero.  
> 
> This is cross-platform code. Does the same applies to MS VC compiler, for
> example?
> 

Everything except the linux kernel will treat "%*.s" as "%*.0s".

Regardless of anything else specifying a 'precision' when printing
a constant string is entirely pointless - it limits the number of
characters copied from the string.

Basically "%*.s" is always a typo, either for "%.*s" or "%*s".

	David
