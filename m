Content-Type: multipart/mixed; boundary="===============7009613193008573363=="
MIME-Version: 1.0
From: Andy Shevchenko <andy.shevchenko at gmail.com>
Subject: [Devel] Re: [PATCH v3 1/6] ACPI: scan: Extend
 acpi_walk_dep_device_list()
Date: Mon, 08 Mar 2021 15:57:04 +0200
Message-ID: <YEYtME2AxpXBq6iF@smile.fi.intel.com>
In-Reply-To: CAJZ5v0ijOhT3PVm6-gqnqycE-YZhD00dGbtK1UEV5nfrOF5Obw@mail.gmail.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============7009613193008573363==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 08, 2021 at 02:36:27PM +0100, Rafael J. Wysocki wrote:
> On Sun, Mar 7, 2021 at 9:39 PM Andy Shevchenko
> <andy.shevchenko(a)gmail.com> wrote:
> > On Sun, Mar 7, 2021 at 3:36 PM Daniel Scally <djrscally(a)gmail.com> wr=
ote:
> > > On 22/02/2021 13:34, Andy Shevchenko wrote:
> > > > On Mon, Feb 22, 2021 at 3:12 PM Daniel Scally <djrscally(a)gmail.co=
m> wrote:
> > > >> The acpi_walk_dep_device_list() is not as generalisable as its name
> > > >> implies, serving only to decrement the dependency count for each
> > > >> dependent device of the input. Extend the function to instead acce=
pt
> > > >> a callback which can be applied to all the dependencies in acpi_de=
p_list.
> > > >> Replace all existing calls to the function with calls to a wrapper=
, passing
> > > >> a callback that applies the same dependency reduction.
> > > > The code looks okay to me, if it was the initial idea, feel free to=
 add
> > > > Reviewed-by: Andy Shevchenko <andy.shevchenko(a)gmail.com>

...

> > > >> +void acpi_dev_flag_dependency_met(acpi_handle handle)

> > > > Since it's acpi_dev_* namespace, perhaps it should take struct acpi=
_device here?
> > >
> > > I can do this, but I avoided it because in most of the uses in the
> > > kernel currently there's no struct acpi_device, they're just passing
> > > ACPI_HANDLE(dev) instead, so I'd need to get the adev with
> > > ACPI_COMPANION() in each place. It didn't seem worth it...
> =

> It may not even be possible sometimes, because that function may be
> called before creating all of the struct acpi_device objects (like in
> the case of deferred enumeration).
> =

> > > but happy to
> > > do it if you'd prefer it that way?
> >
> > I see, let Rafael decide then. I'm not pushing here.
> =

> Well, it's a matter of correctness.

Looking at your above comment it is indeed. Thanks for clarification!
But should we have acpi_dev_*() namespace for this function if it takes han=
dle?

For time being nothing better than following comes to my mind:

__acpi_dev_flag_dependency_met() =3D> __acpi_flag_device_dependency_met()
acpi_dev_flag_dependency_met() =3D> acpi_flag_device_dependency_met()

-- =

With Best Regards,
Andy Shevchenko


--===============7009613193008573363==--

