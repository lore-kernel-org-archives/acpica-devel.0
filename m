Content-Type: multipart/mixed; boundary="===============6085331762232537122=="
MIME-Version: 1.0
From: Andy Shevchenko <andy.shevchenko at gmail.com>
Subject: Re: [Devel] [PATCH v10 2/4] pm: add to_power_supply macro to the API
Date: Thu, 28 Dec 2017 10:19:32 +0200
Message-ID: <CAHp75VcpuQz4n_wRJ+f-OKf4VAVVhXzKAC+FD0EE52cs+Zv22Q@mail.gmail.com>
In-Reply-To: 20171223105316.GA4352@thinkpad
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============6085331762232537122==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 23, 2017 at 12:53 PM, Ognjen Galic <smclt30p(a)gmail.com> wrote:
> This patch adds the to_power_supply macro to upcast
> a device to a power_supply struct.
>
> This is needed because the same piece of code using
> container_of is used in various other places, so we
> abstract away such low-level operations via a macro.

> ---

This is wrong! You have to use *existing* --- line below. Otherwise
all mail parsers will cut this out including your SoB tag.

>
> v9:
> * Split the pm changes from the thinkpad_acpi patch
> into its own patch
>
> v10:
> * No changes in this patch in v10
>
> Signed-off-by: Ognjen Galic <smclt30p(a)gmail.com>

Missed:

Suggested-by: Andy Shevchenko <andriy.shevchenko(a)linux.intel.com>

> ---
>  drivers/power/supply/power_supply_core.c | 2 +-
>  include/linux/power_supply.h             | 2 ++
>  2 files changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/sup=
ply/power_supply_core.c
> index 82f998a..feac7b0 100644
> --- a/drivers/power/supply/power_supply_core.c
> +++ b/drivers/power/supply/power_supply_core.c
> @@ -668,7 +668,7 @@ EXPORT_SYMBOL_GPL(power_supply_powers);
>
>  static void power_supply_dev_release(struct device *dev)
>  {
> -       struct power_supply *psy =3D container_of(dev, struct power_suppl=
y, dev);
> +       struct power_supply *psy =3D to_power_supply(dev);
>         dev_dbg(dev, "%s\n", __func__);
>         kfree(psy);
>  }
> diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
> index 79e90b3..f0139b4 100644
> --- a/include/linux/power_supply.h
> +++ b/include/linux/power_supply.h
> @@ -371,6 +371,8 @@ devm_power_supply_register_no_ws(struct device *paren=
t,
>  extern void power_supply_unregister(struct power_supply *psy);
>  extern int power_supply_powers(struct power_supply *psy, struct device *=
dev);
>
> +#define to_power_supply(device) container_of(device, struct power_supply=
, dev)
> +
>  extern void *power_supply_get_drvdata(struct power_supply *psy);
>  /* For APM emulation, think legacy userspace. */
>  extern struct class *power_supply_class;

Should fold in the changes you sent as a separate patch.

-- =

With Best Regards,
Andy Shevchenko

--===============6085331762232537122==--

