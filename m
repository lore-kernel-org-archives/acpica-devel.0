Content-Type: multipart/mixed; boundary="===============4323873875297084728=="
MIME-Version: 1.0
From: Zheng, Lv <lv.zheng at intel.com>
Subject: Re: [Devel] ACPICA version 20130927 released
Date: Mon, 30 Sep 2013 22:28:56 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E8802467765@SHSMSX101.ccr.corp.intel.com>
In-Reply-To: 5249B0B9.4050905@FreeBSD.org
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============4323873875297084728==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

OK, the regression is introduced by my commit.
I can take a look at this issue.
Could you send me the version and usage of yacc you are using.
It is better that you can post "yacc -v" and "yacc -h" for me.

Thanks and best regards
-Lv

> -----Original Message-----
> From: devel-bounces(a)acpica.org [mailto:devel-bounces(a)acpica.org] On B=
ehalf Of Jung-uk Kim
> Sent: Tuesday, October 01, 2013 1:11 AM
> To: Moore, Robert; devel(a)acpica.org
> Subject: Re: [Devel] ACPICA version 20130927 released
> =

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> =

> On 2013-09-27 12:59:34 -0400, Robert Moore wrote:
> > 27 September 2013. Summary of changes for version 20130927:
> ...
> Unfortunately, there are two regressions with the release.  First, the
> release tarballs are missing Makefile.config:
> =

> % tar tfv acpica-unix-20130927.tar.gz | grep generate/unix/Makefile
> - -rw-r--r--  0 rmoore1 Domain Users    543  9 27 12:18
> acpica-unix-20130927/generate/unix/Makefile
> - -rw-r--r--  0 rmoore1 Domain Users   2057  9 27 12:18
> acpica-unix-20130927/generate/unix/Makefile.common
> - -rw-r--r--  0 rmoore1 Domain Users    519  9 27 12:18
> acpica-unix-20130927/generate/unix/Makefile.rules
> % tar tfv acpica-unix2-20130927.tar.gz | grep generate/unix/Makefile
> - -rw-r--r--  0 rmoore1 Domain Users    543  9 27 12:18
> acpica-unix2-20130927/generate/unix/Makefile
> - -rw-r--r--  0 rmoore1 Domain Users   2057  9 27 12:18
> acpica-unix2-20130927/generate/unix/Makefile.common
> - -rw-r--r--  0 rmoore1 Domain Users    519  9 27 12:18
> acpica-unix2-20130927/generate/unix/Makefile.rules
> =

> Even after adding the file from github, I realized this release does
> not support traditional yacc any more and now it only builds with GNU
> bison since this commit:
> =

> https://github.com/acpica/acpica/commit/d8a0e964
> =

> Jung-uk Kim
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v2.0.21 (FreeBSD)
> =

> iQEcBAEBAgAGBQJSSbC4AAoJEHyflib82/FGuKYH/jmdm/vsgq2svgHIrIzJBK7R
> GDkHtJjpNNGXIh7+OGndoodQCIesyXPfd1NOKYIww8S8ScO80vAJ0eK/qx2dkJUU
> ZPtgiAgZkgU/S413OXIa6FDd1sdV1gOMOiIEIc6NeCgyOr+L3pxzVsrN2/KNgymH
> 8XnRtP7svnNatrpv8bWl48PX1VT2Vxe6ZlXJSh7jbz0YG5cAqQ+ycnKiZBmpHtId
> v92aDFKbbqXg8nOYJcpqFCsxr+dlQtcUxPLfYyzo0q1jK4kTRjGsus1eDk6BEJuP
> u9TpyRV9V9wj3s/G5JPV4sFJpeoOHXLqoavHypipima8fherg8ATBDP240juiM4=3D
> =3DSGYi
> -----END PGP SIGNATURE-----
> _______________________________________________
> Devel mailing list
> Devel(a)acpica.org
> https://lists.acpica.org/mailman/listinfo/devel

--===============4323873875297084728==--

