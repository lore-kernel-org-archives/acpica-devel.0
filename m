Content-Type: multipart/mixed; boundary="===============0035427156582190239=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: Re: [Devel] [RFC] proposed patch for some segfaults encountered
Date: Tue, 02 Jun 2015 19:06:15 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37D2F1418@ORSMSX112.amr.corp.intel.com>
In-Reply-To: 556DDE3E.2070107@redhat.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============0035427156582190239==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

I'll need to disassemble with the DSDT and all SSDTs.

Do you have an acpidump for the machine? Otherwise, the binary files will b=
e ok.

There are a lot of externals to other tables, and this may be a part of the=
 problem.


> -----Original Message-----
> From: Moore, Robert
> Sent: Tuesday, June 02, 2015 11:55 AM
> To: 'Al Stone'; devel(a)acpica.org
> Subject: RE: [Devel] [RFC] proposed patch for some segfaults encountered
> =

> Ok, I've been able to reproduce the problem. I'll let you know how things
> progress.
> Bob
> =

> =

> > -----Original Message-----
> > From: Al Stone [mailto:ahs3(a)redhat.com]
> > Sent: Tuesday, June 02, 2015 9:48 AM
> > To: Moore, Robert; devel(a)acpica.org
> > Subject: Re: [Devel] [RFC] proposed patch for some segfaults encountered
> >
> > On 06/02/2015 10:26 AM, Moore, Robert wrote:
> > > Please send the ssdt9.dat file, it wasn't attached.
> > > Bob
> > >
> >
> > Ooops.  Sorry about that.
> >
> > --
> > ciao,
> > al
> > -----------------------------------
> > Al Stone
> > Software Engineer
> > Red Hat, Inc.
> > ahs3(a)redhat.com
> > -----------------------------------

--===============0035427156582190239==--

