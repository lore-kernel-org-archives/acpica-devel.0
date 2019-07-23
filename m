Content-Type: multipart/mixed; boundary="===============3476543176326044262=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: Re: [Devel] [PATCH] acpica: fix -Wnull-pointer-arithmetic warnings
Date: Tue, 23 Jul 2019 20:49:52 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E3B9661869@ORSMSX110.amr.corp.intel.com>
In-Reply-To: 73A4565B-837B-4E13-8B72-63F69BF408E7@lca.pw
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============3476543176326044262==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



-----Original Message-----
From: Qian Cai [mailto:cai(a)lca.pw] =

Sent: Wednesday, July 17, 2019 5:50 PM
To: Nick Desaulniers <ndesaulniers(a)google.com>
Cc: Wysocki, Rafael J <rafael.j.wysocki(a)intel.com>; Moore, Robert <robert=
.moore(a)intel.com>; Schmauss, Erik <erik.schmauss(a)intel.com>; jkim(a)fre=
ebsd.org; Len Brown <lenb(a)kernel.org>; linux-acpi(a)vger.kernel.org; deve=
l(a)acpica.org; clang-built-linux <clang-built-linux(a)googlegroups.com>; L=
KML <linux-kernel(a)vger.kernel.org>
Subject: Re: [PATCH] acpica: fix -Wnull-pointer-arithmetic warnings



> On Jul 17, 2019, at 6:01 PM, Nick Desaulniers <ndesaulniers(a)google.com>=
 wrote:
> =

> On Tue, Jul 16, 2019 at 8:38 PM Qian Cai <cai(a)lca.pw> wrote:
>> =

>> Clang generate quite a few of those warnings.
>> =

>> drivers/acpi/scan.c:759:28: warning: arithmetic on a null pointer =

>> treated as a cast from integer to pointer is a GNU extension =

>> [-Wnull-pointer-arithmetic]
>>                status =3D acpi_get_handle(ACPI_ROOT_OBJECT,
>> obj->string.pointer,
>>                                         ^~~~~~~~~~~~~~~~
>> ./include/acpi/actypes.h:458:56: note: expanded from macro =

>> 'ACPI_ROOT_OBJECT'
>> #define ACPI_ROOT_OBJECT                ((acpi_handle) ACPI_TO_POINTER
>> (ACPI_MAX_PTR))
>>                                                        =

>> ^~~~~~~~~~~~~~~
>> ./include/acpi/actypes.h:509:41: note: expanded from macro =

>> 'ACPI_TO_POINTER'
>> #define ACPI_TO_POINTER(i)              ACPI_ADD_PTR (void, (void *) 0,
>> (acpi_size) (i))
>>                                         =

>> ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> ./include/acpi/actypes.h:503:84: note: expanded from macro =

>> 'ACPI_ADD_PTR'
>> #define ACPI_ADD_PTR(t, a, b)           ACPI_CAST_PTR (t,
>> (ACPI_CAST_PTR (u8, (a)) + (acpi_size)(b)))
>>                                         ^~~~~~~~~~~~~~~~~
>> ./include/acpi/actypes.h:501:66: note: expanded from macro =

>> 'ACPI_CAST_PTR'
>> #define ACPI_CAST_PTR(t, p)             ((t *) (acpi_uintptr_t) (p))
>>                                                                  ^ =

>> This is because pointer arithmetic on a pointer not pointing to an =

>> array is an undefined behavior. Fix it by doing an integer arithmetic =

>> instead.
> =

> Hi Qian, thanks for the patch.  How do I reproduce this issue, =

> precisely?  I just tried:
> $ make CC=3Dclang -j71 drivers/acpi/scan.o on linux-next today and don't =

> observe the warning.  My clang is ToT built sometime this week.  It =

> looks like drivers/acpi/scan.o when CONFIG_ACPI=3Dy, which is set in the =

> defconfig.  Is there another set of configs to enable to observe the =

> warning?

# make W=3D1 -j 256

With the config,

https://raw.githubusercontent.com/cailca/linux-mm/master/arm64.config =


> =

> Also, the fix is curious.  Arithmetic on pointers to different =

> "objects" (with one element passed the end) may lead to provence =

> issues due to undefined behavior, but I would have expected some cases =

> to uintptr_t, then arithmetic on that type, as the solution (which is =

> what I suspect ACPI_CAST_PTR is doing).
> =

> Further, you seem to have modified ACPI_ADD_PTR but not ACPI_SUB_PTR; =

> I would have expected both to be afflicted together or not at all =

> based on their existing implementations.

Yes, I thought about that, but ACPI_SUB_PTR does not seem used anywhere, so=
 I thought maybe just start a new discussion to remove it all together late=
r.

ACPI_SUB_PTR is used in the iasl data table compiler.


> =

>> =

>> Signed-off-by: Qian Cai <cai(a)lca.pw>
>> ---
>> include/acpi/actypes.h | 4 ++--
>> 1 file changed, 2 insertions(+), 2 deletions(-)
>> =

>> diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h index =

>> ad6892a24015..25b4a32da177 100644
>> --- a/include/acpi/actypes.h
>> +++ b/include/acpi/actypes.h
>> @@ -500,13 +500,13 @@ typedef u64 acpi_integer;
>> =

>> #define ACPI_CAST_PTR(t, p)             ((t *) (acpi_uintptr_t) (p))
>> #define ACPI_CAST_INDIRECT_PTR(t, p)    ((t **) (acpi_uintptr_t) (p))
>> -#define ACPI_ADD_PTR(t, a, b)           ACPI_CAST_PTR (t, (ACPI_CAST_PT=
R (u8, (a)) + (acpi_size)(b)))
>> +#define ACPI_ADD_PTR(t, a, b)           ACPI_CAST_PTR (t, (a) + (acpi_s=
ize)(b))

We have some questions concerning this change. If (a) is not cast to a u8, =
the addition will be in whatever units are appropriate for (a) i.e., the ty=
pe of (a). However, we want ACPI_ADD_PTR (And ACPI_SUB_PTR) to simply perfo=
rm a byte addition or subtraction - thus the cast to u8. I believe that is =
the original thinking behind the macros.

>> #define ACPI_SUB_PTR(t, a, b)           ACPI_CAST_PTR (t, (ACPI_CAST_PTR=
 (u8, (a)) - (acpi_size)(b)))
>> #define ACPI_PTR_DIFF(a, b)             ((acpi_size) (ACPI_CAST_PTR (u8,=
 (a)) - ACPI_CAST_PTR (u8, (b))))
>> =

>> /* Pointer/Integer type conversions */
>> =

>> -#define ACPI_TO_POINTER(i)              ACPI_ADD_PTR (void, (void *) 0,=
 (acpi_size) (i))
>> +#define ACPI_TO_POINTER(i)              ACPI_ADD_PTR (void, 0, (acpi_si=
ze) (i))
> =

> IIUC, these are adding `i` to NULL (or (void*)0)? X + 0 =3D=3D X ?
> --
> Thanks,
> ~Nick Desaulniers


--===============3476543176326044262==--

