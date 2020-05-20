Content-Type: multipart/mixed; boundary="===============8154896770188766737=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: [Devel] Re: [PATCH] ACPICA: Replace one-element array and use
 struct_size() helper
Date: Wed, 20 May 2020 11:15:18 +0200
Message-ID: <CAJZ5v0jg9HoE2KEm45hxKNB1g61DzCn-GWH74w1goeHH3AKRaA@mail.gmail.com>
In-Reply-To: 20200519225058.GA14138@embeddedor
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============8154896770188766737==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, May 20, 2020 at 12:46 AM Gustavo A. R. Silva
<gustavoars(a)kernel.org> wrote:
>
> On Tue, May 19, 2020 at 12:25:13PM +0200, Rafael J. Wysocki wrote:
> > On Tue, May 19, 2020 at 12:22 AM Gustavo A. R. Silva
> > <gustavoars(a)kernel.org> wrote:
> > >
> > > The current codebase makes use of one-element arrays in the following
> > > form:
> > >
> > > struct something {
> > >     int length;
> > >     u8 data[1];
> > > };
> > >
> > > struct something *instance;
> > >
> > > instance =3D kmalloc(sizeof(*instance) + size, GFP_KERNEL);
> > > instance->length =3D size;
> > > memcpy(instance->data, source, size);
> > >
> > > but the preferred mechanism to declare variable-length types such as
> > > these ones is a flexible array member[1][2], introduced in C99:
> > >
> > > struct foo {
> > >         int stuff;
> > >         struct boo array[];
> > > };
> > >
> > > By making use of the mechanism above, we will get a compiler warning
> > > in case the flexible array does not occur last in the structure, which
> > > will help us prevent some kind of undefined behavior bugs from being
> > > inadvertently introduced[3] to the codebase from now on.
> >
> > However, the ACPICA code in the kernel comes from an external project
> > and changes of this type are generally not applicable to it unless
> > accepted upstream.
>
> Hi Rafael,
>
> By _accepted upstream_, in this case, you mean the adoption of the
> flexible-arrays in the whole codebase, first?

I meant whether or not the patch is accepted by the ACPICA upstream.

>  If this is the case
> notice that there are hundreds of these flexible-array conversions
> in mainline, already:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/log/?q=
t=3Dgrep&q=3Dflexible-array
>
> Is this what you mean?

I'm not actually sure what you mean here.
--===============8154896770188766737==--

