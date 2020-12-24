Content-Type: multipart/mixed; boundary="===============7992575473152728354=="
MIME-Version: 1.0
From: Andy Shevchenko <andy.shevchenko at gmail.com>
Subject: [Devel] Re: [PATCH v3 07/14] software_node: Add support for
 fwnode_graph*() family of functions
Date: Thu, 24 Dec 2020 14:24:12 +0200
Message-ID: <CAHp75Vft7gg1AcKCEU+E74eB_ZMouHFd-8uZ7pcVj5CoJzZpvQ@mail.gmail.com>
In-Reply-To: 20201224010907.263125-8-djrscally@gmail.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============7992575473152728354==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 24, 2020 at 3:14 AM Daniel Scally <djrscally(a)gmail.com> wrote:
>
> From: Heikki Krogerus <heikki.krogerus(a)linux.intel.com>
>
> This implements the remaining .graph_* callbacks in the

.graph_* =3D=3D> ->graph_*() ?

> fwnode operations structure for the software nodes. That makes
> the fwnode_graph*() functions available in the drivers also

graph*() -> graph_*() ?

> when software nodes are used.
>
> The implementation tries to mimic the "OF graph" as much as
> possible, but there is no support for the "reg" device
> property. The ports will need to have the index in their
> name which starts with "port@" (for example "port(a)0", "port(a)1",

> ...)

Looks not good, perhaps move to the previous line, or move port(a)1 example=
 here?

> and endpoints will use the index of the software node
> that is given to them during creation. The port nodes can
> also be grouped under a specially named "ports" subnode,
> just like in DT, if necessary.
>
> The remote-endpoints are reference properties under the
> endpoint nodes that are named "remote-endpoint".

Few nitpicks here and there, after addressing them,
Reviewed-by: Andy Shevchenko <andy.shevchenko(a)gmail.com>

> Signed-off-by: Heikki Krogerus <heikki.krogerus(a)linux.intel.com>
> Co-developed-by: Daniel Scally <djrscally(a)gmail.com>
> Signed-off-by: Daniel Scally <djrscally(a)gmail.com>
> ---
> Changes in v3
>         - Changed software_node_get_next_endpoint() to drop the variable
>         named "old"
>         - Used the macros defined in 06/14 instead of magic numbers
>         - Added some comments to explain behaviour a little where it's un=
clear
>
>  drivers/base/swnode.c | 112 +++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 111 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
> index 2d07eb04c6c8..ff690029060d 100644
> --- a/drivers/base/swnode.c
> +++ b/drivers/base/swnode.c
> @@ -540,6 +540,112 @@ software_node_get_reference_args(const struct fwnod=
e_handle *fwnode,
>         return 0;
>  }
>
> +static struct fwnode_handle *
> +swnode_graph_find_next_port(const struct fwnode_handle *parent,
> +                           struct fwnode_handle *port)
> +{
> +       struct fwnode_handle *old =3D port;
> +
> +       while ((port =3D software_node_get_next_child(parent, old))) {
> +               /*
> +                * ports have naming style "port(a)n", so we search for c=
hildren
> +                * that follow that convention (but without assuming anyt=
hing
> +                * about the index number)
> +                */

> +               if (!strncmp(to_swnode(port)->node->name, "port@",

You may use here corresponding _FMT macro.

> +                            FWNODE_GRAPH_PORT_NAME_PREFIX_LEN))
> +                       return port;
> +               old =3D port;
> +       }
> +
> +       return NULL;
> +}
> +
> +static struct fwnode_handle *
> +software_node_graph_get_next_endpoint(const struct fwnode_handle *fwnode,
> +                                     struct fwnode_handle *endpoint)
> +{
> +       struct swnode *swnode =3D to_swnode(fwnode);
> +       struct fwnode_handle *parent;
> +       struct fwnode_handle *port;
> +
> +       if (!swnode)
> +               return NULL;
> +
> +       if (endpoint) {
> +               port =3D software_node_get_parent(endpoint);
> +               parent =3D software_node_get_parent(port);
> +       } else {
> +               parent =3D software_node_get_named_child_node(fwnode, "po=
rts");
> +               if (!parent)
> +                       parent =3D software_node_get(&swnode->fwnode);
> +
> +               port =3D swnode_graph_find_next_port(parent, NULL);
> +       }
> +
> +       for (; port; port =3D swnode_graph_find_next_port(parent, port)) {
> +               endpoint =3D software_node_get_next_child(port, endpoint);
> +               if (endpoint) {
> +                       fwnode_handle_put(port);
> +                       break;
> +               }
> +       }
> +
> +       fwnode_handle_put(parent);
> +
> +       return endpoint;
> +}
> +
> +static struct fwnode_handle *
> +software_node_graph_get_remote_endpoint(const struct fwnode_handle *fwno=
de)
> +{
> +       struct swnode *swnode =3D to_swnode(fwnode);
> +       const struct software_node_ref_args *ref;
> +       const struct property_entry *prop;
> +
> +       if (!swnode)
> +               return NULL;
> +
> +       prop =3D property_entry_get(swnode->node->properties, "remote-end=
point");
> +       if (!prop || prop->type !=3D DEV_PROP_REF || prop->is_inline)
> +               return NULL;
> +
> +       ref =3D prop->pointer;
> +
> +       return software_node_get(software_node_fwnode(ref[0].node));
> +}
> +
> +static struct fwnode_handle *
> +software_node_graph_get_port_parent(struct fwnode_handle *fwnode)
> +{
> +       struct swnode *swnode =3D to_swnode(fwnode);
> +
> +       swnode =3D swnode->parent;
> +       if (swnode && !strcmp(swnode->node->name, "ports"))
> +               swnode =3D swnode->parent;
> +
> +       return swnode ? software_node_get(&swnode->fwnode) : NULL;
> +}
> +
> +static int
> +software_node_graph_parse_endpoint(const struct fwnode_handle *fwnode,
> +                                  struct fwnode_endpoint *endpoint)
> +{
> +       struct swnode *swnode =3D to_swnode(fwnode);
> +       int ret;
> +
> +       /* Ports have naming style "port(a)n", we need to select the n */

> +       ret =3D kstrtou32(swnode->parent->node->name + FWNODE_GRAPH_PORT_=
NAME_PREFIX_LEN,

Maybe a temporary variable?

  unsigned int prefix_len =3D FWNODE_GRAPH_PORT_NAME_PREFIX_LEN;
  ...
  ret =3D kstrtou32(swnode->parent->node->name + prefix_len,


> +                       10, &endpoint->port);
> +       if (ret)
> +               return ret;
> +
> +       endpoint->id =3D swnode->id;
> +       endpoint->local_fwnode =3D fwnode;
> +
> +       return 0;
> +}
> +
>  static const struct fwnode_operations software_node_ops =3D {
>         .get =3D software_node_get,
>         .put =3D software_node_put,
> @@ -551,7 +657,11 @@ static const struct fwnode_operations software_node_=
ops =3D {
>         .get_parent =3D software_node_get_parent,
>         .get_next_child_node =3D software_node_get_next_child,
>         .get_named_child_node =3D software_node_get_named_child_node,
> -       .get_reference_args =3D software_node_get_reference_args
> +       .get_reference_args =3D software_node_get_reference_args,
> +       .graph_get_next_endpoint =3D software_node_graph_get_next_endpoin=
t,
> +       .graph_get_remote_endpoint =3D software_node_graph_get_remote_end=
point,
> +       .graph_get_port_parent =3D software_node_graph_get_port_parent,
> +       .graph_parse_endpoint =3D software_node_graph_parse_endpoint,
>  };
>
>  /* ---------------------------------------------------------------------=
----- */
> --
> 2.25.1
>


-- =

With Best Regards,
Andy Shevchenko
--===============7992575473152728354==--

