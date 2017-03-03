Content-Type: multipart/mixed; boundary="===============4682052321727620688=="
MIME-Version: 1.0
From: Zheng, Lv <lv.zheng at intel.com>
Subject: Re: [Devel] [PATCH] ACPICA: Log Exceptions and Errors as warning
 while loading extra tables
Date: Fri, 03 Mar 2017 02:48:21 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E886CE44EB1@SHSMSX101.ccr.corp.intel.com>
In-Reply-To: 0518b7f7-8d08-0071-df54-af19806883ae@redhat.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============4682052321727620688==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

> From: Hans de Goede [mailto:hdegoede(a)redhat.com]
> Subject: Re: [PATCH] ACPICA: Log Exceptions and Errors as warning while l=
oading extra tables
> =

> Hi,
> =

> On 02-03-17 03:03, Zheng, Lv wrote:
> > Hi,
> >
> >> From: Hans de Goede [mailto:hdegoede(a)redhat.com]
> >> Subject: [PATCH] ACPICA: Log Exceptions and Errors as warning while lo=
ading extra tables
> >>
> >> Honor the "Ignore errors while loading tables, get as many as possible"
> >> comment in the tbxfload.c code and log any exceptions and errors during
> >> loading extra tables as warnings.
> >>
> >> This is important because many desktop and embedded applicance Linux
> >> use-cases have a hard requirement of not showing any (scary) text
> >> messages during system bootup, which get broken by errors reported
> >> by attempts to load the extra tables, as messaged logged at a KERN_ERR
> >> level are always shown even if the quiet kernel cmdline option is used.
> >
> > This looks worse than comparing the tables.
> =

> This is really another patch entirely, it would also make the duplicate
> table thing less of an issue, but even with a fix for the duplicate tables
> we still need something like this to lower the log level of errors while
> loading extra tables as that currently causes errors to be spewn on
> way to many machines, e.g. on my main workstation I get:
> =

> [    0.019856] ACPI Warning: [\_SB_.PCI0.XHC_.RHUB.HS11] Namespace lookup=
 failure, AE_NOT_FOUND
> (20160930/dswload-210)
> [    0.019859] ACPI Warning: AE_NOT_FOUND, During name lookup/catalog (20=
160930/psobject-227)
> [    0.019886] ACPI Warning: AE_NOT_FOUND, (SSDT:xh_rvp08) while loading =
table (20160930/tbxfload-268)
> [    0.026491] ACPI Warning: 1 table load failures, 5 successful (2016093=
0/tbxfload-287)

However some of them indicating a real issue that can be fixed by:
1. Merging this pull request: https://github.com/acpica/acpica/pull/189 (I =
made it no longer dependent on other fixes)
2. Setting acpi_gbl_parse_table_as_term_list to TRUE.
It's not far away than actually solving the real issues.
So why do we use a one-size-fits-all solution for such kind of errors?

Thanks and best regards
Lv


> =

> (this is with the patch, before that this were all errors and exceptions).
> =

> Add IIRC I'm getting yet another set of errors on my XPS 15, etc.
> =

> Regards,
> =

> Hans
> =

> =

> =

> > So before determining what should be done for the check of the duplicat=
ed aml tables.
> > Let's skip this submission.
> >
> > Thanks
> > Lv
> >
> >>
> >> Signed-off-by: Hans de Goede <hdegoede(a)redhat.com>
> >> ---
> >>  drivers/acpi/acpica/acglobal.h  |  1 +
> >>  drivers/acpi/acpica/tbxfload.c  |  4 +++-
> >>  drivers/acpi/acpica/uterror.c   | 10 ++++++++--
> >>  drivers/acpi/acpica/utxferror.c | 19 ++++++++++---------
> >>  4 files changed, 22 insertions(+), 12 deletions(-)
> >>
> >> diff --git a/drivers/acpi/acpica/acglobal.h b/drivers/acpi/acpica/acgl=
obal.h
> >> index edbb42e..5ae9eee 100644
> >> --- a/drivers/acpi/acpica/acglobal.h
> >> +++ b/drivers/acpi/acpica/acglobal.h
> >> @@ -146,6 +146,7 @@ ACPI_GLOBAL(acpi_cache_t *, acpi_gbl_operand_cache=
);
> >>  ACPI_INIT_GLOBAL(u32, acpi_gbl_startup_flags, 0);
> >>  ACPI_INIT_GLOBAL(u8, acpi_gbl_shutdown, TRUE);
> >>  ACPI_INIT_GLOBAL(u8, acpi_gbl_early_initialization, TRUE);
> >> +ACPI_INIT_GLOBAL(u8, acpi_gbl_log_errors_exceptions_as_warnings, FALS=
E);
> >>
> >>  /* Global handlers */
> >>
> >> diff --git a/drivers/acpi/acpica/tbxfload.c b/drivers/acpi/acpica/tbxf=
load.c
> >> index 1971cd7..b0c5478 100644
> >> --- a/drivers/acpi/acpica/tbxfload.c
> >> +++ b/drivers/acpi/acpica/tbxfload.c
> >> @@ -256,6 +256,7 @@ acpi_status acpi_tb_load_namespace(void)
> >>  		}
> >>
> >>  		/* Ignore errors while loading tables, get as many as possible */
> >> +		acpi_gbl_log_errors_exceptions_as_warnings =3D TRUE;
> >>
> >>  		(void)acpi_ut_release_mutex(ACPI_MTX_TABLES);
> >>  		status =3D acpi_ns_load_table(i, acpi_gbl_root_node);
> >> @@ -276,11 +277,12 @@ acpi_status acpi_tb_load_namespace(void)
> >>  			tables_loaded++;
> >>  		}
> >>  	}
> >> +	acpi_gbl_log_errors_exceptions_as_warnings =3D FALSE;
> >>
> >>  	if (!tables_failed) {
> >>  		ACPI_INFO(("%u ACPI AML tables successfully acquired and loaded", t=
ables_loaded));
> >>  	} else {
> >> -		ACPI_ERROR((AE_INFO,
> >> +		ACPI_WARNING((AE_INFO,
> >>  			    "%u table load failures, %u successful",
> >>  			    tables_failed, tables_loaded));
> >>
> >> diff --git a/drivers/acpi/acpica/uterror.c b/drivers/acpi/acpica/uterr=
or.c
> >> index 475932c..e01ff1f 100644
> >> --- a/drivers/acpi/acpica/uterror.c
> >> +++ b/drivers/acpi/acpica/uterror.c
> >> @@ -205,7 +205,10 @@ acpi_ut_namespace_error(const char *module_name,
> >>  	char *name =3D NULL;
> >>
> >>  	ACPI_MSG_REDIRECT_BEGIN;
> >> -	acpi_os_printf(ACPI_MSG_ERROR);
> >> +	if (acpi_gbl_log_errors_exceptions_as_warnings)
> >> +		acpi_os_printf(ACPI_MSG_WARNING);
> >> +	else
> >> +		acpi_os_printf(ACPI_MSG_ERROR);
> >>
> >>  	if (lookup_status =3D=3D AE_BAD_CHARACTER) {
> >>
> >> @@ -269,7 +272,10 @@ acpi_ut_method_error(const char *module_name,
> >>  	struct acpi_namespace_node *node =3D prefix_node;
> >>
> >>  	ACPI_MSG_REDIRECT_BEGIN;
> >> -	acpi_os_printf(ACPI_MSG_ERROR);
> >> +	if (acpi_gbl_log_errors_exceptions_as_warnings)
> >> +		acpi_os_printf(ACPI_MSG_WARNING);
> >> +	else
> >> +		acpi_os_printf(ACPI_MSG_ERROR);
> >>
> >>  	if (path) {
> >>  		status =3D acpi_ns_get_node(prefix_node, path,
> >> diff --git a/drivers/acpi/acpica/utxferror.c b/drivers/acpi/acpica/utx=
ferror.c
> >> index d9f15cb..c8ca25af 100644
> >> --- a/drivers/acpi/acpica/utxferror.c
> >> +++ b/drivers/acpi/acpica/utxferror.c
> >> @@ -73,7 +73,10 @@ acpi_error(const char *module_name, u32 line_number=
, const char *format, ...)
> >>  	va_list arg_list;
> >>
> >>  	ACPI_MSG_REDIRECT_BEGIN;
> >> -	acpi_os_printf(ACPI_MSG_ERROR);
> >> +	if (acpi_gbl_log_errors_exceptions_as_warnings)
> >> +		acpi_os_printf(ACPI_MSG_WARNING);
> >> +	else
> >> +		acpi_os_printf(ACPI_MSG_ERROR);
> >>
> >>  	va_start(arg_list, format);
> >>  	acpi_os_vprintf(format, arg_list);
> >> @@ -107,16 +110,14 @@ acpi_exception(const char *module_name,
> >>  	va_list arg_list;
> >>
> >>  	ACPI_MSG_REDIRECT_BEGIN;
> >> -
> >> -	/* For AE_OK, just print the message */
> >> -
> >> -	if (ACPI_SUCCESS(status)) {
> >> +	if (acpi_gbl_log_errors_exceptions_as_warnings)
> >> +		acpi_os_printf(ACPI_MSG_WARNING);
> >> +	else
> >>  		acpi_os_printf(ACPI_MSG_EXCEPTION);
> >>
> >> -	} else {
> >> -		acpi_os_printf(ACPI_MSG_EXCEPTION "%s, ",
> >> -			       acpi_format_exception(status));
> >> -	}
> >> +	/* For AE_OK, just print the message */
> >> +	if (ACPI_FAILURE(status))
> >> +		acpi_os_printf("%s, ", acpi_format_exception(status));
> >>
> >>  	va_start(arg_list, format);
> >>  	acpi_os_vprintf(format, arg_list);
> >> --
> >> 2.9.3
> >

--===============4682052321727620688==--

