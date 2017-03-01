Content-Type: multipart/mixed; boundary="===============4851617290613244238=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: Re: [Devel] [PATCH] ACPICA: Detect duplicate SSDT tables
Date: Wed, 01 Mar 2017 00:11:11 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37E56833B@ORSMSX110.amr.corp.intel.com>
In-Reply-To: d969d189-d960-cbe2-915c-dbe299bcdbdb@redhat.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============4851617290613244238==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



> -----Original Message-----
> From: Hans de Goede [mailto:hdegoede(a)redhat.com]
> Sent: Tuesday, February 28, 2017 3:45 PM
> To: Moore, Robert; Zheng, Lv; Rafael J . Wysocki; Len Brown
> Cc: linux-acpi(a)vger.kernel.org; devel(a)acpica.org
> Subject: Re: [PATCH] ACPICA: Detect duplicate SSDT tables
> =

> Hi,
> =

> On 28-02-17 16:46, Moore, Robert wrote:
> > Does the machine or machines work properly with Windows? This is always
> one of our early questions.
> =

> Yes although I do not see how that is really relevant or a discussion
> about changing the log level of certain errors ...
> =


Gee, I thought the original discussion was about multiple identical SSDTs, =
which led to this:

    acpi_tb_find_duplicate_ssdt

I would imagine that ACPICA would generate lots of errors as the duplicate =
symbols were found.

What Windows would do is my question.



> Regards,
> =

> Hans
> =

> =

> =

> > Bob
> >
> >
> >> -----Original Message-----
> >> From: Hans de Goede [mailto:hdegoede(a)redhat.com]
> >> Sent: Tuesday, February 28, 2017 6:32 AM
> >> To: Zheng, Lv <lv.zheng(a)intel.com>; Rafael J . Wysocki
> >> <rjw(a)rjwysocki.net>; Len Brown <lenb(a)kernel.org>; Moore, Robert
> >> <robert.moore(a)intel.com>
> >> Cc: linux-acpi(a)vger.kernel.org; devel(a)acpica.org
> >> Subject: Re: [PATCH] ACPICA: Detect duplicate SSDT tables
> >>
> >> Hi,
> >>
> >> On 28-02-17 06:19, Zheng, Lv wrote:
> >>> Hi,
> >>>
> >>>> From: Hans de Goede [mailto:hdegoede(a)redhat.com]
> >>>> Subject: [PATCH] ACPICA: Detect duplicate SSDT tables
> >>>>
> >>>> Some machines have the exact (byte for byte) same SSDT tables
> >>>> multiple times in the root_table_list.
> >>>
> >>> Could you give a machine list here?
> >>
> >> Currently I'm seeing this on a GPD win machine:
> >>
> >> http://www.gpd.hk/gpdwin.asp
> >>
> >> I thought I was seeing it on more machines, but those have different
> >> apci table loading errors...
> >>
> >>>> Detect this and silently skip the duplicates rather then printing a
> >>>> scary looking set of errors.
> >>>
> >>> Why will this matter to OSPMs?
> >>
> >> Not sure what you mean with OSPMs but I can tell you why this matters
> >> in general, Linux distributions like e.g. Fedora have been putting a
> >> lot of work in a smooth boot experience where end users do not get
> >> any scary text messages. For some more embedded like systems this
> >> even is a hard requirement.
> >>
> >> The kernel supports quiet kernel cmdline argument to silence normal
> >> kernel messages, which is part of what is needed but messages with a
> >> log level of error still get shown, breaking the "no scary text
> messages"
> >> product requirement.
> >>
> >>> And should we add non-costless steps just in order to reduce errors,
> >>
> >> Yes we should, work on that front has been happening for years, also
> >> the CPU cost of this check is quite small, memcmp will only happen on
> >> identically sized tables and even then it will exit as soon as a
> >> single byte differs.
> >>
> >>> while the errors are on the contrary useful (in1dicating platform
> >> issues)?
> >>
> >> These errors are useful for developers / during testing but not in
> >> production setups, esp. in the case of duplicate tables where not
> >> loading the duplicate leads to 0 bad side effects.
> >>
> >> I've an alternative proposal though, since this check just fixes a
> >> small part of the early boot messages caused by SSDT loading and
> >> since the code itself chooses to ignore any errors:
> >>
> >>          /* Ignore errors while loading tables, get as many as
> >> possible */
> >>
> >> How about setting a global flag while loading these tables and making
> >>
> >> ACPI_EXCEPTION calls log the exceptions with a log level of warning
> >> as well as turning the final:
> >>
> >>                  ACPI_ERROR((AE_INFO,
> >>                              "%u table load failures, %u successful",
> >>                              tables_failed, tables_loaded));
> >>
> >> Into a warning ?
> >>
> >> Regards,
> >>
> >> Hans
> >>
> >>
> >>
> >>
> >>>
> >>> Thanks
> >>> Lv
> >>>
> >>>>
> >>>> Signed-off-by: Hans de Goede <hdegoede(a)redhat.com>
> >>>> ---
> >>>>  drivers/acpi/acpica/tbxfload.c | 41
> >>>> ++++++++++++++++++++++++++++++++++++++++-
> >>>>  1 file changed, 40 insertions(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/drivers/acpi/acpica/tbxfload.c
> >>>> b/drivers/acpi/acpica/tbxfload.c index 82019c0..1971cd7 100644
> >>>> --- a/drivers/acpi/acpica/tbxfload.c
> >>>> +++ b/drivers/acpi/acpica/tbxfload.c
> >>>> @@ -125,6 +125,44 @@ ACPI_EXPORT_SYMBOL_INIT(acpi_load_tables)
> >>>>
> >>>>
> >> /********************************************************************
> >> ***
> >> ********
> >>>>   *
> >>>> + * FUNCTION:    acpi_tb_find_duplicate_ssdt
> >>>> + *
> >>>> + * PARAMETERS:  table         - validated acpi_table_desc of table
> >> to check
> >>>> + *              index         - index of table to find a duplicate
> >> of
> >>>> + *
> >>>> + * RETURN:      TRUE if a duplicate is found, FALSE if not
> >>>> + *
> >>>> + * DESCRIPTION: Private helper function for acpi_tb_load_namespace
> >> to
> >>>> + *              avoid trying to load duplicate ssdt tables
> >>>> + *
> >>>> +
> >>>> +******************************************************************
> >>>> +** **********/ static u8 acpi_tb_find_duplicate_ssdt(struct
> >>>> +acpi_table_desc *table, u32 index) {
> >>>> +	struct acpi_table_desc *dup;
> >>>> +	u32 i;
> >>>> +
> >>>> +	for (i =3D 0; i < index; ++i) {
> >>>> +		dup =3D &acpi_gbl_root_table_list.tables[i];
> >>>> +
> >>>> +		if (!acpi_gbl_root_table_list.tables[i].address ||
> >>>> +		    (!ACPI_COMPARE_NAME(dup->signature.ascii,
> ACPI_SIG_SSDT)
> >>>> +		     && !ACPI_COMPARE_NAME(dup->signature.ascii,
> >>>> +					   ACPI_SIG_PSDT)
> >>>> +		     && !ACPI_COMPARE_NAME(dup->signature.ascii,
> >>>> +					   ACPI_SIG_OSDT))
> >>>> +		    || ACPI_FAILURE(acpi_tb_validate_table(dup))
> >>>> +		    || dup->length !=3D table->length) {
> >>>> +			continue;
> >>>> +		}
> >>>> +
> >>>> +		if (memcmp(dup->pointer, table->pointer, table->length)
> =3D=3D 0)
> >>>> +			return TRUE;
> >>>> +	}
> >>>> +	return FALSE;
> >>>> +}
> >>>> +
> >>>> +/*****************************************************************
> >>>> +**
> >>>> +************
> >>>> + *
> >>>>   * FUNCTION:    acpi_tb_load_namespace
> >>>>   *
> >>>>   * PARAMETERS:  None
> >>>> @@ -212,7 +250,8 @@ acpi_status acpi_tb_load_namespace(void)
> >>>>  					   ACPI_SIG_PSDT)
> >>>>  		     && !ACPI_COMPARE_NAME(table->signature.ascii,
> >>>>  					   ACPI_SIG_OSDT))
> >>>> -		    || ACPI_FAILURE(acpi_tb_validate_table(table))) {
> >>>> +		    || ACPI_FAILURE(acpi_tb_validate_table(table))
> >>>> +		    || acpi_tb_find_duplicate_ssdt(table, i)) {
> >>>>  			continue;
> >>>>  		}
> >>>>
> >>>> --
> >>>> 2.9.3
> >>>

--===============4851617290613244238==--

