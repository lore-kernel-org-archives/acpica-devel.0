Content-Type: multipart/mixed; boundary="===============8813502190531873463=="
MIME-Version: 1.0
From: Schmauss, Erik <erik.schmauss at intel.com>
Subject: Re: [Devel] [RFC 1/3] ACPICA: ACPI 6.3: Add MADT/GICC/SPE extension.
Date: Mon, 11 Feb 2019 18:27:02 +0000
Message-ID: <CF6A88132359CE47947DB4C6E1709ED53C57BD14@ORSMSX122.amr.corp.intel.com>
In-Reply-To: 20190209004718.3292087-2-jeremy.linton@arm.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============8813502190531873463==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



> -----Original Message-----
> From: Jeremy Linton [mailto:jeremy.linton(a)arm.com]
> Sent: Friday, February 8, 2019 4:47 PM
> To: linux-arm-kernel(a)lists.infradead.org
> Cc: linux-kernel(a)vger.kernel.org; linux-acpi(a)vger.kernel.org;
> devel(a)acpica.org; catalin.marinas(a)arm.com; will.deacon(a)arm.com;
> mark.rutland(a)arm.com; Moore, Robert <robert.moore(a)intel.com>;
> Schmauss, Erik <erik.schmauss(a)intel.com>; Wysocki, Rafael J
> <rafael.j.wysocki(a)intel.com>; lenb(a)kernel.org; Jeremy Linton
> <jeremy.linton(a)arm.com>
> Subject: [RFC 1/3] ACPICA: ACPI 6.3: Add MADT/GICC/SPE extension.
> =

Hi Jeremy,

> [Placeholder patch for upstream ACPICA commit]

FYI: we are planning on releasing ACPICA patches by the end of this week at=
 the latest.

Erik
> =

> Add just ACPI 6.3 changes associated with the arm64 SPE.
> =

> Signed-off-by: Jeremy Linton <jeremy.linton(a)arm.com>
> ---
>  include/acpi/actbl2.h | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> =

> diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h index
> c50ef7e6b942..4b58eb6cf64e 100644
> --- a/include/acpi/actbl2.h
> +++ b/include/acpi/actbl2.h
> @@ -623,7 +623,7 @@ struct acpi_madt_local_x2apic_nmi {
>  	u8 reserved[3];		/* reserved - must be zero */
>  };
> =

> -/* 11: Generic Interrupt (ACPI 5.0 + ACPI 6.0 changes) */
> +/* 11: Generic Interrupt (ACPI 5.0 + 6.0 + 6.3 changes) */
> =

>  struct acpi_madt_generic_interrupt {
>  	struct acpi_subtable_header header;
> @@ -641,7 +641,8 @@ struct acpi_madt_generic_interrupt {
>  	u64 gicr_base_address;
>  	u64 arm_mpidr;
>  	u8 efficiency_class;
> -	u8 reserved2[3];
> +	u8 reserved2;
> +	u16 spe_overflow_interrupt;
>  };
> =

>  /* Masks for Flags field above */
> --
> 2.17.2


--===============8813502190531873463==--

