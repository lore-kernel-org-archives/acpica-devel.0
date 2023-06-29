Return-Path: <rjwysocki@gmail.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 689B14015F
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9CAB840586
MIME-Version: 1.0
References: <20230626110026.65825-1-andriy.shevchenko@linux.intel.com>
 <20230626110026.65825-3-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230626110026.65825-3-andriy.shevchenko@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Message-ID: <CAJZ5v0jDO_ktnqg-2+iUt0UFRE-zYHdLHjWL3QfVD5syLF+d+w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Acpica-devel] [PATCH v3 2/4] ACPI: bus: Introduce
	acpi_match_acpi_device() helper
List-Id: "This is the central place for ACPICA developer discussions and
 issues." <acpica-devel.lists.linuxfoundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/acpica-devel/>
List-Post: <mailto:acpica-devel@lists.linuxfoundation.org>
List-Help: <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=subscribe>
Date: Thu, 29 Jun 2023 08:45:11 -0000
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Andi Shyti <andi.shyti@kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-kernel@vger.kernel.org, Robert Moore <robert.moore@intel.com>, linux-acpi@vger.kernel.org, Michael Walle <michael@walle.cc>, linux-i2c@vger.kernel.org, acpica-devel@lists.linuxfoundation.org, Len Brown <lenb@kernel.org>

On Mon, Jun 26, 2023 at 1:00=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> In some cases we can't have a physical node associated with
> the ACPI device. Yet we want to match it against ID table and
> get respective driver data. Introduce the helper for that.

I think that the problem is really to find a struct acpi_device_id in
a given list matching a given struct acpi_device.

> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/acpi/bus.c   | 15 +++++++++++----
>  include/linux/acpi.h |  9 +++++++++
>  2 files changed, 20 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> index 20cdfb37da79..ee88bfb60ac2 100644
> --- a/drivers/acpi/bus.c
> +++ b/drivers/acpi/bus.c
> @@ -850,6 +850,16 @@ static bool __acpi_match_device(const struct acpi_de=
vice *device,
>         return true;
>  }
>
> +const struct acpi_device_id *acpi_match_acpi_device(const struct acpi_de=
vice_id *ids,
> +                                                   const struct acpi_dev=
ice *adev)
> +{
> +       const struct acpi_device_id *id =3D NULL;
> +
> +       __acpi_match_device(adev, ids, NULL, &id, NULL);
> +       return id;
> +}
> +EXPORT_SYMBOL_GPL(acpi_match_acpi_device);

This is fine, but it requires a kerneldoc comment (as an exported function)=
.

Of course, the code in scan.c can use it even if it is not exported.

> +
>  /**
>   * acpi_match_device - Match a struct device against a given list of ACP=
I IDs
>   * @ids: Array of struct acpi_device_id object to match against.
> @@ -864,10 +874,7 @@ static bool __acpi_match_device(const struct acpi_de=
vice *device,
>  const struct acpi_device_id *acpi_match_device(const struct acpi_device_=
id *ids,
>                                                const struct device *dev)
>  {
> -       const struct acpi_device_id *id =3D NULL;
> -
> -       __acpi_match_device(acpi_companion_match(dev), ids, NULL, &id, NU=
LL);
> -       return id;
> +       return acpi_match_acpi_device(ids, acpi_companion_match(dev));
>  }
>  EXPORT_SYMBOL_GPL(acpi_match_device);
>
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index 640f1c07c894..641dc4843987 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -707,6 +707,9 @@ extern int acpi_nvs_register(__u64 start, __u64 size)=
;
>  extern int acpi_nvs_for_each_region(int (*func)(__u64, __u64, void *),
>                                     void *data);
>
> +const struct acpi_device_id *acpi_match_acpi_device(const struct acpi_de=
vice_id *ids,
> +                                                   const struct acpi_dev=
ice *adev);
> +
>  const struct acpi_device_id *acpi_match_device(const struct acpi_device_=
id *ids,
>                                                const struct device *dev);
>
> @@ -922,6 +925,12 @@ static inline int acpi_nvs_for_each_region(int (*fun=
c)(__u64, __u64, void *),
>
>  struct acpi_device_id;
>
> +static inline const struct acpi_device_id *acpi_match_acpi_device(
> +       const struct acpi_device_id *ids, const struct acpi_device *adev)
> +{
> +       return NULL;
> +}
> +
>  static inline const struct acpi_device_id *acpi_match_device(
>         const struct acpi_device_id *ids, const struct device *dev)
>  {
> --
> 2.40.0.1.gaa8946217a0b
>
