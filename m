Return-Path: <andriy.shevchenko@linux.intel.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BE89760BA2
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9E40E60B5A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1687767327; x=1719303327;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=idVIrM6nyAePhdkzWQmk/OgLjJRW7dN8sqMUgjM5mCI=;
 b=InbWtPR/RvxgVke8jaPuXRhBcY5fvBfYgdHjRbK7bgV85kdIaqg4SERX
 L8Wg7wc0JcyFKcFnuReLz1YgpCKJfwobnuP5UMz+1RBIebiGOQ/LPH2SE
 UF94zBrGLcasiBuEfoyHelDBfsjoEqC8RWvEHlbbtfZNnzuKzQRznUU8S
 t3nnAeiaJ+QAjbc2Cg6qYQdR+MYrG3FvHbn7CqReRqyJg4Gv2+/pNoj3U
 yDiNtaloNxgRV89KjuxTjPTMl0rQ1OE0OjUkRlSp+NLIDWsCbIP4e5AOB
 kZbVERA9bcHcqay3heW0syzIKXCbaZsAwDd0dj27ICn5uosH6ir1ByXgV g==;
Date: Mon, 26 Jun 2023 11:15:18 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Message-ID: <ZJlJFtsXoC6JyLxY@smile.fi.intel.com>
References: <20230621151652.79579-1-andriy.shevchenko@linux.intel.com>
 <CAJZ5v0jt8XCzUxQaBXLz0zXezih1Urq=dt-K9PWVY1JpN=Go6Q@mail.gmail.com>
 <ZJSQf07cO6qmNyCn@smile.fi.intel.com>
 <CAJZ5v0iKLtQpUnhMqB6zgwbURXGFZkje5rNORS9MLqYN=13nWg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0iKLtQpUnhMqB6zgwbURXGFZkje5rNORS9MLqYN=13nWg@mail.gmail.com>
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

On Fri, Jun 23, 2023 at 04:43:55PM +0200, Rafael J. Wysocki wrote:
> On Thu, Jun 22, 2023 at 8:19 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Thu, Jun 22, 2023 at 05:53:13PM +0200, Rafael J. Wysocki wrote:
> > > On Wed, Jun 21, 2023 at 5:16 PM Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:

...

> > /* Check if the device has resources provided by _CRS method */
> > #define ACPI_PLATFORM_CHECK_RES         BIT(0)
> >
> > ?
> 
> Could be, but this is specific to forbidden_ids_list[].  Maybe
> ACPI_ALLOW_WO_RESOURCES or similar.

Got it, will do this way.

...

> BTW, this doesn't need to increment the count even.  It could just
> terminate the walk on the first valid resource found and tell the
> caller to return true in that case.

Indeed, thank you for the hint!

-- 
With Best Regards,
Andy Shevchenko


