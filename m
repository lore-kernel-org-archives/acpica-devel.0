Return-Path: <andriy.shevchenko@linux.intel.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0CF4D40986
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0DAF440975
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1687776280; x=1719312280;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=ulzjEKt9TPFPosS7yZEKwHAFl3FmcOd566vv02OR1+8=;
 b=CGnOFrUvzSsjhnlwDqr1GevFin4FsUEoAdqimQEJhNcrwNWcFdCbYdCz
 zKQ7SF4l/eZz2qNp5BdqKeRyNX+zVyYjJRNpRmauWH01yZpjFTSPdV2Io
 G7VIEpH6L543UucYBzveR4xQ/Qrp9Gg+k3YsqLw0JZXEIrgRgVkMG4YLf
 MGrc42owf0l56q7hJqIo2R2wiMmXrrOxPPig9akiBf4DAABzYKG58rV/a
 TjP9tIqY6YoCLN4DY9VZwCK0sCpeF4l/j+1WL9q0wkNmDAuIE/flS/k97
 CP8tqYdfATlN2MNe5FoK57F0MeZc3VyZkZVzRirs60kfZp5Sg79xIkRZJ A==;
Date: Mon, 26 Jun 2023 13:44:34 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Message-ID: <ZJlsEggaJZc9u15T@smile.fi.intel.com>
References: <20230621151652.79579-1-andriy.shevchenko@linux.intel.com>
 <CAJZ5v0jt8XCzUxQaBXLz0zXezih1Urq=dt-K9PWVY1JpN=Go6Q@mail.gmail.com>
 <ZJSQf07cO6qmNyCn@smile.fi.intel.com>
 <CAJZ5v0iKLtQpUnhMqB6zgwbURXGFZkje5rNORS9MLqYN=13nWg@mail.gmail.com>
 <ZJlJFtsXoC6JyLxY@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZJlJFtsXoC6JyLxY@smile.fi.intel.com>
Subject: Re: [Acpica-devel] [PATCH v2 1/2] ACPI: platform: Ignore SMB0001
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
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Andi Shyti <andi.shyti@kernel.org>, linux-kernel@vger.kernel.org, Michael Brunner <michael.brunner@kontron.com>, Robert Moore <robert.moore@intel.com>, linux-acpi@vger.kernel.org, linux-i2c@vger.kernel.org, acpica-devel@lists.linuxfoundation.org, Len Brown <lenb@kernel.org>

On Mon, Jun 26, 2023 at 11:15:19AM +0300, Andy Shevchenko wrote:
> On Fri, Jun 23, 2023 at 04:43:55PM +0200, Rafael J. Wysocki wrote:
> > On Thu, Jun 22, 2023 at 8:19 PM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > On Thu, Jun 22, 2023 at 05:53:13PM +0200, Rafael J. Wysocki wrote:
> > > > On Wed, Jun 21, 2023 at 5:16 PM Andy Shevchenko
> > > > <andriy.shevchenko@linux.intel.com> wrote:

...

> > BTW, this doesn't need to increment the count even.  It could just
> > terminate the walk on the first valid resource found and tell the
> > caller to return true in that case.
> 
> Indeed, thank you for the hint!

Actually it's doesn't matter if we count them or not, we still must use the
context of the call to set up a flag or whatever. With the current code in mind
I prefer to count resources and compare that to be non-zero. This will help to
read and understand code better.

That said, I will go with (*counter)++;

-- 
With Best Regards,
Andy Shevchenko


