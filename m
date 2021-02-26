Content-Type: multipart/mixed; boundary="===============9217525479759875143=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: [Devel] Re: [PATCH] [ACPICA] IORT: Fix HTTU Override mask for the
 SMMUv3 subtable
Date: Fri, 26 Feb 2021 15:12:57 +0000
Message-ID: <BYAPR11MB32566AB506BAD2C77356FE07879D9@BYAPR11MB3256.namprd11.prod.outlook.com>
In-Reply-To: 3b009c89-c3cc-8fd2-4ef6-5b8d27a88119@huawei.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============9217525479759875143==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Yes, you are correct. ACPI_DMT_FLAGS1 Will pick up two bits at bit [2:1]
Sorry for the noise,
Bob


-----Original Message-----
From: Zenghui Yu <yuzenghui(a)huawei.com> =

Sent: Thursday, February 25, 2021 5:59 PM
To: Moore, Robert <robert.moore(a)intel.com>; devel(a)acpica.org; linux-acp=
i(a)vger.kernel.org
Cc: Kaneda, Erik <erik.kaneda(a)intel.com>; robin.murphy(a)arm.com; Wysocki=
, Rafael J <rafael.j.wysocki(a)intel.com>; guohanjun(a)huawei.com; wanghaib=
in.wang(a)huawei.com; Kunkun Jiang <jiangkunkun(a)huawei.com>
Subject: Re: [PATCH] [ACPICA] IORT: Fix HTTU Override mask for the SMMUv3 s=
ubtable

On 2021/2/26 4:45, Moore, Robert wrote:
> If the field is two bits, I think the ACPI_DMT_* symbol should be ACPI_DM=
T_FLAGS2, not ACPI_DMT_FLAGS1

The SMMUv3 flags is decoded as:

- bit[0]	"COHACC Override"
- bit[2:1]	"HTTU Override"
- bit[3]	"Proximity Domain Valid"
- bit[31:4]	"Reserved"

whilst ACPI_DMT_FLAGS2 will extract bit[3:2] for us, right?

> -----Original Message-----
> From: Zenghui Yu <yuzenghui(a)huawei.com>
> Sent: Thursday, February 25, 2021 3:26 AM
> To: devel(a)acpica.org; linux-acpi(a)vger.kernel.org
> Cc: Moore, Robert <robert.moore(a)intel.com>; Kaneda, Erik <erik.kaneda(a=
)intel.com>; robin.murphy(a)arm.com; Wysocki, Rafael J <rafael.j.wysocki(a)=
intel.com>; guohanjun(a)huawei.com; wanghaibin.wang(a)huawei.com; Zenghui Y=
u <yuzenghui(a)huawei.com>; Kunkun Jiang <jiangkunkun(a)huawei.com>
> Subject: [PATCH] [ACPICA] IORT: Fix HTTU Override mask for the SMMUv3 sub=
table
> =

> As per the IORT spec, this field overrides the value in SMMU_IRD0.HTTU wh=
ich should always have been 2 bits.
> =

> Fixes: 9f7c3e148f44 ("IORT: Add in support for the SMMUv3 subtable")
> Reported-by: Kunkun Jiang <jiangkunkun(a)huawei.com>
> Signed-off-by: Zenghui Yu <yuzenghui(a)huawei.com>
> ---
>   source/common/dmtbinfo2.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> =

> diff --git a/source/common/dmtbinfo2.c b/source/common/dmtbinfo2.c index =
17a80ba21..321f106fa 100644
> --- a/source/common/dmtbinfo2.c
> +++ b/source/common/dmtbinfo2.c
> @@ -343,7 +343,7 @@ ACPI_DMTABLE_INFO           AcpiDmTableInfoIort4[] =
=3D
>       {ACPI_DMT_UINT64,   ACPI_IORT4_OFFSET (BaseAddress),            "Ba=
se Address", 0},
>       {ACPI_DMT_UINT32,   ACPI_IORT4_OFFSET (Flags),                  "Fl=
ags (decoded below)", 0},
>       {ACPI_DMT_FLAG0,    ACPI_IORT4_FLAG_OFFSET (Flags, 0),          "CO=
HACC Override", 0},
> -    {ACPI_DMT_FLAG1,    ACPI_IORT4_FLAG_OFFSET (Flags, 0),          "HTT=
U Override", 0},
> +    {ACPI_DMT_FLAGS1,   ACPI_IORT4_FLAG_OFFSET (Flags, 0),          "HTT=
U Override", 0},
>       {ACPI_DMT_FLAG3,    ACPI_IORT4_FLAG_OFFSET (Flags, 0),          "Pr=
oximity Domain Valid", 0},
>       {ACPI_DMT_UINT32,   ACPI_IORT4_OFFSET (Reserved),               "Re=
served", 0},
>       {ACPI_DMT_UINT64,   ACPI_IORT4_OFFSET (VatosAddress),           "VA=
TOS Address", 0},
> --
> 2.19.1
> =

> .
>=20

--===============9217525479759875143==--

