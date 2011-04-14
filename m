Content-Type: multipart/mixed; boundary="===============7650427559775288105=="
MIME-Version: 1.0
From: Jung-uk Kim <jkim at FreeBSD.org>
Subject: Re: [Devel] ACPICA version 20110413 released
Date: Thu, 14 Apr 2011 13:00:57 -0400
Message-ID: <201104141300.59473.jkim@FreeBSD.org>
In-Reply-To: 4911F71203A09E4D9981D27F9D830858D3FA3D3B@orsmsx503.amr.corp.intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============7650427559775288105==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thursday 14 April 2011 12:26 pm, Moore, Robert wrote:
> Thanks. I'll look at these changes and get back to you.
>
> As I recall, you don't use flex/bison, you use the actual lex/yacc,
> is that correct?

Actually flex originated from BSD.  yacc is real thing from BSD, of =

course. :-)

> And that is the source of some of these differences.

Understood.

> Which makefile is wrong, is it the one under generate/unix or
> generate/linux?

I guess it is from generate/unix because it's from =

acpica-unix2-20110413.tar.gz, right?

Thanks,

Jung-uk Kim

> Bob
>
> > -----Original Message-----
> > From: Jung-uk Kim [mailto:jkim(a)FreeBSD.org]
> > Sent: Wednesday, April 13, 2011 4:33 PM
> > To: devel(a)acpica.org
> > Cc: Moore, Robert
> > Subject: Re: [Devel] ACPICA version 20110413 released
> >
> >
> > iASL doesn't build on BSD any more.  Please see the attached
> > patch.
> >
> > Makefile:	Fix object dependencies and fix "clean" target.
> > dtparser.l:	Add missing EOF.
> > dtparser.y:	Declare DtParserparse() properly and fix yytname.
> >
> > Jung-uk Kim

--===============7650427559775288105==--

