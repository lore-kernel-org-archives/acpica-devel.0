Content-Type: multipart/mixed; boundary="===============3429786090025121014=="
MIME-Version: 1.0
From: Lorenzo Pieralisi <lorenzo.pieralisi at arm.com>
Subject: [Devel] Re: [PATCH v2] Revert "ACPI: Add memory semantics to
 acpi_os_map_memory()"
Date: Wed, 29 Sep 2021 14:31:31 +0100
Message-ID: <20210929133131.GA20191@lpieralisi>
In-Reply-To: 44f20f07-257b-a1a5-23d9-ffd66bf45887@intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============3429786090025121014==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

[+Tony]

On Tue, Sep 28, 2021 at 07:26:52PM +0200, Rafael J. Wysocki wrote:
> On 9/24/2021 11:04 AM, Lorenzo Pieralisi wrote:
> > On Thu, Sep 23, 2021 at 02:54:52PM +0200, Rafael J. Wysocki wrote:
> > > On Thu, Sep 23, 2021 at 2:26 PM Mark Kettenis <mark.kettenis(a)xs4all=
.nl> wrote:
> > > > > From: "Rafael J. Wysocki" <rafael(a)kernel.org>
> > > > > Date: Thu, 23 Sep 2021 13:05:05 +0200
> > > > > =

> > > > > On Thu, Sep 23, 2021 at 11:40 AM Lorenzo Pieralisi
> > > > > <lorenzo.pieralisi(a)arm.com> wrote:
> > > > > > On Thu, Sep 23, 2021 at 01:09:58AM +0200, Mark Kettenis wrote:
> > > > > > > > Date: Wed, 22 Sep 2021 17:33:36 +0100
> > > > > > > > From: Lorenzo Pieralisi <lorenzo.pieralisi(a)arm.com>
> > > > > > > > =

> > > > > > > > On Fri, Sep 10, 2021 at 10:32:23PM +0800, Jia He wrote:
> > > > > > > > > This reverts commit 437b38c51162f8b87beb28a833c4d5dc85fa8=
64e.
> > > > > > > > > =

> > > > > > > > > After this commit, a boot panic is alway hit on an Ampere=
 EMAG server
> > > > > > > > > with call trace as follows:
> > > > > > > > >   Internal error: synchronous external abort: 96000410 [#=
1] SMP
> > > > > > > > >   Modules linked in:
> > > > > > > > >   CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.14.0+ #462
> > > > > > > > >   Hardware name: MiTAC RAPTOR EV-883832-X3-0001/RAPTOR, B=
IOS 0.14 02/22/2019
> > > > > > > > >   pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS B=
TYPE=3D--)
> > > > > > > > > [...snip...]
> > > > > > > > >   Call trace:
> > > > > > > > >    acpi_ex_system_memory_space_handler+0x26c/0x2c8
> > > > > > > > >    acpi_ev_address_space_dispatch+0x228/0x2c4
> > > > > > > > >    acpi_ex_access_region+0x114/0x268
> > > > > > > > >    acpi_ex_field_datum_io+0x128/0x1b8
> > > > > > > > >    acpi_ex_extract_from_field+0x14c/0x2ac
> > > > > > > > >    acpi_ex_read_data_from_field+0x190/0x1b8
> > > > > > > > >    acpi_ex_resolve_node_to_value+0x1ec/0x288
> > > > > > > > >    acpi_ex_resolve_to_value+0x250/0x274
> > > > > > > > >    acpi_ds_evaluate_name_path+0xac/0x124
> > > > > > > > >    acpi_ds_exec_end_op+0x90/0x410
> > > > > > > > >    acpi_ps_parse_loop+0x4ac/0x5d8
> > > > > > > > >    acpi_ps_parse_aml+0xe0/0x2c8
> > > > > > > > >    acpi_ps_execute_method+0x19c/0x1ac
> > > > > > > > >    acpi_ns_evaluate+0x1f8/0x26c
> > > > > > > > >    acpi_ns_init_one_device+0x104/0x140
> > > > > > > > >    acpi_ns_walk_namespace+0x158/0x1d0
> > > > > > > > >    acpi_ns_initialize_devices+0x194/0x218
> > > > > > > > >    acpi_initialize_objects+0x48/0x50
> > > > > > > > >    acpi_init+0xe0/0x498
> > > > > > > > > =

> > > > > > > > > As mentioned by Lorenzo:
> > > > > > > > >    "We are forcing memory semantics mappings to PROT_NORM=
AL_NC, which
> > > > > > > > >    eMAG does not like at all and I'd need to understand w=
hy. It looks
> > > > > > > > >    like the issue happen in SystemMemory Opregion handler=
."
> > > > > > > > > =

> > > > > > > > > Hence just revert it before everything is clear.
> > > > > > > > > =

> > > > > > > > > Fixes: 437b38c51162 ("ACPI: Add memory semantics to acpi_=
os_map_memory()")
> > > > > > > > > Cc: Lorenzo Pieralisi <lorenzo.pieralisi(a)arm.com>
> > > > > > > > > Cc: Ard Biesheuvel <ardb(a)kernel.org>
> > > > > > > > > Cc: Hanjun Guo <guohanjun(a)huawei.com>
> > > > > > > > > Cc: Catalin Marinas <catalin.marinas(a)arm.com>
> > > > > > > > > Cc: Rafael J. Wysocki <rafael.j.wysocki(a)intel.com>
> > > > > > > > > Cc: Harb Abdulhamid <harb(a)amperecomputing.com>
> > > > > > > > > =

> > > > > > > > > Signed-off-by: Jia He <justin.he(a)arm.com>
> > > > > > > > Rewrote the commit log, please take the patch below and rep=
ost
> > > > > > > > it as a v3.
> > > > > > > > =

> > > > > > > > It would still be great if Ampere can help us understand why
> > > > > > > > the NormalNC attributes trigger a sync abort on the opregion
> > > > > > > > before merging it.
> > > > > > > To be honest, I don't think you really need an explanation fr=
om Ampere
> > > > > > > here.  Mapping a part of the address space that doesn't provi=
de memory
> > > > > > > semantics with NormalNC attributes is wrong and triggering a =
sync
> > > > > > > abort in that case is way better than silently ignoring the a=
ccess.
> > > > > > That's understood and that's what I explained in the revert com=
mit
> > > > > > log, no question about it.
> > > > > > =

> > > > > > I was just asking to confirm if that's what's actually happenin=
g.
> > > > > > =

> > > > > > > Putting my OpenBSD hat on (where we have our own ACPI OSPM
> > > > > > > implementation) I must say that we always interpreted SystemM=
emory as
> > > > > > > memory mapped IO and I think that is a logical choice as Syst=
emIO is
> > > > > > > used for (non-memory mapped) IO.  And I'd say that the ACPI O=
SPM code
> > > > > > > should make sure that it uses properly aligned access to any =
Field
> > > > > > > object that doesn't use AnyAcc as its access type.  Even on x=
86!  And
> > > > > > > I'd say that AML that uses AnyAcc fields for SystemMemory OpR=
egions on
> > > > > > > arm64 is buggy.
> > > > > > > =

> > > > > > > But maybe relaxing this when the EFI memory map indicates tha=
t the
> > > > > > > address space in question does provide memory semantics does =
make
> > > > > > > sense.  That should defenitely be documented in the ACPI stan=
dard
> > > > > > > though.
> > > > > > Mapping SystemMemory Opregions as "memory" does not make sense
> > > > > > at all to me. Still, that's what Linux ACPICA code does (*if*
> > > > > > that's what acpi_os_map_memory() is supposed to mean).
> > > > > > =

> > > > > > https://lore.kernel.org/linux-acpi/20210916160827.GA4525(a)lpie=
ralisi
> > > > > It doesn't need to do that, though, if there are good enough argu=
ments
> > > > > to change the current behavior (and the argument here is that it =
may
> > > > > be an MMIO region, so mapping it as memory doesn't really work, b=
ut it
> > > > > also may be a region in memory - there is no rule in the spec by =
which
> > > > > SystemMemory Opregions cannot be "memory" AFAICS) and if that cha=
nge
> > > > > doesn't introduce regressions in the installed base.
> > > > > =

> > > > > > Where do we go from here, to be defined, we still have a bug
> > > > > > to fix after the revert is applied.
> > > > > > =

> > > > > > drivers/acpi/sysfs.c
> > > > > > =

> > > > > > maps BERT error regions with acpi_os_map_memory().
> > > > > That mechanism is basically used for exporting ACPI tables to user
> > > > > space and they are known to reside in memory.  Whether or not BERT
> > > > > regions should be mapped in the same way is a good question.
> > > > It is not inconceivable that BERT regions actually live in memory of
> > > > the BMC that is exposed over a bus that doesn't implement memory
> > > > semantics is it?
> > > No, it isn't, which is why I think that mapping them as RAM may not be
> > > a good idea in general.
> > Should I patch acpi_data_show() to map BERT error regions (well, that's
> > what acpi_data_show() is used on at the moment) as MMIO and use the
> > related memcpy routine to read them then :) ?
> =

> It actually would be good to clean it up so it is clear that this is only
> used for BERT.
> =

> And then there is this question: if this is not RAM (so effectively it is
> device memory), should it be exposed directly to user space?

Do you mean from a security standpoint ? I believe there might be users
out there so if we want to remove that sysfs entry it may be
problematic.

Maybe Tony has more insights into this than I do:

commit 7dae6326ed76 ("ACPI / sysfs: Extend ACPI sysfs to provide access to =
boot error region")

Thanks,
Lorenzo
--===============3429786090025121014==--

