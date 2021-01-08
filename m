Content-Type: multipart/mixed; boundary="===============2575843521921247951=="
MIME-Version: 1.0
From: Andy Shevchenko <andy.shevchenko at gmail.com>
Subject: [Devel] Re: [PATCH 18/18] ipu3: Add driver for dummy INT3472 ACPI
 device
Date: Fri, 08 Jan 2021 12:17:01 +0000
Message-ID: <CAHp75VeYOqJt9iKaGPA4=dkb2kYUbqUV4PGTn8uSsnUt_kSGSw@mail.gmail.com>
In-Reply-To: 778f23fc-b99c-33a2-642d-ca0e47fd4ed5@gmail.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============2575843521921247951==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 8, 2021 at 1:56 AM Daniel Scally <djrscally(a)gmail.com> wrote:
> On 30/11/2020 20:07, Andy Shevchenko wrote:
> > On Mon, Nov 30, 2020 at 01:31:29PM +0000, Daniel Scally wrote:

...

> > It's solely Windows driver design...
> > Luckily I found some information and can clarify above table:
> >
> > 0x00 Reset
> > 0x01 Power down
> > 0x0b Power enable
> > 0x0c Clock enable
> > 0x0d LED (active high)
> >
> > The above text perhaps should go somewhere under Documentation.
>
> Coming back to this; there's a bit of an anomaly with the 0x01 Power
> Down pin for at least one platform.  As listed above, the OV2680 on one
> of my platforms has 3 GPIOs defined, and the table above gives them as
> type Reset, Power down and Clock enable. I'd assumed from this table
> that "power down" meant a powerdown GPIO (I.E. the one usually called
> PWDNB in Omnivision datasheets and "powerdown" in drivers), but the
> datasheet for the OV2680 doesn't list a separate reset and powerdown
> pin, but rather a single pin that performs both functions.

All of them are GPIOs, the question here is how they are actually
connected on PCB level and I have no answer to that. You have to find
schematics somewhere.

> Am I wrong to treat that as something that ought to be mapped as a
> powerdown GPIO to the sensors? Or do you know of any other way to
> reconcile that discrepancy?

The GPIOs can go directly to the sensors or be a control pin for
separate discrete power gates.
So, we can do one of the following:
 a) present PD GPIO as fixed regulator;
 b) present PD & Reset GPIOs as regulator;
 c) provide them as is to the sensor and sensor driver must do what it
considers right.

Since we don't have schematics (yet?) and we have plenty of variations
of sensors, I would go to c) and update the driver of the affected
sensor as needed. Because even if you have separate discrete PD for
one sensor on one platform there is no guarantee that it will be the
same on another. Providing a "virtual" PD in a sensor that doesn't
support it is the best choice I think. Let's hear what Sakari and
other experienced camera sensor developers say.

My vision is purely based on electrical engineering background,
experience with existing (not exactly camera) sensor drivers and
generic cases.

> Failing that; the only way I can think to handle this is to register
> proxy GPIO pins assigned to the sensors as you suggested previously, and
> have them toggle the GPIO's assigned to the INT3472 based on platform
> specific mapping data (I.E. we register a pin called "reset", which on
> most platforms just toggles the 0x00 pin, but on this specific platform
> would drive both 0x00 and 0x01 together. We're already heading that way
> for the regulator consumer supplies so it's sort of nothing new, but I'd
> still rather not if it can be avoided.


-- =

With Best Regards,
Andy Shevchenko
--===============2575843521921247951==--

