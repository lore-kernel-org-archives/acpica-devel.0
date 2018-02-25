Content-Type: multipart/mixed; boundary="===============7510438871400957354=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: Re: [Devel] [PATCH v13 3/4] thinkpad_acpi: Add support for battery
 thresholds
Date: Sun, 25 Feb 2018 10:20:10 +0100
Message-ID: <CAJZ5v0hw-wpMRuiY72PznNXvhuOd8GrscG=Be2pGEU_EP0qYYg@mail.gmail.com>
In-Reply-To: 20180224103140.lyisawzxxkboez42@thinkpad
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============7510438871400957354==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 24, 2018 at 11:31 AM, Ognjen Gali=C4=87 <smclt30p(a)gmail.com> =
wrote:
> On Sat, Feb 24, 2018 at 10:07:20AM +0100, Rafael J. Wysocki wrote:
>> On Fri, Feb 23, 2018 at 6:21 PM, Andy Shevchenko
>> <andy.shevchenko(a)gmail.com> wrote:
>> > On Sat, Feb 10, 2018 at 10:48 AM, Ognjen Gali=C4=87 <smclt30p(a)gmail.=
com> wrote:
>> >
>> >> Do you guys want me to send in another revision of the patch with some
>> >> documentation on the sysfs API?
>> >
>> > I noticed I didn't apply it because of some pending changes discussed,
>> > perhaps this one above.
>> >
>> > So, definitely please send a new version which addresses comments.
>>
>> No, it actually has been applied already.
>
> So it has been queued up for 4.17?

Yes, it has.

> If it has, that is awesome! Thanks!

No biggie.

That said, I would like you to send a follow-up patch moving the
definitions of the charge_start_threshold and charge_stop_threshold
attributes to the power supply core as requested by Sebastian and
documenting them.

Of course, it still needs to be possible to add/remove them on demand
after registering the power supply to cover the use case at hand
AFAICS.

Thanks,
Rafael

--===============7510438871400957354==--

