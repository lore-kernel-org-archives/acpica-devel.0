Content-Type: multipart/mixed; boundary="===============8998150799448949428=="
MIME-Version: 1.0
From: Andy Shevchenko <andy.shevchenko at gmail.com>
Subject: Re: [Devel] [PATCH 1/3 v8] battery: Add the battery hooking API
Date: Thu, 21 Dec 2017 16:02:21 +0200
Message-ID: <CAHp75VeZ3T3VOx_3S8D=Eg8BLHmSwGFmoWr+MVeFgKd0ZPwUtA@mail.gmail.com>
In-Reply-To: 20171221100026.GA30586@thinkpad
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============8998150799448949428==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 21, 2017 at 12:00 PM, Ognjen Galic <smclt30p(a)gmail.com> wrote:
> This is a patch that implements a generic hooking API for the
> generic ACPI battery driver.
>
> With this new generic API, drivers can expose platform specific
> behaviour via sysfs attributes in /sys/class/power_supply/BATn/
> in a generic way.
>
> A perfect example of the need for this API are Lenovo ThinkPads.
>
> Lenovo ThinkPads have a ACPI extension that allows the setting of
> start and stop charge thresholds in the EC and battery firmware
> via ACPI. The thinkpad_acpi module can use this API to expose
> sysfs attributes that it controls inside the ACPI battery driver
> sysfs tree, under /sys/class/power_supply/BATN/.
>
> The file drivers/acpi/battery.h has been moved to
> include/acpi/battery.h and the includes inside ac.c, sbs.c, and
> battery.c have been adjusted to reflect that.
>
> When drivers hooks into the API, the API calls add_battery() for
> each battery in the system that passes it a acpi_battery
> struct. Then, the drivers can use device_create_file() to create
> new sysfs attributes with that struct and identify the batteries
> for per-battery attributes.

>
> v7:
> * Implemented mutual exclusion for hooking methods and battery
> callbacks
> * Fixed a BUG where errors in other modules would occur when the
> modules that depend on battery get unloaded
> v8:
> * Use list_for_each_safe instead of list_for_each for the module
> exit function where deletion of nodes occurs

Just two workflow / style comments:

- usually we put changelog under --- line;
- when you prepare patch series you may use -v<N> to create a version
<N> automatically.

-- =

With Best Regards,
Andy Shevchenko

--===============8998150799448949428==--

