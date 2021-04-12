Content-Type: multipart/mixed; boundary="===============7660804230434722051=="
MIME-Version: 1.0
From: Andy Shevchenko <andy.shevchenko at gmail.com>
Subject: [Devel] Re: [PATCH v1 1/1] ACPI: bus: Introduce acpi_dev_get() and
 reuse it in ACPI code
Date: Mon, 12 Apr 2021 21:09:53 +0300
Message-ID: <CAHp75VcdZq9afovEP1Di6ScoFvBMuV0Es-XcuP60-Ewr9mfX5w@mail.gmail.com>
In-Reply-To: CAJZ5v0jTQziFzc7pZ631=iigm6nv7xKAYyaA64pssAPKTA522g@mail.gmail.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============7660804230434722051==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 12, 2021 at 9:05 PM Rafael J. Wysocki <rafael(a)kernel.org> wro=
te:
>
> On Mon, Apr 12, 2021 at 7:47 PM Andy Shevchenko
> <andy.shevchenko(a)gmail.com> wrote:
> >
> > On Mon, Apr 12, 2021 at 8:32 PM Rafael J. Wysocki <rafael(a)kernel.org>=
 wrote:
> > > On Sat, Apr 10, 2021 at 3:47 PM Andy Shevchenko
> > > <andy.shevchenko(a)gmail.com> wrote:
> >
> > ...
> >
> > > >  static void get_acpi_device(void *dev)
> > > >  {
> > > > -       if (dev)
> > > > -               get_device(&((struct acpi_device *)dev)->dev);
> > > > +       acpi_dev_get(dev);
> > >
> > > I would do
> > >
> > > if (dev)
> > >     acpi_dev_get(dev);
> > >
> > > here.
> >
> > Hmm... I don't see a point. acpi_dev_get() guaranteed to perform this c=
heck.
> >
> > > >  }
> >
> >
> > > > +static inline void acpi_dev_get(struct acpi_device *adev)
> > > > +{
> > > > +       if (adev)
> > > > +               get_device(&adev->dev);
> > >
> > > And I would drop the adev check from here (because the code calling it
> > > may be running with wrong assumptions if adev is NULL).  Or it should
> > > return adev and the caller should be held responsible for checking it
> > > against NULL (if they care).
> >
> > But this follows the get_device() / put_device() logic.
>
> Not really.  get_device() returns a pointer.
>
> > Personally I don't think this is a good idea to deviate.
>
> Well, exactly. :-)
>
> > Note the acpi_bus_get_acpi_device()
>
> This also returns a pointer.

Is it okay to return a pointer in acpi_dev_get() then?

I will do it that way if there are no objections.

> > / acpi_bus_put_acpi_device() as well.



-- =

With Best Regards,
Andy Shevchenko
--===============7660804230434722051==--

