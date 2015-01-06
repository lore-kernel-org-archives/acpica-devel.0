Content-Type: multipart/mixed; boundary="===============6673734108757530198=="
MIME-Version: 1.0
From: Zheng, Lv <lv.zheng at intel.com>
Subject: Re: [Devel] [PATCH 3/3] ACPICA: Remove use of __DATE__ macro
Date: Tue, 06 Jan 2015 00:30:05 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E88026AB06A@SHSMSX101.ccr.corp.intel.com>
In-Reply-To: 87oaqdy13n.fsf@rasmusvillemoes.dk
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============6673734108757530198==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

> From: Rasmus Villemoes [mailto:linux(a)rasmusvillemoes.dk]
> Sent: Monday, January 05, 2015 6:27 PM
> =

> On Mon, Jan 05 2015, "Zheng, Lv" <lv.zheng(a)intel.com> wrote:
> =

> > Hi,
> >
> >> From: Rasmus Villemoes [mailto:linux(a)rasmusvillemoes.dk]
> >> Sent: Friday, December 12, 2014 6:51 PM
> >> To: Zheng, Lv
> >> Cc: Rasmus Villemoes; linux-acpi(a)vger.kernel.org; devel(a)acpica.org=
; linux-kernel(a)vger.kernel.org
> >> Subject: [PATCH 3/3] ACPICA: Remove use of __DATE__ macro
> >>
> >> The macro __DATE__ and friends is not allowed in the kernel. Also,
> >> including the build time in output doesn't seem to provide any value.
> >>
> >
> > Could you confirm that it is not useful even for the user tools?
> > Please perform the following commands in the kernel source tree
> > 1. stay in tools folder
> > 2. type "make acpi"
> > 3. type "./power/acpi/acpidump -v"
> >
> =

> Yeah, it's part of the output, but for what reason? What can userspace
> possibly use that information for?

I also want to know.

> I can see some utility in printing a
> version number, since that may tell something about the features
> present or absent. The compilation date, on the other hand, seems
> completely useless. Different distros may ship different versions which
> happened to be compiled on the same day, or older versions compiled later.

If the deletion was done for this reason, IMO, it's acceptable.
So let's wait to see others' feedback.

Thanks and best regards
-Lv

> Note that -Werror=3Ddate-time was added to the kernel's default build
> flags in fe7c36c7bde12. It doesn't currently show because tools/ uses
> its own flags, and the ACPI_COMMON_SIGNON macro is not used within the
> kernel.
> =

> Rasmus

--===============6673734108757530198==--

