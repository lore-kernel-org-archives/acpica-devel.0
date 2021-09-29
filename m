Content-Type: multipart/mixed; boundary="===============3943811635576720764=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: [Devel] Re: [PATCH] ACPI: avoid NULL pointer arithmetic
Date: Wed, 29 Sep 2021 14:01:41 +0200
Message-ID: <CAJZ5v0gHgMVjKzKUnJ0HkE+Bz7-1Rav3FnLA+ycF94JTw5V=ww@mail.gmail.com>
In-Reply-To: BYAPR11MB32560CEAC6CC3C2E93FBBF9387A89@BYAPR11MB3256.namprd11.prod.outlook.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============3943811635576720764==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 28, 2021 at 10:39 PM Moore, Robert <robert.moore(a)intel.com> w=
rote:
>
> I can take this patch as-is, I think. I'll try for the next acpica releas=
e later this week.

Thanks!


> -----Original Message-----
> From: Wysocki, Rafael J <rafael.j.wysocki(a)intel.com>
> Sent: Tuesday, September 28, 2021 10:44 AM
> To: Arnd Bergmann <arnd(a)kernel.org>; Moore, Robert <robert.moore(a)inte=
l.com>
> Cc: Arnd Bergmann <arnd(a)arndb.de>; Nathan Chancellor <nathan(a)kernel.o=
rg>; Nick Desaulniers <ndesaulniers(a)google.com>; Erik Kaneda <erik.kaneda=
(a)intel.com>; linux-acpi(a)vger.kernel.org; devel(a)acpica.org; linux-kern=
el(a)vger.kernel.org; llvm(a)lists.linux.dev; Len Brown <lenb(a)kernel.org>=
; Rafael J. Wysocki <rafael(a)kernel.org>
> Subject: Re: [PATCH] ACPI: avoid NULL pointer arithmetic
>
> Bob, this is ACPICA material.
>
> Would it be possible to apply this to the upstream from the patch or do y=
ou need  a PR for this?
>
> On 9/27/2021 2:13 PM, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd(a)arndb.de>
> >
> > There are some very old macros for doing an open-coded offsetof() and
> > cast between pointer and integer in ACPI headers. clang-14 now
> > complains about these:
> >
> > drivers/acpi/acpica/tbfadt.c:86:3: error: performing pointer subtractio=
n with a null pointer has undefined behavior [-Werror,-Wnull-pointer-subtra=
ction]
> >           ACPI_FADT_OFFSET(pm_timer_block),
> >           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > include/acpi/actbl.h:376:47: note: expanded from macro 'ACPI_FADT_OFFSE=
T'
> >   #define ACPI_FADT_OFFSET(f)             (u16) ACPI_OFFSET (struct acp=
i_table_fadt, f)
> >
> > ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > include/acpi/actypes.h:511:41: note: expanded from macro 'ACPI_OFFSET'
> >   #define ACPI_OFFSET(d, f)               ACPI_PTR_DIFF (&(((d *) 0)->f=
), (void *) 0)
> >
> > ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > include/acpi/actypes.h:505:79: note: expanded from macro 'ACPI_PTR_DIFF'
> >   #define ACPI_PTR_DIFF(a, b)             ((acpi_size) (ACPI_CAST_PTR (=
u8, (a)) - ACPI_CAST_PTR (u8, (b))))
> >
> > ^ ~~~~~~~~~~~~~~~~~~~~~~~ Convert them to the modern equivalents.
> >
> > Signed-off-by: Arnd Bergmann <arnd(a)arndb.de>
> > ---
> >   include/acpi/actypes.h | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h index
> > 92c71dfce0d5..285bc7b73de3 100644
> > --- a/include/acpi/actypes.h
> > +++ b/include/acpi/actypes.h
> > @@ -507,8 +507,8 @@ typedef u64 acpi_integer;
> >   /* Pointer/Integer type conversions */
> >
> >   #define ACPI_TO_POINTER(i)              ACPI_CAST_PTR (void, (acpi_si=
ze) (i))
> > -#define ACPI_TO_INTEGER(p)              ACPI_PTR_DIFF (p, (void *) 0)
> > -#define ACPI_OFFSET(d, f)               ACPI_PTR_DIFF (&(((d *) 0)->f)=
, (void *) 0)
> > +#define ACPI_TO_INTEGER(p)              ((uintptr_t)(p))
> > +#define ACPI_OFFSET(d, f)               offsetof(d, f)
> >   #define ACPI_PHYSADDR_TO_PTR(i)         ACPI_TO_POINTER(i)
> >   #define ACPI_PTR_TO_PHYSADDR(i)         ACPI_TO_INTEGER(i)
> >
>
>
--===============3943811635576720764==--

