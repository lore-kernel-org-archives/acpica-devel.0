Content-Type: multipart/mixed; boundary="===============1602649827718542646=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: [Devel] Re: [PATCH v2 2/7] acpi: utils: Add function to fetch
 dependent acpi_devices
Date: Thu, 21 Jan 2021 12:58:43 +0100
Message-ID: <CAJZ5v0gg5oXG3yOO9iDvPKSsadYrFojW6JcKfZcQbFFpO78zAQ@mail.gmail.com>
In-Reply-To: e2d7e5e9-920f-7227-76a6-b166e30e11e5@gmail.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============1602649827718542646==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 21, 2021 at 10:47 AM Daniel Scally <djrscally(a)gmail.com> wrot=
e:
>
> Hi Rafael
>
> On 19/01/2021 13:15, Rafael J. Wysocki wrote:
> > On Mon, Jan 18, 2021 at 9:51 PM Daniel Scally <djrscally(a)gmail.com> w=
rote:
> >> On 18/01/2021 16:14, Rafael J. Wysocki wrote:
> >>> On Mon, Jan 18, 2021 at 1:37 AM Daniel Scally <djrscally(a)gmail.com>=
 wrote:
> >>>> In some ACPI tables we encounter, devices use the _DEP method to ass=
ert
> >>>> a dependence on other ACPI devices as opposed to the OpRegions that =
the
> >>>> specification intends. We need to be able to find those devices "fro=
m"
> >>>> the dependee, so add a function to parse all ACPI Devices and check =
if
> >>>> the include the handle of the dependee device in their _DEP buffer.
> >>> What exactly do you need this for?
> >> So, in our DSDT we have devices with _HID INT3472, plus sensors which
> >> refer to those INT3472's in their _DEP method. The driver binds to the
> >> INT3472 device, we need to find the sensors dependent on them.
> >>
> > Well, this is an interesting concept. :-)
> >
> > Why does _DEP need to be used for that?  Isn't there any other way to
> > look up the dependent sensors?
> >
> >>> Would it be practical to look up the suppliers in acpi_dep_list inste=
ad?
> >>>
> >>> Note that supplier drivers may remove entries from there, but does
> >>> that matter for your use case?
> >> Ah - that may work, yes. Thank you, let me test that.
> > Even if that doesn't work right away, but it can be made work, I would
> > very much prefer that to the driver parsing _DEP for every device in
> > the namespace by itself.
>
>
> This does work; do you prefer it in scan.c, or in utils.c (in which case
> with acpi_dep_list declared as external var in internal.h)?

Let's put it in scan.c for now, because there is the lock protecting
the list in there too.

How do you want to implement this?  Something like "walk the list and
run a callback for the matching entries" or do you have something else
in mind?
--===============1602649827718542646==--

