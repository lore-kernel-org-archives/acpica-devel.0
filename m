Content-Type: multipart/mixed; boundary="===============7495294873037921316=="
MIME-Version: 1.0
From: Hanjun Guo <hanjun.guo at linaro.org>
Subject: Re: [Devel] [PATCH] ACPICA: Add MADT generic distributor version
 values for ACPI 6.0
Date: Mon, 25 May 2015 17:26:28 +0800
Message-ID: <5562EAC4.7030905@linaro.org>
In-Reply-To: 1432545858-3793-1-git-send-email-hanjun.guo@linaro.org
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============7495294873037921316==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 2015=E5=B9=B405=E6=9C=8825=E6=97=A5 17:24, Hanjun Guo wrote:
> ACPI 6.0 specified MADT generic distributor version values, but
> the detail definition is missing, add its support in this patch.
>
> Signed-off-by: Hanjun Guo <hanjun.guo(a)linaro.org>
> ---
> Hi Bob, Lv,
>
> As discussed with Lv on linux-acpi maillist, I prepared this
> patch for review.
>
> Please treat this patch as a fix for next ACPICA version and
> linux kernel 4.2 material, because we still can not
> use the newest ACPICA for linux when this enum is missing,

s/for linux/ for ARM ACPI linux, sorry.

Hanjun

> any comments are welcomed.
>
> Thanks
> Hanjun
>
>   source/include/actbl1.h | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
>
> diff --git a/source/include/actbl1.h b/source/include/actbl1.h
> index 1c508a0..0235543 100644
> --- a/source/include/actbl1.h
> +++ b/source/include/actbl1.h
> @@ -1050,6 +1050,18 @@ typedef struct acpi_madt_generic_distributor
>
>   } ACPI_MADT_GENERIC_DISTRIBUTOR;
>
> +/* Values for Version in Generic Distributor  (ACPI 6.0) */
> +
> +enum AcpiMadtGicVersionType
> +{
> +    ACPI_MADT_GIC_VER_UNKNOWN    =3D 0,
> +    ACPI_MADT_GIC_VER_V1         =3D 1,
> +    ACPI_MADT_GIC_VER_V2         =3D 2,
> +    ACPI_MADT_GIC_VER_V3         =3D 3,
> +    ACPI_MADT_GIC_VER_V4         =3D 4,
> +    ACPI_MADT_GIC_VER_RESERVED   =3D 5    /* 5 and greater are reserved =
*/
> +};
> +
>
>   /* 13: Generic MSI Frame (ACPI 5.1) */
>
>

--===============7495294873037921316==--

