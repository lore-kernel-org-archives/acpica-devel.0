Content-Type: multipart/mixed; boundary="===============0087279607423002062=="
MIME-Version: 1.0
From: Ganapatrao Kulkarni <gpkulkarni at gmail.com>
Subject: Re: [Devel] [PATCH] iasl: Update to IORT SMMUv3 disassembling
Date: Fri, 16 Jun 2017 07:57:22 +0530
Message-ID: <CAFpQJXXmnp0CvEXEmK=BZ8SM=Awp5xVkUxkxB=rVJ+MQAsSDGg@mail.gmail.com>
In-Reply-To: a01f1bae-5dc1-703d-2720-44771fd2ef53@linaro.org
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============0087279607423002062==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Hanjun,

On Fri, Jun 16, 2017 at 6:28 AM, Hanjun Guo <hanjun.guo(a)linaro.org> wrote:
> Hi Ganapat,
>
>
> On 2017/6/6 12:27, Ganapatrao Kulkarni wrote:
>>
>> ARM IORT specification has provision to define Proximity domain
>> in SMMUv3 IORT table. Adding required changes to decode
>> Proximity domain of SMMUv3 IORT table.
>>
>> Signed-off-by: Ganapatrao Kulkarni <ganapatrao.kulkarni(a)cavium.com>
>> ---
>>   source/common/dmtbinfo.c | 2 ++
>>   source/include/actbl2.h  | 4 ++++
>>   2 files changed, 6 insertions(+)
>>
>> diff --git a/source/common/dmtbinfo.c b/source/common/dmtbinfo.c
>> index 692763f..f9c48e4 100644
>> --- a/source/common/dmtbinfo.c
>> +++ b/source/common/dmtbinfo.c
>> @@ -1838,6 +1838,7 @@ ACPI_DMTABLE_INFO           AcpiDmTableInfoIort4[]=
 =3D
>>       {ACPI_DMT_UINT32,   ACPI_IORT4_OFFSET (Flags),
>> "Flags (decoded below)", 0},
>>       {ACPI_DMT_FLAG0,    ACPI_IORT4_FLAG_OFFSET (Flags, 0),
>> "COHACC Override", 0},
>>       {ACPI_DMT_FLAG1,    ACPI_IORT4_FLAG_OFFSET (Flags, 0),
>> "HTTU Override", 0},
>> +    {ACPI_DMT_FLAG3,    ACPI_IORT4_FLAG_OFFSET (Flags, 0),
>> "Proximity Valid", 0},
>>       {ACPI_DMT_UINT32,   ACPI_IORT4_OFFSET (Reserved),
>> "Reserved", 0},
>>       {ACPI_DMT_UINT64,   ACPI_IORT4_OFFSET (VatosAddress),
>> "VATOS Address", 0},
>>       {ACPI_DMT_UINT32,   ACPI_IORT4_OFFSET (Model),
>> "Model", 0},
>> @@ -1845,6 +1846,7 @@ ACPI_DMTABLE_INFO           AcpiDmTableInfoIort4[]=
 =3D
>>       {ACPI_DMT_UINT32,   ACPI_IORT4_OFFSET (PriGsiv),                "P=
RI
>> GSIV", 0},
>>       {ACPI_DMT_UINT32,   ACPI_IORT4_OFFSET (GerrGsiv),
>> "GERR GSIV", 0},
>>       {ACPI_DMT_UINT32,   ACPI_IORT4_OFFSET (SyncGsiv),
>> "Sync GSIV", 0},
>> +    {ACPI_DMT_UINT8,   ACPI_IORT4_OFFSET (Pxm),
>> "Proximity", 0},
>
>
> It's missing two reserved field definition here:
>
> +    {ACPI_DMT_UINT8,   ACPI_IORT4_OFFSET (Reserved1), "Reserved1", 0},
> +    {ACPI_DMT_UINT16,   ACPI_IORT4_OFFSET (Reserved2), "Reserved2", 0},

thanks i will add to complete the mapping in next version of patch,
however it was not effecting the decoding. i could generate iort.dsl
file with this patched acpica/iasl.
Below is the snippet of iort.dsl

[198h 0408   4]        Flags (decoded below) : 00000009
                             COHACC Override : 1
                               HTTU Override : 0
                             Proximity Valid : 1
[19Ch 0412   4]                     Reserved : 00000000
[1A0h 0416   8]                VATOS Address : 0000000000000000
[1A8h 0424   4]                        Model : 00000002
[1ACh 0428   4]                   Event GSIV : 0000006C
[1B0h 0432   4]                     PRI GSIV : 0000006C
[1B4h 0436   4]                    GERR GSIV : 0000006C
[1B8h 0440   4]                    Sync GSIV : 0000006C
[1BCh 0444   1]                    Proximity : 00
.
.
.
[250h 0592   4]        Flags (decoded below) : 00000009
                             COHACC Override : 1
                               HTTU Override : 0
                             Proximity Valid : 1
[254h 0596   4]                     Reserved : 00000000
[258h 0600   8]                VATOS Address : 0000000000000000
[260h 0608   4]                        Model : 00000002
[264h 0612   4]                   Event GSIV : 0000006A
[268h 0616   4]                     PRI GSIV : 0000006A
[26Ch 0620   4]                    GERR GSIV : 0000006A
[270h 0624   4]                    Sync GSIV : 0000006A
[274h 0628   1]                    Proximity : 01


>
> in order to mirror ....
>
>>       ACPI_DMT_TERMINATOR
>>   };
>>   diff --git a/source/include/actbl2.h b/source/include/actbl2.h
>> index 80495d8..2583863 100644
>> --- a/source/include/actbl2.h
>> +++ b/source/include/actbl2.h
>> @@ -1041,6 +1041,9 @@ typedef struct acpi_iort_smmu_v3
>>       UINT32                  PriGsiv;
>>       UINT32                  GerrGsiv;
>>       UINT32                  SyncGsiv;
>> +    UINT8                   Pxm;
>> +    UINT8                   Reserved1;
>> +    UINT16                  Reserved2;
>
>
> ... here.
>
> Or the compiler will not work.
>
> Thanks
> Hanjun

thanks
Ganapat

--===============0087279607423002062==--

