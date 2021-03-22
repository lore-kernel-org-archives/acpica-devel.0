Content-Type: multipart/mixed; boundary="===============1687352105109971316=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: [Devel] Re: [PATCH v4 1/1] ACPI: scan: Use unique number for
 instance_no
Date: Mon, 22 Mar 2021 17:47:07 +0100
Message-ID: <CAJZ5v0hpNzCVf76npq_z+H-kBa0BurDnUDJdK5jqkpooHmTmJg@mail.gmail.com>
In-Reply-To: 20210322163100.42617-1-andriy.shevchenko@linux.intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============1687352105109971316==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 22, 2021 at 5:31 PM Andy Shevchenko
<andriy.shevchenko(a)linux.intel.com> wrote:
>
> The decrementation of acpi_device_bus_id->instance_no
> in acpi_device_del() is incorrect, because it may cause
> a duplicate instance number to be allocated next time
> a device with the same acpi_device_bus_id is added.
>
> Replace above mentioned approach by using IDA framework.
>
> While at it, define the instance range to be [0, 4096).
>
> Fixes: e49bd2dd5a50 ("ACPI: use PNPID:instance_no as bus_id of ACPI devic=
e")
> Fixes: ca9dc8d42b30 ("ACPI / scan: Fix acpi_bus_id_list bookkeeping")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko(a)linux.intel.com>

Applied as 5.12-rc material, thanks!

> ---
> v4: defined instance range [0, 4096) (Rafael)
>  drivers/acpi/internal.h |  6 +++++-
>  drivers/acpi/scan.c     | 33 ++++++++++++++++++++++++++++-----
>  include/acpi/acpi_bus.h |  1 +
>  3 files changed, 34 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
> index e6a5d997241c..cb8f70842249 100644
> --- a/drivers/acpi/internal.h
> +++ b/drivers/acpi/internal.h
> @@ -9,6 +9,8 @@
>  #ifndef _ACPI_INTERNAL_H_
>  #define _ACPI_INTERNAL_H_
>
> +#include <linux/idr.h>
> +
>  #define PREFIX "ACPI: "
>
>  int early_acpi_osi_init(void);
> @@ -96,9 +98,11 @@ void acpi_scan_table_handler(u32 event, void *table, v=
oid *context);
>
>  extern struct list_head acpi_bus_id_list;
>
> +#define ACPI_MAX_DEVICE_INSTANCES      4096
> +
>  struct acpi_device_bus_id {
>         const char *bus_id;
> -       unsigned int instance_no;
> +       struct ida instance_ida;
>         struct list_head node;
>  };
>
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index a184529d8fa4..84bb7c1929f1 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -479,9 +479,8 @@ static void acpi_device_del(struct acpi_device *devic=
e)
>         list_for_each_entry(acpi_device_bus_id, &acpi_bus_id_list, node)
>                 if (!strcmp(acpi_device_bus_id->bus_id,
>                             acpi_device_hid(device))) {
> -                       if (acpi_device_bus_id->instance_no > 0)
> -                               acpi_device_bus_id->instance_no--;
> -                       else {
> +                       ida_simple_remove(&acpi_device_bus_id->instance_i=
da, device->pnp.instance_no);
> +                       if (ida_is_empty(&acpi_device_bus_id->instance_id=
a)) {
>                                 list_del(&acpi_device_bus_id->node);
>                                 kfree_const(acpi_device_bus_id->bus_id);
>                                 kfree(acpi_device_bus_id);
> @@ -631,6 +630,21 @@ static struct acpi_device_bus_id *acpi_device_bus_id=
_match(const char *dev_id)
>         return NULL;
>  }
>
> +static int acpi_device_set_name(struct acpi_device *device,
> +                               struct acpi_device_bus_id *acpi_device_bu=
s_id)
> +{
> +       struct ida *instance_ida =3D &acpi_device_bus_id->instance_ida;
> +       int result;
> +
> +       result =3D ida_simple_get(instance_ida, 0, ACPI_MAX_DEVICE_INSTAN=
CES, GFP_KERNEL);
> +       if (result < 0)
> +               return result;
> +
> +       device->pnp.instance_no =3D result;
> +       dev_set_name(&device->dev, "%s:%02x", acpi_device_bus_id->bus_id,=
 result);
> +       return 0;
> +}
> +
>  int acpi_device_add(struct acpi_device *device,
>                     void (*release)(struct device *))
>  {
> @@ -665,7 +679,9 @@ int acpi_device_add(struct acpi_device *device,
>
>         acpi_device_bus_id =3D acpi_device_bus_id_match(acpi_device_hid(d=
evice));
>         if (acpi_device_bus_id) {
> -               acpi_device_bus_id->instance_no++;
> +               result =3D acpi_device_set_name(device, acpi_device_bus_i=
d);
> +               if (result)
> +                       goto err_unlock;
>         } else {
>                 acpi_device_bus_id =3D kzalloc(sizeof(*acpi_device_bus_id=
),
>                                              GFP_KERNEL);
> @@ -681,9 +697,16 @@ int acpi_device_add(struct acpi_device *device,
>                         goto err_unlock;
>                 }
>
> +               ida_init(&acpi_device_bus_id->instance_ida);
> +
> +               result =3D acpi_device_set_name(device, acpi_device_bus_i=
d);
> +               if (result) {
> +                       kfree(acpi_device_bus_id);
> +                       goto err_unlock;
> +               }
> +
>                 list_add_tail(&acpi_device_bus_id->node, &acpi_bus_id_lis=
t);
>         }
> -       dev_set_name(&device->dev, "%s:%02x", acpi_device_bus_id->bus_id,=
 acpi_device_bus_id->instance_no);
>
>         if (device->parent)
>                 list_add_tail(&device->node, &device->parent->children);
> diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> index 02a716a0af5d..f28b097c658f 100644
> --- a/include/acpi/acpi_bus.h
> +++ b/include/acpi/acpi_bus.h
> @@ -233,6 +233,7 @@ struct acpi_pnp_type {
>
>  struct acpi_device_pnp {
>         acpi_bus_id bus_id;             /* Object name */
> +       int instance_no;                /* Instance number of this object=
 */
>         struct acpi_pnp_type type;      /* ID type */
>         acpi_bus_address bus_address;   /* _ADR */
>         char *unique_id;                /* _UID */
> --
> 2.30.2
>
--===============1687352105109971316==--

