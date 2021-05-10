Content-Type: multipart/mixed; boundary="===============7646792036011171502=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: [Devel] Re: [PATCH 1/1] ACPICA: Add SVKL table headers
Date: Mon, 10 May 2021 18:58:19 +0200
Message-ID: <CAJZ5v0hbAaFtRxuyR2B6YBUfV6eGWmDrZnTisd9j5H0UNurqrg@mail.gmail.com>
In-Reply-To: 20210422192937.707500-1-sathyanarayanan.kuppuswamy@linux.intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============7646792036011171502==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 22, 2021 at 9:29 PM Kuppuswamy Sathyanarayanan
<sathyanarayanan.kuppuswamy(a)linux.intel.com> wrote:
>
> ACPICA commit b5e6bcf69dbb9877481992d5ce86008cfb94f5b8
>
> SVKL (Storage Volume Key Location Table) is used by BIOS/Firmware
> to share storage volume encryption key's with OS. It will be used
> by userspace to decrypt and mount encrypted drives.
>
> So add SVKL table signature and add it to known signatures array
> support SVKL.
>
> You can find details about the SVKL table in TDX specfication
> titled "Guest-Host-Communication Interface (GHCI) for Intel
> Trust Domain Extensions (Intel=C2=AE TDX)", sec 4.4 and in ACPI
> specification r6.4, sec 5.2.6.
>
> https://software.intel.com/content/dam/develop/external/us/en/documents/i=
ntel-tdx-guest-hypervisor-communication-interface.pdf
>
> Cc: Robert Moore <robert.moore(a)intel.com>
> Cc: Erik Kaneda <erik.kaneda(a)intel.com>
> Cc: Rafael J. Wysocki <rafael.j.wysocki(a)intel.com>
>
> Link: https://github.com/acpica/acpica/commit/b5e6bcf6
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy(a)l=
inux.intel.com>
> Signed-off-by: Bob Moore <robert.moore(a)intel.com>
> Signed-off-by: Erik Kaneda <erik.kaneda(a)intel.com>

Erik, what's the plan regarding this patch and the other ACPICA change
requisite for this series?

Are they going to be part of the next ACPICA release and am I going to
receive them the usual way?

> ---
>  include/acpi/actbl2.h | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
>
> diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
> index d6478c430c99..83a9d8b68e3a 100644
> --- a/include/acpi/actbl2.h
> +++ b/include/acpi/actbl2.h
> @@ -43,6 +43,7 @@
>  #define ACPI_SIG_SDEI           "SDEI" /* Software Delegated Exception I=
nterface Table */
>  #define ACPI_SIG_SDEV           "SDEV" /* Secure Devices table */
>  #define ACPI_SIG_NHLT           "NHLT" /* Non-HDAudio Link Table */
> +#define ACPI_SIG_SVKL           "SVKL" /* Storage Volume Key Location Ta=
ble */
>
>  /*
>   * All tables must be byte-packed to match the ACPI specification, since
> @@ -1713,6 +1714,35 @@ struct acpi_sdev_pcie_path {
>         u8 function;
>  };
>
> +/***********************************************************************=
********
> + *
> + * SVKL - Storage Volume Key Location Table (ACPI 6.4)
> + *        Version 1
> + *
> + ***********************************************************************=
*******/
> +
> +struct acpi_table_svkl {
> +       struct acpi_table_header header;        /* Common ACPI table head=
er */
> +       u32 count;
> +};
> +
> +struct acpi_svkl_header {
> +       u16 type;
> +       u16 format;
> +       u32 size;
> +       u64 address;
> +};
> +
> +enum acpi_svkl_type {
> +       ACPI_SVKL_TYPE_MAIN_STORAGE =3D 0,
> +       ACPI_SVKL_TYPE_RESERVED =3D 1     /* 1 and greater are reserved */
> +};
> +
> +enum acpi_svkl_format {
> +       ACPI_SVKL_FORMAT_RAW_BINARY =3D 0,
> +       ACPI_SVKL_FORMAT_RESERVED =3D 1   /* 1 and greater are reserved */
> +};
> +
>  /* Reset to default packing */
>
>  #pragma pack()
> --
> 2.25.1
>
--===============7646792036011171502==--

