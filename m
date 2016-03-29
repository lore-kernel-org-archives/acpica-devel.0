Content-Type: multipart/mixed; boundary="===============4249771694031153644=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: Re: [Devel] [PATCH] ACPICA: Remove unnecessary "\n" from an ACPI_INFO
 boot message
Date: Tue, 29 Mar 2016 19:09:57 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37E455538@ORSMSX110.amr.corp.intel.com>
In-Reply-To: 74bc15316c48bb33c0954d94c0595720ee0955bd.1459187689.git.bristot@redhat.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============4249771694031153644==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Actually, I did in fact put that there to break up the output after the tab=
les are loaded. Is this a problem?


> -----Original Message-----
> From: Daniel Bristot de Oliveira [mailto:bristot(a)redhat.com]
> Sent: Monday, March 28, 2016 10:59 AM
> To: Moore, Robert; Zheng, Lv; Wysocki, Rafael J; Len Brown
> Cc: linux-acpi(a)vger.kernel.org; devel(a)acpica.org; linux-
> kernel(a)vger.kernel.org
> Subject: [PATCH] ACPICA: Remove unnecessary "\n" from an ACPI_INFO boot
> message
> =

> A "\n" at the end of bellow ACPI_INFO message is causing a blank line in
> the kernel log:
> =

>   ACPI_INFO(("%u ACPI AML tables successfully acquired and loaded\n",
> tables_loaded));
> =

> This patch removes the "\n".
> =

> Kernel log before this patch:
> 	ACPI: Core revision 20160108
> 	ACPI: 2 ACPI AML tables successfully acquired and loaded
> =

> 	Security Framework initialized
> =

> Kernel log after this patch:
> 	ACPI: Core revision 20160108
> 	ACPI: 2 ACPI AML tables successfully acquired and loaded
> 	Security Framework initialized
> =

> Signed-off-by: Daniel Bristot de Oliveira <bristot(a)redhat.com>
> =

> diff --git a/drivers/acpi/acpica/tbxfload.c
> b/drivers/acpi/acpica/tbxfload.c index 3151968..e435b84 100644
> --- a/drivers/acpi/acpica/tbxfload.c
> +++ b/drivers/acpi/acpica/tbxfload.c
> @@ -240,7 +240,8 @@ acpi_status acpi_tb_load_namespace(void)
>  	}
> =

>  	if (!tables_failed) {
> -		ACPI_INFO(("%u ACPI AML tables successfully acquired and
> loaded\n", tables_loaded));
> +		ACPI_INFO(("%u ACPI AML tables successfully acquired and
> loaded",
> +			   tables_loaded));
>  	} else {
>  		ACPI_ERROR((AE_INFO,
>  			    "%u table load failures, %u successful",
> --
> 2.5.0


--===============4249771694031153644==--

