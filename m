Content-Type: multipart/mixed; boundary="===============8302884181880776480=="
MIME-Version: 1.0
From: Thomas Renninger <trenn at suse.de>
Subject: Re: [Devel] [PATCHES] Various fixes for Fedora
Date: Wed, 10 Oct 2012 23:49:20 +0200
Message-ID: <201210102349.21351.trenn@suse.de>
In-Reply-To: 20121010154258.GT24071@rhmail.home.annexia.org
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============8302884181880776480==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wednesday 10 October 2012 17:42:58 Richard W.M. Jones wrote:
> =

> Here is a laundry-list of patches that fix various compiler warnings
> in the ACPICA code.
> =

> 'iasl-pointer-casts.patch' fixes a segfault on ppc64:
> =

> https://bugzilla.redhat.com/show_bug.cgi?id=3D856856
> =

> There is also an endianness assumption in the code on ppc64 which I'm
> still tracking down.

While code correctness across architectures is a good thing, especially
for acpica, but I am really curious about: Why should someone compile
acpica for ppc/ppc64?

Thanks,

   Thomas

--===============8302884181880776480==--

