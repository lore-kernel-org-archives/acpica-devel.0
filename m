Content-Type: multipart/mixed; boundary="===============8510851698038111846=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: [Devel] Re: [PATCH] ACPI: avoid NULL pointer arithmetic
Date: Tue, 28 Sep 2021 20:39:55 +0000
Message-ID: <BYAPR11MB32560CEAC6CC3C2E93FBBF9387A89@BYAPR11MB3256.namprd11.prod.outlook.com>
In-Reply-To: 92b02547-3aa5-537f-a782-7a25854d88fe@intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============8510851698038111846==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

I can take this patch as-is, I think. I'll try for the next acpica release =
later this week.


-----Original Message-----
From: Wysocki, Rafael J <rafael.j.wysocki(a)intel.com> =

Sent: Tuesday, September 28, 2021 10:44 AM
To: Arnd Bergmann <arnd(a)kernel.org>; Moore, Robert <robert.moore(a)intel.=
com>
Cc: Arnd Bergmann <arnd(a)arndb.de>; Nathan Chancellor <nathan(a)kernel.org=
>; Nick Desaulniers <ndesaulniers(a)google.com>; Erik Kaneda <erik.kaneda(a=
)intel.com>; linux-acpi(a)vger.kernel.org; devel(a)acpica.org; linux-kernel=
(a)vger.kernel.org; llvm(a)lists.linux.dev; Len Brown <lenb(a)kernel.org>; =
Rafael J. Wysocki <rafael(a)kernel.org>
Subject: Re: [PATCH] ACPI: avoid NULL pointer arithmetic

Bob, this is ACPICA material.

Would it be possible to apply this to the upstream from the patch or do you=
 need=C2=A0 a PR for this?

On 9/27/2021 2:13 PM, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd(a)arndb.de>
>
> There are some very old macros for doing an open-coded offsetof() and =

> cast between pointer and integer in ACPI headers. clang-14 now =

> complains about these:
>
> drivers/acpi/acpica/tbfadt.c:86:3: error: performing pointer subtraction =
with a null pointer has undefined behavior [-Werror,-Wnull-pointer-subtract=
ion]
>           ACPI_FADT_OFFSET(pm_timer_block),
>           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> include/acpi/actbl.h:376:47: note: expanded from macro 'ACPI_FADT_OFFSET'
>   #define ACPI_FADT_OFFSET(f)             (u16) ACPI_OFFSET (struct acpi_=
table_fadt, f)
>                                                =

> ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> include/acpi/actypes.h:511:41: note: expanded from macro 'ACPI_OFFSET'
>   #define ACPI_OFFSET(d, f)               ACPI_PTR_DIFF (&(((d *) 0)->f),=
 (void *) 0)
>                                          =

> ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> include/acpi/actypes.h:505:79: note: expanded from macro 'ACPI_PTR_DIFF'
>   #define ACPI_PTR_DIFF(a, b)             ((acpi_size) (ACPI_CAST_PTR (u8=
, (a)) - ACPI_CAST_PTR (u8, (b))))
>                                                                          =
      =

> ^ ~~~~~~~~~~~~~~~~~~~~~~~ Convert them to the modern equivalents.
>
> Signed-off-by: Arnd Bergmann <arnd(a)arndb.de>
> ---
>   include/acpi/actypes.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h index =

> 92c71dfce0d5..285bc7b73de3 100644
> --- a/include/acpi/actypes.h
> +++ b/include/acpi/actypes.h
> @@ -507,8 +507,8 @@ typedef u64 acpi_integer;
>   /* Pointer/Integer type conversions */
>   =

>   #define ACPI_TO_POINTER(i)              ACPI_CAST_PTR (void, (acpi_size=
) (i))
> -#define ACPI_TO_INTEGER(p)              ACPI_PTR_DIFF (p, (void *) 0)
> -#define ACPI_OFFSET(d, f)               ACPI_PTR_DIFF (&(((d *) 0)->f), =
(void *) 0)
> +#define ACPI_TO_INTEGER(p)              ((uintptr_t)(p))
> +#define ACPI_OFFSET(d, f)               offsetof(d, f)
>   #define ACPI_PHYSADDR_TO_PTR(i)         ACPI_TO_POINTER(i)
>   #define ACPI_PTR_TO_PHYSADDR(i)         ACPI_TO_INTEGER(i)
>   =




--===============8510851698038111846==--

