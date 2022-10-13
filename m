Content-Type: multipart/mixed; boundary="===============5118146507568421955=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: [Devel] Re: [PATCH v2] ACPI: APEI: Fix num_ghes to unsigned int
Date: Thu, 13 Oct 2022 20:45:48 +0200
Message-ID: <CAJZ5v0gsnVTwPX+hrB4-hUtESsBC1dot3vFh_8qe4cb8ChDYtA@mail.gmail.com>
In-Reply-To: 20221005163253.455910-1-Ashish.Kalra@amd.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============5118146507568421955==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 5, 2022 at 6:33 PM Ashish Kalra <Ashish.Kalra(a)amd.com> wrote:
>
> From: Ashish Kalra <ashish.kalra(a)amd.com>
>
> Change num_ghes from int to unsigned int, preventing an overflow
> and causing subsequent vmalloc to fail.
>
> The overflow happens in the ghes_estatus_pool_init() when calculating
> len during execution of the statement below as both multiplication
> operands here are signed int :
>
> len +=3D (num_ghes * GHES_ESOURCE_PREALLOC_MAX_SIZE);
>
> The following call trace is observed because of this bug:
>
> [    9.317108] swapper/0: vmalloc error: size 18446744071562596352, excee=
ds total pages, mode:0xcc0(GFP_KERNEL), nodemask=3D(null),cpuset=3D/,mems_a=
llowed=3D0-1
> [    9.317131] Call Trace:
> [    9.317134]  <TASK>
> [    9.317137]  dump_stack_lvl+0x49/0x5f
> [    9.317145]  dump_stack+0x10/0x12
> [    9.317146]  warn_alloc.cold+0x7b/0xdf
> [    9.317150]  ? __device_attach+0x16a/0x1b0
> [    9.317155]  __vmalloc_node_range+0x702/0x740
> [    9.317160]  ? device_add+0x17f/0x920
> [    9.317164]  ? dev_set_name+0x53/0x70
> [    9.317166]  ? platform_device_add+0xf9/0x240
> [    9.317168]  __vmalloc_node+0x49/0x50
> [    9.317170]  ? ghes_estatus_pool_init+0x43/0xa0
> [    9.317176]  vmalloc+0x21/0x30
> [    9.317177]  ghes_estatus_pool_init+0x43/0xa0
> [    9.317179]  acpi_hest_init+0x129/0x19c
> [    9.317185]  acpi_init+0x434/0x4a4
> [    9.317188]  ? acpi_sleep_proc_init+0x2a/0x2a
> [    9.317190]  do_one_initcall+0x48/0x200
> [    9.317195]  kernel_init_freeable+0x221/0x284
> [    9.317200]  ? rest_init+0xe0/0xe0
> [    9.317204]  kernel_init+0x1a/0x130
> [    9.317205]  ret_from_fork+0x22/0x30
> [    9.317208]  </TASK>
>
> Signed-off-by: Ashish Kalra <ashish.kalra(a)amd.com>
> ---
>  drivers/acpi/apei/ghes.c | 2 +-
>  include/acpi/ghes.h      | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index d91ad378c00d..6d7c202142a6 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -163,7 +163,7 @@ static void ghes_unmap(void __iomem *vaddr, enum fixe=
d_addresses fixmap_idx)
>         clear_fixmap(fixmap_idx);
>  }
>
> -int ghes_estatus_pool_init(int num_ghes)
> +int ghes_estatus_pool_init(unsigned int num_ghes)
>  {
>         unsigned long addr, len;
>         int rc;
> diff --git a/include/acpi/ghes.h b/include/acpi/ghes.h
> index 34fb3431a8f3..292a5c40bd0c 100644
> --- a/include/acpi/ghes.h
> +++ b/include/acpi/ghes.h
> @@ -71,7 +71,7 @@ int ghes_register_vendor_record_notifier(struct notifie=
r_block *nb);
>  void ghes_unregister_vendor_record_notifier(struct notifier_block *nb);
>  #endif
>
> -int ghes_estatus_pool_init(int num_ghes);
> +int ghes_estatus_pool_init(unsigned int num_ghes);
>
>  /* From drivers/edac/ghes_edac.c */
>
> --

Applied as 6.1 material with some edits in the subject and changelog.

Thanks!
--===============5118146507568421955==--

