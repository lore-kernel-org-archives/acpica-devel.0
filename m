Content-Type: multipart/mixed; boundary="===============3268055426456954527=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: [Devel] Re: [PATCH 1/1] ACPI: fix acpi table use after free
Date: Thu, 18 Mar 2021 16:22:37 +0100
Message-ID: <CAJZ5v0iump7nVKfyu7S23-n=gQFx5d2MKejrnT6yFak7L9V11g@mail.gmail.com>
In-Reply-To: CAJZ5v0g_y3X2Ps+ipBg702Q_RR3cm4gKBJoPqjazHXaisKGc4g@mail.gmail.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============3268055426456954527==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 18, 2021 at 11:50 AM Rafael J. Wysocki <rafael(a)kernel.org> wr=
ote:
>
> On Thu, Mar 18, 2021 at 8:25 AM Mike Rapoport <rppt(a)linux.ibm.com> wrot=
e:
> >
> > On Wed, Mar 17, 2021 at 09:14:37PM +0100, Rafael J. Wysocki wrote:
> > > On Monday, March 15, 2021 5:19:29 PM CET Rafael J. Wysocki wrote:
> > > > On Sun, Mar 14, 2021 at 8:00 PM Mike Rapoport <rppt(a)linux.ibm.com=
> wrote:
> > > > >
> > > > > On Thu, Mar 11, 2021 at 04:36:31PM +0100, Rafael J. Wysocki wrote:
> > > > > > On Wed, Mar 10, 2021 at 8:47 PM David Hildenbrand <david(a)redh=
at.com> wrote:
> > > > > > > >
> > > > > > > > There is some care that should be taken to make sure we get=
 the order
> > > > > > > > right, but I don't see a fundamental issue here.
> > > > > >
> > > > > > Me neither.
> > > > > >
> > > > > > > > If I understand correctly, Rafael's concern is about changi=
ng the parts of
> > > > > > > > ACPICA that should be OS agnostic, so I think we just need =
another place to
> > > > > > > > call memblock_reserve() rather than acpi_tb_install_table_w=
ith_override().
> > > > > >
> > > > > > Something like this.
> > > > > >
> > > > > > There is also the problem that memblock_reserve() needs to be c=
alled
> > > > > > for all of the tables early enough, which will require some reo=
rdering
> > > > > > of the early init code.
> > > > > >
> > > > > > > > Since the reservation should be done early in x86::setup_ar=
ch() (and
> > > > > > > > probably in arm64::setup_arch()) we might just have a funct=
ion that parses
> > > > > > > > table headers and reserves them, similarly to how we parse =
the tables
> > > > > > > > during KASLR setup.
> > > > > >
> > > > > > Right.
> > > > >
> > > > > I've looked at it a bit more and we do something like the patch b=
elow that
> > > > > nearly duplicates acpi_tb_parse_root_table() which is not very ni=
ce.
> > > >
> > > > It looks to me that the code need not be duplicated (see below).
> > > >
> > > > > Besides, reserving ACPI tables early and then calling acpi_table_=
init()
> > > > > (and acpi_tb_parse_root_table() again would mean doing the dance =
with
> > > > > early_memremap() twice for no good reason.
> > > >
> > > > That'd be simply inefficient which is kind of acceptable to me to s=
tart with.
> > > >
> > > > And I changing the ACPICA code can be avoided at least initially, it
> > > > by itself would be a good enough reason.
> > > >
> > > > > I believe the most effective way to deal with this would be to ha=
ve a
> > > > > function that does parsing, reservation and installs the tables s=
upplied by
> > > > > the firmware which can be called really early and then another fu=
nction
> > > > > that overrides tables if needed a some later point.
> > > >
> > > > I agree that this should be the direction to go into.
> > >
> > > So maybe something like the patch below?
> > >
> > > I'm not sure if acpi_boot_table_prepare() gets called early enough, t=
hough.
> >
> > To be 100% safe it should be called before e820__memblock_setup().
>
> OK

Well, that said, reserve_bios_regions() doesn't seem to have concerns
like this and I'm not sure why ACPI tables should be reserved before
this runs.  That applies to efi_reserve_boot_services() too.

I can put the new call before e820__memblock_alloc_reserved_mpc_new(),
but I'm not sure why to put it before efi_reserve_boot_services(),
say?
--===============3268055426456954527==--

