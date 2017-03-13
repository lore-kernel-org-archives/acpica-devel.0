Content-Type: multipart/mixed; boundary="===============4428989731035139348=="
MIME-Version: 1.0
From: Zheng, Lv <lv.zheng at intel.com>
Subject: Re: [Devel] [PATCH] ACPICA: Detect duplicate SSDT tables
Date: Mon, 13 Mar 2017 06:01:31 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E886CE4934B@SHSMSX101.ccr.corp.intel.com>
In-Reply-To: 1d07f8ff-9672-7141-90c4-3d67c6e23f0f@redhat.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============4428989731035139348==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi, Hans

I noticed that in AcpiTbInstallStandardTable(), there is a similar check:
        for (i =3D 0; i < AcpiGbl_RootTableList.CurrentTableCount; ++i)
        {
            /*
             * Check for a table match on the entire table length,
             * not just the header.
             */
            if (!AcpiTbCompareTables (&NewTableDesc, i))
            {
                continue;
            }
Could you check and tell us why this cannot cover your use case?
Is your use case related to the LoadTable opcode?
Thanks in advance.

Best regards
Lv

> From: Hans de Goede [mailto:hdegoede(a)redhat.com]
> Subject: Re: [PATCH] ACPICA: Detect duplicate SSDT tables
> =

> Hi,
> =

> On 03-03-17 03:50, Zheng, Lv wrote:
> > Hi,
> >
> >> From: Hans de Goede [mailto:hdegoede(a)redhat.com]
> >> Subject: Re: [PATCH] ACPICA: Detect duplicate SSDT tables
> >>
> >> Hi,
> >>
> >> On 02-03-17 02:59, Zheng, Lv wrote:
> >>> Hi,
> >>>
> >>>> From: Hans de Goede [mailto:hdegoede(a)redhat.com]
> >>>> Subject: Re: [PATCH] ACPICA: Detect duplicate SSDT tables
> >>>>
> >>>> Hi,
> >>>>
> >>>> On 01-03-17 04:21, Zheng, Lv wrote:
> >>>>> Hi,
> >>>>>
> >>>>>> From: Hans de Goede [mailto:hdegoede(a)redhat.com]
> >>>>>> Subject: Re: [PATCH] ACPICA: Detect duplicate SSDT tables
> >>>>>>
> >>>>>> Hi,
> >>>>>>
> >>>>>> On 28-02-17 06:19, Zheng, Lv wrote:
> >>>>>>> Hi,
> >>>>>>>
> >>>>>>>> From: Hans de Goede [mailto:hdegoede(a)redhat.com]
> >>>>>>>> Subject: [PATCH] ACPICA: Detect duplicate SSDT tables
> >>>>>>>>
> >>>>>>>> Some machines have the exact (byte for byte) same SSDT tables mu=
ltiple
> >>>>>>>> times in the root_table_list.
> >>
> >> <snip>
> >>
> >>>>>>>> Detect this and silently skip the duplicates
> >>>>>>>> rather then printing a scary looking set of errors.
> >>
> >> <snip>
> >>
> >>>>>>>> Signed-off-by: Hans de Goede <hdegoede(a)redhat.com>
> >>>>>>>> ---
> >>>>>>>>  drivers/acpi/acpica/tbxfload.c | 41 +++++++++++++++++++++++++++=
+++++++++++++-
> >>>>>>>>  1 file changed, 40 insertions(+), 1 deletion(-)
> >>>>>>>>
> >>>>>>>> diff --git a/drivers/acpi/acpica/tbxfload.c b/drivers/acpi/acpic=
a/tbxfload.c
> >>>>>>>> index 82019c0..1971cd7 100644
> >>>>>>>> --- a/drivers/acpi/acpica/tbxfload.c
> >>>>>>>> +++ b/drivers/acpi/acpica/tbxfload.c
> >>>>>>>> @@ -125,6 +125,44 @@ ACPI_EXPORT_SYMBOL_INIT(acpi_load_tables)
> >>>>>>>>
> >>>>>>>>  /**************************************************************=
*****************
> >>>>>>>>   *
> >>>>>>>> + * FUNCTION:    acpi_tb_find_duplicate_ssdt
> >>>>>>>> + *
> >>>>>>>> + * PARAMETERS:  table         - validated acpi_table_desc of ta=
ble to check
> >>>>>>>> + *              index         - index of table to find a duplic=
ate of
> >>>>>>>> + *
> >>>>>>>> + * RETURN:      TRUE if a duplicate is found, FALSE if not
> >>>>>>>> + *
> >>>>>>>> + * DESCRIPTION: Private helper function for acpi_tb_load_namesp=
ace to
> >>>>>>>> + *              avoid trying to load duplicate ssdt tables
> >>>>>>>> + *
> >>>>>>>> + **************************************************************=
****************/
> >>>>>>>> +static u8 acpi_tb_find_duplicate_ssdt(struct acpi_table_desc *t=
able, u32 index)
> >>>
> >>> If you really want to add this.
> >>> My suggestion is:
> >>> Invoke this function in acpi_tb_verify_temp_table().
> >>> This is the function we use to verify if a table is OK.
> >>> Otherwise it won't be installed to the global table list.
> >>>
> >>> And the name should contain "aml_table" or "aml" rather than "ssdt" a=
ccording to your check below.
> >>
> >> Ok, when I've some time I will do a new version moving the functionali=
ty
> >> to acpi_tb_verify_temp_table(). I will post a v2 with this change when
> >> it is ready. I will also just compare the headers then as suggested in
> >> other replies in this thread.
> >
> > If you wish, I can offer help here.
> > It actually won't take me much time to generate such a change.
> =

> Great, if you can send me a new patch to test I'm more then willing
> to make time to test it.
> =

> Thanks & Regards,
> =

> Hans

--===============4428989731035139348==--

