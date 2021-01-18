Content-Type: multipart/mixed; boundary="===============0659116345087726152=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: [Devel] Re: [PATCH v2 1/7] acpi: utils: move acpi_lpss_dep() to utils
Date: Mon, 18 Jan 2021 17:06:30 +0100
Message-ID: <CAJZ5v0hihFa=M658GE2LtoKCnPkMQznXBtq9_+g0_4gFnw6qAg@mail.gmail.com>
In-Reply-To: 20210118122852.GD4077@smile.fi.intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============0659116345087726152==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 18, 2021 at 1:30 PM Andy Shevchenko
<andriy.shevchenko(a)linux.intel.com> wrote:
>
> On Mon, Jan 18, 2021 at 12:34:22AM +0000, Daniel Scally wrote:
> > I need to be able to identify devices which declare themselves to be
> > dependent on other devices through _DEP; add this function to utils.c
> > and export it to the rest of the ACPI layer.
>
> Prefix -> "ACPI / utils: "

Preferably "ACPI: utils: " for that matter and yes, please rename the
function while moving it.

> Otherwise good to me
> Reviewed-by: Andy Shevchenko <andriy.shevchenko(a)linux.intel.com>
>
> > Suggested-by: Andy Shevchenko <andriy.shevchenko(a)linux.intel.com>
> > Signed-off-by: Daniel Scally <djrscally(a)gmail.com>
> > ---
> > Changes in v2:
> >       - Introduced
> >
> >  drivers/acpi/acpi_lpss.c | 24 ------------------------
> >  drivers/acpi/internal.h  |  1 +
> >  drivers/acpi/utils.c     | 24 ++++++++++++++++++++++++
> >  3 files changed, 25 insertions(+), 24 deletions(-)
> >
> > diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
> > index be73974ce449..70c7d9a3f715 100644
> > --- a/drivers/acpi/acpi_lpss.c
> > +++ b/drivers/acpi/acpi_lpss.c
> > @@ -543,30 +543,6 @@ static struct device *acpi_lpss_find_device(const =
char *hid, const char *uid)
> >       return bus_find_device(&pci_bus_type, NULL, &data, match_hid_uid);
> >  }
> >
> > -static bool acpi_lpss_dep(struct acpi_device *adev, acpi_handle handle)
> > -{
> > -     struct acpi_handle_list dep_devices;
> > -     acpi_status status;
> > -     int i;
> > -
> > -     if (!acpi_has_method(adev->handle, "_DEP"))
> > -             return false;
> > -
> > -     status =3D acpi_evaluate_reference(adev->handle, "_DEP", NULL,
> > -                                      &dep_devices);
> > -     if (ACPI_FAILURE(status)) {
> > -             dev_dbg(&adev->dev, "Failed to evaluate _DEP.\n");
> > -             return false;
> > -     }
> > -
> > -     for (i =3D 0; i < dep_devices.count; i++) {
> > -             if (dep_devices.handles[i] =3D=3D handle)
> > -                     return true;
> > -     }
> > -
> > -     return false;
> > -}
> > -
> >  static void acpi_lpss_link_consumer(struct device *dev1,
> >                                   const struct lpss_device_links *link)
> >  {
> > diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
> > index cb229e24c563..ee62c0973576 100644
> > --- a/drivers/acpi/internal.h
> > +++ b/drivers/acpi/internal.h
> > @@ -79,6 +79,7 @@ static inline void acpi_lpss_init(void) {}
> >  #endif
> >
> >  void acpi_apd_init(void);
> > +bool acpi_lpss_dep(struct acpi_device *adev, acpi_handle handle);
> >
> >  acpi_status acpi_hotplug_schedule(struct acpi_device *adev, u32 src);
> >  bool acpi_queue_hotplug_work(struct work_struct *work);
> > diff --git a/drivers/acpi/utils.c b/drivers/acpi/utils.c
> > index ddca1550cce6..78b38775f18b 100644
> > --- a/drivers/acpi/utils.c
> > +++ b/drivers/acpi/utils.c
> > @@ -807,6 +807,30 @@ static int acpi_dev_match_cb(struct device *dev, c=
onst void *data)
> >       return hrv =3D=3D match->hrv;
> >  }
> >
> > +bool acpi_lpss_dep(struct acpi_device *adev, acpi_handle handle)
> > +{
> > +     struct acpi_handle_list dep_devices;
> > +     acpi_status status;
> > +     int i;
> > +
> > +     if (!acpi_has_method(adev->handle, "_DEP"))
> > +             return false;
> > +
> > +     status =3D acpi_evaluate_reference(adev->handle, "_DEP", NULL,
> > +                                      &dep_devices);
> > +     if (ACPI_FAILURE(status)) {
> > +             dev_dbg(&adev->dev, "Failed to evaluate _DEP.\n");
> > +             return false;
> > +     }
> > +
> > +     for (i =3D 0; i < dep_devices.count; i++) {
> > +             if (dep_devices.handles[i] =3D=3D handle)
> > +                     return true;
> > +     }
> > +
> > +     return false;
> > +}
> > +
> >  /**
> >   * acpi_dev_present - Detect that a given ACPI device is present
> >   * @hid: Hardware ID of the device.
> > --
> > 2.25.1
> >
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
--===============0659116345087726152==--

