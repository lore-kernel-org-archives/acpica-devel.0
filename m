Content-Type: multipart/mixed; boundary="===============8453899653051798835=="
MIME-Version: 1.0
From: Hanjun Guo <hanjun.guo at linaro.org>
Subject: Re: [Devel] [PATCH v6 13/14] arm64, acpi,
 numa: NUMA support based on SRAT and SLIT
Date: Thu, 12 May 2016 01:03:39 +0000
Message-ID: <5733D660.7030604@linaro.org>
In-Reply-To: 5733C8F5.6090206@caviumnetworks.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============8453899653051798835==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 2016/5/12 8:06, David Daney wrote:
> On 05/11/2016 03:39 AM, Catalin Marinas wrote:
>> On Wed, Apr 27, 2016 at 11:07:15AM -0700, David Daney wrote:
>>> +static int __init get_mpidr_in_madt(int acpi_id, u64 *mpidr)
>>> +{
>>> +    unsigned long madt_end, entry;
>>> +    struct acpi_table_madt *madt;
>>> +    acpi_size tbl_size;
>>> +
>>> +    if (ACPI_FAILURE(acpi_get_table_with_size(ACPI_SIG_MADT, 0,
>>> +            (struct acpi_table_header **)&madt, &tbl_size)))
>>> +        return -ENODEV;
>>> +
>>> +    entry =3D (unsigned long)madt;
>>> +    madt_end =3D entry + madt->header.length;
>>> +
>>> +    /* Parse all entries looking for a match. */
>>> +    entry +=3D sizeof(struct acpi_table_madt);
>>> +    while (entry + sizeof(struct acpi_subtable_header) < madt_end) {
>>> +        struct acpi_subtable_header *header =3D
>>> +            (struct acpi_subtable_header *)entry;
>>> +
>>> +        if (header->type =3D=3D ACPI_MADT_TYPE_GENERIC_INTERRUPT) {
>>> +            struct acpi_madt_generic_interrupt *gicc =3D
>>> +                container_of(header,
>>> +                struct acpi_madt_generic_interrupt, header);
>>> +
>>> +            if ((gicc->flags & ACPI_MADT_ENABLED) &&
>>> +                (gicc->uid =3D=3D acpi_id)) {
>>> +                *mpidr =3D gicc->arm_mpidr;
>>> +                early_acpi_os_unmap_memory(madt, tbl_size);
>>> +                return 0;
>>> +            }
>>> +        }
>>> +        entry +=3D header->length;
>>> +    }
>>> +
>>> +    early_acpi_os_unmap_memory(madt, tbl_size);
>>> +    return -ENODEV;
>>> +}
>>> +
>>> +/* Callback for Proximity Domain -> ACPI processor UID mapping */
>>> +void __init acpi_numa_gicc_affinity_init(struct
>>> acpi_srat_gicc_affinity *pa)
>>> +{
>>> +    int pxm, node;
>>> +    u64 mpidr;
>>> +
>>> +    if (srat_disabled())
>>> +        return;
>>> +
>>> +    if (pa->header.length < sizeof(struct acpi_srat_gicc_affinity)) {
>>> +        pr_err("SRAT: Invalid SRAT header length: %d\n",
>>> +            pa->header.length);
>>> +        bad_srat();
>>> +        return;
>>> +    }
>>> +
>>> +    if (!(pa->flags & ACPI_SRAT_GICC_ENABLED))
>>> +        return;
>>> +
>>> +    if (cpus_in_srat >=3D NR_CPUS) {
>>> +        pr_warn_once("SRAT: cpu_to_node_map[%d] is too small, may
>>> not be able to use all cpus\n",
>>> +                 NR_CPUS);
>>> +        return;
>>> +    }
>>> +
>>> +    pxm =3D pa->proximity_domain;
>>> +    node =3D acpi_map_pxm_to_node(pxm);
>>> +
>>> +    if (node =3D=3D NUMA_NO_NODE || node >=3D MAX_NUMNODES) {
>>> +        pr_err("SRAT: Too many proximity domains %d\n", pxm);
>>> +        bad_srat();
>>> +        return;
>>> +    }
>>> +
>>> +    if (get_mpidr_in_madt(pa->acpi_processor_uid, &mpidr)) {
>>> +        pr_err("SRAT: PXM %d with ACPI ID %d has no valid MPIDR in
>>> MADT\n",
>>> +            pxm, pa->acpi_processor_uid);
>>> +        bad_srat();
>>> +        return;
>>> +    }
>>
>> I wonder whether you could replace the get_mpidr_in_madt() function with
>> something like acpi_get_phys_id(). It looks like get_mpidr_in_madt()
>> duplicates functionality already available elsewhere.
>>
>
> I just tried that, and it doesn't work.
>
> The problem is that this code is being run very early in the boot, and
> kmalloc cannot be used.  acpi_get_phys_id() and its ilk can only be used
> once we have working kmalloc.  We need to extract the NUMA information
> early like this precisely because it is needed to initializing the slab
> system
>
> Notice that we are using early_acpi_os_unmap_memory() et al. in
> get_mpidr_in_madt() explicitly for this reason.

I got the same conclusion when I was preparing this patch set.

Thanks
Hanjun

--===============8453899653051798835==--

