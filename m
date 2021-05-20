Content-Type: multipart/mixed; boundary="===============3191778276736025128=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: [Devel] Re: [PATCH v1 1/1] ACPI: utils: Fix reference counting in
 for_each_acpi_dev_match()
Date: Thu, 20 May 2021 21:13:36 +0200
Message-ID: <CAJZ5v0in=qEtVULLF=RwBTiFqiRK-DyPfD4F6uUAqeUfPFB8QQ@mail.gmail.com>
In-Reply-To: 20210519210253.3578025-1-andy.shevchenko@gmail.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============3191778276736025128==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, May 19, 2021 at 11:19 PM Andy Shevchenko
<andy.shevchenko(a)gmail.com> wrote:
>
> Currently it's possible to iterate over the dangling pointer in case the =
device
> suddenly disappears. This may happen becase callers put it at the end of =
a loop.
>
> Instead, let's move that call inside acpi_dev_get_next_match_dev().

Not really.

> Fixes: 803abec64ef9 ("media: ipu3-cio2: Add cio2-bridge to ipu3-cio2 driv=
er")
> Fixes: bf263f64e804 ("media: ACPI / bus: Add acpi_dev_get_next_match_dev(=
) and helper macro")
> Cc: Daniel Scally <djrscally(a)gmail.com>
> Cc: Sakari Ailus <sakari.ailus(a)linux.intel.com>
> Signed-off-by: Andy Shevchenko <andy.shevchenko(a)gmail.com>
> ---
>  drivers/acpi/utils.c                       | 5 +----
>  drivers/media/pci/intel/ipu3/cio2-bridge.c | 8 +++-----
>  include/acpi/acpi_bus.h                    | 5 -----
>  3 files changed, 4 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/acpi/utils.c b/drivers/acpi/utils.c
> index 3b54b8fd7396..ccfc484dbffd 100644
> --- a/drivers/acpi/utils.c
> +++ b/drivers/acpi/utils.c
> @@ -846,10 +846,6 @@ EXPORT_SYMBOL(acpi_dev_present);
>   * Return the next match of ACPI device if another matching device was p=
resent
>   * at the moment of invocation, or NULL otherwise.
>   *
> - * FIXME: The function does not tolerate the sudden disappearance of @ad=
ev, e.g.
> - * in the case of a hotplug event. That said, the caller should ensure t=
hat
> - * this will never happen.
> - *
>   * The caller is responsible for invoking acpi_dev_put() on the returned=
 device.
>   *
>   * See additional information in acpi_dev_present() as well.
> @@ -866,6 +862,7 @@ acpi_dev_get_next_match_dev(struct acpi_device *adev,=
 const char *hid, const cha
>         match.hrv =3D hrv;
>
>         dev =3D bus_find_device(&acpi_bus_type, start, &match, acpi_dev_m=
atch_cb);
> +       acpi_dev_put(adev);

What's the point?

The caller may as well put it after this returns, can't it?

And what if the caller still wants to do something with adev after this ret=
urns?

>         return dev ? to_acpi_device(dev) : NULL;
>  }
>  EXPORT_SYMBOL(acpi_dev_get_next_match_dev);

The original changelog is somewhat unclear.  It should say that it is
required to reference-count the start-point device before passing it
to this function, but beyond that I don't see a bug here.

> diff --git a/drivers/media/pci/intel/ipu3/cio2-bridge.c b/drivers/media/p=
ci/intel/ipu3/cio2-bridge.c
> index e8511787c1e4..477417261b6e 100644
> --- a/drivers/media/pci/intel/ipu3/cio2-bridge.c
> +++ b/drivers/media/pci/intel/ipu3/cio2-bridge.c
> @@ -178,13 +178,11 @@ static int cio2_bridge_connect_sensor(const struct =
cio2_sensor_config *cfg,
>
>                 if (bridge->n_sensors >=3D CIO2_NUM_PORTS) {
>                         dev_err(&cio2->dev, "Exceeded available CIO2 port=
s\n");
> -                       cio2_bridge_unregister_sensors(bridge);
>                         ret =3D -EINVAL;
> -                       goto err_out;
> +                       goto err_put_adev;
>                 }
>
>                 sensor =3D &bridge->sensors[bridge->n_sensors];
> -               sensor->adev =3D adev;
>                 strscpy(sensor->name, cfg->hid, sizeof(sensor->name));
>
>                 ret =3D cio2_bridge_read_acpi_buffer(adev, "SSDB",
> @@ -214,6 +212,7 @@ static int cio2_bridge_connect_sensor(const struct ci=
o2_sensor_config *cfg,
>                         goto err_free_swnodes;
>                 }
>
> +               sensor->adev =3D acpi_dev_get(adev);
>                 adev->fwnode.secondary =3D fwnode;
>
>                 dev_info(&cio2->dev, "Found supported sensor %s\n",
> @@ -227,8 +226,7 @@ static int cio2_bridge_connect_sensor(const struct ci=
o2_sensor_config *cfg,
>  err_free_swnodes:
>         software_node_unregister_nodes(sensor->swnodes);
>  err_put_adev:
> -       acpi_dev_put(sensor->adev);
> -err_out:
> +       acpi_dev_put(adev);
>         return ret;
>  }
>
> diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> index 3a82faac5767..bff6a11bb21f 100644
> --- a/include/acpi/acpi_bus.h
> +++ b/include/acpi/acpi_bus.h
> @@ -698,11 +698,6 @@ acpi_dev_get_first_match_dev(const char *hid, const =
char *uid, s64 hrv);
>   * @hrv: Hardware Revision of the device, pass -1 to not check _HRV
>   *
>   * The caller is responsible for invoking acpi_dev_put() on the returned=
 device.
> - *
> - * FIXME: Due to above requirement there is a window that may invalidate=
 @adev
> - * and next iteration will use a dangling pointer, e.g. in the case of a
> - * hotplug event. That said, the caller should ensure that this will nev=
er
> - * happen.
>   */
>  #define for_each_acpi_dev_match(adev, hid, uid, hrv)                   \
>         for (adev =3D acpi_dev_get_first_match_dev(hid, uid, hrv);       =
 \
> --
> 2.31.1
>
--===============3191778276736025128==--

