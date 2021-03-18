Content-Type: multipart/mixed; boundary="===============8874661952942508003=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: [Devel] Re: [PATCH 1/1] ACPI: fix acpi table use after free
Date: Thu, 18 Mar 2021 16:42:21 +0100
Message-ID: <CAJZ5v0g81pE6S_bYV_ECvvzifEUFznWUOVcC8X5v-MQb4-th_g@mail.gmail.com>
In-Reply-To: bad1ea33-1a6e-bd4d-b795-fbc51ac6ecca@oracle.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============8874661952942508003==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 17, 2021 at 11:28 PM George Kennedy
<george.kennedy(a)oracle.com> wrote:
>
>
>
> On 3/17/2021 4:14 PM, Rafael J. Wysocki wrote:
> > On Monday, March 15, 2021 5:19:29 PM CET Rafael J. Wysocki wrote:
> >> On Sun, Mar 14, 2021 at 8:00 PM Mike Rapoport <rppt(a)linux.ibm.com> w=
rote:
> >>> On Thu, Mar 11, 2021 at 04:36:31PM +0100, Rafael J. Wysocki wrote:
> >>>> On Wed, Mar 10, 2021 at 8:47 PM David Hildenbrand <david(a)redhat.co=
m> wrote:
> >>>>>> There is some care that should be taken to make sure we get the or=
der
> >>>>>> right, but I don't see a fundamental issue here.
> >>>> Me neither.
> >>>>
> >>>>>> If I understand correctly, Rafael's concern is about changing the =
parts of
> >>>>>> ACPICA that should be OS agnostic, so I think we just need another=
 place to
> >>>>>> call memblock_reserve() rather than acpi_tb_install_table_with_ove=
rride().
> >>>> Something like this.
> >>>>
> >>>> There is also the problem that memblock_reserve() needs to be called
> >>>> for all of the tables early enough, which will require some reorderi=
ng
> >>>> of the early init code.
> >>>>
> >>>>>> Since the reservation should be done early in x86::setup_arch() (a=
nd
> >>>>>> probably in arm64::setup_arch()) we might just have a function tha=
t parses
> >>>>>> table headers and reserves them, similarly to how we parse the tab=
les
> >>>>>> during KASLR setup.
> >>>> Right.
> >>> I've looked at it a bit more and we do something like the patch below=
 that
> >>> nearly duplicates acpi_tb_parse_root_table() which is not very nice.
> >> It looks to me that the code need not be duplicated (see below).
> >>
> >>> Besides, reserving ACPI tables early and then calling acpi_table_init=
()
> >>> (and acpi_tb_parse_root_table() again would mean doing the dance with
> >>> early_memremap() twice for no good reason.
> >> That'd be simply inefficient which is kind of acceptable to me to star=
t with.
> >>
> >> And I changing the ACPICA code can be avoided at least initially, it
> >> by itself would be a good enough reason.
> >>
> >>> I believe the most effective way to deal with this would be to have a
> >>> function that does parsing, reservation and installs the tables suppl=
ied by
> >>> the firmware which can be called really early and then another functi=
on
> >>> that overrides tables if needed a some later point.
> >> I agree that this should be the direction to go into.
> > So maybe something like the patch below?
>
> Do you want me to try it out in the failing setup?

Yes, please!
--===============8874661952942508003==--

