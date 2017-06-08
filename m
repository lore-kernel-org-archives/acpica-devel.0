Content-Type: multipart/mixed; boundary="===============1533896309156319981=="
MIME-Version: 1.0
From: Lorenzo Pieralisi <lorenzo.pieralisi at arm.com>
Subject: Re: [Devel] [PATCH v7 1/3] ACPI/IORT: Fixup SMMUv3 resource size for
 Cavium ThunderX2 SMMUv3 model
Date: Thu, 08 Jun 2017 09:58:58 +0100
Message-ID: <20170608085857.GB8607@red-moon>
In-Reply-To: 1496145821-3411-2-git-send-email-gakula@caviumnetworks.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============1533896309156319981==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, May 30, 2017 at 05:33:39PM +0530, Geetha sowjanya wrote:
> From: Linu Cherian <linu.cherian(a)cavium.com>
> =

> Cavium ThunderX2 implementation doesn't support second page in SMMU
> register space. Hence, resource size is set as 64k for this model.
> =

> Signed-off-by: Linu Cherian <linu.cherian(a)cavium.com>
> Signed-off-by: Geetha Sowjanya <geethasowjanya.akula(a)cavium.com>
> ---
>  drivers/acpi/arm64/iort.c |   10 +++++++++-
>  1 files changed, 9 insertions(+), 1 deletions(-)
> =

> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> index c5fecf9..bba2b59 100644
> --- a/drivers/acpi/arm64/iort.c
> +++ b/drivers/acpi/arm64/iort.c
> @@ -833,12 +833,20 @@ static void __init arm_smmu_v3_init_resources(struc=
t resource *res,
>  {
>  	struct acpi_iort_smmu_v3 *smmu;
>  	int num_res =3D 0;
> +	unsigned long size =3D SZ_128K;
>  =

>  	/* Retrieve SMMUv3 specific data */
>  	smmu =3D (struct acpi_iort_smmu_v3 *)node->node_data;
>  =

> +	/*
> +	 * Override the size, for Cavium ThunderX2 implementation
> +	 * which doesn't support the page 1 SMMU register space.
> +	 */
> +	if (smmu->model =3D=3D ACPI_IORT_SMMU_CAVIUM_CN99XX)
> +		size =3D SZ_64K;

Nit: add a function, say arm_smmu_v3_resource_size() with the logic
above that by default returns SZ_128K, I do not like this switch
in the middle of this function.

Lorenzo

> +
>  	res[num_res].start =3D smmu->base_address;
> -	res[num_res].end =3D smmu->base_address + SZ_128K - 1;
> +	res[num_res].end =3D smmu->base_address + size - 1;
>  	res[num_res].flags =3D IORESOURCE_MEM;
>  =

>  	num_res++;
> -- =

> 1.7.1
>=20

--===============1533896309156319981==--

