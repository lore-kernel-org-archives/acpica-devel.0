Content-Type: multipart/mixed; boundary="===============8185729144399540736=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: Re: [Devel] [PATCH v13 1/4] battery: Add the battery hooking API
Date: Thu, 08 Feb 2018 16:18:55 +0100
Message-ID: <CAJZ5v0jvz2CNRdbTf=yC5g3H4tEJNRGogyradWFYzF9vgkr_Vg@mail.gmail.com>
In-Reply-To: 20180207145813.icmv6rwemyejhxbk@thinkpad
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============8185729144399540736==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 7, 2018 at 3:58 PM, Ognjen Galic <smclt30p(a)gmail.com> wrote:
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
> Signed-off-by: Ognjen Galic <smclt30p(a)gmail.com>

This is a major update and for timing reasons I'd rather not try to
rush it into 4.16-rc.

If that's not a big issue, I'll queue it up for 4.17.

Thanks,
Rafael

--===============8185729144399540736==--

