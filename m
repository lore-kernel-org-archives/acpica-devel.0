Content-Type: multipart/mixed; boundary="===============5324365613397948553=="
MIME-Version: 1.0
From: Andy Shevchenko <andy.shevchenko at gmail.com>
Subject: [Devel] Re: [PATCH v3 05/14] software_node: unregister software_nodes
 in reverse order
Date: Thu, 24 Dec 2020 16:12:20 +0200
Message-ID: <CAHp75VdWuowLenNPQRNc+QXeyuvwKqh_bjw=1WvmFrzoygXFRw@mail.gmail.com>
In-Reply-To: de478ef0-0b4d-df1d-2651-9cc35bf2f45b@gmail.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============5324365613397948553==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 24, 2020 at 4:00 PM Daniel Scally <djrscally(a)gmail.com> wrote:
> On 24/12/2020 12:13, Andy Shevchenko wrote:
> > On Thu, Dec 24, 2020 at 3:12 AM Daniel Scally <djrscally(a)gmail.com> w=
rote:

...

> >> + * Unregister multiple software nodes at once. The array will be unwo=
und in
> >> + * reverse order (i.e. last entry first) and thus if any member of th=
e array
> >> + * has its .parent member set then they should appear later in the ar=
ray such
> >> + * that they are unregistered first.
> >
> > I'm, as being not a native speaker, a bit confused by this comment.
> > The idea is that children are unregistered first. Can you try to make
> > it more clear maybe?
>
> Sure, how about:
>
> The array will be unwound in reverse order (i.e. last entry first). If
> any member of the array is a child of another member then the child must

children ?

> appear later in the array than their parent, so that they are
> unregistered first.

I think with the above change it will be better, yes.

-- =

With Best Regards,
Andy Shevchenko
--===============5324365613397948553==--

