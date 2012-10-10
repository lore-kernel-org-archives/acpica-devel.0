Content-Type: multipart/mixed; boundary="===============6738506150355681498=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: Re: [Devel] [PATCHES] Various fixes for Fedora
Date: Wed, 10 Oct 2012 15:50:36 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E346B85199@ORSMSX101.amr.corp.intel.com>
In-Reply-To: 20121010154258.GT24071@rhmail.home.annexia.org
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============6738506150355681498==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Thanks, we will take a look at integrating these.
Bob


> -----Original Message-----
> From: devel-bounces(a)acpica.org [mailto:devel-bounces(a)acpica.org] On B=
ehalf
> Of Richard W.M. Jones
> Sent: Wednesday, October 10, 2012 8:43 AM
> To: trenn(a)suse.de; Matthew Garrett; devel(a)acpica.org
> Subject: [Devel] [PATCHES] Various fixes for Fedora
> =

> =

> Here is a laundry-list of patches that fix various compiler warnings in
> the ACPICA code.
> =

> 'iasl-pointer-casts.patch' fixes a segfault on ppc64:
> =

> https://bugzilla.redhat.com/show_bug.cgi?id=3D856856
> =

> There is also an endianness assumption in the code on ppc64 which I'm
> still tracking down.
> =

> Rich.
> =

> --
> Richard Jones, Virtualization Group, Red Hat
> http://people.redhat.com/~rjones Read my programming blog:
> http://rwmj.wordpress.com Fedora now supports 80 OCaml packages (the OPEN
> alternative to F#)
> http://cocan.org/getting_started_with_ocaml_on_red_hat_and_fedora

--===============6738506150355681498==--

