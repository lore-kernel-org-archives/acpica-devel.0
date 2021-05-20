Content-Type: multipart/mixed; boundary="===============2511807882434444954=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: [Devel] Re: [PATCH v4 1/8] ACPI: scan: Extend
 acpi_walk_dep_device_list()
Date: Thu, 20 May 2021 20:22:37 +0200
Message-ID: <CAJZ5v0hy=AmbBK72w+ZsVZ4x0haQerTxeDnBXKOU5bOosUHgPA@mail.gmail.com>
In-Reply-To: 20210520140928.3252671-2-djrscally@gmail.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============2511807882434444954==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, May 20, 2021 at 4:11 PM Daniel Scally <djrscally(a)gmail.com> wrote:
>
> The acpi_walk_dep_device_list() is not as generalisable as its name
> implies, serving only to decrement the dependency count for each
> dependent device of the input. Extend the function to instead accept
> a callback which can be applied to all the dependencies in acpi_dep_list.
> Replace all existing calls to the function with calls to a wrapper, passi=
ng
> a callback that applies the same dependency reduction.
>
> Signed-off-by: Daniel Scally <djrscally(a)gmail.com>

LGTM, but I will have changes depending on it.

If that's fine by Hans, I'll take this one and expose it in a git
branch that won't be rebased.

> ---
> changes since v3:
>
>         - Most of the functions got renamed
>         - acpi_dev_get_dependent_dev() was altered to take a struct acpi_=
device
>         This had some repurcussions in the other files, mostly switching =
from
>         ACPI_HANDLE() to ACPI_COMPANION().
>         - acpi_walk_dep_device_list() was altered to check the return val=
ue of
>         the callback on each iteration of the loop, to allow for error ha=
ndling
>         of the callbacks or breaking the loop early to save time. Andy, W=
olfram,
>         I thought this change was significant enough to drop your R-b and=
 Ack.
>
>  drivers/acpi/ec.c                             |  2 +-
>  drivers/acpi/pmic/intel_pmic_chtdc_ti.c       |  2 +-
>  drivers/acpi/scan.c                           | 69 ++++++++++++++-----
>  drivers/gpio/gpiolib-acpi.c                   | 10 +--
>  drivers/i2c/i2c-core-acpi.c                   |  8 +--
>  drivers/platform/surface/aggregator/core.c    |  6 +-
>  drivers/platform/surface/surface3_power.c     | 22 +++---
>  .../platform/surface/surface_acpi_notify.c    |  7 +-
>  include/acpi/acpi_bus.h                       |  7 ++
>  include/linux/acpi.h                          |  4 +-
>  10 files changed, 90 insertions(+), 47 deletions(-)
>
> diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
> index 13565629ce0a..3f7680a007a3 100644
> --- a/drivers/acpi/ec.c
> +++ b/drivers/acpi/ec.c
> @@ -1627,7 +1627,7 @@ static int acpi_ec_add(struct acpi_device *device)
>         WARN(!ret, "Could not request EC cmd io port 0x%lx", ec->command_=
addr);
>
>         /* Reprobe devices depending on the EC */
> -       acpi_walk_dep_device_list(ec->handle);
> +       acpi_dev_clear_dependencies(device);
>
>         acpi_handle_debug(ec->handle, "enumerated.\n");
>         return 0;
> diff --git a/drivers/acpi/pmic/intel_pmic_chtdc_ti.c b/drivers/acpi/pmic/=
intel_pmic_chtdc_ti.c
> index a5101b07611a..fef7831d0d63 100644
> --- a/drivers/acpi/pmic/intel_pmic_chtdc_ti.c
> +++ b/drivers/acpi/pmic/intel_pmic_chtdc_ti.c
> @@ -117,7 +117,7 @@ static int chtdc_ti_pmic_opregion_probe(struct platfo=
rm_device *pdev)
>                 return err;
>
>         /* Re-enumerate devices depending on PMIC */
> -       acpi_walk_dep_device_list(ACPI_HANDLE(pdev->dev.parent));
> +       acpi_dev_clear_dependencies(ACPI_COMPANION(pdev->dev.parent));
>         return 0;
>  }
>
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index 453eff8ec8c3..195635c3462b 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -47,12 +47,6 @@ static DEFINE_MUTEX(acpi_hp_context_lock);
>   */
>  static u64 spcr_uart_addr;
>
> -struct acpi_dep_data {
> -       struct list_head node;
> -       acpi_handle supplier;
> -       acpi_handle consumer;
> -};
> -
>  void acpi_scan_lock_acquire(void)
>  {
>         mutex_lock(&acpi_scan_lock);
> @@ -2111,30 +2105,69 @@ static void acpi_bus_attach(struct acpi_device *d=
evice, bool first_pass)
>                 device->handler->hotplug.notify_online(device);
>  }
>
> -void acpi_walk_dep_device_list(acpi_handle handle)
> +static int acpi_scan_clear_dep(struct acpi_dep_data *dep, void *data)
>  {
> -       struct acpi_dep_data *dep, *tmp;
>         struct acpi_device *adev;
>
> +       acpi_bus_get_device(dep->consumer, &adev);
> +
> +       if (adev) {
> +               adev->dep_unmet--;
> +               if (!adev->dep_unmet)
> +                       acpi_bus_attach(adev, true);
> +       }
> +
> +       list_del(&dep->node);
> +       kfree(dep);
> +
> +       return 0;
> +}
> +
> +/**
> + * acpi_walk_dep_device_list - Apply a callback to every entry in acpi_d=
ep_list
> + * @handle:    The ACPI handle of the supplier device
> + * @callback:  Pointer to the callback function to apply
> + * @data:      Pointer to some data to pass to the callback
> + *
> + * The return value of the callback determines this function's behaviour=
. If 0
> + * is returned we continue to iterate over acpi_dep_list. If a positive =
value
> + * is returned then the loop is broken but this function returns 0. If a
> + * negative value is returned by the callback then the loop is broken an=
d that
> + * value is returned as the final error.
> + */
> +int acpi_walk_dep_device_list(acpi_handle handle,
> +                             int (*callback)(struct acpi_dep_data *, voi=
d *),
> +                             void *data)
> +{
> +       struct acpi_dep_data *dep, *tmp;
> +       int ret;
> +
>         mutex_lock(&acpi_dep_list_lock);
>         list_for_each_entry_safe(dep, tmp, &acpi_dep_list, node) {
>                 if (dep->supplier =3D=3D handle) {
> -                       acpi_bus_get_device(dep->consumer, &adev);
> -
> -                       if (adev) {
> -                               adev->dep_unmet--;
> -                               if (!adev->dep_unmet)
> -                                       acpi_bus_attach(adev, true);
> -                       }
> -
> -                       list_del(&dep->node);
> -                       kfree(dep);
> +                       ret =3D callback(dep, data);
> +                       if (ret)
> +                               break;
>                 }
>         }
>         mutex_unlock(&acpi_dep_list_lock);
> +
> +       return ret > 0 ? 0 : ret;
>  }
>  EXPORT_SYMBOL_GPL(acpi_walk_dep_device_list);
>
> +/**
> + * acpi_dev_clear_dependencies - Inform consumers that the device is now=
 active
> + * @supplier: Pointer to the supplier &struct acpi_device
> + *
> + * Clear dependencies on the given device.
> + */
> +void acpi_dev_clear_dependencies(struct acpi_device *supplier)
> +{
> +       acpi_walk_dep_device_list(supplier->handle, acpi_scan_clear_dep, =
NULL);
> +}
> +EXPORT_SYMBOL_GPL(acpi_dev_clear_dependencies);
> +
>  /**
>   * acpi_bus_scan - Add ACPI device node objects in a given namespace sco=
pe.
>   * @handle: Root of the namespace scope to scan.
> diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
> index 3ef22a3c104d..5b4111e4be3f 100644
> --- a/drivers/gpio/gpiolib-acpi.c
> +++ b/drivers/gpio/gpiolib-acpi.c
> @@ -1233,14 +1233,14 @@ static void acpi_gpiochip_scan_gpios(struct acpi_=
gpio_chip *achip)
>  void acpi_gpiochip_add(struct gpio_chip *chip)
>  {
>         struct acpi_gpio_chip *acpi_gpio;
> -       acpi_handle handle;
> +       struct acpi_device *adev;
>         acpi_status status;
>
>         if (!chip || !chip->parent)
>                 return;
>
> -       handle =3D ACPI_HANDLE(chip->parent);
> -       if (!handle)
> +       adev =3D ACPI_COMPANION(chip->parent);
> +       if (!adev)
>                 return;
>
>         acpi_gpio =3D kzalloc(sizeof(*acpi_gpio), GFP_KERNEL);
> @@ -1254,7 +1254,7 @@ void acpi_gpiochip_add(struct gpio_chip *chip)
>         INIT_LIST_HEAD(&acpi_gpio->events);
>         INIT_LIST_HEAD(&acpi_gpio->deferred_req_irqs_list_entry);
>
> -       status =3D acpi_attach_data(handle, acpi_gpio_chip_dh, acpi_gpio);
> +       status =3D acpi_attach_data(adev->handle, acpi_gpio_chip_dh, acpi=
_gpio);
>         if (ACPI_FAILURE(status)) {
>                 dev_err(chip->parent, "Failed to attach ACPI GPIO chip\n"=
);
>                 kfree(acpi_gpio);
> @@ -1263,7 +1263,7 @@ void acpi_gpiochip_add(struct gpio_chip *chip)
>
>         acpi_gpiochip_request_regions(acpi_gpio);
>         acpi_gpiochip_scan_gpios(acpi_gpio);
> -       acpi_walk_dep_device_list(handle);
> +       acpi_dev_clear_dependencies(adev);
>  }
>
>  void acpi_gpiochip_remove(struct gpio_chip *chip)
> diff --git a/drivers/i2c/i2c-core-acpi.c b/drivers/i2c/i2c-core-acpi.c
> index 8ceaa88dd78f..6f0aa0ed3241 100644
> --- a/drivers/i2c/i2c-core-acpi.c
> +++ b/drivers/i2c/i2c-core-acpi.c
> @@ -259,8 +259,8 @@ static acpi_status i2c_acpi_add_device(acpi_handle ha=
ndle, u32 level,
>   */
>  void i2c_acpi_register_devices(struct i2c_adapter *adap)
>  {
> +       struct acpi_device *adev;
>         acpi_status status;
> -       acpi_handle handle;
>
>         if (!has_acpi_companion(&adap->dev))
>                 return;
> @@ -275,11 +275,11 @@ void i2c_acpi_register_devices(struct i2c_adapter *=
adap)
>         if (!adap->dev.parent)
>                 return;
>
> -       handle =3D ACPI_HANDLE(adap->dev.parent);
> -       if (!handle)
> +       adev =3D ACPI_COMPANION(adap->dev.parent);
> +       if (!adev)
>                 return;
>
> -       acpi_walk_dep_device_list(handle);
> +       acpi_dev_clear_dependencies(adev);
>  }
>
>  static const struct acpi_device_id i2c_acpi_force_400khz_device_ids[] =
=3D {
> diff --git a/drivers/platform/surface/aggregator/core.c b/drivers/platfor=
m/surface/aggregator/core.c
> index 8dc2c267bcd6..517f774a6e60 100644
> --- a/drivers/platform/surface/aggregator/core.c
> +++ b/drivers/platform/surface/aggregator/core.c
> @@ -621,8 +621,8 @@ static const struct acpi_gpio_mapping ssam_acpi_gpios=
[] =3D {
>
>  static int ssam_serial_hub_probe(struct serdev_device *serdev)
>  {
> +       struct acpi_device *ssh =3D ACPI_COMPANION(&serdev->dev);
>         struct ssam_controller *ctrl;
> -       acpi_handle *ssh =3D ACPI_HANDLE(&serdev->dev);
>         acpi_status astatus;
>         int status;
>
> @@ -652,7 +652,7 @@ static int ssam_serial_hub_probe(struct serdev_device=
 *serdev)
>         if (status)
>                 goto err_devopen;
>
> -       astatus =3D ssam_serdev_setup_via_acpi(ssh, serdev);
> +       astatus =3D ssam_serdev_setup_via_acpi(ssh->handle, serdev);
>         if (ACPI_FAILURE(astatus)) {
>                 status =3D -ENXIO;
>                 goto err_devinit;
> @@ -706,7 +706,7 @@ static int ssam_serial_hub_probe(struct serdev_device=
 *serdev)
>          *       For now let's thus default power/wakeup to false.
>          */
>         device_set_wakeup_capable(&serdev->dev, true);
> -       acpi_walk_dep_device_list(ssh);
> +       acpi_dev_clear_dependencies(ssh);
>
>         return 0;
>
> diff --git a/drivers/platform/surface/surface3_power.c b/drivers/platform=
/surface/surface3_power.c
> index cc4f9cba6856..dea82aa1abd4 100644
> --- a/drivers/platform/surface/surface3_power.c
> +++ b/drivers/platform/surface/surface3_power.c
> @@ -446,12 +446,12 @@ mshw0011_space_handler(u32 function, acpi_physical_=
address command,
>
>  static int mshw0011_install_space_handler(struct i2c_client *client)
>  {
> -       acpi_handle handle;
> +       struct acpi_device *adev;
>         struct mshw0011_handler_data *data;
>         acpi_status status;
>
> -       handle =3D ACPI_HANDLE(&client->dev);
> -       if (!handle)
> +       adev =3D ACPI_COMPANION(&client->dev);
> +       if (!adev)
>                 return -ENODEV;
>
>         data =3D kzalloc(sizeof(struct mshw0011_handler_data),
> @@ -460,25 +460,25 @@ static int mshw0011_install_space_handler(struct i2=
c_client *client)
>                 return -ENOMEM;
>
>         data->client =3D client;
> -       status =3D acpi_bus_attach_private_data(handle, (void *)data);
> +       status =3D acpi_bus_attach_private_data(adev->handle, (void *)dat=
a);
>         if (ACPI_FAILURE(status)) {
>                 kfree(data);
>                 return -ENOMEM;
>         }
>
> -       status =3D acpi_install_address_space_handler(handle,
> -                               ACPI_ADR_SPACE_GSBUS,
> -                               &mshw0011_space_handler,
> -                               NULL,
> -                               data);
> +       status =3D acpi_install_address_space_handler(adev->handle,
> +                                                   ACPI_ADR_SPACE_GSBUS,
> +                                                   &mshw0011_space_handl=
er,
> +                                                   NULL,
> +                                                   data);
>         if (ACPI_FAILURE(status)) {
>                 dev_err(&client->dev, "Error installing i2c space handler=
\n");
> -               acpi_bus_detach_private_data(handle);
> +               acpi_bus_detach_private_data(adev->handle);
>                 kfree(data);
>                 return -ENOMEM;
>         }
>
> -       acpi_walk_dep_device_list(handle);
> +       acpi_dev_clear_dependencies(adev);
>         return 0;
>  }
>
> diff --git a/drivers/platform/surface/surface_acpi_notify.c b/drivers/pla=
tform/surface/surface_acpi_notify.c
> index ef9c1f8e8336..8339988d95c1 100644
> --- a/drivers/platform/surface/surface_acpi_notify.c
> +++ b/drivers/platform/surface/surface_acpi_notify.c
> @@ -798,7 +798,7 @@ static int san_consumer_links_setup(struct platform_d=
evice *pdev)
>
>  static int san_probe(struct platform_device *pdev)
>  {
> -       acpi_handle san =3D ACPI_HANDLE(&pdev->dev);
> +       struct acpi_device *san =3D ACPI_COMPANION(&pdev->dev);
>         struct ssam_controller *ctrl;
>         struct san_data *data;
>         acpi_status astatus;
> @@ -821,7 +821,8 @@ static int san_probe(struct platform_device *pdev)
>
>         platform_set_drvdata(pdev, data);
>
> -       astatus =3D acpi_install_address_space_handler(san, ACPI_ADR_SPAC=
E_GSBUS,
> +       astatus =3D acpi_install_address_space_handler(san->handle,
> +                                                    ACPI_ADR_SPACE_GSBUS,
>                                                      &san_opreg_handler, =
NULL,
>                                                      &data->info);
>         if (ACPI_FAILURE(astatus))
> @@ -835,7 +836,7 @@ static int san_probe(struct platform_device *pdev)
>         if (status)
>                 goto err_install_dev;
>
> -       acpi_walk_dep_device_list(san);
> +       acpi_dev_clear_dependencies(san);
>         return 0;
>
>  err_install_dev:
> diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> index 3a82faac5767..0b2c4f170f4d 100644
> --- a/include/acpi/acpi_bus.h
> +++ b/include/acpi/acpi_bus.h
> @@ -280,6 +280,12 @@ struct acpi_device_power {
>         struct acpi_device_power_state states[ACPI_D_STATE_COUNT];      /=
* Power states (D0-D3Cold) */
>  };
>
> +struct acpi_dep_data {
> +       struct list_head node;
> +       acpi_handle supplier;
> +       acpi_handle consumer;
> +};
> +
>  /* Performance Management */
>
>  struct acpi_device_perf_flags {
> @@ -685,6 +691,7 @@ static inline bool acpi_device_can_poweroff(struct ac=
pi_device *adev)
>
>  bool acpi_dev_hid_uid_match(struct acpi_device *adev, const char *hid2, =
const char *uid2);
>
> +void acpi_dev_clear_dependencies(struct acpi_device *supplier);
>  struct acpi_device *
>  acpi_dev_get_next_match_dev(struct acpi_device *adev, const char *hid, c=
onst char *uid, s64 hrv);
>  struct acpi_device *
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index c60745f657e9..170b9bebdb2b 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -666,7 +666,9 @@ extern bool acpi_driver_match_device(struct device *d=
ev,
>                                      const struct device_driver *drv);
>  int acpi_device_uevent_modalias(struct device *, struct kobj_uevent_env =
*);
>  int acpi_device_modalias(struct device *, char *, int);
> -void acpi_walk_dep_device_list(acpi_handle handle);
> +int acpi_walk_dep_device_list(acpi_handle handle,
> +                             int (*callback)(struct acpi_dep_data *, voi=
d *),
> +                             void *data);
>
>  struct platform_device *acpi_create_platform_device(struct acpi_device *,
>                                                     struct property_entry=
 *);
> --
> 2.25.1
>
--===============2511807882434444954==--

