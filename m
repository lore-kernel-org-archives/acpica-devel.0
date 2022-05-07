Content-Type: multipart/mixed; boundary="===============2708468625820585121=="
MIME-Version: 1.0
From: Hanjun Guo <guohanjun at huawei.com>
Subject: [Devel] Re: [PATCH 2/2] ACPI: ARM Performance Monitoring Unit Table
 (APMT) initial support
Date: Sat, 07 May 2022 23:03:38 +0800
Message-ID: <bf994eb0-0e6d-fd0b-3499-8c28d2c13cc9@huawei.com>
In-Reply-To: 20220419205432.46021-3-bwicaksono@nvidia.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============2708468625820585121==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 2022/4/20 4:54, Besar Wicaksono wrote:
> ARM Performance Monitoring Unit Table describes the properties of PMU
> support in ARM-based system. The APMT table contains a list of nodes,
> each represents a PMU in the system that conforms to ARM CoreSight PMU
> architecture. The properties of each node include information required
> to access the PMU (e.g. MMIO base address, interrupt number) and also
> identification. For more detailed information, please refer to the
> specification below:
>   * APMT: https://developer.arm.com/documentation/den0117/latest
>   * ARM Coresight PMU:
>          https://developer.arm.com/documentation/ihi0091/latest
> =

> The initial support adds the detection of APMT table and generic
> infrastructure to create platform devices for ARM CoreSight PMUs.
> Similar to IORT the root pointer of APMT is preserved during runtime
> and each PMU platform device is given a pointer to the corresponding
> APMT node.
> =

> Signed-off-by: Besar Wicaksono <bwicaksono(a)nvidia.com>
> ---
>   arch/arm64/Kconfig          |   1 +
>   drivers/acpi/arm64/Kconfig  |   3 +
>   drivers/acpi/arm64/Makefile |   1 +
>   drivers/acpi/arm64/apmt.c   | 176 ++++++++++++++++++++++++++++++++++++
>   drivers/acpi/bus.c          |   2 +
>   include/linux/acpi_apmt.h   |  19 ++++
>   6 files changed, 202 insertions(+)
>   create mode 100644 drivers/acpi/arm64/apmt.c
>   create mode 100644 include/linux/acpi_apmt.h
> =

> +++ b/drivers/acpi/arm64/apmt.c
> @@ -0,0 +1,176 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * ARM APMT table support.
> + * Design document number: ARM DEN0117.
> + *
> + * Copyright (c) 2022, NVIDIA CORPORATION & AFFILIATES.
> + *
> + */
> +
> +#define pr_fmt(fmt)	"ACPI: APMT: " fmt
> +
> +#include <linux/acpi.h>
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/platform_device.h>

Please include <linux/acpi_apmt.h>, here is the similar patch:

https://lore.kernel.org/lkml/CAJZ5v0gqr97AFuk855UZkcVpDnmj1Q6B2PE32zWmx4eKx=
bNvCw(a)mail.gmail.com/T/

Thanks
Hanjun
--===============2708468625820585121==--

