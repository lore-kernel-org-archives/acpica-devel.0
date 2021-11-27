Content-Type: multipart/mixed; boundary="===============2073799744428652298=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: [Devel] Re: [PATCH] ACPICA: fix swap.cocci warning
Date: Sat, 27 Nov 2021 11:36:14 +0000
Message-ID: <BYAPR11MB325677C8CDA89C5B5C5267A487649@BYAPR11MB3256.namprd11.prod.outlook.com>
In-Reply-To: db9c50a4-dab7-4aba-1ebb-e38fda08cfe1@vivo.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============2073799744428652298==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



-----Original Message-----
From: Guo Zhengkui <guozhengkui(a)vivo.com> =

Sent: Thursday, November 18, 2021 10:31 PM
To: Rafael J. Wysocki <rafael(a)kernel.org>
Cc: Moore, Robert <robert.moore(a)intel.com>; Wysocki, Rafael J <rafael.j.w=
ysocki(a)intel.com>; Len Brown <lenb(a)kernel.org>; ACPI Devel Maling List =
<linux-acpi(a)vger.kernel.org>; open list:ACPI COMPONENT ARCHITECTURE (ACPI=
CA) <devel(a)acpica.org>; Linux Kernel Mailing List <linux-kernel(a)vger.ke=
rnel.org>; kernel <kernel(a)vivo.com>
Subject: Re: [PATCH] ACPICA: fix swap.cocci warning

On 2021/11/18 22:46, Rafael J. Wysocki wrote:
> On Tue, Nov 9, 2021 at 2:47 PM Guo Zhengkui <guozhengkui(a)vivo.com> wrot=
e:
>>
>> Fix following swap.cocci warning:
>> ./drivers/acpi/acpica/nsrepair2.c:896:33-34: WARNING opportunity for =

>> swap()
>>
>> Signed-off-by: Guo Zhengkui <guozhengkui(a)vivo.com>
> =

> This change needs to be submitted to the upstream ACPICA project via =

> https://github.com/acpica/acpica/
> =

> Thanks!

So it means I need to submit this patch to upstream ACPICA project, not lin=
ux-next?


The answer is yes.
Bob


> =

>> ---
>>   drivers/acpi/acpica/nsrepair2.c | 6 ++----
>>   1 file changed, 2 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/acpi/acpica/nsrepair2.c =

>> b/drivers/acpi/acpica/nsrepair2.c index 14b71b41e845..02a904ca4caf =

>> 100644
>> --- a/drivers/acpi/acpica/nsrepair2.c
>> +++ b/drivers/acpi/acpica/nsrepair2.c
>> @@ -8,6 +8,7 @@
>>    *
>>    =

>> *********************************************************************
>> ********/
>>
>> +#include <linux/minmax.h>
>>   #include <acpi/acpi.h>
>>   #include "accommon.h"
>>   #include "acnamesp.h"
>> @@ -875,7 +876,6 @@ acpi_ns_sort_list(union acpi_operand_object **elemen=
ts,
>>   {
>>          union acpi_operand_object *obj_desc1;
>>          union acpi_operand_object *obj_desc2;
>> -       union acpi_operand_object *temp_obj;
>>          u32 i;
>>          u32 j;
>>
>> @@ -892,9 +892,7 @@ acpi_ns_sort_list(union acpi_operand_object **elemen=
ts,
>>                              || ((sort_direction =3D=3D ACPI_SORT_DESCEN=
DING)
>>                                  && (obj_desc1->integer.value <
>>                                      obj_desc2->integer.value))) {
>> -                               temp_obj =3D elements[j - 1];
>> -                               elements[j - 1] =3D elements[j];
>> -                               elements[j] =3D temp_obj;
>> +                               swap(elements[j - 1], elements[j]);
>>                          }
>>                  }
>>          }
>> --
>> 2.20.1
>>

--===============2073799744428652298==--

