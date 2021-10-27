Content-Type: multipart/mixed; boundary="===============7917581955949475725=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: [Devel] Re: [PATCH] ACPI: APEI: mark apei_hest_parse
Date: Wed, 27 Oct 2021 20:37:20 +0200
Message-ID: <CAJZ5v0jYmrV7bMV0b9wB8L-bX6PU+yCDrK8s+jCJh1x3xCi_Rg@mail.gmail.com>
In-Reply-To: 20211027065438.1742175-1-hch@lst.de
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============7917581955949475725==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 27, 2021 at 8:54 AM Christoph Hellwig <hch(a)lst.de> wrote:
>
> apei_hest_parse is only used in hest.c, so mark it static.
>
> Signed-off-by: Christoph Hellwig <hch(a)lst.de>
> ---
>  drivers/acpi/apei/hest.c | 5 +++--
>  include/acpi/apei.h      | 3 ---
>  2 files changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/acpi/apei/hest.c b/drivers/acpi/apei/hest.c
> index 277f00b288d14..0edc1ed476737 100644
> --- a/drivers/acpi/apei/hest.c
> +++ b/drivers/acpi/apei/hest.c
> @@ -86,7 +86,9 @@ static int hest_esrc_len(struct acpi_hest_header *hest_=
hdr)
>         return len;
>  };
>
> -int apei_hest_parse(apei_hest_func_t func, void *data)
> +typedef int (*apei_hest_func_t)(struct acpi_hest_header *hest_hdr, void =
*data);
> +
> +static int apei_hest_parse(apei_hest_func_t func, void *data)
>  {
>         struct acpi_hest_header *hest_hdr;
>         int i, rc, len;
> @@ -121,7 +123,6 @@ int apei_hest_parse(apei_hest_func_t func, void *data)
>
>         return 0;
>  }
> -EXPORT_SYMBOL_GPL(apei_hest_parse);
>
>  /*
>   * Check if firmware advertises firmware first mode. We need FF bit to b=
e set
> diff --git a/include/acpi/apei.h b/include/acpi/apei.h
> index 680f80960c3dc..ece0a8af2bae7 100644
> --- a/include/acpi/apei.h
> +++ b/include/acpi/apei.h
> @@ -37,9 +37,6 @@ void __init acpi_hest_init(void);
>  static inline void acpi_hest_init(void) { return; }
>  #endif
>
> -typedef int (*apei_hest_func_t)(struct acpi_hest_header *hest_hdr, void =
*data);
> -int apei_hest_parse(apei_hest_func_t func, void *data);
> -
>  int erst_write(const struct cper_record_header *record);
>  ssize_t erst_get_record_count(void);
>  int erst_get_record_id_begin(int *pos);
> --

Applied as 5.16 material, thanks!
--===============7917581955949475725==--

