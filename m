Content-Type: multipart/mixed; boundary="===============5995209278062377888=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: Re: [Devel] [PATCH 3/6] ACPICA: make use of new strtolower() function
Date: Fri, 01 Jul 2016 01:11:03 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37E4C3731@ORSMSX110.amr.corp.intel.com>
In-Reply-To: 1467330612-26242-4-git-send-email-mmayer@broadcom.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============5995209278062377888==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Where is "strtolower" implemented?


> -----Original Message-----
> From: Markus Mayer [mailto:mmayer(a)broadcom.com]
> Sent: Thursday, June 30, 2016 4:50 PM
> To: Moore, Robert; Zheng, Lv; Wysocki, Rafael J; Len Brown
> Cc: Markus Mayer; linux-acpi(a)vger.kernel.org; devel(a)acpica.org; linux-
> kernel(a)vger.kernel.org
> Subject: [PATCH 3/6] ACPICA: make use of new strtolower() function
> =

> Call strtolower() rather than walking the string explicitly to convert it
> to lowercase.
> =

> Signed-off-by: Markus Mayer <mmayer(a)broadcom.com>
> ---
> =

> *** Please note that there don't seem to be any callers of
> acpi_ut_strlwr().
> *** It may be possible to remove the function altogether.
> =

>  drivers/acpi/acpica/utnonansi.c | 13 +------------
>  1 file changed, 1 insertion(+), 12 deletions(-)
> =

> diff --git a/drivers/acpi/acpica/utnonansi.c
> b/drivers/acpi/acpica/utnonansi.c index 3465fe2..b6e11dc 100644
> --- a/drivers/acpi/acpica/utnonansi.c
> +++ b/drivers/acpi/acpica/utnonansi.c
> @@ -64,19 +64,8 @@ ACPI_MODULE_NAME("utnonansi")
> =

> **************************************************************************
> ****/
>  void acpi_ut_strlwr(char *src_string)
>  {
> -	char *string;
> -
>  	ACPI_FUNCTION_ENTRY();
> -
> -	if (!src_string) {
> -		return;
> -	}
> -
> -	/* Walk entire string, lowercasing the letters */
> -
> -	for (string =3D src_string; *string; string++) {
> -		*string =3D (char)tolower((int)*string);
> -	}
> +	strtolower(src_string);
>  }
> =

> =

> /*************************************************************************
> ******
> --
> 2.7.4


--===============5995209278062377888==--

