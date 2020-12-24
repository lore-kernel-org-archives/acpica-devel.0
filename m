Content-Type: multipart/mixed; boundary="===============8713795515440990522=="
MIME-Version: 1.0
From: Andy Shevchenko <andy.shevchenko at gmail.com>
Subject: [Devel] Re: [PATCH v3 05/14] software_node: unregister software_nodes
 in reverse order
Date: Thu, 24 Dec 2020 14:13:13 +0200
Message-ID: <CAHp75VdF5NdjrSxcOafh7KNNDteYEUDk9otA0HKX-iks7G0D4g@mail.gmail.com>
In-Reply-To: 20201224010907.263125-6-djrscally@gmail.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============8713795515440990522==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 24, 2020 at 3:12 AM Daniel Scally <djrscally(a)gmail.com> wrote:
>
> To maintain consistency with software_node_unregister_nodes(), reverse
> the order in which the software_node_unregister_node_group() function
> unregisters nodes.

...

> - * Unregister multiple software nodes at once.
> + * Unregister multiple software nodes at once. The array will be unwound=
 in
> + * reverse order (i.e. last entry first) and thus if any member of the a=
rray
> + * has its .parent member set then they should appear later in the array=
 such
> + * that they are unregistered first.

I'm, as being not a native speaker, a bit confused by this comment.
The idea is that children are unregistered first. Can you try to make
it more clear maybe?

>   */


-- =

With Best Regards,
Andy Shevchenko
--===============8713795515440990522==--

