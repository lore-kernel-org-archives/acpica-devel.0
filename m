Content-Type: multipart/mixed; boundary="===============4479499225044573782=="
MIME-Version: 1.0
From: Andy Shevchenko <andy.shevchenko at gmail.com>
Subject: [Devel] Re: [PATCH v3 1/1] ACPI: scan: Use unique number for
 instance_no
Date: Mon, 22 Mar 2021 18:11:37 +0200
Message-ID: <CAHp75VeC2MUEQTQnZMb96sz+P7gQVUPtds9CfxFf9t7rOVeXRg@mail.gmail.com>
In-Reply-To: CAJZ5v0gxjCiP-XbvLkHZiewjMhpR6KdJFapjV_-F05Uc_G7tqQ@mail.gmail.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============4479499225044573782==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 22, 2021 at 5:42 PM Rafael J. Wysocki <rafael(a)kernel.org> wro=
te:
> On Mon, Mar 22, 2021 at 4:02 PM Andy Shevchenko
> <andy.shevchenko(a)gmail.com> wrote:
> > On Mon, Mar 22, 2021 at 4:57 PM Rafael J. Wysocki <rafael(a)kernel.org>=
 wrote:
> > > On Fri, Mar 19, 2021 at 8:21 PM Andy Shevchenko
> > > <andriy.shevchenko(a)linux.intel.com> wrote:
> > > >
> > > > The decrementation of acpi_device_bus_id->instance_no
> > > > in acpi_device_del() is incorrect, because it may cause
> > > > a duplicate instance number to be allocated next time
> > > > a device with the same acpi_device_bus_id is added.
> > > >
> > > > Replace above mentioned approach by using IDA framework.
> >
> > ...
> >
> > > > +       result =3D ida_simple_get(&acpi_device_bus_id->instance_ida=
, 0, 255, GFP_KERNEL);
> > >
> > > This is ida_alloc_range(ida, start, (end) - 1, gfp), so I think it
> > > should be 256 above, instead of 255.
> >
> > Ah, good catch!
> >
> >
> > > While at it, though, there can be more than 256 CPU devices easily on
> > > contemporary systems, so I would use a greater number here.  Maybe
> > > 4096 and define a symbol for it?
> >
> > I was thinking about it, but there is a problem with the device name,
> > since it will break a lot of code,
>
> What problem is there?

If we have only 2 digits, but you are right, we have _at least_ two digits.

> > And taking into account that currently we don't change the behaviour
> > it is good enough per se as a fix.
> >
> > That said, we may extend by an additional patch with a logic like this:
> >
> > res =3D ida_get(4096)
> > if (res < 0)
> >   return res;
> > if (res >=3D 256)
> >  use %04x
> > else
> >  use %02x
> >
> > Would it make sense to you?
>
> I'm not sure why not to always use %02x ?  It doesn't truncate numbers
> longer than 2 digits AFAICS.

Yeah, should work. Thanks for review, I'll send a new version soon.

-- =

With Best Regards,
Andy Shevchenko
--===============4479499225044573782==--

