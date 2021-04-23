Content-Type: multipart/mixed; boundary="===============7677215419009329585=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: [Devel] Re: [PATCH v2 1/3] ACPICA: ACPI 6.4: MADT: add Multiprocessor
 Wakeup Mailbox Structure
Date: Fri, 23 Apr 2021 14:33:53 +0200
Message-ID: <CAJZ5v0itaKL58ieMB6ER47GVns7Ukvd_7VNBAxkktWB5cDv-SQ@mail.gmail.com>
In-Reply-To: 20210422214708.716164-2-sathyanarayanan.kuppuswamy@linux.intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============7677215419009329585==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 22, 2021 at 11:47 PM Kuppuswamy Sathyanarayanan
<sathyanarayanan.kuppuswamy(a)linux.intel.com> wrote:
>
> ACPICA commit f1ee04207a212f6c519441e7e25397649ebc4cea
>
> Add Multiprocessor Wakeup Mailbox Structure definition. It is useful
> in parsing MADT Wake table.
>
> Link: https://github.com/acpica/acpica/commit/f1ee0420
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy(a)l=
inux.intel.com>

I'm expecting to receive this patch from Erik at one point, so I'm
guessing that it's been added to this series for reference.

> ---
>  include/acpi/actbl2.h | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
> index b2362600b9ff..7dce422f6119 100644
> --- a/include/acpi/actbl2.h
> +++ b/include/acpi/actbl2.h
> @@ -733,6 +733,20 @@ struct acpi_madt_multiproc_wakeup {
>         u64 base_address;
>  };
>
> +#define ACPI_MULTIPROC_WAKEUP_MB_OS_SIZE       2032
> +#define ACPI_MULTIPROC_WAKEUP_MB_FIRMWARE_SIZE 2048
> +
> +struct acpi_madt_multiproc_wakeup_mailbox {
> +       u16 command;
> +       u16 reserved;           /* reserved - must be zero */
> +       u32 apic_id;
> +       u64 wakeup_vector;
> +       u8 reserved_os[ACPI_MULTIPROC_WAKEUP_MB_OS_SIZE];       /* reserv=
ed for OS use */
> +       u8 reserved_firmware[ACPI_MULTIPROC_WAKEUP_MB_FIRMWARE_SIZE];   /=
* reserved for firmware use */
> +};
> +
> +#define ACPI_MP_WAKE_COMMAND_WAKEUP    1
> +
>  /*
>   * Common flags fields for MADT subtables
>   */
> --
> 2.25.1
>
--===============7677215419009329585==--

