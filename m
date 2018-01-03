Content-Type: multipart/mixed; boundary="===============0574851228498935022=="
MIME-Version: 1.0
From: Andy Shevchenko <andy.shevchenko at gmail.com>
Subject: Re: [Devel] [PATCH v12 4/4] battery: Add the ThinkPad "Not Charging"
 quirk
Date: Wed, 03 Jan 2018 16:43:17 +0200
Message-ID: <CAHp75VcQ3+r0SfPYtHqv6VvSg3CeFGy27jvoa+wx7hGDGonv4w@mail.gmail.com>
In-Reply-To: 20180103115939.GA10155@thinkpad
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============0574851228498935022==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 3, 2018 at 1:59 PM, Ognjen Galic <smclt30p(a)gmail.com> wrote:
> The EC/ACPI firmware on Lenovo ThinkPads used to report a status
> of "Unknown" when the battery is between the charge start and
> charge stop thresholds. On Windows, it reports "Not Charging"
> so the quirk has been added to also report correctly.
>
> Now the "status" attribute returns "Not Charging" when the
> battery on ThinkPads is not physicaly charging.
>
> Signed-off-by: Ognjen Galic <smclt30p(a)gmail.com>

Reviewed-by: Andy Shevchenko <andy.shevchenko(a)gmail.com>

> ---
>
> Notes:
>     v7:
>     * Added all the style changes as suggested by Rafael
>     * Re-ordered the series to make this a post-implement
>     bugfix
>
>     v8:
>     * No changes in this patch in v8
>
>     v9:
>     * No changes in this patch in v9
>
>     v10:
>     * No changes in this patch in v10
>
>     v11:
>     * Fix formatting of changelog
>
>     v12:
>     * No changes in this patch in v12
>
>  drivers/acpi/battery.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>
> diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
> index 7089e31..279516e 100644
> --- a/drivers/acpi/battery.c
> +++ b/drivers/acpi/battery.c
> @@ -74,6 +74,7 @@ static async_cookie_t async_cookie;
>  static bool battery_driver_registered;
>  static int battery_bix_broken_package;
>  static int battery_notification_delay_ms;
> +static int battery_quirk_notcharging;
>  static unsigned int cache_time =3D 1000;
>  module_param(cache_time, uint, 0644);
>  MODULE_PARM_DESC(cache_time, "cache time in milliseconds");
> @@ -225,6 +226,8 @@ static int acpi_battery_get_property(struct power_sup=
ply *psy,
>                         val->intval =3D POWER_SUPPLY_STATUS_CHARGING;
>                 else if (acpi_battery_is_charged(battery))
>                         val->intval =3D POWER_SUPPLY_STATUS_FULL;
> +               else if (battery_quirk_notcharging)
> +                       val->intval =3D POWER_SUPPLY_STATUS_NOT_CHARGING;
>                 else
>                         val->intval =3D POWER_SUPPLY_STATUS_UNKNOWN;
>                 break;
> @@ -1309,6 +1312,12 @@ battery_notification_delay_quirk(const struct dmi_=
system_id *d)
>         return 0;
>  }
>
> +static int __init battery_quirk_not_charging(const struct dmi_system_id =
*d)
> +{
> +       battery_quirk_notcharging =3D 1;
> +       return 0;
> +}
> +
>  static const struct dmi_system_id bat_dmi_table[] __initconst =3D {
>         {
>                 .callback =3D battery_bix_broken_package_quirk,
> @@ -1326,6 +1335,19 @@ static const struct dmi_system_id bat_dmi_table[] =
__initconst =3D {
>                         DMI_MATCH(DMI_PRODUCT_NAME, "Aspire V5-573G"),
>                 },
>         },
> +       {
> +               /*
> +                * On Lenovo ThinkPads the BIOS specification defines
> +                * a state when the bits for charging and discharging
> +                * are both set to 0. That state is "Not Charging".
> +                */
> +               .callback =3D battery_quirk_not_charging,
> +               .ident =3D "Lenovo ThinkPad",
> +               .matches =3D {
> +                       DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> +                       DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad"),
> +               },
> +       },
>         {},
>  };
>
> --
> 2.7.4
>



-- =

With Best Regards,
Andy Shevchenko

--===============0574851228498935022==--

