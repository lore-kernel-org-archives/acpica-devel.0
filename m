Content-Type: multipart/mixed; boundary="===============2182523341408589015=="
MIME-Version: 1.0
From: Zheng, Lv <lv.zheng at intel.com>
Subject: Re: [Devel] [PATCH 3/3] ACPICA: Remove use of __DATE__ macro
Date: Tue, 13 Jan 2015 05:42:16 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E88026ADAD3@SHSMSX101.ccr.corp.intel.com>
In-Reply-To: 1AE640813FDE7649BE1B193DEA596E88026AC9E4@SHSMSX101.ccr.corp.intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============2182523341408589015==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi, Rasmus

Just for your information.

There is also a known bug related to the application header printing.
The fix is:
https://github.com/zetalog/acpica/commit/79e75432
But this bug can only be seen for EFI ports of ACPICA utilities, it won't b=
e detected in the kernel source tree.
Hope this is not the motivation that has caused you to try to remove the __=
DATE__ usages.

Thanks and best regards
-Lv

> From: Devel [mailto:devel-bounces(a)acpica.org] On Behalf Of Zheng, Lv
> Sent: Tuesday, January 13, 2015 10:33 AM
> =

> Hi,
> =

> I've added this patch into the 201501 ACPICA materials for review:
> https://github.com/acpica/acpica/pull/61
> If it is merged, it will appear in Linux kernel after 201501 ACPICA relea=
se.
> Thanks for reporting.
> =

> Best regards
> -Lv
> =

> > From: David E. Box [mailto:david.e.box(a)linux.intel.com]
> > Sent: Wednesday, January 07, 2015 3:36 AM
> >
> > On Tue, Jan 06, 2015 at 12:30:05AM +0000, Zheng, Lv wrote:
> > > Hi,
> > >
> > > > From: Rasmus Villemoes [mailto:linux(a)rasmusvillemoes.dk]
> > > > Sent: Monday, January 05, 2015 6:27 PM
> > > >
> > > > On Mon, Jan 05 2015, "Zheng, Lv" <lv.zheng(a)intel.com> wrote:
> > > >
> > > > > Hi,
> > > > >
> > > > >> From: Rasmus Villemoes [mailto:linux(a)rasmusvillemoes.dk]
> > > > >> Sent: Friday, December 12, 2014 6:51 PM
> > > > >> To: Zheng, Lv
> > > > >> Cc: Rasmus Villemoes; linux-acpi(a)vger.kernel.org; devel(a)acpi=
ca.org; linux-kernel(a)vger.kernel.org
> > > > >> Subject: [PATCH 3/3] ACPICA: Remove use of __DATE__ macro
> > > > >>
> > > > >> The macro __DATE__ and friends is not allowed in the kernel. Als=
o,
> > > > >> including the build time in output doesn't seem to provide any v=
alue.
> > > > >>
> > > > >
> > > > > Could you confirm that it is not useful even for the user tools?
> > > > > Please perform the following commands in the kernel source tree
> > > > > 1. stay in tools folder
> > > > > 2. type "make acpi"
> > > > > 3. type "./power/acpi/acpidump -v"
> > > > >
> > > >
> > > > Yeah, it's part of the output, but for what reason? What can usersp=
ace
> > > > possibly use that information for?
> > >
> > > I also want to know.
> >
> > I don't see a reason for userspace to know the build date.
> >
> > >
> > > > I can see some utility in printing a
> > > > version number, since that may tell something about the features
> > > > present or absent. The compilation date, on the other hand, seems
> > > > completely useless. Different distros may ship different versions w=
hich
> > > > happened to be compiled on the same day, or older versions compiled=
 later.
> > >
> > > If the deletion was done for this reason, IMO, it's acceptable.
> > > So let's wait to see others' feedback.
> > >
> >
> > I'm okay with removing it (the build date) in Linux and ACPICA as well.=
 However
> > the version, which is essentially the release date, is important for th=
e exact
> > reasons already stated.
> >
> > Dave
> _______________________________________________
> Devel mailing list
> Devel(a)acpica.org
> https://lists.acpica.org/mailman/listinfo/devel

--===============2182523341408589015==--

