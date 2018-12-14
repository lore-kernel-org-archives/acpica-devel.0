Content-Type: multipart/mixed; boundary="===============2630451117475944960=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: Re: [Devel] [PATCH v8 3/4] PCI/ACPI: Allow ACPI to be built without
 CONFIG_PCI set
Date: Fri, 14 Dec 2018 10:19:48 +0100
Message-ID: <CAJZ5v0j6u=E5xY-a=_D8wO5u=GOX9of3sG572pMSW+eB_e58Ow@mail.gmail.com>
In-Reply-To: 20181214031252.28707-4-okaya@kernel.org
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============2630451117475944960==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 14, 2018 at 4:13 AM Sinan Kaya <okaya(a)kernel.org> wrote:
>
> We are compiling PCI code today for systems with ACPI and no PCI
> device present. Remove the useless code and reduce the tight
> dependency.
>
> Signed-off-by: Sinan Kaya <okaya(a)kernel.org>

Bjorn, any objections here?

> ---
>  arch/x86/include/asm/pci_x86.h | 7 +++++++
>  drivers/acpi/Kconfig           | 1 -
>  drivers/acpi/Makefile          | 2 +-
>  drivers/acpi/internal.h        | 5 +++++
>  drivers/pci/Makefile           | 2 +-
>  include/acpi/acpi_drivers.h    | 7 +++++++
>  include/linux/acpi.h           | 7 +++++++
>  include/linux/pci.h            | 4 ++++
>  8 files changed, 32 insertions(+), 3 deletions(-)
>
> diff --git a/arch/x86/include/asm/pci_x86.h b/arch/x86/include/asm/pci_x8=
6.h
> index 959d618dbb17..73bb404f4d2a 100644
> --- a/arch/x86/include/asm/pci_x86.h
> +++ b/arch/x86/include/asm/pci_x86.h
> @@ -121,7 +121,14 @@ extern void __init dmi_check_pciprobe(void);
>  extern void __init dmi_check_skip_isa_align(void);
>
>  /* some common used subsys_initcalls */
> +#ifdef CONFIG_PCI
>  extern int __init pci_acpi_init(void);
> +#else
> +static inline int  __init pci_acpi_init(void)
> +{
> +       return -EINVAL;
> +}
> +#endif
>  extern void __init pcibios_irq_init(void);
>  extern int __init pcibios_init(void);
>  extern int pci_legacy_init(void);
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index 7cea769c37df..a0abcb3bd673 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -9,7 +9,6 @@ config ARCH_SUPPORTS_ACPI
>  menuconfig ACPI
>         bool "ACPI (Advanced Configuration and Power Interface) Support"
>         depends on ARCH_SUPPORTS_ACPI
> -       depends on PCI
>         select PNP
>         default y if X86
>         help
> diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
> index edc039313cd6..7c6afc111d76 100644
> --- a/drivers/acpi/Makefile
> +++ b/drivers/acpi/Makefile
> @@ -39,7 +39,7 @@ acpi-y                                +=3D processor_co=
re.o
>  acpi-$(CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC) +=3D processor_pdc.o
>  acpi-y                         +=3D ec.o
>  acpi-$(CONFIG_ACPI_DOCK)       +=3D dock.o
> -acpi-y                         +=3D pci_root.o pci_link.o pci_irq.o
> +acpi-$(CONFIG_PCI)             +=3D pci_root.o pci_link.o pci_irq.o
>  obj-$(CONFIG_ACPI_MCFG)                +=3D pci_mcfg.o
>  acpi-y                         +=3D acpi_lpss.o acpi_apd.o
>  acpi-y                         +=3D acpi_platform.o
> diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
> index 530a3f675490..b7060dae2789 100644
> --- a/drivers/acpi/internal.h
> +++ b/drivers/acpi/internal.h
> @@ -25,8 +25,13 @@ int acpi_osi_init(void);
>  acpi_status acpi_os_initialize1(void);
>  void init_acpi_device_notify(void);
>  int acpi_scan_init(void);
> +#ifdef CONFIG_PCI
>  void acpi_pci_root_init(void);
>  void acpi_pci_link_init(void);
> +#else
> +static inline void acpi_pci_root_init(void) {}
> +static inline void acpi_pci_link_init(void) {}
> +#endif
>  void acpi_processor_init(void);
>  void acpi_platform_init(void);
>  void acpi_pnp_init(void);
> diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
> index f2bda77a2df1..657d642fcc67 100644
> --- a/drivers/pci/Makefile
> +++ b/drivers/pci/Makefile
> @@ -11,6 +11,7 @@ ifdef CONFIG_PCI
>  obj-$(CONFIG_PROC_FS)          +=3D proc.o
>  obj-$(CONFIG_SYSFS)            +=3D slot.o
>  obj-$(CONFIG_OF)               +=3D of.o
> +obj-$(CONFIG_ACPI)             +=3D pci-acpi.o
>  endif
>
>  obj-$(CONFIG_PCI_QUIRKS)       +=3D quirks.o
> @@ -20,7 +21,6 @@ obj-$(CONFIG_PCI_MSI)         +=3D msi.o
>  obj-$(CONFIG_PCI_ATS)          +=3D ats.o
>  obj-$(CONFIG_PCI_IOV)          +=3D iov.o
>  obj-$(CONFIG_PCI_BRIDGE_EMUL)  +=3D pci-bridge-emul.o
> -obj-$(CONFIG_ACPI)             +=3D pci-acpi.o
>  obj-$(CONFIG_PCI_LABEL)                +=3D pci-label.o
>  obj-$(CONFIG_X86_INTEL_MID)    +=3D pci-mid.o
>  obj-$(CONFIG_PCI_SYSCALL)      +=3D syscall.o
> diff --git a/include/acpi/acpi_drivers.h b/include/acpi/acpi_drivers.h
> index 14499757338f..de1804aeaf69 100644
> --- a/include/acpi/acpi_drivers.h
> +++ b/include/acpi/acpi_drivers.h
> @@ -88,7 +88,14 @@ int acpi_pci_link_free_irq(acpi_handle handle);
>
>  struct pci_bus;
>
> +#ifdef CONFIG_PCI
>  struct pci_dev *acpi_get_pci_dev(acpi_handle);
> +#else
> +static inline struct pci_dev *acpi_get_pci_dev(acpi_handle handle)
> +{
> +       return NULL;
> +}
> +#endif
>
>  /* Arch-defined function to add a bus to the system */
>
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index ed80f147bd50..eb1fdf4c196a 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -340,7 +340,14 @@ struct pci_dev;
>  int acpi_pci_irq_enable (struct pci_dev *dev);
>  void acpi_penalize_isa_irq(int irq, int active);
>  bool acpi_isa_irq_available(int irq);
> +#ifdef CONFIG_PCI
>  void acpi_penalize_sci_irq(int irq, int trigger, int polarity);
> +#else
> +static inline void acpi_penalize_sci_irq(int irq, int trigger,
> +                                       int polarity)
> +{
> +}
> +#endif
>  void acpi_pci_irq_disable (struct pci_dev *dev);
>
>  extern int ec_read(u8 addr, u8 *val);
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 11c71c4ecf75..51a5a5217667 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1960,7 +1960,11 @@ int pcibios_set_pcie_reset_state(struct pci_dev *d=
ev,
>                                  enum pcie_reset_state state);
>  int pcibios_add_device(struct pci_dev *dev);
>  void pcibios_release_device(struct pci_dev *dev);
> +#ifdef CONFIG_PCI
>  void pcibios_penalize_isa_irq(int irq, int active);
> +#else
> +static inline void pcibios_penalize_isa_irq(int irq, int active) {}
> +#endif
>  int pcibios_alloc_irq(struct pci_dev *dev);
>  void pcibios_free_irq(struct pci_dev *dev);
>  resource_size_t pcibios_default_alignment(void);
> --
> 2.19.0
>

--===============2630451117475944960==--

