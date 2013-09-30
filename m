Content-Type: multipart/mixed; boundary="===============4185995368095755397=="
MIME-Version: 1.0
From: Jung-uk Kim <jkim at FreeBSD.org>
Subject: Re: [Devel] ACPICA version 20130927 released
Date: Mon, 30 Sep 2013 13:11:21 -0400
Message-ID: <5249B0B9.4050905@FreeBSD.org>
In-Reply-To: 94F2FBAB4432B54E8AACC7DFDE6C92E36FF11F71@ORSMSX103.amr.corp.intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============4185995368095755397==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 2013-09-27 12:59:34 -0400, Robert Moore wrote:
> 27 September 2013. Summary of changes for version 20130927:
...
Unfortunately, there are two regressions with the release.  First, the
release tarballs are missing Makefile.config:

% tar tfv acpica-unix-20130927.tar.gz | grep generate/unix/Makefile
- -rw-r--r--  0 rmoore1 Domain Users    543  9 27 12:18
acpica-unix-20130927/generate/unix/Makefile
- -rw-r--r--  0 rmoore1 Domain Users   2057  9 27 12:18
acpica-unix-20130927/generate/unix/Makefile.common
- -rw-r--r--  0 rmoore1 Domain Users    519  9 27 12:18
acpica-unix-20130927/generate/unix/Makefile.rules
% tar tfv acpica-unix2-20130927.tar.gz | grep generate/unix/Makefile
- -rw-r--r--  0 rmoore1 Domain Users    543  9 27 12:18
acpica-unix2-20130927/generate/unix/Makefile
- -rw-r--r--  0 rmoore1 Domain Users   2057  9 27 12:18
acpica-unix2-20130927/generate/unix/Makefile.common
- -rw-r--r--  0 rmoore1 Domain Users    519  9 27 12:18
acpica-unix2-20130927/generate/unix/Makefile.rules

Even after adding the file from github, I realized this release does
not support traditional yacc any more and now it only builds with GNU
bison since this commit:

https://github.com/acpica/acpica/commit/d8a0e964

Jung-uk Kim
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (FreeBSD)

iQEcBAEBAgAGBQJSSbC4AAoJEHyflib82/FGuKYH/jmdm/vsgq2svgHIrIzJBK7R
GDkHtJjpNNGXIh7+OGndoodQCIesyXPfd1NOKYIww8S8ScO80vAJ0eK/qx2dkJUU
ZPtgiAgZkgU/S413OXIa6FDd1sdV1gOMOiIEIc6NeCgyOr+L3pxzVsrN2/KNgymH
8XnRtP7svnNatrpv8bWl48PX1VT2Vxe6ZlXJSh7jbz0YG5cAqQ+ycnKiZBmpHtId
v92aDFKbbqXg8nOYJcpqFCsxr+dlQtcUxPLfYyzo0q1jK4kTRjGsus1eDk6BEJuP
u9TpyRV9V9wj3s/G5JPV4sFJpeoOHXLqoavHypipima8fherg8ATBDP240juiM4=3D
=3DSGYi
-----END PGP SIGNATURE-----

--===============4185995368095755397==--

