Content-Type: multipart/mixed; boundary="===============0978642505193096817=="
MIME-Version: 1.0
From: Jung-uk Kim <jkim at FreeBSD.org>
Subject: [Devel] Re: [PATCH] ACPICA: fix UBSAN warning using __builtin_offsetof
Date: Wed, 10 Jun 2020 19:31:30 -0400
Message-ID: <a896ac5c-dbea-cc06-befd-b59b8e5b1c78@FreeBSD.org>
In-Reply-To: BYAPR11MB3096A0EA2D03BCB76C91F80AF0830@BYAPR11MB3096.namprd11.prod.outlook.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============0978642505193096817==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 20. 6. 10., Kaneda, Erik wrote:
> +JKim (for FreeBSD's perspective)
> =

>> -----Original Message-----
>> From: Nick Desaulniers <ndesaulniers(a)google.com>
>> Sent: Monday, June 1, 2020 4:18 PM
>> To: Moore, Robert <robert.moore(a)intel.com>; Kaneda, Erik
>> <erik.kaneda(a)intel.com>; Wysocki, Rafael J <rafael.j.wysocki(a)intel.c=
om>;
>> Len Brown <lenb(a)kernel.org>
>> Cc: Ard Biesheuvel <ardb(a)kernel.org>; dvyukov(a)google.com;
>> glider(a)google.com; guohanjun(a)huawei.com; linux-arm-
>> kernel(a)lists.infradead.org; linux-kernel(a)vger.kernel.org;
>> lorenzo.pieralisi(a)arm.com; mark.rutland(a)arm.com;
>> ndesaulniers(a)google.com; pcc(a)google.com; rjw(a)rjwysocki.net;
>> will(a)kernel.org; stable(a)vger.kernel.org; linux-acpi(a)vger.kernel.or=
g;
>> devel(a)acpica.org
>> Subject: [PATCH] ACPICA: fix UBSAN warning using __builtin_offsetof
>>
>> Will reported UBSAN warnings:
>> UBSAN: null-ptr-deref in drivers/acpi/acpica/tbfadt.c:459:37
>> UBSAN: null-ptr-deref in arch/arm64/kernel/smp.c:596:6
>>
> Hi,
> =

>> Looks like the emulated offsetof macro ACPI_OFFSET is causing these. We
>> can avoid this by using the compiler builtin, __builtin_offsetof.
>>
> This doesn't really fly because __builtin_offsetof is a compiler extensio=
n.
> =

> It looks like a lot of stddef.h files do this:
> =

> #define offsetof(a,b) __builtin_offset(a,b)
> =

> So does anyone have objections to ACPI_OFFSET being defined to offsetof()?
> =

> This will allow a host OS project project to use their own definitions of=
 offsetof in place of ACPICA's.
> If they don't have a definition for offsetof, we can supply the old one a=
s a fallback.
> =

> Here's a patch:
> =

> --- a/include/acpi/actypes.h
> +++ b/include/acpi/actypes.h
> @@ -504,11 +504,17 @@ typedef u64 acpi_integer;
>  #define ACPI_SUB_PTR(t, a, b)           ACPI_CAST_PTR (t, (ACPI_CAST_PTR=
 (u8, (a)) - (acpi_size)(b)))
>  #define ACPI_PTR_DIFF(a, b)             ((acpi_size) (ACPI_CAST_PTR (u8,=
 (a)) - ACPI_CAST_PTR (u8, (b))))
> =

> +/* Use an existing definiton for offsetof */
> +
> +#ifndef offsetof
> +#define offsetof(d,f)                   ACPI_PTR_DIFF (&(((d *) 0)->f), =
(void *) 0)
> +#endif
> +
>  /* Pointer/Integer type conversions */
> =

>  #define ACPI_TO_POINTER(i)              ACPI_CAST_PTR (void, (acpi_size)=
 (i))
>  #define ACPI_TO_INTEGER(p)              ACPI_PTR_DIFF (p, (void *) 0)
> -#define ACPI_OFFSET(d, f)               ACPI_PTR_DIFF (&(((d *) 0)->f), =
(void *) 0)
> +#define ACPI_OFFSET(d, f)               offsetof (d,f)
>  #define ACPI_PHYSADDR_TO_PTR(i)         ACPI_TO_POINTER(i)
>  #define ACPI_PTR_TO_PHYSADDR(i)         ACPI_TO_INTEGER(i)

LGTM.

Jung-uk Kim

>> The non-kernel runtime of UBSAN would print:
>> runtime error: member access within null pointer of type for this macro.
>>
>> Link: https://lore.kernel.org/lkml/20200521100952.GA5360(a)willie-the-tr=
uck/
>> Cc: stable(a)vger.kernel.org
>> Reported-by: Will Deacon <will(a)kernel.org>
>> Suggested-by: Ard Biesheuvel <ardb(a)kernel.org>
>> Signed-off-by: Nick Desaulniers <ndesaulniers(a)google.com>
>> ---
>>  include/acpi/actypes.h | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h index
>> 4defed58ea33..04359c70b198 100644
>> --- a/include/acpi/actypes.h
>> +++ b/include/acpi/actypes.h
>> @@ -508,7 +508,7 @@ typedef u64 acpi_integer;
>>
>>  #define ACPI_TO_POINTER(i)              ACPI_CAST_PTR (void, (acpi_size=
) (i))
>>  #define ACPI_TO_INTEGER(p)              ACPI_PTR_DIFF (p, (void *) 0)
>> -#define ACPI_OFFSET(d, f)               ACPI_PTR_DIFF (&(((d *) 0)->f),=
 (void *)
>> 0)
>> +#define ACPI_OFFSET(d, f)               __builtin_offsetof(d, f)
>>  #define ACPI_PHYSADDR_TO_PTR(i)         ACPI_TO_POINTER(i)
>>  #define ACPI_PTR_TO_PHYSADDR(i)         ACPI_TO_INTEGER(i)
>>
>> --
>> 2.27.0.rc2.251.g90737beb825-goog
>=20

--===============0978642505193096817==--

