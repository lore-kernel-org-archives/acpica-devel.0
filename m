Content-Type: multipart/mixed; boundary="===============5866713895787234067=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: [Devel] Re: [PATCH v3 1/6] ACPI: scan: Extend
 acpi_walk_dep_device_list()
Date: Mon, 08 Mar 2021 14:36:27 +0100
Message-ID: <CAJZ5v0ijOhT3PVm6-gqnqycE-YZhD00dGbtK1UEV5nfrOF5Obw@mail.gmail.com>
In-Reply-To: CAHp75Vc2iwvh1RiYmQDPSvgNvGT_gBcGTK67F+MhWgXyoxqn0A@mail.gmail.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============5866713895787234067==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 7, 2021 at 9:39 PM Andy Shevchenko
<andy.shevchenko(a)gmail.com> wrote:
>
> On Sun, Mar 7, 2021 at 3:36 PM Daniel Scally <djrscally(a)gmail.com> wrot=
e:
> > On 22/02/2021 13:34, Andy Shevchenko wrote:
> > > On Mon, Feb 22, 2021 at 3:12 PM Daniel Scally <djrscally(a)gmail.com>=
 wrote:
> > >> The acpi_walk_dep_device_list() is not as generalisable as its name
> > >> implies, serving only to decrement the dependency count for each
> > >> dependent device of the input. Extend the function to instead accept
> > >> a callback which can be applied to all the dependencies in acpi_dep_=
list.
> > >> Replace all existing calls to the function with calls to a wrapper, =
passing
> > >> a callback that applies the same dependency reduction.
> > > The code looks okay to me, if it was the initial idea, feel free to a=
dd
> > > Reviewed-by: Andy Shevchenko <andy.shevchenko(a)gmail.com>
> >
> >
> > Thank you!
> >
> >
> > >> + */
> > >> +void acpi_dev_flag_dependency_met(acpi_handle handle)
> > >> +{
> > > Since it's acpi_dev_* namespace, perhaps it should take struct acpi_d=
evice here?
> >
> >
> > I can do this, but I avoided it because in most of the uses in the
> > kernel currently there's no struct acpi_device, they're just passing
> > ACPI_HANDLE(dev) instead, so I'd need to get the adev with
> > ACPI_COMPANION() in each place. It didn't seem worth it...

It may not even be possible sometimes, because that function may be
called before creating all of the struct acpi_device objects (like in
the case of deferred enumeration).

> > but happy to
> > do it if you'd prefer it that way?
>
> I see, let Rafael decide then. I'm not pushing here.

Well, it's a matter of correctness.
--===============5866713895787234067==--

