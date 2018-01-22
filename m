Content-Type: multipart/mixed; boundary="===============7990633617450307140=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: Re: [Devel] [PATCH v2 1/5] ACPI: export acpi_bus_get_status_handle()
Date: Tue, 23 Jan 2018 00:55:33 +0100
Message-ID: <CAJZ5v0g7KppXpk_jRWjKz8-ncdJQHg-QU7oGrgPiBtczgf+gfQ@mail.gmail.com>
In-Reply-To: 20180122085135.16732-2-hdegoede@redhat.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============7990633617450307140==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2018 at 9:51 AM, Hans de Goede <hdegoede(a)redhat.com> wrot=
e:
> Some modular drivers need this, export it.
>
> Signed-off-by: Hans de Goede <hdegoede(a)redhat.com>
> ---
> Changes in v2:
> -This is a new patch in v2 of this patch-set
> ---
>  drivers/acpi/bus.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> index 4d0979e02a28..db0c05997cc2 100644
> --- a/drivers/acpi/bus.c
> +++ b/drivers/acpi/bus.c
> @@ -108,6 +108,7 @@ acpi_status acpi_bus_get_status_handle(acpi_handle ha=
ndle,
>         }
>         return status;
>  }
> +EXPORT_SYMBOL(acpi_bus_get_status_handle);

EXPORT_SYMBOL_GPL(), please.

>
>  int acpi_bus_get_status(struct acpi_device *device)
>  {
> --

--===============7990633617450307140==--

