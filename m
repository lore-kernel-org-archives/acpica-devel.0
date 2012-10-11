Content-Type: multipart/mixed; boundary="===============1062583089511443161=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: Re: [Devel] [PATCHES] Various fixes for Fedora
Date: Thu, 11 Oct 2012 15:29:52 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E346B8667C@ORSMSX101.amr.corp.intel.com>
In-Reply-To: 20121011072416.GZ24071@rhmail.home.annexia.org
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============1062583089511443161==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

So, this is for the iASL compiler only. Of course, iASL pulls in huge chunk=
s of the core ACPICA code, so this is kind of moot.


I just noticed that you are using a version of the source that is over two =
years old:

> diff -ur acpica-unix-20100528.old/compiler/Makefile acpica-unix-20100528/=
compiler/Makefile
> --- acpica-unix-20100528.old/compiler/Makefile	2012-10-10 14:26:24.910788=
185 +0200
> +++ acpica-unix-20100528/compiler/Makefile	2012-10-10 14:33:10.570794691 =
+0200


The current version is 20120913.

Please migrate to the latest version.
Thanks,
Bob



> -----Original Message-----
> From: devel-bounces(a)acpica.org [mailto:devel-bounces(a)acpica.org] On B=
ehalf
> Of Richard W.M. Jones
> Sent: Thursday, October 11, 2012 12:24 AM
> To: Thomas Renninger
> Cc: devel(a)acpica.org; Matthew Garrett
> Subject: Re: [Devel] [PATCHES] Various fixes for Fedora
> =

> =

> On Wed, Oct 10, 2012 at 11:49:20PM +0200, Thomas Renninger wrote:
> > On Wednesday 10 October 2012 17:42:58 Richard W.M. Jones wrote:
> > >
> > > Here is a laundry-list of patches that fix various compiler warnings
> > > in the ACPICA code.
> > >
> > > 'iasl-pointer-casts.patch' fixes a segfault on ppc64:
> > >
> > > https://bugzilla.redhat.com/show_bug.cgi?id=3D856856
> > >
> > > There is also an endianness assumption in the code on ppc64 which
> > > I'm still tracking down.
> >
> > While code correctness across architectures is a good thing,
> > especially for acpica, but I am really curious about: Why should
> > someone compile acpica for ppc/ppc64?
> =

> For the (very esoteric and rarely used) case where someone wants to
> compile qemu{,-system-x86_64} from source on ppc.
> =

> Rich.
> =

> --
> Richard Jones, Virtualization Group, Red Hat
> http://people.redhat.com/~rjones virt-top is 'top' for virtual machines.
> Tiny program with many powerful monitoring features, net stats, disk
> stats, logging, etc.
> http://et.redhat.com/~rjones/virt-top
> _______________________________________________
> Devel mailing list
> Devel(a)acpica.org
> http://lists.acpica.org/listinfo/devel

--===============1062583089511443161==--

