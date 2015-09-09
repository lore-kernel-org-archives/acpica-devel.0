Content-Type: multipart/mixed; boundary="===============4298050950029612127=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: Re: [Devel] PATCH proposal removing use of strtoul in
 events/evgpeinit.c
Date: Wed, 09 Sep 2015 18:00:07 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37D343F87@ORSMSX112.amr.corp.intel.com>
In-Reply-To: 55EA8551.2090207@netbsd.org
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============4298050950029612127==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This is hardly the only use of strtoul in ACPICA. May or may not be an issu=
e on solaris, depending on the kernel/ACPICA configuration.


> -----Original Message-----
> From: Richard PALO [mailto:richard(a)netbsd.org]
> Sent: Friday, September 04, 2015 11:02 PM
> To: Moore, Robert; devel(a)acpica.org
> Subject: Re: [Devel] PATCH proposal removing use of strtoul in
> events/evgpeinit.c
> =

> Le 04/09/15 15:58, Moore, Robert a =C3=A9crit :
> > Sure, but the original code is much simpler.
> >
> =

> The reason for the error was that, by default, the extern declaration was
> forcluded by _DDI_STRICT being defined..
> which is to say that strtoul, strictly speaking is unavailable in the
> Solaris kernel (excepting kmdb).
> =

> So I kludged and added to acsolaris.h #ifdef _KERNEL section :
> > static __GNU_INLINE unsigned long
> > strtoul(const char *str, char **nptr, int base) {
> > 	unsigned long ret;
> > 	int status;
> >
> > 	if ((status =3D ddi_strtoul(str, nptr, base, &ret)) !=3D 0) {
> > 		if (status =3D=3D ERANGE)
> > 			return (ULONG_MAX);
> > 		return (0);
> > 	}
> > 	return (ret);
> > }
> =

> Still seems for one call in the kernel to convert a single HEX byte from
> ascii to unsigned long, that the portable solution is to avoid using
> 'strtoul' in paths operating in kernel space.
> (also considering the Linux discussion also around strtoul in the kernel)
> =

> cheers,
> --
> Richard PALO


--===============4298050950029612127==--

