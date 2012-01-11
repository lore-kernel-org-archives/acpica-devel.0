Content-Type: multipart/mixed; boundary="===============4499307938294724804=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: Re: [Devel] one question about the release package and source repo
Date: Wed, 11 Jan 2012 22:33:56 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E3256D0869@ORSMSX101.amr.corp.intel.com>
In-Reply-To: CAHceRrgRHhFFB40pn7HbzgmYU3J0Gu=mqYVZ6zg3riUahmuzPw@mail.gmail.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============4499307938294724804==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

I guess I don't fully understand the question. Yes, the unix "packages" and=
 the git tree are different. The unix packages flatten out the directory tr=
ee somewhat. This is sortof a "legacy" thing for ACPICA and this flattening=
 is apparently no longer needed.

We intend to change the unix packages to reflect the git structure sometime=
 early this year, unless there are major objections.

Bob


> -----Original Message-----
> From: Moore, Robert
> Sent: Wednesday, January 11, 2012 12:55 PM
> To: 'Liang Qi'; devel(a)acpica.org
> Subject: RE: [Devel] one question about the release package and source
> repo
> =

> You can just download the source package from acpica.org.
> =

> However, the actual scripts are in generate/release.
> =

> Bob
> =

> =

> > -----Original Message-----
> > From: devel-bounces(a)acpica.org [mailto:devel-bounces(a)acpica.org] On
> > Behalf Of Liang Qi
> > Sent: Wednesday, January 11, 2012 12:49 PM
> > To: devel(a)acpica.org
> > Subject: [Devel] one question about the release package and source
> repo
> >
> > Hi,
> >
> > I have a clone of acpica git repo, and downloaded the latest 20120111
> > package, find out they are very different. Could you let me know
> where
> > I could find the release scripts which could generate the release
> > package from source repo? Thanks.
> >
> > Regards,
> > Liang
> >
> > --
> > http://www.qiliang.net
> > _______________________________________________
> > Devel mailing list
> > Devel(a)acpica.org
> > http://lists.acpica.org/listinfo/devel

--===============4499307938294724804==--

