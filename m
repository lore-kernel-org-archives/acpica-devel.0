Content-Type: multipart/mixed; boundary="===============4047345524464617103=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: Re: [Devel] [PATCH 2/2] Acutally unload a table.
Date: Tue, 07 Apr 2015 17:50:55 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37D2BB71D@ORSMSX112.amr.corp.intel.com>
In-Reply-To: 1428425535-31774-3-git-send-email-bob.j.paauwe@intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============4047345524464617103==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Is this really such a big deal? I don't think that a loaded table is really=
 consuming much in the way of resources. Sure, it is mapped, but at least s=
ome of the internal stuff is relatively static. Plus, we have to:

1) Add a new external interface which must be documented.
2) Disallow unloading things like DSDT and SSDTs, FADT, FACS.
3) What if a table is used by more than one "module"?

You'll have to convince me that this is worth the trouble.
Bob


> -----Original Message-----
> From: Devel [mailto:devel-bounces(a)acpica.org] On Behalf Of Bob Paauwe
> Sent: Tuesday, April 07, 2015 9:52 AM
> To: devel-acpica
> Subject: [Devel] [PATCH 2/2] Acutally unload a table.
> =

> Instead of simply marking it as unloaded.  If a table is dynamically
> loaded by a module and the module is then unloaded, the table is no longer
> valid so it's best to make sure it is unloaded.
> =

> Signed-off-by: Bob Paauwe <bob.j.paauwe(a)intel.com>
> ---
>  drivers/acpi/acpica/tbxfload.c | 1 +
>  1 file changed, 1 insertion(+)
> =

> diff --git a/drivers/acpi/acpica/tbxfload.c
> b/drivers/acpi/acpica/tbxfload.c index aadb300..ce75ca2 100644
> --- a/drivers/acpi/acpica/tbxfload.c
> +++ b/drivers/acpi/acpica/tbxfload.c
> @@ -408,6 +408,7 @@ acpi_status acpi_unload_parent_table(acpi_handle
> object)
> =

>  		status =3D acpi_tb_release_owner_id(i);
>  		acpi_tb_set_table_loaded_flag(i, FALSE);
> +		acpi_tb_uninstall_table(&acpi_gbl_root_table_list.tables[i]);
>  		break;
>  	}
> =

> --
> 2.1.0
> =

> _______________________________________________
> Devel mailing list
> Devel(a)acpica.org
> https://lists.acpica.org/mailman/listinfo/devel

--===============4047345524464617103==--

