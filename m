Content-Type: multipart/mixed; boundary="===============5522515545591914358=="
MIME-Version: 1.0
From: Joey Lee <jlee at suse.com>
Subject: Re: [Devel] [PATCH 1/2] ACPICA: Introduce acpi_os_phys_table_override
 function
Date: Mon, 29 Aug 2011 02:24:25 -0600
Message-ID: <4E5BD9590200002300030F07@novprvlin0050.provo.novell.com>
In-Reply-To: 1314179290-31526-2-git-send-email-trenn@suse.de
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============5522515545591914358==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

=E6=96=BC =E4=B8=89=EF=BC=8C2011-08-24 =E6=96=BC 11:48 +0200=EF=BC=8CThomas=
 Renninger =E6=8F=90=E5=88=B0=EF=BC=9A
> Currently it's only possible to feed acpica with virtual
> address for table overriding.
> This patch introduces a function which allows the OS to
> pass physical addresses for table overriding.
> =

> This is necessary to allow early table overridings of
> arbitrary ACPI tables.
> =

> An extra flag like ACPI_TABLE_ORIGIN_OVERRIDE is not used,
> because physical address overriding is rather transparent
> (the same way acpica expects to get tables from reserved
> memory BIOS regions which is the normal way).
> =

> Signed-off-by: Thomas Renninger <trenn(a)suse.de>
> CC: devel(a)acpica.org
> CC: linux-acpi(a)vger.kernel.org
> CC: lenb(a)kernel.org
> ---

This patch works fine to me on Acer TravelMate 8572.

Tested-by: Lee, Chun-Yi <jlee(a)suse.com>


Thank's
Joey Lee

>  drivers/acpi/acpica/tbinstal.c |   15 +++++++++++++++
>  drivers/acpi/acpica/tbutils.c  |   18 +++++++++++++++++-
>  drivers/acpi/osl.c             |   11 +++++++++++
>  include/acpi/acpiosxf.h        |    4 ++++
>  4 files changed, 47 insertions(+), 1 deletions(-)
> =

> diff --git a/drivers/acpi/acpica/tbinstal.c b/drivers/acpi/acpica/tbinsta=
l.c
> index 62365f6..b9b9d2a 100644
> --- a/drivers/acpi/acpica/tbinstal.c
> +++ b/drivers/acpi/acpica/tbinstal.c
> @@ -242,6 +242,21 @@ acpi_tb_add_table(struct acpi_table_desc *table_desc=
, u32 *table_index)
>  		table_desc->pointer =3D override_table;
>  		table_desc->length =3D override_table->length;
>  		table_desc->flags =3D ACPI_TABLE_ORIGIN_OVERRIDE;
> +	} else {
> +		acpi_physical_address address =3D 0;
> +		u32 table_len =3D 0;
> +		status =3D acpi_os_phys_table_override(table_desc->pointer,
> +						     &address, &table_len);
> +		if (ACPI_SUCCESS(status) && table_len && address) {
> +			ACPI_INFO((AE_INFO, "%4.4s @ 0x%p "
> +				   "Phys table override, replaced with:",
> +				   table_desc->pointer->signature,
> +				   ACPI_CAST_PTR(void, table_desc->address)));
> +			table_desc->address =3D address;
> +			table_desc->pointer =3D acpi_os_map_memory(address,
> +								 table_len);
> +			table_desc->length =3D table_len;
> +		}
>  	}
>  =

>  	/* Add the table to the global root table list */
> diff --git a/drivers/acpi/acpica/tbutils.c b/drivers/acpi/acpica/tbutils.c
> index 0f2d395..df85afe 100644
> --- a/drivers/acpi/acpica/tbutils.c
> +++ b/drivers/acpi/acpica/tbutils.c
> @@ -499,8 +499,24 @@ acpi_tb_install_table(acpi_physical_address address,
>  		table_to_install =3D override_table;
>  		flags =3D ACPI_TABLE_ORIGIN_OVERRIDE;
>  	} else {
> -		table_to_install =3D mapped_table;
> +		u32 table_len =3D 0;
> +		acpi_physical_address tmp_addr =3D 0;
> +
> +		status =3D acpi_os_phys_table_override(mapped_table,
> +						     &tmp_addr, &table_len);
> +		if (ACPI_SUCCESS(status) && table_len && tmp_addr) {
> +			ACPI_INFO((AE_INFO, "%4.4s @ 0x%p "
> +				   "Phys table override, replaced with:",
> +				   mapped_table->signature,
> +				   ACPI_CAST_PTR(void, address)));
> +			acpi_os_unmap_memory(mapped_table,
> +					     sizeof(struct acpi_table_header));
> +			mapped_table =3D acpi_os_map_memory(address,
> +					  sizeof(struct acpi_table_header));
> +			address =3D tmp_addr;
> +		}
>  		flags =3D ACPI_TABLE_ORIGIN_MAPPED;
> +		table_to_install =3D mapped_table;
>  	}
>  =

>  	/* Initialize the table entry */
> diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
> index fa32f58..49b5fa6 100644
> --- a/drivers/acpi/osl.c
> +++ b/drivers/acpi/osl.c
> @@ -522,6 +522,17 @@ acpi_os_table_override(struct acpi_table_header * ex=
isting_table,
>  	return AE_OK;
>  }
>  =

> +acpi_status
> +acpi_os_phys_table_override(struct acpi_table_header *existing_table,
> +			    acpi_physical_address *address, u32 *table_length)
> +{
> +	if (!existing_table)
> +		return AE_BAD_PARAMETER;
> +
> +	table_length =3D 0;
> +	return AE_OK;
> +}
> +
>  static irqreturn_t acpi_irq(int irq, void *dev_id)
>  {
>  	u32 handled;
> diff --git a/include/acpi/acpiosxf.h b/include/acpi/acpiosxf.h
> index 4543b6f..0bef969 100644
> --- a/include/acpi/acpiosxf.h
> +++ b/include/acpi/acpiosxf.h
> @@ -95,6 +95,10 @@ acpi_status
>  acpi_os_table_override(struct acpi_table_header *existing_table,
>  		       struct acpi_table_header **new_table);
>  =

> +acpi_status
> +acpi_os_phys_table_override(struct acpi_table_header *existing_table,
> +			    acpi_physical_address *address, u32 *table_length);
> +
>  /*
>   * Spinlock primitives
>   */
> -- =

> 1.7.3.4
> =

> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo(a)vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/



--===============5522515545591914358==--

