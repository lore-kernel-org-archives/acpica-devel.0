Received: from mail-yx2-f36.google.com (mail-yx2-f36.google.com [74.125.224.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A254A841D
	for <acpica-devel@lists.linux.dev>; Thu, 24 Sep 2026 16:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790267419; cv=none; b=kvJ2HhzY6T6lOLgn52wsWofS+a3VggALSBuck8nWkpe5b6Tmxo27S2tzYJjmlobSNQlII0W/gAm8L2Ro5XGxcWDbL91Rl5GwCyZlMOLIX9Xg0qKngTYCYgey95ciFmOlRcJvP6jyBWMH8qEuV+4spfo/Vz3iTX3BpGBhWiTAEPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790267419; c=relaxed/simple;
	bh=JBDGzc60077SgcewoR3vKPZnAOMKOUz6ytxF3+0PB5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DInLN2zOLkLBBvMylxXJELywN2CarmD/gr677MD9FwuugT6+f7k/wSBjwBBrcBT7mIsasGK9HIb1ihO5IxkEYRACLVYSC5akzRJNvWpCVFQ2Ebx8JFwY+vTkIYLz6yMkSIplIIwZd7bMbddJXfbIK268ungP8djmU689KVJf+L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mnCpCD0R; arc=none smtp.client-ip=74.125.224.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mnCpCD0R"
Received: by mail-yx2-f36.google.com with SMTP id 956f58d0204a3-66e4aaf2ecfso110303d50.1
        for <acpica-devel@lists.linux.dev>; Thu, 24 Sep 2026 09:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790267417; x=1790872217; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1Rnw2ZxPq8QQGfsa2N17k5WV6br+EhptPqyuYf7fWpE=;
        b=mnCpCD0RD/BZivIjCjPqHPI+eQUTdUx+nHcU7NjIAZsVVkb8Uvck1kleykdI5WEt2X
         dnt/bFIzNOwygAzaQFy/lXwApT4rVae1TR2ldsvXN1/ohwWsHC04Jex0oXPes+5+m5RN
         eTsyiUaFTP5gPMtLqhUSAtMsbC+C0rVrtWB7NvalRd3hYBny2YympQxZyMA5+izv9wHs
         oGmqkVlB3ahQsx+rf9u0tifzZ8zYXqCKKzAtLH3p17YJ7cl/4ZwNpjlgX3c6k/Ew4ww1
         eGHmtgyHgq/XTtVy9Wai0QNNnnbVS3ZluNlEtwwJRvgMyOhWk/jsqZLqCYU/kZlRnOPL
         Rq8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790267417; x=1790872217;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=1Rnw2ZxPq8QQGfsa2N17k5WV6br+EhptPqyuYf7fWpE=;
        b=Ad7u4y/u1iqbpmAQmxLMfqjd7tPunI5ejkpLcmT13SMjaLCeGd5COGULAsIGaJtkA5
         RfNWrNPZup2d1K6wiSfn1aPBuzCAhS/CuilrTX+jVv/ogGK4YH5krkTekniTqYmElPtT
         P1i7mOvg7/TAY8sYQdyu3a14gBufhcU/gJ1DFpK5yKaKG6Ei14Lzl42GAc7dq9u0mcny
         hQYrsx9e1WF3mdtht5N26vLZ2IePP7GeFW+X5rGC8PvMfuOtXYw65ohVDvCrMYveZHH7
         yzuPBgVAu8GkGXhsjyA3r5hevP/X8E08YKoCvhCQsD9sOWXkDxbpNbRc7yTc4TklAekC
         YX9w==
X-Forwarded-Encrypted: i=1; AKwUvBwSlDoj6xf9atqo4lJV6DnZ9NIYSTXX+raCZ8pbx8hHd35u5Hh0x5Wdsm1Ljb/DttJjwp0NwyimaftQnQA=@lists.linux.dev
X-Gm-Message-State: AFuF++nlwxn6n5/aOu7aOdbwP5OQB2ADjrQVBOoeDt7AsZjlmPg4crIZ
	ZGBTPg26eHvHqG0sleW6AaDioaXYkmoCnZeplFnH4pW7SSEVEhxzqAva
X-Gm-Gg: AYBFou1enUFqRS9NDOjxnghYs73eIAELIQyVmaDG9Xs6sCD1RcHdr5JQpW6NDMEUOX/
	mztGL3V9r5OqbLPOplQgS/JODsXNxh+8k3BHBtu6iiSD7ZLacAYoJ+zQOkXtmesiL51YK2L/Bv6
	gim1jEHKWGBt49qSpaQsp3fYOnjS1WEaOXD/OnphlZi322fNowDHRrF/HH1siolNIXQFoRwatvH
	bjw+UXBi7frfBWZaKueaWP1InacVe/UZG0SsWRDEu6IrlMgHyH4ygLwt5iCQiW2mKZFr2yoPPso
	mA6WKyjsY0xPfRKNaFxUHRxRbZAVwn0TB54zAah3sdv5sw6BEwSWUPpl9Kc8Z3tCXexPGinEAZ/
	C60Q6N7mupDF+veDRzb8b4EUnv0XpvwywS7PiSN8PKksJWeg4FV37Dxp2PlAG/k6p6FfDEHp4gw
	ulgSCrfVffYOsR/tMVNoCfdmJ0PNGltM9r36LkXytlwllBUmyvhB9dnN1Hdd7i56xP+xqH1doQy
	2wG
X-Received: by 2002:a05:690e:12ca:b0:672:a450:6932 with SMTP id 956f58d0204a3-672ed36dbecmr2089408d50.70.1790267416650;
        Thu, 24 Sep 2026 09:30:16 -0700 (PDT)
Received: from deathstar ([2600:1700:22f5:9081:10c5:856:4833:d269])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-672d81ce7dcsm2254959d50.18.2026.09.24.09.30.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 09:30:16 -0700 (PDT)
Date: Thu, 24 Sep 2026 09:30:13 -0700
From: Matthew Wood <thepacketgeek@gmail.com>
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: Saket Dumbre <saket.dumbre@intel.com>, Len Brown <lenb@kernel.org>, 
	Sudeep Holla <sudeep.holla@kernel.org>, Bob Moore <robert.moore@intel.com>, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev, 
	linux-kernel@vger.kernel.org, catalin.marinas@arm.com, kernel-team@meta.com
Subject: Re: [PATCH] ACPICA: Fix memory leak at acpi_ds_create_field()
Message-ID: <arVPNWY3HziZkU1p@mail.gmail.com>
References: <20260813-acpica-pcc-field-leak-v1-1-3d6c5f0eb557@debian.org>
 <CAJZ5v0isQYRN9aZCmWty-kZpjHvZWyJT2AnRXs9RDszy7b5TkA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0isQYRN9aZCmWty-kZpjHvZWyJT2AnRXs9RDszy7b5TkA@mail.gmail.com>

On Thu, Aug 13, 2026 at 03:39:37PM +0200, Rafael J. Wysocki (Intel) wrote:
> On Thu, Aug 13, 2026 at 3:35 PM Breno Leitao <leitao@debian.org> wrote:
> >
> > acpi_ds_create_field() allocates internal_pcc_buffer for operation
> > regions in the PCC address space.
> >
> > The function runs once per field, so a second field on the
> > same region overwrites the pointer and orphans the previous buffer.
> >
> > The matching ACPI_FREE() in acpi_ut_delete_internal_obj() only ever sees
> > the last one.
> >
> > An arm64 platform whose SSDT declares regions with multiple fields each
> > leaks two buffers at boot, as detected by kmemleak:
> >
> >   unreferenced object 0xffff000051e65400 (size 192):
> >     comm "swapper/0", pid 1, jiffies 4294668436
> >     backtrace (crc 0):
> >       __kmalloc_noprof
> >       acpi_ds_create_field
> >       acpi_ds_load2_end_op
> >       acpi_ds_exec_end_op
> >       acpi_ps_parse_loop
> >       acpi_ps_parse_aml
> >       acpi_ns_load_table
> >       acpi_load_tables
> >       acpi_init
> >
> > Do not allocate a region if it was previously allocated before,
> > preserving the current design, but, not leaking memory.
> >
> > Fixes: 0acf24ad7e10 ("ACPICA: Add support for PCC Opregion special context data")
> > Signed-off-by: Breno Leitao <leitao@debian.org>
> 
> As per Documentation/driver-api/acpi/linuxized-acpica.rst, please
> submit a pull request with this change to the upstream ACPICA project
> on GitHub.  The Linux patch will become applicable when there is a
> corresponding commit upstream.
> 

Hi Rafael,

This change has been submitted, approved, and merged in GitHub:
https://github.com/open-acpica/acpica/commit/c71849d476bb5f97ca1867849e893368e12a69e6

Can you please review here as well? Thank you.

Regards,
Matthew

> > ---
> >  drivers/acpi/acpica/dsfield.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/acpi/acpica/dsfield.c b/drivers/acpi/acpica/dsfield.c
> > index d7d56cc600d31..f7e503bf57c87 100644
> > --- a/drivers/acpi/acpica/dsfield.c
> > +++ b/drivers/acpi/acpica/dsfield.c
> > @@ -522,7 +522,8 @@ acpi_ds_create_field(union acpi_parse_object *op,
> >         }
> >
> >         if (info.region_node->object->region.space_id ==
> > -           ACPI_ADR_SPACE_PLATFORM_COMM) {
> > +           ACPI_ADR_SPACE_PLATFORM_COMM &&
> > +           !region_node->object->field.internal_pcc_buffer) {
> >                 region_node->object->field.internal_pcc_buffer =
> >                     ACPI_ALLOCATE_ZEROED(info.region_node->object->region.
> >                                          length);
> >
> > ---
> > base-commit: 28d012efb4327f9c75d5e042a7c91e9a542efa98
> > change-id: 20260813-acpica-pcc-field-leak-8f676f55179b
> >
> > Best regards,
> > --
> > Breno Leitao <leitao@debian.org>
> >
