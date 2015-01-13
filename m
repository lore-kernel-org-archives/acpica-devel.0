Content-Type: multipart/mixed; boundary="===============1007272960892520841=="
MIME-Version: 1.0
From: Zheng, Lv <lv.zheng at intel.com>
Subject: Re: [Devel] [PATCH 3/3] ACPICA: Remove use of __DATE__ macro
Date: Tue, 13 Jan 2015 02:33:18 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E88026AC9E4@SHSMSX101.ccr.corp.intel.com>
In-Reply-To: 20150106193610.GA7141@pathfinder
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============1007272960892520841==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

I've added this patch into the 201501 ACPICA materials for review:
https://github.com/acpica/acpica/pull/61
If it is merged, it will appear in Linux kernel after 201501 ACPICA release.
Thanks for reporting.

Best regards
-Lv

> From: David E. Box [mailto:david.e.box(a)linux.intel.com]
> Sent: Wednesday, January 07, 2015 3:36 AM
> =

> On Tue, Jan 06, 2015 at 12:30:05AM +0000, Zheng, Lv wrote:
> > Hi,
> >
> > > From: Rasmus Villemoes [mailto:linux(a)rasmusvillemoes.dk]
> > > Sent: Monday, January 05, 2015 6:27 PM
> > >
> > > On Mon, Jan 05 2015, "Zheng, Lv" <lv.zheng(a)intel.com> wrote:
> > >
> > > > Hi,
> > > >
> > > >> From: Rasmus Villemoes [mailto:linux(a)rasmusvillemoes.dk]
> > > >> Sent: Friday, December 12, 2014 6:51 PM
> > > >> To: Zheng, Lv
> > > >> Cc: Rasmus Villemoes; linux-acpi(a)vger.kernel.org; devel(a)acpica=
.org; linux-kernel(a)vger.kernel.org
> > > >> Subject: [PATCH 3/3] ACPICA: Remove use of __DATE__ macro
> > > >>
> > > >> The macro __DATE__ and friends is not allowed in the kernel. Also,
> > > >> including the build time in output doesn't seem to provide any val=
ue.
> > > >>
> > > >
> > > > Could you confirm that it is not useful even for the user tools?
> > > > Please perform the following commands in the kernel source tree
> > > > 1. stay in tools folder
> > > > 2. type "make acpi"
> > > > 3. type "./power/acpi/acpidump -v"
> > > >
> > >
> > > Yeah, it's part of the output, but for what reason? What can userspace
> > > possibly use that information for?
> >
> > I also want to know.
> =

> I don't see a reason for userspace to know the build date.
> =

> >
> > > I can see some utility in printing a
> > > version number, since that may tell something about the features
> > > present or absent. The compilation date, on the other hand, seems
> > > completely useless. Different distros may ship different versions whi=
ch
> > > happened to be compiled on the same day, or older versions compiled l=
ater.
> >
> > If the deletion was done for this reason, IMO, it's acceptable.
> > So let's wait to see others' feedback.
> >
> =

> I'm okay with removing it (the build date) in Linux and ACPICA as well. H=
owever
> the version, which is essentially the release date, is important for the =
exact
> reasons already stated.
> =

> Dave

--===============1007272960892520841==--

