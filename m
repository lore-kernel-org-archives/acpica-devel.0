Return-Path: <rjwysocki@gmail.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 60693401CC
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 595BF400D9
MIME-Version: 1.0
References: <20230703130125.997208-1-ben.dooks@codethink.co.uk>
In-Reply-To: <20230703130125.997208-1-ben.dooks@codethink.co.uk>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 4 Jul 2023 19:19:37 +0200
Message-ID: <CAJZ5v0icycz_6=h40WP1Yxu0QWFZT7fqKezax=ekb2mrbx5j8A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Acpica-devel] [PATCH] ACPICA: actbl2: change to be16/be32
	types for big endian data
List-Id: "This is the central place for ACPICA developer discussions and
 issues." <acpica-devel.lists.linuxfoundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/acpica-devel/>
List-Post: <mailto:acpica-devel@lists.linuxfoundation.org>
List-Help: <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=subscribe>
To: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: nvdimm@lists.linux.dev, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, acpica-devel@lists.linuxfoundation.org, Dan Williams <dan.j.williams@intel.com>, lenb@kernel.org

On Mon, Jul 3, 2023 at 3:01=E2=80=AFPM Ben Dooks <ben.dooks@codethink.co.uk=
> wrote:
>
> Some of the fields in struct acpi_nfit_control_region are used in big
> endian format, and thus are generatng warnings from spare where the
> member is passed to one of the conversion functions.
>
> Fix the following sparse warnings by changing the data types:
>
> drivers/acpi/nfit/core.c:1403:41: warning: cast to restricted __be16
> drivers/acpi/nfit/core.c:1403:41: warning: cast to restricted __be16
> drivers/acpi/nfit/core.c:1403:41: warning: cast to restricted __be16
> drivers/acpi/nfit/core.c:1403:41: warning: cast to restricted __be16
> drivers/acpi/nfit/core.c:1412:41: warning: cast to restricted __be16
> drivers/acpi/nfit/core.c:1412:41: warning: cast to restricted __be16
> drivers/acpi/nfit/core.c:1412:41: warning: cast to restricted __be16
> drivers/acpi/nfit/core.c:1412:41: warning: cast to restricted __be16
> drivers/acpi/nfit/core.c:1421:41: warning: cast to restricted __be16
> drivers/acpi/nfit/core.c:1421:41: warning: cast to restricted __be16
> drivers/acpi/nfit/core.c:1421:41: warning: cast to restricted __be16
> drivers/acpi/nfit/core.c:1421:41: warning: cast to restricted __be16
> drivers/acpi/nfit/core.c:1430:41: warning: cast to restricted __be16
> drivers/acpi/nfit/core.c:1430:41: warning: cast to restricted __be16
> drivers/acpi/nfit/core.c:1430:41: warning: cast to restricted __be16
> drivers/acpi/nfit/core.c:1430:41: warning: cast to restricted __be16
> drivers/acpi/nfit/core.c:1440:25: warning: cast to restricted __be16
> drivers/acpi/nfit/core.c:1440:25: warning: cast to restricted __be16
> drivers/acpi/nfit/core.c:1440:25: warning: cast to restricted __be16
> drivers/acpi/nfit/core.c:1440:25: warning: cast to restricted __be16
> drivers/acpi/nfit/core.c:1449:41: warning: cast to restricted __be16
> drivers/acpi/nfit/core.c:1449:41: warning: cast to restricted __be16
> drivers/acpi/nfit/core.c:1449:41: warning: cast to restricted __be16
> drivers/acpi/nfit/core.c:1449:41: warning: cast to restricted __be16
> drivers/acpi/nfit/core.c:1468:41: warning: cast to restricted __le16
> drivers/acpi/nfit/core.c:1502:41: warning: cast to restricted __le16
> drivers/acpi/nfit/core.c:1527:41: warning: cast to restricted __be32
> drivers/acpi/nfit/core.c:1527:41: warning: cast to restricted __be32
> drivers/acpi/nfit/core.c:1527:41: warning: cast to restricted __be32
> drivers/acpi/nfit/core.c:1527:41: warning: cast to restricted __be32
> drivers/acpi/nfit/core.c:1527:41: warning: cast to restricted __be32
> drivers/acpi/nfit/core.c:1527:41: warning: cast to restricted __be32
> drivers/acpi/nfit/core.c:1792:33: warning: cast to restricted __be16
> drivers/acpi/nfit/core.c:1792:33: warning: cast to restricted __be16
> drivers/acpi/nfit/core.c:1792:33: warning: cast to restricted __be16
> drivers/acpi/nfit/core.c:1792:33: warning: cast to restricted __be16
> drivers/acpi/nfit/core.c:1794:33: warning: cast to restricted __be16
> drivers/acpi/nfit/core.c:1794:33: warning: cast to restricted __be16
> drivers/acpi/nfit/core.c:1794:33: warning: cast to restricted __be16
> drivers/acpi/nfit/core.c:1794:33: warning: cast to restricted __be16
> drivers/acpi/nfit/core.c:1795:33: warning: cast to restricted __be32
> drivers/acpi/nfit/core.c:1795:33: warning: cast to restricted __be32
> drivers/acpi/nfit/core.c:1795:33: warning: cast to restricted __be32
> drivers/acpi/nfit/core.c:1795:33: warning: cast to restricted __be32
> drivers/acpi/nfit/core.c:1795:33: warning: cast to restricted __be32
> drivers/acpi/nfit/core.c:1795:33: warning: cast to restricted __be32
> drivers/acpi/nfit/core.c:1798:33: warning: cast to restricted __be16
> drivers/acpi/nfit/core.c:1798:33: warning: cast to restricted __be16
> drivers/acpi/nfit/core.c:1798:33: warning: cast to restricted __be16
> drivers/acpi/nfit/core.c:1798:33: warning: cast to restricted __be16
> drivers/acpi/nfit/core.c:1799:33: warning: cast to restricted __be32
> drivers/acpi/nfit/core.c:1799:33: warning: cast to restricted __be32
> drivers/acpi/nfit/core.c:1799:33: warning: cast to restricted __be32
> drivers/acpi/nfit/core.c:1799:33: warning: cast to restricted __be32
> drivers/acpi/nfit/core.c:1799:33: warning: cast to restricted __be32
> drivers/acpi/nfit/core.c:1799:33: warning: cast to restricted __be32
>
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>

First off, this falls under the ACPICA rule mentioned before.

Second, all ACPI is little-endian by the spec, so I'm not sure what is
going on here.

> ---
>  drivers/acpi/nfit/core.c |  8 ++++----
>  include/acpi/actbl2.h    | 18 +++++++++---------
>  2 files changed, 13 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
> index 07204d482968..0fcc247fdfac 100644
> --- a/drivers/acpi/nfit/core.c
> +++ b/drivers/acpi/nfit/core.c
> @@ -2194,15 +2194,15 @@ static const struct attribute_group *acpi_nfit_re=
gion_attribute_groups[] =3D {
>  /* enough info to uniquely specify an interleave set */
>  struct nfit_set_info {
>         u64 region_offset;
> -       u32 serial_number;
> +       __be32 serial_number;
>         u32 pad;
>  };
>
>  struct nfit_set_info2 {
>         u64 region_offset;
> -       u32 serial_number;
> -       u16 vendor_id;
> -       u16 manufacturing_date;
> +       __be32 serial_number;
> +       __be16 vendor_id;
> +       __be16 manufacturing_date;
>         u8 manufacturing_location;
>         u8 reserved[31];
>  };
> diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
> index 0029336775a9..c1df59aa8855 100644
> --- a/include/acpi/actbl2.h
> +++ b/include/acpi/actbl2.h
> @@ -1716,18 +1716,18 @@ struct acpi_nfit_smbios {
>  struct acpi_nfit_control_region {
>         struct acpi_nfit_header header;
>         u16 region_index;
> -       u16 vendor_id;
> -       u16 device_id;
> -       u16 revision_id;
> -       u16 subsystem_vendor_id;
> -       u16 subsystem_device_id;
> -       u16 subsystem_revision_id;
> +       __be16 vendor_id;
> +       __be16 device_id;
> +       __be16  revision_id;
> +       __be16 subsystem_vendor_id;
> +       __be16 subsystem_device_id;
> +       __be16 subsystem_revision_id;
>         u8 valid_fields;
>         u8 manufacturing_location;
> -       u16 manufacturing_date;
> +       __be16 manufacturing_date;
>         u8 reserved[2];         /* Reserved, must be zero */
> -       u32 serial_number;
> -       u16 code;
> +       __be32 serial_number;
> +       __le16 code;
>         u16 windows;
>         u64 window_size;
>         u64 command_offset;
> --
> 2.40.1
>
