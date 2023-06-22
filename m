Return-Path: <rjwysocki@gmail.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 141FF4027C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B6A5E4017C
MIME-Version: 1.0
References: <20230621151652.79579-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230621151652.79579-1-andriy.shevchenko@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Message-ID: <CAJZ5v0jt8XCzUxQaBXLz0zXezih1Urq=dt-K9PWVY1JpN=Go6Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Acpica-devel] [PATCH v2 1/2] ACPI: platform: Ignore SMB0001
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
Date: Thu, 22 Jun 2023 15:53:28 -0000
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Andi Shyti <andi.shyti@kernel.org>, linux-kernel@vger.kernel.org, Michael Brunner <michael.brunner@kontron.com>, Robert Moore <robert.moore@intel.com>, linux-acpi@vger.kernel.org, linux-i2c@vger.kernel.org, acpica-devel@lists.linuxfoundation.org, Len Brown <lenb@kernel.org>

On Wed, Jun 21, 2023 at 5:16=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> After switching i2c-scmi driver to be a plaform one, it stopped

"platform"

> being enumerated on number of Kontron platforms, because it's
> listed in the forbidden_id_list.
>
> To resolve the situation, split the list to generic one and
> another that holds devices that has to be skipped if and only

"have"

> if they have bogus resources attached (_CRS method returns some).
>
> Fixes: 03d4287add6e ("i2c: scmi: Convert to be a platform driver")
> Closes: https://lore.kernel.org/r/60c1756765b9a3f1eab0dcbd84f59f00fe1caf4=
8.camel@kontron.com
> Reported-by: Michael Brunner <michael.brunner@kontron.com>
> Tested-by: Michael Brunner <michael.brunner@kontron.com>
> Reviewed-by: Andi Shyti <andi.shyti@kernel.org>
> Link: https://lore.kernel.org/r/20230620163534.1042-1-andriy.shevchenko@l=
inux.intel.com
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> v2: added tags (Andi, Michael), fixed spelling (Andi)
>  drivers/acpi/acpi_platform.c | 27 +++++++++++++++++++++++++--
>  1 file changed, 25 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/acpi/acpi_platform.c b/drivers/acpi/acpi_platform.c
> index fe00a5783f53..089a98bd18bf 100644
> --- a/drivers/acpi/acpi_platform.c
> +++ b/drivers/acpi/acpi_platform.c
> @@ -19,13 +19,17 @@
>
>  #include "internal.h"
>
> +static const struct acpi_device_id forbidden_id_with_resourses[] =3D {

I don't quite like this name and the driver_data field could be used
to indicate the need to check the resources.

> +       {"SMB0001",  0},        /* ACPI SMBUS virtual device */
> +       { }
> +};
> +
>  static const struct acpi_device_id forbidden_id_list[] =3D {
>         {"ACPI0009", 0},        /* IOxAPIC */
>         {"ACPI000A", 0},        /* IOAPIC */
>         {"PNP0000",  0},        /* PIC */
>         {"PNP0100",  0},        /* Timer */
>         {"PNP0200",  0},        /* AT DMA Controller */
> -       {"SMB0001",  0},        /* ACPI SMBUS virtual device */
>         { }
>  };
>
> @@ -83,6 +87,15 @@ static void acpi_platform_fill_resource(struct acpi_de=
vice *adev,
>                 dest->parent =3D pci_find_resource(to_pci_dev(parent), de=
st);
>  }
>
> +static int acpi_platform_resource_count(struct acpi_resource *ares, void=
 *data)
> +{
> +       int *count =3D data;
> +
> +       *count =3D *count + 1;

Why not (*count)++?

> +
> +       return 1;
> +}
> +
>  /**
>   * acpi_create_platform_device - Create platform device for ACPI device =
node
>   * @adev: ACPI device node to create a platform device for.
> @@ -103,7 +116,8 @@ struct platform_device *acpi_create_platform_device(s=
truct acpi_device *adev,
>         struct resource_entry *rentry;
>         struct list_head resource_list;
>         struct resource *resources =3D NULL;
> -       int count;
> +       int count =3D 0;
> +       int ret;
>
>         /* If the ACPI node already has a physical device attached, skip =
it. */
>         if (adev->physical_node_count)
> @@ -113,6 +127,15 @@ struct platform_device *acpi_create_platform_device(=
struct acpi_device *adev,
>                 return ERR_PTR(-EINVAL);
>
>         INIT_LIST_HEAD(&resource_list);
> +       ret =3D acpi_dev_get_resources(adev, &resource_list, acpi_platfor=
m_resource_count, &count);
> +       if (ret < 0)
> +               return ERR_PTR(ret);

Why not use acpi_walk_resources() directly here?

Also, this extra resources walk is only needed if the resources check
is needed to decide whether or not to skip the device, so what's the
benefit of doing it for every device that's not skipped?

> +
> +       acpi_dev_free_resource_list(&resource_list);
> +
> +       if (count > 0 && !acpi_match_device_ids(adev, forbidden_id_with_r=
esourses))
> +               return ERR_PTR(-EINVAL);
> +
>         count =3D acpi_dev_get_resources(adev, &resource_list, NULL, NULL=
);
>         if (count < 0)
>                 return NULL;
> --
