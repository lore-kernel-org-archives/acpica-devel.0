Content-Type: multipart/mixed; boundary="===============7982983165777213508=="
MIME-Version: 1.0
From: Schmauss, Erik <erik.schmauss at intel.com>
Subject: Re: [Devel] [PATCH] ACPICA: make acpi_load_table() return table index
Date: Wed, 25 Sep 2019 18:13:34 +0000
Message-ID: <CF6A88132359CE47947DB4C6E1709ED53C646E97@ORSMSX122.amr.corp.intel.com>
In-Reply-To: 4929b1d2-c2a7-4efd-89e4-f02205e79c01@telfort.nl
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============7982983165777213508==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



> -----Original Message-----
> From: Ferry Toth <ftoth(a)telfort.nl>
> Sent: Thursday, September 12, 2019 12:37 PM
> To: Moore, Robert <robert.moore(a)intel.com>; Nikolaus Voss
> <nikolaus.voss(a)loewensteinmedical.de>; Shevchenko, Andriy
> <andriy.shevchenko(a)intel.com>; Schmauss, Erik <erik.schmauss(a)intel.co=
m>;
> Rafael J. Wysocki <rjw(a)rjwysocki.net>
> Cc: Len Brown <lenb(a)kernel.org>; Jacek Anaszewski
> <jacek.anaszewski(a)gmail.com>; Pavel Machek <pavel(a)ucw.cz>; Dan Murphy
> <dmurphy(a)ti.com>; linux-acpi(a)vger.kernel.org; devel(a)acpica.org; lin=
ux-
> kernel(a)vger.kernel.org; nv(a)vosn.de
> Subject: Re: [PATCH] ACPICA: make acpi_load_table() return table index
> =

> Op 12-09-19 om 16:19 schreef Moore, Robert:
> > Nikolaus,
> > The ability to unload an ACPI table (especially AML tables such as SSDT=
s) is in
> the process of being deprecated in ACPICA -- since it is also deprecated =
in the
> current ACPI specification. This is being done because of the difficulty =
of
> deleting the namespace entries for the table.  FYI, Windows does not prop=
erly
> support this function either.
> =

> I really hope this is not the case. On x86 loading/unloading SSDTs has pr=
oven to
> be a powerful way to handle reconfigurable hardware without rebooting and
> without requiring dedicated platform drivers. Same for user plugable hard=
ware
> on i2c/spi busses.
> =

> This has worked before and will violate the "don't break user space" rule.

If the table index wasn't being used, how did this work before?
Which commit broke this?

Bob and I are trying to understand if this is a regression or a new feature=
 request...

Thanks,
Erik
> =

> I don't see why Windows is an example to follow. On Windows platform driv=
ers
> don't get compiled into the kernel and don't need to be upstreamed.
> =

> > Bob
> >
> >
> > -----Original Message-----
> > From: Nikolaus Voss [mailto:nikolaus.voss(a)loewensteinmedical.de]
> > Sent: Thursday, September 12, 2019 1:08 AM
> > To: Shevchenko, Andriy <andriy.shevchenko(a)intel.com>; Schmauss, Erik
> > <erik.schmauss(a)intel.com>; Rafael J. Wysocki <rjw(a)rjwysocki.net>;
> > Moore, Robert <robert.moore(a)intel.com>
> > Cc: Len Brown <lenb(a)kernel.org>; Jacek Anaszewski
> > <jacek.anaszewski(a)gmail.com>; Pavel Machek <pavel(a)ucw.cz>; Dan Murp=
hy
> > <dmurphy(a)ti.com>; linux-acpi(a)vger.kernel.org; devel(a)acpica.org;
> > linux-kernel(a)vger.kernel.org; nv(a)vosn.de; Nikolaus Voss
> > <nikolaus.voss(a)loewensteinmedical.de>
> > Subject: [PATCH] ACPICA: make acpi_load_table() return table index
> >
> > For unloading an ACPI table, it is necessary to provide the index of th=
e table.
> The method intended for dynamically loading or hotplug addition of tables,
> acpi_load_table(), should provide this information via an optional pointe=
r to
> the loaded table index.
> >
> > This patch fixes the table unload function of acpi_configfs.
> >
> > Reported-by: Andy Shevchenko <andriy.shevchenko(a)linux.intel.com>
> > Fixes: d06c47e3dd07f ("ACPI: configfs: Resolve objects on
> > host-directed table loads")
> > Signed-off-by: Nikolaus Voss <nikolaus.voss(a)loewensteinmedical.de>
> > ---
> >   drivers/acpi/acpi_configfs.c   | 2 +-
> >   drivers/acpi/acpica/dbfileio.c | 2 +-
> >   drivers/acpi/acpica/tbxfload.c | 8 ++++++--
> >   drivers/firmware/efi/efi.c     | 2 +-
> >   include/acpi/acpixf.h          | 3 ++-
> >   5 files changed, 11 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/acpi/acpi_configfs.c
> > b/drivers/acpi/acpi_configfs.c index 57d9d574d4dde..77f81242a28e6
> > 100644
> > --- a/drivers/acpi/acpi_configfs.c
> > +++ b/drivers/acpi/acpi_configfs.c
> > @@ -53,7 +53,7 @@ static ssize_t acpi_table_aml_write(struct config_item
> *cfg,
> >   	if (!table->header)
> >   		return -ENOMEM;
> >
> > -	ret =3D acpi_load_table(table->header);
> > +	ret =3D acpi_load_table(table->header, &table->index);
> >   	if (ret) {
> >   		kfree(table->header);
> >   		table->header =3D NULL;
> > diff --git a/drivers/acpi/acpica/dbfileio.c
> > b/drivers/acpi/acpica/dbfileio.c index c6e25734dc5cd..e1b6e54a96ac1
> > 100644
> > --- a/drivers/acpi/acpica/dbfileio.c
> > +++ b/drivers/acpi/acpica/dbfileio.c
> > @@ -93,7 +93,7 @@ acpi_status acpi_db_load_tables(struct
> acpi_new_table_desc *list_head)
> >   	while (table_list_head) {
> >   		table =3D table_list_head->table;
> >
> > -		status =3D acpi_load_table(table);
> > +		status =3D acpi_load_table(table, NULL);
> >   		if (ACPI_FAILURE(status)) {
> >   			if (status =3D=3D AE_ALREADY_EXISTS) {
> >   				acpi_os_printf
> > diff --git a/drivers/acpi/acpica/tbxfload.c
> > b/drivers/acpi/acpica/tbxfload.c index 86f1693f6d29a..d08cd8ffcbdb6
> > 100644
> > --- a/drivers/acpi/acpica/tbxfload.c
> > +++ b/drivers/acpi/acpica/tbxfload.c
> > @@ -268,7 +268,8 @@ ACPI_EXPORT_SYMBOL_INIT(acpi_install_table)
> >    *
> >    * PARAMETERS:  table               - Pointer to a buffer containing =
the ACPI
> >    *                                    table to be loaded.
> > - *
> > + *              table_idx           - Pointer to a u32 for storing the=
 table
> > + *                                    index, might be NULL
> >    * RETURN:      Status
> >    *
> >    * DESCRIPTION: Dynamically load an ACPI table from the caller's buff=
er.
> Must @@ -278,7 +279,7 @@ ACPI_EXPORT_SYMBOL_INIT(acpi_install_table)
> >    *              to ensure that the table is not deleted or unmapped.
> >    *
> >
> >
> *******************************************************************
> ***
> > ********/ -acpi_status acpi_load_table(struct acpi_table_header
> > *table)
> > +acpi_status acpi_load_table(struct acpi_table_header *table, u32
> > +*table_idx)
> >   {
> >   	acpi_status status;
> >   	u32 table_index;
> > @@ -297,6 +298,9 @@ acpi_status acpi_load_table(struct acpi_table_header
> *table)
> >   	status =3D
> acpi_tb_install_and_load_table(ACPI_PTR_TO_PHYSADDR(table),
> >
> 	ACPI_TABLE_ORIGIN_EXTERNAL_VIRTUAL,
> >   						FALSE, &table_index);
> > +	if (table_idx)
> > +		*table_idx =3D table_index;
> > +
> >   	if (ACPI_SUCCESS(status)) {
> >
> >   		/* Complete the initialization/resolution of new objects */ diff
> > --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c index
> > ad3b1f4866b35..9773e4212baef 100644
> > --- a/drivers/firmware/efi/efi.c
> > +++ b/drivers/firmware/efi/efi.c
> > @@ -308,7 +308,7 @@ static __init int efivar_ssdt_load(void)
> >   			goto free_data;
> >   		}
> >
> > -		ret =3D acpi_load_table(data);
> > +		ret =3D acpi_load_table(data, NULL);
> >   		if (ret) {
> >   			pr_err("failed to load table: %d\n", ret);
> >   			goto free_data;
> > diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h index
> > 3845c8fcc94e5..c90bbdc4146a6 100644
> > --- a/include/acpi/acpixf.h
> > +++ b/include/acpi/acpixf.h
> > @@ -452,7 +452,8 @@ ACPI_EXTERNAL_RETURN_STATUS(acpi_status
> ACPI_INIT_FUNCTION
> >   					       u8 physical))
> >
> >   ACPI_EXTERNAL_RETURN_STATUS(acpi_status
> > -			    acpi_load_table(struct acpi_table_header *table))
> > +			    acpi_load_table(struct acpi_table_header *table,
> > +					    u32 *table_idx))
> >
> >   ACPI_EXTERNAL_RETURN_STATUS(acpi_status
> >   			    acpi_unload_parent_table(acpi_handle object))
> > --
> > 2.17.1
> >
> >


--===============7982983165777213508==--

