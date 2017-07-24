Content-Type: multipart/mixed; boundary="===============2721054930503241288=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rjw at rjwysocki.net>
Subject: Re: [Devel] [PATCH 2/2] acpi: Fix typo in SRAT table name
Date: Mon, 24 Jul 2017 22:29:10 +0200
Message-ID: <7822621.77xjRtf9ye@aspire.rjw.lan>
In-Reply-To: 20170721225124.15297-2-ross.zwisler@linux.intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============2721054930503241288==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Friday, July 21, 2017 04:51:24 PM Ross Zwisler wrote:
> To save someone the time of searching the ACPI spec for "Static Resource
> Affinity Table".
> =

> Signed-off-by: Ross Zwisler <ross.zwisler(a)linux.intel.com>
> ---
>  drivers/acpi/numa.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> =

> diff --git a/drivers/acpi/numa.c b/drivers/acpi/numa.c
> index edb0c79..917f1cc 100644
> --- a/drivers/acpi/numa.c
> +++ b/drivers/acpi/numa.c
> @@ -443,7 +443,7 @@ int __init acpi_numa_init(void)
>  	 * So go over all cpu entries in SRAT to get apicid to node mapping.
>  	 */
>  =

> -	/* SRAT: Static Resource Affinity Table */
> +	/* SRAT: System Resource Affinity Table */
>  	if (!acpi_table_parse(ACPI_SIG_SRAT, acpi_parse_srat)) {
>  		struct acpi_subtable_proc srat_proc[3];
>  =

> =


Both this and the [1/2] applied, thanks!


--===============2721054930503241288==--

