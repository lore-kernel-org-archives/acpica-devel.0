Content-Type: multipart/mixed; boundary="===============1907073954411145685=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rjw at rjwysocki.net>
Subject: Re: [Devel] [pm:bleeding-edge 126/127]
 drivers/base/power/domain.c:2434:47: warning: format '%d' expects argument of
 type 'int', but argument 3 has type 'long int'
Date: Fri, 25 May 2018 12:09:58 +0200
Message-ID: <2463340.b3LbXslx6h@aspire.rjw.lan>
In-Reply-To: 20180524103315.rpo4a23h4c26fg6y@vireshk-i7
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============1907073954411145685==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thursday, May 24, 2018 12:33:15 PM CEST Viresh Kumar wrote:
> On 24-05-18, 18:25, kbuild test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git bleeding-edge
> > head:   34ae5d53ec5963e3f2967fcd12bae44decbfc4c0
> > commit: 07cebb5e726d519b7de0373ade62465c2ebdd355 [126/127] PM / domains=
: Return 0 on error from of_genpd_opp_to_performance_state()
> > config: x86_64-randconfig-x019-201820 (attached as .config)
> > compiler: gcc-7 (Debian 7.3.0-16) 7.3.0
> > reproduce:
> >         git checkout 07cebb5e726d519b7de0373ade62465c2ebdd355
> >         # save the attached .config to linux build tree
> >         make ARCH=3Dx86_64 =

> > =

> > All warnings (new ones prefixed by >>):
> > =

> >    drivers/base/power/domain.c: In function 'of_genpd_opp_to_performanc=
e_state':
> > >> drivers/base/power/domain.c:2434:47: warning: format '%d' expects ar=
gument of type 'int', but argument 3 has type 'long int' [-Wformat=3D]
> >       dev_err(dev, "Failed to find required OPP: %d\n", PTR_ERR(opp));
> >                                                  ~^     ~~~~~~~~~~~~
> >                                                  %ld
> > =

> > vim +2434 drivers/base/power/domain.c
> =

> Sent a fix for that. Thanks.

I've replaced the original with this, thanks!


--===============1907073954411145685==--

