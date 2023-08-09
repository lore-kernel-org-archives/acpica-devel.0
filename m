Return-Path: <rjwysocki@gmail.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BDCF28221A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org F15C0821F7
MIME-Version: 1.0
References: <20230809094451.15473-1-ivan.hu@canonical.com>
In-Reply-To: <20230809094451.15473-1-ivan.hu@canonical.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 9 Aug 2023 12:09:16 +0200
Message-ID: <CAJZ5v0hh=AccmG12iE5Y5JHOjwtDrDbLSgwY8K+QwtfBZN3N2Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Acpica-devel] [PATCH] ACPI: thermal: extend the acpi maximum
	handles for _PSL method
List-Id: "This is the central place for ACPICA developer discussions and
 issues." <acpica-devel.lists.linuxfoundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/acpica-devel/>
List-Post: <mailto:acpica-devel@lists.linuxfoundation.org>
List-Help: <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=subscribe>
To: Ivan Hu <ivan.hu@canonical.com>
Cc: rafael.j.wysocki@intel.com, robert.moore@intel.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, acpica-devel@lists.linuxfoundation.org, lenb@kernel.org

On Wed, Aug 9, 2023 at 11:44=E2=80=AFAM Ivan Hu <ivan.hu@canonical.com> wro=
te:
>
> Several platforms encountered the following kernel message:
> ACPI: \_TZ_.BATZ: Invalid passive threshold
>
> This issue arises due to the failure of the acpi_evaluate_reference funct=
ion
> in drivers/acpi/thermal.c while evaluating the ACPI _PSL method.
>
> status =3D acpi_evaluate_reference(tz->device->handle, "_PSL",
>                          NULL, &devices);
> if (ACPI_FAILURE(status)) {
>         acpi_handle_info(tz->device->handle,
>                          "Invalid passive threshold\n");
>         tz->trips.passive.valid =3D false;
> } else {
>         tz->trips.passive.valid =3D true;
> }
>
> However, the root cause lies in the _PSL method returning packages with a=
 count
> exceeding ACPI_MAX_HANDLES in acpi_evaluate_reference.
>
> As per the ACPI specification, the _PSL (Passive List) method is defined =
under
> a thermal zone and evaluates to a list of processor objects to be used fo=
r
> passive cooling. And it will return a variable-length Package containing =
a list
> of References to processor objects.
>
> Signed-off-by: Ivan Hu <ivan.hu@canonical.com>

Please check if this patch fixes the problem for you (it may need to
be rebased):

https://patchwork.kernel.org/project/linux-acpi/patch/20230330030446.246933=
8-1-vi@endrift.com/

> ---
>  include/acpi/acpi_bus.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> index 23fbe4a16972..dc7b38826113 100644
> --- a/include/acpi/acpi_bus.h
> +++ b/include/acpi/acpi_bus.h
> @@ -13,7 +13,7 @@
>  #include <linux/property.h>
>
>  /* TBD: Make dynamic */
> -#define ACPI_MAX_HANDLES       10
> +#define ACPI_MAX_HANDLES       32
>  struct acpi_handle_list {
>         u32 count;
>         acpi_handle handles[ACPI_MAX_HANDLES];
> --
> 2.34.1
>
