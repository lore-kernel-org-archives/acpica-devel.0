Return-Path: <andi.shyti@kernel.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1D5C4417BC
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6A493417B4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1688053969;
 bh=CCKbzzXdJBYuI+KW0adHtNgjwnMf15NSqnKLyLN6/jk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=mtFlczZ03HLwJp8zf7gcnm48scmZ56OxFM8rJbBkKwaIgtwpDpdz81n73wV6WnSOI
 z8PyiY6oTvqcpHIfvSmsHVy4KM1jfaRP4+Z3jjcfzxOMemWGDggwYUs2X7bXgl4gMN
 FV0hAjlpFcmV2ZaYKzD3wdDOh9lFvb+61FKbxhhTPCbhlK/akVSzklgQl+zQ3hYQJU
 Jj6v3ItTlZUueS1Z3ZG5IJNYcfbFlnqh1HamlViKSB4wCc1EMwwt2kfK/Pt5Uy528K
 FKDL097TdGgTKFVThDqBJxthUBNWVUgrAd/xmgITMd+xmKgDrZQrgQTGMuqCb8ZR1V
 KWVWMuxQRYzVg==
From: Andi Shyti <andi.shyti@kernel.org>
Message-ID: <20230629155245.syd6mx2rffbvbkol@intel.intel>
References: <20230626110026.65825-1-andriy.shevchenko@linux.intel.com>
 <20230626110026.65825-2-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230626110026.65825-2-andriy.shevchenko@linux.intel.com>
Subject: Re: [Acpica-devel] [PATCH v3 1/4] ACPI: bus: Constify
 acpi_companion_match() returned value
List-Id: "This is the central place for ACPICA developer discussions and
 issues." <acpica-devel.lists.linuxfoundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/acpica-devel/>
List-Post: <mailto:acpica-devel@lists.linuxfoundation.org>
List-Help: <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=subscribe>
Date: Thu, 29 Jun 2023 15:52:57 -0000
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-kernel@vger.kernel.org, Robert Moore <robert.moore@intel.com>, linux-acpi@vger.kernel.org, Michael Walle <michael@walle.cc>, linux-i2c@vger.kernel.org, acpica-devel@lists.linuxfoundation.org, Len Brown <lenb@kernel.org>

Hi Andy,

On Mon, Jun 26, 2023 at 02:00:23PM +0300, Andy Shevchenko wrote:
> acpi_companion_match() doesn't alter the contents of the passed
> parameter, so we don't expect that returned value can be altered
> either. So constify it.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

I guess I'm late for adding my

Reviewed-by: Andi Shyti <andi.shyti@kernel.org> 

here.

Andi
