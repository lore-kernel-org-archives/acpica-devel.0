Content-Type: multipart/mixed; boundary="===============6955027474222281976=="
MIME-Version: 1.0
From: Zheng, Lv <lv.zheng at intel.com>
Subject: Re: [Devel] [PATCH] iasl:iort fix the incorrect MappingOffset value
 for ITS group
Date: Tue, 30 Aug 2016 07:52:09 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E886A179768@SHSMSX101.ccr.corp.intel.com>
In-Reply-To: 1472462176-19666-1-git-send-email-dennis.chen@arm.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============6955027474222281976==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

> From: Dennis Chen [mailto:dennis.chen(a)arm.com]
> Subject: [PATCH] iasl:iort fix the incorrect MappingOffset value for ITS =
group
> =

> According to the IORT spec[1], the *Mapping Offset* field of the
> ITS group node is always 0 since there isn't ID mapping for this kind
> of node. Current iasl codes will assign a wrong value for this field,
> for instance, below is an IORT ITS group node data segment created
> by existing iasl tool:
> =

> [031h 0049   1]                         Type : 00
> [032h 0050   2]                       Length : 001C
> [034h 0052   1]                     Revision : 00
> [035h 0053   4]                     Reserved : 00000000
> [039h 0057   4]                Mapping Count : 00000000
> [03Dh 0061   4]               Mapping Offset : 0000001C
> =

> [041h 0065   4]                     ItsCount : 00000002
> [045h 0069   4]                  Identifiers : 00000000
> [049h 0073   4]                  Identifiers : 00000001
> =

> We can see from above that the *Mapping Offset* has been assigned the
> value 0x1C while not 0x0.

What kind of real issue can be caused by this value?

> After applied this patch, the new data segment
> generated will be:
> =

> [031h 0049   1]                         Type : 00
> [032h 0050   2]                       Length : 001C
> [034h 0052   1]                     Revision : 00
> [035h 0053   4]                     Reserved : 00000000
> [039h 0057   4]                Mapping Count : 00000000
> [03Dh 0061   4]               Mapping Offset : 00000000
> =

> [041h 0065   4]                     ItsCount : 00000002
> [045h 0069   4]                  Identifiers : 00000000
> [049h 0073   4]                  Identifiers : 00000001
> =

> Notice that the *Mapping Offset* filed has been set the correct value acc=
ording
> to the spec.
> =

> [1]http://infocenter.arm.com/help/topic/com.arm.doc.den0049b/DEN0049B_IO_=
Remapping_Table.pdf
> =

> Signed-off-by: Dennis Chen <dennis.chen(a)arm.com>
> Cc: Lv Zheng <lv.zheng(a)intel.com>
> Cc: Robert Moore <robert.moore(a)intel.com>
> ---
>  source/compiler/dttable1.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> =

> diff --git a/source/compiler/dttable1.c b/source/compiler/dttable1.c
> index cacd9de..a620dcc 100644
> --- a/source/compiler/dttable1.c
> +++ b/source/compiler/dttable1.c
> @@ -1568,7 +1568,10 @@ DtCompileIort (
> =

>          /* Compile Array of ID mappings */
> =

> -        IortNode->MappingOffset =3D NodeLength;
> +	/* For ITS group node, the MappingOffset field is always 0 */
> +	if (IortNode->Type !=3D ACPI_IORT_NODE_ITS_GROUP)
> +		IortNode->MappingOffset =3D NodeLength;
> +

You have coding style issues here:
1. No tab in ACPICA upstream, you need to use 4 spaces.
2. For single line comment, you need to put an empty line before/after it.

>          IdMappingNumber =3D 0;
>          while (*PFieldList)
>          {

IMO, the better fix should be relying on (IdMappingNumber =3D=3D 0),
Rather than relying on (IortNode->Type !=3D ACPI_IORT_NODE_ITS_GROUP).

Thanks
Lv

--===============6955027474222281976==--

