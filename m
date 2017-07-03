Content-Type: multipart/mixed; boundary="===============8328435719354433544=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: Re: [Devel] [PATCH] ACPI: SPCR: Use access width to determine mmio
 usage
Date: Mon, 03 Jul 2017 20:56:04 +0200
Message-ID: <CAJZ5v0gLxoS2Tu-DO_8yEWMm2b273U3PdQx31otcYe8as-fEXA@mail.gmail.com>
In-Reply-To: CAPw-ZTmK7bwbKG+nFuq9tcbyJDrMKpf3itt1WogApfK5-jsoBg@mail.gmail.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============8328435719354433544==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 3, 2017 at 8:27 PM, Loc Ho <lho(a)apm.com> wrote:
> Hi Rafael,
>
>>>>> >> >>>>>> The current SPCR code does not check the access width of th=
e mmio, and
>>>>> >> >>>>>> uses a default of 8bit register accesses.  This prevents de=
vices that
>>>>> >> >>>>>> only do 16 or 32bit register accesses from working.  By sim=
ply checking
>>>>> >> >>>>>> this field and setting the mmio string appropriately, this =
issue can be
>>>>> >> >>>>>> corrected.  To prevent any legacy issues, the code will def=
ault to 8bit
>>>>> >> >>>>>> accesses if the value is anything but 16 or 32.
>>>>> >> >>>>>
>>>>> >> >>>>> Thanks for this. Just as an FYI I've a running discussion wi=
th Microsoft
>>>>> >> >>>>> about defining additional UART subtypes in the DBG2 for spec=
ial case
>>>>> >> >>>>> UARTs. Specifically, I want to address AppliedMicro's specia=
l 8250 dw IP
>>>>> >> >>>>> that also has a non-standard clock. At this time, there is g=
eneral
>>>>> >> >>>>> agreement to use the access width for some cases rather than=
 defining
>>>>> >> >>>>> yet more subtypes - so your patch is good.
>>>>> >> >>>>>
>>>>> >> >>>>> Loc/Applied: please track this thread, incorporate feedback,=
 and also
>>>>> >> >>>>> track the other general recent discussions of 8250 dw from t=
his week.
>>>>> >> >>>>
>>>>> >> >>>> Thanks for forward me this patch. This patch does not work wi=
th X-Gene
>>>>> >> >>>> v1 and v2 SoC's. As BIOS SPCR encodes these info as:
>>>>> >> >>>>
>>>>> >> >>>> Bit Width: 32
>>>>> >> >>>> Bit Offset: 0
>>>>> >> >>>> Encoded Access Width: 01 (Byte Access)
>>>>> >> >>>>
>>>>> >> >>>> With this patch, it would use the "mmio" instead the "mmio32"=
 as with
>>>>> >> >>>> this patch - https://patchwork.kernel.org/patch/9460959
>>>>> >> >>>
>>>>> >> >>> I think this is why we need the DBG2 subtype for Applied X-Gen=
e1. I'm
>>>>> >> >>> hoping the update to the SPCR/DBG2 spec is done soon.
>>>>> >> >>
>>>>> >> >> We can't rely on the BIOS change to support this new subtype as=
 we
>>>>> >> >> have system that is already in production deployment. When these
>>>>> >> >> system upgrade to new version of the OS (stock, RHELSA, or what=
ever),
>>>>> >> >> they will break. We need the patch from
>>>>> >> >> https://patchwork.kernel.org/patch/9460959/ rolled upstream.
>>>>> >> >
>>>>> >> > There is no reason why the patch you reference cannot co-exist w=
ith
>>>>> >> > the one I am submitting here.  In this case, my patch would set =
it to
>>>>> >> > mmio, then the patch you link above would reset it to mmio32.
>>>>> >> > Personally, I would recommend a big, fat comment on why this ext=
ra
>>>>> >> > step is necessary, but it should work as desired.  Alternatively=
, we
>>>>> >> > could add some kind of quirk library (similar to
>>>>> >> > qdf2400_erratum_44_present) where the OEM/OEM Table ID is refere=
nced
>>>>> >> > and workaround applied.  Thoughts?
>>>>> >>
>>>>> >> That's was my first version but after seeing both versions, I think
>>>>> >> they are better solution as it works for more SoC's than just our.=
 As
>>>>> >> you had suggested, we should apply your patch and
>>>>> >> https://patchwork.kernel.org/patch/9460959. The third patch -
>>>>> >> https://patchwork.kernel.org/patch/9462183/ - conflicts with your.
>>>>> >>
>>>>> >> Summary:
>>>>> >> 1. Applied your - https://lkml.org/lkml/2017/5/4/450
>>>>> >> 2. Applied this one - https://patchwork.kernel.org/patch/9460959/
>>>>> >>
>>>>> >> -Loc
>>>>> >
>>>>> > What if we simply applied the following (100% untested) patch to add
>>>>> > the quirk framework I was suggesting?  It can be applied on top of =
the
>>>>> > patch I submitted previously.
>>>>>
>>>>> It is a bit more complex that this simple patch. How about this one
>>>>> (my original version). As for Jon Master question on McDivitt, not
>>>>> sure what they use for the ACPI table for SPCR. If they used our
>>>>> reference, then this might work for them too. This version would limit
>>>>> to just the existent firmware or until the SPCR table gets changed.
>>>>>
>>>>>
>>>>> tty: 8250: Workaround for APM X-Gene 8250 UART 32-alignment errata
>>>>>
>>>>> APM X-Gene verion 1 and 2 have an 8250 UART with its register
>>>>> aligned to 32-bit. The SPCR always assumes fully compatible
>>>>> 8250. This causes no console with ACPI boot as the console
>>>>> will not match X-Gene UART port due to the lack of mmio32
>>>>> option.
>>>>>
>>>>> Signed-off-by: Loc Ho <lho(a)apm.com>
>>>>> ---
>>>>>  drivers/acpi/spcr.c | 21 +++++++++++++++++++++
>>>>>  1 file changed, 21 insertions(+)
>>>>>
>>>>> diff --git a/drivers/acpi/spcr.c b/drivers/acpi/spcr.c
>>>>> index 3afa8c1..77b45a0 100644
>>>>> --- a/drivers/acpi/spcr.c
>>>>> +++ b/drivers/acpi/spcr.c
>>>>> @@ -36,6 +36,25 @@ static bool qdf2400_erratum_44_present(struct
>>>>> acpi_table_header *h)
>>>>>         return false;
>>>>>  }
>>>>>
>>>>> +/*
>>>>> + * APM X-Gene v1 and v2 UART hardware is an 16550 like device but ha=
s its
>>>>> + * register aligned to 32-bit. This function detects this errata con=
dition.
>>>>> + */
>>>>> +static bool xgene_8250_erratum_present(struct acpi_table_spcr *tb)
>>>>> +{
>>>>> +       if (tb->interface_type !=3D ACPI_DBG2_16550_COMPATIBLE)
>>>>> +               return false;
>>>>> +
>>>>> +       if (memcmp(tb->header.oem_id, "APMC0D", ACPI_OEM_ID_SIZE))
>>>>> +               return false;
>>>>> +
>>>>> +       if (!memcmp(tb->header.oem_table_id, "XGENESPC",
>>>>> +                   ACPI_OEM_TABLE_ID_SIZE) && tb->header.oem_revisio=
n =3D=3D 0)
>>>>> +               return true;
>>>>> +
>>>>> +       return false;
>>>>> +}
>>>>> +
>>>>>  /**
>>>>>   * parse_spcr() - parse ACPI SPCR table and add preferred console
>>>>>   *
>>>>> @@ -115,6 +134,8 @@ int __init parse_spcr(bool earlycon)
>>>>>
>>>>>         if (qdf2400_erratum_44_present(&table->header))
>>>>>                 uart =3D "qdf2400_e44";
>>>>> +       if (xgene_8250_erratum_present(table))
>>>>> +               iotype =3D "mmio32";
>>>>>
>>>>>         snprintf(opts, sizeof(opts), "%s,%s,0x%llx,%d", uart, iotype,
>>>>>                  table->serial_port.address, baud_rate);
>>>>>
>>>>
>>>> I didn't see a follow up email on this. What was the conclusion to
>>>> this patch series?
>>>
>>> I have not received an ack, nack, or gtfo from any of the maintainers
>>> of this file.  Per
>>> ./scripts/get_maintainer.pl drivers/acpi/spcr.c
>>> "Rafael J. Wysocki" <rjw(a)rjwysocki.net> (supporter:ACPI)
>>> Len Brown <lenb(a)kernel.org> (supporter:ACPI)
>>> linux-acpi(a)vger.kernel.org (open list:ACPI)
>>> linux-kernel(a)vger.kernel.org (open list)
>>>
>>> Is there someone else I should be directing this patch through?
>>
>> Generally, whoever is going to be affected by this change.
>>
>> git seems to tell me that the spcr.c file went in through the tty tree
>> and Aleksey introduced it.
>>
>> I can apply it if no one has any objections.
>
> I think this is on the mailing list long enough and I don't see anyone
> follow up with any objection. Would you applies Jon Mason patch and my
> patch on May 8 or inline below? If you need a more formal patch email
> for the below patch, I can send one to this email list as well.

Yes, I do.

Actually, please send both patches as a series with CCs to Greg and
Aleksey.  You can add your sign off to the resend of the Jon's patch.

Thanks,
Rafael

--===============8328435719354433544==--

