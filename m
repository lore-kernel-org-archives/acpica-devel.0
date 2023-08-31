Return-Path: <rjwysocki@gmail.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C529E408DD
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DA581403AE
MIME-Version: 1.0
References: <20230831073432.1712904-1-suhui@nfschina.com>
In-Reply-To: <20230831073432.1712904-1-suhui@nfschina.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 31 Aug 2023 11:35:24 +0200
Message-ID: <CAJZ5v0iBZhz6oRgzU3_E+TFT244cgcWxS5ufo_8LnsgvrbbTJQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Acpica-devel] [PATCH 1/2] ACPICA: Use strscpy to replace
	strncpy
List-Id: "This is the central place for ACPICA developer discussions and
 issues." <acpica-devel.lists.linuxfoundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/acpica-devel/>
List-Post: <mailto:acpica-devel@lists.linuxfoundation.org>
List-Help: <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=subscribe>
To: Su Hui <suhui@nfschina.com>
Cc: rafael.j.wysocki@intel.com, kernel-janitors@vger.kernel.org, robert.moore@intel.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, acpica-devel@lists.linuxfoundation.org, lenb@kernel.org

On Thu, Aug 31, 2023 at 9:35=E2=80=AFAM Su Hui <suhui@nfschina.com> wrote:
>
> With gcc and W=3D1 option to compile kernel, warning happens:
>
> inlined from =E2=80=98acpi_tb_find_table=E2=80=99 at drivers/acpi/acpica/=
tbfind.c:60:2:
> include/linux/fortify-string.h:68:30: error: =E2=80=98__builtin_strncpy=
=E2=80=99 specified
> bound 6 equals destination size [-Werror=3Dstringop-truncation]
>
> Use strscpy to avoid this warning and is safer.
>
> Signed-off-by: Su Hui <suhui@nfschina.com>

Please see

https://lore.kernel.org/linux-acpi/202308241612.DFE4119@keescook/

> ---
>  drivers/acpi/acpica/tbfind.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/acpi/acpica/tbfind.c b/drivers/acpi/acpica/tbfind.c
> index 1c1b2e284bd9..5536d1755188 100644
> --- a/drivers/acpi/acpica/tbfind.c
> +++ b/drivers/acpi/acpica/tbfind.c
> @@ -57,8 +57,8 @@ acpi_tb_find_table(char *signature,
>
>         memset(&header, 0, sizeof(struct acpi_table_header));
>         ACPI_COPY_NAMESEG(header.signature, signature);
> -       strncpy(header.oem_id, oem_id, ACPI_OEM_ID_SIZE);
> -       strncpy(header.oem_table_id, oem_table_id, ACPI_OEM_TABLE_ID_SIZE=
);
> +       strscpy(header.oem_id, oem_id, ACPI_OEM_ID_SIZE);
> +       strscpy(header.oem_table_id, oem_table_id, ACPI_OEM_TABLE_ID_SIZE=
);
>
>         /* Search for the table */
>
> --
> 2.30.2
>
