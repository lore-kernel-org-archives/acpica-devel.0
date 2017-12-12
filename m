Content-Type: multipart/mixed; boundary="===============1621668450243965659=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: Re: [Devel] [PATCH] acpi: acpica: add acpi status check prior walking
 through namespace
Date: Tue, 12 Dec 2017 21:52:21 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E3B74FBD84@ORSMSX110.amr.corp.intel.com>
In-Reply-To: 1513094360-1414-2-git-send-email-Vadim.Lomovtsev@caviumnetworks.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============1621668450243965659==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Another way to look at this is that the kernel should not be calling ACPI i=
nterfaces if ACPI is disabled.

> -----Original Message-----
> From: Vadim Lomovtsev [mailto:Vadim.Lomovtsev(a)caviumnetworks.com]
> Sent: Tuesday, December 12, 2017 7:59 AM
> To: Moore, Robert <robert.moore(a)intel.com>; Zheng, Lv
> <lv.zheng(a)intel.com>; Wysocki, Rafael J <rafael.j.wysocki(a)intel.com>;
> lenb(a)kernel.org; linux-acpi(a)vger.kernel.org; devel(a)acpica.org; linu=
x-
> kernel(a)vger.kernel.org
> Cc: vadim.lomovtsev(a)cavium.com
> Subject: [PATCH] acpi: acpica: add acpi status check prior walking
> through namespace
> =

> From: Vadim Lomovtsev <vadim.lomovtsev(a)cavium.com>
> =

> While having kernel built with ACPI support enabled and booted over FDT,
> the ltp_acpi test from LTP suite causes kernel crash while calling
> acpi_ns_walk_namespace(). The acpi_get_devices is high level wrapper for
> it, so we need to protect kernel from crashes by adding acpi status
> check before walking through namespace which is not loaded because of
> acpi is disabled.
> =

> Signed-off-by: Vadim Lomovtsev <vadim.lomovtsev(a)cavium.com>
> ---
>  drivers/acpi/acpica/nsxfeval.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> =

> diff --git a/drivers/acpi/acpica/nsxfeval.c
> b/drivers/acpi/acpica/nsxfeval.c index 783f4c8..e0eb9ae 100644
> --- a/drivers/acpi/acpica/nsxfeval.c
> +++ b/drivers/acpi/acpica/nsxfeval.c
> @@ -52,6 +52,8 @@
>  #define _COMPONENT          ACPI_NAMESPACE
>  ACPI_MODULE_NAME("nsxfeval")
> =

> +extern int acpi_disabled;
> +
>  /* Local prototypes */
>  static void acpi_ns_resolve_references(struct acpi_evaluate_info
> *info);
> =

> @@ -812,6 +814,11 @@ static void acpi_ns_resolve_references(struct
> acpi_evaluate_info *info)
> =

>  	ACPI_FUNCTION_TRACE(acpi_get_devices);
> =

> +	/* check if ACPI disabled to prevent kernel crash later */
> +	if (acpi_disabled) {
> +		return_ACPI_STATUS(AE_NOT_CONFIGURED);
> +	}
> +
>  	/* Parameter validation */
> =

>  	if (!user_function) {
> --
> 1.8.3.1


--===============1621668450243965659==--

