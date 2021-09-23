Content-Type: multipart/mixed; boundary="===============0671743213966724136=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: [Devel] Re: [PATCH v3] Revert "ACPI: Add memory semantics to
 acpi_os_map_memory()"
Date: Thu, 23 Sep 2021 20:42:20 +0200
Message-ID: <CAJZ5v0gFUcvoNPzAfHj8Bd9+m=+aPQAEy=djBOug9q1HbJzWnQ@mail.gmail.com>
In-Reply-To: 20210923091644.GA5882@lpieralisi
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============0671743213966724136==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 23, 2021 at 11:16 AM Lorenzo Pieralisi
<lorenzo.pieralisi(a)arm.com> wrote:
>
> On Thu, Sep 23, 2021 at 11:35:57AM +0800, Jia He wrote:
> > This reverts commit 437b38c51162f8b87beb28a833c4d5dc85fa864e.
> >
> > The memory semantics added in commit 437b38c51162 causes SystemMemory
> > Operation region, whose address range is not described in the EFI memory
> > map to be mapped as NormalNC memory on arm64 platforms (through
> > acpi_os_map_memory() in acpi_ex_system_memory_space_handler()).
> >
> > This triggers the following abort on an ARM64 Ampere eMAG machine,
> > because presumably the physical address range area backing the Opregion
> > does not support NormalNC memory attributes driven on the bus.
> >
> >  Internal error: synchronous external abort: 96000410 [#1] SMP
> >  Modules linked in:
> >  CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.14.0+ #462
> >  Hardware name: MiTAC RAPTOR EV-883832-X3-0001/RAPTOR, BIOS 0.14 02/22/=
2019
> >  pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=3D--)
> > [...snip...]
> >  Call trace:
> >   acpi_ex_system_memory_space_handler+0x26c/0x2c8
> >   acpi_ev_address_space_dispatch+0x228/0x2c4
> >   acpi_ex_access_region+0x114/0x268
> >   acpi_ex_field_datum_io+0x128/0x1b8
> >   acpi_ex_extract_from_field+0x14c/0x2ac
> >   acpi_ex_read_data_from_field+0x190/0x1b8
> >   acpi_ex_resolve_node_to_value+0x1ec/0x288
> >   acpi_ex_resolve_to_value+0x250/0x274
> >   acpi_ds_evaluate_name_path+0xac/0x124
> >   acpi_ds_exec_end_op+0x90/0x410
> >   acpi_ps_parse_loop+0x4ac/0x5d8
> >   acpi_ps_parse_aml+0xe0/0x2c8
> >   acpi_ps_execute_method+0x19c/0x1ac
> >   acpi_ns_evaluate+0x1f8/0x26c
> >   acpi_ns_init_one_device+0x104/0x140
> >   acpi_ns_walk_namespace+0x158/0x1d0
> >   acpi_ns_initialize_devices+0x194/0x218
> >   acpi_initialize_objects+0x48/0x50
> >   acpi_init+0xe0/0x498
> >
> > If the Opregion address range is not present in the EFI memory map there
> > is no way for us to determine the memory attributes to use to map it -
> > defaulting to NormalNC does not work (and it is not correct on a memory
> > region that may have read side-effects) and therefore commit
> > 437b38c51162 should be reverted, which means reverting back to the
> > original behavior whereby address ranges that are mapped using
> > acpi_os_map_memory() default to the safe devicenGnRnE attributes on
> > ARM64 if the mapped address range is not defined in the EFI memory map.
> >
> > Fixes: 437b38c51162 ("ACPI: Add memory semantics to acpi_os_map_memory(=
)")
> > Signed-off-by: Jia He <justin.he(a)arm.com>
> > Cc: Lorenzo Pieralisi <lorenzo.pieralisi(a)arm.com>
> > Cc: Ard Biesheuvel <ardb(a)kernel.org>
> > Cc: Hanjun Guo <guohanjun(a)huawei.com>
> > Cc: Catalin Marinas <catalin.marinas(a)arm.com>
> > Cc: Rafael J. Wysocki <rafael.j.wysocki(a)intel.com>
> > Cc: Harb Abdulhamid <harb(a)amperecomputing.com>
> > ---
> > V3: refine the commit log which came from Lorenzo Pieralisi
> >
> >  arch/arm64/include/asm/acpi.h |  3 ---
> >  arch/arm64/kernel/acpi.c      | 19 +++----------------
> >  drivers/acpi/osl.c            | 23 +++++++----------------
> >  include/acpi/acpi_io.h        |  8 --------
> >  4 files changed, 10 insertions(+), 43 deletions(-)
>
> Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi(a)arm.com>
>
> Rafael if possible please apply it, thank you very much.

Applied as 5.15-rc material, thanks!
--===============0671743213966724136==--

