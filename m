Content-Type: multipart/mixed; boundary="===============7122670157350611234=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: [Devel] Re: [PATCH v5 2/6] ACPI: scan: Add function to fetch
 dependent of acpi device
Date: Mon, 07 Jun 2021 16:52:43 +0200
Message-ID: <CAJZ5v0j8pLo3pjuByYxJue9mr4TOGieYTHm8tghNQgk+LphL=w@mail.gmail.com>
In-Reply-To: 20210603224007.120560-3-djrscally@gmail.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============7122670157350611234==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 4, 2021 at 12:41 AM Daniel Scally <djrscally(a)gmail.com> wrote:
>
> In some ACPI tables we encounter, devices use the _DEP method to assert
> a dependence on other ACPI devices as opposed to the OpRegions that the
> specification intends. We need to be able to find those devices "from"
> the dependee, so add a callback and a wrapper to walk over the
> acpi_dep_list and return the dependent ACPI device.
>
> Reviewed-by: Andy Shevchenko <andy.shevchenko(a)gmail.com>
> Signed-off-by: Daniel Scally <djrscally(a)gmail.com>
> ---
> Changes since v5:
>
>         - Functions renamed
>
>  drivers/acpi/scan.c     | 35 +++++++++++++++++++++++++++++++++++
>  include/acpi/acpi_bus.h |  1 +
>  2 files changed, 36 insertions(+)
>
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index 195635c3462b..9af64c34e286 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -2105,6 +2105,20 @@ static void acpi_bus_attach(struct acpi_device *de=
vice, bool first_pass)
>                 device->handler->hotplug.notify_online(device);
>  }
>
> +static int acpi_dev_get_first_consumer_dev_cb(struct acpi_dep_data *dep,=
 void *data)
> +{
> +       struct acpi_device *adev;
> +
> +       adev =3D acpi_bus_get_acpi_device(dep->consumer);
> +       if (!adev)
> +               /* If we don't find an adev then we want to continue pars=
ing */
> +               return 0;
> +
> +       *(struct acpi_device **)data =3D adev;
> +
> +       return 1;
> +}
> +
>  static int acpi_scan_clear_dep(struct acpi_dep_data *dep, void *data)
>  {
>         struct acpi_device *adev;
> @@ -2168,6 +2182,27 @@ void acpi_dev_clear_dependencies(struct acpi_devic=
e *supplier)
>  }
>  EXPORT_SYMBOL_GPL(acpi_dev_clear_dependencies);
>
> +/**
> + * acpi_dev_get_first_consumer_dev - Return ACPI device dependent on @su=
pplier
> + * @supplier: Pointer to the dependee device
> + *
> + * Returns the first &struct acpi_device which declares itself dependent=
 on
> + * @supplier via the _DEP buffer, parsed from the acpi_dep_list.
> + *
> + * The caller is responsible for putting the reference to adev when it i=
s no
> + * longer needed.
> + */
> +struct acpi_device *acpi_dev_get_first_consumer_dev(struct acpi_device *=
supplier)
> +{
> +       struct acpi_device *adev =3D NULL;
> +
> +       acpi_walk_dep_device_list(supplier->handle,
> +                                 acpi_dev_get_first_consumer_dev_cb, &ad=
ev);
> +
> +       return adev;
> +}
> +EXPORT_SYMBOL_GPL(acpi_dev_get_first_consumer_dev);
> +
>  /**
>   * acpi_bus_scan - Add ACPI device node objects in a given namespace sco=
pe.
>   * @handle: Root of the namespace scope to scan.
> diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> index 0b2c4f170f4d..4bed30e61c5b 100644
> --- a/include/acpi/acpi_bus.h
> +++ b/include/acpi/acpi_bus.h
> @@ -692,6 +692,7 @@ static inline bool acpi_device_can_poweroff(struct ac=
pi_device *adev)
>  bool acpi_dev_hid_uid_match(struct acpi_device *adev, const char *hid2, =
const char *uid2);
>
>  void acpi_dev_clear_dependencies(struct acpi_device *supplier);
> +struct acpi_device *acpi_dev_get_first_consumer_dev(struct acpi_device *=
supplier);
>  struct acpi_device *
>  acpi_dev_get_next_match_dev(struct acpi_device *adev, const char *hid, c=
onst char *uid, s64 hrv);
>  struct acpi_device *
> --

Applied as 5.14 material along the [1/6].

I'll expose a branch containing the 2 patches to pull from later this week.

Thanks!
--===============7122670157350611234==--

