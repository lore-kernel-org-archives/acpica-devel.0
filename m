Return-Path: <andriy.shevchenko@linux.intel.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0198340BFC
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org F212140144
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1687353613; x=1718889613;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=gXKkCfw0L0vm2oisoVKbq0dOluIkKgZ/dLrFgppTtNQ=;
 b=QotaW+FVeVjOiMdARyiIpt3SlEBdDI+sjpLBPVKSOd7es6DnxuFOhhvb
 vt3xb+dT8o10V6cDefy7xm4nrldCxQtqKzPymD6z2ou9vHSNqZV8EviFC
 sa4BDiTLwTDaFKfCIlpThrHwF4ZGTuJYhZHF0mNNiZa4mFP1SeNHTIzew
 wCtikyAVofH9A6dVer9Be1MtafTn2GQSLST7YUi1/gpo8LmzX8r0yGIO3
 43gyw85zjjL0Zc92eOh9GOYihMSM3Um9wJabwWMYiUVbPP6eIQ90jGSD5
 2jYG7Zo1NTTtB1i3S2TPtz9etfLxMRF7uIZ33qjjl4JTarL3O8M6DV48K g==;
From: "andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>
Message-ID: <ZJL4/X1Z9gCdESxp@smile.fi.intel.com>
References: <20230620163534.1042-1-andriy.shevchenko@linux.intel.com>
 <b9af5a068cc0b5e785c8e2ddfc70d811fd5929cd.camel@kontron.com>
 <20230621093056.5qfa3kn7ldgwsyeg@intel.intel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230621093056.5qfa3kn7ldgwsyeg@intel.intel>
Subject: Re: [Acpica-devel] [PATCH v1 1/2] ACPI: platform: Ignore SMB0001
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
Date: Wed, 21 Jun 2023 13:20:16 -0000
To: Andi Shyti <andi.shyti@kernel.org>
Cc: "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Michael Brunner <michael.brunner@kontron.com>, "robert.moore@intel.com" <robert.moore@intel.com>, "wsa@kernel.org" <wsa@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "acpica-devel@lists.linuxfoundation.org" <acpica-devel@lists.linuxfoundation.org>, "lenb@kernel.org" <lenb@kernel.org>

On Wed, Jun 21, 2023 at 11:30:56AM +0200, Andi Shyti wrote:
> On Wed, Jun 21, 2023 at 07:46:42AM +0000, Michael Brunner wrote:
> > On Tue, 2023-06-20 at 19:35 +0300, Andy Shevchenko wrote:
> > > After switchind i2c-scmi driver to be a plaform one it stopped
> > > being enumerated on number of Kontron platformsm, because it's
> > > listed in the forbidden_id_list.
> > > 
> > > To resolve the situation, split the list to generic one and
> > > another that holds devices that has to be skiped if and only if
> > > they have bogus resources attached (_CRS method returns some).
> > > 
> > > Fixes: 03d4287add6e ("i2c: scmi: Convert to be a platform driver")
> > > Closes: https://lore.kernel.org/r/60c1756765b9a3f1eab0dcbd84f59f00fe1caf48.camel@kontron.com
> > > Reported-by: Michael Brunner <michael.brunner@kontron.com>
> > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > 
> > Works as expected - the SMB0001 device shows up as platform device and
> > the i2c-scmi driver is enumerated again on the affected boards.
> > Thanks a lot!
> 
> is this a "Tested-by: Michael Brunner <michael.brunner@kontron.com>" :)

Michael, indeed, it would be nice to have a formal tag.
After that I will send a v2 with tags and fixed typos
as Andi noticed (thank you, Andi!).


-- 
With Best Regards,
Andy Shevchenko


