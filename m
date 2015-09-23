Content-Type: multipart/mixed; boundary="===============4014904636250594152=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: Re: [Devel] [PATCH] ACPICA: fix possible NULL dereference
Date: Wed, 23 Sep 2015 16:32:36 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37D3536B1@ORSMSX112.amr.corp.intel.com>
In-Reply-To: 1AE640813FDE7649BE1B193DEA596E883406456A@SHSMSX101.ccr.corp.intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============4014904636250594152==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This is the type of thing such that if we get to the code, it is guaranteed=
 that NULL will not be returned by virtue of the fact that it would have be=
en caught much earlier.

I don't want to start littering the code with assert, etc.

It is not as if we have not thought about these things and made certain dec=
isions.

Bob


> -----Original Message-----
> From: Zheng, Lv
> Sent: Sunday, September 20, 2015 5:59 PM
> To: Sudip Mukherjee; Moore, Robert
> Cc: Wysocki, Rafael J; Len Brown; devel(a)acpica.org
> Subject: RE: [PATCH] ACPICA: fix possible NULL dereference
> =

> If it is intentional, can we put something like assert(), BUG_ON() there
> so that the checker can always be coded but not compiled when the binary
> is released?
> =

> Thanks
> -Lv
> =

> > From: Sudip Mukherjee [mailto:sudipm.mukherjee(a)gmail.com]
> > Sent: Friday, September 18, 2015 2:06 PM
> >
> > On Thu, Sep 10, 2015 at 07:06:02PM +0000, Moore, Robert wrote:
> > > One of the things we always have to think about and look at is that
> > > often, things like this are *guaranteed" to be valid simply by
> > virtue of the fact that the code has gotten as far as it has.
> > >
> > > So, rather than litter the code with NULL checks for every single
> access, we know up front that the object is valid.
> > >
> > > This isn't always true and there are some valid situations, but we
> would appreciate it if you help track this down.
> > I tried but looks like acpi is very tough to understand. The only
> > argument I can give in favor of my patch is that in all the places
> > this function acpi_ns_get_secondary_object() has been used the return
> > has been checked, only the three calls in this file
> > acpi/acpica/dsargs.c has not checked the return. Like you said it
> > might be intentional also to not check the return only in this file.
> >
> > regards
> > sudip

--===============4014904636250594152==--

