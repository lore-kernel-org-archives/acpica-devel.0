Content-Type: multipart/mixed; boundary="===============0781049456854347137=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: [Devel] Re: [PATCH v3 1/6] ACPI: scan: Extend
 acpi_walk_dep_device_list()
Date: Mon, 08 Mar 2021 16:45:07 +0100
Message-ID: <CAJZ5v0i+suMNWhUc=v0pnpabS-Ew-CMeSH945JB0YKnQAbi4Wg@mail.gmail.com>
In-Reply-To: YEYtME2AxpXBq6iF@smile.fi.intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============0781049456854347137==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 8, 2021 at 2:57 PM Andy Shevchenko
<andy.shevchenko(a)gmail.com> wrote:
>
> On Mon, Mar 08, 2021 at 02:36:27PM +0100, Rafael J. Wysocki wrote:
> > On Sun, Mar 7, 2021 at 9:39 PM Andy Shevchenko
> > <andy.shevchenko(a)gmail.com> wrote:
> > > On Sun, Mar 7, 2021 at 3:36 PM Daniel Scally <djrscally(a)gmail.com> =
wrote:
> > > > On 22/02/2021 13:34, Andy Shevchenko wrote:
> > > > > On Mon, Feb 22, 2021 at 3:12 PM Daniel Scally <djrscally(a)gmail.=
com> wrote:
> > > > >> The acpi_walk_dep_device_list() is not as generalisable as its n=
ame
> > > > >> implies, serving only to decrement the dependency count for each
> > > > >> dependent device of the input. Extend the function to instead ac=
cept
> > > > >> a callback which can be applied to all the dependencies in acpi_=
dep_list.
> > > > >> Replace all existing calls to the function with calls to a wrapp=
er, passing
> > > > >> a callback that applies the same dependency reduction.
> > > > > The code looks okay to me, if it was the initial idea, feel free =
to add
> > > > > Reviewed-by: Andy Shevchenko <andy.shevchenko(a)gmail.com>
>
> ...
>
> > > > >> +void acpi_dev_flag_dependency_met(acpi_handle handle)
>
> > > > > Since it's acpi_dev_* namespace, perhaps it should take struct ac=
pi_device here?
> > > >
> > > > I can do this, but I avoided it because in most of the uses in the
> > > > kernel currently there's no struct acpi_device, they're just passing
> > > > ACPI_HANDLE(dev) instead, so I'd need to get the adev with
> > > > ACPI_COMPANION() in each place. It didn't seem worth it...
> >
> > It may not even be possible sometimes, because that function may be
> > called before creating all of the struct acpi_device objects (like in
> > the case of deferred enumeration).
> >
> > > > but happy to
> > > > do it if you'd prefer it that way?
> > >
> > > I see, let Rafael decide then. I'm not pushing here.
> >
> > Well, it's a matter of correctness.
>
> Looking at your above comment it is indeed. Thanks for clarification!

Well, actually, the struct device for the object passed to this
function should be there already, because otherwise it wouldn't make
sense to update the list.  So my comment above is not really
applicable to this particular device and the function could take a
struct acpi_device pointer argument.  Sorry for the confusion.

> But should we have acpi_dev_*() namespace for this function if it takes h=
andle?

It takes a device object handle.

Anyway, as per the above, it can take a struct acpi_device pointer
argument in which case the "acpi_dev_" prefix should be fine.

> For time being nothing better than following comes to my mind:
>
> __acpi_dev_flag_dependency_met() =3D> __acpi_flag_device_dependency_met()
> acpi_dev_flag_dependency_met() =3D> acpi_flag_device_dependency_met()

The above said, the name is somewhat confusing overall IMV.

Something like acpi_dev_clear_dependencies() might be better.

So lets make it something like

void acpi_dev_clear_dependencies(struct acpi_device *supplier);
--===============0781049456854347137==--

