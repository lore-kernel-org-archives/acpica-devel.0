Content-Type: multipart/mixed; boundary="===============9087107084973109578=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: Re: [Devel] [PATCH] ACPICA: Delete an unnecessary check before the
 function call "acpi_ds_delete_walk_state"
Date: Wed, 24 Jun 2015 15:16:25 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37D306826@ORSMSX112.amr.corp.intel.com>
In-Reply-To: 558A9864.2020608@users.sourceforge.net
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============9087107084973109578==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Got it, thanks.


> -----Original Message-----
> From: SF Markus Elfring [mailto:elfring(a)users.sourceforge.net]
> Sent: Wednesday, June 24, 2015 4:46 AM
> To: Len Brown; Zheng, Lv; Wysocki, Rafael J; Moore, Robert; linux-
> acpi(a)vger.kernel.org; devel(a)acpica.org
> Cc: LKML; kernel-janitors(a)vger.kernel.org; Julia Lawall
> Subject: [PATCH] ACPICA: Delete an unnecessary check before the function
> call "acpi_ds_delete_walk_state"
> =

> From: Markus Elfring <elfring(a)users.sourceforge.net>
> Date: Wed, 24 Jun 2015 13:33:47 +0200
> =

> The acpi_ds_delete_walk_state() function tests whether its argument is
> NULL and then returns immediately. Thus the test around the call is not
> needed.
> =

> This issue was detected by using the Coccinelle software.
> =

> Signed-off-by: Markus Elfring <elfring(a)users.sourceforge.net>
> ---
>  drivers/acpi/acpica/dsmethod.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> =

> diff --git a/drivers/acpi/acpica/dsmethod.c
> b/drivers/acpi/acpica/dsmethod.c index 85bb951..188b254 100644
> --- a/drivers/acpi/acpica/dsmethod.c
> +++ b/drivers/acpi/acpica/dsmethod.c
> @@ -574,10 +574,7 @@ cleanup:
>  	/* On error, we must terminate the method properly */
> =

>  	acpi_ds_terminate_control_method(obj_desc, next_walk_state);
> -	if (next_walk_state) {
> -		acpi_ds_delete_walk_state(next_walk_state);
> -	}
> -
> +	acpi_ds_delete_walk_state(next_walk_state);
>  	return_ACPI_STATUS(status);
>  }
> =

> --
> 2.4.4


--===============9087107084973109578==--

