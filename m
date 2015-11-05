Content-Type: multipart/mixed; boundary="===============4094398220121349690=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: Re: [Devel] [PATCH] ACPICA: Delete unnecessary checks before the
 function call "acpi_ut_strupr"
Date: Thu, 05 Nov 2015 16:28:39 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37D98E1D4@ORSMSX112.amr.corp.intel.com>
In-Reply-To: 563B7438.6010002@users.sourceforge.net
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============4094398220121349690==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Agreed, we will implement your suggestions in the ACPICA code (which is in =
a different format than the Linux version).


> -----Original Message-----
> From: SF Markus Elfring [mailto:elfring(a)users.sourceforge.net]
> Sent: Thursday, November 05, 2015 7:23 AM
> To: Len Brown; Zheng, Lv; Wysocki, Rafael J; Moore, Robert; linux-
> acpi(a)vger.kernel.org; devel(a)acpica.org
> Cc: LKML; kernel-janitors(a)vger.kernel.org; Julia Lawall
> Subject: [PATCH] ACPICA: Delete unnecessary checks before the function
> call "acpi_ut_strupr"
> =

> From: Markus Elfring <elfring(a)users.sourceforge.net>
> Date: Thu, 5 Nov 2015 16:12:32 +0100
> =

> The acpi_ut_strupr() function tests whether its argument is NULL and then
> returns immediately. Thus the test around the call is not needed.
> =

> This issue was detected by using the Coccinelle software.
> =

> Signed-off-by: Markus Elfring <elfring(a)users.sourceforge.net>
> ---
>  drivers/acpi/acpica/dbcmds.c  | 9 ++-------
> drivers/acpi/acpica/dbinput.c | 5 +----
>  2 files changed, 3 insertions(+), 11 deletions(-)
> =

> diff --git a/drivers/acpi/acpica/dbcmds.c b/drivers/acpi/acpica/dbcmds.c
> index 30414b3..7dcc95a 100644
> --- a/drivers/acpi/acpica/dbcmds.c
> +++ b/drivers/acpi/acpica/dbcmds.c
> @@ -1131,13 +1131,8 @@ void acpi_db_trace(char *enable_arg, char
> *method_arg, char *once_arg)
>  	u32 debug_layer =3D 0;
>  	u32 flags =3D 0;
> =

> -	if (enable_arg) {
> -		acpi_ut_strupr(enable_arg);
> -	}
> -
> -	if (once_arg) {
> -		acpi_ut_strupr(once_arg);
> -	}
> +	acpi_ut_strupr(enable_arg);
> +	acpi_ut_strupr(once_arg);
> =

>  	if (method_arg) {
>  		if (acpi_db_trace_method_name) {
> diff --git a/drivers/acpi/acpica/dbinput.c b/drivers/acpi/acpica/dbinput.c
> index 0480254..aa1dcee 100644
> --- a/drivers/acpi/acpica/dbinput.c
> +++ b/drivers/acpi/acpica/dbinput.c
> @@ -622,10 +622,7 @@ static u32 acpi_db_get_line(char *input_buffer)
>  	}
> =

>  	/* Uppercase the actual command */
> -
> -	if (acpi_gbl_db_args[0]) {
> -		acpi_ut_strupr(acpi_gbl_db_args[0]);
> -	}
> +	acpi_ut_strupr(acpi_gbl_db_args[0]);
> =

>  	count =3D i;
>  	if (count) {
> --
> 2.6.2


--===============4094398220121349690==--

