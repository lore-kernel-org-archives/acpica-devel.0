Content-Type: multipart/mixed; boundary="===============0632434122006031163=="
MIME-Version: 1.0
From: Andy Shevchenko <andy.shevchenko at gmail.com>
Subject: [Devel] Re: [PATCH v3 07/14] software_node: Add support for
 fwnode_graph*() family of functions
Date: Thu, 24 Dec 2020 15:03:18 +0200
Message-ID: <CAHp75Ve6YHm-tdqFPvOhfJiT=uRK_dpKY3mnhQd6Mg3KkSuKqA@mail.gmail.com>
In-Reply-To: X+SPsks5itN9OFqB@pendragon.ideasonboard.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============0632434122006031163==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 24, 2020 at 2:55 PM Laurent Pinchart
<laurent.pinchart(a)ideasonboard.com> wrote:
> On Thu, Dec 24, 2020 at 02:24:12PM +0200, Andy Shevchenko wrote:
> > On Thu, Dec 24, 2020 at 3:14 AM Daniel Scally wrote:

...

> > > +               if (!strncmp(to_swnode(port)->node->name, "port@",
> >
> > You may use here corresponding _FMT macro.
> >
> > > +                            FWNODE_GRAPH_PORT_NAME_PREFIX_LEN))
> > > +                       return port;

...

> > > +       /* Ports have naming style "port(a)n", we need to select the =
n */
> >
> > > +       ret =3D kstrtou32(swnode->parent->node->name + FWNODE_GRAPH_P=
ORT_NAME_PREFIX_LEN,
> >
> > Maybe a temporary variable?
> >
> >   unsigned int prefix_len =3D FWNODE_GRAPH_PORT_NAME_PREFIX_LEN;
> >   ...
> >   ret =3D kstrtou32(swnode->parent->node->name + prefix_len,
>
> Honestly I'm wondering if those macros don't hinder readability. I'd
> rather write
>
>         + strlen("port@")

Works for me, since the compiler optimizes this away to be a plain constant.

> and let the compiler optimize this to a compile-time constant.
>
> > > +                       10, &endpoint->port);
> > > +       if (ret)
> > > +               return ret;


-- =

With Best Regards,
Andy Shevchenko
--===============0632434122006031163==--

