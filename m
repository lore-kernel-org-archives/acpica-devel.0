Content-Type: multipart/mixed; boundary="===============0859417450989717103=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: [Devel] Re: [PATCH 1/3] ACPI: Add LoongArch support for
 ACPI_PROCESSOR/ACPI_NUMA
Date: Fri, 16 Jul 2021 19:11:25 +0200
Message-ID: <CAJZ5v0juBC5USF_t-kF7Npk7onXF6SkKvwechuUYiM2jzFuN3Q@mail.gmail.com>
In-Reply-To: 407870af.c1bf.17aa87f94db.Coremail.chenhuacai@loongson.cn
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============0859417450989717103==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 15, 2021 at 6:49 AM =E9=99=88=E5=8D=8E=E6=89=8D <chenhuacai(a)l=
oongson.cn> wrote:
>
> Hi, Rafael,
>
>
> &gt; -----=E5=8E=9F=E5=A7=8B=E9=82=AE=E4=BB=B6-----
> &gt; =E5=8F=91=E4=BB=B6=E4=BA=BA: "Rafael J. Wysocki" <rafael(a)kernel.or=
g>
> &gt; =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: 2021-07-14 20:30:33 (=E6=98=9F=
=E6=9C=9F=E4=B8=89)
> &gt; =E6=94=B6=E4=BB=B6=E4=BA=BA: "Huacai Chen" <chenhuacai(a)loongson.cn>
> &gt; =E6=8A=84=E9=80=81: "Rafael J . Wysocki" <rjw(a)rjwysocki.net>, "Len=
 Brown" <lenb(a)kernel.org>, "Robert Moore" <robert.moore(a)intel.com>, "Er=
ik Kaneda" <erik.kaneda(a)intel.com>, "ACPI Devel Maling List" <linux-acpi(=
a)vger.kernel.org>, "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel=
(a)acpica.org>, "Xuefeng Li" <lixuefeng(a)loongson.cn>, "Jiaxun Yang" <jiax=
un.yang(a)flygoat.com>
> &gt; =E4=B8=BB=E9=A2=98: Re: [PATCH 1/3] ACPI: Add LoongArch support for =
ACPI_PROCESSOR/ACPI_NUMA
> &gt;
> &gt; On Mon, Jul 5, 2021 at 2:41 PM Huacai Chen <chenhuacai(a)loongson.cn=
> wrote:
> &gt; &gt;
> &gt; &gt; We are preparing to add new Loongson (based on LoongArch, not M=
IPS)
> &gt; &gt; support. LoongArch use ACPI other than DT as its boot protocol,=
 so
> &gt; &gt; add its support for ACPI_PROCESSOR/ACPI_NUMA.
> &gt; &gt;
> &gt; &gt; Signed-off-by: Huacai Chen <chenhuacai(a)loongson.cn>
> &gt; &gt; ---
> &gt; &gt;  drivers/acpi/Kconfig      | 4 ++--
> &gt; &gt;  drivers/acpi/numa/Kconfig | 2 +-
> &gt; &gt;  drivers/acpi/numa/srat.c  | 2 +-
> &gt; &gt;  include/linux/acpi.h      | 2 +-
> &gt; &gt;  4 files changed, 5 insertions(+), 5 deletions(-)
> &gt; &gt;
> &gt; &gt; diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> &gt; &gt; index fe0bb6277e4d..90afa44efcba 100644
> &gt; &gt; --- a/drivers/acpi/Kconfig
> &gt; &gt; +++ b/drivers/acpi/Kconfig
> &gt; &gt; @@ -280,9 +280,9 @@ config ACPI_CPPC_LIB
> &gt; &gt;
> &gt; &gt;  config ACPI_PROCESSOR
> &gt; &gt;         tristate "Processor"
> &gt; &gt; -       depends on X86 || IA64 || ARM64
> &gt; &gt; +       depends on X86 || IA64 || ARM64 || LOONGARCH
> &gt; &gt;         select ACPI_PROCESSOR_IDLE
> &gt; &gt; -       select ACPI_CPU_FREQ_PSS if X86 || IA64
> &gt; &gt; +       select ACPI_CPU_FREQ_PSS if X86 || IA64 || LOONGARCH
> &gt; &gt;         default y
> &gt; &gt;         help
> &gt; &gt;           This driver adds support for the ACPI Processor packa=
ge. It is required
> &gt; &gt; diff --git a/drivers/acpi/numa/Kconfig b/drivers/acpi/numa/Kcon=
fig
> &gt; &gt; index fcf2e556d69d..39b1f34c21df 100644
> &gt; &gt; --- a/drivers/acpi/numa/Kconfig
> &gt; &gt; +++ b/drivers/acpi/numa/Kconfig
> &gt; &gt; @@ -2,7 +2,7 @@
> &gt; &gt;  config ACPI_NUMA
> &gt; &gt;         bool "NUMA support"
> &gt; &gt;         depends on NUMA
> &gt; &gt; -       depends on (X86 || IA64 || ARM64)
> &gt; &gt; +       depends on (X86 || IA64 || ARM64 || LOONGARCH)
> &gt; &gt;         default y if IA64 || ARM64
> &gt; &gt;
> &gt; &gt;  config ACPI_HMAT
> &gt; &gt; diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
> &gt; &gt; index 6021a1013442..b8795fc49097 100644
> &gt; &gt; --- a/drivers/acpi/numa/srat.c
> &gt; &gt; +++ b/drivers/acpi/numa/srat.c
> &gt; &gt; @@ -206,7 +206,7 @@ int __init srat_disabled(void)
> &gt; &gt;         return acpi_numa &lt; 0;
> &gt; &gt;  }
> &gt; &gt;
> &gt; &gt; -#if defined(CONFIG_X86) || defined(CONFIG_ARM64)
> &gt; &gt; +#if defined(CONFIG_X86) || defined(CONFIG_ARM64) || defined(CO=
NFIG_LOONGARCH)
> &gt; &gt;  /*
> &gt; &gt;   * Callback for SLIT parsing.  pxm_to_node() returns NUMA_NO_N=
ODE for
> &gt; &gt;   * I/O localities since SRAT does not list them.  I/O localiti=
es are
> &gt; &gt; diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> &gt; &gt; index 6bb36fd6ba31..3ba8511cbede 100644
> &gt; &gt; --- a/include/linux/acpi.h
> &gt; &gt; +++ b/include/linux/acpi.h
> &gt; &gt; @@ -249,7 +249,7 @@ void acpi_table_print_madt_entry (struct ac=
pi_subtable_header *madt);
> &gt; &gt;  /* the following numa functions are architecture-dependent */
> &gt; &gt;  void acpi_numa_slit_init (struct acpi_table_slit *slit);
> &gt; &gt;
> &gt; &gt; -#if defined(CONFIG_X86) || defined(CONFIG_IA64)
> &gt; &gt; +#if defined(CONFIG_X86) || defined(CONFIG_IA64) || defined(CON=
FIG_LOONGARCH)
> &gt; &gt;  void acpi_numa_processor_affinity_init (struct acpi_srat_cpu_a=
ffinity *pa);
> &gt; &gt;  #else
> &gt; &gt;  static inline void
> &gt; &gt; --
> &gt;
> &gt; Does this patch alone make sense without the other two in the series?
> &gt; If so, I can queue it up for 5.15, so please let me know.
> Yes, this patch has no dependency with other two.

OK, applied as 5.15 material.

Thanks!
--===============0859417450989717103==--

