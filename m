Content-Type: multipart/mixed; boundary="===============6473341312291854598=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: Re: [Devel] [PATCH] ACPI: SPCR: Use access width to determine mmio
 usage
Date: Tue, 20 Jun 2017 23:43:51 +0200
Message-ID: <CAJZ5v0jDiOUNYz-iZ0dox1SRbVLYoRVtzaTUivyCEwVHE2jD1Q@mail.gmail.com>
In-Reply-To: CAC3K-4rAt0CZ2=45uJyR5PPJctxVzL0_wKv9j+1UTE+BWVx5uw@mail.gmail.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============6473341312291854598==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 20, 2017 at 11:27 PM, Jon Mason <jon.mason(a)broadcom.com> wrot=
e:
> On Tue, Jun 20, 2017 at 2:33 PM, Loc Ho <lho(a)apm.com> wrote:
>> Hi Jon,
>>
>>>
>>> >> >>>>>> The current SPCR code does not check the access width of the =
mmio, and
>>> >> >>>>>> uses a default of 8bit register accesses.  This prevents devi=
ces that
>>> >> >>>>>> only do 16 or 32bit register accesses from working.  By simpl=
y checking
>>> >> >>>>>> this field and setting the mmio string appropriately, this is=
sue can be
>>> >> >>>>>> corrected.  To prevent any legacy issues, the code will defau=
lt to 8bit
>>> >> >>>>>> accesses if the value is anything but 16 or 32.
>>> >> >>>>>
>>> >> >>>>> Thanks for this. Just as an FYI I've a running discussion with=
 Microsoft
>>> >> >>>>> about defining additional UART subtypes in the DBG2 for specia=
l case
>>> >> >>>>> UARTs. Specifically, I want to address AppliedMicro's special =
8250 dw IP
>>> >> >>>>> that also has a non-standard clock. At this time, there is gen=
eral
>>> >> >>>>> agreement to use the access width for some cases rather than d=
efining
>>> >> >>>>> yet more subtypes - so your patch is good.
>>> >> >>>>>
>>> >> >>>>> Loc/Applied: please track this thread, incorporate feedback, a=
nd also
>>> >> >>>>> track the other general recent discussions of 8250 dw from thi=
s week.
>>> >> >>>>
>>> >> >>>> Thanks for forward me this patch. This patch does not work with=
 X-Gene
>>> >> >>>> v1 and v2 SoC's. As BIOS SPCR encodes these info as:
>>> >> >>>>
>>> >> >>>> Bit Width: 32
>>> >> >>>> Bit Offset: 0
>>> >> >>>> Encoded Access Width: 01 (Byte Access)
>>> >> >>>>
>>> >> >>>> With this patch, it would use the "mmio" instead the "mmio32" a=
s with
>>> >> >>>> this patch - https://patchwork.kernel.org/patch/9460959
>>> >> >>>
>>> >> >>> I think this is why we need the DBG2 subtype for Applied X-Gene1=
. I'm
>>> >> >>> hoping the update to the SPCR/DBG2 spec is done soon.
>>> >> >>
>>> >> >> We can't rely on the BIOS change to support this new subtype as we
>>> >> >> have system that is already in production deployment. When these
>>> >> >> system upgrade to new version of the OS (stock, RHELSA, or whatev=
er),
>>> >> >> they will break. We need the patch from
>>> >> >> https://patchwork.kernel.org/patch/9460959/ rolled upstream.
>>> >> >
>>> >> > There is no reason why the patch you reference cannot co-exist with
>>> >> > the one I am submitting here.  In this case, my patch would set it=
 to
>>> >> > mmio, then the patch you link above would reset it to mmio32.
>>> >> > Personally, I would recommend a big, fat comment on why this extra
>>> >> > step is necessary, but it should work as desired.  Alternatively, =
we
>>> >> > could add some kind of quirk library (similar to
>>> >> > qdf2400_erratum_44_present) where the OEM/OEM Table ID is referenc=
ed
>>> >> > and workaround applied.  Thoughts?
>>> >>
>>> >> That's was my first version but after seeing both versions, I think
>>> >> they are better solution as it works for more SoC's than just our. As
>>> >> you had suggested, we should apply your patch and
>>> >> https://patchwork.kernel.org/patch/9460959. The third patch -
>>> >> https://patchwork.kernel.org/patch/9462183/ - conflicts with your.
>>> >>
>>> >> Summary:
>>> >> 1. Applied your - https://lkml.org/lkml/2017/5/4/450
>>> >> 2. Applied this one - https://patchwork.kernel.org/patch/9460959/
>>> >>
>>> >> -Loc
>>> >
>>> > What if we simply applied the following (100% untested) patch to add
>>> > the quirk framework I was suggesting?  It can be applied on top of the
>>> > patch I submitted previously.
>>>
>>> It is a bit more complex that this simple patch. How about this one
>>> (my original version). As for Jon Master question on McDivitt, not
>>> sure what they use for the ACPI table for SPCR. If they used our
>>> reference, then this might work for them too. This version would limit
>>> to just the existent firmware or until the SPCR table gets changed.
>>>
>>>
>>> tty: 8250: Workaround for APM X-Gene 8250 UART 32-alignment errata
>>>
>>> APM X-Gene verion 1 and 2 have an 8250 UART with its register
>>> aligned to 32-bit. The SPCR always assumes fully compatible
>>> 8250. This causes no console with ACPI boot as the console
>>> will not match X-Gene UART port due to the lack of mmio32
>>> option.
>>>
>>> Signed-off-by: Loc Ho <lho(a)apm.com>
>>> ---
>>>  drivers/acpi/spcr.c | 21 +++++++++++++++++++++
>>>  1 file changed, 21 insertions(+)
>>>
>>> diff --git a/drivers/acpi/spcr.c b/drivers/acpi/spcr.c
>>> index 3afa8c1..77b45a0 100644
>>> --- a/drivers/acpi/spcr.c
>>> +++ b/drivers/acpi/spcr.c
>>> @@ -36,6 +36,25 @@ static bool qdf2400_erratum_44_present(struct
>>> acpi_table_header *h)
>>>         return false;
>>>  }
>>>
>>> +/*
>>> + * APM X-Gene v1 and v2 UART hardware is an 16550 like device but has =
its
>>> + * register aligned to 32-bit. This function detects this errata condi=
tion.
>>> + */
>>> +static bool xgene_8250_erratum_present(struct acpi_table_spcr *tb)
>>> +{
>>> +       if (tb->interface_type !=3D ACPI_DBG2_16550_COMPATIBLE)
>>> +               return false;
>>> +
>>> +       if (memcmp(tb->header.oem_id, "APMC0D", ACPI_OEM_ID_SIZE))
>>> +               return false;
>>> +
>>> +       if (!memcmp(tb->header.oem_table_id, "XGENESPC",
>>> +                   ACPI_OEM_TABLE_ID_SIZE) && tb->header.oem_revision =
=3D=3D 0)
>>> +               return true;
>>> +
>>> +       return false;
>>> +}
>>> +
>>>  /**
>>>   * parse_spcr() - parse ACPI SPCR table and add preferred console
>>>   *
>>> @@ -115,6 +134,8 @@ int __init parse_spcr(bool earlycon)
>>>
>>>         if (qdf2400_erratum_44_present(&table->header))
>>>                 uart =3D "qdf2400_e44";
>>> +       if (xgene_8250_erratum_present(table))
>>> +               iotype =3D "mmio32";
>>>
>>>         snprintf(opts, sizeof(opts), "%s,%s,0x%llx,%d", uart, iotype,
>>>                  table->serial_port.address, baud_rate);
>>>
>>
>> I didn't see a follow up email on this. What was the conclusion to
>> this patch series?
>
> I have not received an ack, nack, or gtfo from any of the maintainers
> of this file.  Per
> ./scripts/get_maintainer.pl drivers/acpi/spcr.c
> "Rafael J. Wysocki" <rjw(a)rjwysocki.net> (supporter:ACPI)
> Len Brown <lenb(a)kernel.org> (supporter:ACPI)
> linux-acpi(a)vger.kernel.org (open list:ACPI)
> linux-kernel(a)vger.kernel.org (open list)
>
> Is there someone else I should be directing this patch through?

Generally, whoever is going to be affected by this change.

git seems to tell me that the spcr.c file went in through the tty tree
and Aleksey introduced it.

I can apply it if no one has any objections.

Thanks,
Rafael

--===============6473341312291854598==--

