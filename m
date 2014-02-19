Content-Type: multipart/mixed; boundary="===============7018859768101462097=="
MIME-Version: 1.0
From: Thomas Renninger <trenn at suse.de>
Subject: Re: [Devel] [PATCH 1/4] ACPI: Provide support for ACPI table adding
 via OS
Date: Wed, 19 Feb 2014 12:22:58 +0100
Message-ID: <3327021.IBYDWO02Gb@skinner>
In-Reply-To: 5303C7BB.4020803@zytor.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============7018859768101462097==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tuesday, February 18, 2014 12:51:07 PM H. Peter Anvin wrote:
> On 02/18/2014 10:44 AM, Thomas Renninger wrote:
> > On Tuesday, February 18, 2014 10:27:23 AM H. Peter Anvin wrote:
> >> Why can't you add SSDTs? It would be particularly useful.
> > =

> > There are 2 ways how ACPI tables get added:
> >    - Via pointer from a root table (XSDT or RSDT iirc)
> >    - Via load statement inside of ACPI context when ACPI BIOS
> >    =

> >      code gets executed (iirc the physical address is passed).
> > =

> > The latter is only for SSDTs.
> > The problem is that you if you add an SSDT early, it might
> > have been intended for overriding when an SSDT gets dynamically
> > loaded later when the system is up which is particular useful as
> > well if you want to debug this specific BIOS table.
> > =

> > This could be workarounded via a boot param:
> > acpi=3Dallow_ssdt_adding
> > But this is not nice. Maybe someone has a more elegant idea.
> > Something could still be added if someone is really needing this.
> =

> Since adding SSDTs is one of the things I really can imagine one would
> do, I think we need to figure out how to do that.  I would think that
> overriding would be the exception case.

You can always paste new code into the DSDT. It is effectively the same
than adding a new SSDT table.
The other way around, modifying or deleting broken code in a BIOS
provided SSDT needs overriding.

So in fact adding SSDTs is not necessary at all.
It would be a nice add-on, but it's not even worth introducing
an extra boot param or whatever confusion.
A hint in Documentation that adding additional ASL (ACPI Source Language)
code to the DSDT would be the same than creating and adding a new
SSDT table which is not possible should be enough.

The whole thing will always taint the kernel and is meant for
debugging only anyway.

   Thomas

--===============7018859768101462097==--

