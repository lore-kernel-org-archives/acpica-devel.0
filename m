Content-Type: multipart/mixed; boundary="===============8458689515028587693=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: [Devel] Re: [PATCH] ACPI: APEI: Fix num_ghes to unsigned int
Date: Wed, 05 Oct 2022 16:28:40 +0200
Message-ID: <CAJZ5v0h72L+U60=fBK5LOaNr5bCj9ukwcW8Pn2CCgx0jt1e1Kw@mail.gmail.com>
In-Reply-To: 20221004230541.449243-1-Ashish.Kalra@amd.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============8458689515028587693==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 5, 2022 at 1:06 AM Ashish Kalra <Ashish.Kalra(a)amd.com> wrote:
>
> From: Ashish Kalra <ashish.kalra(a)amd.com>
>
> Change num_ghes from int to unsigned int, preventing an overflow
> and causing subsequent vmalloc to fail.

So do you have a system where int is not sufficient?

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
> 2.25.1
>
--===============8458689515028587693==--

