Content-Type: multipart/mixed; boundary="===============7997101440062586156=="
MIME-Version: 1.0
From: Andy Shevchenko <andy.shevchenko at gmail.com>
Subject: [Devel] Re: [PATCH v3 5/6] platform/x86: Add intel_skl_int3472 driver
Date: Wed, 24 Feb 2021 12:18:43 +0200
Message-ID: <CAHp75VcKUjnwh4fi-mofooBuBYiqXjXOspU4twKg6-Lfvzf=QA@mail.gmail.com>
In-Reply-To: YDYmv0PpSndAlnDC@pendragon.ideasonboard.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============7997101440062586156==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 24, 2021 at 12:16 PM Laurent Pinchart
<laurent.pinchart(a)ideasonboard.com> wrote:
> On Tue, Feb 23, 2021 at 10:36:18PM +0000, Daniel Scally wrote:
> > On 23/02/2021 20:04, Laurent Pinchart wrote:

...

> > >> +  get_device(&int3472->sensor->dev);
> > >
> > > I see no corresponding put_device(), am I missing something ? I'm also
> > > not sure why this is needed.
> >
> > The put is acpi_dev_put() in skl_int3472_discrete_remove(); there seems
> > to be no acpi_dev_get() for some reason. We use the sensor acpi_device
> > to get the clock frequency, and to fetch the sensor module string, so I
> > thought it ought to hold a reference on those grounds.
>
> Shouldn't acpi_dev_get_dependent_dev() increase the reference count
> then, instead of doing it manually here ?

That's what I expected as well.
We have plenty of acpi_dev_get_*() and they do increase the reference
counter one way or the other.

-- =

With Best Regards,
Andy Shevchenko
--===============7997101440062586156==--

