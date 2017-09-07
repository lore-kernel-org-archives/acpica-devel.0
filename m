Content-Type: multipart/mixed; boundary="===============3981679665984386277=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: Re: [Devel] [PATCH 1/1] ACPI: NULL pointer checking
Date: Thu, 07 Sep 2017 19:26:56 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37E60C211@ORSMSX110.amr.corp.intel.com>
In-Reply-To: 94F2FBAB4432B54E8AACC7DFDE6C92E37E60BA3F@ORSMSX110.amr.corp.intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============3981679665984386277==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



> -----Original Message-----
> From: Devel [mailto:devel-bounces(a)acpica.org] On Behalf Of Moore, Robert
> Sent: Wednesday, September 6, 2017 9:43 AM
> To: Zhenhua <lizhenhuajiyang(a)163.com>; devel(a)acpica.org; Zheng, Lv
> <lv.zheng(a)intel.com>; Wysocki, Rafael J <rafael.j.wysocki(a)intel.com>;
> lenb(a)kernel.org; linux-acpi(a)vger.kernel.org; linux-
> kernel(a)vger.kernel.org
> Subject: Re: [Devel] [PATCH 1/1] ACPI: NULL pointer checking
> =

> =

> =

> > -----Original Message-----
> > From: Zhenhua [mailto:lizhenhuajiyang(a)163.com]
> > Sent: Wednesday, September 6, 2017 6:35 AM
> > To: devel(a)acpica.org; Moore, Robert <robert.moore(a)intel.com>; Zheng,
> > Lv <lv.zheng(a)intel.com>; Wysocki, Rafael J
> > <rafael.j.wysocki(a)intel.com>; lenb(a)kernel.org;
> > linux-acpi(a)vger.kernel.org; linux- kernel(a)vger.kernel.org
> > Cc: Zhenhua <lizhenhuajiyang(a)163.com>
> > Subject: [PATCH 1/1] ACPI: NULL pointer checking
> >
> > These two pointers should be checked, for some broken devices they may
> > cause system crash.
> >
> > Signed-off-by: Zhenhua <lizhenhuajiyang(a)163.com>
> > ---
> >  drivers/acpi/acpica/nsaccess.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/acpi/acpica/nsaccess.c
> > b/drivers/acpi/acpica/nsaccess.c index f2733f51ca8d..151abb0ef4d5
> > 100644
> > --- a/drivers/acpi/acpica/nsaccess.c
> > +++ b/drivers/acpi/acpica/nsaccess.c
> > @@ -338,7 +338,7 @@ acpi_ns_lookup(union acpi_generic_state
> *scope_info,
> >  			return_ACPI_STATUS(AE_AML_INTERNAL);
> >  		}
> >
> > -		if (!(flags & ACPI_NS_PREFIX_IS_SCOPE)) {
> > +		if ((!prefix_node) && (!(flags & ACPI_NS_PREFIX_IS_SCOPE))) {
> [Moore, Robert]
> =

> Is there an actual case where the original code failed?
> =

> =

[Moore, Robert] =


Prefix_node is guaranteed to be valid at this point in the code.


> =

> >  			/*
> >  			 * This node might not be a actual "scope" node (such as
> a
> >  			 * Device/Method, etc.)  It could be a Package or other
> object @@
> > -369,7 +369,7 @@ acpi_ns_lookup(union acpi_generic_state *scope_info,
> >  		ACPI_DEBUG_PRINT((ACPI_DB_NAMES,
> >  				  "Null Pathname (Zero segments), Flags=3D%X\n",
> >  				  flags));
> > -	} else {
> > +	} else if (path) {
[Moore, Robert] =


Likewise, "path" is guaranteed to be valid at this point.


> >  		/*
> >  		 * Name pointer is valid (and must be in internal name
> > format)
> >  		 *
> > --
> > 2.14.1
> >
> =

> _______________________________________________
> Devel mailing list
> Devel(a)acpica.org
> https://lists.acpica.org/mailman/listinfo/devel

--===============3981679665984386277==--

