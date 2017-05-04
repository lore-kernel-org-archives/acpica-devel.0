Content-Type: multipart/mixed; boundary="===============7554616336738789769=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: Re: [Devel] [PATCH] Remove redundant assignment to NamepathOffset
Date: Thu, 04 May 2017 14:50:45 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37E597C7D@ORSMSX110.amr.corp.intel.com>
In-Reply-To: 7a341ec8-9336-0b3a-f6be-6262e366da79@canonical.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============7554616336738789769==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

These all look good. (NamePathOffset and ObjectType changes)

Make one or two pull requests if you'd like.
Thanks,
Bob


> -----Original Message-----
> From: Devel [mailto:devel-bounces(a)acpica.org] On Behalf Of Colin Ian
> King
> Sent: Wednesday, May 3, 2017 6:56 AM
> To: devel(a)acpica.org
> Subject: Re: [Devel] [PATCH] Remove redundant assignment to
> NamepathOffset
> =

> On 18/04/17 22:30, Colin King wrote:
> > From: Colin Ian King <colin.king(a)canonical.com>
> >
> > NamepathOffset is being assigned and not used and the a few statements
> > later it is being re-assigned, hence the earlier assignment is
> > redundant and can be removed.  Remove it.
> >
> > Signed-off-by: Colin Ian King <colin.king(a)canonical.com>
> > ---
> >  source/compiler/asloffset.c | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/source/compiler/asloffset.c b/source/compiler/asloffset.c
> > index e3fdf1c91..0964d4fea 100644
> > --- a/source/compiler/asloffset.c
> > +++ b/source/compiler/asloffset.c
> > @@ -250,7 +250,6 @@ LsAmlOffsetWalk (
> >          }
> >
> >          Length =3D Op->Asl.FinalAmlLength;
> > -        NamepathOffset =3D Gbl_CurrentAmlOffset + Length;
> >
> >          /* Get to the NameSeg/NamePath Op (and length of the name) */
> >
> >
> Any chance this will be reviewed?
> _______________________________________________
> Devel mailing list
> Devel(a)acpica.org
> https://lists.acpica.org/mailman/listinfo/devel

--===============7554616336738789769==--

