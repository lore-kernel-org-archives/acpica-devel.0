Content-Type: multipart/mixed; boundary="===============4856460998522552169=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: [Devel] Re: [PATCH v1 1/1] ACPI: utils: Fix reference counting in
 for_each_acpi_dev_match()
Date: Thu, 20 May 2021 21:40:50 +0200
Message-ID: <CAJZ5v0hsDpGtLHPQvcnof3c1LBnhoZSwWyHJdj1mOov9gV_W8A@mail.gmail.com>
In-Reply-To: CAJZ5v0in=qEtVULLF=RwBTiFqiRK-DyPfD4F6uUAqeUfPFB8QQ@mail.gmail.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============4856460998522552169==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, May 20, 2021 at 9:13 PM Rafael J. Wysocki <rafael(a)kernel.org> wro=
te:
>
> On Wed, May 19, 2021 at 11:19 PM Andy Shevchenko
> <andy.shevchenko(a)gmail.com> wrote:
> >
> > Currently it's possible to iterate over the dangling pointer in case th=
e device
> > suddenly disappears. This may happen becase callers put it at the end o=
f a loop.
> >
> > Instead, let's move that call inside acpi_dev_get_next_match_dev().
>
> Not really.

OK, I see what you want to achieve and the macro is actually buggy,
because it leaves unbalanced references behind.

> > Fixes: 803abec64ef9 ("media: ipu3-cio2: Add cio2-bridge to ipu3-cio2 dr=
iver")
> > Fixes: bf263f64e804 ("media: ACPI / bus: Add acpi_dev_get_next_match_de=
v() and helper macro")
> > Cc: Daniel Scally <djrscally(a)gmail.com>
> > Cc: Sakari Ailus <sakari.ailus(a)linux.intel.com>
> > Signed-off-by: Andy Shevchenko <andy.shevchenko(a)gmail.com>
> > ---
> >  drivers/acpi/utils.c                       | 5 +----
> >  drivers/media/pci/intel/ipu3/cio2-bridge.c | 8 +++-----
> >  include/acpi/acpi_bus.h                    | 5 -----
> >  3 files changed, 4 insertions(+), 14 deletions(-)
> >
> > diff --git a/drivers/acpi/utils.c b/drivers/acpi/utils.c
> > index 3b54b8fd7396..ccfc484dbffd 100644
> > --- a/drivers/acpi/utils.c
> > +++ b/drivers/acpi/utils.c
> > @@ -846,10 +846,6 @@ EXPORT_SYMBOL(acpi_dev_present);
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
> >   *
> >   * See additional information in acpi_dev_present() as well.

But the kerneldoc really needs to say that the caller is required to
obtain a reference on adev before passing it here, because that
reference will be dropped and the object pointed to by adev may not be
present any more after this returns.

> > @@ -866,6 +862,7 @@ acpi_dev_get_next_match_dev(struct acpi_device *ade=
v, const char *hid, const cha
> >         match.hrv =3D hrv;
> >
> >         dev =3D bus_find_device(&acpi_bus_type, start, &match, acpi_dev=
_match_cb);
> > +       acpi_dev_put(adev);
--===============4856460998522552169==--

