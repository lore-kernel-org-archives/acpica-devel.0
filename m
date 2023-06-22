Return-Path: <andriy.shevchenko@linux.intel.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E906660B97
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B8B1260B24
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1687457943; x=1718993943;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=lUTHnqqp11Qcu3wRI49BegX8QJeUiSLIGXhWdpB4hXE=;
 b=DWYwvrMtpbcmC5l70OBkmiWwqWMWjP+1gavgTBxoBLRe8BzZjXaoq29v
 Q7LV0IRXCtNo8GBsGm2pn9tuq1AaG6kiTzLGCvFm9mJ5zW5XwZN1dgyyG
 WRETHY5c8HsE0R/eg2jywmrTAVwMj8Q5TmPQPiw+ITMRUkm/ip4hOuXNh
 Xoi4Qz58mQjh5hKxpp0XukRJdTBfhSxdx3WZ+tSszbNLmM4UgcdwLLkUu
 Rj79X8ULs7XF1Eg2/x/6vjIw6E+n8fwNECE+J0cc5kV1FYPmI3AUWxUUH
 06UkOE1cQt9MuVaTv1/WSKwk4lBQgtmhHdp5YHOZQVf47Pw8WSVJxS/BB g==;
Date: Thu, 22 Jun 2023 21:18:39 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Message-ID: <ZJSQf07cO6qmNyCn@smile.fi.intel.com>
References: <20230621151652.79579-1-andriy.shevchenko@linux.intel.com>
 <CAJZ5v0jt8XCzUxQaBXLz0zXezih1Urq=dt-K9PWVY1JpN=Go6Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0jt8XCzUxQaBXLz0zXezih1Urq=dt-K9PWVY1JpN=Go6Q@mail.gmail.com>
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

On Thu, Jun 22, 2023 at 05:53:13PM +0200, Rafael J. Wysocki wrote:
> On Wed, Jun 21, 2023 at 5:16 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > After switching i2c-scmi driver to be a plaform one, it stopped
> 
> "platform"
> 
> > being enumerated on number of Kontron platforms, because it's
> > listed in the forbidden_id_list.
> >
> > To resolve the situation, split the list to generic one and
> > another that holds devices that has to be skipped if and only
> 
> "have"
> 
> > if they have bogus resources attached (_CRS method returns some).

Thanks for the typo fixes!

...

> > +static const struct acpi_device_id forbidden_id_with_resourses[] = {
> 
> I don't quite like this name and the driver_data field could be used
> to indicate the need to check the resources.

Okay, something like

/* Check if the device has resources provided by _CRS method */
#define ACPI_PLATFORM_CHECK_RES		BIT(0)

?

> > +       {"SMB0001",  0},        /* ACPI SMBUS virtual device */
> > +       { }
> > +};

...

> > +static int acpi_platform_resource_count(struct acpi_resource *ares, void *data)
> > +{
> > +       int *count = data;
> > +
> > +       *count = *count + 1;
> 
> Why not (*count)++?

Can be that way, I just copied'n'pasted from the existing code.

> > +       return 1;
> > +}

...

> >         INIT_LIST_HEAD(&resource_list);
> > +       ret = acpi_dev_get_resources(adev, &resource_list, acpi_platform_resource_count, &count);
> > +       if (ret < 0)
> > +               return ERR_PTR(ret);
> 
> Why not use acpi_walk_resources() directly here?

Can be done that way. Again, I just used a template (existing code in kernel)
for similar functionality.

> Also, this extra resources walk is only needed if the resources check
> is needed to decide whether or not to skip the device, so what's the
> benefit of doing it for every device that's not skipped?

Ah, indeed. Makes sense to have done it conditionally.

> > +       acpi_dev_free_resource_list(&resource_list);

...

Thank you for the review!

-- 
With Best Regards,
Andy Shevchenko


