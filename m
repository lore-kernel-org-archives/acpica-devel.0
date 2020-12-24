Content-Type: multipart/mixed; boundary="===============4605073722079882306=="
MIME-Version: 1.0
From: Andy Shevchenko <andy.shevchenko at gmail.com>
Subject: [Devel] Re: [PATCH v3 06/14] include: fwnode.h: Define format macros
 for ports and endpoints
Date: Thu, 24 Dec 2020 14:17:07 +0200
Message-ID: <CAHp75Ve8YRygEn3wcbmnSPthG+R_-9hhkAdMLk7jgiPi=jnJ5Q@mail.gmail.com>
In-Reply-To: 20201224010907.263125-7-djrscally@gmail.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============4605073722079882306==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 24, 2020 at 3:12 AM Daniel Scally <djrscally(a)gmail.com> wrote:
>
> OF, ACPI and software_nodes all implement graphs including nodes for ports
> and endpoints. These are all intended to be named with a common schema,
> as "port(a)n" and "endpoint(a)n" where n is an unsigned int representing =
the
> index of the node. To ensure commonality across the subsystems, provide a
> set of macros to define the format.

Nitpicks below, but in general that's what I meant, thanks!

Reviewed-by: Andy Shevchenko <andy.shevchenko(a)gmail.com>
(after addressing nitpicks)

> Suggested-by: Andy Shevchenko <andriy.shevchenko(a)linux.intel.com>
> Signed-off-by: Daniel Scally <djrscally(a)gmail.com>
> ---
> Changes in v3
>         - Patch introduced
>
>  include/linux/fwnode.h | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
> index 9506f8ec0974..52889efceb7d 100644
> --- a/include/linux/fwnode.h
> +++ b/include/linux/fwnode.h
> @@ -32,6 +32,19 @@ struct fwnode_endpoint {
>         const struct fwnode_handle *local_fwnode;
>  };
>
> +/*
> + * ports and endpoints defined in OF, ACPI and as software_nodes should =
all
> + * follow a common naming scheme; use these macros to ensure commonality=
 across
> + * the subsystems.
> + *
> + * The *PREFIX_LEN macros refer to the length of the "port@" and "endpoi=
nt@"

*PREFIX_LEN -> *_PREFIX_LEN

> + * sections of the naming scheme.
> + */
> +#define FWNODE_GRAPH_PORT_NAME_FORMAT          "port@%u"
> +#define FWNODE_GRAPH_PORT_NAME_PREFIX_LEN      5
> +#define FWNODE_GRAPH_ENDPOINT_NAME_FORMAT      "endpoint@%u"
> +#define FWNODE_GRAPH_ENDPOINT_PREFIX_LEN       9

_FORMAT -> _FMT (however, V4L2 guys may correct me, because IIRC _FMT
suffix is also used for other things in v4l2.

>  #define NR_FWNODE_REFERENCE_ARGS       8
>
>  /**

-- =

With Best Regards,
Andy Shevchenko
--===============4605073722079882306==--

