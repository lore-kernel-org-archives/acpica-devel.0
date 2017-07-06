Content-Type: multipart/mixed; boundary="===============2268100454146042297=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: Re: [Devel] [RFC v2 1/5] acpi: add missing include in acpi_numa.h
Date: Fri, 07 Jul 2017 00:08:36 +0200
Message-ID: <CAJZ5v0hsNT6VzgxsC7KG2+N1wv0Yc54qQEG3WWt2Lro+ij8ZEA@mail.gmail.com>
In-Reply-To: 20170706215233.11329-2-ross.zwisler@linux.intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============2268100454146042297==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 6, 2017 at 11:52 PM, Ross Zwisler
<ross.zwisler(a)linux.intel.com> wrote:
> Right now if a file includes acpi_numa.h and they don't happen to include
> linux/numa.h before it, they get the following warning:
>
> ./include/acpi/acpi_numa.h:9:5: warning: "MAX_NUMNODES" is not defined [-=
Wundef]
>  #if MAX_NUMNODES > 256
>      ^~~~~~~~~~~~
>
> Signed-off-by: Ross Zwisler <ross.zwisler(a)linux.intel.com>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki(a)intel.com>

> ---
>  include/acpi/acpi_numa.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/include/acpi/acpi_numa.h b/include/acpi/acpi_numa.h
> index d4b7294..1e3a74f 100644
> --- a/include/acpi/acpi_numa.h
> +++ b/include/acpi/acpi_numa.h
> @@ -3,6 +3,7 @@
>
>  #ifdef CONFIG_ACPI_NUMA
>  #include <linux/kernel.h>
> +#include <linux/numa.h>
>
>  /* Proximity bitmap length */
>  #if MAX_NUMNODES > 256
> --
> 2.9.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo(a)vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--===============2268100454146042297==--

