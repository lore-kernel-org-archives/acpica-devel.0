Content-Type: multipart/mixed; boundary="===============8287225612184512283=="
MIME-Version: 1.0
From: Colin Ian King <colin.king at canonical.com>
Subject: [Devel] Re: [PATCH] trivial: acpi: replace some bitshifts with BIT
 macro
Date: Fri, 24 Jul 2020 17:40:15 +0100
Message-ID: <8fc15ffe-9df7-d1f2-2e6a-194f6e8368cc@canonical.com>
In-Reply-To: BYAPR11MB325604ACC5F3BCCEB89A58AA87770@BYAPR11MB3256.namprd11.prod.outlook.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============8287225612184512283==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 24/07/2020 17:29, Moore, Robert wrote:
> Where is "BIT" defined?

this is a linux macro, currently in include/vdso.bits.h, see also
linux/bits.h for the BIT_ULL() unsigned long long variant too.

> =

> =

> -----Original Message-----
> From: Garrit Franke <garritfranke(a)gmail.com> =

> Sent: Friday, July 24, 2020 9:21 AM
> To: Moore, Robert <robert.moore(a)intel.com>; Wysocki, Rafael J <rafael.j=
.wysocki(a)intel.com>; lenb(a)kernel.org; trivial(a)kernel.org; linux-acpi(=
a)vger.kernel.org; devel(a)acpica.org; kernel-janitors(a)vger.kernel.org
> Cc: Garrit Franke <garritfranke(a)gmail.com>
> Subject: [PATCH] trivial: acpi: replace some bitshifts with BIT macro
> =

> Signed-off-by: Garrit Franke <garritfranke(a)gmail.com>
> ---
>  drivers/acpi/acpica/exfldio.c   | 2 +-
>  drivers/acpi/acpica/utownerid.c | 6 +++---
>  drivers/acpi/bus.c              | 2 +-
>  drivers/acpi/sleep.c            | 2 +-
>  4 files changed, 6 insertions(+), 6 deletions(-)
> =

> diff --git a/drivers/acpi/acpica/exfldio.c b/drivers/acpi/acpica/exfldio.=
c index ade35ff1c7..92fc702456 100644
> --- a/drivers/acpi/acpica/exfldio.c
> +++ b/drivers/acpi/acpica/exfldio.c
> @@ -298,7 +298,7 @@ acpi_ex_register_overflow(union acpi_operand_object *=
obj_desc, u64 value)
>  		return (FALSE);
>  	}
>  =

> -	if (value >=3D ((u64) 1 << obj_desc->common_field.bit_length)) {
> +	if (value >=3D ((u64) BIT(obj_desc->common_field.bit_length))) {
>  		/*
>  		 * The Value is larger than the maximum value that can fit into
>  		 * the register.
> diff --git a/drivers/acpi/acpica/utownerid.c b/drivers/acpi/acpica/utowne=
rid.c index d3525ef8ed..c4e2db2f54 100644
> --- a/drivers/acpi/acpica/utownerid.c
> +++ b/drivers/acpi/acpica/utownerid.c
> @@ -74,13 +74,13 @@ acpi_status acpi_ut_allocate_owner_id(acpi_owner_id *=
owner_id)
>  			 * int. Some compilers or runtime error detection may flag this as
>  			 * an error.
>  			 */
> -			if (!(acpi_gbl_owner_id_mask[j] & ((u32)1 << k))) {
> +			if (!(acpi_gbl_owner_id_mask[j] & (u32)BIT(k))) {
>  				/*
>  				 * Found a free ID. The actual ID is the bit index plus one,
>  				 * making zero an invalid Owner ID. Save this as the last ID
>  				 * allocated and update the global ID mask.
>  				 */
> -				acpi_gbl_owner_id_mask[j] |=3D ((u32)1 << k);
> +				acpi_gbl_owner_id_mask[j] |=3D (u32)BIT(k);
>  =

>  				acpi_gbl_last_owner_id_index =3D (u8)j;
>  				acpi_gbl_next_owner_id_offset =3D (u8)(k + 1); @@ -171,7 +171,7 @@ v=
oid acpi_ut_release_owner_id(acpi_owner_id *owner_id_ptr)
>  	/* Decode ID to index/offset pair */
>  =

>  	index =3D ACPI_DIV_32(owner_id);
> -	bit =3D (u32)1 << ACPI_MOD_32(owner_id);
> +	bit =3D (u32)BIT(ACPI_MOD_32(owner_id));
>  =

>  	/* Free the owner ID only if it is valid */
>  =

> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c index 54002670cb..39=
ead80c45 100644
> --- a/drivers/acpi/bus.c
> +++ b/drivers/acpi/bus.c
> @@ -233,7 +233,7 @@ acpi_status acpi_run_osc(acpi_handle handle, struct a=
cpi_osc_context *context)
>  		goto out_kfree;
>  	}
>  	/* Need to ignore the bit0 in result code */
> -	errors =3D *((u32 *)out_obj->buffer.pointer) & ~(1 << 0);
> +	errors =3D *((u32 *)out_obj->buffer.pointer) & BIT(0);
>  	if (errors) {
>  		if (errors & OSC_REQUEST_ERROR)
>  			acpi_print_osc_error(handle, context, diff --git a/drivers/acpi/sleep=
.c b/drivers/acpi/sleep.c index aff13bf4d9..38f5210313 100644
> --- a/drivers/acpi/sleep.c
> +++ b/drivers/acpi/sleep.c
> @@ -880,7 +880,7 @@ static void acpi_sleep_run_lps0_dsm(unsigned int func=
)  {
>  	union acpi_object *out_obj;
>  =

> -	if (!(lps0_dsm_func_mask & (1 << func)))
> +	if (!(lps0_dsm_func_mask & BIT(func)))
>  		return;
>  =

>  	out_obj =3D acpi_evaluate_dsm(lps0_device_handle, &lps0_dsm_guid, 1, fu=
nc, NULL);
> --
> 2.25.1
> _______________________________________________
> Devel mailing list -- devel(a)acpica.org
> To unsubscribe send an email to devel-leave(a)acpica.org
> %(web_page_url)slistinfo%(cgiext)s/%(_internal_name)s
>=20

--===============8287225612184512283==--

