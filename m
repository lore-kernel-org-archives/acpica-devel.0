Content-Type: multipart/mixed; boundary="===============2279665907848428638=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: Re: [Devel] [PATCH] ACPI: SPCR: Use access width to determine mmio
 usage
Date: Thu, 04 May 2017 16:28:23 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37E597D3A@ORSMSX110.amr.corp.intel.com>
In-Reply-To: 1493910330-17913-1-git-send-email-jon.mason@broadcom.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============2279665907848428638==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Jon,

You might want to take a look at using the acpi_read and acpi_write ACPICA =
interfaces that accept a GAS structure and handle the access width (etc.) a=
utomatically.

Bob


> -----Original Message-----
> From: Jon Mason [mailto:jon.mason(a)broadcom.com]
> Sent: Thursday, May 4, 2017 8:06 AM
> To: Rafael Wysocki <rjw(a)rjwysocki.net>; Len Brown <lenb(a)kernel.org>;
> Moore, Robert <robert.moore(a)intel.com>; Zheng, Lv <lv.zheng(a)intel.com>
> Cc: linux-acpi(a)vger.kernel.org; linux-kernel(a)vger.kernel.org;
> devel(a)acpica.org; bcm-kernel-feedback-list(a)broadcom.com
> Subject: [PATCH] ACPI: SPCR: Use access width to determine mmio usage
> =

> The current SPCR code does not check the access width of the mmio, and
> uses a default of 8bit register accesses.  This prevents devices that
> only do 16 or 32bit register accesses from working.  By simply checking
> this field and setting the mmio string appropriately, this issue can be
> corrected.  To prevent any legacy issues, the code will default to 8bit
> accesses if the value is anything but 16 or 32.
> =

> Signed-off-by: Jon Mason <jon.mason(a)broadcom.com>
> ---
>  drivers/acpi/spcr.c     | 18 ++++++++++++++++--
>  include/acpi/acrestyp.h |  7 +++++++
>  2 files changed, 23 insertions(+), 2 deletions(-)
> =

> diff --git a/drivers/acpi/spcr.c b/drivers/acpi/spcr.c index
> 01c9466..11233f6 100644
> --- a/drivers/acpi/spcr.c
> +++ b/drivers/acpi/spcr.c
> @@ -74,8 +74,22 @@ int __init parse_spcr(bool earlycon)
>  		goto done;
>  	}
> =

> -	iotype =3D table->serial_port.space_id =3D=3D
> ACPI_ADR_SPACE_SYSTEM_MEMORY ?
> -			"mmio" : "io";
> +	if (table->serial_port.space_id =3D=3D ACPI_ADR_SPACE_SYSTEM_MEMORY) {
> +		switch (table->serial_port.access_width) {
> +		default:
> +			pr_err("Unexpected SPCR Access Width.  Defaulting to
> byte size\n");
> +		case ACPI_ACCESS_SIZE_BYTE:
> +			iotype =3D "mmio";
> +			break;
> +		case ACPI_ACCESS_SIZE_WORD:
> +			iotype =3D "mmio16";
> +			break;
> +		case ACPI_ACCESS_SIZE_DWORD:
> +			iotype =3D "mmio32";
> +			break;
> +		}
> +	} else
> +		iotype =3D "io";
> =

>  	switch (table->interface_type) {
>  	case ACPI_DBG2_ARM_SBSA_32BIT:
> diff --git a/include/acpi/acrestyp.h b/include/acpi/acrestyp.h index
> f0f7403..781cb55 100644
> --- a/include/acpi/acrestyp.h
> +++ b/include/acpi/acrestyp.h
> @@ -372,6 +372,13 @@ struct acpi_resource_generic_register {
>  	u64 address;
>  };
> =

> +/* Generic Address Space Access Sizes */
> +#define ACPI_ACCESS_SIZE_UNDEFINED		0
> +#define ACPI_ACCESS_SIZE_BYTE			1
> +#define ACPI_ACCESS_SIZE_WORD			2
> +#define ACPI_ACCESS_SIZE_DWORD			3
> +#define ACPI_ACCESS_SIZE_QWORD			4
> +
>  struct acpi_resource_gpio {
>  	u8 revision_id;
>  	u8 connection_type;
> --
> 2.7.4


--===============2279665907848428638==--

