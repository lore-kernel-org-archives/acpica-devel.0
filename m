Content-Type: multipart/mixed; boundary="===============3732375484579837956=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: Re: [Devel] [PATCH v4 1/9] ACPICA: Add additional PPTT flags for
 cache properties
Date: Fri, 10 Nov 2017 17:13:19 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37E618DB4@ORSMSX110.amr.corp.intel.com>
In-Reply-To: 20171109210311.25655-2-jeremy.linton@arm.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============3732375484579837956==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Included in ACPICA version 20171110


> -----Original Message-----
> From: Jeremy Linton [mailto:jeremy.linton(a)arm.com]
> Sent: Thursday, November 9, 2017 1:03 PM
> To: linux-acpi(a)vger.kernel.org
> Cc: linux-arm-kernel(a)lists.infradead.org; sudeep.holla(a)arm.com;
> hanjun.guo(a)linaro.org; lorenzo.pieralisi(a)arm.com; rjw(a)rjwysocki.net;
> will.deacon(a)arm.com; catalin.marinas(a)arm.com;
> gregkh(a)linuxfoundation.org; viresh.kumar(a)linaro.org;
> mark.rutland(a)arm.com; linux-kernel(a)vger.kernel.org; linux-
> pm(a)vger.kernel.org; jhugo(a)codeaurora.org; wangxiongfeng2(a)huawei.com;
> Jonathan.Zhang(a)cavium.com; ahs3(a)redhat.com;
> Jayachandran.Nair(a)cavium.com; austinwc(a)codeaurora.org; lenb(a)kernel.=
org;
> Moore, Robert <robert.moore(a)intel.com>; Zheng, Lv <lv.zheng(a)intel.com=
>;
> devel(a)acpica.org; Jeremy Linton <jeremy.linton(a)arm.com>
> Subject: [PATCH v4 1/9] ACPICA: Add additional PPTT flags for cache
> properties
> =

> The PPTT table has a number of flags that can be set to describe whether
> the cache is I/D/U and the allocation and write policies. Add these
> flags.
> =

> Signed-off-by: Jeremy Linton <jeremy.linton(a)arm.com>
> ---
>  include/acpi/actbl1.h | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> =

> diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h index
> 6b8714a428b6..71f874e2790d 100644
> --- a/include/acpi/actbl1.h
> +++ b/include/acpi/actbl1.h
> @@ -1346,6 +1346,20 @@ struct acpi_pptt_cache {
>  #define ACPI_PPTT_MASK_CACHE_TYPE           (0x0C)	/* Cache type */
>  #define ACPI_PPTT_MASK_WRITE_POLICY         (0x10)	/* Write policy */
> =

> +/* Attributes describing cache */
> +#define ACPI_PPTT_CACHE_READ_ALLOCATE	    (0x0)   /* Cache line is
> allocated on read */
> +#define ACPI_PPTT_CACHE_WRITE_ALLOCATE	    (0x01)  /* Cache line is
> allocated on write */
> +#define ACPI_PPTT_CACHE_RW_ALLOCATE	    (0x02)  /* Cache line is
> allocated on read and write */
> +#define ACPI_PPTT_CACHE_RW_ALLOCATE_ALT	    (0x03)  /* Alternate
> representation of above */
> +
> +#define ACPI_PPTT_CACHE_TYPE_DATA	    (0x0)   /* Data cache */
> +#define ACPI_PPTT_CACHE_TYPE_INSTR	    (1<<2)  /* Instruction cache */
> +#define ACPI_PPTT_CACHE_TYPE_UNIFIED	    (2<<2)  /* Unified I & D cache
> */
> +#define ACPI_PPTT_CACHE_TYPE_UNIFIED_ALT    (3<<2)  /* Alternate
> representation of above */
> +
> +#define ACPI_PPTT_CACHE_POLICY_WB	    (0x0)   /* Cache is write back
> */
> +#define ACPI_PPTT_CACHE_POLICY_WT	    (1<<4)  /* Cache is write
> through */
> +
>  /* 2: ID Structure */
> =

>  struct acpi_pptt_id {
> --
> 2.13.5


--===============3732375484579837956==--

