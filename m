Content-Type: multipart/mixed; boundary="===============7507765912151238806=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: [Devel] Re: [pm:bleeding-edge 20/29]
 drivers/acpi/platform_profile.c:67:33: error: passing 'const struct
 platform_profile_handler to parameter of type 'struct
 platform_profile_handler discards qualifiers
Date: Tue, 12 Jan 2021 14:49:46 +0100
Message-ID: <CAJZ5v0hUrNd9HCY66mw6_Vab0JrgNwJYV_PgaT6fkd1+j8UBtw@mail.gmail.com>
In-Reply-To: 01442a77-7d87-5a12-d7b8-4fe397a37464@redhat.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============7507765912151238806==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 12, 2021 at 1:11 PM Hans de Goede <hdegoede(a)redhat.com> wrote:
>
> Hi,
>
> On 1/12/21 1:07 PM, Jiaxun Yang wrote:
> > =E5=9C=A8 2021/1/12 =E4=B8=8B=E5=8D=886:42, Hans de Goede =E5=86=99=E9=
=81=93:
> >> Hi,
> >>
> >> On 1/8/21 9:52 AM, kernel test robot wrote:
> > [...]
> >>
> >> If you fix the issue, kindly add following tag as appropriate
> >> Reported-by: kernel test robot <lkp(a)intel.com>
> >>
> >> All errors (new ones prefixed by >>):
> >>
> > [...]
> >>>     2 errors generated.
> >
> > Oops, thanks for the reminder, I should exclude 0day CI from mail filte=
r.
> > It's wired that GCC didn't say anything about it.
> >
> >> Ugh, so that means that the current version of the
> >> "ACPI: platform-profile: Pass profile pointer to driver callbacks"
> >> patch is no good. Since this is causing compile errors I assume
> >> that it will be dropped from the bleeding-edge branch.
> >> Is that right Rafael?
> >
> > I'm not familiar with x86pdx and ACPI workflow.
> > Should I resend the patch or send a fixup patch?
>
> I believe a new version of the patch is best, then Rafael can
> replace the broken patch. We want to avoid having a commit in
> git history which does not compile in some cases, because that
> creates problems when git bisecting.

That's right.

If the plan is to drop the "const" everywhere, I would appreciate an
additional patch to do that on top of the two from Mark and a new
patch adding a new callback on top of that.
--===============7507765912151238806==--

