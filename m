Content-Type: multipart/mixed; boundary="===============3912065557521451496=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: Re: [Devel] [PATCH v3 2/3] hmat: add heterogeneous memory sysfs
 support
Date: Fri, 15 Dec 2017 01:52:03 +0100
Message-ID: <CAJZ5v0h8=mh9BKa2eZzqbc12T6saB+q19yqSfRLYKOiUjS2Cjg@mail.gmail.com>
In-Reply-To: 20171214021019.13579-3-ross.zwisler@linux.intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============3912065557521451496==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 14, 2017 at 3:10 AM, Ross Zwisler
<ross.zwisler(a)linux.intel.com> wrote:
> Add a new sysfs subsystem, /sys/devices/system/hmat, which surfaces
> information about memory initiators and memory targets to the user.  These
> initiators and targets are described by the ACPI SRAT and HMAT tables.
>
> A "memory initiator" in this case is a NUMA node containing one or more
> devices such as CPU or separate memory I/O devices that can initiate
> memory requests.  A "memory target" is NUMA node containing at least one
> CPU-accessible physical address range.
>
> The key piece of information surfaced by this patch is the mapping between
> the ACPI table "proximity domain" numbers, held in the "firmware_id"
> attribute, and Linux NUMA node numbers.  Every ACPI proximity domain will
> end up being a unique NUMA node in Linux, but the numbers may get reorder=
ed
> and Linux can create extra NUMA nodes that don't map back to ACPI proximi=
ty
> domains.  The firmware_id value is needed if anyone ever wants to look at
> the ACPI HMAT and SRAT tables directly and make sense of how they map to
> NUMA nodes in Linux.
>
> Initiators are found at /sys/devices/system/hmat/mem_initX, and the
> attributes for a given initiator look like this:
>
>   # tree mem_init0
>   mem_init0
>   =E2=94=9C=E2=94=80=E2=94=80 firmware_id
>   =E2=94=9C=E2=94=80=E2=94=80 node0 -> ../../node/node0
>   =E2=94=9C=E2=94=80=E2=94=80 power
>   =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 async
>   =E2=94=82   ...
>   =E2=94=9C=E2=94=80=E2=94=80 subsystem -> ../../../../bus/hmat
>   =E2=94=94=E2=94=80=E2=94=80 uevent
>
> Where "mem_init0" on my system represents the CPU acting as a memory
> initiator at NUMA node 0.  Users can discover which CPUs are part of this
> memory initiator by following the node0 symlink and looking at cpumap,
> cpulist and the cpu* symlinks.
>
> Targets are found at /sys/devices/system/hmat/mem_tgtX, and the attributes
> for a given target look like this:
>
>   # tree mem_tgt2
>   mem_tgt2
>   =E2=94=9C=E2=94=80=E2=94=80 firmware_id
>   =E2=94=9C=E2=94=80=E2=94=80 is_cached
>   =E2=94=9C=E2=94=80=E2=94=80 node2 -> ../../node/node2
>   =E2=94=9C=E2=94=80=E2=94=80 power
>   =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 async
>   =E2=94=82   ...
>   =E2=94=9C=E2=94=80=E2=94=80 subsystem -> ../../../../bus/hmat
>   =E2=94=94=E2=94=80=E2=94=80 uevent
>
> Users can discover information about the memory owned by this memory targ=
et
> by following the node2 symlink and looking at meminfo, vmstat and at the
> memory* memory section symlinks.
>
> Signed-off-by: Ross Zwisler <ross.zwisler(a)linux.intel.com>
> ---
>  MAINTAINERS                   |   6 +
>  drivers/acpi/Kconfig          |   1 +
>  drivers/acpi/Makefile         |   1 +
>  drivers/acpi/hmat/Kconfig     |   7 +
>  drivers/acpi/hmat/Makefile    |   2 +
>  drivers/acpi/hmat/core.c      | 536 ++++++++++++++++++++++++++++++++++++=
++++++
>  drivers/acpi/hmat/hmat.h      |  47 ++++
>  drivers/acpi/hmat/initiator.c |  43 ++++
>  drivers/acpi/hmat/target.c    |  55 +++++
>  9 files changed, 698 insertions(+)
>  create mode 100644 drivers/acpi/hmat/Kconfig
>  create mode 100644 drivers/acpi/hmat/Makefile
>  create mode 100644 drivers/acpi/hmat/core.c
>  create mode 100644 drivers/acpi/hmat/hmat.h
>  create mode 100644 drivers/acpi/hmat/initiator.c
>  create mode 100644 drivers/acpi/hmat/target.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 82ad0eabce4f..64ebec0708de 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6366,6 +6366,12 @@ S:       Supported
>  F:     drivers/scsi/hisi_sas/
>  F:     Documentation/devicetree/bindings/scsi/hisilicon-sas.txt
>
> +HMAT - ACPI Heterogeneous Memory Attribute Table Support
> +M:     Ross Zwisler <ross.zwisler(a)linux.intel.com>
> +L:     linux-mm(a)kvack.org
> +S:     Supported
> +F:     drivers/acpi/hmat/
> +
>  HMM - Heterogeneous Memory Management
>  M:     J=C3=A9r=C3=B4me Glisse <jglisse(a)redhat.com>
>  L:     linux-mm(a)kvack.org
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index 46505396869e..21cdd1288430 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -466,6 +466,7 @@ config ACPI_REDUCED_HARDWARE_ONLY
>           If you are unsure what to do, do not enable this option.
>
>  source "drivers/acpi/nfit/Kconfig"
> +source "drivers/acpi/hmat/Kconfig"
>
>  source "drivers/acpi/apei/Kconfig"
>  source "drivers/acpi/dptf/Kconfig"
> diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
> index 41954a601989..ed5eab6b0412 100644
> --- a/drivers/acpi/Makefile
> +++ b/drivers/acpi/Makefile
> @@ -75,6 +75,7 @@ obj-$(CONFIG_ACPI_PROCESSOR)  +=3D processor.o
>  obj-$(CONFIG_ACPI)             +=3D container.o
>  obj-$(CONFIG_ACPI_THERMAL)     +=3D thermal.o
>  obj-$(CONFIG_ACPI_NFIT)                +=3D nfit/
> +obj-$(CONFIG_ACPI_HMAT)                +=3D hmat/
>  obj-$(CONFIG_ACPI)             +=3D acpi_memhotplug.o
>  obj-$(CONFIG_ACPI_HOTPLUG_IOAPIC) +=3D ioapic.o
>  obj-$(CONFIG_ACPI_BATTERY)     +=3D battery.o
> diff --git a/drivers/acpi/hmat/Kconfig b/drivers/acpi/hmat/Kconfig
> new file mode 100644
> index 000000000000..954ad4701005
> --- /dev/null
> +++ b/drivers/acpi/hmat/Kconfig
> @@ -0,0 +1,7 @@
> +config ACPI_HMAT
> +       bool "ACPI Heterogeneous Memory Attribute Table Support"
> +       depends on ACPI_NUMA
> +       depends on SYSFS
> +       help
> +         Exports a sysfs representation of the ACPI Heterogeneous Memory
> +         Attributes Table (HMAT).
> diff --git a/drivers/acpi/hmat/Makefile b/drivers/acpi/hmat/Makefile
> new file mode 100644
> index 000000000000..edf4bcb1c97d
> --- /dev/null
> +++ b/drivers/acpi/hmat/Makefile
> @@ -0,0 +1,2 @@
> +obj-$(CONFIG_ACPI_HMAT) :=3D hmat.o
> +hmat-y :=3D core.o initiator.o target.o
> diff --git a/drivers/acpi/hmat/core.c b/drivers/acpi/hmat/core.c
> new file mode 100644
> index 000000000000..61b90dadf84b
> --- /dev/null
> +++ b/drivers/acpi/hmat/core.c
> @@ -0,0 +1,536 @@
> +/*
> + * Heterogeneous Memory Attributes Table (HMAT) representation in sysfs
> + *
> + * Copyright (c) 2017, Intel Corporation.
> + *
> + * This program is free software; you can redistribute it and/or modify =
it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License=
 for
> + * more details.
> + */

Minor nit for starters: you should use SPDX license indentifiers in
new files and if you do so, the license boilerplace is not necessary
any more.

Thanks,
Rafael

--===============3912065557521451496==--

