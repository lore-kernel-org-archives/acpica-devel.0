Content-Type: multipart/mixed; boundary="===============8811292678978465846=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: Re: [Devel] [PATCH] acpi: update struct acpi_table_tpm2
Date: Mon, 08 Jun 2015 20:52:02 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37D2F28EC@ORSMSX112.amr.corp.intel.com>
In-Reply-To: 1433770706-3332-1-git-send-email-jarkko.sakkinen@linux.intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============8811292678978465846==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

It looks like there is a change to the TCPA table also.


> -----Original Message-----
> From: Jarkko Sakkinen [mailto:jarkko.sakkinen(a)linux.intel.com]
> Sent: Monday, June 08, 2015 6:38 AM
> To: Moore, Robert
> Cc: Jarkko Sakkinen; Zheng, Lv; Wysocki, Rafael J; Len Brown; open
> list:ACPI COMPONENT AR...; open list:ACPI COMPONENT AR...; open list
> Subject: [PATCH] acpi: update struct acpi_table_tpm2
> =

> Updated struct acpi_table_tpm2 to conform to the official TCG ACPI spec.
> =

> Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen(a)linux.intel.com>
> ---
>  include/acpi/actbl3.h | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> =

> diff --git a/include/acpi/actbl3.h b/include/acpi/actbl3.h index
> 440ca81..33df1dd 100644
> --- a/include/acpi/actbl3.h
> +++ b/include/acpi/actbl3.h
> @@ -688,13 +688,14 @@ enum acpi_rasf_status {
>   * TPM2 - Trusted Platform Module (TPM) 2.0 Hardware Interface Table
>   *        Version 3
>   *
> - * Conforms to "TPM 2.0 Hardware Interface Table (TPM2)" 29 November 2011
> + * Conforms to "TCG ACPI Specification for Family 1.2 and 2.0" 19
> + December 2014
>   *
> =

> **************************************************************************
> ****/
> =

>  struct acpi_table_tpm2 {
>  	struct acpi_table_header header;	/* Common ACPI table header */
> -	u32 flags;
> +	u16 platform_class;
> +	u16 reserved;
>  	u64 control_address;
>  	u32 start_method;
>  };
> --
> 2.1.4


--===============8811292678978465846==--

