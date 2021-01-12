Content-Type: multipart/mixed; boundary="===============6958966671250232389=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: [Devel] Re: [PATCH v5 07/15] device property: Define format macros
 for ports and endpoints
Date: Tue, 12 Jan 2021 20:29:46 +0100
Message-ID: <CAJZ5v0gzRvNwciDRa2CmnimaXwShzvouTK7_mNx9QGcwXe+v+A@mail.gmail.com>
In-Reply-To: 20210107132838.396641-8-djrscally@gmail.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============6958966671250232389==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 7, 2021 at 2:31 PM Daniel Scally <djrscally(a)gmail.com> wrote:
>
> OF, ACPI and software_nodes all implement graphs including nodes for ports
> and endpoints. These are all intended to be named with a common schema,
> as "port(a)n" and "endpoint(a)n" where n is an unsigned int representing =
the
> index of the node. To ensure commonality across the subsystems, provide a
> set of macros to define the format.
>
> Suggested-by: Andy Shevchenko <andriy.shevchenko(a)linux.intel.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko(a)gmail.com>
> Reviewed-by: Laurent Pinchart <laurent.pinchart(a)ideasonboard.com>
> Signed-off-by: Daniel Scally <djrscally(a)gmail.com>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki(a)intel.com>

> ---
> Changes in v5:
>
>         - Changed commit subject
>
>  include/linux/fwnode.h | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
> index fde4ad97564c..77414e431e89 100644
> --- a/include/linux/fwnode.h
> +++ b/include/linux/fwnode.h
> @@ -50,6 +50,13 @@ struct fwnode_endpoint {
>         const struct fwnode_handle *local_fwnode;
>  };
>
> +/*
> + * ports and endpoints defined as software_nodes should all follow a com=
mon
> + * naming scheme; use these macros to ensure commonality.
> + */
> +#define SWNODE_GRAPH_PORT_NAME_FMT             "port@%u"
> +#define SWNODE_GRAPH_ENDPOINT_NAME_FMT         "endpoint@%u"
> +
>  #define NR_FWNODE_REFERENCE_ARGS       8
>
>  /**
> --
> 2.25.1
>
--===============6958966671250232389==--

