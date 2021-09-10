Content-Type: multipart/mixed; boundary="===============7065624200466779045=="
MIME-Version: 1.0
From: Lorenzo Pieralisi <lorenzo.pieralisi at arm.com>
Subject: [Devel] Re: [PATCH] Revert "ACPI: Add memory semantics to
 acpi_os_map_memory()"
Date: Fri, 10 Sep 2021 14:54:46 +0100
Message-ID: <20210910135446.GA15810@lpieralisi>
In-Reply-To: 20210910122820.26886-1-justin.he@arm.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============7065624200466779045==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

[dropped CC stable, +CC Harb]

On Fri, Sep 10, 2021 at 08:28:20PM +0800, Jia He wrote:
> This reverts commit 437b38c51162f8b87beb28a833c4d5dc85fa864e.
> =

> After this commit, a boot panic is alway hit on an Ampere EMAG server
> with call trace as follows:
>  Internal error: synchronous external abort: 96000410 [#1] SMP
>  Modules linked in:
>  CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.14.0+ #462
>  Hardware name: MiTAC RAPTOR EV-883832-X3-0001/RAPTOR, BIOS 0.14 02/22/20=
19
>  pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=3D--)
> [...snip...]
>  Call trace:
>   acpi_ex_system_memory_space_handler+0x26c/0x2c8
>   acpi_ev_address_space_dispatch+0x228/0x2c4
>   acpi_ex_access_region+0x114/0x268
>   acpi_ex_field_datum_io+0x128/0x1b8
>   acpi_ex_extract_from_field+0x14c/0x2ac
>   acpi_ex_read_data_from_field+0x190/0x1b8
>   acpi_ex_resolve_node_to_value+0x1ec/0x288
>   acpi_ex_resolve_to_value+0x250/0x274
>   acpi_ds_evaluate_name_path+0xac/0x124
>   acpi_ds_exec_end_op+0x90/0x410
>   acpi_ps_parse_loop+0x4ac/0x5d8
>   acpi_ps_parse_aml+0xe0/0x2c8
>   acpi_ps_execute_method+0x19c/0x1ac
>   acpi_ns_evaluate+0x1f8/0x26c
>   acpi_ns_init_one_device+0x104/0x140
>   acpi_ns_walk_namespace+0x158/0x1d0
>   acpi_ns_initialize_devices+0x194/0x218
>   acpi_initialize_objects+0x48/0x50
>   acpi_init+0xe0/0x498
> =

> From the debugging, we're mapping something which is *not* described by
> the EFI memory map, but *does* want PROT_NORMAL_NC.

"Does not" you mean. We are forcing memory semantics mappings to
PROT_NORMAL_NC, which eMAG does not like at all and I'd need to
understand why.

It looks like the issue happen in SystemMemory Opregion handler.

> =

> Hence just revert it before everything is clear.
> =

> Fixes: 437b38c51162 ("ACPI: Add memory semantics to acpi_os_map_memory()")
> Cc: stable(a)vger.kernel.org

No need, it is not even in an -rc yet (and stable should not be CCed in
the addressees CC list).

Thanks,
Lorenzo

> Cc: Lorenzo Pieralisi <lorenzo.pieralisi(a)arm.com>
> Cc: Ard Biesheuvel <ardb(a)kernel.org>
> Cc: Hanjun Guo <guohanjun(a)huawei.com>
> Cc: Catalin Marinas <catalin.marinas(a)arm.com>
> Cc: Rafael J. Wysocki <rafael.j.wysocki(a)intel.com>
> =

> Signed-off-by: Jia He <justin.he(a)arm.com>
> ---
>  arch/arm64/include/asm/acpi.h |  3 ---
>  arch/arm64/kernel/acpi.c      | 19 +++----------------
>  drivers/acpi/osl.c            | 23 +++++++----------------
>  include/acpi/acpi_io.h        |  8 --------
>  4 files changed, 10 insertions(+), 43 deletions(-)
> =

> diff --git a/arch/arm64/include/asm/acpi.h b/arch/arm64/include/asm/acpi.h
> index 7535dc7cc5aa..bd68e1b7f29f 100644
> --- a/arch/arm64/include/asm/acpi.h
> +++ b/arch/arm64/include/asm/acpi.h
> @@ -50,9 +50,6 @@ pgprot_t __acpi_get_mem_attribute(phys_addr_t addr);
>  void __iomem *acpi_os_ioremap(acpi_physical_address phys, acpi_size size=
);
>  #define acpi_os_ioremap acpi_os_ioremap
>  =

> -void __iomem *acpi_os_memmap(acpi_physical_address phys, acpi_size size);
> -#define acpi_os_memmap acpi_os_memmap
> -
>  typedef u64 phys_cpuid_t;
>  #define PHYS_CPUID_INVALID INVALID_HWID
>  =

> diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
> index 1c9c2f7a1c04..f3851724fe35 100644
> --- a/arch/arm64/kernel/acpi.c
> +++ b/arch/arm64/kernel/acpi.c
> @@ -273,8 +273,7 @@ pgprot_t __acpi_get_mem_attribute(phys_addr_t addr)
>  	return __pgprot(PROT_DEVICE_nGnRnE);
>  }
>  =

> -static void __iomem *__acpi_os_ioremap(acpi_physical_address phys,
> -				       acpi_size size, bool memory)
> +void __iomem *acpi_os_ioremap(acpi_physical_address phys, acpi_size size)
>  {
>  	efi_memory_desc_t *md, *region =3D NULL;
>  	pgprot_t prot;
> @@ -300,11 +299,9 @@ static void __iomem *__acpi_os_ioremap(acpi_physical=
_address phys,
>  	 * It is fine for AML to remap regions that are not represented in the
>  	 * EFI memory map at all, as it only describes normal memory, and MMIO
>  	 * regions that require a virtual mapping to make them accessible to
> -	 * the EFI runtime services. Determine the region default
> -	 * attributes by checking the requested memory semantics.
> +	 * the EFI runtime services.
>  	 */
> -	prot =3D memory ? __pgprot(PROT_NORMAL_NC) :
> -			__pgprot(PROT_DEVICE_nGnRnE);
> +	prot =3D __pgprot(PROT_DEVICE_nGnRnE);
>  	if (region) {
>  		switch (region->type) {
>  		case EFI_LOADER_CODE:
> @@ -364,16 +361,6 @@ static void __iomem *__acpi_os_ioremap(acpi_physical=
_address phys,
>  	return __ioremap(phys, size, prot);
>  }
>  =

> -void __iomem *acpi_os_ioremap(acpi_physical_address phys, acpi_size size)
> -{
> -	return __acpi_os_ioremap(phys, size, false);
> -}
> -
> -void __iomem *acpi_os_memmap(acpi_physical_address phys, acpi_size size)
> -{
> -	return __acpi_os_ioremap(phys, size, true);
> -}
> -
>  /*
>   * Claim Synchronous External Aborts as a firmware first notification.
>   *
> diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
> index a43f1521efe6..45c5c0e45e33 100644
> --- a/drivers/acpi/osl.c
> +++ b/drivers/acpi/osl.c
> @@ -284,8 +284,7 @@ acpi_map_lookup_virt(void __iomem *virt, acpi_size si=
ze)
>  #define should_use_kmap(pfn)   page_is_ram(pfn)
>  #endif
>  =

> -static void __iomem *acpi_map(acpi_physical_address pg_off, unsigned lon=
g pg_sz,
> -			      bool memory)
> +static void __iomem *acpi_map(acpi_physical_address pg_off, unsigned lon=
g pg_sz)
>  {
>  	unsigned long pfn;
>  =

> @@ -295,8 +294,7 @@ static void __iomem *acpi_map(acpi_physical_address p=
g_off, unsigned long pg_sz,
>  			return NULL;
>  		return (void __iomem __force *)kmap(pfn_to_page(pfn));
>  	} else
> -		return memory ? acpi_os_memmap(pg_off, pg_sz) :
> -				acpi_os_ioremap(pg_off, pg_sz);
> +		return acpi_os_ioremap(pg_off, pg_sz);
>  }
>  =

>  static void acpi_unmap(acpi_physical_address pg_off, void __iomem *vaddr)
> @@ -311,10 +309,9 @@ static void acpi_unmap(acpi_physical_address pg_off,=
 void __iomem *vaddr)
>  }
>  =

>  /**
> - * __acpi_os_map_iomem - Get a virtual address for a given physical addr=
ess range.
> + * acpi_os_map_iomem - Get a virtual address for a given physical addres=
s range.
>   * @phys: Start of the physical address range to map.
>   * @size: Size of the physical address range to map.
> - * @memory: true if remapping memory, false if IO
>   *
>   * Look up the given physical address range in the list of existing ACPI=
 memory
>   * mappings.  If found, get a reference to it and return a pointer to it=
 (its
> @@ -324,8 +321,8 @@ static void acpi_unmap(acpi_physical_address pg_off, =
void __iomem *vaddr)
>   * During early init (when acpi_permanent_mmap has not been set yet) this
>   * routine simply calls __acpi_map_table() to get the job done.
>   */
> -static void __iomem __ref
> -*__acpi_os_map_iomem(acpi_physical_address phys, acpi_size size, bool me=
mory)
> +void __iomem __ref
> +*acpi_os_map_iomem(acpi_physical_address phys, acpi_size size)
>  {
>  	struct acpi_ioremap *map;
>  	void __iomem *virt;
> @@ -356,7 +353,7 @@ static void __iomem __ref
>  =

>  	pg_off =3D round_down(phys, PAGE_SIZE);
>  	pg_sz =3D round_up(phys + size, PAGE_SIZE) - pg_off;
> -	virt =3D acpi_map(phys, size, memory);
> +	virt =3D acpi_map(phys, size);
>  	if (!virt) {
>  		mutex_unlock(&acpi_ioremap_lock);
>  		kfree(map);
> @@ -375,17 +372,11 @@ static void __iomem __ref
>  	mutex_unlock(&acpi_ioremap_lock);
>  	return map->virt + (phys - map->phys);
>  }
> -
> -void __iomem *__ref
> -acpi_os_map_iomem(acpi_physical_address phys, acpi_size size)
> -{
> -	return __acpi_os_map_iomem(phys, size, false);
> -}
>  EXPORT_SYMBOL_GPL(acpi_os_map_iomem);
>  =

>  void *__ref acpi_os_map_memory(acpi_physical_address phys, acpi_size siz=
e)
>  {
> -	return (void *)__acpi_os_map_iomem(phys, size, true);
> +	return (void *)acpi_os_map_iomem(phys, size);
>  }
>  EXPORT_SYMBOL_GPL(acpi_os_map_memory);
>  =

> diff --git a/include/acpi/acpi_io.h b/include/acpi/acpi_io.h
> index a0212e67d6f4..027faa8883aa 100644
> --- a/include/acpi/acpi_io.h
> +++ b/include/acpi/acpi_io.h
> @@ -14,14 +14,6 @@ static inline void __iomem *acpi_os_ioremap(acpi_physi=
cal_address phys,
>  }
>  #endif
>  =

> -#ifndef acpi_os_memmap
> -static inline void __iomem *acpi_os_memmap(acpi_physical_address phys,
> -					    acpi_size size)
> -{
> -	return ioremap_cache(phys, size);
> -}
> -#endif
> -
>  extern bool acpi_permanent_mmap;
>  =

>  void __iomem __ref
> -- =

> 2.17.1
>=20
--===============7065624200466779045==--

