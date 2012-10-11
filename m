Content-Type: multipart/mixed; boundary="===============1154648725656186279=="
MIME-Version: 1.0
From: Richard W.M. Jones <rjones at redhat.com>
Subject: Re: [Devel] [PATCHES] Various fixes for Fedora
Date: Thu, 11 Oct 2012 08:24:16 +0100
Message-ID: <20121011072416.GZ24071@rhmail.home.annexia.org>
In-Reply-To: 201210102349.21351.trenn@suse.de
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============1154648725656186279==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Wed, Oct 10, 2012 at 11:49:20PM +0200, Thomas Renninger wrote:
> On Wednesday 10 October 2012 17:42:58 Richard W.M. Jones wrote:
> > =

> > Here is a laundry-list of patches that fix various compiler warnings
> > in the ACPICA code.
> > =

> > 'iasl-pointer-casts.patch' fixes a segfault on ppc64:
> > =

> > https://bugzilla.redhat.com/show_bug.cgi?id=3D856856
> > =

> > There is also an endianness assumption in the code on ppc64 which I'm
> > still tracking down.
> =

> While code correctness across architectures is a good thing, especially
> for acpica, but I am really curious about: Why should someone compile
> acpica for ppc/ppc64?

For the (very esoteric and rarely used) case where someone wants
to compile qemu{,-system-x86_64} from source on ppc.

Rich.

-- =

Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjon=
es
virt-top is 'top' for virtual machines.  Tiny program with many
powerful monitoring features, net stats, disk stats, logging, etc.
http://et.redhat.com/~rjones/virt-top

--===============1154648725656186279==--

