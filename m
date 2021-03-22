Content-Type: multipart/mixed; boundary="===============7368045493684514529=="
MIME-Version: 1.0
From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi at huawei.com>
Subject: [Devel] Re: [RFC PATCH v2 1/8] ACPICA: IORT: Update for revision E
Date: Mon, 22 Mar 2021 10:36:04 +0000
Message-ID: <b7a2424941214b33803e34ba3e532440@huawei.com>
In-Reply-To: 20201119121150.3316-2-shameerali.kolothum.thodi@huawei.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============7368045493684514529==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

[+]

Hi Erik,

As this is now just merged ino acpica-master and based on the discussion we=
 had here,

https://github.com/acpica/acpica/pull/638

I had a discussion with ARM folks(Lorenzo) in the linaro-open-discussions c=
all and
can confirm that the IORT Revision E is not the final specification and has=
 some issues
which is now corrected in the latest E.b revision[1]. Also there are no cur=
rent users
for the Rev E and it may not be a good idea to push this version into the L=
inux kernel
or elsewhere.

So could you please revert the merge and I am planning to work on the E.b s=
oon.
Please let me know if I need to explicitly send a revert pull request or no=
t.

Thanks,
Shameer

1. https://developer.arm.com/documentation/den0049/latest/

> -----Original Message-----
> From: iommu [mailto:iommu-bounces(a)lists.linux-foundation.org] On Behalf=
 Of
> Shameer Kolothum
> Sent: 19 November 2020 12:12
> To: linux-arm-kernel(a)lists.infradead.org; linux-acpi(a)vger.kernel.org;
> iommu(a)lists.linux-foundation.org; devel(a)acpica.org
> Cc: Linuxarm <linuxarm(a)huawei.com>; steven.price(a)arm.com; Guohanjun
> (Hanjun Guo) <guohanjun(a)huawei.com>; Sami.Mujawar(a)arm.com;
> robin.murphy(a)arm.com; wanghuiqiang <wanghuiqiang(a)huawei.com>
> Subject: [RFC PATCH v2 1/8] ACPICA: IORT: Update for revision E
> =

> IORT revision E contains a few additions like,
> =C2=A0 =C2=A0 -Added an identifier field in the node descriptors to aid t=
able
> =C2=A0 =C2=A0 =C2=A0cross-referencing.
> =C2=A0 =C2=A0 -Introduced the Reserved Memory Range(RMR) node. This is us=
ed
>  =C2=A0 =C2=A0 to describe memory ranges that are used by endpoints and r=
equires
>  =C2=A0 =C2=A0 a unity mapping in SMMU.
>     -Introduced a flag in the RC node to express support for PRI.
> =

> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi(a)huawei.com>
> ---
>  include/acpi/actbl2.h | 25 +++++++++++++++++++------
>  1 file changed, 19 insertions(+), 6 deletions(-)
> =

> diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h index
> ec66779cb193..274fce7b5c01 100644
> --- a/include/acpi/actbl2.h
> +++ b/include/acpi/actbl2.h
> @@ -68,7 +68,7 @@
>   * IORT - IO Remapping Table
>   *
>   * Conforms to "IO Remapping Table System Software on ARM Platforms",
> - * Document number: ARM DEN 0049D, March 2018
> + * Document number: ARM DEN 0049E, June 2020
>   *
> =

> ****************************************************************
> **************/
> =

> @@ -86,7 +86,8 @@ struct acpi_iort_node {
>  	u8 type;
>  	u16 length;
>  	u8 revision;
> -	u32 reserved;
> +	u16 reserved;
> +	u16 identifier;
>  	u32 mapping_count;
>  	u32 mapping_offset;
>  	char node_data[1];
> @@ -100,7 +101,8 @@ enum acpi_iort_node_type {
>  	ACPI_IORT_NODE_PCI_ROOT_COMPLEX =3D 0x02,
>  	ACPI_IORT_NODE_SMMU =3D 0x03,
>  	ACPI_IORT_NODE_SMMU_V3 =3D 0x04,
> -	ACPI_IORT_NODE_PMCG =3D 0x05
> +	ACPI_IORT_NODE_PMCG =3D 0x05,
> +	ACPI_IORT_NODE_RMR =3D 0x06,
>  };
> =

>  struct acpi_iort_id_mapping {
> @@ -167,10 +169,10 @@ struct acpi_iort_root_complex {
>  	u8 reserved[3];		/* Reserved, must be zero */
>  };
> =

> -/* Values for ats_attribute field above */
> +/* Masks for ats_attribute field above */
> =

> -#define ACPI_IORT_ATS_SUPPORTED         0x00000001	/* The root
> complex supports ATS */
> -#define ACPI_IORT_ATS_UNSUPPORTED       0x00000000	/* The root
> complex doesn't support ATS */
> +#define ACPI_IORT_ATS_SUPPORTED         (1)	/* The root complex
> supports ATS */
> +#define ACPI_IORT_PRI_SUPPORTED         (1<<1)	/* The root complex
> supports PRI */
> =

>  struct acpi_iort_smmu {
>  	u64 base_address;	/* SMMU base address */
> @@ -241,6 +243,17 @@ struct acpi_iort_pmcg {
>  	u64 page1_base_address;
>  };
> =

> +struct acpi_iort_rmr {
> +	u32 rmr_count;
> +	u32 rmr_offset;
> +};
> +
> +struct acpi_iort_rmr_desc {
> +	u64 base_address;
> +	u64 length;
> +	u32 reserved;
> +};
> +
> =

> /***************************************************************
> ****************
>   *
>   * IVRS - I/O Virtualization Reporting Structure
> --
> 2.17.1
> =

> _______________________________________________
> iommu mailing list
> iommu(a)lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu

--===============7368045493684514529==--

