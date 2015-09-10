Content-Type: multipart/mixed; boundary="===============5907701307992847204=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: Re: [Devel] [PATCH] ACPICA: fix possible NULL dereference
Date: Thu, 10 Sep 2015 19:06:02 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37D344302@ORSMSX112.amr.corp.intel.com>
In-Reply-To: 1441880368-17718-1-git-send-email-sudipm.mukherjee@gmail.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============5907701307992847204==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

One of the things we always have to think about and look at is that often, =
things like this are *guaranteed" to be valid simply by virtue of the fact =
that the code has gotten as far as it has.

So, rather than litter the code with NULL checks for every single access, w=
e know up front that the object is valid.

This isn't always true and there are some valid situations, but we would ap=
preciate it if you help track this down.

Bob


> -----Original Message-----
> From: Sudip Mukherjee [mailto:sudipm.mukherjee(a)gmail.com]
> Sent: Thursday, September 10, 2015 3:19 AM
> To: Moore, Robert; Zheng, Lv; Wysocki, Rafael J; Len Brown
> Cc: linux-kernel(a)vger.kernel.org; linux-acpi(a)vger.kernel.org;
> devel(a)acpica.org; Sudip Mukherjee
> Subject: [PATCH] ACPICA: fix possible NULL dereference
> =

> acpi_ns_get_secondary_object() can return NULL, and if it returns NULL
> then we were dereferencing it while calling acpi_ds_execute_arguments().
> =

> Lets have a NULL check and return AE_NOT_EXIST.
> =

> Signed-off-by: Sudip Mukherjee <sudip(a)vectorindia.org>
> ---
>  drivers/acpi/acpica/dsargs.c | 3 +++
>  1 file changed, 3 insertions(+)
> =

> diff --git a/drivers/acpi/acpica/dsargs.c b/drivers/acpi/acpica/dsargs.c
> index e2ab59e..4bb8952 100644
> --- a/drivers/acpi/acpica/dsargs.c
> +++ b/drivers/acpi/acpica/dsargs.c
> @@ -192,6 +192,9 @@ acpi_ds_get_buffer_field_arguments(union
> acpi_operand_object *obj_desc)
>  	/* Get the AML pointer (method object) and buffer_field node */
> =

>  	extra_desc =3D acpi_ns_get_secondary_object(obj_desc);
> +	if (!extra_desc)
> +		return_ACPI_STATUS(AE_NOT_EXIST);
> +
>  	node =3D obj_desc->buffer_field.node;
> =

> =

> 	ACPI_DEBUG_EXEC(acpi_ut_display_init_pathname(ACPI_TYPE_BUFFER_FIELD
> ,
> --
> 1.9.1


--===============5907701307992847204==--

