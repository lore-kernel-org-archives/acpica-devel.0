Content-Type: multipart/mixed; boundary="===============4966895828832827929=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: [Devel] Re: [PATCH v1 1/1] ACPI: bus: Introduce acpi_dev_get() and
 reuse it in ACPI code
Date: Mon, 12 Apr 2021 20:12:38 +0200
Message-ID: <CAJZ5v0jHWF2q550pAo+s2s+dN+FLKAQ8yzY9d1p1Ww3t116pzA@mail.gmail.com>
In-Reply-To: CAHp75VcdZq9afovEP1Di6ScoFvBMuV0Es-XcuP60-Ewr9mfX5w@mail.gmail.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============4966895828832827929==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 12, 2021 at 8:10 PM Andy Shevchenko
<andy.shevchenko(a)gmail.com> wrote:
>
> On Mon, Apr 12, 2021 at 9:05 PM Rafael J. Wysocki <rafael(a)kernel.org> w=
rote:
> >
> > On Mon, Apr 12, 2021 at 7:47 PM Andy Shevchenko
> > <andy.shevchenko(a)gmail.com> wrote:
> > >
> > > On Mon, Apr 12, 2021 at 8:32 PM Rafael J. Wysocki <rafael(a)kernel.or=
g> wrote:
> > > > On Sat, Apr 10, 2021 at 3:47 PM Andy Shevchenko
> > > > <andy.shevchenko(a)gmail.com> wrote:
> > >
> > > ...
> > >
> > > > >  static void get_acpi_device(void *dev)
> > > > >  {
> > > > > -       if (dev)
> > > > > -               get_device(&((struct acpi_device *)dev)->dev);
> > > > > +       acpi_dev_get(dev);
> > > >
> > > > I would do
> > > >
> > > > if (dev)
> > > >     acpi_dev_get(dev);
> > > >
> > > > here.
> > >
> > > Hmm... I don't see a point. acpi_dev_get() guaranteed to perform this=
 check.
> > >
> > > > >  }
> > >
> > >
> > > > > +static inline void acpi_dev_get(struct acpi_device *adev)
> > > > > +{
> > > > > +       if (adev)
> > > > > +               get_device(&adev->dev);
> > > >
> > > > And I would drop the adev check from here (because the code calling=
 it
> > > > may be running with wrong assumptions if adev is NULL).  Or it shou=
ld
> > > > return adev and the caller should be held responsible for checking =
it
> > > > against NULL (if they care).
> > >
> > > But this follows the get_device() / put_device() logic.
> >
> > Not really.  get_device() returns a pointer.
> >
> > > Personally I don't think this is a good idea to deviate.
> >
> > Well, exactly. :-)
> >
> > > Note the acpi_bus_get_acpi_device()
> >
> > This also returns a pointer.
>
> Is it okay to return a pointer in acpi_dev_get() then?

Yes, it is, as I've said already.
--===============4966895828832827929==--

