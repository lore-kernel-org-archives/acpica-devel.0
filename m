Content-Type: multipart/mixed; boundary="===============2118396372413906342=="
MIME-Version: 1.0
From: Zheng, Lv <lv.zheng at intel.com>
Subject: Re: [Devel] [PATCH] ACPICA: Log Exceptions and Errors as warning
 while loading extra tables
Date: Tue, 14 Mar 2017 08:15:28 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E886CE49E37@SHSMSX101.ccr.corp.intel.com>
In-Reply-To: 07925741-3500-8e69-cc78-cd5ec140c7c6@redhat.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============2118396372413906342==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi, Hans

> From: Hans de Goede [mailto:hdegoede(a)redhat.com]
> Subject: Re: [PATCH] ACPICA: Log Exceptions and Errors as warning while l=
oading extra tables
> =

> Hi,
> =

> On 13-03-17 10:52, Zheng, Lv wrote:
> > Hi, Hans
> >
> > For log level issue, is this fix useful for you?
> > https://github.com/acpica/acpica/pull/121/commits/a505d3942
> =

> That fixes reloading already loaded tables, the problem I'm
> getting errors about its loading a different table with identical
> contents.
> =

> I will look into your suggestion to do something similar to
> AcpiTbInstallStandardTable using AcpiTbCompareTables for the
> SSDT tables. I will send a new patch when I can make some time
> to look into this.

I just completed a prototype here:
https://github.com/acpica/acpica/pull/121

I guess the original "duplicate table check" couldn't cover static SSDTs.
Actually the duplicate table check should be a sanity check of table load.
And for table install, we should have a different sanity check like:
https://github.com/acpica/acpica/pull/121/commits/6e825cae5e5
I'm not sure if this is what you want.

Thanks
Lv

> =

> Regards,
> =

> Hans
> =

> =

> =

> >
> > Thanks and best regards
> > Lv
> >
> >> From: Hans de Goede [mailto:hdegoede(a)redhat.com]
> >> Subject: Re: [PATCH] ACPICA: Log Exceptions and Errors as warning whil=
e loading extra tables
> >>
> >> Hi,
> >>
> >> On 03-03-17 03:48, Zheng, Lv wrote:
> >>> Hi,
> >>>
> >>>> From: Hans de Goede [mailto:hdegoede(a)redhat.com]
> >>>> Subject: Re: [PATCH] ACPICA: Log Exceptions and Errors as warning wh=
ile loading extra tables
> >>>>
> >>>> Hi,
> >>>>
> >>>> On 02-03-17 03:03, Zheng, Lv wrote:
> >>>>> Hi,
> >>>>>
> >>>>>> From: Hans de Goede [mailto:hdegoede(a)redhat.com]
> >>>>>> Subject: [PATCH] ACPICA: Log Exceptions and Errors as warning whil=
e loading extra tables
> >>>>>>
> >>>>>> Honor the "Ignore errors while loading tables, get as many as poss=
ible"
> >>>>>> comment in the tbxfload.c code and log any exceptions and errors d=
uring
> >>>>>> loading extra tables as warnings.
> >>>>>>
> >>>>>> This is important because many desktop and embedded applicance Lin=
ux
> >>>>>> use-cases have a hard requirement of not showing any (scary) text
> >>>>>> messages during system bootup, which get broken by errors reported
> >>>>>> by attempts to load the extra tables, as messaged logged at a KERN=
_ERR
> >>>>>> level are always shown even if the quiet kernel cmdline option is =
used.
> >>>>>
> >>>>> This looks worse than comparing the tables.
> >>>>
> >>>> This is really another patch entirely, it would also make the duplic=
ate
> >>>> table thing less of an issue, but even with a fix for the duplicate =
tables
> >>>> we still need something like this to lower the log level of errors w=
hile
> >>>> loading extra tables as that currently causes errors to be spewn on
> >>>> way to many machines, e.g. on my main workstation I get:
> >>>>
> >>>> [    0.019856] ACPI Warning: [\_SB_.PCI0.XHC_.RHUB.HS11] Namespace l=
ookup failure, AE_NOT_FOUND
> >>>> (20160930/dswload-210)
> >>>> [    0.019859] ACPI Warning: AE_NOT_FOUND, During name lookup/catalo=
g (20160930/psobject-227)
> >>>> [    0.019886] ACPI Warning: AE_NOT_FOUND, (SSDT:xh_rvp08) while loa=
ding table
> (20160930/tbxfload-
> >> 268)
> >>>> [    0.026491] ACPI Warning: 1 table load failures, 5 successful (20=
160930/tbxfload-287)
> >>>
> >>> However some of them indicating a real issue that can be fixed by:
> >>> 1. Merging this pull request: https://github.com/acpica/acpica/pull/1=
89 (I made it no longer
> >> dependent on other fixes)
> >>> 2. Setting acpi_gbl_parse_table_as_term_list to TRUE.
> >>> It's not far away than actually solving the real issues.
> >>> So why do we use a one-size-fits-all solution for such kind of errors?
> >>
> >> Ok, I agree that doing proper fixes for errors like this is better,
> >> so lets drop this patch.
> >>
> >> Regards,
> >>
> >> Hans
> >>
> >>
> >>>
> >>> Thanks and best regards
> >>> Lv
> >>>
> >>>
> >>>>
> >>>> (this is with the patch, before that this were all errors and except=
ions).
> >>>>
> >>>> Add IIRC I'm getting yet another set of errors on my XPS 15, etc.
> >>>>
> >>>> Regards,
> >>>>
> >>>> Hans
> >>>>
> >>>>
> >>>>
> >>>>> So before determining what should be done for the check of the dupl=
icated aml tables.
> >>>>> Let's skip this submission.
> >>>>>
> >>>>> Thanks
> >>>>> Lv
> >>>>>
> >>>>>>
> >>>>>> Signed-off-by: Hans de Goede <hdegoede(a)redhat.com>
> >>>>>> ---
> >>>>>>  drivers/acpi/acpica/acglobal.h  |  1 +
> >>>>>>  drivers/acpi/acpica/tbxfload.c  |  4 +++-
> >>>>>>  drivers/acpi/acpica/uterror.c   | 10 ++++++++--
> >>>>>>  drivers/acpi/acpica/utxferror.c | 19 ++++++++++---------
> >>>>>>  4 files changed, 22 insertions(+), 12 deletions(-)
> >>>>>>
> >>>>>> diff --git a/drivers/acpi/acpica/acglobal.h b/drivers/acpi/acpica/=
acglobal.h
> >>>>>> index edbb42e..5ae9eee 100644
> >>>>>> --- a/drivers/acpi/acpica/acglobal.h
> >>>>>> +++ b/drivers/acpi/acpica/acglobal.h
> >>>>>> @@ -146,6 +146,7 @@ ACPI_GLOBAL(acpi_cache_t *, acpi_gbl_operand_c=
ache);
> >>>>>>  ACPI_INIT_GLOBAL(u32, acpi_gbl_startup_flags, 0);
> >>>>>>  ACPI_INIT_GLOBAL(u8, acpi_gbl_shutdown, TRUE);
> >>>>>>  ACPI_INIT_GLOBAL(u8, acpi_gbl_early_initialization, TRUE);
> >>>>>> +ACPI_INIT_GLOBAL(u8, acpi_gbl_log_errors_exceptions_as_warnings, =
FALSE);
> >>>>>>
> >>>>>>  /* Global handlers */
> >>>>>>
> >>>>>> diff --git a/drivers/acpi/acpica/tbxfload.c b/drivers/acpi/acpica/=
tbxfload.c
> >>>>>> index 1971cd7..b0c5478 100644
> >>>>>> --- a/drivers/acpi/acpica/tbxfload.c
> >>>>>> +++ b/drivers/acpi/acpica/tbxfload.c
> >>>>>> @@ -256,6 +256,7 @@ acpi_status acpi_tb_load_namespace(void)
> >>>>>>  		}
> >>>>>>
> >>>>>>  		/* Ignore errors while loading tables, get as many as possible =
*/
> >>>>>> +		acpi_gbl_log_errors_exceptions_as_warnings =3D TRUE;
> >>>>>>
> >>>>>>  		(void)acpi_ut_release_mutex(ACPI_MTX_TABLES);
> >>>>>>  		status =3D acpi_ns_load_table(i, acpi_gbl_root_node);
> >>>>>> @@ -276,11 +277,12 @@ acpi_status acpi_tb_load_namespace(void)
> >>>>>>  			tables_loaded++;
> >>>>>>  		}
> >>>>>>  	}
> >>>>>> +	acpi_gbl_log_errors_exceptions_as_warnings =3D FALSE;
> >>>>>>
> >>>>>>  	if (!tables_failed) {
> >>>>>>  		ACPI_INFO(("%u ACPI AML tables successfully acquired and loaded=
", tables_loaded));
> >>>>>>  	} else {
> >>>>>> -		ACPI_ERROR((AE_INFO,
> >>>>>> +		ACPI_WARNING((AE_INFO,
> >>>>>>  			    "%u table load failures, %u successful",
> >>>>>>  			    tables_failed, tables_loaded));
> >>>>>>
> >>>>>> diff --git a/drivers/acpi/acpica/uterror.c b/drivers/acpi/acpica/u=
terror.c
> >>>>>> index 475932c..e01ff1f 100644
> >>>>>> --- a/drivers/acpi/acpica/uterror.c
> >>>>>> +++ b/drivers/acpi/acpica/uterror.c
> >>>>>> @@ -205,7 +205,10 @@ acpi_ut_namespace_error(const char *module_na=
me,
> >>>>>>  	char *name =3D NULL;
> >>>>>>
> >>>>>>  	ACPI_MSG_REDIRECT_BEGIN;
> >>>>>> -	acpi_os_printf(ACPI_MSG_ERROR);
> >>>>>> +	if (acpi_gbl_log_errors_exceptions_as_warnings)
> >>>>>> +		acpi_os_printf(ACPI_MSG_WARNING);
> >>>>>> +	else
> >>>>>> +		acpi_os_printf(ACPI_MSG_ERROR);
> >>>>>>
> >>>>>>  	if (lookup_status =3D=3D AE_BAD_CHARACTER) {
> >>>>>>
> >>>>>> @@ -269,7 +272,10 @@ acpi_ut_method_error(const char *module_name,
> >>>>>>  	struct acpi_namespace_node *node =3D prefix_node;
> >>>>>>
> >>>>>>  	ACPI_MSG_REDIRECT_BEGIN;
> >>>>>> -	acpi_os_printf(ACPI_MSG_ERROR);
> >>>>>> +	if (acpi_gbl_log_errors_exceptions_as_warnings)
> >>>>>> +		acpi_os_printf(ACPI_MSG_WARNING);
> >>>>>> +	else
> >>>>>> +		acpi_os_printf(ACPI_MSG_ERROR);
> >>>>>>
> >>>>>>  	if (path) {
> >>>>>>  		status =3D acpi_ns_get_node(prefix_node, path,
> >>>>>> diff --git a/drivers/acpi/acpica/utxferror.c b/drivers/acpi/acpica=
/utxferror.c
> >>>>>> index d9f15cb..c8ca25af 100644
> >>>>>> --- a/drivers/acpi/acpica/utxferror.c
> >>>>>> +++ b/drivers/acpi/acpica/utxferror.c
> >>>>>> @@ -73,7 +73,10 @@ acpi_error(const char *module_name, u32 line_nu=
mber, const char *format, ...)
> >>>>>>  	va_list arg_list;
> >>>>>>
> >>>>>>  	ACPI_MSG_REDIRECT_BEGIN;
> >>>>>> -	acpi_os_printf(ACPI_MSG_ERROR);
> >>>>>> +	if (acpi_gbl_log_errors_exceptions_as_warnings)
> >>>>>> +		acpi_os_printf(ACPI_MSG_WARNING);
> >>>>>> +	else
> >>>>>> +		acpi_os_printf(ACPI_MSG_ERROR);
> >>>>>>
> >>>>>>  	va_start(arg_list, format);
> >>>>>>  	acpi_os_vprintf(format, arg_list);
> >>>>>> @@ -107,16 +110,14 @@ acpi_exception(const char *module_name,
> >>>>>>  	va_list arg_list;
> >>>>>>
> >>>>>>  	ACPI_MSG_REDIRECT_BEGIN;
> >>>>>> -
> >>>>>> -	/* For AE_OK, just print the message */
> >>>>>> -
> >>>>>> -	if (ACPI_SUCCESS(status)) {
> >>>>>> +	if (acpi_gbl_log_errors_exceptions_as_warnings)
> >>>>>> +		acpi_os_printf(ACPI_MSG_WARNING);
> >>>>>> +	else
> >>>>>>  		acpi_os_printf(ACPI_MSG_EXCEPTION);
> >>>>>>
> >>>>>> -	} else {
> >>>>>> -		acpi_os_printf(ACPI_MSG_EXCEPTION "%s, ",
> >>>>>> -			       acpi_format_exception(status));
> >>>>>> -	}
> >>>>>> +	/* For AE_OK, just print the message */
> >>>>>> +	if (ACPI_FAILURE(status))
> >>>>>> +		acpi_os_printf("%s, ", acpi_format_exception(status));
> >>>>>>
> >>>>>>  	va_start(arg_list, format);
> >>>>>>  	acpi_os_vprintf(format, arg_list);
> >>>>>> --
> >>>>>> 2.9.3
> >>>>>

--===============2118396372413906342==--

