Content-Type: multipart/mixed; boundary="===============3684469905098103959=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: [Devel] Re: [PATCH v3 3/3] device property: Unify access to of_node
Date: Mon, 07 Jun 2021 14:45:32 +0200
Message-ID: <CAJZ5v0hk8BiDt5e_P=KXkj3datr_WTCUe7k2u_TkFUPjWm79Aw@mail.gmail.com>
In-Reply-To: 20210604165047.13243-3-andriy.shevchenko@linux.intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============3684469905098103959==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 4, 2021 at 6:50 PM Andy Shevchenko
<andriy.shevchenko(a)linux.intel.com> wrote:
>
> Historically we have a few variants how we access dev->fwnode
> and dev->of_node. Some of the functions during development
> gained different versions of the getters. Unify access to of_node
> and as a side change slightly refactor ACPI specific branches.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko(a)linux.intel.com>
> ---
> v3: no changes
> v2: no changes
>  drivers/base/property.c  | 29 +++++++++++++----------------
>  include/linux/property.h |  2 +-
>  2 files changed, 14 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/base/property.c b/drivers/base/property.c
> index c26370aacdc6..d0874f6c29bb 100644
> --- a/drivers/base/property.c
> +++ b/drivers/base/property.c
> @@ -759,13 +759,8 @@ EXPORT_SYMBOL_GPL(fwnode_get_next_available_child_no=
de);
>  struct fwnode_handle *device_get_next_child_node(struct device *dev,
>                                                  struct fwnode_handle *ch=
ild)
>  {
> -       struct acpi_device *adev =3D ACPI_COMPANION(dev);
> -       struct fwnode_handle *fwnode =3D NULL, *next;
> -
> -       if (dev->of_node)
> -               fwnode =3D of_fwnode_handle(dev->of_node);
> -       else if (adev)
> -               fwnode =3D acpi_fwnode_handle(adev);
> +       const struct fwnode_handle *fwnode =3D dev_fwnode(dev);
> +       struct fwnode_handle *next;
>
>         /* Try to find a child in primary fwnode */
>         next =3D fwnode_get_next_child_node(fwnode, child);
> @@ -868,28 +863,31 @@ EXPORT_SYMBOL_GPL(device_get_child_node_count);
>
>  bool device_dma_supported(struct device *dev)
>  {
> +       const struct fwnode_handle *fwnode =3D dev_fwnode(dev);
> +
>         /* For DT, this is always supported.
>          * For ACPI, this depends on CCA, which
>          * is determined by the acpi_dma_supported().
>          */
> -       if (IS_ENABLED(CONFIG_OF) && dev->of_node)
> +       if (is_of_node(fwnode))
>                 return true;
>
> -       return acpi_dma_supported(ACPI_COMPANION(dev));
> +       return acpi_dma_supported(to_acpi_device_node(fwnode));
>  }
>  EXPORT_SYMBOL_GPL(device_dma_supported);
>
>  enum dev_dma_attr device_get_dma_attr(struct device *dev)
>  {
> +       const struct fwnode_handle *fwnode =3D dev_fwnode(dev);
>         enum dev_dma_attr attr =3D DEV_DMA_NOT_SUPPORTED;
>
> -       if (IS_ENABLED(CONFIG_OF) && dev->of_node) {
> -               if (of_dma_is_coherent(dev->of_node))
> +       if (is_of_node(fwnode)) {
> +               if (of_dma_is_coherent(to_of_node(fwnode)))
>                         attr =3D DEV_DMA_COHERENT;
>                 else
>                         attr =3D DEV_DMA_NON_COHERENT;
>         } else
> -               attr =3D acpi_get_dma_attr(ACPI_COMPANION(dev));
> +               attr =3D acpi_get_dma_attr(to_acpi_device_node(fwnode));
>
>         return attr;
>  }
> @@ -1007,14 +1005,13 @@ EXPORT_SYMBOL(device_get_mac_address);
>   * Returns Linux IRQ number on success. Other values are determined
>   * accordingly to acpi_/of_ irq_get() operation.
>   */
> -int fwnode_irq_get(struct fwnode_handle *fwnode, unsigned int index)
> +int fwnode_irq_get(const struct fwnode_handle *fwnode, unsigned int inde=
x)
>  {
> -       struct device_node *of_node =3D to_of_node(fwnode);
>         struct resource res;
>         int ret;
>
> -       if (IS_ENABLED(CONFIG_OF) && of_node)
> -               return of_irq_get(of_node, index);
> +       if (is_of_node(fwnode))
> +               return of_irq_get(to_of_node(fwnode), index);
>
>         ret =3D acpi_irq_get(ACPI_HANDLE_FWNODE(fwnode), index, &res);
>         if (ret)
> diff --git a/include/linux/property.h b/include/linux/property.h
> index 0d876316e61d..073e680c35e2 100644
> --- a/include/linux/property.h
> +++ b/include/linux/property.h
> @@ -119,7 +119,7 @@ struct fwnode_handle *device_get_named_child_node(str=
uct device *dev,
>  struct fwnode_handle *fwnode_handle_get(struct fwnode_handle *fwnode);
>  void fwnode_handle_put(struct fwnode_handle *fwnode);
>
> -int fwnode_irq_get(struct fwnode_handle *fwnode, unsigned int index);
> +int fwnode_irq_get(const struct fwnode_handle *fwnode, unsigned int inde=
x);
>
>  unsigned int device_get_child_node_count(struct device *dev);
>
> --

Applied as 5.14 material along with the [1-2/3], thanks!
--===============3684469905098103959==--

