Content-Type: multipart/mixed; boundary="===============1867726984847822356=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: [Devel] Re: [PATCH] ACPI: avoid NULL pointer arithmetic
Date: Wed, 29 Sep 2021 20:47:14 +0200
Message-ID: <CAJZ5v0jJRYQPSfVV_hCD6uxch+vU6kvWV9-KAfqHckHgkFOeaA@mail.gmail.com>
In-Reply-To: 20210927121338.938994-1-arnd@kernel.org
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============1867726984847822356==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 27, 2021 at 2:13 PM Arnd Bergmann <arnd(a)kernel.org> wrote:
>
> From: Arnd Bergmann <arnd(a)arndb.de>
>
> There are some very old macros for doing an open-coded offsetof() and
> cast between pointer and integer in ACPI headers. clang-14 now complains
> about these:
>
> drivers/acpi/acpica/tbfadt.c:86:3: error: performing pointer subtraction =
with a null pointer has undefined behavior [-Werror,-Wnull-pointer-subtract=
ion]
>          ACPI_FADT_OFFSET(pm_timer_block),
>          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> include/acpi/actbl.h:376:47: note: expanded from macro 'ACPI_FADT_OFFSET'
>  #define ACPI_FADT_OFFSET(f)             (u16) ACPI_OFFSET (struct acpi_t=
able_fadt, f)
>                                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~~~~
> include/acpi/actypes.h:511:41: note: expanded from macro 'ACPI_OFFSET'
>  #define ACPI_OFFSET(d, f)               ACPI_PTR_DIFF (&(((d *) 0)->f), =
(void *) 0)
>                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~~
> include/acpi/actypes.h:505:79: note: expanded from macro 'ACPI_PTR_DIFF'
>  #define ACPI_PTR_DIFF(a, b)             ((acpi_size) (ACPI_CAST_PTR (u8,=
 (a)) - ACPI_CAST_PTR (u8, (b))))
>                                                                          =
     ^ ~~~~~~~~~~~~~~~~~~~~~~~
> Convert them to the modern equivalents.
>
> Signed-off-by: Arnd Bergmann <arnd(a)arndb.de>
> ---
>  include/acpi/actypes.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
> index 92c71dfce0d5..285bc7b73de3 100644
> --- a/include/acpi/actypes.h
> +++ b/include/acpi/actypes.h
> @@ -507,8 +507,8 @@ typedef u64 acpi_integer;
>  /* Pointer/Integer type conversions */
>
>  #define ACPI_TO_POINTER(i)              ACPI_CAST_PTR (void, (acpi_size)=
 (i))
> -#define ACPI_TO_INTEGER(p)              ACPI_PTR_DIFF (p, (void *) 0)
> -#define ACPI_OFFSET(d, f)               ACPI_PTR_DIFF (&(((d *) 0)->f), =
(void *) 0)
> +#define ACPI_TO_INTEGER(p)              ((uintptr_t)(p))
> +#define ACPI_OFFSET(d, f)               offsetof(d, f)
>  #define ACPI_PHYSADDR_TO_PTR(i)         ACPI_TO_POINTER(i)
>  #define ACPI_PTR_TO_PHYSADDR(i)         ACPI_TO_INTEGER(i)
>
> --

Queued up as 5.16 material, converted into an upstream ACPICA pull
request and submitted, thanks!
--===============1867726984847822356==--

