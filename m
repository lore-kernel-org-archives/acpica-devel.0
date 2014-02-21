Content-Type: multipart/mixed; boundary="===============7480627898234914948=="
MIME-Version: 1.0
From: Zheng, Lv <lv.zheng at intel.com>
Subject: Re: [Devel] [PATCH 1/4] ACPI: Provide support for ACPI table
 adding	via OS
Date: Fri, 21 Feb 2014 07:24:20 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E88024B23BD@SHSMSX101.ccr.corp.intel.com>
In-Reply-To: 3327021.IBYDWO02Gb@skinner
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============7480627898234914948==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi, Thomas

> From: Devel [mailto:devel-bounces(a)acpica.org] On Behalf Of Thomas Renni=
nger
> Sent: Wednesday, February 19, 2014 7:23 PM
> =

> On Tuesday, February 18, 2014 12:51:07 PM H. Peter Anvin wrote:
> > On 02/18/2014 10:44 AM, Thomas Renninger wrote:
> > > On Tuesday, February 18, 2014 10:27:23 AM H. Peter Anvin wrote:
> > >> Why can't you add SSDTs? It would be particularly useful.
> > >
> > > There are 2 ways how ACPI tables get added:
> > >    - Via pointer from a root table (XSDT or RSDT iirc)
> > >    - Via load statement inside of ACPI context when ACPI BIOS
> > >
> > >      code gets executed (iirc the physical address is passed).
> > >
> > > The latter is only for SSDTs.
> > > The problem is that you if you add an SSDT early, it might
> > > have been intended for overriding when an SSDT gets dynamically
> > > loaded later when the system is up which is particular useful as
> > > well if you want to debug this specific BIOS table.
> > >
> > > This could be workarounded via a boot param:
> > > acpi=3Dallow_ssdt_adding
> > > But this is not nice. Maybe someone has a more elegant idea.
> > > Something could still be added if someone is really needing this.
> >
> > Since adding SSDTs is one of the things I really can imagine one would
> > do, I think we need to figure out how to do that.  I would think that
> > overriding would be the exception case.
> =

> You can always paste new code into the DSDT. It is effectively the same
> than adding a new SSDT table.
> The other way around, modifying or deleting broken code in a BIOS
> provided SSDT needs overriding.
> =

> So in fact adding SSDTs is not necessary at all.
> It would be a nice add-on, but it's not even worth introducing
> an extra boot param or whatever confusion.
> A hint in Documentation that adding additional ASL (ACPI Source Language)
> code to the DSDT would be the same than creating and adding a new
> SSDT table which is not possible should be enough.

IMO, we need to load tables from RSDT/XSDT, they look like "static tables".
Given that we can live in the environment where table reloading is properly=
 implemented by ACPICA, we won't face issues.
And the reloading feature is also required by ACPI specification.
If a table contains same "signature, oem_id, oem_table_id", it could be abl=
e to replace the old loaded one if the revision field is greater than the o=
ld one.

Actually I'm currently working on the parallel reloading support and all fu=
nctionalities have been done.
This report is a bit hurry than I expected.
I'll try to prepare fixes (which seems to be dozens of patches) for the tes=
ters to validate.

Fortunately, specific to this bug, I don't think the reload requirement mus=
t be implemented as the new one doesn't contain a greater revision number.
So there might just be dead lock issues for this bug.

Thanks and best regards
-Lv

> =

> The whole thing will always taint the kernel and is meant for
> debugging only anyway.
> =

>    Thomas
> _______________________________________________
> Devel mailing list
> Devel(a)acpica.org
> https://lists.acpica.org/mailman/listinfo/devel

--===============7480627898234914948==--

