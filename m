Content-Type: multipart/mixed; boundary="===============5339941153186749104=="
MIME-Version: 1.0
From: Hanjun Guo <hanjun.guo at linaro.org>
Subject: Re: [Devel] [PATCH] iasl: Update to IORT SMMUv3 disassembling
Date: Fri, 16 Jun 2017 08:58:22 +0800
Message-ID: <a01f1bae-5dc1-703d-2720-44771fd2ef53@linaro.org>
In-Reply-To: 1496723245-17465-1-git-send-email-ganapatrao.kulkarni@cavium.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============5339941153186749104==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Ganapat,

On 2017/6/6 12:27, Ganapatrao Kulkarni wrote:
> ARM IORT specification has provision to define Proximity domain
> in SMMUv3 IORT table. Adding required changes to decode
> Proximity domain of SMMUv3 IORT table.
> =

> Signed-off-by: Ganapatrao Kulkarni <ganapatrao.kulkarni(a)cavium.com>
> ---
>   source/common/dmtbinfo.c | 2 ++
>   source/include/actbl2.h  | 4 ++++
>   2 files changed, 6 insertions(+)
> =

> diff --git a/source/common/dmtbinfo.c b/source/common/dmtbinfo.c
> index 692763f..f9c48e4 100644
> --- a/source/common/dmtbinfo.c
> +++ b/source/common/dmtbinfo.c
> @@ -1838,6 +1838,7 @@ ACPI_DMTABLE_INFO           AcpiDmTableInfoIort4[] =
=3D
>       {ACPI_DMT_UINT32,   ACPI_IORT4_OFFSET (Flags),                  "Fl=
ags (decoded below)", 0},
>       {ACPI_DMT_FLAG0,    ACPI_IORT4_FLAG_OFFSET (Flags, 0),          "CO=
HACC Override", 0},
>       {ACPI_DMT_FLAG1,    ACPI_IORT4_FLAG_OFFSET (Flags, 0),          "HT=
TU Override", 0},
> +    {ACPI_DMT_FLAG3,    ACPI_IORT4_FLAG_OFFSET (Flags, 0),          "Pro=
ximity Valid", 0},
>       {ACPI_DMT_UINT32,   ACPI_IORT4_OFFSET (Reserved),               "Re=
served", 0},
>       {ACPI_DMT_UINT64,   ACPI_IORT4_OFFSET (VatosAddress),           "VA=
TOS Address", 0},
>       {ACPI_DMT_UINT32,   ACPI_IORT4_OFFSET (Model),                  "Mo=
del", 0},
> @@ -1845,6 +1846,7 @@ ACPI_DMTABLE_INFO           AcpiDmTableInfoIort4[] =
=3D
>       {ACPI_DMT_UINT32,   ACPI_IORT4_OFFSET (PriGsiv),                "PR=
I GSIV", 0},
>       {ACPI_DMT_UINT32,   ACPI_IORT4_OFFSET (GerrGsiv),               "GE=
RR GSIV", 0},
>       {ACPI_DMT_UINT32,   ACPI_IORT4_OFFSET (SyncGsiv),               "Sy=
nc GSIV", 0},
> +    {ACPI_DMT_UINT8,   ACPI_IORT4_OFFSET (Pxm),                     "Pro=
ximity", 0},

It's missing two reserved field definition here:

+    {ACPI_DMT_UINT8,   ACPI_IORT4_OFFSET (Reserved1), "Reserved1", 0},
+    {ACPI_DMT_UINT16,   ACPI_IORT4_OFFSET (Reserved2), "Reserved2", 0},

in order to mirror ....

>       ACPI_DMT_TERMINATOR
>   };
>   =

> diff --git a/source/include/actbl2.h b/source/include/actbl2.h
> index 80495d8..2583863 100644
> --- a/source/include/actbl2.h
> +++ b/source/include/actbl2.h
> @@ -1041,6 +1041,9 @@ typedef struct acpi_iort_smmu_v3
>       UINT32                  PriGsiv;
>       UINT32                  GerrGsiv;
>       UINT32                  SyncGsiv;
> +    UINT8                   Pxm;
> +    UINT8                   Reserved1;
> +    UINT16                  Reserved2;

... here.

Or the compiler will not work.

Thanks
Hanjun

--===============5339941153186749104==--

