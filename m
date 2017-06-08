Content-Type: multipart/mixed; boundary="===============5354882725841628636=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: Re: [Devel] [PATCH] ACPICA: Remove unnecessary call to debugger
Date: Thu, 08 Jun 2017 23:43:35 +0200
Message-ID: <CAJZ5v0i=7CyVNT=CeEbB2Xrn7mEmi21URtS8gCZ_CinzAgLCHQ@mail.gmail.com>
In-Reply-To: 20170608213106.11982-1-kilobyte@angband.pl
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============5354882725841628636==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 8, 2017 at 11:31 PM, Adam Borowski <kilobyte(a)angband.pl> wrot=
e:
> This is a port of https://github.com/acpica/acpica/commit/eaa455ac by
> Robert Moore to the kernel:
>
>> This call was simply wrong, and resulted in a -1 index into the operand
>> stack.
>
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=3D120351
> Signed-off-by: Adam Borowski <kilobyte(a)angband.pl>
> ---
> You guys fixed this in your tool months ago, but it's still unfixed in the
> kernel.  Let's apply that patch, then.  The coding styles differ so much =
the
> patch is hardly recognizable, but it's a direct port.

Lv, any comments?

>  drivers/acpi/acpica/dsutils.c | 9 ---------
>  1 file changed, 9 deletions(-)
>
> diff --git a/drivers/acpi/acpica/dsutils.c b/drivers/acpi/acpica/dsutils.c
> index 406edec20de7..0dabd9b95684 100644
> --- a/drivers/acpi/acpica/dsutils.c
> +++ b/drivers/acpi/acpica/dsutils.c
> @@ -633,15 +633,6 @@ acpi_ds_create_operand(struct acpi_walk_state *walk_=
state,
>
>                 if ((op_info->flags & AML_HAS_RETVAL) ||
>                     (arg->common.flags & ACPI_PARSEOP_IN_STACK)) {
> -                       ACPI_DEBUG_PRINT((ACPI_DB_DISPATCH,
> -                                         "Argument previously created, a=
lready stacked\n"));
> -
> -                       acpi_db_display_argument_object(walk_state->
> -                                                       operands[walk_sta=
te->
> -                                                                num_oper=
ands -
> -                                                                1],
> -                                                       walk_state);
> -
>                         /*
>                          * Use value that was already previously returned
>                          * by the evaluation of this argument
> --
> 2.11.0

--===============5354882725841628636==--

