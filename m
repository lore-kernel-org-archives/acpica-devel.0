Content-Type: multipart/mixed; boundary="===============1861965785993536790=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: [Devel] Re: [PATCH v3 1/1] ACPI: scan: Use unique number for
 instance_no
Date: Mon, 22 Mar 2021 15:55:37 +0100
Message-ID: <CAJZ5v0gcqKiXKzEj6u7vq_1Y9pYBdSGA6yT3q6JPVgW4djSiaQ@mail.gmail.com>
In-Reply-To: 20210319192109.40041-1-andriy.shevchenko@linux.intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============1861965785993536790==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 19, 2021 at 8:21 PM Andy Shevchenko
<andriy.shevchenko(a)linux.intel.com> wrote:
>
> The decrementation of acpi_device_bus_id->instance_no
> in acpi_device_del() is incorrect, because it may cause
> a duplicate instance number to be allocated next time
> a device with the same acpi_device_bus_id is added.
>
> Replace above mentioned approach by using IDA framework.
>
> Fixes: e49bd2dd5a50 ("ACPI: use PNPID:instance_no as bus_id of ACPI devic=
e")
> Fixes: ca9dc8d42b30 ("ACPI / scan: Fix acpi_bus_id_list bookkeeping")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko(a)linux.intel.com>
> ---
> v3: rewrote commit message once again as proposed by Rafael in v1
>  drivers/acpi/internal.h |  4 +++-
>  drivers/acpi/scan.c     | 32 +++++++++++++++++++++++++++-----
>  include/acpi/acpi_bus.h |  1 +
>  3 files changed, 31 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
> index e6a5d997241c..417eb768d710 100644
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
> @@ -98,7 +100,7 @@ extern struct list_head acpi_bus_id_list;
>
>  struct acpi_device_bus_id {
>         const char *bus_id;
> -       unsigned int instance_no;
> +       struct ida instance_ida;
>         struct list_head node;
>  };
>
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index a184529d8fa4..4b445b169ad4 100644
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
> @@ -631,6 +630,20 @@ static struct acpi_device_bus_id *acpi_device_bus_id=
_match(const char *dev_id)
>         return NULL;
>  }
>
> +static int acpi_device_set_name(struct acpi_device *device,
> +                               struct acpi_device_bus_id *acpi_device_bu=
s_id)
> +{
> +       int result;
> +
> +       result =3D ida_simple_get(&acpi_device_bus_id->instance_ida, 0, 2=
55, GFP_KERNEL);

This is ida_alloc_range(ida, start, (end) - 1, gfp), so I think it
should be 256 above, instead of 255.

While at it, though, there can be more than 256 CPU devices easily on
contemporary systems, so I would use a greater number here.  Maybe
4096 and define a symbol for it?
--===============1861965785993536790==--

