Content-Type: multipart/mixed; boundary="===============5547055750410959714=="
MIME-Version: 1.0
From: Andy Shevchenko <andy.shevchenko at gmail.com>
Subject: [Devel] Re: [PATCH v3 5/6] platform/x86: Add intel_skl_int3472 driver
Date: Tue, 23 Feb 2021 14:01:25 +0200
Message-ID: <YDTuldAG9FB8+RAd@smile.fi.intel.com>
In-Reply-To: 534849f6-c7b5-19b0-a09f-cd410cde93bd@gmail.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============5547055750410959714==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 22, 2021 at 10:35:44PM +0000, Daniel Scally wrote:
> On 22/02/2021 14:58, Andy Shevchenko wrote:
> > On Mon, Feb 22, 2021 at 3:12 PM Daniel Scally <djrscally(a)gmail.com> w=
rote:

...

> >> +       if (obj->buffer.length > sizeof(*cldb)) {
> >> +               dev_err(&adev->dev, "The CLDB buffer is too large\n");
> >> +               ret =3D -EINVAL;
> > ENOSPC? ENOMEM?
> =

> I still think EINVAL actually, as in this case the problem isn't that
> space couldn't be allocated but that the buffer in the SSDB is larger
> than I expect it to be, which means the definition of it has changed /
> this device isn't actually supported.

OK!

...

> >> +       if (!IS_ERR_OR_NULL(sensor_config) && sensor_config->function_=
maps) {
> > Hmm...
> >
> > Would
> >
> > if (IS_ERR_OR_NULL(sensor_config))
> >   return 0;
> >
> > if (!_maps)
> >   return 0;
> >
> > with respective comments working here?
> =

> No, because the absence of either sensor_config or
> sensor_config->function_maps is not a failure mode. We only need to
> provide sensor_configs for some platforms, and function_maps for even
> fewer. So if that check is false, the rest of the function should still
> execute.

I see, thanks for elaboration.

...

> >> +       if (ares->type !=3D ACPI_RESOURCE_TYPE_GPIO ||
> >> +           ares->data.gpio.connection_type !=3D ACPI_RESOURCE_GPIO_TY=
PE_IO)
> >> +               return 1; /* Deliberately positive so parsing continue=
s */
> > I don't like to lose control over ACPI_RESOURCE_TYPE_GPIO, i.e.
> > spreading it over kernel code (yes, I know about one existing TS
> > case).
> > Consider to provide a helper in analogue to acpi_gpio_get_irq_resource(=
).
> =

> Sure, but I probably name it acpi_gpio_is_io_resource() - a function
> named "get" which returns a bool seems a bit funny to me.

But don't you need the resource itself?

You may extract and check resource at the same time as
acpi_gpio_get_irq_resource() does.

...

> >> +       struct int3472_discrete_device *int3472 =3D platform_get_drvda=
ta(pdev);
> >> +       if (int3472->gpios.dev_id)
> >> +               gpiod_remove_lookup_table(&int3472->gpios);
> > gpiod_remove_lookup_table() is now NULL-aware.
> > But in any case I guess you don't need the above check.
> =

> Sorry; forgot to call out that I didn't follow that suggestion;
> int3472->gpios is a _struct_ rather than a pointer, so &int3472->gpios
> won't be NULL, even if I haven't filled anything in to there yet because
> it failed before it got to that point. So, not sure that it quite works
> there.

I think if you initialize the ->list member you can remove without check.

-- =

With Best Regards,
Andy Shevchenko


--===============5547055750410959714==--

