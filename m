Content-Type: multipart/mixed; boundary="===============7035983869900271298=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: Re: [Devel] [PATCH v10 1/4] battery: Add the battery hooking API
Date: Sat, 23 Dec 2017 12:59:45 +0100
Message-ID: <CAJZ5v0guiuWi=8zHX3cUZarkcxTT-VY9R3ASaCdEPAfjQPDXkA@mail.gmail.com>
In-Reply-To: 20171223105258.GA4334@thinkpad
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============7035983869900271298==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 23, 2017 at 11:52 AM, Ognjen Galic <smclt30p(a)gmail.com> wrote:
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
> ---
> v7:
> * Implemented mutual exclusion for hooking methods and battery
> callbacks
> * Fixed a BUG where errors in other modules would occur when the
> modules that depend on battery get unloaded
>
> v8:
> * Use list_for_each_safe instead of list_for_each for the module
> exit function where deletion of nodes occurs
>
> v9:
> * No changes in this patch in v9
>
> v10:
> * Fix compiler warnings in Intel's 0-day CI

You're sending new revisions too fast for me to review them. :-/

Please stop doing this for a while until you get a response from me for the=
 v10.

Thanks,
Rafael

--===============7035983869900271298==--

