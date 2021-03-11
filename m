Content-Type: multipart/mixed; boundary="===============8092596597581144744=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: [Devel] Re: [PATCH 1/1] ACPI: fix acpi table use after free
Date: Thu, 11 Mar 2021 16:36:31 +0100
Message-ID: <CAJZ5v0jOpNJrOt5xn-1YkSB9Q15NZS2cxmsGKAU945YNbs+hOw@mail.gmail.com>
In-Reply-To: 0d05364c-4881-d78a-9721-bd15f5eb822b@redhat.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============8092596597581144744==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 10, 2021 at 8:47 PM David Hildenbrand <david(a)redhat.com> wrot=
e:
>
> >>>>> The same could be reproduced via zone shuffling with a little luck.
> >>>>
> >>>> But nobody does that in practice.
> >>>>
> >>
> >> Dan will most certainly object. And I don't know what makes you speak =
in
> >> absolute words here.
> >>
> >>>> This would be relatively straightforward to address if ACPICA was not
> >>>> involved in it, but unfortunately that's not the case.
> >>>>
> >>>> Changing this part of ACPICA is risky, because such changes may affe=
ct
> >>>> other OSes using it, so that requires some serious consideration.
> >>>> Alternatively, the previous memory allocation order in Linux could be
> >>>> restored.
> >>>
> >>> Of course, long-term this needs to be addressed in the ACPI
> >>> initialization code, because it clearly is not robust enough, but in
> >>> the meantime there's practical breakage observable in the field, so
> >>> what can be done about that?
> >>
> >> *joke* enable zone shuffling.
> >>
> >> No seriously, fix the latent BUG. What again is problematic about excl=
uding
> >> these pages from the page allcoator, for example, via memblock_reserve=
()?
> >>
> >> @Mike?
> >
> > There is some care that should be taken to make sure we get the order
> > right, but I don't see a fundamental issue here.

Me neither.

> > If I understand correctly, Rafael's concern is about changing the parts=
 of
> > ACPICA that should be OS agnostic, so I think we just need another plac=
e to
> > call memblock_reserve() rather than acpi_tb_install_table_with_override=
().

Something like this.

There is also the problem that memblock_reserve() needs to be called
for all of the tables early enough, which will require some reordering
of the early init code.

> > Since the reservation should be done early in x86::setup_arch() (and
> > probably in arm64::setup_arch()) we might just have a function that par=
ses
> > table headers and reserves them, similarly to how we parse the tables
> > during KASLR setup.

Right.

>
> FWIW, something like below would hide our latent BUG again properly (lol).
> But I guess I don't have to express how ugly and wrong that is. Not to me=
ntion
> what happens if memblock decides to allocate that memory area earlier
> for some other user (including CMA, ...).

Fair enough.

> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 3e4b29ee2b1e..ec71b7c63dbe 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1566,6 +1566,21 @@ void __free_pages_core(struct page *page, unsigned=
 int order)
>
>          atomic_long_add(nr_pages, &page_zone(page)->managed_pages);
>
> +       /*
> +        * BUG ALERT: x86-64 ACPI code has latent BUGs where ACPI tables
> +        * that must not get allocated/modified will get exposed to the b=
uddy
> +        * as free pages; anybody can allocate and use them once in the f=
ree
> +        * lists.
> +        *
> +        * Instead of fixing the BUG, revert the change to the
> +        * freeing/allocation order during boot that revealed it and cross
> +        * fingers that everything will be fine.
> +        */
> +       if (system_state < SYSTEM_RUNNING) {
> +               __free_pages_ok(page, order, FPI_NONE);
> +               return;
> +       }
> +
>          /*
>           * Bypass PCP and place fresh pages right to the tail, primarily
>           * relevant for memory onlining.
>
>
> --
--===============8092596597581144744==--

