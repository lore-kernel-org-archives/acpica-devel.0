Content-Type: multipart/mixed; boundary="===============3980548945143089946=="
MIME-Version: 1.0
From: Richard PALO <richard at netbsd.org>
Subject: Re: [Devel] PATCH proposal removing use of strtoul in
 events/evgpeinit.c
Date: Sat, 05 Sep 2015 08:01:53 +0200
Message-ID: <55EA8551.2090207@netbsd.org>
In-Reply-To: 94F2FBAB4432B54E8AACC7DFDE6C92E37D343333@ORSMSX112.amr.corp.intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============3980548945143089946==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Le 04/09/15 15:58, Moore, Robert a =C3=A9crit :
> Sure, but the original code is much simpler.
> =

 =

The reason for the error was that, by default, the extern declaration was f=
orcluded by
_DDI_STRICT being defined.. =

which is to say that strtoul, strictly speaking is unavailable in the Solar=
is kernel (excepting kmdb).

So I kludged and added to acsolaris.h #ifdef _KERNEL section :
> static __GNU_INLINE unsigned long
> strtoul(const char *str, char **nptr, int base)
> {
> 	unsigned long ret;
> 	int status;
> =

> 	if ((status =3D ddi_strtoul(str, nptr, base, &ret)) !=3D 0) {
> 		if (status =3D=3D ERANGE)
> 			return (ULONG_MAX);
> 		return (0);
> 	}
> 	return (ret);
> }

Still seems for one call in the kernel to convert a single HEX byte from as=
cii to unsigned long, that =

the portable solution is to avoid using 'strtoul' in paths operating in ker=
nel space.
(also considering the Linux discussion also around strtoul in the kernel)

cheers,
-- =

Richard PALO


--===============3980548945143089946==--

