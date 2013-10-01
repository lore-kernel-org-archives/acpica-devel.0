Content-Type: multipart/mixed; boundary="===============5173309039657747901=="
MIME-Version: 1.0
From: Zheng, Lv <lv.zheng at intel.com>
Subject: Re: [Devel] ACPICA version 20130927 released
Date: Tue, 01 Oct 2013 22:42:21 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E8802467AB8@SHSMSX101.ccr.corp.intel.com>
In-Reply-To: 524B138D.8070702@FreeBSD.org
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============5173309039657747901==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

> From: Jung-uk Kim [mailto:jkim(a)FreeBSD.org]
> Sent: Wednesday, October 02, 2013 2:25 AM
> =

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> =

> On 2013-09-30 18:50:21 -0400, Lv Zheng wrote:
> > Hi, Kim
> >
> > I took a look at the Makefile you are using. It seems the problem
> > is that the "--defines" is not supported by the traditional yacc. I
> > can see you are using .ORDER and empty touch to solve issues that
> > can be solved by --defines.
> >
> > So my question is: 1. Shall we still support traditional yacc?
> =

> We tried hard not to break POSIX Yacc support for maximum
> compatibility.  In fact, I believe all *.y files were written for
> POSIX Yacc and '-y' option was used for Bison to emulate POSIX Yacc.
> GNU did not take over the world yet. ;-)
> =


Let Bob determine this.

> > 2. Are there any better way other than using the ugly empty
> > "touch"?
> =

> I don't know if there's any easy way, unfortunately.
> =

> BTW, "-o/dev/null --defines=3D..." looks more hackish to my eyes but it
> may be just me. :-p
> =


:-) If POSIX yacc is going to be supported, I'll try again based on your id=
ea.
Thanks for the report.

Cheers
-Lv

> Jung-uk Kim
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v2.0.21 (FreeBSD)
> =

> iQEcBAEBAgAGBQJSSxOMAAoJEHyflib82/FGEacH+wfPhh+HNvt448L0W0tRd329
> 5RABk2PgK0ijWhsxEszz92bAIGqs4NXhpR44l8D4grfWaIYVWpGXjeVi0T/uz7Ca
> oVu+U9yDHCBJcmftWe13Qg++oaujWZcpaSPC5vvc+mlbhcl+91ldk2cJ7ImAhN2E
> PBwmikGuy+iioeZTbY+d7sZEMX55d0ZmXpR4PVT1udPwSq0PkLnRsT6GO+3vXamx
> RKaq35U/aQFelyRfFA3d63pHOdA+tACsBNpuR/em/hQHYJwNTm7xY+vmy+rI5y2S
> YJ6i7fh5mgfq8fUINq6Kpn12sKAhRi3L9U7Mfu0+pT1Qw3TQl0hd1qYhhsBk1UE=3D
> =3DCVe9
> -----END PGP SIGNATURE-----

--===============5173309039657747901==--

