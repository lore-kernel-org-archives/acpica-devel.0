Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997FD6A35A
	for <acpica-devel@lists.linux.dev>; Wed, 20 Mar 2024 18:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710957612; cv=none; b=uBQHy8xzspcFfsWFQUrPQXDRBLCiCEg0ajMpM/uTH9uE76gsVa0LqxdVBjA7zXeCowTEZGeK9gRiNiMWkGLyL9LMepmnHRqi8EVLm6aIXvGuYBGF0sdg/cX17Gkq9RN73Fgs55DZBRSTD18MaDPMGubAAvzIEK9ax5pqANitaIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710957612; c=relaxed/simple;
	bh=u2ficWTRB7/C92TP0dSjSn7oEUj3yvr5zCepFHQnHIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IfGgBbI5smJWX4engQfi4JdFJAmPq0Osy+ZT5C6QVy7MzDfRplBt44p21/msGfbiPPtfS5o9jsoinXBVaCCeCUt7af+4QlNS0kezddIyUEFB4MsTQV7CM/VYSl2O8O3Tm07wqUPEuw+s9OsHzW0902ECdeeWmnlyCrt+keCDPKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aEDneT7k; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aEDneT7k"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6e6a9fafacdso178331b3a.2
        for <acpica-devel@lists.linux.dev>; Wed, 20 Mar 2024 11:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710957610; x=1711562410; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zEaZmuSwz46Hcw3JWMaFjB/vxwT2qH65FH7pBddW/iU=;
        b=aEDneT7k2PgwmQFEv9T3LOWPYJlB2KIZamQzxZnTAbHIx07c9xCMbspHLa9/UNg/+n
         lEfbgE+rgjtF0z/mvlLrGnBW4H6vgGYlLgV8k82mUqdapfGCU4wWP3+vLTQdWb8gdrSc
         r1m1bsV8og6Iu0u1m0BUXgAffO8Fv7IJGTg4kGKaEVaNgAU0fltErkz7jFId9pHK2ceq
         pa6wbyXe2I7dbeNQYFYyHWPHrwrzAgJ3BX3MP7G/r+6zBloYva6aAwYlabzjWKxSKf2T
         EYbAeLY6sJhKnVdxeFan3nk+DDMPg1vTBBLtK/b7Cp0ZUPA18bO2p5pinuX7EqDzpCTt
         JdEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710957610; x=1711562410;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zEaZmuSwz46Hcw3JWMaFjB/vxwT2qH65FH7pBddW/iU=;
        b=DdJxtqPm2iy/zhS5/pG66s7FEXNkfQ4omoDBScsJOvsKd1VJT6uleULcn+Hz3EDM/g
         D0cDWWhf2JrqpAecQfHEjyPRcAM4FgWEDvTHdyxHpzijcQ3gf3rV7H69l9q4IsbCDhKf
         TsvACYG4R+78O618W20wTfpcDZoeRAukpYRVYZhmiKGTyrPNJbwdC50TvMAoqBdAeLKP
         VTpqeurH7r2BiUd52kNLs9+HSOOaEShk0t478nRbafJugiwm1Tay+azsIj6MHIT2Vis9
         fa9meSUvoZkM9Ilqbx49oIjKRWNAG6V8W/80JbsRSiOnyqB1kcw3CpjhpJfi3V60a3SW
         VMuQ==
X-Forwarded-Encrypted: i=1; AJvYcCURuvtvJ4LNPon028pPMv9HUroNtjQcXbNMDrhSNV9vV+5GTJkclQz21iRelF4s8PBJVaEkNu5X5M4jMRBiwCiAa11K+nbYggfepYFa
X-Gm-Message-State: AOJu0Yy7YA4uvX2sLYE1kghgJalxgY20BcBAOTqt0gqtRVAuKu8H5ggx
	1jKmIali3f8FK6DBRFaqrnPjZVUGtvOVQiHRkaZute6xIO8Eu20C
X-Google-Smtp-Source: AGHT+IEmAvWRUh6LSC9BFmM0+cCgly0PVhJKwMHdEfzIHpTtRrsZ3MGXZQIy44f3qojeizWQddZYgw==
X-Received: by 2002:a05:6a00:a12:b0:6e6:e587:3c30 with SMTP id p18-20020a056a000a1200b006e6e5873c30mr19298221pfh.25.1710957609975;
        Wed, 20 Mar 2024 11:00:09 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s40-20020a056a0017a800b006e74a85f862sm3053167pfg.146.2024.03.20.11.00.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 11:00:09 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 20 Mar 2024 11:00:08 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: rafael@kernel.org, lenb@kernel.org, jdelvare@suse.com,
	robert.moore@intel.com, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH v5 1/2] ACPI: IPMI: Add helper to wait for when SMI is
 selected
Message-ID: <f7ed4f78-b5cb-4a46-9c13-d67af3ba0700@roeck-us.net>
References: <20240320084317.366853-1-kai.heng.feng@canonical.com>
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240320084317.366853-1-kai.heng.feng@canonical.com>

On Wed, Mar 20, 2024 at 04:43:16PM +0800, Kai-Heng Feng wrote:
> On Dell servers, many APCI methods of acpi_power_meter module evaluate
> variables inside IPMI region, so the region handler needs to be
> installed. In addition to that, the handler needs to be fully
> functional, and that depends on SMI being selected.
> 
> So add a helper to let acpi_power_meter know when the handler is
> installed and ready to be used.
> 
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Applied to hwmon-next.

Please note that I'll push the branch after the commit window closed.

Thanks,
Guenter
