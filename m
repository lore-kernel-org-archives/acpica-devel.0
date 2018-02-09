Content-Type: multipart/mixed; boundary="===============8607361674867454936=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: Re: [Devel] [PATCH v13 3/4] thinkpad_acpi: Add support for battery
 thresholds
Date: Fri, 09 Feb 2018 11:49:40 +0100
Message-ID: <CAJZ5v0h8YW03EpqEVO8LGti9ECo7+Gmm0PdgQViidUCZ=o0AQw@mail.gmail.com>
In-Reply-To: 20180209103946.fkolldv6boml3e32@earth.universe
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============8607361674867454936==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 9, 2018 at 11:39 AM, Sebastian Reichel <sre(a)kernel.org> wrote:
> Hi,
>
> On Fri, Feb 09, 2018 at 10:22:54AM +0100, Rafael J. Wysocki wrote:
>> On Thu, Feb 8, 2018 at 11:03 PM, Sebastian Reichel <sre(a)kernel.org> wr=
ote:
>> > Hi,
>> >
>> > On Wed, Feb 07, 2018 at 03:58:44PM +0100, Ognjen Galic wrote:
>> >> 1) Charge start threshold
>> >> /sys/class/power_supply/BATN/charge_start_threshold
>> >>
>> >> Valid values are [0, 99]. A value of 0 turns off the
>> >> start threshold wear control.
>> >>
>> >> 2) Charge stop threshold
>> >> /sys/class/power_supply/BATN/charge_stop_threshold
>> >>
>> >> Valid values are [1, 100]. A value of 100 turns off
>> >> the stop threshold wear control. This must be
>> >> configured first.
>> >
>> > This is a new sysfs file, that should be documented.
>>
>> Right, I should have remembered about that, sorry.
>>
>> > Also this looks pretty generic. Just introduce new POWER_SUPPLY_PROP_
>> > entries for start/stop charging threshold and use them.
>>
>> What about doing this as a follow-up?
>
> Fine with me.

OK

Actually, I don't see any documentation whatever for ACPI battery and
AC power supply properties, so I guess that needs to be added in
general and I don't think it would be fair to ask Ognjen to do that in
order to get the extension in.

Why don't we pencil this in as work to do?

--===============8607361674867454936==--

