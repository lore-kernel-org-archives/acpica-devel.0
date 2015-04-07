Content-Type: multipart/mixed; boundary="===============1940313516299952541=="
MIME-Version: 1.0
From: Bob Paauwe <bob.j.paauwe at intel.com>
Subject: Re: [Devel] [PATCH 2/2] Acutally unload a table.
Date: Tue, 07 Apr 2015 11:34:34 -0700
Message-ID: <20150407113434.0fd8d75b@bpaauwe-desk.fm.intel.com>
In-Reply-To: 94F2FBAB4432B54E8AACC7DFDE6C92E37D2BB71D@ORSMSX112.amr.corp.intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============1940313516299952541==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, 7 Apr 2015 10:50:55 -0700
"Moore, Robert" <robert.moore(a)intel.com> wrote:

> Is this really such a big deal? I don't think that a loaded table is real=
ly consuming much in the way of resources. Sure, it is mapped, but at least=
 some of the internal stuff is relatively static. Plus, we have to:
> =

> 1) Add a new external interface which must be documented.
> 2) Disallow unloading things like DSDT and SSDTs, FADT, FACS.
> 3) What if a table is used by more than one "module"?
> =

> You'll have to convince me that this is worth the trouble.
> Bob

I'm doing something that's a bit unconventional so I'm not sure I can
convince you.  But maybe I'm doing something really wrong and there's a
better way.  So with that.

I'm using the new acpi properties as a way to provide some
configuration data to the driver. Right now, I have three ways to get
these values loaded.

1) They could be inserted into the ACPI firmware for the device.  I
think this will work, but I don't have any way of doing this today.

2) I can create a table, compile it, and add it as a firmware blob
in /lib/firmware (or build the blob into the kernel).

3) I can create a table, compile it, and include it in the driver
source as static data.

I'm using #3 right now to test everything.  If I do the following:

	modprobe i915
		acpi_load_table(static table data);
		[ use properties to configure driver and test]
		acpi_unload_parent_table();
	rmmod i915

	modprobe i915
		acpi_load_table(static table data);

I'll get a kernel null dereference in acpi_load_table() because it
thinks the static table data from the first load is still there, but
since it was part of the module that was unloaded, it's gone.

This patch was the easiest way for me to stop crashing and allow me
to test stuff without having to reboot every time. =


Bob

> =

> =

> > -----Original Message-----
> > From: Devel [mailto:devel-bounces(a)acpica.org] On Behalf Of Bob Paauwe
> > Sent: Tuesday, April 07, 2015 9:52 AM
> > To: devel-acpica
> > Subject: [Devel] [PATCH 2/2] Acutally unload a table.
> > =

> > Instead of simply marking it as unloaded.  If a table is dynamically
> > loaded by a module and the module is then unloaded, the table is no lon=
ger
> > valid so it's best to make sure it is unloaded.
> > =

> > Signed-off-by: Bob Paauwe <bob.j.paauwe(a)intel.com>
> > ---
> >  drivers/acpi/acpica/tbxfload.c | 1 +
> >  1 file changed, 1 insertion(+)
> > =

> > diff --git a/drivers/acpi/acpica/tbxfload.c
> > b/drivers/acpi/acpica/tbxfload.c index aadb300..ce75ca2 100644
> > --- a/drivers/acpi/acpica/tbxfload.c
> > +++ b/drivers/acpi/acpica/tbxfload.c
> > @@ -408,6 +408,7 @@ acpi_status acpi_unload_parent_table(acpi_handle
> > object)
> > =

> >  		status =3D acpi_tb_release_owner_id(i);
> >  		acpi_tb_set_table_loaded_flag(i, FALSE);
> > +		acpi_tb_uninstall_table(&acpi_gbl_root_table_list.tables[i]);
> >  		break;
> >  	}
> > =

> > --
> > 2.1.0
> > =

> > _______________________________________________
> > Devel mailing list
> > Devel(a)acpica.org
> > https://lists.acpica.org/mailman/listinfo/devel


--===============1940313516299952541==--

