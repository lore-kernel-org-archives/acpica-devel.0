Content-Type: multipart/mixed; boundary="===============0454134166685408537=="
MIME-Version: 1.0
From: David E. Box <david.e.box at linux.intel.com>
Subject: Re: [Devel] [PATCH 3/3] ACPICA: Remove use of __DATE__ macro
Date: Tue, 06 Jan 2015 11:36:10 -0800
Message-ID: <20150106193610.GA7141@pathfinder>
In-Reply-To: 1AE640813FDE7649BE1B193DEA596E88026AB06A@SHSMSX101.ccr.corp.intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============0454134166685408537==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 06, 2015 at 12:30:05AM +0000, Zheng, Lv wrote:
> Hi,
> =

> > From: Rasmus Villemoes [mailto:linux(a)rasmusvillemoes.dk]
> > Sent: Monday, January 05, 2015 6:27 PM
> > =

> > On Mon, Jan 05 2015, "Zheng, Lv" <lv.zheng(a)intel.com> wrote:
> > =

> > > Hi,
> > >
> > >> From: Rasmus Villemoes [mailto:linux(a)rasmusvillemoes.dk]
> > >> Sent: Friday, December 12, 2014 6:51 PM
> > >> To: Zheng, Lv
> > >> Cc: Rasmus Villemoes; linux-acpi(a)vger.kernel.org; devel(a)acpica.o=
rg; linux-kernel(a)vger.kernel.org
> > >> Subject: [PATCH 3/3] ACPICA: Remove use of __DATE__ macro
> > >>
> > >> The macro __DATE__ and friends is not allowed in the kernel. Also,
> > >> including the build time in output doesn't seem to provide any value.
> > >>
> > >
> > > Could you confirm that it is not useful even for the user tools?
> > > Please perform the following commands in the kernel source tree
> > > 1. stay in tools folder
> > > 2. type "make acpi"
> > > 3. type "./power/acpi/acpidump -v"
> > >
> > =

> > Yeah, it's part of the output, but for what reason? What can userspace
> > possibly use that information for?
> =

> I also want to know.

I don't see a reason for userspace to know the build date.

> =

> > I can see some utility in printing a
> > version number, since that may tell something about the features
> > present or absent. The compilation date, on the other hand, seems
> > completely useless. Different distros may ship different versions which
> > happened to be compiled on the same day, or older versions compiled lat=
er.
> =

> If the deletion was done for this reason, IMO, it's acceptable.
> So let's wait to see others' feedback.
> =


I'm okay with removing it (the build date) in Linux and ACPICA as well. How=
ever
the version, which is essentially the release date, is important for the ex=
act
reasons already stated.

Dave

--===============0454134166685408537==--

