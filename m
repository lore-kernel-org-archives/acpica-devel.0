Content-Type: multipart/mixed; boundary="===============1138792162711681423=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: [Devel] Re: [PATCH v2 1/1] ACPI: utils: Fix reference counting in
 for_each_acpi_dev_match()
Date: Fri, 16 Jul 2021 19:27:20 +0200
Message-ID: <CAJZ5v0jR5T2+EHXz_RqzMDxb0i9pDhQTDZomWe3po91A7Bb-xg@mail.gmail.com>
In-Reply-To: d542bc45-6e52-dc12-69bf-76fa6dcaaf5e@gmail.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============1138792162711681423==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 14, 2021 at 12:32 AM Daniel Scally <djrscally(a)gmail.com> wrot=
e:
>
> Hi Andy - thanks for fixing this
>
> On 12/07/2021 19:21, Andy Shevchenko wrote:
> > Currently it's possible to iterate over the dangling pointer in case th=
e device
> > suddenly disappears. This may happen becase callers put it at the end o=
f a loop.
> >
> > Instead, let's move that call inside acpi_dev_get_next_match_dev().
> >
> > Fixes: 803abec64ef9 ("media: ipu3-cio2: Add cio2-bridge to ipu3-cio2 dr=
iver")
> > Fixes: bf263f64e804 ("media: ACPI / bus: Add acpi_dev_get_next_match_de=
v() and helper macro")
> > Fixes: edbd1bc4951e ("efi/dev-path-parser: Switch to use for_each_acpi_=
dev_match()")
> > Signed-off-by: Andy Shevchenko <andy.shevchenko(a)gmail.com>
>
> Reviewed-by: Daniel Scally <djrscally(a)gmail.com>

Applied as 5.14-rc material, thanks!

> > ---
> > v2:
> > - rebased on top of v5.14-rc1 and hence added fix for EFI code
> > - added kernel documentation update to point out that
> >   acpi_dev_get_next_match_dev() drops a reference on the given
> >   ACPI device (Rafael)
> >
> >  drivers/acpi/utils.c                       | 7 +++----
> >  drivers/firmware/efi/dev-path-parser.c     | 1 -
> >  drivers/media/pci/intel/ipu3/cio2-bridge.c | 6 ++----
> >  include/acpi/acpi_bus.h                    | 5 -----
> >  4 files changed, 5 insertions(+), 14 deletions(-)
> >
> > diff --git a/drivers/acpi/utils.c b/drivers/acpi/utils.c
> > index e7ddd281afff..d5cedffeeff9 100644
> > --- a/drivers/acpi/utils.c
> > +++ b/drivers/acpi/utils.c
> > @@ -860,11 +860,9 @@ EXPORT_SYMBOL(acpi_dev_present);
> >   * Return the next match of ACPI device if another matching device was=
 present
> >   * at the moment of invocation, or NULL otherwise.
> >   *
> > - * FIXME: The function does not tolerate the sudden disappearance of @=
adev, e.g.
> > - * in the case of a hotplug event. That said, the caller should ensure=
 that
> > - * this will never happen.
> > - *
> >   * The caller is responsible for invoking acpi_dev_put() on the return=
ed device.
> > + * On the other hand the function invokes  acpi_dev_put() on the given=
 @adev
> > + * assuming that its reference counter had been increased beforehand.
> >   *
> >   * See additional information in acpi_dev_present() as well.
> >   */
> > @@ -880,6 +878,7 @@ acpi_dev_get_next_match_dev(struct acpi_device *ade=
v, const char *hid, const cha
> >       match.hrv =3D hrv;
> >
> >       dev =3D bus_find_device(&acpi_bus_type, start, &match, acpi_dev_m=
atch_cb);
> > +     acpi_dev_put(adev);
> >       return dev ? to_acpi_device(dev) : NULL;
> >  }
> >  EXPORT_SYMBOL(acpi_dev_get_next_match_dev);
> > diff --git a/drivers/firmware/efi/dev-path-parser.c b/drivers/firmware/=
efi/dev-path-parser.c
> > index 10d4457417a4..eb9c65f97841 100644
> > --- a/drivers/firmware/efi/dev-path-parser.c
> > +++ b/drivers/firmware/efi/dev-path-parser.c
> > @@ -34,7 +34,6 @@ static long __init parse_acpi_path(const struct efi_d=
ev_path *node,
> >                       break;
> >               if (!adev->pnp.unique_id && node->acpi.uid =3D=3D 0)
> >                       break;
> > -             acpi_dev_put(adev);
> >       }
> >       if (!adev)
> >               return -ENODEV;
> > diff --git a/drivers/media/pci/intel/ipu3/cio2-bridge.c b/drivers/media=
/pci/intel/ipu3/cio2-bridge.c
> > index 4657e99df033..59a36f922675 100644
> > --- a/drivers/media/pci/intel/ipu3/cio2-bridge.c
> > +++ b/drivers/media/pci/intel/ipu3/cio2-bridge.c
> > @@ -173,10 +173,8 @@ static int cio2_bridge_connect_sensor(const struct=
 cio2_sensor_config *cfg,
> >       int ret;
> >
> >       for_each_acpi_dev_match(adev, cfg->hid, NULL, -1) {
> > -             if (!adev->status.enabled) {
> > -                     acpi_dev_put(adev);
> > +             if (!adev->status.enabled)
> >                       continue;
> > -             }
> >
> >               if (bridge->n_sensors >=3D CIO2_NUM_PORTS) {
> >                       acpi_dev_put(adev);
> > @@ -185,7 +183,6 @@ static int cio2_bridge_connect_sensor(const struct =
cio2_sensor_config *cfg,
> >               }
> >
> >               sensor =3D &bridge->sensors[bridge->n_sensors];
> > -             sensor->adev =3D adev;
> >               strscpy(sensor->name, cfg->hid, sizeof(sensor->name));
> >
> >               ret =3D cio2_bridge_read_acpi_buffer(adev, "SSDB",
> > @@ -215,6 +212,7 @@ static int cio2_bridge_connect_sensor(const struct =
cio2_sensor_config *cfg,
> >                       goto err_free_swnodes;
> >               }
> >
> > +             sensor->adev =3D acpi_dev_get(adev);
> >               adev->fwnode.secondary =3D fwnode;
> >
> >               dev_info(&cio2->dev, "Found supported sensor %s\n",
> > diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> > index 1ae993fee4a5..b9d434a93632 100644
> > --- a/include/acpi/acpi_bus.h
> > +++ b/include/acpi/acpi_bus.h
> > @@ -707,11 +707,6 @@ acpi_dev_get_first_match_dev(const char *hid, cons=
t char *uid, s64 hrv);
> >   * @hrv: Hardware Revision of the device, pass -1 to not check _HRV
> >   *
> >   * The caller is responsible for invoking acpi_dev_put() on the return=
ed device.
> > - *
> > - * FIXME: Due to above requirement there is a window that may invalida=
te @adev
> > - * and next iteration will use a dangling pointer, e.g. in the case of=
 a
> > - * hotplug event. That said, the caller should ensure that this will n=
ever
> > - * happen.
> >   */
> >  #define for_each_acpi_dev_match(adev, hid, uid, hrv)                 \
> >       for (adev =3D acpi_dev_get_first_match_dev(hid, uid, hrv);       =
 \
--===============1138792162711681423==--

