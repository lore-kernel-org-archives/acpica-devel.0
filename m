Content-Type: multipart/mixed; boundary="===============0986786605435853247=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: Re: [Devel] _CRS/_PRS for address space range
Date: Fri, 22 Jul 2011 20:01:31 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E313707163@ORSMSX101.amr.corp.intel.com>
In-Reply-To: 201107221548.17122.jkim@FreeBSD.org
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============0986786605435853247==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

There is, however, an option to iASL to disable this checking:

  -cr            Disable Resource Descriptor error checking



> -----Original Message-----
> From: Jung-uk Kim [mailto:jkim(a)FreeBSD.org]
> Sent: Friday, July 22, 2011 12:48 PM
> To: Moore, Robert
> Cc: devel(a)acpica.org; John Baldwin
> Subject: Re: [Devel] _CRS/_PRS for address space range
> =

> On Friday 22 July 2011 03:15 pm, Moore, Robert wrote:
> > I think we relaxed the iASL checking a bit because of these issues.
> > If not, we plan to do so.
> =

> ACPICA 20110527 still has this issue.
> =

> > This might be an area where we could check the descriptors at
> > runtime, as they are returned from _CRS, etc.
> =

> That'll be great.
> =

> Thanks!
> =

> JK
> =

> > Bob
> >
> > > -----Original Message-----
> > > From: devel-bounces(a)acpica.org [mailto:devel-bounces(a)acpica.org]
> > > On Behalf Of Jung-uk Kim
> > > Sent: Friday, July 22, 2011 11:44 AM
> > > To: devel(a)acpica.org
> > > Cc: John Baldwin
> > > Subject: Re: [Devel] _CRS/_PRS for address space range
> > >
> > > On Friday 22 July 2011 12:45 pm, Jung-uk Kim wrote:
> > > > ACPI Spec. 4.0a, 6.4.3.5 Address Space Range Descriptor, Table
> > > > 6-40 on page 260 implies _LEN > 0, _MIF =3D 1, and _MAF =3D 1 is
> > > > the only valid combination for _CRS.  However, I found a _CRS
> > > > example on page, which has _LEN =3D _MIF =3D _MAF =3D 0.  Can you
> > > > please clarify? If the table is correct, iasl should have
> > > > warned about it.  I think iasl currently treats _PRS and _CRS
> > > > equally.
> > >
> > > John Baldwin <jhb(a)FreeBSD.org> pointed out iASL's address space
> > > range check introduced in ACPI-CA 20100428 is just bogus.  It is
> > > often times dynamically recalculated from a template.  Therefore,
> > > OS must do the sanity check at *runtime*, at least for _CRS.
> > >
> > > Jung-uk Kim
> > > _______________________________________________
> > > Devel mailing list
> > > Devel(a)acpica.org
> > > http://lists.acpica.org/listinfo/devel

--===============0986786605435853247==--

