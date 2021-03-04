Content-Type: multipart/mixed; boundary="===============2710870628584630326=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: [Devel] Re: [PATCH 1/1] ACPI: fix acpi table use after free
Date: Thu, 04 Mar 2021 13:14:49 +0100
Message-ID: <CAJZ5v0j3=82x1hV9SCdinJQPkDXmJd9BFoqvNxNHSb6iS8PHVQ@mail.gmail.com>
In-Reply-To: 1614802160-29362-1-git-send-email-george.kennedy@oracle.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============2710870628584630326==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 4, 2021 at 2:22 AM George Kennedy <george.kennedy(a)oracle.com>=
 wrote:
>
> Since commit 7fef431be9c9 ("mm/page_alloc: place pages to tail
> in __free_pages_core()") the following use after free occurs
> intermittently when acpi tables are accessed.
>
> BUG: KASAN: use-after-free in ibft_init+0x134/0xc49
> Read of size 4 at addr ffff8880be453004 by task swapper/0/1
> CPU: 3 PID: 1 Comm: swapper/0 Not tainted 5.12.0-rc1-7a7fd0d #1
> Call Trace:
>  dump_stack+0xf6/0x158
>  print_address_description.constprop.9+0x41/0x60
>  kasan_report.cold.14+0x7b/0xd4
>  __asan_report_load_n_noabort+0xf/0x20
>  ibft_init+0x134/0xc49
>  do_one_initcall+0xc4/0x3e0
>  kernel_init_freeable+0x5af/0x66b
>  kernel_init+0x16/0x1d0
>  ret_from_fork+0x22/0x30
>
> ACPI tables mapped via kmap() do not have their mapped pages
> reserved and the pages can be "stolen" by the buddy allocator.

What do you mean by this?

> Use memblock_reserve() to reserve all the ACPI table pages.

How is this going to help?

> Signed-off-by: George Kennedy <george.kennedy(a)oracle.com>
> ---
>  arch/x86/kernel/setup.c        | 3 +--
>  drivers/acpi/acpica/tbinstal.c | 4 ++++
>  2 files changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> index d883176..97deea3 100644
> --- a/arch/x86/kernel/setup.c
> +++ b/arch/x86/kernel/setup.c
> @@ -1046,6 +1046,7 @@ void __init setup_arch(char **cmdline_p)
>         cleanup_highmap();
>
>         memblock_set_current_limit(ISA_END_ADDRESS);
> +       acpi_boot_table_init();

This cannot be moved before the acpi_table_upgrade() invocation AFAICS.

Why exactly do you want to move it?

>         e820__memblock_setup();
>
>         /*
> @@ -1139,8 +1140,6 @@ void __init setup_arch(char **cmdline_p)
>         /*
>          * Parse the ACPI tables for possible boot-time SMP configuration.
>          */
> -       acpi_boot_table_init();
> -
>         early_acpi_boot_init();
>
>         initmem_init();
> diff --git a/drivers/acpi/acpica/tbinstal.c b/drivers/acpi/acpica/tbinsta=
l.c
> index 8d1e5b5..4e32b22 100644
> --- a/drivers/acpi/acpica/tbinstal.c
> +++ b/drivers/acpi/acpica/tbinstal.c
> @@ -8,6 +8,7 @@
>   ***********************************************************************=
******/
>
>  #include <acpi/acpi.h>
> +#include <linux/memblock.h>
>  #include "accommon.h"
>  #include "actables.h"
>
> @@ -58,6 +59,9 @@
>                                       new_table_desc->flags,
>                                       new_table_desc->pointer);
>
> +       memblock_reserve(new_table_desc->address,
> +                        PAGE_ALIGN(new_table_desc->pointer->length));
> +

Why do you want to do this here in the first place?

Things like that cannot be done in the ACPICA code in general.

>         acpi_tb_print_table_header(new_table_desc->address,
>                                    new_table_desc->pointer);
>
> --
--===============2710870628584630326==--

