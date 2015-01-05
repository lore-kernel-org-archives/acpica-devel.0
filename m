Content-Type: multipart/mixed; boundary="===============3520274414222820383=="
MIME-Version: 1.0
From: Zheng, Lv <lv.zheng at intel.com>
Subject: Re: [Devel] [PATCH 3/3] ACPICA: Remove use of __DATE__ macro
Date: Mon, 05 Jan 2015 08:47:43 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E88026AACD9@SHSMSX101.ccr.corp.intel.com>
In-Reply-To: 1418381488-25123-3-git-send-email-linux@rasmusvillemoes.dk
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============3520274414222820383==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

> From: Rasmus Villemoes [mailto:linux(a)rasmusvillemoes.dk]
> Sent: Friday, December 12, 2014 6:51 PM
> To: Zheng, Lv
> Cc: Rasmus Villemoes; linux-acpi(a)vger.kernel.org; devel(a)acpica.org; l=
inux-kernel(a)vger.kernel.org
> Subject: [PATCH 3/3] ACPICA: Remove use of __DATE__ macro
> =

> The macro __DATE__ and friends is not allowed in the kernel. Also,
> including the build time in output doesn't seem to provide any value.
> =


Could you confirm that it is not useful even for the user tools?
Please perform the following commands in the kernel source tree
1. stay in tools folder
2. type "make acpi"
3. type "./power/acpi/acpidump -v"

Thanks and best regards
-Lv

> Signed-off-by: Rasmus Villemoes <linux(a)rasmusvillemoes.dk>
> ---
>  drivers/acpi/acpica/acapps.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> =

> diff --git a/drivers/acpi/acpica/acapps.h b/drivers/acpi/acpica/acapps.h
> index 3d2c88289da9..f72826176ebe 100644
> --- a/drivers/acpi/acpica/acapps.h
> +++ b/drivers/acpi/acpica/acapps.h
> @@ -64,15 +64,15 @@
>  /* Macros for signons and file headers */
> =

>  #define ACPI_COMMON_SIGNON(utility_name) \
> -	"\n%s\n%s version %8.8X%s [%s]\n%s\n\n", \
> +	"\n%s\n%s version %8.8X%s\n%s\n\n", \
>  	ACPICA_NAME, \
> -	utility_name, ((u32) ACPI_CA_VERSION), ACPI_WIDTH, __DATE__, \
> +	utility_name, ((u32) ACPI_CA_VERSION), ACPI_WIDTH, \
>  	ACPICA_COPYRIGHT
> =

>  #define ACPI_COMMON_HEADER(utility_name, prefix) \
> -	"%s%s\n%s%s version %8.8X%s [%s]\n%s%s\n%s\n", \
> +	"%s%s\n%s%s version %8.8X%s\n%s%s\n%s\n", \
>  	prefix, ACPICA_NAME, \
> -	prefix, utility_name, ((u32) ACPI_CA_VERSION), ACPI_WIDTH, __DATE__, \
> +	prefix, utility_name, ((u32) ACPI_CA_VERSION), ACPI_WIDTH, \
>  	prefix, ACPICA_COPYRIGHT, \
>  	prefix
> =

> --
> 2.1.3


--===============3520274414222820383==--

