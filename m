Content-Type: multipart/mixed; boundary="===============4643564750944021434=="
MIME-Version: 1.0
From: Zheng, Lv <lv.zheng at intel.com>
Subject: Re: [Devel] [PATCH] ACPICA: Remove unnecessary call to debugger
Date: Fri, 09 Jun 2017 01:18:25 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E886CECBBA1@SHSMSX101.ccr.corp.intel.com>
In-Reply-To: 20170608213106.11982-1-kilobyte@angband.pl
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============4643564750944021434==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi, Adam

> From: linux-acpi-owner(a)vger.kernel.org [mailto:linux-acpi-owner(a)vger.=
kernel.org] On Behalf Of Adam
> Borowski
> Sent: Friday, June 9, 2017 5:31 AM
> To: Moore, Robert <robert.moore(a)intel.com>; Zheng, Lv <lv.zheng(a)intel=
.com>; Wysocki, Rafael J
> <rafael.j.wysocki(a)intel.com>; Len Brown <lenb(a)kernel.org>; linux-acpi=
(a)vger.kernel.org;
> devel(a)acpica.org
> Cc: Adam Borowski <kilobyte(a)angband.pl>
> Subject: [PATCH] ACPICA: Remove unnecessary call to debugger
> =

> This is a port of https://github.com/acpica/acpica/commit/eaa455ac by
> Robert Moore to the kernel:
> =

> > This call was simply wrong, and resulted in a -1 index into the operand
> > stack.
> =

> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=3D120351
> Signed-off-by: Adam Borowski <kilobyte(a)angband.pl>

I think my first fix also worked and your test on bug 120351 was wrong.
I just added comment a moment ago.

However I just pushed the removal of the wrong debugging statement fix to t=
he upstream.
It's really redundant, you need to enable the log and check them.

The patch has already been sent here:
https://patchwork.kernel.org/patch/9765837/
So you don't have to send it again.

Thanks
Lv

> You guys fixed this in your tool months ago, but it's still unfixed in the
> kernel.  Let's apply that patch, then.  The coding styles differ so much =
the
> patch is hardly recognizable, but it's a direct port.
> =

>  drivers/acpi/acpica/dsutils.c | 9 ---------
>  1 file changed, 9 deletions(-)
> =

> diff --git a/drivers/acpi/acpica/dsutils.c b/drivers/acpi/acpica/dsutils.c
> index 406edec20de7..0dabd9b95684 100644
> --- a/drivers/acpi/acpica/dsutils.c
> +++ b/drivers/acpi/acpica/dsutils.c
> @@ -633,15 +633,6 @@ acpi_ds_create_operand(struct acpi_walk_state *walk_=
state,
> =

>  		if ((op_info->flags & AML_HAS_RETVAL) ||
>  		    (arg->common.flags & ACPI_PARSEOP_IN_STACK)) {
> -			ACPI_DEBUG_PRINT((ACPI_DB_DISPATCH,
> -					  "Argument previously created, already stacked\n"));
> -
> -			acpi_db_display_argument_object(walk_state->
> -							operands[walk_state->
> -								 num_operands -
> -								 1],
> -							walk_state);
> -
>  			/*
>  			 * Use value that was already previously returned
>  			 * by the evaluation of this argument
> --
> 2.11.0
> =

> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo(a)vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--===============4643564750944021434==--

