Content-Type: multipart/mixed; boundary="===============7306062270906545187=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: [Devel] Re: [PATCH 1/1] ACPI: fix acpi table use after free
Date: Mon, 15 Mar 2021 17:19:29 +0100
Message-ID: <CAJZ5v0g1H6hCVbAAFajhn0AYRMU4GkZOqggOB6LVdgFx_vfwOA@mail.gmail.com>
In-Reply-To: YE5dJ6U3nPWsXY4D@linux.ibm.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============7306062270906545187==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 14, 2021 at 8:00 PM Mike Rapoport <rppt(a)linux.ibm.com> wrote:
>
> On Thu, Mar 11, 2021 at 04:36:31PM +0100, Rafael J. Wysocki wrote:
> > On Wed, Mar 10, 2021 at 8:47 PM David Hildenbrand <david(a)redhat.com> =
wrote:
> > > >
> > > > There is some care that should be taken to make sure we get the ord=
er
> > > > right, but I don't see a fundamental issue here.
> >
> > Me neither.
> >
> > > > If I understand correctly, Rafael's concern is about changing the p=
arts of
> > > > ACPICA that should be OS agnostic, so I think we just need another =
place to
> > > > call memblock_reserve() rather than acpi_tb_install_table_with_over=
ride().
> >
> > Something like this.
> >
> > There is also the problem that memblock_reserve() needs to be called
> > for all of the tables early enough, which will require some reordering
> > of the early init code.
> >
> > > > Since the reservation should be done early in x86::setup_arch() (and
> > > > probably in arm64::setup_arch()) we might just have a function that=
 parses
> > > > table headers and reserves them, similarly to how we parse the tabl=
es
> > > > during KASLR setup.
> >
> > Right.
>
> I've looked at it a bit more and we do something like the patch below that
> nearly duplicates acpi_tb_parse_root_table() which is not very nice.

It looks to me that the code need not be duplicated (see below).

> Besides, reserving ACPI tables early and then calling acpi_table_init()
> (and acpi_tb_parse_root_table() again would mean doing the dance with
> early_memremap() twice for no good reason.

That'd be simply inefficient which is kind of acceptable to me to start wit=
h.

And I changing the ACPICA code can be avoided at least initially, it
by itself would be a good enough reason.

> I believe the most effective way to deal with this would be to have a
> function that does parsing, reservation and installs the tables supplied =
by
> the firmware which can be called really early and then another function
> that overrides tables if needed a some later point.

I agree that this should be the direction to go into.

However, it looks to me that something like the following could be
done to start with:

(a) Make __acpi_map_table() call memblock_reserve() in addition to
early_memremap().

My assumption here is that the memblock_reserve() will simply be
ignored if it is called too late.

(b) Introduce acpi_reserve_tables() as something like

void __init acpi_table_reserve(void)
{
        acpi_initialize_tables(initial_tables, ACPI_MAX_TABLES, 0);
}

Because initial_tables is passed to acpi_initialize_tables() above and
allow_resize is 0, the array used by it will simply get overwritten
when acpi_table_init() gets called.

(c) Make setup_arch() call acpi_table_reserve() like in the original
patch from George.

Would that work?

If so, I'll cut a patch along these lines.
--===============7306062270906545187==--

