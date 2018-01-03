Content-Type: multipart/mixed; boundary="===============2550044235015221867=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rjw at rjwysocki.net>
Subject: Re: [Devel] [PATCH v11 3/5] thinkpad_acpi: Add support for battery
 thresholds
Date: Wed, 03 Jan 2018 12:24:53 +0100
Message-ID: <7475117.k4QWeGOQkJ@aspire.rjw.lan>
In-Reply-To: 20180103103455.GA17803@thinkpad
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============2550044235015221867==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wednesday, January 3, 2018 11:34:55 AM CET Ognjen Gali=C4=87 wrote:
> On Mon, Jan 01, 2018 at 12:24:39PM +0200, Andy Shevchenko wrote:
> > On Sun, Dec 31, 2017 at 4:17 PM, Ognjen Galic <smclt30p(a)gmail.com> wr=
ote:
> > > thinkpad_acpi registers two new attributes for each battery:
> > >
> > > 1) Charge start threshold
> > > /sys/class/power_supply/BATN/charge_start_threshold
> > >
> > > Valid values are [0, 99]. A value of 0 turns off the
> > > start threshold wear control.
> > >
> > > 2) Charge stop threshold
> > > /sys/class/power_supply/BATN/charge_stop_threshold
> > >
> > > Valid values are [1, 100]. A value of 100 turns off
> > > the stop threshold wear control. This must be
> > > configured first.
> > >
> > =

> > > This patch depends on the following patches:
> > >
> > > "battery: Add the battery hooking API"
> > =

> > Since this is series, no need to put above into changelog.
> > =

> > AFAICS it's not going to be backported either.
> > =

> > =

> > > +/**
> > > + * This evaluates a ACPI method call specific to the battery
> > > + * ACPI extension. The specifics are that an error is marked
> > > + * in the 32rd bit of the response, so we just check that here.
> > > + *
> > > + * Returns 0 on success
> > > + */
> > > +static int tpacpi_battery_acpi_eval(char *method, int *ret, int para=
m)
> > > +{
> > =

> > One problem and one trick you may do.
> > =

> > A problem: you return ACPI status as int. We have special type for
> > that. So, be consistent with it.
> > Looking to acpi_evalf() which is private to the module, I think you
> > need to get rid of ACPI return codes here.
> > =

> > A trick: since you are using only least significant byte of the
> > response, you can declare it as u8 *value (yeah, ret is not best name
> > here I think).
> =

> Not really. In one place I need bit #9, so that will stay a int.
> I have changed the acpi return value to acpi_status tho.

OK, you can resend the updated series when you're ready.

Thanks,
Rafael


--===============2550044235015221867==--

