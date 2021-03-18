Content-Type: multipart/mixed; boundary="===============7278697370897435347=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: [Devel] Re: [PATCH 1/1] ACPI: fix acpi table use after free
Date: Thu, 18 Mar 2021 11:50:21 +0100
Message-ID: <CAJZ5v0g_y3X2Ps+ipBg702Q_RR3cm4gKBJoPqjazHXaisKGc4g@mail.gmail.com>
In-Reply-To: YFMAdIVn2hpTHfBq@linux.ibm.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============7278697370897435347==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 18, 2021 at 8:25 AM Mike Rapoport <rppt(a)linux.ibm.com> wrote:
>
> On Wed, Mar 17, 2021 at 09:14:37PM +0100, Rafael J. Wysocki wrote:
> > On Monday, March 15, 2021 5:19:29 PM CET Rafael J. Wysocki wrote:
> > > On Sun, Mar 14, 2021 at 8:00 PM Mike Rapoport <rppt(a)linux.ibm.com> =
wrote:
> > > >
> > > > On Thu, Mar 11, 2021 at 04:36:31PM +0100, Rafael J. Wysocki wrote:
> > > > > On Wed, Mar 10, 2021 at 8:47 PM David Hildenbrand <david(a)redhat=
.com> wrote:
> > > > > > >
> > > > > > > There is some care that should be taken to make sure we get t=
he order
> > > > > > > right, but I don't see a fundamental issue here.
> > > > >
> > > > > Me neither.
> > > > >
> > > > > > > If I understand correctly, Rafael's concern is about changing=
 the parts of
> > > > > > > ACPICA that should be OS agnostic, so I think we just need an=
other place to
> > > > > > > call memblock_reserve() rather than acpi_tb_install_table_wit=
h_override().
> > > > >
> > > > > Something like this.
> > > > >
> > > > > There is also the problem that memblock_reserve() needs to be cal=
led
> > > > > for all of the tables early enough, which will require some reord=
ering
> > > > > of the early init code.
> > > > >
> > > > > > > Since the reservation should be done early in x86::setup_arch=
() (and
> > > > > > > probably in arm64::setup_arch()) we might just have a functio=
n that parses
> > > > > > > table headers and reserves them, similarly to how we parse th=
e tables
> > > > > > > during KASLR setup.
> > > > >
> > > > > Right.
> > > >
> > > > I've looked at it a bit more and we do something like the patch bel=
ow that
> > > > nearly duplicates acpi_tb_parse_root_table() which is not very nice.
> > >
> > > It looks to me that the code need not be duplicated (see below).
> > >
> > > > Besides, reserving ACPI tables early and then calling acpi_table_in=
it()
> > > > (and acpi_tb_parse_root_table() again would mean doing the dance wi=
th
> > > > early_memremap() twice for no good reason.
> > >
> > > That'd be simply inefficient which is kind of acceptable to me to sta=
rt with.
> > >
> > > And I changing the ACPICA code can be avoided at least initially, it
> > > by itself would be a good enough reason.
> > >
> > > > I believe the most effective way to deal with this would be to have=
 a
> > > > function that does parsing, reservation and installs the tables sup=
plied by
> > > > the firmware which can be called really early and then another func=
tion
> > > > that overrides tables if needed a some later point.
> > >
> > > I agree that this should be the direction to go into.
> >
> > So maybe something like the patch below?
> >
> > I'm not sure if acpi_boot_table_prepare() gets called early enough, tho=
ugh.
>
> To be 100% safe it should be called before e820__memblock_setup().

OK

> It is possible to call memblock_reserve() at any time, even before the ac=
tual
> memory is detected as long as all reservations fit into the static array
> that currently has 128 entries on x86.
>
> As e820__memblock_setup() essentially enables memblock allocations,
> theoretically the memory occupied by ACPI tables can be allocated even in
> x86::setup_arch() unless it is reserved before e820__memblock_setup().
>
> > Also this still may not play well with initrd-based table overrides. Er=
ik, do
> > you have any insights here?
> >
> > And ia64 needs to be updated too.
>
> I think arm64 as well.

Right.

> > ---
> >  arch/x86/kernel/acpi/boot.c |   12 +++++++++---
> >  arch/x86/kernel/setup.c     |    3 +++
> >  drivers/acpi/tables.c       |   24 +++++++++++++++++++++---
> >  include/linux/acpi.h        |    9 +++++++--
> >  4 files changed, 40 insertions(+), 8 deletions(-)
> >
> > Index: linux-pm/arch/x86/kernel/acpi/boot.c
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- linux-pm.orig/arch/x86/kernel/acpi/boot.c
> > +++ linux-pm/arch/x86/kernel/acpi/boot.c
> > @@ -1541,7 +1541,7 @@ static const struct dmi_system_id acpi_d
> >   *   ...
> >   */
> >
> > -void __init acpi_boot_table_init(void)
> > +void __init acpi_boot_table_prepare(void)
> >  {
> >       dmi_check_system(acpi_dmi_table);
> >
> > @@ -1554,10 +1554,16 @@ void __init acpi_boot_table_init(void)
> >       /*
> >        * Initialize the ACPI boot-time table parser.
> >        */
> > -     if (acpi_table_init()) {
> > +     if (acpi_table_prepare())
> >               disable_acpi();
> > +}
> > +
> > +void __init acpi_boot_table_init(void)
> > +{
> > +     if (acpi_disabled)
> >               return;
> > -     }
> > +
> > +     acpi_table_init();
> >
> >       acpi_table_parse(ACPI_SIG_BOOT, acpi_parse_sbf);
> >
> > Index: linux-pm/arch/x86/kernel/setup.c
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- linux-pm.orig/arch/x86/kernel/setup.c
> > +++ linux-pm/arch/x86/kernel/setup.c
> > @@ -1070,6 +1070,9 @@ void __init setup_arch(char **cmdline_p)
> >       /* preallocate 4k for mptable mpc */
> >       e820__memblock_alloc_reserved_mpc_new();
> >
> > +     /* Look for ACPI tables and reserve memory occupied by them. */
> > +     acpi_boot_table_prepare();
> > +
> >  #ifdef CONFIG_X86_CHECK_BIOS_CORRUPTION
> >       setup_bios_corruption_check();
> >  #endif
> > Index: linux-pm/include/linux/acpi.h
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- linux-pm.orig/include/linux/acpi.h
> > +++ linux-pm/include/linux/acpi.h
> > @@ -222,11 +222,13 @@ void __iomem *__acpi_map_table(unsigned
> >  void __acpi_unmap_table(void __iomem *map, unsigned long size);
> >  int early_acpi_boot_init(void);
> >  int acpi_boot_init (void);
> > +void acpi_boot_table_prepare (void);
> >  void acpi_boot_table_init (void);
>
> Not related to this patch, but it feels to me like there are too many
> acpi_boot_something() :)

Well, there was one initially, but it has been split for a few times
due to ordering issues similar to the one at hand.

It could be cleaned up I suppose, though.
--===============7278697370897435347==--

