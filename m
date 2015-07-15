Content-Type: multipart/mixed; boundary="===============8411652912413014219=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: Re: [Devel] Can't build IASL on today's ACPICA tip
Date: Wed, 15 Jul 2015 18:11:15 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37D30C427@ORSMSX112.amr.corp.intel.com>
In-Reply-To: 55A69F28.2010501@canonical.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============8411652912413014219==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Yes, dmobject needs to be removed. We already have a fix.
Thanks,
Bob


> -----Original Message-----
> From: Devel [mailto:devel-bounces(a)acpica.org] On Behalf Of Colin Ian Ki=
ng
> Sent: Wednesday, July 15, 2015 10:58 AM
> To: devel(a)acpica.org
> Subject: [Devel] Can't build IASL on today's ACPICA tip
> =

> Hi there,
> =

> Building of IASL on Ubuntu 15.10 Wily fails on today's ACPICA tip (commit
> b9677e910888b35f27746f97567950f9157f63a6)
> =

> make[1]: Entering directory '/home/king/repos/acpica/generate/unix/iasl'
> make[1]: *** No rule to make target 'obj/dmobject.o', needed by
> 'obj/iasl'. Stop.
> make[1]: Leaving directory '/home/king/repos/acpica/generate/unix/iasl'
> generate/unix/Makefile.common:21: recipe for target 'iasl' failed
> make: *** [iasl] Error 2
> =

> I think the root cause is the following commit:
> =

> commit 7dca7e02d1f10f096233358096a4578225f207a7
> Merge: 1389ac5 2164923
> Author: Robert Moore <Robert.Moore(a)intel.com>
> Date:   Fri Jul 10 12:56:35 2015 -0700
> =

>     Merge pull request #78 from zetalog/acpica-debug
> =

>     Acpica debugger
> =

> Colin.
> _______________________________________________
> Devel mailing list
> Devel(a)acpica.org
> https://lists.acpica.org/mailman/listinfo/devel

--===============8411652912413014219==--

