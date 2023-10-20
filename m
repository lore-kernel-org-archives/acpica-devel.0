Return-Path: <rjwysocki@gmail.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7939A84C1B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BD3FE84C17
MIME-Version: 1.0
References: <20231020084732.17130-1-raag.jadav@intel.com>
 <20231020084732.17130-4-raag.jadav@intel.com>
In-Reply-To: <20231020084732.17130-4-raag.jadav@intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 20 Oct 2023 19:18:42 +0200
Message-ID: <CAJZ5v0ibBZ0e4_7=2h9rEjrBXGgsmYxZBO91_VfSxhgD9xJ=tQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Acpica-devel] [PATCH v1 3/8] ACPI: sysfs: use
	acpi_device_uid() for fetching _UID
List-Id: "This is the central place for ACPICA developer discussions and
 issues." <acpica-devel.lists.linuxfoundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/acpica-devel/>
List-Post: <mailto:acpica-devel@lists.linuxfoundation.org>
List-Help: <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=subscribe>
To: Raag Jadav <raag.jadav@intel.com>
Cc: mark.rutland@arm.com, len.brown@intel.com, linux-hwmon@vger.kernel.org, will@kernel.org, linux-gpio@vger.kernel.org, mallikarjunappa.sangannavar@intel.com, robert.moore@intel.com, bala.senthil@intel.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, acpica-devel@lists.linuxfoundation.org, andriy.shevchenko@linux.intel.com, mika.westerberg@linux.intel.com, linux@roeck-us.net

On Fri, Oct 20, 2023 at 10:48=E2=80=AFAM Raag Jadav <raag.jadav@intel.com> =
wrote:
>
> Convert manual _UID references to use standard ACPI helpers.
>
> Signed-off-by: Raag Jadav <raag.jadav@intel.com>
> ---
>  drivers/acpi/device_sysfs.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/acpi/device_sysfs.c b/drivers/acpi/device_sysfs.c
> index b9bbf0746199..9d8e90744cb5 100644
> --- a/drivers/acpi/device_sysfs.c
> +++ b/drivers/acpi/device_sysfs.c
> @@ -410,7 +410,7 @@ static ssize_t uid_show(struct device *dev,
>  {
>         struct acpi_device *acpi_dev =3D to_acpi_device(dev);
>
> -       return sprintf(buf, "%s\n", acpi_dev->pnp.unique_id);
> +       return sprintf(buf, "%s\n", acpi_device_uid(acpi_dev));
>  }
>  static DEVICE_ATTR_RO(uid);
>
> @@ -554,7 +554,7 @@ int acpi_device_setup_files(struct acpi_device *dev)
>
>         if (dev->pnp.type.bus_address)
>                 result =3D device_create_file(&dev->dev, &dev_attr_adr);
> -       if (dev->pnp.unique_id)
> +       if (acpi_device_uid(dev))
>                 result =3D device_create_file(&dev->dev, &dev_attr_uid);
>
>         if (acpi_has_method(dev->handle, "_SUN")) {
> @@ -635,7 +635,7 @@ void acpi_device_remove_files(struct acpi_device *dev=
)
>         if (acpi_has_method(dev->handle, "_HRV"))
>                 device_remove_file(&dev->dev, &dev_attr_hrv);
>
> -       if (dev->pnp.unique_id)
> +       if (acpi_device_uid(dev))
>                 device_remove_file(&dev->dev, &dev_attr_uid);
>         if (dev->pnp.type.bus_address)
>                 device_remove_file(&dev->dev, &dev_attr_adr);
> --

Applied as 6.7 material, thanks!
