Return-Path: <rjwysocki@gmail.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org F2B43400E9
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E125240015
MIME-Version: 1.0
References: <20230626110026.65825-1-andriy.shevchenko@linux.intel.com>
 <20230626110026.65825-2-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230626110026.65825-2-andriy.shevchenko@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Message-ID: <CAJZ5v0jqP0N3=TB3w+HMwGMzctpRCjKa3a5iHKePP113T3CK-g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Acpica-devel] [PATCH v3 1/4] ACPI: bus: Constify
 acpi_companion_match() returned value
List-Id: "This is the central place for ACPICA developer discussions and
 issues." <acpica-devel.lists.linuxfoundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/acpica-devel/>
List-Post: <mailto:acpica-devel@lists.linuxfoundation.org>
List-Help: <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=subscribe>
Date: Thu, 29 Jun 2023 08:49:32 -0000
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Andi Shyti <andi.shyti@kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-kernel@vger.kernel.org, Robert Moore <robert.moore@intel.com>, linux-acpi@vger.kernel.org, Michael Walle <michael@walle.cc>, linux-i2c@vger.kernel.org, acpica-devel@lists.linuxfoundation.org, Len Brown <lenb@kernel.org>

On Mon, Jun 26, 2023 at 1:00=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> acpi_companion_match() doesn't alter the contents of the passed
> parameter, so we don't expect that returned value can be altered
> either. So constify it.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

This makes sense even without the rest of the series, so I can queue
it up right away if you want me to do that.

> ---
>  drivers/acpi/bus.c          | 6 +++---
>  drivers/acpi/device_sysfs.c | 2 +-
>  drivers/acpi/internal.h     | 2 +-
>  3 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> index e3e0bd0c5a50..20cdfb37da79 100644
> --- a/drivers/acpi/bus.c
> +++ b/drivers/acpi/bus.c
> @@ -682,7 +682,7 @@ bool acpi_device_is_first_physical_node(struct acpi_d=
evice *adev,
>   * resources available from it but they will be matched normally using f=
unctions
>   * provided by their bus types (and analogously for their modalias).
>   */
> -struct acpi_device *acpi_companion_match(const struct device *dev)
> +const struct acpi_device *acpi_companion_match(const struct device *dev)
>  {
>         struct acpi_device *adev;
>
> @@ -706,7 +706,7 @@ struct acpi_device *acpi_companion_match(const struct=
 device *dev)
>   * identifiers and a _DSD object with the "compatible" property, use tha=
t
>   * property to match against the given list of identifiers.
>   */
> -static bool acpi_of_match_device(struct acpi_device *adev,
> +static bool acpi_of_match_device(const struct acpi_device *adev,
>                                  const struct of_device_id *of_match_tabl=
e,
>                                  const struct of_device_id **of_id)
>  {
> @@ -808,7 +808,7 @@ static bool __acpi_match_device_cls(const struct acpi=
_device_id *id,
>         return true;
>  }
>
> -static bool __acpi_match_device(struct acpi_device *device,
> +static bool __acpi_match_device(const struct acpi_device *device,
>                                 const struct acpi_device_id *acpi_ids,
>                                 const struct of_device_id *of_ids,
>                                 const struct acpi_device_id **acpi_id,
> diff --git a/drivers/acpi/device_sysfs.c b/drivers/acpi/device_sysfs.c
> index 0fbfbaa8d8e3..b9bbf0746199 100644
> --- a/drivers/acpi/device_sysfs.c
> +++ b/drivers/acpi/device_sysfs.c
> @@ -283,7 +283,7 @@ int acpi_device_uevent_modalias(const struct device *=
dev, struct kobj_uevent_env
>  }
>  EXPORT_SYMBOL_GPL(acpi_device_uevent_modalias);
>
> -static int __acpi_device_modalias(struct acpi_device *adev, char *buf, i=
nt size)
> +static int __acpi_device_modalias(const struct acpi_device *adev, char *=
buf, int size)
>  {
>         int len, count;
>
> diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
> index 50dcb35c9965..f4148dc50b9c 100644
> --- a/drivers/acpi/internal.h
> +++ b/drivers/acpi/internal.h
> @@ -121,7 +121,7 @@ int acpi_bus_register_early_device(int type);
>  /* ---------------------------------------------------------------------=
-----
>                       Device Matching and Notification
>     ---------------------------------------------------------------------=
----- */
> -struct acpi_device *acpi_companion_match(const struct device *dev);
> +const struct acpi_device *acpi_companion_match(const struct device *dev)=
;
>  int __acpi_device_uevent_modalias(const struct acpi_device *adev,
>                                   struct kobj_uevent_env *env);
>
> --
> 2.40.0.1.gaa8946217a0b
>
