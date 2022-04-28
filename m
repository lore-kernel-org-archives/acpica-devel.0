Content-Type: multipart/mixed; boundary="===============6297322756703789463=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: [Devel] Re: [PATCH 1/1] Constify AcpiGetHandle pathname argument
Date: Thu, 28 Apr 2022 14:59:22 +0200
Message-ID: <CAJZ5v0iWjAV8325ObG8mn3Wam9BMaRuNxp6JNYcRxYWQd4nDxg@mail.gmail.com>
In-Reply-To: Ymmriu0wN04o4s0/@paasikivi.fi.intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============6297322756703789463==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 27, 2022 at 10:46 PM Sakari Ailus
<sakari.ailus(a)linux.intel.com> wrote:
>
> Hi Rafael,
>
> On Wed, Apr 27, 2022 at 06:35:09PM +0200, Rafael J. Wysocki wrote:
> > On Wed, Apr 27, 2022 at 12:48 PM Sakari Ailus
> > <sakari.ailus(a)linux.intel.com> wrote:
> > >
> > > AcpiGetHandle doesn't write to the pathname argument, therefore make =
it
> > > const.
> > >
> > > This allows later on passing pathname to AcpiGetHandle which is const,
> > > without creating a copy of it.
> > >
> > > Signed-off-by: Sakari Ailus <sakari.ailus(a)linux.intel.com>
> > > ---
> > > Hi folks,
> > >
> > > This isn't required by acpica internally as such but upcoming patches=
 to
> > > Linux depend on it.
> >
> > I'm afraid that the kernel source cannot depart from the upstream
> > ACPICA this way, though.
>
> I'm not quite sure I follow you. I wanted to make this change to ACPICA so
> the two remain in sync.

My mistake, sorry.

It looks OK.  Please submit a pull request to the upstream project at
https://github.com/acpica/acpica and feel free to add my ACK to the
commit.

> >
> > >  source/components/namespace/nsxfname.c | 2 +-
> > >  source/include/acpixf.h                | 2 +-
> > >  2 files changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/source/components/namespace/nsxfname.c b/source/componen=
ts/namespace/nsxfname.c
> > > index 7a7393b61..da89b2d8e 100644
> > > --- a/source/components/namespace/nsxfname.c
> > > +++ b/source/components/namespace/nsxfname.c
> > > @@ -192,7 +192,7 @@ AcpiNsCopyDeviceId (
> > >  ACPI_STATUS
> > >  AcpiGetHandle (
> > >      ACPI_HANDLE             Parent,
> > > -    ACPI_STRING             Pathname,
> > > +    const char              *Pathname,
> > >      ACPI_HANDLE             *RetHandle)
> > >  {
> > >      ACPI_STATUS             Status;
> > > diff --git a/source/include/acpixf.h b/source/include/acpixf.h
> > > index 7610f2e30..a3f7397e7 100644
> > > --- a/source/include/acpixf.h
> > > +++ b/source/include/acpixf.h
> > > @@ -766,7 +766,7 @@ ACPI_EXTERNAL_RETURN_STATUS (
> > >  ACPI_STATUS
> > >  AcpiGetHandle (
> > >      ACPI_HANDLE             Parent,
> > > -    ACPI_STRING             Pathname,
> > > +    const char              *Pathname,
> > >      ACPI_HANDLE             *RetHandle))
> > >
> > >  ACPI_EXTERNAL_RETURN_STATUS (
> > > --
> > > 2.30.2
> > >
>
> --
> Sakari Ailus
--===============6297322756703789463==--

