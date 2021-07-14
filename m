Content-Type: multipart/mixed; boundary="===============8608221006824486310=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: [Devel] Re: [PATCH 1/3] ACPI: Add LoongArch support for
 ACPI_PROCESSOR/ACPI_NUMA
Date: Wed, 14 Jul 2021 14:30:33 +0200
Message-ID: <CAJZ5v0gyun_85uXrH6jt-d3XjaOFZmHEYGnKKGL-XUb=4ZcrMQ@mail.gmail.com>
In-Reply-To: 20210705124206.1228958-2-chenhuacai@loongson.cn
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============8608221006824486310==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 5, 2021 at 2:41 PM Huacai Chen <chenhuacai(a)loongson.cn> wrote:
>
> We are preparing to add new Loongson (based on LoongArch, not MIPS)
> support. LoongArch use ACPI other than DT as its boot protocol, so
> add its support for ACPI_PROCESSOR/ACPI_NUMA.
>
> Signed-off-by: Huacai Chen <chenhuacai(a)loongson.cn>
> ---
>  drivers/acpi/Kconfig      | 4 ++--
>  drivers/acpi/numa/Kconfig | 2 +-
>  drivers/acpi/numa/srat.c  | 2 +-
>  include/linux/acpi.h      | 2 +-
>  4 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index fe0bb6277e4d..90afa44efcba 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -280,9 +280,9 @@ config ACPI_CPPC_LIB
>
>  config ACPI_PROCESSOR
>         tristate "Processor"
> -       depends on X86 || IA64 || ARM64
> +       depends on X86 || IA64 || ARM64 || LOONGARCH
>         select ACPI_PROCESSOR_IDLE
> -       select ACPI_CPU_FREQ_PSS if X86 || IA64
> +       select ACPI_CPU_FREQ_PSS if X86 || IA64 || LOONGARCH
>         default y
>         help
>           This driver adds support for the ACPI Processor package. It is =
required
> diff --git a/drivers/acpi/numa/Kconfig b/drivers/acpi/numa/Kconfig
> index fcf2e556d69d..39b1f34c21df 100644
> --- a/drivers/acpi/numa/Kconfig
> +++ b/drivers/acpi/numa/Kconfig
> @@ -2,7 +2,7 @@
>  config ACPI_NUMA
>         bool "NUMA support"
>         depends on NUMA
> -       depends on (X86 || IA64 || ARM64)
> +       depends on (X86 || IA64 || ARM64 || LOONGARCH)
>         default y if IA64 || ARM64
>
>  config ACPI_HMAT
> diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
> index 6021a1013442..b8795fc49097 100644
> --- a/drivers/acpi/numa/srat.c
> +++ b/drivers/acpi/numa/srat.c
> @@ -206,7 +206,7 @@ int __init srat_disabled(void)
>         return acpi_numa < 0;
>  }
>
> -#if defined(CONFIG_X86) || defined(CONFIG_ARM64)
> +#if defined(CONFIG_X86) || defined(CONFIG_ARM64) || defined(CONFIG_LOONG=
ARCH)
>  /*
>   * Callback for SLIT parsing.  pxm_to_node() returns NUMA_NO_NODE for
>   * I/O localities since SRAT does not list them.  I/O localities are
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index 6bb36fd6ba31..3ba8511cbede 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -249,7 +249,7 @@ void acpi_table_print_madt_entry (struct acpi_subtabl=
e_header *madt);
>  /* the following numa functions are architecture-dependent */
>  void acpi_numa_slit_init (struct acpi_table_slit *slit);
>
> -#if defined(CONFIG_X86) || defined(CONFIG_IA64)
> +#if defined(CONFIG_X86) || defined(CONFIG_IA64) || defined(CONFIG_LOONGA=
RCH)
>  void acpi_numa_processor_affinity_init (struct acpi_srat_cpu_affinity *p=
a);
>  #else
>  static inline void
> --

Does this patch alone make sense without the other two in the series?
If so, I can queue it up for 5.15, so please let me know.

Thanks!
--===============8608221006824486310==--

