Content-Type: multipart/mixed; boundary="===============1564576894238320285=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: [Devel] Re: [PATCH 1/1] ACPI: fix acpi table use after free
Date: Mon, 22 Mar 2021 17:57:27 +0100
Message-ID: <CAJZ5v0jEeBxtaAz+w2SZdAud077FJBR+AfkyEYR-eM7gY4050g@mail.gmail.com>
In-Reply-To: YFWxbzN92XcXNl95@linux.ibm.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============1564576894238320285==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 20, 2021 at 9:25 AM Mike Rapoport <rppt(a)linux.ibm.com> wrote:
>
> On Thu, Mar 18, 2021 at 04:22:37PM +0100, Rafael J. Wysocki wrote:
> > On Thu, Mar 18, 2021 at 11:50 AM Rafael J. Wysocki <rafael(a)kernel.org=
> wrote:
> > >
> > > On Thu, Mar 18, 2021 at 8:25 AM Mike Rapoport <rppt(a)linux.ibm.com> =
wrote:
> > > >
> > > > On Wed, Mar 17, 2021 at 09:14:37PM +0100, Rafael J. Wysocki wrote:
> > > > > On Monday, March 15, 2021 5:19:29 PM CET Rafael J. Wysocki wrote:
> > > > > > On Sun, Mar 14, 2021 at 8:00 PM Mike Rapoport <rppt(a)linux.ibm=
.com> wrote:
> > > > > > >
> > > > > > > On Thu, Mar 11, 2021 at 04:36:31PM +0100, Rafael J. Wysocki w=
rote:
> > > > > > > > On Wed, Mar 10, 2021 at 8:47 PM David Hildenbrand <david(a)=
redhat.com> wrote:
> > > > > > > > > >
> > > > > > > > > > There is some care that should be taken to make sure we=
 get the order
> > > > > > > > > > right, but I don't see a fundamental issue here.
> > > > > > > >
> > > > > > > > Me neither.
> > > > > > > >
> > > > > > > > > > If I understand correctly, Rafael's concern is about ch=
anging the parts of
> > > > > > > > > > ACPICA that should be OS agnostic, so I think we just n=
eed another place to
> > > > > > > > > > call memblock_reserve() rather than acpi_tb_install_tab=
le_with_override().
> > > > > > > >
> > > > > > > > Something like this.
> > > > > > > >
> > > > > > > > There is also the problem that memblock_reserve() needs to =
be called
> > > > > > > > for all of the tables early enough, which will require some=
 reordering
> > > > > > > > of the early init code.
> > > > > > > >
> > > > > > > > > > Since the reservation should be done early in x86::setu=
p_arch() (and
> > > > > > > > > > probably in arm64::setup_arch()) we might just have a f=
unction that parses
> > > > > > > > > > table headers and reserves them, similarly to how we pa=
rse the tables
> > > > > > > > > > during KASLR setup.
> > > > > > > >
> > > > > > > > Right.
> > > > > > >
> > > > > > > I've looked at it a bit more and we do something like the pat=
ch below that
> > > > > > > nearly duplicates acpi_tb_parse_root_table() which is not ver=
y nice.
> > > > > >
> > > > > > It looks to me that the code need not be duplicated (see below).
> > > > > >
> > > > > > > Besides, reserving ACPI tables early and then calling acpi_ta=
ble_init()
> > > > > > > (and acpi_tb_parse_root_table() again would mean doing the da=
nce with
> > > > > > > early_memremap() twice for no good reason.
> > > > > >
> > > > > > That'd be simply inefficient which is kind of acceptable to me =
to start with.
> > > > > >
> > > > > > And I changing the ACPICA code can be avoided at least initiall=
y, it
> > > > > > by itself would be a good enough reason.
> > > > > >
> > > > > > > I believe the most effective way to deal with this would be t=
o have a
> > > > > > > function that does parsing, reservation and installs the tabl=
es supplied by
> > > > > > > the firmware which can be called really early and then anothe=
r function
> > > > > > > that overrides tables if needed a some later point.
> > > > > >
> > > > > > I agree that this should be the direction to go into.
> > > > >
> > > > > So maybe something like the patch below?
> > > > >
> > > > > I'm not sure if acpi_boot_table_prepare() gets called early enoug=
h, though.
> > > >
> > > > To be 100% safe it should be called before e820__memblock_setup().
> > >
> > > OK
> >
> > Well, that said, reserve_bios_regions() doesn't seem to have concerns
> > like this and I'm not sure why ACPI tables should be reserved before
> > this runs.  That applies to efi_reserve_boot_services() too.
> >
> > I can put the new call before e820__memblock_alloc_reserved_mpc_new(),
> > but I'm not sure why to put it before efi_reserve_boot_services(),
> > say?
>
> The general idea is to reserve all the memory used by the firmware before
> memblock allocations are possible, i.e. before e820__memblock_setup().
> Currently this is not the case, but it does not make it more correct.

I see.

> Theoretically, it is possible that reserve_bios_regions() will cause a
> memory allocation and the allocated memory will be exactly at the area
> where ACPI tables reside.
>
> In practice I believe this is very unlikely, but who knows.
>
> Another advantage of having ACPI tables handy by the time we do the memory
> detection is that we will be able to SRAT earlier and simplify NUMA
> initialization.

OK, fair enough.
--===============1564576894238320285==--

