Content-Type: multipart/mixed; boundary="===============6233624178114918088=="
MIME-Version: 1.0
From: Zheng, Lv <lv.zheng at intel.com>
Subject: Re: [Devel] [PATCH] ACPICA: Export mutex functions
Date: Mon, 17 Apr 2017 23:43:12 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E886CE93CFF@SHSMSX101.ccr.corp.intel.com>
In-Reply-To: 94F2FBAB4432B54E8AACC7DFDE6C92E37E59345B@ORSMSX110.amr.corp.intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============6233624178114918088==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

> -----Original Message-----
> From: Moore, Robert
> Sent: Tuesday, April 18, 2017 3:28 AM
> To: 'Guenter Roeck' <linux(a)roeck-us.net>; Zheng, Lv <lv.zheng(a)intel.c=
om>
> Cc: Wysocki, Rafael J <rafael.j.wysocki(a)intel.com>; 'Len Brown' <lenb(a=
)kernel.org>; 'linux-
> acpi(a)vger.kernel.org' <linux-acpi(a)vger.kernel.org>; 'devel(a)acpica.o=
rg' <devel(a)acpica.org>; 'linux-
> kernel(a)vger.kernel.org' <linux-kernel(a)vger.kernel.org>; Box, David E =
<david.e.box(a)intel.com>
> Subject: RE: [PATCH] ACPICA: Export mutex functions
> =

> =

> > -----Original Message-----
> > From: Moore, Robert
> > Sent: Monday, April 17, 2017 10:13 AM
> > To: Guenter Roeck <linux(a)roeck-us.net>; Zheng, Lv <lv.zheng(a)intel.c=
om>
> > Cc: Wysocki, Rafael J <rafael.j.wysocki(a)intel.com>; Len Brown
> > <lenb(a)kernel.org>; linux-acpi(a)vger.kernel.org; devel(a)acpica.org; =
linux-
> > kernel(a)vger.kernel.org
> > Subject: RE: [PATCH] ACPICA: Export mutex functions
> >
> > There is a model for the drivers to directly acquire an AML mutex
> > object. That is why the acquire/release public interfaces were added to
> > ACPICA.
> >
> > I forget all of the details, but the model was developed with MS and
> > others during the ACPI 6.0 timeframe.
> >
> >
> [Moore, Robert]
> =

> =

> Here is the case where the OS may need to directly acquire an AML mutex:
> =

> From the ACPI spec:
> =

> 19.6.2 Acquire (Acquire a Mutex)
> =

> Note: For Mutex objects referenced by a _DLM object, the host OS may also=
 contend for ownership.
> =

> =

> =

> =

> Other than this case, the OS/drivers should never need to directly acquir=
e an AML mutex.

That sounds reasonable but the driver might invoke an ACPICA API accessing =
the _DLM returned mutexes.

Thanks and best regards
Lv


--===============6233624178114918088==--

