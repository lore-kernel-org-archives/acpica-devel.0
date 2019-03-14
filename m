Content-Type: multipart/mixed; boundary="===============1335501473547764119=="
MIME-Version: 1.0
From: Schmauss, Erik <erik.schmauss at intel.com>
Subject: Re: [Devel] PROBLEM: Calling ObjectType on buffer field reports type
 integer
Date: Thu, 14 Mar 2019 17:19:07 +0000
Message-ID: <CF6A88132359CE47947DB4C6E1709ED53C592D47@ORSMSX122.amr.corp.intel.com>
In-Reply-To: 3ef42aa1-196d-f3db-0e5d-2fd84c198242@gmail.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============1335501473547764119==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



> -----Original Message-----
> From: Maximilian Luz [mailto:luzmaximilian(a)gmail.com]
> Sent: Thursday, March 14, 2019 7:24 AM
> To: Moore, Robert <robert.moore(a)intel.com>; Schmauss, Erik
> <erik.schmauss(a)intel.com>; Wysocki, Rafael J
> <rafael.j.wysocki(a)intel.com>
> Cc: linux-acpi(a)vger.kernel.org; devel(a)acpica.org
> Subject: PROBLEM: Calling ObjectType on buffer field reports type
> integer
> =

> Hi all,
> =

> it seems that buffer fields (created via CreateField) are incorrectly
> reported as being of type integer (via ObjectType) when they are small
> enough to allow for that.
> =

> As far as I know all kernel versions are affected by this, I have
> specifically checked 5.0 (5.0.2), 4.20, 4.19 and 4.18.
> =

> In more detail: On the Microsoft Surface Book 2, Surface Pro (2017),
> Surface Pro 6, Surface Laptop and Surface Laptop 2 devices there is the
> following piece of AML code:
> =

>      Local0 =3D ^^_SAN.RQST (0x02, One, One, Zero, One)
>      If ((ObjectType (Local0) !=3D 0x03))
>      {
>          // Error path
>      }
>      Else
>      {
>          // Success path
>      }
> =

> Which executes a command (RQST) and then checks the type of the
> returned field to determine if that command was successful (i.e.
> returned a buffer object) or failed (i.e. returned any other type,
> including integer). The buffer field that is being returned by RQST is
> crated as
> follows:
> =

>      CreateField (RQBF, 0x20, Local3, ARB)
>      Local4 =3D ARB /* \_SB_._SAN.RQSX.ARB_ */
>      ...
>      Return (Local4)
> =

> If the returned buffer field is small enough (smaller than
> acpi_gbl_integer_byte_width), the error-path will always be executed.
> =

> The full DSDT for the Surface Book 2 can be found here:
> https://github.com/qzed/surfacebook2-
> dsdt/blob/fa0ca7c7cba8fb0da1e79c282f9a9f4a12eaaa17/dsdt.dsl#L153
> 96
> =

> I have attached a patch (for 5.0) that fixes this issue and has been in
> use on the affected devices for a few months now via
> =

>      https://github.com/qzed/linux-surfacegen5-acpi and
>      https://github.com/jakeday/linux-surface/
> =

> I'm not aware of any issues regarding the patch, but then again this
> has, to my knowledge, only been tested on Microsoft Surface devices.

I'll take a look at this and test the behavior on windows OS. Surface lapto=
ps
tend to have interesting firmware that expose these differences.

Erik
> =

> Maximilian
> =

> Signed-off-by: Maximilian Luz <luzmaximilian(a)gmail.com>
> ---
>   drivers/acpi/acpica/dsopcode.c |  2 +-
>   drivers/acpi/acpica/exfield.c  | 12 +++++++++---
>   2 files changed, 10 insertions(+), 4 deletions(-)
> =

> diff --git a/drivers/acpi/acpica/dsopcode.c
> b/drivers/acpi/acpica/dsopcode.c index 78f9de260d5f..0cd858520f5b
> 100644
> --- a/drivers/acpi/acpica/dsopcode.c
> +++ b/drivers/acpi/acpica/dsopcode.c
> @@ -123,7 +123,7 @@ acpi_ds_init_buffer_field(u16 aml_opcode,
> =

>   		/* Offset is in bits, count is in bits */
> =

> -		field_flags =3D AML_FIELD_ACCESS_BYTE;
> +		field_flags =3D AML_FIELD_ACCESS_BUFFER;
>   		bit_offset =3D offset;
>   		bit_count =3D (u32) length_desc->integer.value;
> =

> diff --git a/drivers/acpi/acpica/exfield.c b/drivers/acpi/acpica/exfield.c
> index e5798f15793a..55abd9e035a0 100644
> --- a/drivers/acpi/acpica/exfield.c
> +++ b/drivers/acpi/acpica/exfield.c
> @@ -98,6 +98,7 @@ acpi_ex_read_data_from_field(struct
> acpi_walk_state *walk_state,
>   	union acpi_operand_object *buffer_desc;
>   	void *buffer;
>   	u32 buffer_length;
> +	u8 field_flags;
> =

>   	ACPI_FUNCTION_TRACE_PTR(ex_read_data_from_field,
> obj_desc);
> =

> @@ -146,11 +147,16 @@ acpi_ex_read_data_from_field(struct
> acpi_walk_state *walk_state,
>   	 * Note: Field.length is in bits.
>   	 */
>   	buffer_length =3D
> -	    (acpi_size)ACPI_ROUND_BITS_UP_TO_BYTES(obj_desc-
> >field.bit_length);
> +	    (acpi_size)ACPI_ROUND_BITS_UP_TO_BYTES(obj_desc-
> >common_field.bit_length);
> +	field_flags =3D obj_desc->common_field.field_flags;
> =

> -	if (buffer_length > acpi_gbl_integer_byte_width) {
> +	if (buffer_length > acpi_gbl_integer_byte_width ||
> +	    (field_flags & AML_FIELD_ACCESS_TYPE_MASK) =3D=3D
> +AML_FIELD_ACCESS_BUFFER) {
> =

> -		/* Field is too large for an Integer, create a Buffer
> instead */
> +		/*
> +		 * Field is either too large for an Integer, or a actually of
> type
> +		 * buffer, so create a Buffer.
> +		 */
> =

>   		buffer_desc =3D
> acpi_ut_create_buffer_object(buffer_length);
>   		if (!buffer_desc) {
> --
> 2.20.1
> =



--===============1335501473547764119==--

