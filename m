Content-Type: multipart/mixed; boundary="===============1006996658010243243=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: Re: [Devel] [PATCH v2] ACPI: surface3_power: MSHW0011 rev-eng
 implementation
Date: Thu, 06 Sep 2018 14:43:32 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E3B94F5A63@ORSMSX110.amr.corp.intel.com>
In-Reply-To: CAO-hwJ+U+e8a70LskxaSLV_hjWejpqjBWC788mEOOcUg=oxBCw@mail.gmail.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============1006996658010243243==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



> -----Original Message-----
> From: Benjamin Tissoires [mailto:benjamin.tissoires(a)redhat.com]
> Sent: Friday, August 31, 2018 7:55 AM
> To: Andy Shevchenko <andy.shevchenko(a)gmail.com>
> Cc: Hans de Goede <hdegoede(a)redhat.com>; Bastien Nocera
> <hadess(a)hadess.net>; stephenjust(a)gmail.com; Sebastian Reichel
> <sre(a)kernel.org>; Wysocki, Rafael J <rafael.j.wysocki(a)intel.com>;
> lenb(a)kernel.org; Moore, Robert <robert.moore(a)intel.com>;
> lv.zheng(a)intel.com; mika.westerberg(a)linux.intel.com; linux-
> acpi(a)vger.kernel.org; devel(a)acpica.org; linux-pm(a)vger.kernel.org; l=
kml
> <linux-kernel(a)vger.kernel.org>
> Subject: Re: [PATCH v2] ACPI: surface3_power: MSHW0011 rev-eng
> implementation
> =

> Hi Andy,
> =

> I am resurrecting this thread now that ACPICA seemed to finally have
> fixed the bug that prevent the driver to work.
> The patch I submitted was reverted shortly after, which lead me to
> ignore this review until ACPICA was fixed. It took a lot of effort from
> Hans to have a fix accepted, so now we can hope to upstream this driver.
> =

[Moore, Robert] =


The worst part of all this is that the ACPI specification is so ambiguous i=
n this area, that we were forced to *guess* at certain elements of the impl=
ementation.

So, if anyone knows of any ASL/machines that use the serial bus stuff, plea=
se forward the code to me.

This includes:
    GenericSerialBus
    SMBus
    IPMI

And maybe:
    GeneralPurposeIo

For completeness.



> On Fri, Jun 30, 2017 at 6:37 PM Andy Shevchenko
> <andy.shevchenko(a)gmail.com> wrote:
> >
> > On Fri, Jun 30, 2017 at 6:57 PM, Benjamin Tissoires
> > <benjamin.tissoires(a)redhat.com> wrote:
> > > On Jun 29 2017 or thereabouts, Andy Shevchenko wrote:
> > >> On Thu, Jun 29, 2017 at 3:10 PM, Benjamin Tissoires
> > >> <benjamin.tissoires(a)redhat.com> wrote:
> >
> > >> What devices (laptops, tablets) have it?
> > >> Surface 3. What else?
> > >
> > > So far, Surface 3 only. It's a Microsoft PNPId, so I guess they
> > > control which device has it. Maybe the model after the Surface 3
> > > (reduced
> > > platform) will have such chip, but for now, it's unknown.
> >
> > Please, extend introduction in commit message to state above.
> =

> OK. On this note, I have been mentioned that the Surface Pro 2017 uses a
> similar mechanism as in it's also using an operation region handler, but
> this time over UART, not I2C :)
> =

> >
> > >> > I couldn't manage to get the IRQ correctly triggered, so I am
> > >> > using a good old polling thread to check for changes.
> > >>
> > >> It might be
> >
> > It seems I didn't finished the sentence here.
> >
> > I though it might be actually ACPI event, GPE or direct IRQ (when GPIO
> > chip should not disable it, though if it's the case it likely a BIOS
> > bug for this hardware).
> =

> If you don't mind, I'd rather have the polling version that seems to be
> working first. I haven't touched the logs I had from Windows since last
> year, so I am a little bit rusty on debugging this.
> FWIW, /proc/interrupts doesn't change a bit when I unplug/replug the
> power cable.
> =

> My guess is that the Windows driver initializes the chip in a different
> way and this enables the cable detection.
> =

> >
> > >> > +       help
> > >> > +         Select this option to enable support for ACPI operation
> > >> > +         region of the Surface 3 battery platform driver.
> > >>
> > >> > +/*
> > >> > + * Supports for the power IC on the Surface 3 tablet.
> > >>
> > >> Shouldn't it go to drivers/acpi/pmic folder ?
> > >
> > > Already answered later in the thread, so yes, I'll move it there.
> >
> > Actually Hans did a good point, so, feel free to use
> drivers/platform/x86.
> =

> Roger that!
> =

> >
> > >> And did you check if it have actual chip IP vendor name and model?
> > >> Most likely it's a TI (based?) solution.
> > >
> > > As mentioned, I have strictly no idea. I can not crack open the
> > > Surface
> > > 3 without breaking the warranty (I already had to return it once
> > > because the disk crashed).
> >
> > We have one indeed cracked (screen is broken for good :-) ), so, I
> > would check what I can find there.
> >
> > > And I do not find anything brand-related under Windows either:
> > > - it's called "Surface Platform Power Driver"
> > > - and the driver is provided by Microsoft
> >
> > Fair enough.
> >
> > >> > +static int mshw0011_bix(struct mshw0011_data *cdata, struct bix
> > >> > +*bix) {
> > >>
> > >> > +       memcpy(bix->serial, buf + 7, 3);
> > >> > +       memcpy(bix->serial + 3, buf, 6);
> > >> > +       bix->serial[9] =3D '\0';
> > >>
> > >> snprintf()?
> > >
> > > probably :)
> >
> > I would do this until we have an evidence that it contains
> > non-printable symbols (or, in case you want to fix ahead, make the
> > buffer 4 times bigger and use %*pE)
> =

> I can't really make the buffer 4 time bigger. The buffer is then used by
> the DSDT table to report the _BIX status, so the length of 10 is
> mandatory.
> It doesn't seem to hurt, and worse case, we will just strip the serial,
> not a big deal IMO.
> =

> >
> > >> > +       memcpy(bix->OEM, buf, 3);
> > >> > +       bix->OEM[4] =3D '\0';
> > >>
> > >> snprintf() ?
> >
> > Ditto.
> >
> > >> > +       snprintf(prefix, ARRAY_SIZE(prefix), "%s: ", bat0->name);
> > >>
> > >> > +       prefix[127] =3D '\0';
> > >>
> > >> Why?
> > >
> > > Just me being paranoid in case the code doesn't follow the spec...
> > > Yeah, I'll remove it.
> >
> > snprintf() despite n in the name takes care of terminating NUL.
> >
> > >> > +static int mshw0011_probe(struct i2c_client *client,
> > >> > +                         const struct i2c_device_id *id) {
> > >>
> > >> > +       data->notify_version =3D version =3D=3D MSHW0011_EV_2_5;
> > >>
> > >> 0x1ff as version sounds hmm suspicious.
> > >
> > > So after a little bit of digging, it appears those values were taken
> > > from the DSDT:
> > > https://bugzilla.kernel.org/attachment.cgi?id=3D187171 line 11694.
> > >
> > > It appears 0x3F is EV 2.1 and before, and 0x1FF is EV 2.5 and above.
> > > The returned value is not a version of the chip, just a flag to know
> > > which path we are taking in the DSM.
> > >
> > > The name is probably not the best.
> >
> > 63 and 511 looks too suspicious to be a version. Rather block size, a
> > mask or alike.
> =

> I replaced the 'version' by 'mask' in v3. It doesn't hurt to do so.
> =

> >
> > >> > +static const struct i2c_device_id mshw0011_id[] =3D {
> > >> > +       { }
> > >> > +};
> > >> > +MODULE_DEVICE_TABLE(i2c, mshw0011_id);
> > >>
> > >> ->probe_new(), please.
> > >
> > > Correct
> > >
> > >>
> > >> If I2C framework is _still_ broken we need to fix that part.
> > >
> > > I haven't check, so let's see for v3.
> >
> > Cc: Wolfram for v3 and ask him directly. Last time I checked it looks
> > like I2C core doesn't care about ACPI when ->probe_new() is used.
> =

> Looks like things are working fine now. So I can just submit the driver
> without bothering the I2C core team :)
> =

> Cheers,
> Benjamin

--===============1006996658010243243==--

