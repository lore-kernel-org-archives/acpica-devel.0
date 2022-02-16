Content-Type: multipart/mixed; boundary="===============3937404401180100739=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: [Devel] Re: [PATCH][next] treewide: Replace zero-length arrays with
 flexible-array members
Date: Wed, 16 Feb 2022 20:05:47 +0100
Message-ID: <CAJZ5v0jpAnQk+Hub6ue6t712RW+W0YBjb_gAcZZbUeuYMGv7mg@mail.gmail.com>
In-Reply-To: 20220215193221.GA884407@embeddedor
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============3937404401180100739==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 15, 2022 at 8:24 PM Gustavo A. R. Silva
<gustavoars(a)kernel.org> wrote:
>
> On Tue, Feb 15, 2022 at 09:19:29PM +0200, Leon Romanovsky wrote:
> > On Tue, Feb 15, 2022 at 01:21:10PM -0600, Gustavo A. R. Silva wrote:
> > > On Tue, Feb 15, 2022 at 10:17:40AM -0800, Kees Cook wrote:
> > > > On Tue, Feb 15, 2022 at 11:47:43AM -0600, Gustavo A. R. Silva wrote:
> > > >
> > > > These all look trivially correct to me. Only two didn't have the en=
d of
> > > > the struct visible in the patch, and checking those showed them to =
be
> > > > trailing members as well, so:
> > > >
> > > > Reviewed-by: Kees Cook <keescook(a)chromium.org>
> > >
> > > I'll add this to my -next tree.
> >
> > I would like to ask you to send mlx5 patch separately to netdev. We are=
 working
> > to delete that file completely and prefer to avoid from unnecessary mer=
ge conflicts.
>
> Oh OK. Sure thing; I will do so.

Can you also send the ACPI patch separately, please?

We would like to route it through the upstream ACPICA code base.
--===============3937404401180100739==--

