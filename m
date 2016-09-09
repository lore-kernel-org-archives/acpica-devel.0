Content-Type: multipart/mixed; boundary="===============8120654983938956101=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: Re: [Devel] [PATCH] ACPICA / Interpreter: Remove redundant newline
Date: Fri, 09 Sep 2016 18:26:17 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37E4F34B4@ORSMSX110.amr.corp.intel.com>
In-Reply-To: 20160909161253.30952-1-bp@alien8.de
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============8120654983938956101==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Is this a big deal?

We do this on purpose for AcpiExec, to make the screen output more readable.


> -----Original Message-----
> From: Borislav Petkov [mailto:bp(a)alien8.de]
> Sent: Friday, September 9, 2016 9:13 AM
> To: LKML <linux-kernel(a)vger.kernel.org>
> Cc: Moore, Robert <robert.moore(a)intel.com>; Zheng, Lv
> <lv.zheng(a)intel.com>; Wysocki, Rafael J <rafael.j.wysocki(a)intel.com>;
> Len Brown <lenb(a)kernel.org>; linux-acpi(a)vger.kernel.org;
> devel(a)acpica.org
> Subject: [PATCH] ACPICA / Interpreter: Remove redundant newline
> =

> From: Borislav Petkov <bp(a)suse.de>
> =

> acpi_info() already issues a '\n' so remove it in the call.
> =

> Signed-off-by: Borislav Petkov <bp(a)suse.de>
> Cc: Robert Moore <robert.moore(a)intel.com>
> Cc: Lv Zheng <lv.zheng(a)intel.com>
> Cc: "Rafael J. Wysocki" <rafael.j.wysocki(a)intel.com>
> Cc: Len Brown <lenb(a)kernel.org>
> Cc: linux-acpi(a)vger.kernel.org
> Cc: devel(a)acpica.org
> ---
>  drivers/acpi/acpica/tbxfload.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> =

> diff --git a/drivers/acpi/acpica/tbxfload.c
> b/drivers/acpi/acpica/tbxfload.c index ac71abcd32bb..e7119b7ccd79 100644
> --- a/drivers/acpi/acpica/tbxfload.c
> +++ b/drivers/acpi/acpica/tbxfload.c
> @@ -240,7 +240,7 @@ acpi_status acpi_tb_load_namespace(void)
>  	}
> =

>  	if (!tables_failed) {
> -		ACPI_INFO(("%u ACPI AML tables successfully acquired and
> loaded\n", tables_loaded));
> +		ACPI_INFO(("%u ACPI AML tables successfully acquired and
> loaded",
> +tables_loaded));
>  	} else {
>  		ACPI_ERROR((AE_INFO,
>  			    "%u table load failures, %u successful",
> --
> 2.10.0


--===============8120654983938956101==--

