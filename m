Return-Path: <andriy.shevchenko@linux.intel.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6F8FD409E7
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E66C7409C3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1687786028; x=1719322028;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=9ng5AnCmQfRGGBiaPFf18ARsNicr/v2JOScpItK0kq0=;
 b=O2Tcyp2W/uQKZBc6eRejg4VvihxJW3elYSewVfRdlEx6J2WOWBwZtOj8
 WdaP3ZOwo2/MdO2bedccreAu1FEl7zXzyYdlkUEG47TqDypviHHhNZsEl
 3leI5t65nR/UBqtD9P+ctqe//0uappaJ1Qlw/03LBt13kUrFpSFsjIQ4S
 x2s0PhNz5PB0P35LdlCC1pOYXym/Xy42xv7NwZ8p2jXD8YuAup1hIG9+J
 y3UgEF6yHCjAAAJvvgoLY0CY+9m750qFt3NXUlzBsIQjvey6XWyobiljq
 vJ4knBuMNKfi2/6QkyY5s7TJptEAwQgYxBw5Ke7tPJ0T+2DJEF129By3p Q==;
Date: Mon, 26 Jun 2023 16:27:03 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Message-ID: <ZJmSJ83Hvm+A9pK6@smile.fi.intel.com>
References: <20230621151652.79579-1-andriy.shevchenko@linux.intel.com>
 <CAJZ5v0jt8XCzUxQaBXLz0zXezih1Urq=dt-K9PWVY1JpN=Go6Q@mail.gmail.com>
 <ZJSQf07cO6qmNyCn@smile.fi.intel.com>
 <CAJZ5v0iKLtQpUnhMqB6zgwbURXGFZkje5rNORS9MLqYN=13nWg@mail.gmail.com>
 <ZJlJFtsXoC6JyLxY@smile.fi.intel.com>
 <ZJlsEggaJZc9u15T@smile.fi.intel.com>
 <CAJZ5v0iU5LXcjG8j+S1VZbBmTWGdOdM2W4Yf8HMou2=HQW0-nA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0iU5LXcjG8j+S1VZbBmTWGdOdM2W4Yf8HMou2=HQW0-nA@mail.gmail.com>
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

On Mon, Jun 26, 2023 at 02:11:10PM +0200, Rafael J. Wysocki wrote:
> On Mon, Jun 26, 2023 at 12:44 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Mon, Jun 26, 2023 at 11:15:19AM +0300, Andy Shevchenko wrote:
> > > On Fri, Jun 23, 2023 at 04:43:55PM +0200, Rafael J. Wysocki wrote:
> > > > On Thu, Jun 22, 2023 at 8:19 PM Andy Shevchenko
> > > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > > On Thu, Jun 22, 2023 at 05:53:13PM +0200, Rafael J. Wysocki wrote:
> > > > > > On Wed, Jun 21, 2023 at 5:16 PM Andy Shevchenko
> > > > > > <andriy.shevchenko@linux.intel.com> wrote:

...

> > > > BTW, this doesn't need to increment the count even.  It could just
> > > > terminate the walk on the first valid resource found and tell the
> > > > caller to return true in that case.
> > >
> > > Indeed, thank you for the hint!
> >
> > Actually it's doesn't matter if we count them or not, we still must use the
> > context of the call to set up a flag or whatever.
> 
> No, it is sufficient to pass a pointer to a bool variable.
> 
> > With the current code in mind I prefer to count resources and compare that
> > to be non-zero. This will help to read and understand code better.
> 
> I'm not sure.  The condition is "if there is at least one valid
> resource, skip the device".  Counting them all will make casual
> readers wonder why IMO.

Okay, Can you check v3 for the rest and I can send a v4 if nothing else there?

-- 
With Best Regards,
Andy Shevchenko


