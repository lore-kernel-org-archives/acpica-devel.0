Content-Type: multipart/mixed; boundary="===============2322269728198900397=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: [Devel] Re: [PATCH v2 2/7] acpi: utils: Add function to fetch
 dependent acpi_devices
Date: Mon, 18 Jan 2021 17:14:17 +0100
Message-ID: <CAJZ5v0gVQsZ4rxXW8uMidW9zfY_S50zpfrL-Gq0J3Z4-qqBiww@mail.gmail.com>
In-Reply-To: 20210118003428.568892-3-djrscally@gmail.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============2322269728198900397==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 18, 2021 at 1:37 AM Daniel Scally <djrscally(a)gmail.com> wrote:
>
> In some ACPI tables we encounter, devices use the _DEP method to assert
> a dependence on other ACPI devices as opposed to the OpRegions that the
> specification intends. We need to be able to find those devices "from"
> the dependee, so add a function to parse all ACPI Devices and check if
> the include the handle of the dependee device in their _DEP buffer.

What exactly do you need this for?

Would it be practical to look up the suppliers in acpi_dep_list instead?

Note that supplier drivers may remove entries from there, but does
that matter for your use case?

> Signed-off-by: Daniel Scally <djrscally(a)gmail.com>
> ---
> Changes in v2:
>         - Used acpi_lpss_dep() as Andy suggested.
>
>  drivers/acpi/utils.c    | 34 ++++++++++++++++++++++++++++++++++
>  include/acpi/acpi_bus.h |  2 ++
>  2 files changed, 36 insertions(+)
>
> diff --git a/drivers/acpi/utils.c b/drivers/acpi/utils.c
> index 78b38775f18b..ec6a2406a886 100644
> --- a/drivers/acpi/utils.c
> +++ b/drivers/acpi/utils.c
> @@ -831,6 +831,18 @@ bool acpi_lpss_dep(struct acpi_device *adev, acpi_ha=
ndle handle)
>         return false;
>  }
>
> +static int acpi_dev_match_by_dep(struct device *dev, const void *data)
> +{
> +       struct acpi_device *adev =3D to_acpi_device(dev);
> +       const struct acpi_device *dependee =3D data;
> +       acpi_handle handle =3D dependee->handle;
> +
> +       if (acpi_lpss_dep(adev, handle))
> +               return 1;
> +
> +       return 0;
> +}
> +
>  /**
>   * acpi_dev_present - Detect that a given ACPI device is present
>   * @hid: Hardware ID of the device.
> @@ -866,6 +878,28 @@ bool acpi_dev_present(const char *hid, const char *u=
id, s64 hrv)
>  }
>  EXPORT_SYMBOL(acpi_dev_present);
>
> +/**
> + * acpi_dev_get_next_dep_dev - Return next ACPI device dependent on inpu=
t dev
> + * @adev: Pointer to the dependee device
> + * @prev: Pointer to the previous dependent device (or NULL for first ma=
tch)
> + *
> + * Return the next ACPI device which declares itself dependent on @adev =
in
> + * the _DEP buffer.
> + *
> + * The caller is responsible to call put_device() on the returned device.
> + */
> +struct acpi_device *acpi_dev_get_next_dep_dev(struct acpi_device *adev,
> +                                             struct acpi_device *prev)
> +{
> +       struct device *start =3D prev ? &prev->dev : NULL;
> +       struct device *dev;
> +
> +       dev =3D bus_find_device(&acpi_bus_type, start, adev, acpi_dev_mat=
ch_by_dep);
> +
> +       return dev ? to_acpi_device(dev) : NULL;
> +}
> +EXPORT_SYMBOL(acpi_dev_get_next_dep_dev);
> +
>  /**
>   * acpi_dev_get_next_match_dev - Return the next match of ACPI device
>   * @adev: Pointer to the previous acpi_device matching this @hid, @uid a=
nd @hrv
> diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> index 02a716a0af5d..33deb22294f2 100644
> --- a/include/acpi/acpi_bus.h
> +++ b/include/acpi/acpi_bus.h
> @@ -683,6 +683,8 @@ static inline bool acpi_device_can_poweroff(struct ac=
pi_device *adev)
>
>  bool acpi_dev_hid_uid_match(struct acpi_device *adev, const char *hid2, =
const char *uid2);
>
> +struct acpi_device *
> +acpi_dev_get_next_dep_dev(struct acpi_device *adev, struct acpi_device *=
prev);
>  struct acpi_device *
>  acpi_dev_get_next_match_dev(struct acpi_device *adev, const char *hid, c=
onst char *uid, s64 hrv);
>  struct acpi_device *
> --
> 2.25.1
>
--===============2322269728198900397==--

