Content-Type: multipart/mixed; boundary="===============3446767764301691479=="
MIME-Version: 1.0
From: Andy Shevchenko <andy.shevchenko at gmail.com>
Subject: Re: [Devel] [PATCH v11 1/5] battery: Add the battery hooking API
Date: Mon, 01 Jan 2018 11:53:16 +0200
Message-ID: <CAHp75VeQGyzf6oSGgkcuuZ6zmsr2eac5MdBFHVQVrstKFG=nzA@mail.gmail.com>
In-Reply-To: 20171231141631.GA4589@thinkpad
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============3446767764301691479==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 31, 2017 at 4:16 PM, Ognjen Galic <smclt30p(a)gmail.com> wrote:
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

Thanks for an update. Few comments below.

(Keep in mind, please, that we are not expecting new version
immediately, and Rafael might also apply this one without changes,
since they are minors)

>  #include <linux/kernel.h>
>  #include <linux/module.h>
> +#include <linux/mutex.h>
>  #include <linux/init.h>
>  #include <linux/types.h>
>  #include <linux/jiffies.h>
> @@ -30,6 +31,7 @@
>  #include <linux/dmi.h>
>  #include <linux/delay.h>
>  #include <linux/slab.h>
> +#include <linux/list.h>

Just a nit: perhaps add this before module.h ?

> +void __battery_hook_unregister(struct acpi_battery_hook *hook, int force)
> +{
> +       struct list_head *position;
> +       struct acpi_battery *battery;
> +
> +       /*
> +        * In order to remove a hook, we first need to
> +        * de-register all the batteries that are registered.
> +        */
> +
> +       if (!force)

I'm not sure force is a good name here, perhaps "locked"?
Btw, would it be boolean?

> +               mutex_lock(&hook_mutex);

> +       list_for_each(position, &acpi_battery_list) {
> +               battery =3D list_entry(position, struct acpi_battery, lis=
t);
> +               hook->remove_battery(battery->bat);
> +       }

list_for_each_entry()

> +
> +       /* Then, just remove the hook */
> +
> +       list_del(&hook->list);
> +
> +       if (!force)
> +               mutex_unlock(&hook_mutex);
> +
> +       pr_info("battery: extension unregistered: %s\n", hook->name);
> +}

> +void battery_hook_register(struct acpi_battery_hook *hook)
> +{

> +       list_for_each(position, &acpi_battery_list) {
> +               battery =3D list_entry(position, struct acpi_battery, lis=
t);

list_for_each_entry()

> +                       __battery_hook_unregister(hook, 1);
> +                       return;
> +

Perhaps you meant empty line followed by return statement.

> +               }
> +       }
> +
> +       pr_info("battery: new extension: %s\n", hook->name);

Perhaps move "battery:" to pr_fmt() ?
I have counted already 3 prints with it and see more below.

> +       list_for_each(position, &battery_hook_list) {
> +               hook_node =3D list_entry(position, struct acpi_battery_ho=
ok, list);

list_for_each_entry()

> +       list_for_each(position, &battery_hook_list) {
> +               hook =3D list_entry(position, struct acpi_battery_hook, l=
ist);

Ditto.

> +       list_for_each_safe(position, temp, &battery_hook_list) {
> +               hook =3D list_entry(position, struct acpi_battery_hook, l=
ist);

Ditto.

> --- a/drivers/acpi/battery.h
> +++ /dev/null
Apparently you didn't apply -M -C (perhaps with some non-default
threshold) to avoid such thing in the patch.

> --- /dev/null
> +++ b/include/acpi/battery.h

Ditto.

-- =

With Best Regards,
Andy Shevchenko

--===============3446767764301691479==--

