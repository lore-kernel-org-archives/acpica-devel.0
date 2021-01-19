Content-Type: multipart/mixed; boundary="===============6750867403799048956=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: [Devel] Re: [PATCH v2 4/7] i2c: i2c-core-acpi: Add i2c_acpi_dev_name()
Date: Tue, 19 Jan 2021 14:19:16 +0100
Message-ID: <CAJZ5v0hUELtKc9CK=z47XQvSAAx=wTWvoVwP-PaMqugaXaCgZQ@mail.gmail.com>
In-Reply-To: YAVSf7+iTPNYf5XS@pendragon.ideasonboard.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============6750867403799048956==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 18, 2021 at 9:55 PM Laurent Pinchart
<laurent.pinchart(a)ideasonboard.com> wrote:
>
> Hi Daniel,
>
> Thank you for the patch.
>
> On Mon, Jan 18, 2021 at 12:34:25AM +0000, Daniel Scally wrote:
> > We want to refer to an i2c device by name before it has been
>
> s/i2c device/acpi i2c device/ ?
>
> > created by the kernel; add a function that constructs the name
> > from the acpi device instead.
> >
> > Signed-off-by: Daniel Scally <djrscally(a)gmail.com>
> > ---
> > Changes in v2:
> >
> >       - Stopped using devm_kasprintf()
> >
> >  drivers/i2c/i2c-core-acpi.c | 16 ++++++++++++++++
> >  include/linux/i2c.h         |  5 +++++
> >  2 files changed, 21 insertions(+)
> >
> > diff --git a/drivers/i2c/i2c-core-acpi.c b/drivers/i2c/i2c-core-acpi.c
> > index 37c510d9347a..98c3ba9a2350 100644
> > --- a/drivers/i2c/i2c-core-acpi.c
> > +++ b/drivers/i2c/i2c-core-acpi.c
> > @@ -497,6 +497,22 @@ struct i2c_client *i2c_acpi_new_device(struct devi=
ce *dev, int index,
> >  }
> >  EXPORT_SYMBOL_GPL(i2c_acpi_new_device);
> >
> > +/**
> > + * i2c_acpi_dev_name - Construct i2c device name for devs sourced from=
 ACPI
> > + * @adev:     ACPI device to construct the name for
> > + *
> > + * Constructs the name of an i2c device matching the format used by
> > + * i2c_dev_set_name() to allow users to refer to an i2c device by name=
 even
> > + * before they have been instantiated.
> > + *
> > + * The caller is responsible for freeing the returned pointer.
> > + */
> > +char *i2c_acpi_dev_name(struct acpi_device *adev)
> > +{
> > +     return kasprintf(GFP_KERNEL, I2C_DEV_NAME_FORMAT, acpi_dev_name(a=
dev));
>
> There's a real danger of a memory leak, as the function name sounds very
> similar to dev_name() or acpi_dev_name() and those don't allocate
> memory. I'm not sure what a better name would be, but given that this
> function is only used in patch 6/7 and not in the I2C subsystem itself,
> I wonder if we should inline this kasprintf() call in the caller and
> drop this patch.

IMO if this is a one-off usage, it's better to open-code it.
--===============6750867403799048956==--

