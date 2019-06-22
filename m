Content-Type: multipart/mixed; boundary="===============4517402996633770818=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: Re: [Devel] [PATCH v2 1/3] ACPI: Resolve objects on host-directed
 table loads
Date: Sat, 22 Jun 2019 11:04:32 +0200
Message-ID: <CAJZ5v0gtG5mcBwMB7mZ2aooBnJmL7fmx=QpoeMTDpbbHrue6OA@mail.gmail.com>
In-Reply-To: alpine.DEB.2.20.1906200843320.9673@fox.voss.local
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============4517402996633770818==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 20, 2019 at 8:49 AM Nikolaus Voss <nv(a)vosn.de> wrote:
>
> On Wed, 19 Jun 2019, Moore, Robert wrote:
> >
> >
> >> -----Original Message-----
> >> From: Nikolaus Voss [mailto:nv(a)vosn.de]
> >> Sent: Wednesday, June 19, 2019 2:31 AM
> >> To: Moore, Robert <robert.moore(a)intel.com>
> >> Cc: Rafael J. Wysocki <rafael(a)kernel.org>; Rafael J. Wysocki
> >> <rjw(a)rjwysocki.net>; Len Brown <lenb(a)kernel.org>; Schmauss, Erik
> >> <erik.schmauss(a)intel.com>; Jacek Anaszewski
> >> <jacek.anaszewski(a)gmail.com>; Pavel Machek <pavel(a)ucw.cz>; Dan Mur=
phy
> >> <dmurphy(a)ti.com>; Thierry Reding <thierry.reding(a)gmail.com>; ACPI =
Devel
> >> Maling List <linux-acpi(a)vger.kernel.org>; open list:ACPI COMPONENT
> >> ARCHITECTURE (ACPICA) <devel(a)acpica.org>; linux-leds(a)vger.kernel.o=
rg;
> >> Linux PWM List <linux-pwm(a)vger.kernel.org>; Linux Kernel Mailing List
> >> <linux-kernel(a)vger.kernel.org>; nikolaus.voss(a)loewensteinmedical.de
> >> Subject: RE: [PATCH v2 1/3] ACPI: Resolve objects on host-directed tab=
le
> >> loads
> >>
> >> Hi Bob,
> >>
> >> On Tue, 18 Jun 2019, Moore, Robert wrote:
> >>>
> >>>
> >>>> -----Original Message-----
> >>>> From: Moore, Robert
> >>>> Sent: Tuesday, June 18, 2019 1:25 PM
> >>>> To: 'Nikolaus Voss' <nv(a)vosn.de>
> >>>> Cc: 'Rafael J. Wysocki' <rafael(a)kernel.org>; 'Rafael J. Wysocki'
> >>>> <rjw(a)rjwysocki.net>; 'Len Brown' <lenb(a)kernel.org>; Schmauss, Er=
ik
> >>>> <erik.schmauss(a)intel.com>; 'Jacek Anaszewski'
> >>>> <jacek.anaszewski(a)gmail.com>; 'Pavel Machek' <pavel(a)ucw.cz>; 'Dan
> >>>> Murphy' <dmurphy(a)ti.com>; 'Thierry Reding'
> >>>> <thierry.reding(a)gmail.com>; 'ACPI Devel Maling List'
> >>>> <linux-acpi(a)vger.kernel.org>; 'open list:ACPI COMPONENT ARCHITECTU=
RE
> >>>> (ACPICA)' <devel(a)acpica.org>; 'linux- leds(a)vger.kernel.org' <lin=
ux-
> >> leds(a)vger.kernel.org>; 'Linux PWM List'
> >>>> <linux-pwm(a)vger.kernel.org>; 'Linux Kernel Mailing List' <linux-
> >>>> kernel(a)vger.kernel.org>
> >>>> Subject: RE: [PATCH v2 1/3] ACPI: Resolve objects on host-directed
> >>>> table loads
> >>>>
> >>>> If it is in fact the AcpiLoadTable interface that is incorrect, that
> >>>> of course is different. I'll check that out next.
> >>>>
> >>> [Moore, Robert]
> >>>
> >>> Yes, this is the issue, not specifically the Load() operator, but the
> >>> AcpiLoadTable interface only.
> >>
> >> thanks for checking this out. So what is the conclusion? Is my fix of
> >> AcpiLoadTable() sufficient or do we need a different solution?
> >>
> >> Niko
> >>
> >
> >
> > Your change is in the correct area. We want to do something like this, =
however:
> >
> > diff --git a/source/components/executer/exconfig.c b/source/components/=
executer/exconfig.c
> > index 84a058ada..eba1a6d28 100644
> > --- a/source/components/executer/exconfig.c
> > +++ b/source/components/executer/exconfig.c
> > @@ -342,10 +342,9 @@ AcpiExLoadTableOp (
> >         return_ACPI_STATUS (Status);
> >     }
> >
> > -    /* Complete the initialization/resolution of package objects */
> > +    /* Complete the initialization/resolution of new objects */
> >
> > -    Status =3D AcpiNsWalkNamespace (ACPI_TYPE_PACKAGE, ACPI_ROOT_OBJEC=
T,
> > -        ACPI_UINT32_MAX, 0, AcpiNsInitOnePackage, NULL, NULL, NULL);
> > +    AcpiNsInitializeObjects ();
> >
> >     /* Parameter Data (optional) */
> >
> > @@ -620,10 +619,11 @@ AcpiExLoadOp (
> >         return_ACPI_STATUS (Status);
> >     }
> >
> > -    /* Complete the initialization/resolution of package objects */
> > +    /* Complete the initialization/resolution of new objects */
> >
> > -    Status =3D AcpiNsWalkNamespace (ACPI_TYPE_PACKAGE, ACPI_ROOT_OBJEC=
T,
> > -        ACPI_UINT32_MAX, 0, AcpiNsInitOnePackage, NULL, NULL, NULL);
> > +    AcpiExExitInterpreter ();
> > +    AcpiNsInitializeObjects ();
> > +    AcpiExEnterInterpreter ();
> >
> >     /* Store the DdbHandle into the Target operand */
> >
> > diff --git a/source/components/tables/tbxfload.c b/source/components/ta=
bles/tbxfload.c
> > index 217d54bf0..1e17db6c8 100644
> > --- a/source/components/tables/tbxfload.c
> > +++ b/source/components/tables/tbxfload.c
> > @@ -479,6 +479,13 @@ AcpiLoadTable (
> >     ACPI_INFO (("Host-directed Dynamic ACPI Table Load:"));
> >     Status =3D AcpiTbInstallAndLoadTable (ACPI_PTR_TO_PHYSADDR (Table),
> >         ACPI_TABLE_ORIGIN_EXTERNAL_VIRTUAL, FALSE, &TableIndex);
> > +    if (ACPI_SUCCESS (Status))
> > +    {
> > +        /* Complete the initialization/resolution of new objects */
> > +
> > +        AcpiNsInitializeObjects ();
> > +    }
> > +
> >     return_ACPI_STATUS (Status);
> > }
>
> Ok, I see your are taking this up (I was a bit unsure after your previous
> post). Thanks,

The $subject patch has been queued for 5.3.  If I should drop it,
please let me know.

Thanks!

--===============4517402996633770818==--

