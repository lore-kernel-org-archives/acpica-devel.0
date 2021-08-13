Content-Type: multipart/mixed; boundary="===============8954338951906741344=="
MIME-Version: 1.0
From: Hanjun Guo <guohanjun at huawei.com>
Subject: [Devel] Re: [PATCH] x86/acpi: Don't add CPUs that are not online
 capable
Date: Fri, 13 Aug 2021 06:27:06 +0000
Message-ID: <a671969e-526f-cdc0-6c77-0eb2d940ec5c@huawei.com>
In-Reply-To: 20210812051657.28605-1-mario.limonciello@amd.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============8954338951906741344==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 2021/8/12 13:16, Mario Limonciello wrote:
> A number of systems are showing "hotplug capable" CPUs when they
> are not really hotpluggable.  This is because the MADT has extra
> CPU entries to support different CPUs that may be inserted into
> the socket with different numbers of cores.
> =

> The ACPI spec is clear that the Online Capable bit in the
> MADT should be used to determine whether or not a CPU is hotplug
> capable when the enabled bit is not set.

This was introduced in ACPI 6.3 spec, which means ACPI 6.2 and
earlier versions don't include the "Online Capable bit".

> =

> Link: https://uefi.org/htmlspecs/ACPI_Spec_6_4_html/05_ACPI_Software_Prog=
ramming_Model/ACPI_Software_Programming_Model.html?#local-apic-flags
> Reviewed-by: Alex Deucher <alexander.deucher(a)amd.com>
> Reviewed-by: Huang Rui <ray.huang(a)amd.com>
> Signed-off-by: Mario Limonciello <mario.limonciello(a)amd.com>
> ---
>   arch/x86/kernel/acpi/boot.c | 6 ++++++
>   include/acpi/actbl2.h       | 1 +
>   2 files changed, 7 insertions(+)
> =

> diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
> index e55e0c1fad8c..eeb10b27d6de 100644
> --- a/arch/x86/kernel/acpi/boot.c
> +++ b/arch/x86/kernel/acpi/boot.c
> @@ -239,6 +239,12 @@ acpi_parse_lapic(union acpi_subtable_headers * heade=
r, const unsigned long end)
>   	if (processor->id =3D=3D 0xff)
>   		return 0;
>   =

> +	/* don't register processors that can not be onlined */
> +	if (!(processor->lapic_flags & ACPI_MADT_ENABLED)) {
> +		if (!(processor->lapic_flags & ACPI_MADT_ONLINE_CAPABLE))
> +			return 0;
> +	}

For firmware using ACPI 6.2 and early versions, the
ACPI_MADT_ONLINE_CAPABLE bit is reserved as zero, so if
we set CPU as disabled, the code here will always return
0 in those firmwares.

> +
>   	/*
>   	 * We need to register disabled CPU as well to permit
>   	 * counting disabled CPUs. This allows us to size

So we will not register the disabled CPU and will break
CPU hotplug features.

I think we need to consider the compatibility with old versions
of firmware.

Thanks
Hanjun

--===============8954338951906741344==--

