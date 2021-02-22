Content-Type: multipart/mixed; boundary="===============8400819431270530194=="
MIME-Version: 1.0
From: Andy Shevchenko <andy.shevchenko at gmail.com>
Subject: [Devel] Re: [PATCH v3 4/6] gpiolib: acpi: Export acpi_get_gpiod()
Date: Mon, 22 Feb 2021 15:54:09 +0200
Message-ID: <CAHp75VfQpMJt8t_fOyOO0gPL686egCTnfh1=DZRKTg84Omj8=Q@mail.gmail.com>
In-Reply-To: 20210222130735.1313443-5-djrscally@gmail.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============8400819431270530194==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 22, 2021 at 3:13 PM Daniel Scally <djrscally(a)gmail.com> wrote:
>
> I need to be able to translate GPIO resources in an ACPI device's _CRS

I -> we

> into GPIO descriptor array. Those are represented in _CRS as a pathname
> to a GPIO device plus the pin's index number: this function is perfect

Which one? "the acpi_...() function"

> for that purpose.
>
> As it's currently only used internally within the GPIO layer, provide and
> export a wrapper function that additionally holds a reference to the GPIO
> device.

Reviewed-by: Andy Shevchenko <andy.shevchenko(a)gmail.com>
after addressing above and beyond :-)

>
> Signed-off-by: Daniel Scally <djrscally(a)gmail.com>
> ---
> Changes in v3:
>
>         - Having realised that it wasn't taking a reference to the GPIO d=
evice,
>           I decided the best thing to do was leave the existing function =
as-is
>           (apart from renaming) and provide a wrapper that simply passes
>           through to the original and takes a reference before returning =
the
>           struct gpio_desc
>
>           Because of the change to that functionality, I dropped the R-b'=
s from
>           the last version.
>
>  drivers/gpio/gpiolib-acpi.c   | 36 +++++++++++++++++++++++++++++++----
>  include/linux/gpio/consumer.h |  7 +++++++
>  2 files changed, 39 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
> index e4d728fda982..0cc7cc327757 100644
> --- a/drivers/gpio/gpiolib-acpi.c
> +++ b/drivers/gpio/gpiolib-acpi.c
> @@ -102,7 +102,8 @@ static int acpi_gpiochip_find(struct gpio_chip *gc, v=
oid *data)
>  }
>
>  /**
> - * acpi_get_gpiod() - Translate ACPI GPIO pin to GPIO descriptor usable =
with GPIO API
> + * __acpi_get_gpiod() - Translate ACPI GPIO pin to GPIO descriptor usabl=
e with

Can we rename it better, i.e. w/o __, like "acpi_gpio_pin_to_gpiod()" or so?

> + *                     GPIO API
>   * @path:      ACPI GPIO controller full path name, (e.g. "\\_SB.GPO1")
>   * @pin:       ACPI GPIO pin number (0-based, controller-relative)
>   *
> @@ -111,7 +112,7 @@ static int acpi_gpiochip_find(struct gpio_chip *gc, v=
oid *data)
>   * controller does not have GPIO chip registered at the moment. This is =
to
>   * support probe deferral.
>   */
> -static struct gpio_desc *acpi_get_gpiod(char *path, int pin)
> +static struct gpio_desc *__acpi_get_gpiod(char *path, int pin)
>  {
>         struct gpio_chip *chip;
>         acpi_handle handle;
> @@ -128,6 +129,33 @@ static struct gpio_desc *acpi_get_gpiod(char *path, =
int pin)
>         return gpiochip_get_desc(chip, pin);
>  }
>
> +/**
> + * acpi_get_gpiod() - Translate ACPI GPIO pin to GPIO descriptor usable =
with
> + *                   GPIO API, and hold a refcount to the GPIO device.
> + * @path:      ACPI GPIO controller full path name, (e.g. "\\_SB.GPO1")
> + * @pin:       ACPI GPIO pin number (0-based, controller-relative)
> + * @label:     Label to pass to gpiod_request()
> + *
> + * This function is a simple pass-through to __acpi_get_gpiod(), except =
that as
> + * it is intended for use outside of the GPIO layer (in a similar fashio=
n to
> + * gpiod_get_index() for example) it also holds a reference to the GPIO =
device.
> + */
> +struct gpio_desc *acpi_get_gpiod(char *path, int pin, char *label)

Name better to reflect the action, perhaps
"acpi_gpio_get_and_request_desc()" or so.

> +{

> +       struct gpio_desc *gpio =3D __acpi_get_gpiod(path, pin);

Please, split it, so the assignment goes...

> +       int ret;

...here.

> +       if (IS_ERR(gpio))
> +               return gpio;
> +
> +       ret =3D gpiod_request(gpio, label);
> +       if (ret)
> +               return ERR_PTR(ret);
> +
> +       return gpio;
> +}
> +EXPORT_SYMBOL_GPL(acpi_get_gpiod);
> +
>  static irqreturn_t acpi_gpio_irq_handler(int irq, void *data)
>  {
>         struct acpi_gpio_event *event =3D data;
> @@ -689,8 +717,8 @@ static int acpi_populate_gpio_lookup(struct acpi_reso=
urce *ares, void *data)
>                 if (pin_index >=3D agpio->pin_table_length)
>                         return 1;
>
> -               lookup->desc =3D acpi_get_gpiod(agpio->resource_source.st=
ring_ptr,
> -                                             agpio->pin_table[pin_index]=
);
> +               lookup->desc =3D __acpi_get_gpiod(agpio->resource_source.=
string_ptr,
> +                                               agpio->pin_table[pin_inde=
x]);
>                 lookup->info.pin_config =3D agpio->pin_config;
>                 lookup->info.debounce =3D agpio->debounce_timeout;
>                 lookup->info.gpioint =3D gpioint;
> diff --git a/include/linux/gpio/consumer.h b/include/linux/gpio/consumer.h
> index ef49307611d2..6eee751f44dd 100644
> --- a/include/linux/gpio/consumer.h
> +++ b/include/linux/gpio/consumer.h
> @@ -690,6 +690,8 @@ int devm_acpi_dev_add_driver_gpios(struct device *dev,
>                                    const struct acpi_gpio_mapping *gpios);
>  void devm_acpi_dev_remove_driver_gpios(struct device *dev);
>
> +struct gpio_desc *acpi_get_gpiod(char *path, int pin, char *label);
> +
>  #else  /* CONFIG_GPIOLIB && CONFIG_ACPI */
>
>  struct acpi_device;
> @@ -708,6 +710,11 @@ static inline int devm_acpi_dev_add_driver_gpios(str=
uct device *dev,
>  }
>  static inline void devm_acpi_dev_remove_driver_gpios(struct device *dev)=
 {}
>
> +struct gpio_desc *acpi_get_gpiod(char *path, int pin, char *label)
> +{
> +       return NULL;
> +}
> +
>  #endif /* CONFIG_GPIOLIB && CONFIG_ACPI */
>
>
> --
> 2.25.1
>


-- =

With Best Regards,
Andy Shevchenko
--===============8400819431270530194==--

