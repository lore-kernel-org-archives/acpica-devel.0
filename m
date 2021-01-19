Content-Type: multipart/mixed; boundary="===============1681123291381053073=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: [Devel] Re: [PATCH v2 2/7] acpi: utils: Add function to fetch
 dependent acpi_devices
Date: Tue, 19 Jan 2021 14:15:21 +0100
Message-ID: <CAJZ5v0iU2m4Hs6APuauQ645DwbjYaB8nJFjYH0+7yQnR-FPZBQ@mail.gmail.com>
In-Reply-To: b381b48e-1bf2-f3e7-10a6-e51cd261f43c@gmail.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============1681123291381053073==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 18, 2021 at 9:51 PM Daniel Scally <djrscally(a)gmail.com> wrote:
>
> On 18/01/2021 16:14, Rafael J. Wysocki wrote:
> > On Mon, Jan 18, 2021 at 1:37 AM Daniel Scally <djrscally(a)gmail.com> w=
rote:
> >> In some ACPI tables we encounter, devices use the _DEP method to assert
> >> a dependence on other ACPI devices as opposed to the OpRegions that the
> >> specification intends. We need to be able to find those devices "from"
> >> the dependee, so add a function to parse all ACPI Devices and check if
> >> the include the handle of the dependee device in their _DEP buffer.
> > What exactly do you need this for?
>
> So, in our DSDT we have devices with _HID INT3472, plus sensors which
> refer to those INT3472's in their _DEP method. The driver binds to the
> INT3472 device, we need to find the sensors dependent on them.
>

Well, this is an interesting concept. :-)

Why does _DEP need to be used for that?  Isn't there any other way to
look up the dependent sensors?

>
> > Would it be practical to look up the suppliers in acpi_dep_list instead?
> >
> > Note that supplier drivers may remove entries from there, but does
> > that matter for your use case?
>
> Ah - that may work, yes. Thank you, let me test that.

Even if that doesn't work right away, but it can be made work, I would
very much prefer that to the driver parsing _DEP for every device in
the namespace by itself.
--===============1681123291381053073==--

