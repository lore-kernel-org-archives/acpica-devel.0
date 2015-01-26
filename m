Content-Type: multipart/mixed; boundary="===============7754349111768455464=="
MIME-Version: 1.0
From: Zheng, Lv <lv.zheng at intel.com>
Subject: Re: [Devel] [RFC PATCH] ACPICA: Resources: Provide common part for
 struct acpi_resource_address structures.
Date: Mon, 26 Jan 2015 01:35:23 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E88026BA945@SHSMSX101.ccr.corp.intel.com>
In-Reply-To: 711042903.kTarCpRk9E@vostro.rjw.lan
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============7754349111768455464==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi, Rafael

> -----Original Message-----
> From: Rafael J. Wysocki [mailto:rjw(a)rjwysocki.net]
> Sent: Friday, January 23, 2015 11:21 PM
> To: Zheng, Lv
> Cc: Liu, Jiang; Thomas Gleixner (tglx(a)linutronix.de); Wysocki, Rafael J=
; Brown, Len; Moore, Robert; Box, David E; Lv Zheng; linux-
> acpi(a)vger.kernel.org; devel(a)acpica.org
> Subject: Re: [RFC PATCH] ACPICA: Resources: Provide common part for struc=
t acpi_resource_address structures.
> =

> On Friday, January 23, 2015 02:21:30 AM Zheng, Lv wrote:
> > Hi, Rafael
> >
> > > From: Rafael J. Wysocki [mailto:rjw(a)rjwysocki.net]
> > > Sent: Friday, January 23, 2015 6:50 AM
> > >
> > > On Thursday, January 22, 2015 10:46:00 AM Lv Zheng wrote:
> > > > struct acpi_resource_address and struct acpi_resource_extended_addr=
ess64 share substracts
> > > > just at different offsets. To unify the parsing functions, OSPMs li=
ke Linux
> > > > need a new ACPI_ADDRESS64_ATTRIBUTE as their substructs, so they can
> > > > extract the shared data.
> > >
> > > Looks OK to me.
> >
> > Could you help to ship it with linux-next directly so that Gerry can re=
-base
> > his patchset on top of linux-next using this change?
> > I'll take care of remove this patch from ACPICA release cycle.
> =

> So do you want me to apply this one directly?  I can do that.

I noticed that this RFC is just a Linuxized ACPICA commit.
Let me sync the structure changes with Linux code base and re-send it.

Thanks and best regards
-Lv

> =

> =

> > > > Original-by: Thomas Gleixner <tglx(a)linutronix.de>
> > > > Original-by: Jiang Liu <jiang.liu(a)linux.intel.com>
> > > > Signed-off-by: Lv Zheng <lv.zheng(a)intel.com>
> > > > ---
> > > >  drivers/acpi/acpica/rsaddr.c     |    9 +++---
> > > >  drivers/acpi/acpica/rsdumpinfo.c |   59 +++++++++++++++++++-------=
------------
> > > >  drivers/acpi/acpica/rsxface.c    |   10 +++----
> > > >  include/acpi/acrestyp.h          |   40 +++++++++++++++-----------
> > > >  4 files changed, 64 insertions(+), 54 deletions(-)
> > > >
> > > > diff --git a/drivers/acpi/acpica/rsaddr.c b/drivers/acpi/acpica/rsa=
ddr.c
> > > > index 916fd09..94a3a05 100644
> > > > --- a/drivers/acpi/acpica/rsaddr.c
> > > > +++ b/drivers/acpi/acpica/rsaddr.c
> > > > @@ -74,7 +74,7 @@ struct acpi_rsconvert_info acpi_rs_convert_addres=
s16[5] =3D {
> > > >  	 * Address Translation Offset
> > > >  	 * Address Length
> > > >  	 */
> > > > -	{ACPI_RSC_MOVE16, ACPI_RS_OFFSET(data.address16.granularity),
> > > > +	{ACPI_RSC_MOVE16, ACPI_RS_OFFSET(data.address16.address.granulari=
ty),
> > > >  	 AML_OFFSET(address16.granularity),
> > > >  	 5},
> > > >
> > > > @@ -112,7 +112,7 @@ struct acpi_rsconvert_info acpi_rs_convert_addr=
ess32[5] =3D {
> > > >  	 * Address Translation Offset
> > > >  	 * Address Length
> > > >  	 */
> > > > -	{ACPI_RSC_MOVE32, ACPI_RS_OFFSET(data.address32.granularity),
> > > > +	{ACPI_RSC_MOVE32, ACPI_RS_OFFSET(data.address32.address.granulari=
ty),
> > > >  	 AML_OFFSET(address32.granularity),
> > > >  	 5},
> > > >
> > > > @@ -150,7 +150,7 @@ struct acpi_rsconvert_info acpi_rs_convert_addr=
ess64[5] =3D {
> > > >  	 * Address Translation Offset
> > > >  	 * Address Length
> > > >  	 */
> > > > -	{ACPI_RSC_MOVE64, ACPI_RS_OFFSET(data.address64.granularity),
> > > > +	{ACPI_RSC_MOVE64, ACPI_RS_OFFSET(data.address64.address.granulari=
ty),
> > > >  	 AML_OFFSET(address64.granularity),
> > > >  	 5},
> > > >
> > > > @@ -194,7 +194,8 @@ struct acpi_rsconvert_info acpi_rs_convert_ext_=
address64[5] =3D {
> > > >  	 * Address Length
> > > >  	 * Type-Specific Attribute
> > > >  	 */
> > > > -	{ACPI_RSC_MOVE64, ACPI_RS_OFFSET(data.ext_address64.granularity),
> > > > +	{ACPI_RSC_MOVE64,
> > > > +	 ACPI_RS_OFFSET(data.ext_address64.address.granularity),
> > > >  	 AML_OFFSET(ext_address64.granularity),
> > > >  	 6}
> > > >  };
> > > > diff --git a/drivers/acpi/acpica/rsdumpinfo.c b/drivers/acpi/acpica=
/rsdumpinfo.c
> > > > index 2f9332d..6ba7ad5 100644
> > > > --- a/drivers/acpi/acpica/rsdumpinfo.c
> > > > +++ b/drivers/acpi/acpica/rsdumpinfo.c
> > > > @@ -183,15 +183,15 @@ struct acpi_rsdump_info acpi_rs_dump_address1=
6[8] =3D {
> > > >  	{ACPI_RSD_TITLE, ACPI_RSD_TABLE_SIZE(acpi_rs_dump_address16),
> > > >  	 "16-Bit WORD Address Space", NULL},
> > > >  	{ACPI_RSD_ADDRESS, 0, NULL, NULL},
> > > > -	{ACPI_RSD_UINT16, ACPI_RSD_OFFSET(address16.granularity), "Granul=
arity",
> > > > -	 NULL},
> > > > -	{ACPI_RSD_UINT16, ACPI_RSD_OFFSET(address16.minimum), "Address Mi=
nimum",
> > > > -	 NULL},
> > > > -	{ACPI_RSD_UINT16, ACPI_RSD_OFFSET(address16.maximum), "Address Ma=
ximum",
> > > > -	 NULL},
> > > > -	{ACPI_RSD_UINT16, ACPI_RSD_OFFSET(address16.translation_offset),
> > > > +	{ACPI_RSD_UINT16, ACPI_RSD_OFFSET(address16.address.granularity),
> > > > +	 "Granularity", NULL},
> > > > +	{ACPI_RSD_UINT16, ACPI_RSD_OFFSET(address16.address.minimum),
> > > > +	 "Address Minimum", NULL},
> > > > +	{ACPI_RSD_UINT16, ACPI_RSD_OFFSET(address16.address.maximum),
> > > > +	 "Address Maximum", NULL},
> > > > +	{ACPI_RSD_UINT16, ACPI_RSD_OFFSET(address16.address.translation_o=
ffset),
> > > >  	 "Translation Offset", NULL},
> > > > -	{ACPI_RSD_UINT16, ACPI_RSD_OFFSET(address16.address_length),
> > > > +	{ACPI_RSD_UINT16, ACPI_RSD_OFFSET(address16.address.address_lengt=
h),
> > > >  	 "Address Length", NULL},
> > > >  	{ACPI_RSD_SOURCE, ACPI_RSD_OFFSET(address16.resource_source), NUL=
L, NULL}
> > > >  };
> > > > @@ -200,15 +200,15 @@ struct acpi_rsdump_info acpi_rs_dump_address3=
2[8] =3D {
> > > >  	{ACPI_RSD_TITLE, ACPI_RSD_TABLE_SIZE(acpi_rs_dump_address32),
> > > >  	 "32-Bit DWORD Address Space", NULL},
> > > >  	{ACPI_RSD_ADDRESS, 0, NULL, NULL},
> > > > -	{ACPI_RSD_UINT32, ACPI_RSD_OFFSET(address32.granularity), "Granul=
arity",
> > > > -	 NULL},
> > > > -	{ACPI_RSD_UINT32, ACPI_RSD_OFFSET(address32.minimum), "Address Mi=
nimum",
> > > > -	 NULL},
> > > > -	{ACPI_RSD_UINT32, ACPI_RSD_OFFSET(address32.maximum), "Address Ma=
ximum",
> > > > -	 NULL},
> > > > -	{ACPI_RSD_UINT32, ACPI_RSD_OFFSET(address32.translation_offset),
> > > > +	{ACPI_RSD_UINT32, ACPI_RSD_OFFSET(address32.address.granularity),
> > > > +	 "Granularity", NULL},
> > > > +	{ACPI_RSD_UINT32, ACPI_RSD_OFFSET(address32.address.minimum),
> > > > +	 "Address Minimum", NULL},
> > > > +	{ACPI_RSD_UINT32, ACPI_RSD_OFFSET(address32.address.maximum),
> > > > +	 "Address Maximum", NULL},
> > > > +	{ACPI_RSD_UINT32, ACPI_RSD_OFFSET(address32.address.translation_o=
ffset),
> > > >  	 "Translation Offset", NULL},
> > > > -	{ACPI_RSD_UINT32, ACPI_RSD_OFFSET(address32.address_length),
> > > > +	{ACPI_RSD_UINT32, ACPI_RSD_OFFSET(address32.address.address_lengt=
h),
> > > >  	 "Address Length", NULL},
> > > >  	{ACPI_RSD_SOURCE, ACPI_RSD_OFFSET(address32.resource_source), NUL=
L, NULL}
> > > >  };
> > > > @@ -217,15 +217,15 @@ struct acpi_rsdump_info acpi_rs_dump_address6=
4[8] =3D {
> > > >  	{ACPI_RSD_TITLE, ACPI_RSD_TABLE_SIZE(acpi_rs_dump_address64),
> > > >  	 "64-Bit QWORD Address Space", NULL},
> > > >  	{ACPI_RSD_ADDRESS, 0, NULL, NULL},
> > > > -	{ACPI_RSD_UINT64, ACPI_RSD_OFFSET(address64.granularity), "Granul=
arity",
> > > > -	 NULL},
> > > > -	{ACPI_RSD_UINT64, ACPI_RSD_OFFSET(address64.minimum), "Address Mi=
nimum",
> > > > -	 NULL},
> > > > -	{ACPI_RSD_UINT64, ACPI_RSD_OFFSET(address64.maximum), "Address Ma=
ximum",
> > > > -	 NULL},
> > > > -	{ACPI_RSD_UINT64, ACPI_RSD_OFFSET(address64.translation_offset),
> > > > +	{ACPI_RSD_UINT64, ACPI_RSD_OFFSET(address64.address.granularity),
> > > > +	 "Granularity", NULL},
> > > > +	{ACPI_RSD_UINT64, ACPI_RSD_OFFSET(address64.address.minimum),
> > > > +	 "Address Minimum", NULL},
> > > > +	{ACPI_RSD_UINT64, ACPI_RSD_OFFSET(address64.address.maximum),
> > > > +	 "Address Maximum", NULL},
> > > > +	{ACPI_RSD_UINT64, ACPI_RSD_OFFSET(address64.address.translation_o=
ffset),
> > > >  	 "Translation Offset", NULL},
> > > > -	{ACPI_RSD_UINT64, ACPI_RSD_OFFSET(address64.address_length),
> > > > +	{ACPI_RSD_UINT64, ACPI_RSD_OFFSET(address64.address.address_lengt=
h),
> > > >  	 "Address Length", NULL},
> > > >  	{ACPI_RSD_SOURCE, ACPI_RSD_OFFSET(address64.resource_source), NUL=
L, NULL}
> > > >  };
> > > > @@ -234,15 +234,16 @@ struct acpi_rsdump_info acpi_rs_dump_ext_addr=
ess64[8] =3D {
> > > >  	{ACPI_RSD_TITLE, ACPI_RSD_TABLE_SIZE(acpi_rs_dump_ext_address64),
> > > >  	 "64-Bit Extended Address Space", NULL},
> > > >  	{ACPI_RSD_ADDRESS, 0, NULL, NULL},
> > > > -	{ACPI_RSD_UINT64, ACPI_RSD_OFFSET(ext_address64.granularity),
> > > > +	{ACPI_RSD_UINT64, ACPI_RSD_OFFSET(ext_address64.address.granulari=
ty),
> > > >  	 "Granularity", NULL},
> > > > -	{ACPI_RSD_UINT64, ACPI_RSD_OFFSET(ext_address64.minimum),
> > > > +	{ACPI_RSD_UINT64, ACPI_RSD_OFFSET(ext_address64.address.minimum),
> > > >  	 "Address Minimum", NULL},
> > > > -	{ACPI_RSD_UINT64, ACPI_RSD_OFFSET(ext_address64.maximum),
> > > > +	{ACPI_RSD_UINT64, ACPI_RSD_OFFSET(ext_address64.address.maximum),
> > > >  	 "Address Maximum", NULL},
> > > > -	{ACPI_RSD_UINT64, ACPI_RSD_OFFSET(ext_address64.translation_offse=
t),
> > > > +	{ACPI_RSD_UINT64,
> > > > +	 ACPI_RSD_OFFSET(ext_address64.address.translation_offset),
> > > >  	 "Translation Offset", NULL},
> > > > -	{ACPI_RSD_UINT64, ACPI_RSD_OFFSET(ext_address64.address_length),
> > > > +	{ACPI_RSD_UINT64, ACPI_RSD_OFFSET(ext_address64.address.address_l=
ength),
> > > >  	 "Address Length", NULL},
> > > >  	{ACPI_RSD_UINT64, ACPI_RSD_OFFSET(ext_address64.type_specific),
> > > >  	 "Type-Specific Attribute", NULL}
> > > > diff --git a/drivers/acpi/acpica/rsxface.c b/drivers/acpi/acpica/rs=
xface.c
> > > > index 877ab92..2952878 100644
> > > > --- a/drivers/acpi/acpica/rsxface.c
> > > > +++ b/drivers/acpi/acpica/rsxface.c
> > > > @@ -60,11 +60,11 @@ ACPI_MODULE_NAME("rsxface")
> > > >  	ACPI_COPY_FIELD(out, in, min_address_fixed);         \
> > > >  	ACPI_COPY_FIELD(out, in, max_address_fixed);         \
> > > >  	ACPI_COPY_FIELD(out, in, info);                      \
> > > > -	ACPI_COPY_FIELD(out, in, granularity);               \
> > > > -	ACPI_COPY_FIELD(out, in, minimum);                   \
> > > > -	ACPI_COPY_FIELD(out, in, maximum);                   \
> > > > -	ACPI_COPY_FIELD(out, in, translation_offset);        \
> > > > -	ACPI_COPY_FIELD(out, in, address_length);            \
> > > > +	ACPI_COPY_FIELD(out, in, address.granularity);       \
> > > > +	ACPI_COPY_FIELD(out, in, address.minimum);           \
> > > > +	ACPI_COPY_FIELD(out, in, address.maximum);           \
> > > > +	ACPI_COPY_FIELD(out, in, address.translation_offset); \
> > > > +	ACPI_COPY_FIELD(out, in, address.address_length);    \
> > > >  	ACPI_COPY_FIELD(out, in, resource_source);
> > > >  /* Local prototypes */
> > > >  static acpi_status
> > > > diff --git a/include/acpi/acrestyp.h b/include/acpi/acrestyp.h
> > > > index eb760ca..023959d 100644
> > > > --- a/include/acpi/acrestyp.h
> > > > +++ b/include/acpi/acrestyp.h
> > > > @@ -305,43 +305,51 @@ struct acpi_resource_source {
> > > >  	u8                                      max_address_fixed; \
> > > >  	union acpi_resource_attribute           info;
> > > >
> > > > -struct acpi_resource_address {
> > > > -ACPI_RESOURCE_ADDRESS_COMMON};
> > > > -
> > > > -struct acpi_resource_address16 {
> > > > -	ACPI_RESOURCE_ADDRESS_COMMON u16 granularity;
> > > > +struct acpi_address16_attribute {
> > > > +	u16 granularity;
> > > >  	u16 minimum;
> > > >  	u16 maximum;
> > > >  	u16 translation_offset;
> > > >  	u16 address_length;
> > > > -	struct acpi_resource_source resource_source;
> > > >  };
> > > >
> > > > -struct acpi_resource_address32 {
> > > > -	ACPI_RESOURCE_ADDRESS_COMMON u32 granularity;
> > > > +struct acpi_address32_attribute {
> > > > +	u32 granularity;
> > > >  	u32 minimum;
> > > >  	u32 maximum;
> > > >  	u32 translation_offset;
> > > >  	u32 address_length;
> > > > -	struct acpi_resource_source resource_source;
> > > >  };
> > > >
> > > > -struct acpi_resource_address64 {
> > > > -	ACPI_RESOURCE_ADDRESS_COMMON u64 granularity;
> > > > +struct acpi_address64_attribute {
> > > > +	u64 granularity;
> > > >  	u64 minimum;
> > > >  	u64 maximum;
> > > >  	u64 translation_offset;
> > > >  	u64 address_length;
> > > > +};
> > > > +
> > > > +struct acpi_resource_address {
> > > > +ACPI_RESOURCE_ADDRESS_COMMON};
> > > > +
> > > > +struct acpi_resource_address16 {
> > > > +	ACPI_RESOURCE_ADDRESS_COMMON ACPI_ADDRESS16_ATTRIBUTE address;
> > > > +	struct acpi_resource_source resource_source;
> > > > +};
> > > > +
> > > > +struct acpi_resource_address32 {
> > > > +	ACPI_RESOURCE_ADDRESS_COMMON ACPI_ADDRESS32_ATTRIBUTE address;
> > > > +	struct acpi_resource_source resource_source;
> > > > +};
> > > > +
> > > > +struct acpi_resource_address64 {
> > > > +	ACPI_RESOURCE_ADDRESS_COMMON ACPI_ADDRESS64_ATTRIBUTE address;
> > > >  	struct acpi_resource_source resource_source;
> > > >  };
> > > >
> > > >  struct acpi_resource_extended_address64 {
> > > >  	ACPI_RESOURCE_ADDRESS_COMMON u8 revision_ID;
> > > > -	u64 granularity;
> > > > -	u64 minimum;
> > > > -	u64 maximum;
> > > > -	u64 translation_offset;
> > > > -	u64 address_length;
> > > > +	ACPI_ADDRESS64_ATTRIBUTE address;
> > > >  	u64 type_specific;
> > > >  };
> > > >
> > > >
> > >
> > > --
> > > I speak only for myself.
> > > Rafael J. Wysocki, Intel Open Source Technology Center.
> >
> =

> --
> I speak only for myself.
> Rafael J. Wysocki, Intel Open Source Technology Center.

--===============7754349111768455464==--

