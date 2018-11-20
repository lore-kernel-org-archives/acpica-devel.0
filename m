Content-Type: multipart/mixed; boundary="===============8879622316294367786=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rjw at rjwysocki.net>
Subject: Re: [Devel] [PATCH 4.20 regression fix] ACPICA: Fix handling of
 buffer-size in acpi_ex_write_data_to_field()
Date: Tue, 20 Nov 2018 23:03:00 +0100
Message-ID: <2796424.HnM8AfaMEo@aspire.rjw.lan>
In-Reply-To: 20181118192535.13052-1-hdegoede@redhat.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============8879622316294367786==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Sunday, November 18, 2018 8:25:35 PM CET Hans de Goede wrote:
> Generic Serial Bus transfers use a data struct like this:
> =

> struct gsb_buffer {
>         u8      status;
>         u8      len;
>         u8      data[0];
> };
> =

> acpi_ex_write_data_to_field() copies the data which is to be written from
> the source-buffer to a temp-buffer. This is done because the OpReg-handler
> overwrites the status field and some transfers do a write + read-back.
> =

> Commit f99b89eefeb6 ("ACPICA: Update for generic_serial_bus and
> attrib_raw_process_bytes protocol") acpi_ex_write_data_to_field()
> introduces a number of problems with this:
> =

> 1) It drops a "length +=3D 2" statement used to calculate the temp-buffer
> size causing the temp-buffer to only be 1/2 bytes large for byte/word
> transfers while it should be 3/4 bytes (taking the status and len field
> into account). This is already fixed in commit e324e10109fc ("ACPICA:
> Update for field unit access") which refactors the code.
> =

> The ACPI 6.0 spec (ACPI_6.0.pdf) "5.5.2.4.5.2 Declaring and Using a
> GenericSerialBusData Buffer" (page 232) states that the GenericSerialBus
> Data Buffer Length field is only valid when doing a Read/Write Block
> (AttribBlock) transfer, but since the troublesome commit we unconditional=
ly
> use the len field to determine how much data to copy from the source-buff=
er
> into the temp-buffer passed to the OpRegion.
> =

> This causes 3 further issues:
> =

> 2) This may lead to not copying enough data to the temp-buffer causing the
> OpRegion handler for the serial-bus to write garbage to the hardware.
> =

> 3) The temp-buffer passed to the OpRegion is allocated to the size
> returned by acpi_ex_get_serial_access_length(), which may be as little
> as 1, so potentially this may lead to a write overflow of the temp-buffer.
> =

> 4) Commit e324e10109fc ("ACPICA: Update for field unit access") drops a
> length check on the source-buffer, leading to a potential read overflow
> of the source-buffer.
> =

> This commit fixes all 3 remaining issues by not looking at the len field =
at
> all (the interpretation of this field is left up to the OpRegion handler),
> and copying the minimum of the source- and temp-buffer sizes from the
> source-buffer to the temp-buffer.
> =

> This fixes e.g. an Acer S1003 no longer booting since the troublesome
> commit.
> =

> Fixes: f99b89eefeb6 ("ACPICA: Update for generic_serial_bus and ...")
> Fixes: e324e10109fc ("ACPICA: Update for field unit access")
> Cc: Bob Moore <robert.moore(a)intel.com>
> Cc: Erik Schmauss <erik.schmauss(a)intel.com>
> Signed-off-by: Hans de Goede <hdegoede(a)redhat.com>
> ---
> I know that normally ACPICA patches go upstream through ACPICA upstream,
> but since this is a somewhat nasty regression, I'm submitting it directly
> to the ACPI subsys.
> ---
>  drivers/acpi/acpica/exserial.c | 21 ++-------------------
>  1 file changed, 2 insertions(+), 19 deletions(-)
> =

> diff --git a/drivers/acpi/acpica/exserial.c b/drivers/acpi/acpica/exseria=
l.c
> index 0d42f30e5b25..9920fac6413f 100644
> --- a/drivers/acpi/acpica/exserial.c
> +++ b/drivers/acpi/acpica/exserial.c
> @@ -244,7 +244,6 @@ acpi_ex_write_serial_bus(union acpi_operand_object *s=
ource_desc,
>  {
>  	acpi_status status;
>  	u32 buffer_length;
> -	u32 data_length;
>  	void *buffer;
>  	union acpi_operand_object *buffer_desc;
>  	u32 function;
> @@ -282,14 +281,12 @@ acpi_ex_write_serial_bus(union acpi_operand_object =
*source_desc,
>  	case ACPI_ADR_SPACE_SMBUS:
>  =

>  		buffer_length =3D ACPI_SMBUS_BUFFER_SIZE;
> -		data_length =3D ACPI_SMBUS_DATA_SIZE;
>  		function =3D ACPI_WRITE | (obj_desc->field.attribute << 16);
>  		break;
>  =

>  	case ACPI_ADR_SPACE_IPMI:
>  =

>  		buffer_length =3D ACPI_IPMI_BUFFER_SIZE;
> -		data_length =3D ACPI_IPMI_DATA_SIZE;
>  		function =3D ACPI_WRITE;
>  		break;
>  =

> @@ -310,7 +307,6 @@ acpi_ex_write_serial_bus(union acpi_operand_object *s=
ource_desc,
>  		/* Add header length to get the full size of the buffer */
>  =

>  		buffer_length +=3D ACPI_SERIAL_HEADER_SIZE;
> -		data_length =3D source_desc->buffer.pointer[1];
>  		function =3D ACPI_WRITE | (accessor_type << 16);
>  		break;
>  =

> @@ -318,20 +314,6 @@ acpi_ex_write_serial_bus(union acpi_operand_object *=
source_desc,
>  		return_ACPI_STATUS(AE_AML_INVALID_SPACE_ID);
>  	}
>  =

> -#if 0
> -	OBSOLETE ?
> -	    /* Check for possible buffer overflow */
> -	    if (data_length > source_desc->buffer.length) {
> -		ACPI_ERROR((AE_INFO,
> -			    "Length in buffer header (%u)(%u) is greater than "
> -			    "the physical buffer length (%u) and will overflow",
> -			    data_length, buffer_length,
> -			    source_desc->buffer.length));
> -
> -		return_ACPI_STATUS(AE_AML_BUFFER_LIMIT);
> -	}
> -#endif
> -
>  	/* Create the transfer/bidirectional/return buffer */
>  =

>  	buffer_desc =3D acpi_ut_create_buffer_object(buffer_length);
> @@ -342,7 +324,8 @@ acpi_ex_write_serial_bus(union acpi_operand_object *s=
ource_desc,
>  	/* Copy the input buffer data to the transfer buffer */
>  =

>  	buffer =3D buffer_desc->buffer.pointer;
> -	memcpy(buffer, source_desc->buffer.pointer, data_length);
> +	memcpy(buffer, source_desc->buffer.pointer,
> +	       min(buffer_length, source_desc->buffer.length));
>  =

>  	/* Lock entire transaction if requested */
>  =

> =


I've queued this up, but I would like Bob and Erik to speak up too.

A boot crash is a good enough reason for doing a quick fix for 4.20, but it
may be necessary to do something less straightforward long term.

Thanks,
Rafael



--===============8879622316294367786==--

