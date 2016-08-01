Content-Type: multipart/mixed; boundary="===============6532407435337844625=="
MIME-Version: 1.0
From: Zheng, Lv <lv.zheng at intel.com>
Subject: Re: [Devel] [PATCH 1/2] ACPICA: adapt buffer length for Field Attrib
 Raw Process in Ops Region
Date: Mon, 01 Aug 2016 05:58:18 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E883BC0844E@SHSMSX101.ccr.corp.intel.com>
In-Reply-To: 1469807366-24642-2-git-send-email-benjamin.tissoires@redhat.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============6532407435337844625==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

> From: Benjamin Tissoires [mailto:benjamin.tissoires(a)redhat.com]
> Subject: [PATCH 1/2] ACPICA: adapt buffer length for Field Attrib Raw
> Process in Ops Region
> =

> Detected on the Surface 3:
> The MSHW0011 driver uses Field Attrib Raw Process to return information
> for the ACPI Battery. The DSDT declares a parameter of 2 though
> functions like _BST or _BIX require a much bigger out buffer.
> =

> It looks like the incoming buffer has the requested size and we can
> work around the issue by using this input size as the output and
> parameters size.
> =

> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D106231
> =

> Signed-off-by: Benjamin Tissoires <benjamin.tissoires(a)redhat.com>
> ---
>  drivers/acpi/acpica/exfield.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> =

> diff --git a/drivers/acpi/acpica/exfield.c b/drivers/acpi/acpica/exfield.c
> index d7d3ee3..a1bd041 100644
> --- a/drivers/acpi/acpica/exfield.c
> +++ b/drivers/acpi/acpica/exfield.c
> @@ -413,6 +413,17 @@ acpi_ex_write_data_to_field(union
> acpi_operand_object *source_desc,
>  			 *     Data[x-1]: (Bytes 2-x of the arbitrary length
> data buffer)
>  			 */
>  			length +=3D 2;
> +
> +			/*
> +			 * When using Field Attrib Raw Process, it looks like
> +			 * the parameter access_length can be wrong and
> the
> +			 * required output buffer can be much bigger.
> +			 * So just take the incoming buffer length as the
> +			 * reference.
> +			 */
> +			if (accessor_type =3D=3D
> AML_FIELD_ATTRIB_RAW_PROCESS)
> +				length =3D source_desc->buffer.length;
> +
[Lv Zheng] =

I think the related code is:

            OperationRegion (OR02, GenericSerialBus, Zero, 0x0100)
            Field (OR02, BufferAcc, NoLock, Preserve)
            {
                Connection (BX00), =

                AccessAs (BufferAcc, AttribRawProcessBytes (0x02)), =

                BB00,   8
            }
            Name (SPB0, Buffer (0x80) {})
            CreateByteField (SPB0, Zero, STA2)
            CreateByteField (SPB0, One, LEN0)
            CreateByteField (SPB0, 0x02, CMD0)
            CreateByteField (SPB0, 0x03, DAT0)
            CreateByteField (SPB0, 0x04, DAT1)
            CreateDWordField (SPB0, 0x05, DAT2)
            CreateField (SPB0, 0x10, 0x0320, DAT3)
            Method (RSPB, 3, NotSerialized)
            {
                CMD0 =3D One
                LEN0 =3D 0x08
                DAT0 =3D Arg0
                DAT1 =3D Arg1
                DAT2 =3D Arg2
                SPB0 =3D ^^I2Z1.BB00 =3D SPB0 /* \_SB_.BAT0.SPB0 */
                ...
            }
And we have confirmed that the iASL disassembly result is correct.

Then this issue is not a parser issue, but looks like an issue either in in=
terpreter or in BIOS as:

1. The following line triggers i2c operation region handlers:
    SPB0 =3D ^^I2Z1.BB00 =3D SPB0
    Where:
    SPB0 is sized as 0x80, BB00 is sized as 0x02.
    And in spec 19.6.1 AccessAs (Change Field Unit Access), it is said that=
 AttribRawProcessBytes(AccessLength) requires an AccessLength parameter.
    However in this case, the length of the output buffer is not correct, m=
uch smaller than the container buffer.
    So this firstly looks like a BIOS issue. And then needn't be fixed in O=
S.
2. If this is not a BIOS bug but an interpreter bug, then SPB0 should be a =
buffer passing to the i2c region handler.
    The bug should be something related to "data type conversion".
    Please refer to:
    19.2.5.4 Implicit Source Operand Conversion
    19.2.5.5 Implicit Result Object Conversion
    It looks like that we have troubles in either 1st Store or 2nd Store.
    If so, it seems we shouldn't fix this issue here. And thus this fix als=
o looks invalid.

IMO (may be wrong), this bug finally may cause dissension among different p=
arties (BIOS, Windows, ACPICA, spec).

However, for the time being, is that possible to work this issue around in =
the i2c operation region driver?

Thanks and best regards
-Lv


>  			function =3D ACPI_WRITE | (accessor_type << 16);
>  		} else {	/* IPMI */
> =

> --
> 2.5.5


--===============6532407435337844625==--

