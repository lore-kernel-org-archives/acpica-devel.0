Content-Type: multipart/mixed; boundary="===============0153955466609943089=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: Re: [Devel] ACPICA version 20110413 released
Date: Thu, 14 Apr 2011 09:26:10 -0700
Message-ID: <4911F71203A09E4D9981D27F9D830858D3FA3D3B@orsmsx503.amr.corp.intel.com>
In-Reply-To: 201104131932.59163.jkim@FreeBSD.org
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============0153955466609943089==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Thanks. I'll look at these changes and get back to you.

As I recall, you don't use flex/bison, you use the actual lex/yacc, is that=
 correct? And that is the source of some of these differences.

Which makefile is wrong, is it the one under generate/unix or generate/linu=
x?

Bob


> -----Original Message-----
> From: Jung-uk Kim [mailto:jkim(a)FreeBSD.org]
> Sent: Wednesday, April 13, 2011 4:33 PM
> To: devel(a)acpica.org
> Cc: Moore, Robert
> Subject: Re: [Devel] ACPICA version 20110413 released
> =

> =

> iASL doesn't build on BSD any more.  Please see the attached patch.
> =

> Makefile:	Fix object dependencies and fix "clean" target.
> dtparser.l:	Add missing EOF.
> dtparser.y:	Declare DtParserparse() properly and fix yytname.
> =

> Jung-uk Kim

--===============0153955466609943089==--

