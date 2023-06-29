Return-Path: <andi.shyti@kernel.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C910E400D0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0A48C400D9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1688054402;
 bh=jpUacgkdFeRsJ/MSUKrNSTCllv1J69DsiV760Rp2JOM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=fxEmgF3yewTMhBXqSvl0K9ukMQUxWlxLqXrlEdXWH4ryN6ghLB3V4HZB91yVVfGtw
 mXOZAyeLNVR9gHdg1Vgn9PB/+vcvus1gJ36HCr5+M+VYHn4So5v74YFaSl4+3M/UBo
 GOkg8kvtD1dUyDDuxyEADMgx9Aox31w7TZXGpmwet3b+fu0EmGD+LFJyPist2zk3PV
 JB29vhOcT5mFja2zx4YO2vgtZQ1IavsEn3odKGU2GTEuAXKeJCZLI18XFnuTEQfg+K
 lNbiLp4uW2ixIAH/oHByTxFpCqN+UX4OfUJh2rffpcYNQWbsS0+gHQSJO8Tc6wfMXz
 UQZYLS31xn6dg==
From: Andi Shyti <andi.shyti@kernel.org>
Message-ID: <20230629155958.zeze2mirwbrb4ggy@intel.intel>
References: <20230626110026.65825-1-andriy.shevchenko@linux.intel.com>
 <20230626110026.65825-4-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230626110026.65825-4-andriy.shevchenko@linux.intel.com>
Subject: Re: [Acpica-devel] [PATCH v3 3/4] ACPI: platform: Ignore SMB0001
 only when it has resources
List-Id: "This is the central place for ACPICA developer discussions and
 issues." <acpica-devel.lists.linuxfoundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/acpica-devel/>
List-Post: <mailto:acpica-devel@lists.linuxfoundation.org>
List-Help: <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=subscribe>
Date: Thu, 29 Jun 2023 16:00:05 -0000
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-kernel@vger.kernel.org, Robert Moore <robert.moore@intel.com>, linux-acpi@vger.kernel.org, Michael Walle <michael@walle.cc>, linux-i2c@vger.kernel.org, acpica-devel@lists.linuxfoundation.org, Len Brown <lenb@kernel.org>

Hi Andy,

On Mon, Jun 26, 2023 at 02:00:25PM +0300, Andy Shevchenko wrote:
> After switching i2c-scmi driver to be a platform one, it stopped
> being enumerated on number of Kontron platforms, because it's
> listed in the forbidden_id_list.
> 
> To resolve the situation, add a flag to driver data to allow devices
> with no resources in _CRS to be enumerated via platform bus.
> 
> Fixes: 03d4287add6e ("i2c: scmi: Convert to be a platform driver")
> Closes: https://lore.kernel.org/r/60c1756765b9a3f1eab0dcbd84f59f00fe1caf48.camel@kontron.com
> Link: https://lore.kernel.org/r/20230621151652.79579-1-andriy.shevchenko@linux.intel.com
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Andi Shyti <andi.shyti@kernel.org> 

Andi
