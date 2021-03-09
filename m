Content-Type: multipart/mixed; boundary="===============5405947666641590165=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: [Devel] Re: [PATCH 1/1] ACPI: fix acpi table use after free
Date: Tue, 09 Mar 2021 19:29:51 +0100
Message-ID: <CAJZ5v0hAQo7+3bthoC8K7n7qyhQFMuOd8U3BhZWSREjPmq0-7w@mail.gmail.com>
In-Reply-To: YEe2SAESEaEak+HB@linux.ibm.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============5405947666641590165==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 9, 2021 at 6:54 PM Mike Rapoport <rppt(a)linux.ibm.com> wrote:
>
> On Sun, Mar 07, 2021 at 09:46:22AM +0200, Mike Rapoport wrote:
> > Hello Rafael,
> >
> > On Fri, Mar 05, 2021 at 02:30:07PM +0100, Rafael J. Wysocki wrote:
> > > On Fri, Mar 5, 2021 at 12:14 AM George Kennedy <george.kennedy(a)orac=
le.com> wrote:
> > >
> > > > The ibft table, for example, is mapped in via acpi_map() and kmap()=
. The
> > > > page for the ibft table is not reserved, so it can end up on the fr=
eelist.
> > >
> > > You appear to be saying that it is not sufficient to kmap() a page in
> > > order to use it safely.  It is also necessary to reserve it upfront,
> > > for example with the help of memblock_reserve().  Is that correct?  If
> > > so, is there an alternative way to reserve a page frame?
> >
> > Like David said in the other reply, if a BIOS does not mark the memory =
that
> > contains an ACPI table as used (e.g. reserved or ACPI data), we need to
> > make sure the kernel knows that such memory is in use and an early call=
 to
> > memblock_reserve() is exactly what we need here.
> > George had this issue with iBFT, but in general this could be any table
> > that a buggy BIOS forgot to mark as ACPI data.
>
> BTW, I wonder is there a fundamental reason to use ioremap() to access AC=
PI
> tables at all?
> In the end, they reside in RAM and, apparently, they live at the same DIMM
> as neighboring "normal memory" so why cannot we just map them normally as
> read-only not executable?

This may be NVS memory (depending on the configuration of the system)
which isn't "normal" RAM AFAICS.
--===============5405947666641590165==--

