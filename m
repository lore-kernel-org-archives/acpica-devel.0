Content-Type: multipart/mixed; boundary="===============8874725703271375821=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: Re: [Devel] QNX port?
Date: Fri, 04 Mar 2016 17:45:25 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37E44F0B6@ORSMSX110.amr.corp.intel.com>
In-Reply-To: 56D9C471.4020303@sgl.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============8874725703271375821==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

We would be happy to accept an OS-specific header and integrate it into the=
 acenv.h header. We do in fact support many "unusual" operating systems in =
this way.

However, we do not want any OS-specific code (#ifdefs) in the actual C modu=
les.

Bob

> -----Original Message-----
> From: Devel [mailto:devel-bounces(a)acpica.org] On Behalf Of Will Miles
> Sent: Friday, March 04, 2016 9:23 AM
> To: devel(a)acpica.org
> Subject: [Devel] QNX port?
> =

> Hi ACPICA developers,
> =

> Do you have any interest in accepting patches for unusual target
> platforms?   I've made a small patch to port the ACPICA package to QNX
> 6.6 for use as part of a device enumerator for my company's data
> acquisition systems, and I'd be happy to send a pull request if there's
> any interest in including such support to the upstream distribution.
> =

> Thanks,
> -Will Miles
> Sander Geophysics Ltd.
> =

> _______________________________________________
> Devel mailing list
> Devel(a)acpica.org
> https://lists.acpica.org/mailman/listinfo/devel

--===============8874725703271375821==--

