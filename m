Content-Type: multipart/mixed; boundary="===============0040518803121814856=="
MIME-Version: 1.0
From: Andy Shevchenko <andy.shevchenko at gmail.com>
Subject: [Devel] Re: [PATCH 18/18] ipu3: Add driver for dummy INT3472 ACPI
 device
Date: Tue, 01 Dec 2020 20:45:25 +0000
Message-ID: <CAHp75Vfq1zPxt5RpdD16rKiLOSfda7FwfHsot5JCTd98tXxPdQ@mail.gmail.com>
In-Reply-To: 4831d44a-5bcc-8cf3-964c-c7dca6827458@redhat.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============0040518803121814856==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 1, 2020 at 10:39 PM Hans de Goede <hdegoede(a)redhat.com> wrote:
> On 12/1/20 8:21 PM, Andy Shevchenko wrote:
> > On Tue, Dec 01, 2020 at 09:06:38PM +0200, Laurent Pinchart wrote:
> >> On Tue, Dec 01, 2020 at 09:05:23PM +0200, Andy Shevchenko wrote:
> >>> On Tue, Dec 01, 2020 at 08:55:48PM +0200, Laurent Pinchart wrote:
> >>>> On Tue, Dec 01, 2020 at 08:54:17PM +0200, Andy Shevchenko wrote:
> >>>>> On Tue, Dec 01, 2020 at 08:30:03AM +0000, Dan Scally wrote:
> >>>>>> On 30/11/2020 20:07, Andy Shevchenko wrote:

...

> >>>>>>>> +static struct int3472_sensor_regulator_map int3472_sensor_regul=
ator_maps[] =3D {
> >>>>>>>> +      { "GNDF140809R", 2, miix_510_ov2680 },
> >>>>>>>> +      { "YHCU", 2, surface_go2_ov5693 },
> >>>>>>>> +      { "MSHW0070", 2, surface_book_ov5693 },
> >>>>>>>> +};
> >>>>>>>
> >>>>>>> Hmm... Usual way is to use DMI for that. I'm not sure above will =
not give us
> >>>>>>> false positive matches.
> >>>>>>
> >>>>>> I considered DMI too, no problem to switch to that if it's a bette=
r choice.
> >>>>>
> >>>>> I prefer DMI as it's a standard way to describe platform quirks in =
x86 world.
> >>>>
> >>>> Do you think the Windows driver would use DMI ?
> >>>
> >>> Linux is using DMI for quirks.
> >>>
> >>>> That seems quite
> >>>> unlikely to me, given how they would have to release a new driver bi=
nary
> >>>> for every machine. I'm pretty sure that a different mechanism is use=
d to
> >>>> identify camera integration, and I think it would make sense to foll=
ow
> >>>> the same approach. That would allow us to avoid large tables of DMI
> >>>> identifiers that would need to be constently updated, potentially ma=
king
> >>>> user experience better.
> >>>
> >>> All Surface family can be matched in a way as Apple machines [1].
> >>>
> >>> [1]: https://lkml.org/lkml/2020/4/15/1198
> >>
> >> But not all Surface machines necessarily have the same camera
> >> architecture. My point is that there seems to be identifiers reported =
in
> >> ACPI for the exact purpose of identifying the camera architecture. If =
we
> >> used DMI instead, we would have to handle each machine individually.
> >
> > With help of DMI we may narrow down the search.
> >
> > But again, we are talking about uncertainity. It may be your way (a lot=
 of
> > platforms that have different settings), or mine (only a few with more =
or less
> > standard sets of settings).
> >
> > DMI is simply standard in Linux (people usually easier can grep for qui=
rks for
> > a specific platform).
> >
> > I would rather ask Hans' opinion since he has quite an expertise with D=
MI for
> > good and bad.
>
> So generally there are 2 ways how things like this can go:
>
> 1) There is sufficient information in the ACPI table and we use data from=
 the
> ACPI tables
>
> 2) There is unsufficient info in the ACPI tables (or we don't know how to
> get / interpret the data) and we use DMI quirks
>
> Although we do often also use a combination, getting what we can from ACP=
I,
> combined with a set of defaults for what we cannot get from ACPI
> based on what reference designs use (IOW what most devices seem to have
> copy and pasted). Combined with DMI quirks for when the defaults do not
> work (which is quite often).
>
> Depending on if "not working because of wrong defaults" has bad side effe=
cts,
> another option is also to only allow the driver to load on devices which
> have the necessary info provided through a DMI match.
>
> I hope this helps.

Thanks! Yes, it sounds to me as a useful input!

-- =

With Best Regards,
Andy Shevchenko
--===============0040518803121814856==--

