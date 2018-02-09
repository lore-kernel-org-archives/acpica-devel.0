Content-Type: multipart/mixed; boundary="===============1925262744549022950=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: Re: [Devel] [PATCH v13 3/4] thinkpad_acpi: Add support for battery
 thresholds
Date: Fri, 09 Feb 2018 10:22:54 +0100
Message-ID: <CAJZ5v0hOf1DfQuoqcqb3Xjmw_Y49MGCnY19Xv6Qz88KyT5T+xQ@mail.gmail.com>
In-Reply-To: 20180208220323.cr6j2kcozekwbzo6@earth.universe
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============1925262744549022950==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 8, 2018 at 11:03 PM, Sebastian Reichel <sre(a)kernel.org> wrote:
> Hi,
>
> On Wed, Feb 07, 2018 at 03:58:44PM +0100, Ognjen Galic wrote:
>> 1) Charge start threshold
>> /sys/class/power_supply/BATN/charge_start_threshold
>>
>> Valid values are [0, 99]. A value of 0 turns off the
>> start threshold wear control.
>>
>> 2) Charge stop threshold
>> /sys/class/power_supply/BATN/charge_stop_threshold
>>
>> Valid values are [1, 100]. A value of 100 turns off
>> the stop threshold wear control. This must be
>> configured first.
>
> This is a new sysfs file, that should be documented.

Right, I should have remembered about that, sorry.

> Also this looks pretty generic. Just introduce new POWER_SUPPLY_PROP_
> entries for start/stop charging threshold and use them.

What about doing this as a follow-up?

--===============1925262744549022950==--

