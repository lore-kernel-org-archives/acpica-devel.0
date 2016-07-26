Content-Type: multipart/mixed; boundary="===============1394390729754929022=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: Re: [Devel] [PATCH] ACPICA: cleanup method properly on error
Date: Tue, 26 Jul 2016 14:39:51 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37E4CD2A1@ORSMSX110.amr.corp.intel.com>
In-Reply-To: 1469201709-10518-1-git-send-email-vegard.nossum@oracle.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============1394390729754929022==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

We'll look at this.
Thanks.


> -----Original Message-----
> From: Vegard Nossum [mailto:vegard.nossum(a)oracle.com]
> Sent: Friday, July 22, 2016 8:35 AM
> To: Moore, Robert <robert.moore(a)intel.com>; Zheng, Lv
> <lv.zheng(a)intel.com>; Wysocki, Rafael J <rafael.j.wysocki(a)intel.com>
> Cc: linux-acpi(a)vger.kernel.org; devel(a)acpica.org; linux-
> kernel(a)vger.kernel.org; Vegard Nossum <vegard.nossum(a)oracle.com>;
> stable(a)vger.kernel.org
> Subject: [PATCH] ACPICA: cleanup method properly on error
> =

> If the call to acpi_ds_init_aml_walk() fails, then we have to undo the
> walk state push done by acpi_ds_create_walk_state(). Otherwise, the new
> walk state (which has just been freed) will remain on the thread's
> walk_state_list and be dereferenced in acpi_ps_parse_aml() when we try
> to get the new state.
> =

> You can observe this when reading e.g.
> =

>     /sys/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0F:01/status
> =

> Cc: stable(a)vger.kernel.org
> Signed-off-by: Vegard Nossum <vegard.nossum(a)oracle.com>
> ---
>  drivers/acpi/acpica/dsmethod.c | 2 ++
>  1 file changed, 2 insertions(+)
> =

> diff --git a/drivers/acpi/acpica/dsmethod.c
> b/drivers/acpi/acpica/dsmethod.c index 47c7b52..44b50a6 100644
> --- a/drivers/acpi/acpica/dsmethod.c
> +++ b/drivers/acpi/acpica/dsmethod.c
> @@ -596,6 +596,8 @@ cleanup:
>  	/* On error, we must terminate the method properly */
> =

>  	acpi_ds_terminate_control_method(obj_desc, next_walk_state);
> +	if (thread)
> +		acpi_ds_pop_walk_state(thread);
>  	acpi_ds_delete_walk_state(next_walk_state);
> =

>  	return_ACPI_STATUS(status);
> --
> 1.9.1


--===============1394390729754929022==--

