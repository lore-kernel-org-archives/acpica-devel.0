Content-Type: multipart/mixed; boundary="===============6273090359165684423=="
MIME-Version: 1.0
From: Jung-uk Kim <jkim at FreeBSD.org>
Subject: [Devel] Re: [PATCH] ACPICA: fix UBSAN warning using __builtin_offsetof
Date: Wed, 10 Jun 2020 19:46:19 -0400
Message-ID: <9f4322a5-eea6-fb65-449c-90f3d85f753e@FreeBSD.org>
In-Reply-To: CAKwvOdnh6Zh+P9SM_qFiy-9u7Y21fn=byTJtG4fTTRJqqU9bcQ@mail.gmail.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============6273090359165684423==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 20. 6. 10., Nick Desaulniers wrote:
> On Wed, Jun 10, 2020 at 4:07 PM Kaneda, Erik <erik.kaneda(a)intel.com> wr=
ote:
>>
>> +JKim (for FreeBSD's perspective)
>>
>>> -----Original Message-----
>>> From: Nick Desaulniers <ndesaulniers(a)google.com>
>>> Sent: Monday, June 1, 2020 4:18 PM
>>> To: Moore, Robert <robert.moore(a)intel.com>; Kaneda, Erik
>>> <erik.kaneda(a)intel.com>; Wysocki, Rafael J <rafael.j.wysocki(a)intel.=
com>;
>>> Len Brown <lenb(a)kernel.org>
>>> Cc: Ard Biesheuvel <ardb(a)kernel.org>; dvyukov(a)google.com;
>>> glider(a)google.com; guohanjun(a)huawei.com; linux-arm-
>>> kernel(a)lists.infradead.org; linux-kernel(a)vger.kernel.org;
>>> lorenzo.pieralisi(a)arm.com; mark.rutland(a)arm.com;
>>> ndesaulniers(a)google.com; pcc(a)google.com; rjw(a)rjwysocki.net;
>>> will(a)kernel.org; stable(a)vger.kernel.org; linux-acpi(a)vger.kernel.o=
rg;
>>> devel(a)acpica.org
>>> Subject: [PATCH] ACPICA: fix UBSAN warning using __builtin_offsetof
>>>
>>> Will reported UBSAN warnings:
>>> UBSAN: null-ptr-deref in drivers/acpi/acpica/tbfadt.c:459:37
>>> UBSAN: null-ptr-deref in arch/arm64/kernel/smp.c:596:6
>>>
>> Hi,
>>
>>> Looks like the emulated offsetof macro ACPI_OFFSET is causing these. We
>>> can avoid this by using the compiler builtin, __builtin_offsetof.
>>>
>> This doesn't really fly because __builtin_offsetof is a compiler extensi=
on.
>>
>> It looks like a lot of stddef.h files do this:
>>
>> #define offsetof(a,b) __builtin_offset(a,b)
>>
>> So does anyone have objections to ACPI_OFFSET being defined to offsetof(=
)?
>>
>> This will allow a host OS project project to use their own definitions o=
f offsetof in place of ACPICA's.
>> If they don't have a definition for offsetof, we can supply the old one =
as a fallback.
>>
>> Here's a patch:
>>
>> --- a/include/acpi/actypes.h
>> +++ b/include/acpi/actypes.h
>> @@ -504,11 +504,17 @@ typedef u64 acpi_integer;
>>  #define ACPI_SUB_PTR(t, a, b)           ACPI_CAST_PTR (t, (ACPI_CAST_PT=
R (u8, (a)) - (acpi_size)(b)))
>>  #define ACPI_PTR_DIFF(a, b)             ((acpi_size) (ACPI_CAST_PTR (u8=
, (a)) - ACPI_CAST_PTR (u8, (b))))
>>
>> +/* Use an existing definiton for offsetof */
> =

> s/definiton/definition/
> =

>> +
>> +#ifndef offsetof
>> +#define offsetof(d,f)                   ACPI_PTR_DIFF (&(((d *) 0)->f),=
 (void *) 0)
>> +#endif
> =

> If this header doesn't explicitly include <stddef.h> or
> <linux/stddef.h>, won't translation units that include
> <acpi/actypes.h> get different definitions of ACPI_OFFSET based on
> whether they explicitly or transitively included <stddef.h> before
> including <acpi/actypes.h>?  Theoretically, a translation unit in the
> kernel could include actypes.h, have no includes of linux/stddef.h,
> then get UBSAN errors again from using this definition?
> =

> I don't mind using offsetof in place of the builtin (since it
> typically will be implemented in terms of the builtin, or is at least
> for the case specific to the Linux kernel). But if it's used, we
> should include the header that defines it properly, and we should not
> use the host's <stddef.h> IMO.  Is there a platform specific way to
> include the platform's stddef.h here?
> =

> Maybe linux/stddef.h should be included in
> include/acpi/platform/aclinux.h, then include/acpi/platform/acenv.h
> included in include/acpi/actypes.h, such that ACPI_OFFSET is defined
> in terms of offsetof defined from that transitive dependency of
> headers? (or do we get a circular inclusion trying to do that?)

Actually, I think we should let platform-specific acfoo.h decide what to
do here, i.e.,

#ifndef ACPI_OFFSET
#define ACPI_OFFSET(d, f) ...
#endif

Jung-uk Kim

>> +
>>  /* Pointer/Integer type conversions */
>>
>>  #define ACPI_TO_POINTER(i)              ACPI_CAST_PTR (void, (acpi_size=
) (i))
>>  #define ACPI_TO_INTEGER(p)              ACPI_PTR_DIFF (p, (void *) 0)
>> -#define ACPI_OFFSET(d, f)               ACPI_PTR_DIFF (&(((d *) 0)->f),=
 (void *) 0)
>> +#define ACPI_OFFSET(d, f)               offsetof (d,f)
>>  #define ACPI_PHYSADDR_TO_PTR(i)         ACPI_TO_POINTER(i)
>>  #define ACPI_PTR_TO_PHYSADDR(i)         ACPI_TO_INTEGER(i)
>>
>> Thanks,
>> Erik
>>
>>> The non-kernel runtime of UBSAN would print:
>>> runtime error: member access within null pointer of type for this macro.
>>>
>>> Link: https://lore.kernel.org/lkml/20200521100952.GA5360(a)willie-the-t=
ruck/
>>> Cc: stable(a)vger.kernel.org
>>> Reported-by: Will Deacon <will(a)kernel.org>
>>> Suggested-by: Ard Biesheuvel <ardb(a)kernel.org>
>>> Signed-off-by: Nick Desaulniers <ndesaulniers(a)google.com>
>>> ---
>>>  include/acpi/actypes.h | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h index
>>> 4defed58ea33..04359c70b198 100644
>>> --- a/include/acpi/actypes.h
>>> +++ b/include/acpi/actypes.h
>>> @@ -508,7 +508,7 @@ typedef u64 acpi_integer;
>>>
>>>  #define ACPI_TO_POINTER(i)              ACPI_CAST_PTR (void, (acpi_siz=
e) (i))
>>>  #define ACPI_TO_INTEGER(p)              ACPI_PTR_DIFF (p, (void *) 0)
>>> -#define ACPI_OFFSET(d, f)               ACPI_PTR_DIFF (&(((d *) 0)->f)=
, (void *)
>>> 0)
>>> +#define ACPI_OFFSET(d, f)               __builtin_offsetof(d, f)
>>>  #define ACPI_PHYSADDR_TO_PTR(i)         ACPI_TO_POINTER(i)
>>>  #define ACPI_PTR_TO_PHYSADDR(i)         ACPI_TO_INTEGER(i)
>>>
>>> --
>>> 2.27.0.rc2.251.g90737beb825-goog


--===============6273090359165684423==--

