Content-Type: multipart/mixed; boundary="===============8617918278589157123=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: [Devel] Re: [PATCH 1/1] ACPI: fix acpi table use after free
Date: Wed, 10 Mar 2021 19:39:19 +0100
Message-ID: <CAJZ5v0gC+60n0-UkMw8h5JPBc6grQtD1ambSOCAHV2HLm886yQ@mail.gmail.com>
In-Reply-To: 1ae44491-4404-6873-4ee6-6cf58c1ae6fb@redhat.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============8617918278589157123==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 5, 2021 at 2:40 PM David Hildenbrand <david(a)redhat.com> wrote:
>
> >> The ibft table, for example, is mapped in via acpi_map() and kmap(). T=
he
> >> page for the ibft table is not reserved, so it can end up on the freel=
ist.
> >
> > You appear to be saying that it is not sufficient to kmap() a page in
> > order to use it safely.  It is also necessary to reserve it upfront,
> > for example with the help of memblock_reserve().  Is that correct?  If
> > so, is there an alternative way to reserve a page frame?
>
> If the memory is indicated by the BIOS/firmware as valid memory
> (!reserved) but contains actual tables that have to remain untouched
> what happens is:
>
> 1) Memblock thinks the memory should be given to the buddy, because it
>     is valid memory and was not reserved by anyone (i.e., the bios, early
>     allocations).
>
> 2) Memblock will expose the pages to the buddy, adding them to the free
>     page list.
>
> 3) Anybody can allocate them, e.g., via alloc_pages().
>
> The root issue is that pages that should not get exposed to the buddy as
> free pages get exposed to the buddy as free pages. We have to teach
> memblock that these pages are not actually to be used, but instead, area
> reserved.
>
> >
> >>>
> >>>> Use memblock_reserve() to reserve all the ACPI table pages.
> >>> How is this going to help?
> >> If the ibft table page is not reserved, it will end up on the freelist
> >> and potentially be allocated before ibft_init() is called.
> >>
> >> I believe this is the call that causes the ibft table page (in this ca=
se
> >> pfn=3D0xbe453) to end up on the freelist:
> >>
> >> memmap_init_range: size=3Dbd49b, nid=3D0, zone=3D1, start_pfn=3D1000,
> >> zone_end_pfn=3D100000
> >
> > David, is commit 7fef431be9c9 related to this and if so, then how?
> >
>
> Memory gets allocated and used in a different order, which seems to have
> exposed (yet another) latent BUG.

Well, you can call it that, or you can say that things worked under
certain assumptions regarding the memory allocation order which are
not met any more.

> The same could be reproduced via zone shuffling with a little luck.

But nobody does that in practice.

This would be relatively straightforward to address if ACPICA was not
involved in it, but unfortunately that's not the case.

Changing this part of ACPICA is risky, because such changes may affect
other OSes using it, so that requires some serious consideration.
Alternatively, the previous memory allocation order in Linux could be
restored.
--===============8617918278589157123==--

