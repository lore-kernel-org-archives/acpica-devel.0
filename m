Content-Type: multipart/mixed; boundary="===============0040128935160338815=="
MIME-Version: 1.0
From: Andy Shevchenko <andy.shevchenko at gmail.com>
Subject: [Devel] Re: [PATCH v1 1/1] ACPI: bus: Introduce acpi_dev_get() and
 reuse it in ACPI code
Date: Mon, 12 Apr 2021 20:47:38 +0300
Message-ID: <CAHp75VeW7w-tX96B8Gh=E1meTHLzuocqaM2MTLyokc5hETVj7A@mail.gmail.com>
In-Reply-To: CAJZ5v0jQ=UU8FgFFF_ht_v1dZwhp-32wi_QNaZuf6vBaORU41w@mail.gmail.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============0040128935160338815==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 12, 2021 at 8:32 PM Rafael J. Wysocki <rafael(a)kernel.org> wro=
te:
> On Sat, Apr 10, 2021 at 3:47 PM Andy Shevchenko
> <andy.shevchenko(a)gmail.com> wrote:

...

> >  static void get_acpi_device(void *dev)
> >  {
> > -       if (dev)
> > -               get_device(&((struct acpi_device *)dev)->dev);
> > +       acpi_dev_get(dev);
>
> I would do
>
> if (dev)
>     acpi_dev_get(dev);
>
> here.

Hmm... I don't see a point. acpi_dev_get() guaranteed to perform this check.

> >  }


> > +static inline void acpi_dev_get(struct acpi_device *adev)
> > +{
> > +       if (adev)
> > +               get_device(&adev->dev);
>
> And I would drop the adev check from here (because the code calling it
> may be running with wrong assumptions if adev is NULL).  Or it should
> return adev and the caller should be held responsible for checking it
> against NULL (if they care).

But this follows the get_device() / put_device() logic. Personally I
don't think this is a good idea to deviate. Note the
acpi_bus_get_acpi_device() / acpi_bus_put_acpi_device() as well.

> > +}



-- =

With Best Regards,
Andy Shevchenko
--===============0040128935160338815==--

