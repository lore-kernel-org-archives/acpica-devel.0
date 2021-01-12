Content-Type: multipart/mixed; boundary="===============3486332645824852166=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: [Devel] Re: [PATCH v5 13/15] ACPI / bus: Add
 acpi_dev_get_next_match_dev() and helper macro
Date: Tue, 12 Jan 2021 20:25:02 +0100
Message-ID: <CAJZ5v0jWCT6koRvW8AGMs3ODX_10b-fCaQgMXG7kfq1DoDfeBA@mail.gmail.com>
In-Reply-To: 20210107132838.396641-14-djrscally@gmail.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============3486332645824852166==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 7, 2021 at 2:31 PM Daniel Scally <djrscally(a)gmail.com> wrote:
>
> To ensure we handle situations in which multiple sensors of the same
> model (and therefore _HID) are present in a system, we need to be able
> to iterate over devices matching a known _HID but unknown _UID and _HRV
>  - add acpi_dev_get_next_match_dev() to accommodate that possibility and
> change acpi_dev_get_first_match_dev() to simply call the new function
> with a NULL starting point. Add an iterator macro for convenience.
>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko(a)linux.intel.com>
> Reviewed-by: Sakari Ailus <sakari.ailus(a)linux.intel.com>
> Suggested-by: Andy Shevchenko <andriy.shevchenko(a)linux.intel.com>
> Signed-off-by: Daniel Scally <djrscally(a)gmail.com>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki(a)intel.com>

> ---
> Changes in v5:
>
>         - Changed commit subject
>
>  drivers/acpi/utils.c    | 30 ++++++++++++++++++++++++++----
>  include/acpi/acpi_bus.h |  7 +++++++
>  2 files changed, 33 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/acpi/utils.c b/drivers/acpi/utils.c
> index d5411a166685..ddca1550cce6 100644
> --- a/drivers/acpi/utils.c
> +++ b/drivers/acpi/utils.c
> @@ -843,12 +843,13 @@ bool acpi_dev_present(const char *hid, const char *=
uid, s64 hrv)
>  EXPORT_SYMBOL(acpi_dev_present);
>
>  /**
> - * acpi_dev_get_first_match_dev - Return the first match of ACPI device
> + * acpi_dev_get_next_match_dev - Return the next match of ACPI device
> + * @adev: Pointer to the previous acpi_device matching this @hid, @uid a=
nd @hrv
>   * @hid: Hardware ID of the device.
>   * @uid: Unique ID of the device, pass NULL to not check _UID
>   * @hrv: Hardware Revision of the device, pass -1 to not check _HRV
>   *
> - * Return the first match of ACPI device if a matching device was present
> + * Return the next match of ACPI device if another matching device was p=
resent
>   * at the moment of invocation, or NULL otherwise.
>   *
>   * The caller is responsible to call put_device() on the returned device.
> @@ -856,8 +857,9 @@ EXPORT_SYMBOL(acpi_dev_present);
>   * See additional information in acpi_dev_present() as well.
>   */
>  struct acpi_device *
> -acpi_dev_get_first_match_dev(const char *hid, const char *uid, s64 hrv)
> +acpi_dev_get_next_match_dev(struct acpi_device *adev, const char *hid, c=
onst char *uid, s64 hrv)
>  {
> +       struct device *start =3D adev ? &adev->dev : NULL;
>         struct acpi_dev_match_info match =3D {};
>         struct device *dev;
>
> @@ -865,9 +867,29 @@ acpi_dev_get_first_match_dev(const char *hid, const =
char *uid, s64 hrv)
>         match.uid =3D uid;
>         match.hrv =3D hrv;
>
> -       dev =3D bus_find_device(&acpi_bus_type, NULL, &match, acpi_dev_ma=
tch_cb);
> +       dev =3D bus_find_device(&acpi_bus_type, start, &match, acpi_dev_m=
atch_cb);
>         return dev ? to_acpi_device(dev) : NULL;
>  }
> +EXPORT_SYMBOL(acpi_dev_get_next_match_dev);
> +
> +/**
> + * acpi_dev_get_first_match_dev - Return the first match of ACPI device
> + * @hid: Hardware ID of the device.
> + * @uid: Unique ID of the device, pass NULL to not check _UID
> + * @hrv: Hardware Revision of the device, pass -1 to not check _HRV
> + *
> + * Return the first match of ACPI device if a matching device was present
> + * at the moment of invocation, or NULL otherwise.
> + *
> + * The caller is responsible to call put_device() on the returned device.
> + *
> + * See additional information in acpi_dev_present() as well.
> + */
> +struct acpi_device *
> +acpi_dev_get_first_match_dev(const char *hid, const char *uid, s64 hrv)
> +{
> +       return acpi_dev_get_next_match_dev(NULL, hid, uid, hrv);
> +}
>  EXPORT_SYMBOL(acpi_dev_get_first_match_dev);
>
>  /*
> diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> index 6d1879bf9440..02a716a0af5d 100644
> --- a/include/acpi/acpi_bus.h
> +++ b/include/acpi/acpi_bus.h
> @@ -683,9 +683,16 @@ static inline bool acpi_device_can_poweroff(struct a=
cpi_device *adev)
>
>  bool acpi_dev_hid_uid_match(struct acpi_device *adev, const char *hid2, =
const char *uid2);
>
> +struct acpi_device *
> +acpi_dev_get_next_match_dev(struct acpi_device *adev, const char *hid, c=
onst char *uid, s64 hrv);
>  struct acpi_device *
>  acpi_dev_get_first_match_dev(const char *hid, const char *uid, s64 hrv);
>
> +#define for_each_acpi_dev_match(adev, hid, uid, hrv)                   \
> +       for (adev =3D acpi_dev_get_first_match_dev(hid, uid, hrv);       =
 \
> +            adev;                                                      \
> +            adev =3D acpi_dev_get_next_match_dev(adev, hid, uid, hrv))
> +
>  static inline void acpi_dev_put(struct acpi_device *adev)
>  {
>         put_device(&adev->dev);
> --
> 2.25.1
>
--===============3486332645824852166==--

