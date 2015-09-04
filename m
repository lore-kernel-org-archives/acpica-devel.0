Content-Type: multipart/mixed; boundary="===============2961222821240728464=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: Re: [Devel] PATCH proposal removing use of strtoul in
 events/evgpeinit.c
Date: Fri, 04 Sep 2015 13:58:06 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37D343333@ORSMSX112.amr.corp.intel.com>
In-Reply-To: 55E97C8B.3050302@netbsd.org
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============2961222821240728464==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Sure, but the original code is much simpler.


> -----Original Message-----
> From: Devel [mailto:devel-bounces(a)acpica.org] On Behalf Of Richard PALO
> Sent: Friday, September 04, 2015 4:12 AM
> To: devel(a)acpica.org
> Subject: [Devel] PATCH proposal removing use of strtoul in
> events/evgpeinit.c
> =

> I'm noticing on catching up recently, e.g. on 20150717, that there is the
> following issue:
> > /home/richard/ws/illumos-
> gate/usr/src/common/acpica/components/events/evgpeinit.c: In function
> 'AcpiEvMatchGpeMethod':
> > /home/richard/ws/illumos-gate/usr/src/common/acpica/components/events/
> > evgpeinit.c:398: error: implicit declaration of function 'strtoul'
> > [-Wimplicit-function-declaration]
> =

> strtoul is indirectly defined in acsolaris via a system header as:
> =

> I like to propose the following patch substituting for a simplified,
> specific conversion in the file events/evgpeinit.c.
> >extern unsigned long strtoul(const char *, char **, int);
> =

> This seems to be the only real use of strtoul with _KERNEL defined.
> =

> Looking at the code in question, for two hex digits is doesn't seem the
> worth to use it so I propose to replace as follows:
> > diff --git a/usr/src/common/acpica/components/events/evgpeinit.c
> > b/usr/src/common/acpica/components/events/evgpeinit.c
> > index d23a345..de1e15a 100644
> > --- a/usr/src/common/acpica/components/events/evgpeinit.c
> > +++ b/usr/src/common/acpica/components/events/evgpeinit.c
> > @@ -395,8 +395,22 @@ AcpiEvMatchGpeMethod (
> >
> >      /* 4) The last two characters of the name are the hex GPE Number
> > */
> >
> > -    GpeNumber =3D strtoul (&Name[2], NULL, 16);
> > -    if (GpeNumber =3D=3D ACPI_UINT32_MAX)
> > +    /* GpeNumber =3D strtoul (&Name[2], NULL, 16); */
> > +    /*
> > +     * As this function can be called in KERNEL, not all systems have
> > +     * strtoul() available.  Since this is only for a single hex value,
> > +     * manually convert nibble by nibble, checking for possible errors.
> > +     */
> > +    GpeNumber =3D isdigit(Name[2]) ? (Name[2] - '0')<<4 :
> > +       isxdigit(Name[2]) ? (toupper(Name[2]) - 'A' + 10)<<4 : 0xFFFF;
> > +
> > +    if (GpeNumber !=3D 0xFFFF) {
> > +        GpeNumber =3D isdigit(Name[3]) ? GpeNumber + (Name[3] - '0') :
> > +           isxdigit(Name[3]) ? GpeNumber + (toupper(Name[3]) - 'A' +
> 10) :
> > +           0xFFFF;
> > +    }
> > +
> > +    if (GpeNumber =3D=3D 0xFFFF || Name[4] !=3D '\0')
> >      {
> >          /* Conversion failed; invalid method, just ignore it */
> >
> =

> --
> Richard PALO
> =

> _______________________________________________
> Devel mailing list
> Devel(a)acpica.org
> https://lists.acpica.org/mailman/listinfo/devel

--===============2961222821240728464==--

