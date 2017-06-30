Content-Type: multipart/mixed; boundary="===============5639366553435642090=="
MIME-Version: 1.0
From: Andy Shevchenko <andy.shevchenko at gmail.com>
Subject: Re: [Devel] [PATCH v2] ACPI: surface3_power: MSHW0011 rev-eng
 implementation
Date: Fri, 30 Jun 2017 20:40:15 +0300
Message-ID: <CAHp75VfWmAvaASLZOhmMBW7v+E10_7xvD11OSMKdQ0HbY_yHVg@mail.gmail.com>
In-Reply-To: 7d8201bf-b05e-6235-7eb0-54b1a393f99f@redhat.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============5639366553435642090==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 30, 2017 at 8:37 PM, Hans de Goede <hdegoede(a)redhat.com> wrot=
e:
> On 30-06-17 18:37, Andy Shevchenko wrote:
>> On Fri, Jun 30, 2017 at 6:57 PM, Benjamin Tissoires

> ACPI i2c drivers still need an empty i2c_device_id table I've
> fixing this on my TODO but it has been buried in other stuff.
>
> Benjamin if (not saying you should, but if) you want to take a look at
> this, fixing the need for the empty table for ACPI devices should be
> easy. The problem is these lines in drivers/i2c/i2c-core.c:
> i2c_device_probe():
>
>         /*
>          * An I2C ID table is not mandatory, if and only if, a suitable
> Device
>          * Tree match table entry is supplied for the probing device.
>          */
>         if (!driver->id_table &&
>             !i2c_of_match_device(dev->driver->of_match_table, client))
>                 return -ENODEV;
>
> Which needs to be extended to also check for an ACPI match AFAIK
> you can NOT just replace this with i2c_device_match because that would
> break manually binding a driver through sysfs.

I have a stashed change for that, just have no time to look closer.

-- =

With Best Regards,
Andy Shevchenko

--===============5639366553435642090==--

