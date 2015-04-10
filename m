Content-Type: multipart/mixed; boundary="===============4510530465889685527=="
MIME-Version: 1.0
From: Zheng, Lv <lv.zheng at intel.com>
Subject: Re: [Devel] [PATCH 1/2] Remove extra release mutex call.
Date: Fri, 10 Apr 2015 05:49:36 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E8802702DD7@SHSMSX101.ccr.corp.intel.com>
In-Reply-To: 1428425535-31774-2-git-send-email-bob.j.paauwe@intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============4510530465889685527==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This has already been reported by Octavian and the fix has been merged in t=
he ACPICA upstream:
https://github.com/acpica/acpica/commit/c70434d
Thanks for reporting.

Best regards
-Lv

> From: Devel [mailto:devel-bounces(a)acpica.org] On Behalf Of Bob Paauwe
> Sent: Wednesday, April 08, 2015 12:52 AM
> =

> Remove the release mutex call when a table is re-loaded. This seems to
> be here to release a mutex that was aquired at one time in table verify
> function.  That aquire is no longer present, so remove the release.
> =

> Signed-off-by: Bob Paauwe <bob.j.paauwe(a)intel.com>
> ---
>  drivers/acpi/acpica/tbinstal.c | 1 -
>  1 file changed, 1 deletion(-)
> =

> diff --git a/drivers/acpi/acpica/tbinstal.c b/drivers/acpi/acpica/tbinsta=
l.c
> index 9bad45e..7fbc2b9 100644
> --- a/drivers/acpi/acpica/tbinstal.c
> +++ b/drivers/acpi/acpica/tbinstal.c
> @@ -346,7 +346,6 @@ acpi_tb_install_standard_table(acpi_physical_address =
address,
>  				 */
>  				acpi_tb_uninstall_table(&new_table_desc);
>  				*table_index =3D i;
> -				(void)acpi_ut_release_mutex(ACPI_MTX_TABLES);
>  				return_ACPI_STATUS(AE_OK);
>  			}
>  		}
> --
> 2.1.0
> =

> _______________________________________________
> Devel mailing list
> Devel(a)acpica.org
> https://lists.acpica.org/mailman/listinfo/devel

--===============4510530465889685527==--

