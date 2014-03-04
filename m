Content-Type: multipart/mixed; boundary="===============7059336656395441226=="
MIME-Version: 1.0
From: Thomas Renninger <trenn at suse.de>
Subject: Re: [Devel] [PATCH 2/4] ACPICA: Introduce new
 acpi_os_physical_table_add OS callback
Date: Tue, 04 Mar 2014 11:54:22 +0000
Message-ID: <1393960620.uGzzRHqAbc@skinner>
In-Reply-To: 1AE640813FDE7649BE1B193DEA596E88024BD46F@SHSMSX101.ccr.corp.intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============7059336656395441226==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tuesday, March 04, 2014 12:31:57 AM Zheng, Lv wrote:
> Hi,  Thomas
> =

> > From: Thomas Renninger [mailto:trenn(a)suse.de]
> > Sent: Monday, March 03, 2014 8:42 PM
> > =

> > Hi Lv,
> > =

> > On Monday, March 03, 2014 01:20:31 AM Zheng, Lv wrote:
> > > Hi, Thomas
> > > =

> > > I have a patch series that can cleanup the ACPICA table manager, and
> > > change
> > =

> > > the acpi_load_table into the following style:
> > Ok. I suggest that:
> > 1) If Thomas (Gleixner) or whoever wants to try out or needs it urgentl=
y,
> > he> =

> >    can (must) use a recent kernel with my patches applied.
> > =

> > 2) You continue to get your changes into ACPICA.
> > =

> >    Eventually or best would be if you add whatever is needed to
> >    allow adding of tables as well (which will be there automatically if
> >    I understood the description of your changes correctly).
> > =

> > 3) Either you give it a try yourself or give me short description for
> > =

> >    what I have to look out for and I can re-post the Linux patches
> >    based on your ACPICA changes, once they show up in the Linux kernel.
> >    Best give me a ping as soon as I should look at it.
> =

> That sounds good.
> =

> Or it can be more efficient for productions:
> Linux can merge your patches and ACPICA just stop to take them.
You mean add my stuff to drivers/acpi/acpica in Linux kernel without
pushing them into the ACPICA repository?

I cannot remember that this ever happened (beside small important fixes)
and I doubt Rafael is willing to do that.
If it would be super critical, but I cannot see that it is.

> This will leave us divergences.
Yes, that would be bad.

> After the table manager cleanups are tested and shipped in the ACPICA rep=
o,
> the new facilities will automatically be rolled into Linux branches.
I'd suggest to just wait for that.
Best already try to integrate the ACPI table override/add part as you think
it should work without additional changes in drivers/acpi/acpica.


If this happened and things are submitted to get integrated into the Linux
kernel, please add me to CC or point me to the patchset.

> Then I
> can help to reduce the divergences using the new ACPICA facilities. At th=
at
> time I may ask whoever that can test to offer help to review the cleanup
> patch.

I can then give your new patcheset some testing and try to get the Linux
(drivers/acpi/osl.c) parts (re-)implemented based on your stuff.
There might still be the one or other minor fix needed that has to go
into acpica as well, but that should not be that hard to manage and
might end up in acpica and Linux kernel in parallel without much
extra overhead.

     Thomas

--===============7059336656395441226==--

