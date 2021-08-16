Content-Type: multipart/mixed; boundary="===============4711374185894533962=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: [Devel] Re: [PATCH v2] x86/acpi: Don't add CPUs that are not online
 capable
Date: Mon, 16 Aug 2021 16:04:57 +0200
Message-ID: <CAJZ5v0jynpMMnMBQuyJPYfSG-6JSe5=a6wW0UtUnpGuh68CqkA@mail.gmail.com>
In-Reply-To: 20210813161842.222414-1-mario.limonciello@amd.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============4711374185894533962==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 13, 2021 at 6:19 PM Mario Limonciello
<mario.limonciello(a)amd.com> wrote:
>
> A number of systems are showing "hotplug capable" CPUs when they
> are not really hotpluggable.  This is because the MADT has extra
> CPU entries to support different CPUs that may be inserted into
> the socket with different numbers of cores.
>
> Starting with ACPI 6.3 the spec has an Online Capable bit in the
> MADT used to determine whether or not a CPU is hotplug capable
> when the enabled bit is not set.
>
> Link: https://uefi.org/htmlspecs/ACPI_Spec_6_4_html/05_ACPI_Software_Prog=
ramming_Model/ACPI_Software_Programming_Model.html?#local-apic-flags
> Signed-off-by: Mario Limonciello <mario.limonciello(a)amd.com>
> ---
>  arch/x86/kernel/acpi/boot.c | 10 ++++++++++
>  include/acpi/actbl2.h       |  1 +
>  2 files changed, 11 insertions(+)
>
> Changes from v1->v2:
>  * Check the revision field in MADT to determine if it matches the
>    bump from ACPI 6.3 as suggested by Hanjun Guo
>  * Update description
>
> diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
> index e55e0c1fad8c..bfa69a5c9c0b 100644
> --- a/arch/x86/kernel/acpi/boot.c
> +++ b/arch/x86/kernel/acpi/boot.c
> @@ -53,6 +53,8 @@ int acpi_ioapic;
>  int acpi_strict;
>  int acpi_disable_cmcff;
>
> +bool acpi_support_online_capable;

Missing static?

> +
>  /* ACPI SCI override configuration */
>  u8 acpi_sci_flags __initdata;
>  u32 acpi_sci_override_gsi __initdata =3D INVALID_ACPI_IRQ;
> @@ -138,6 +140,8 @@ static int __init acpi_parse_madt(struct acpi_table_h=
eader *table)
>
>                 pr_debug("Local APIC address 0x%08x\n", madt->address);
>         }
> +       if (madt->header.revision >=3D 5)
> +               acpi_support_online_capable =3D true;
>
>         default_acpi_madt_oem_check(madt->header.oem_id,
>                                     madt->header.oem_table_id);
> @@ -239,6 +243,12 @@ acpi_parse_lapic(union acpi_subtable_headers * heade=
r, const unsigned long end)
>         if (processor->id =3D=3D 0xff)
>                 return 0;
>
> +       /* don't register processors that can not be onlined */
> +       if (acpi_support_online_capable &&
> +           !(processor->lapic_flags & ACPI_MADT_ENABLED) &&
> +           !(processor->lapic_flags & ACPI_MADT_ONLINE_CAPABLE))
> +               return 0;
> +
>         /*
>          * We need to register disabled CPU as well to permit
>          * counting disabled CPUs. This allows us to size
> diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
> index 2069ac38a4e2..fae45e383987 100644
> --- a/include/acpi/actbl2.h
> +++ b/include/acpi/actbl2.h

The one below is an ACPICA change and I'd prefer it to be integrated
via the upstream ACPICA.

Could you prepare an ACPICA pull request for just the bit below and
send it via GitHub?

> @@ -808,6 +808,7 @@ struct acpi_madt_multiproc_wakeup_mailbox {
>  /* MADT Local APIC flags */
>
>  #define ACPI_MADT_ENABLED           (1)        /* 00: Processor is usabl=
e if set */
> +#define ACPI_MADT_ONLINE_CAPABLE    (2)        /* 01: System HW supports=
 enabling processor at runtime */
>
>  /* MADT MPS INTI flags (inti_flags) */
>
> --
--===============4711374185894533962==--

