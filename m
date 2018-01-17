Content-Type: multipart/mixed; boundary="===============6033823793008175012=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: Re: [Devel] [PATCH 1/2] ACPICA: acpi_ds_resolve_package_element: Use
 proper status when logging exception
Date: Wed, 17 Jan 2018 21:54:04 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E3B754906A@ORSMSX110.amr.corp.intel.com>
In-Reply-To: 20180112113707.3833-1-hdegoede@redhat.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============6033823793008175012==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

We are working on this file right now, thanks.
Bob


> -----Original Message-----
> From: Hans de Goede [mailto:hdegoede(a)redhat.com]
> Sent: Friday, January 12, 2018 3:37 AM
> To: Len Brown <lenb(a)kernel.org>; Moore, Robert <robert.moore(a)intel.co=
m>;
> Zheng, Lv <lv.zheng(a)intel.com>
> Cc: Hans de Goede <hdegoede(a)redhat.com>; linux-acpi(a)vger.kernel.org;
> devel(a)acpica.org
> Subject: [PATCH 1/2] ACPICA: acpi_ds_resolve_package_element: Use proper
> status when logging exception
> =

> Do not override the status which causes us to call acpi_exception with
> the status returned by the acpi_ns_externalize_name call we do to get a
> name to log.
> =

> Related: https://bugzilla.kernel.org/show_bug.cgi?id=3D198167
> Signed-off-by: Hans de Goede <hdegoede(a)redhat.com>
> ---
>  drivers/acpi/acpica/dspkginit.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> =

> diff --git a/drivers/acpi/acpica/dspkginit.c
> b/drivers/acpi/acpica/dspkginit.c index 6d487edfe2de..cddbbed2f344
> 100644
> --- a/drivers/acpi/acpica/dspkginit.c
> +++ b/drivers/acpi/acpica/dspkginit.c
> @@ -372,9 +372,9 @@ acpi_ds_resolve_package_element(union
> acpi_operand_object **element_ptr)
>  				ACPI_NS_SEARCH_PARENT | ACPI_NS_DONT_OPEN_SCOPE,
>  				NULL, &resolved_node);
>  	if (ACPI_FAILURE(status)) {
> -		status =3D acpi_ns_externalize_name(ACPI_UINT32_MAX,
> -						  (char *)element->reference.
> -						  aml, NULL, &external_path);
> +		acpi_ns_externalize_name(ACPI_UINT32_MAX,
> +					 (char *)element->reference.aml, NULL,
> +					 &external_path);
> =

>  		ACPI_EXCEPTION((AE_INFO, status,
>  				"Could not find/resolve named package element: %s",
> --
> 2.14.3


--===============6033823793008175012==--

