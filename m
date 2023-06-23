Return-Path: <rjwysocki@gmail.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1A1B440500
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org AB64640193
MIME-Version: 1.0
References: <20230621151652.79579-1-andriy.shevchenko@linux.intel.com>
 <CAJZ5v0jt8XCzUxQaBXLz0zXezih1Urq=dt-K9PWVY1JpN=Go6Q@mail.gmail.com>
 <ZJSQf07cO6qmNyCn@smile.fi.intel.com>
In-Reply-To: <ZJSQf07cO6qmNyCn@smile.fi.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Message-ID: <CAJZ5v0iKLtQpUnhMqB6zgwbURXGFZkje5rNORS9MLqYN=13nWg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Date: Fri, 23 Jun 2023 14:44:12 -0000
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Andi Shyti <andi.shyti@kernel.org>, linux-kernel@vger.kernel.org, Michael Brunner <michael.brunner@kontron.com>, Robert Moore <robert.moore@intel.com>, linux-acpi@vger.kernel.org, linux-i2c@vger.kernel.org, acpica-devel@lists.linuxfoundation.org, Len Brown <lenb@kernel.org>

On Thu, Jun 22, 2023 at 8:19=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Thu, Jun 22, 2023 at 05:53:13PM +0200, Rafael J. Wysocki wrote:
> > On Wed, Jun 21, 2023 at 5:16=E2=80=AFPM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > >
> > > After switching i2c-scmi driver to be a plaform one, it stopped
> >
> > "platform"
> >
> > > being enumerated on number of Kontron platforms, because it's
> > > listed in the forbidden_id_list.
> > >
> > > To resolve the situation, split the list to generic one and
> > > another that holds devices that has to be skipped if and only
> >
> > "have"
> >
> > > if they have bogus resources attached (_CRS method returns some).
>
> Thanks for the typo fixes!
>
> ...
>
> > > +static const struct acpi_device_id forbidden_id_with_resourses[] =3D=
 {
> >
> > I don't quite like this name and the driver_data field could be used
> > to indicate the need to check the resources.
>
> Okay, something like
>
> /* Check if the device has resources provided by _CRS method */
> #define ACPI_PLATFORM_CHECK_RES         BIT(0)
>
> ?

Could be, but this is specific to forbidden_ids_list[].  Maybe
ACPI_ALLOW_WO_RESOURCES or similar.

> > > +       {"SMB0001",  0},        /* ACPI SMBUS virtual device */
> > > +       { }
> > > +};
>
> ...
>
> > > +static int acpi_platform_resource_count(struct acpi_resource *ares, =
void *data)
> > > +{
> > > +       int *count =3D data;
> > > +
> > > +       *count =3D *count + 1;
> >
> > Why not (*count)++?
>
> Can be that way, I just copied'n'pasted from the existing code.
>
> > > +       return 1;
> > > +}

BTW, this doesn't need to increment the count even.  It could just
terminate the walk on the first valid resource found and tell the
caller to return true in that case.
