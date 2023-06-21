Return-Path: <andi.shyti@kernel.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3D5DE40641
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 82395401CA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1687339860;
 bh=jj5prc/m9//HFm8xr+N5ZbfzrAhbjiUFjl/hHyLscm8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=S7MELRNuVAcq/3RR2p127etX799EBj8N/6zccTApFtuX2gHEH1LvQUO6sYwcin3kX
 nA2zd5lP/EOGc1OyCbL6TMt1gzPwFogIZHKSjOrfIy91B9o8Y/Au4GNy1bqOxua3A8
 +/daTrRazZd6lsbXzDtFyJSLOfpCdJZmiT+BBFvhpFZ2+5sRkvDsUag5nqqi6+LhIL
 ror6BJj8A0DYaqC8Gan+hGjTvo9brDxTun8ZEcXEYuKx5M06mPaC+RxBDc7kpKO3n+
 Szh/RCzUuDNla2BgUlHoDrJY7mzHsfdt4grD0eACoNeF5EkBPQl0iH89U6OGrDYnnO
 OrbAtyT1n+iOQ==
From: Andi Shyti <andi.shyti@kernel.org>
Message-ID: <20230621093056.5qfa3kn7ldgwsyeg@intel.intel>
References: <20230620163534.1042-1-andriy.shevchenko@linux.intel.com>
 <b9af5a068cc0b5e785c8e2ddfc70d811fd5929cd.camel@kontron.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9af5a068cc0b5e785c8e2ddfc70d811fd5929cd.camel@kontron.com>
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
Date: Wed, 21 Jun 2023 09:31:02 -0000
To: Michael Brunner <michael.brunner@kontron.com>
Cc: "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "robert.moore@intel.com" <robert.moore@intel.com>, "wsa@kernel.org" <wsa@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "acpica-devel@lists.linuxfoundation.org" <acpica-devel@lists.linuxfoundation.org>, "andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>, "lenb@kernel.org" <lenb@kernel.org>

On Wed, Jun 21, 2023 at 07:46:42AM +0000, Michael Brunner wrote:
> On Tue, 2023-06-20 at 19:35 +0300, Andy Shevchenko wrote:
> > After switchind i2c-scmi driver to be a plaform one it stopped
> > being enumerated on number of Kontron platformsm, because it's
> > listed in the forbidden_id_list.
> > 
> > To resolve the situation, split the list to generic one and
> > another that holds devices that has to be skiped if and only if
> > they have bogus resources attached (_CRS method returns some).
> > 
> > Fixes: 03d4287add6e ("i2c: scmi: Convert to be a platform driver")
> > Closes: https://lore.kernel.org/r/60c1756765b9a3f1eab0dcbd84f59f00fe1caf48.camel@kontron.com
> > Reported-by: Michael Brunner <michael.brunner@kontron.com>
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Works as expected - the SMB0001 device shows up as platform device and
> the i2c-scmi driver is enumerated again on the affected boards.
> Thanks a lot!

is this a "Tested-by: Michael Brunner <michael.brunner@kontron.com>" :)

Andi
