Content-Type: multipart/mixed; boundary="===============8095651092824199307=="
MIME-Version: 1.0
From: Andy Shevchenko <andy.shevchenko at gmail.com>
Subject: [Devel] Re: [PATCH v2 12/12] ipu3-cio2: Add cio2-bridge to ipu3-cio2
 driver
Date: Sat, 19 Dec 2020 20:52:29 +0200
Message-ID: <CAHp75VcebKas4j-vByodicHxRMrO4jkaJToSUW3iLJC2+vY_iA@mail.gmail.com>
In-Reply-To: e2b4c35f-5020-c332-d97a-8ba25be0e55e@gmail.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============8095651092824199307==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 19, 2020 at 2:25 AM Daniel Scally <djrscally(a)gmail.com> wrote:
> On 18/12/2020 21:17, Andy Shevchenko wrote:
> > On Thu, Dec 17, 2020 at 11:43:37PM +0000, Daniel Scally wrote:

...

> >> +    sensor->ep_properties[0] =3D PROPERTY_ENTRY_U32(sensor->prop_name=
s.bus_type, 4);
> >
> > Does 4 has any meaning that can be described by #define ?
>
> It's V4L2_FWNODE_BUS_TYPE_CSI2_DPHY:
>
> https://elixir.bootlin.com/linux/latest/source/drivers/media/v4l2-core/v4=
l2-fwnode.c#L36
>
> That enum's not in an accessible header, but I can define it in this
> module's header

Maybe you can do a preparatory patch to make it visible to v4l2
drivers? (Like moving to one of v4l2 headers)

...

> >> +                    if (bridge->n_sensors >=3D CIO2_NUM_PORTS) {
> >> +                            dev_warn(&cio2->dev, "Exceeded available =
CIO2 ports\n");
> >
> >> +                            /* overflow i so outer loop ceases */
> >> +                            i =3D ARRAY_SIZE(cio2_supported_sensors);
> >> +                            break;
> >
> > Why not to create a new label below and assign ret here with probably c=
omment
> > why it's not an error?
>
> Sure, I can do that, but since it wouldn't need any cleanup I could also
> just return 0 here as Laurent suggest (but with a comment explaining why
> that's ok as you say) - do you have a preference?

While it's a good suggestion it will bring a bit of inconsistency into
approach. Everywhere else in the function you are using the goto
approach.
So yes, I have a preference.

> >> +                    }

...

> >> +                    ret =3D cio2_bridge_read_acpi_buffer(adev, "SSDB",
> >> +                                                       &sensor->ssdb,
> >> +                                                       sizeof(sensor-=
>ssdb));
> >> +                    if (ret < 0)
> >
> > if (ret) (because positive case can be returned just by next conditiona=
l).
>
> cio2_bridge_read_acpi_buffer() returns the buffer length on success at
> the moment, but I can change it to return 0 and have this be if (ret)

Please correct this somehow, because the next failure returns it
instead of error...

> >> +                            goto err_put_adev;
> >> +
> >> +                    if (sensor->ssdb.lanes > 4) {
> >> +                            dev_err(&adev->dev,
> >> +                                    "Number of lanes in SSDB is inval=
id\n");

...I'm even thinking that you have to assign ret here to something meaningf=
ul.

> >> +                            goto err_put_adev;
> >> +                    }

-- =

With Best Regards,
Andy Shevchenko
--===============8095651092824199307==--

