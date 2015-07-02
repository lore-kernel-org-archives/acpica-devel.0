Content-Type: multipart/mixed; boundary="===============5532247489766802408=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: Re: [Devel] [PATCH] ACPI, Repair of outdated variable
Date: Thu, 02 Jul 2015 03:35:39 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37D3095DC@ORSMSX112.amr.corp.intel.com>
In-Reply-To: 1435806344-4060-1-git-send-email-yanxiaofeng@inspur.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============5532247489766802408==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This module is in the process of being deprecated; it is not in the linux k=
ernel:

/* TBD: This entire module is apparently obsolete and should be removed */



> -----Original Message-----
> From: xiaofeng_yan2006(a)126.com [mailto:xiaofeng_yan2006(a)126.com] On B=
ehalf
> Of xiaofeng.yan
> Sent: Wednesday, July 01, 2015 8:06 PM
> To: Moore, Robert; Zheng, Lv; Wysocki, Rafael J; lenb(a)kernel.org
> Cc: linux-acpi(a)vger.kernel.org; devel(a)acpica.org; linux-
> kernel(a)vger.kernel.org; xiaofeng.yan
> Subject: [PATCH] ACPI, Repair of outdated variable
> =

> variable "value" in struct acpi_pnp_device_id has been changed to
> "string".
> =

> Signed-off-by: xiaofeng.yan <yanxiaofeng(a)inspur.com>
> ---
>  drivers/acpi/acpica/nsdumpdv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> =

> diff --git a/drivers/acpi/acpica/nsdumpdv.c
> b/drivers/acpi/acpica/nsdumpdv.c index 7dc367e..1af1af7 100644
> --- a/drivers/acpi/acpica/nsdumpdv.c
> +++ b/drivers/acpi/acpica/nsdumpdv.c
> @@ -89,7 +89,7 @@ acpi_ns_dump_one_device(acpi_handle obj_handle,
> =

>  		ACPI_DEBUG_PRINT_RAW((ACPI_DB_TABLES,
>  				      "    HID: %s, ADR: %8.8X%8.8X, Status:
> %X\n",
> -				      info->hardware_id.value,
> +				      info->hardware_id.string,
>  				      ACPI_FORMAT_UINT64(info->address),
>  				      info->current_status));
>  		ACPI_FREE(info);
> --
> 1.9.1
> =



--===============5532247489766802408==--

