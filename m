Content-Type: multipart/mixed; boundary="===============0214457503553091527=="
MIME-Version: 1.0
From: Ganapatrao Kulkarni <gpkulkarni at gmail.com>
Subject: Re: [Devel] [PATCH 2/2] acpi, gicv3-its,
 numa: Adding numa node mapping for gic-its units
Date: Thu, 15 Jun 2017 16:25:15 +0530
Message-ID: <CAFpQJXUG2fZT2jQu5_z1UCOOX6hCHe-pBE5CLkTXi7Fb+0b5ug@mail.gmail.com>
In-Reply-To: 889cbfe3-e381-2805-7925-11dca09aaa2a@arm.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============0214457503553091527==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 15, 2017 at 4:13 PM, Marc Zyngier <marc.zyngier(a)arm.com> wrot=
e:
> On 15/06/17 11:35, Lorenzo Pieralisi wrote:
>> On Wed, Jun 14, 2017 at 03:23:17PM +0530, Ganapatrao Kulkarni wrote:
>>
>> [...]
>>
>>>>> +static int __init
>>>>> +acpi_parse_its_affinity(struct acpi_subtable_header *header,
>>>>> +                      const unsigned long end)
>>>>> +{
>>>>> +     struct acpi_srat_its_affinity *its_affinity;
>>>>> +
>>>>> +     its_affinity =3D (struct acpi_srat_its_affinity *)header;
>>>>> +     if (!its_affinity)
>>>>> +             return -EINVAL;
>>>>> +
>>>>> +     acpi_table_print_srat_entry(header);
>>
>> You can leave this info printing but see below.

ok.
>>
>>>>> +
>>>>> +     /* let architecture-dependent part to do it */
>>>>> +     acpi_numa_its_affinity_init(its_affinity);
>>>>> +
>>>>> +     return 0;
>>>>> +}
>>>>> +
>>>>>  static int __initdata parsed_numa_memblks;
>>>>>
>>>>>  static int __init
>>>>> @@ -445,7 +473,7 @@ int __init acpi_numa_init(void)
>>>>>
>>>>>       /* SRAT: Static Resource Affinity Table */
>>>>>       if (!acpi_table_parse(ACPI_SIG_SRAT, acpi_parse_srat)) {
>>>>> -             struct acpi_subtable_proc srat_proc[3];
>>>>> +             struct acpi_subtable_proc srat_proc[4];
>>>>>
>>>>>               memset(srat_proc, 0, sizeof(srat_proc));
>>>>>               srat_proc[0].id =3D ACPI_SRAT_TYPE_CPU_AFFINITY;
>>>>> @@ -454,6 +482,8 @@ int __init acpi_numa_init(void)
>>>>>               srat_proc[1].handler =3D acpi_parse_x2apic_affinity;
>>>>>               srat_proc[2].id =3D ACPI_SRAT_TYPE_GICC_AFFINITY;
>>>>>               srat_proc[2].handler =3D acpi_parse_gicc_affinity;
>>>>> +             srat_proc[3].id =3D ACPI_SRAT_TYPE_GIC_ITS_AFFINITY;
>>>>> +             srat_proc[3].handler =3D acpi_parse_its_affinity;
>>>>>
>>>>>               acpi_table_parse_entries_array(ACPI_SIG_SRAT,
>>>>>                                       sizeof(struct acpi_table_srat),
>>>>> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-g=
ic-v3-its.c
>>>>> index 45ea1933..84936da 100644
>>>>> --- a/drivers/irqchip/irq-gic-v3-its.c
>>>>> +++ b/drivers/irqchip/irq-gic-v3-its.c
>>>>> @@ -1861,7 +1861,8 @@ static int __init gic_acpi_parse_madt_its(struc=
t acpi_subtable_header *header,
>>>>>               goto dom_err;
>>>>>       }
>>>>>
>>>>> -     err =3D its_probe_one(&res, dom_handle, NUMA_NO_NODE);
>>>>> +     err =3D its_probe_one(&res, dom_handle,
>>>>> +                     acpi_numa_get_its_nid(its_entry->translation_id=
));
>>>>
>>>> If that's the only usage I wonder whether we really need all arm64
>>>> arch code/data, instead of parsing the SRAT in ITS code driver straight
>>>> away at probe, retrieve its node and be done with this.
>>>>
>>>> I understand you replicated what x86/GICC does with APIC code, I would
>>>> like to understand though if we see a reason why (or better, why we ke=
ep
>>>> the relevant stashed data in arch/arm64 instead of the ITS driver).
>>>
>>> it is been thought to do ITS sub table parse along with other SRAT
>>> tables.  and use the mapping later when ITS devices are
>>> initialised/probed.  IMO, it is more appropriate to keep all SRAT sub
>>> table parsing to same function/place rather than moving to driver.
>>
>> I do not follow. If it is just used in ITS driver code to set the ITS
>> affinity node what's the point of stashing data and adding callbacks
>> when you can simply parse the SRAT and be done with it ?
>>
>> Or you have something on top of these patches that require ITS node
>> information and the calls you added ? If so post the code please.
>>
>> Regardless, it's ITS specific information, ITS is managed through an
>> irqchip driver on ARM64 so even if you decided to stash the SRAT ITS
>> information it does not belong in arch/arm64 IMO, you can implement
>> acpi_numa_its_affinity_init() in the ITS driver but AFAICS for the time
>> being it would be just useless that's the point I am making.
>
> Agreed. As long as there is only the ITS as a consumer of that
> information, there is no need to pollute the rest of the kernel with it.
> Once we have another consumer, we can look at making that code common.
> In the meantime, keeping it in the ITS code is the right thing to do.

agreed, i will change it in next version.

>
> Thanks,
>
>         M.
> --
> Jazz is not dead. It just smells funny...

thanks
Ganapat

--===============0214457503553091527==--

