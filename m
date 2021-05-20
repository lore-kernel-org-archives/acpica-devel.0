Content-Type: multipart/mixed; boundary="===============2114060720471221757=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: [Devel] Re: [PATCH v4 2/8] ACPI: scan: Add function to fetch
 dependent of acpi device
Date: Thu, 20 May 2021 20:55:14 +0200
Message-ID: <CAJZ5v0hdSi4BcZvhkyrtcBQqRL8CHtOtwUeYW7EnWL2zvKhDZw@mail.gmail.com>
In-Reply-To: CAJZ5v0hoDswjr+7r4uf6jZvV3t+-UDtEA0V7A_MvdT_34XrbJA@mail.gmail.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============2114060720471221757==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, May 20, 2021 at 8:33 PM Rafael J. Wysocki <rafael(a)kernel.org> wro=
te:
>
> On Thu, May 20, 2021 at 4:11 PM Daniel Scally <djrscally(a)gmail.com> wro=
te:
> >
> > In some ACPI tables we encounter, devices use the _DEP method to assert
> > a dependence on other ACPI devices as opposed to the OpRegions that the
> > specification intends. We need to be able to find those devices "from"
> > the dependee, so add a callback and a wrapper to walk over the
> > acpi_dep_list and return the dependent ACPI device.
> >
> > Reviewed-by: Andy Shevchenko <andy.shevchenko(a)gmail.com>
> > Signed-off-by: Daniel Scally <djrscally(a)gmail.com>
> > ---
> > Changes since v3:
> >
> >         Both new functions were renamed.
> >
> >  drivers/acpi/scan.c     | 38 ++++++++++++++++++++++++++++++++++++++
> >  include/acpi/acpi_bus.h |  1 +
> >  2 files changed, 39 insertions(+)
> >
> > diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> > index 195635c3462b..1a76fbdfa669 100644
> > --- a/drivers/acpi/scan.c
> > +++ b/drivers/acpi/scan.c
> > @@ -2105,6 +2105,21 @@ static void acpi_bus_attach(struct acpi_device *=
device, bool first_pass)
> >                 device->handler->hotplug.notify_online(device);
> >  }
> >
> > +static int acpi_return_dep_dev(struct acpi_dep_data *dep, void *data)
>
> What about calling this acpi_get_first_consumer_cb()?

Or acpi_dev_get_first_consumer_dev_cb() if you want to be super-precise?

>
> > +{
> > +       struct acpi_device *adev;
> > +       int ret;
> > +
> > +       ret =3D acpi_bus_get_device(dep->consumer, &adev);
> > +       if (ret)
> > +               /* If we don't find an adev then we want to continue pa=
rsing */
> > +               return 0;
> > +
> > +       *(struct acpi_device **)data =3D adev;
>
> And it can do the get_device() here, can't it?
>
> So maybe use acpi_bus_get_acpi_device() instead of
> acpi_bus_get_device()?  Would be simpler.
>
> > +
> > +       return 1;
> > +}
> > +
> >  static int acpi_scan_clear_dep(struct acpi_dep_data *dep, void *data)
> >  {
> >         struct acpi_device *adev;
> > @@ -2168,6 +2183,29 @@ void acpi_dev_clear_dependencies(struct acpi_dev=
ice *supplier)
> >  }
> >  EXPORT_SYMBOL_GPL(acpi_dev_clear_dependencies);
> >
> > +/**
> > + * acpi_dev_get_dependent_dev - Return ACPI device dependent on @suppl=
ier
>
> And what about calling this acpi_get_first_consumer() ?

Or acpi_dev_get_first_consumer_dev() (in analogy with the above)?

> > + * @supplier: Pointer to the dependee device
> > + *
> > + * Returns the first &struct acpi_device which declares itself depende=
nt on
> > + * @supplier via the _DEP buffer, parsed from the acpi_dep_list.
> > + *
> > + * The caller is responsible for putting the reference to adev when it=
 is no
> > + * longer needed.
> > + */
> > +struct acpi_device *acpi_dev_get_dependent_dev(struct acpi_device *sup=
plier)
> > +{
> > +       struct acpi_device *adev =3D NULL;
> > +
> > +       acpi_walk_dep_device_list(supplier->handle, acpi_return_dep_dev=
, &adev);
> > +
> > +       if (adev)
> > +               get_device(&adev->dev);
> > +
> > +       return adev;
> > +}
> > +EXPORT_SYMBOL_GPL(acpi_dev_get_dependent_dev);
> > +
> >  /**
> >   * acpi_bus_scan - Add ACPI device node objects in a given namespace s=
cope.
> >   * @handle: Root of the namespace scope to scan.
> > diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> > index 0b2c4f170f4d..68d378207704 100644
> > --- a/include/acpi/acpi_bus.h
> > +++ b/include/acpi/acpi_bus.h
> > @@ -692,6 +692,7 @@ static inline bool acpi_device_can_poweroff(struct =
acpi_device *adev)
> >  bool acpi_dev_hid_uid_match(struct acpi_device *adev, const char *hid2=
, const char *uid2);
> >
> >  void acpi_dev_clear_dependencies(struct acpi_device *supplier);
> > +struct acpi_device *acpi_dev_get_dependent_dev(struct acpi_device *sup=
plier);
> >  struct acpi_device *
> >  acpi_dev_get_next_match_dev(struct acpi_device *adev, const char *hid,=
 const char *uid, s64 hrv);
> >  struct acpi_device *
> > --
> > 2.25.1
> >
--===============2114060720471221757==--

