Content-Type: multipart/mixed; boundary="===============2528965438411064632=="
MIME-Version: 1.0
From: Jung-uk Kim <jkim at FreeBSD.org>
Subject: Re: [Devel] ACPICA version 20130927 released
Date: Mon, 30 Sep 2013 13:40:18 -0400
Message-ID: <5249B782.3090506@FreeBSD.org>
In-Reply-To: 5249B0B9.4050905@FreeBSD.org
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============2528965438411064632==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 2013-09-30 13:11:21 -0400, Jung-uk Kim wrote:
> On 2013-09-27 12:59:34 -0400, Robert Moore wrote:
>> 27 September 2013. Summary of changes for version 20130927:
> ... Unfortunately, there are two regressions with the release.
> First, the release tarballs are missing Makefile.config:
> =

> % tar tfv acpica-unix-20130927.tar.gz | grep
> generate/unix/Makefile -rw-r--r--  0 rmoore1 Domain Users    543  9
> 27 12:18 acpica-unix-20130927/generate/unix/Makefile -rw-r--r--  0
> rmoore1 Domain Users   2057  9 27 12:18 =

> acpica-unix-20130927/generate/unix/Makefile.common -rw-r--r--  0
> rmoore1 Domain Users    519  9 27 12:18 =

> acpica-unix-20130927/generate/unix/Makefile.rules % tar tfv
> acpica-unix2-20130927.tar.gz | grep generate/unix/Makefile =

> -rw-r--r--  0 rmoore1 Domain Users    543  9 27 12:18 =

> acpica-unix2-20130927/generate/unix/Makefile -rw-r--r--  0 rmoore1
> Domain Users   2057  9 27 12:18 =

> acpica-unix2-20130927/generate/unix/Makefile.common -rw-r--r--  0
> rmoore1 Domain Users    519  9 27 12:18 =

> acpica-unix2-20130927/generate/unix/Makefile.rules
> =

> Even after adding the file from github, I realized this release
> does not support traditional yacc any more and now it only builds
> with GNU bison since this commit:
> =

> https://github.com/acpica/acpica/commit/d8a0e964

BTW, FreeBSD had a similar problem in the past and we worked around it
like this:

http://svnweb.freebsd.org/changeset/base/232676

I am sure GNU make gurus should be able to do something similar
without breaking yacc support. ;-)

Jung-uk Kim
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (FreeBSD)

iQEcBAEBAgAGBQJSSbeCAAoJEHyflib82/FGqiIH/RullH+KMkBKsQ3u8efR0TbV
hf8CW37fQH6CNLVZnBRT7o6Jgv+ot4ChZA+Rj6nLmHWc2jHr6b+JsKjLFENW7o9V
I+4NAFvEpl1sJFMkw6IczTFS1kmiuaB3eNyLK9bGKqS9clku9mT6vjMP6uTc+arn
aze9Sa8f5stLRjjg3A/DKVAztATTT7Dsb2m1OGgILPdZju03PNe8U1DhF1LyzmYw
0IJS10U6rJe4CFTeIz2LKyc8mfTe1CE2Sao7pWqFRgHqf9bOcl6Wbd4gCkCQpPsT
Fa0voEiLexD3yuUdwihfRWuhQy14UNaa8Nw1FpA6skQ+H70zExsdBMQyQmjGsSg=3D
=3Dv2xf
-----END PGP SIGNATURE-----

--===============2528965438411064632==--

