Content-Type: multipart/mixed; boundary="===============8105158950757755392=="
MIME-Version: 1.0
From: Andy Shevchenko <andy.shevchenko at gmail.com>
Subject: [Devel] Re: [PATCH v3 2/6] ACPI: scan: Add function to fetch
 dependent of acpi device
Date: Mon, 22 Feb 2021 15:41:21 +0200
Message-ID: <CAHp75VeK-0gJ195mXjuZDPLKD4ROVKfFaoWw97yJ1NXpK1QVWg@mail.gmail.com>
In-Reply-To: 20210222130735.1313443-3-djrscally@gmail.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============8105158950757755392==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 22, 2021 at 3:11 PM Daniel Scally <djrscally(a)gmail.com> wrote:
>
> In some ACPI tables we encounter, devices use the _DEP method to assert
> a dependence on other ACPI devices as opposed to the OpRegions that the
> specification intends. We need to be able to find those devices "from"
> the dependee, so add a callback and a wrapper to walk over the
> acpi_dep_list and return the dependent ACPI device.
>

Reviewed-by: Andy Shevchenko <andy.shevchenko(a)gmail.com>
Nit-picks below as usual :-)

> Signed-off-by: Daniel Scally <djrscally(a)gmail.com>
> ---
> Changes in v3:
>         - Switched from a standalone function to a callback passed to
>           acpi_walk_dep_device_list().
>
>  drivers/acpi/scan.c     | 34 ++++++++++++++++++++++++++++++++++
>  include/acpi/acpi_bus.h |  1 +
>  2 files changed, 35 insertions(+)
>
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index c9e4190316ef..55626925261c 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -2093,6 +2093,21 @@ static void acpi_bus_attach(struct acpi_device *de=
vice, bool first_pass)
>                 device->handler->hotplug.notify_online(device);
>  }
>
> +static int __acpi_dev_get_dependent_dev(struct acpi_dep_data *dep, void =
*data)
> +{
> +       struct acpi_device *adev;
> +       int ret;
> +
> +       ret =3D acpi_bus_get_device(dep->consumer, &adev);
> +       if (ret)
> +               /* If we don't find an adev then we want to continue pars=
ing */
> +               return 0;
> +
> +       *(struct acpi_device **)data =3D adev;

Hmm... I'm wondering if
  *(void **data) =3D adev;
will compile and work.

But on second thought the current code is more specific and explicit,
which is good.

> +
> +       return 1;
> +}
> +
>  static int __acpi_dev_flag_dependency_met(struct acpi_dep_data *dep,
>                                           void *data)
>  {
> @@ -2145,6 +2160,25 @@ void acpi_dev_flag_dependency_met(acpi_handle hand=
le)
>  }
>  EXPORT_SYMBOL_GPL(acpi_dev_flag_dependency_met);
>
> +/**
> + * acpi_dev_get_dependent_dev - Return ACPI device dependent on @adev
> + * @adev: Pointer to the dependee device
> + *
> + * Returns the first &struct acpi_device which declares itself dependent=
 on
> + * @adev via the _DEP buffer, parsed from the acpi_dep_list.
> + */

> +struct acpi_device *
> +acpi_dev_get_dependent_dev(struct acpi_device *supplier)

I believe it will be okay to have it on one line

> +{
> +       struct acpi_device *adev =3D NULL;

> +       acpi_walk_dep_device_list(supplier->handle,
> +                                 __acpi_dev_get_dependent_dev, &adev);

Ditto.

> +       return adev;
> +}
> +EXPORT_SYMBOL_GPL(acpi_dev_get_dependent_dev);
> +
>  /**
>   * acpi_bus_scan - Add ACPI device node objects in a given namespace sco=
pe.
>   * @handle: Root of the namespace scope to scan.
> diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> index 91172af3a04d..5b14a9ae4ed5 100644
> --- a/include/acpi/acpi_bus.h
> +++ b/include/acpi/acpi_bus.h
> @@ -690,6 +690,7 @@ static inline bool acpi_device_can_poweroff(struct ac=
pi_device *adev)
>  bool acpi_dev_hid_uid_match(struct acpi_device *adev, const char *hid2, =
const char *uid2);
>
>  void acpi_dev_flag_dependency_met(acpi_handle handle);
> +struct acpi_device *acpi_dev_get_dependent_dev(struct acpi_device *suppl=
ier);
>  struct acpi_device *
>  acpi_dev_get_next_match_dev(struct acpi_device *adev, const char *hid, c=
onst char *uid, s64 hrv);
>  struct acpi_device *
> --
> 2.25.1
>


-- =

With Best Regards,
Andy Shevchenko
--===============8105158950757755392==--

