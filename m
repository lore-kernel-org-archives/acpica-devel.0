Content-Type: multipart/mixed; boundary="===============0028111184210186658=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: [Devel] Re: [PATCH 1/2] ACPICA: Add support for ARM Performance
 Monitoring Unit Table.
Date: Wed, 20 Apr 2022 17:31:43 +0200
Message-ID: <CAJZ5v0jUZSSvMGYhu44rSnEXmVve-wKXkUf-U_qy0ojn4v6kXA@mail.gmail.com>
In-Reply-To: 20220419205432.46021-2-bwicaksono@nvidia.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============0028111184210186658==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 19, 2022 at 10:55 PM Besar Wicaksono <bwicaksono(a)nvidia.com> =
wrote:
>
> ACPICA commit 002165ecc0a3dc703bb24c789aaa02fdada01675
>
> The specification of this table is described in
> "ARM Performance Monitoring Unit Architecture 1.0 Platform Design Documen=
t"
> ARM DEN0117.
>
> This patch adds the necessary types and support for
> compiling/disassembling APMT.
>
> Link: https://github.com/acpica/acpica/commit/002165ec
> Signed-off-by: Besar Wicaksono <bwicaksono(a)nvidia.com>

It should be equivalent to this patch:

https://patchwork.kernel.org/project/linux-acpi/patch/3370028.QJadu78ljV(a)=
kreacher/

present in linux-next.

If the other patch in the series is ACKed by the ARM64 ACPi people, I
can take it too.

Thanks!

> ---
>  include/acpi/actbl2.h | 81 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 81 insertions(+)
>
> diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
> index 16847c8d9d5f..8fc5cf318c15 100644
> --- a/include/acpi/actbl2.h
> +++ b/include/acpi/actbl2.h
> @@ -25,6 +25,7 @@
>   * the wrong signature.
>   */
>  #define ACPI_SIG_AGDI           "AGDI" /* Arm Generic Diagnostic Dump an=
d Reset Device Interface */
> +#define ACPI_SIG_APMT           "APMT" /* Arm Performance Monitoring Uni=
t table */
>  #define ACPI_SIG_BDAT           "BDAT" /* BIOS Data ACPI Table */
>  #define ACPI_SIG_IORT           "IORT" /* IO Remapping Table */
>  #define ACPI_SIG_IVRS           "IVRS" /* I/O Virtualization Reporting S=
tructure */
> @@ -258,6 +259,86 @@ struct acpi_table_agdi {
>
>  #define ACPI_AGDI_SIGNALING_MODE (1)
>
> +/***********************************************************************=
********
> + *
> + * APMT - ARM Performance Monitoring Unit Table
> + *
> + * Conforms to:
> + * ARM Performance Monitoring Unit Architecture 1.0 Platform Design Docu=
ment
> + * ARM DEN0117 v1.0 November 25, 2021
> + *
> + ***********************************************************************=
*******/
> +
> +struct acpi_table_apmt {
> +       struct acpi_table_header header;    /* Common ACPI table header */
> +};
> +
> +#define ACPI_APMT_NODE_ID_LENGTH                4
> +
> +/*
> + * APMT subtables
> + */
> +struct acpi_apmt_node {
> +       u16                                  length;
> +       u8                                   flags;
> +       u8                                   type;
> +       u32                                  id;
> +       u64                                  inst_primary;
> +       u32                                  inst_secondary;
> +       u64                                  base_address0;
> +       u64                                  base_address1;
> +       u32                                  ovflw_irq;
> +       u32                                  reserved;
> +       u32                                  ovflw_irq_flags;
> +       u32                                  proc_affinity;
> +       u32                                  impl_id;
> +};
> +
> +/* Masks for Flags field above */
> +
> +#define ACPI_APMT_FLAGS_DUAL_PAGE               (1<<0)
> +#define ACPI_APMT_FLAGS_AFFINITY                (1<<1)
> +#define ACPI_APMT_FLAGS_ATOMIC                  (1<<2)
> +
> +/* Values for Flags dual page field above */
> +
> +#define ACPI_APMT_FLAGS_DUAL_PAGE_NSUPP         (0<<0)
> +#define ACPI_APMT_FLAGS_DUAL_PAGE_SUPP          (1<<0)
> +
> +/* Values for Flags processor affinity field above */
> +#define ACPI_APMT_FLAGS_AFFINITY_PROC           (0<<1)
> +#define ACPI_APMT_FLAGS_AFFINITY_PROC_CONTAINER (1<<1)
> +
> +/* Values for Flags 64-bit atomic field above */
> +#define ACPI_APMT_FLAGS_ATOMIC_NSUPP            (0<<2)
> +#define ACPI_APMT_FLAGS_ATOMIC_SUPP             (1<<2)
> +
> +/* Values for Type field above */
> +
> +enum acpi_apmt_node_type {
> +       ACPI_APMT_NODE_TYPE_MC                      =3D 0x00,
> +       ACPI_APMT_NODE_TYPE_SMMU                    =3D 0x01,
> +       ACPI_APMT_NODE_TYPE_PCIE_ROOT               =3D 0x02,
> +       ACPI_APMT_NODE_TYPE_ACPI                    =3D 0x03,
> +       ACPI_APMT_NODE_TYPE_CACHE                   =3D 0x04,
> +       ACPI_APMT_NODE_TYPE_COUNT
> +};
> +
> +/* Masks for ovflw_irq_flags field above */
> +
> +#define ACPI_APMT_OVFLW_IRQ_FLAGS_MODE          (1<<0)
> +#define ACPI_APMT_OVFLW_IRQ_FLAGS_TYPE          (1<<1)
> +
> +/* Values for ovflw_irq_flags mode field above */
> +
> +#define ACPI_APMT_OVFLW_IRQ_FLAGS_MODE_LEVEL    (0<<0)
> +#define ACPI_APMT_OVFLW_IRQ_FLAGS_MODE_EDGE     (1<<0)
> +
> +/* Values for ovflw_irq_flags type field above */
> +
> +#define ACPI_APMT_OVFLW_IRQ_FLAGS_TYPE_WIRED    (0<<1)
> +
> +
>  /***********************************************************************=
********
>   *
>   * BDAT - BIOS Data ACPI Table
> --
> 2.17.1
>
--===============0028111184210186658==--

