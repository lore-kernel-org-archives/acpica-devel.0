Return-Path: <rjwysocki@gmail.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E741A60AD0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CA31260AB5
MIME-Version: 1.0
References: <20230703121411.69606-1-andriy.shevchenko@linux.intel.com>
 <20230703121411.69606-3-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230703121411.69606-3-andriy.shevchenko@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Message-ID: <CAJZ5v0iZzvdkxe3NjHbiZzDjea=CoK-pGw3hjSoa9u8f87TLtg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Acpica-devel] [PATCH v4 2/5] ACPI: platform: Ignore SMB0001
	only when it has resources
List-Id: "This is the central place for ACPICA developer discussions and
 issues." <acpica-devel.lists.linuxfoundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/acpica-devel/>
List-Post: <mailto:acpica-devel@lists.linuxfoundation.org>
List-Help: <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=subscribe>
Date: Tue, 04 Jul 2023 17:32:58 -0000
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Andi Shyti <andi.shyti@kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-kernel@vger.kernel.org, Robert Moore <robert.moore@intel.com>, Wolfram Sang <wsa@kernel.org>, linux-acpi@vger.kernel.org, Michael Walle <michael@walle.cc>, linux-i2c@vger.kernel.org, acpica-devel@lists.linuxfoundation.org, Len Brown <lenb@kernel.org>

On Mon, Jul 3, 2023 at 2:14=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> After switching i2c-scmi driver to be a platform one, it stopped
> being enumerated on number of Kontron platforms, because it's
> listed in the forbidden_id_list.
>
> To resolve the situation, add a flag to driver data to allow devices
> with no resources in _CRS to be enumerated via platform bus.
>
> Fixes: 03d4287add6e ("i2c: scmi: Convert to be a platform driver")
> Closes: https://lore.kernel.org/r/60c1756765b9a3f1eab0dcbd84f59f00fe1caf4=
8.camel@kontron.com
> Link: https://lore.kernel.org/r/20230621151652.79579-1-andriy.shevchenko@=
linux.intel.com
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Andi Shyti <andi.shyti@kernel.org>
> ---
>  drivers/acpi/acpi_platform.c | 30 +++++++++++++++++++++++++++---
>  1 file changed, 27 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/acpi/acpi_platform.c b/drivers/acpi/acpi_platform.c
> index fe00a5783f53..c2ce558bd032 100644
> --- a/drivers/acpi/acpi_platform.c
> +++ b/drivers/acpi/acpi_platform.c
> @@ -9,6 +9,7 @@
>   */
>
>  #include <linux/acpi.h>
> +#include <linux/bits.h>
>  #include <linux/device.h>
>  #include <linux/err.h>
>  #include <linux/kernel.h>
> @@ -19,13 +20,16 @@
>
>  #include "internal.h"
>
> +/* Exclude devices that have no _CRS resources provided */
> +#define ACPI_ALLOW_WO_RESOURCES                BIT(0)
> +
>  static const struct acpi_device_id forbidden_id_list[] =3D {
>         {"ACPI0009", 0},        /* IOxAPIC */
>         {"ACPI000A", 0},        /* IOAPIC */
>         {"PNP0000",  0},        /* PIC */
>         {"PNP0100",  0},        /* Timer */
>         {"PNP0200",  0},        /* AT DMA Controller */
> -       {"SMB0001",  0},        /* ACPI SMBUS virtual device */
> +       {"SMB0001",  ACPI_ALLOW_WO_RESOURCES},  /* ACPI SMBUS virtual dev=
ice */
>         { }
>  };
>
> @@ -83,6 +87,15 @@ static void acpi_platform_fill_resource(struct acpi_de=
vice *adev,
>                 dest->parent =3D pci_find_resource(to_pci_dev(parent), de=
st);
>  }
>
> +static unsigned int acpi_platform_resource_count(struct acpi_resource *a=
res, void *data)
> +{
> +       bool *has_resources =3D data;
> +
> +       *has_resources =3D true;
> +
> +       return AE_CTRL_TERMINATE;
> +}
> +
>  /**
>   * acpi_create_platform_device - Create platform device for ACPI device =
node
>   * @adev: ACPI device node to create a platform device for.
> @@ -100,17 +113,28 @@ struct platform_device *acpi_create_platform_device=
(struct acpi_device *adev,
>         struct acpi_device *parent =3D acpi_dev_parent(adev);
>         struct platform_device *pdev =3D NULL;
>         struct platform_device_info pdevinfo;
> +       const struct acpi_device_id *match;
>         struct resource_entry *rentry;
>         struct list_head resource_list;
>         struct resource *resources =3D NULL;
> +       bool has_resources;
>         int count;
>
>         /* If the ACPI node already has a physical device attached, skip =
it. */
>         if (adev->physical_node_count)
>                 return NULL;
>
> -       if (!acpi_match_device_ids(adev, forbidden_id_list))
> -               return ERR_PTR(-EINVAL);
> +       match =3D acpi_match_acpi_device(forbidden_id_list, adev);
> +       if (match) {
> +               if (match->driver_data & ACPI_ALLOW_WO_RESOURCES) {
> +                       acpi_walk_resources(adev->handle, METHOD_NAME__CR=
S,
> +                                           acpi_platform_resource_count,=
 &has_resources);
> +                       if (has_resources)
> +                               return ERR_PTR(-EINVAL);
> +               } else {
> +                       return ERR_PTR(-EINVAL);
> +               }
> +       }
>
>         INIT_LIST_HEAD(&resource_list);
>         count =3D acpi_dev_get_resources(adev, &resource_list, NULL, NULL=
);
> --

Applied as 6.5-rc material along with the rest of the series (except
for the last patch that has been superseded), but I moved the
has_resources definition to the block where it is used and added a
'false' initial value to it. as the code might not work as expected
without initializing it.

Please double check the bleeding-edge branch of linux-pm.

Thanks!
