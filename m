Content-Type: multipart/mixed; boundary="===============6992402776590914482=="
MIME-Version: 1.0
From: Zheng, Lv <lv.zheng at intel.com>
Subject: Re: [Devel] [PATCH] ACPICA: cleanup method properly on error
Date: Fri, 29 Jul 2016 04:47:10 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E883BC07E8C@SHSMSX101.ccr.corp.intel.com>
In-Reply-To: 1469201709-10518-1-git-send-email-vegard.nossum@oracle.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============6992402776590914482==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi, Vegard

> From: linux-acpi-owner(a)vger.kernel.org [mailto:linux-acpi-
> owner(a)vger.kernel.org] On Behalf Of Vegard Nossum
> Subject: [PATCH] ACPICA: cleanup method properly on error
> =

> If the call to acpi_ds_init_aml_walk() fails, then we have to undo the
> walk state push done by acpi_ds_create_walk_state(). Otherwise, the new
> walk state (which has just been freed) will remain on the thread's
> walk_state_list and be dereferenced in acpi_ps_parse_aml() when we try
> to get the new state.
[Lv Zheng] =

I haven't looked into the detail.
Let me first ask simple questions and present simple concerns in order to m=
ove this discussion on.

> =

> You can observe this when reading e.g.
> =

>     /sys/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0F:01/status
[Lv Zheng] =

Do you mean you have real issues related to this?
If so, could provide the .config and dmesg for us?

> =

> Cc: stable(a)vger.kernel.org
> Signed-off-by: Vegard Nossum <vegard.nossum(a)oracle.com>
> ---
>  drivers/acpi/acpica/dsmethod.c | 2 ++
>  1 file changed, 2 insertions(+)
> =

> diff --git a/drivers/acpi/acpica/dsmethod.c
> b/drivers/acpi/acpica/dsmethod.c
> index 47c7b52..44b50a6 100644
> --- a/drivers/acpi/acpica/dsmethod.c
> +++ b/drivers/acpi/acpica/dsmethod.c
> @@ -596,6 +596,8 @@ cleanup:
>  	/* On error, we must terminate the method properly */
> =

>  	acpi_ds_terminate_control_method(obj_desc, next_walk_state);
> +	if (thread)
> +		acpi_ds_pop_walk_state(thread);
>  	acpi_ds_delete_walk_state(next_walk_state);
[Lv Zheng] =

It seems, if acpi_ds_create_walk_state() fails, acpi_ds_delete_walk_state()=
 will be invoked.
So they are paired. Fixing this in acpi_ds_delete_walk_state() could help t=
o fix all of them.
Given the fix is useful, why don't you do this in acpi_ds_delete_walk_state=
()?

Thanks and best regards
-Lv

--===============6992402776590914482==--

