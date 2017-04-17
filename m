Content-Type: multipart/mixed; boundary="===============4030764313534593173=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: Re: [Devel] [PATCH] ACPICA: Export mutex functions
Date: Mon, 17 Apr 2017 20:40:38 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37E593580@ORSMSX110.amr.corp.intel.com>
In-Reply-To: 20170417194527.GA16734@roeck-us.net
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============4030764313534593173==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



> -----Original Message-----
> From: Guenter Roeck [mailto:linux(a)roeck-us.net]
> Sent: Monday, April 17, 2017 12:45 PM
> To: Moore, Robert <robert.moore(a)intel.com>
> Cc: Zheng, Lv <lv.zheng(a)intel.com>; Wysocki, Rafael J
> <rafael.j.wysocki(a)intel.com>; 'Len Brown' <lenb(a)kernel.org>; 'linux-
> acpi(a)vger.kernel.org' <linux-acpi(a)vger.kernel.org>; 'devel(a)acpica.o=
rg'
> <devel(a)acpica.org>; 'linux-kernel(a)vger.kernel.org' <linux-
> kernel(a)vger.kernel.org>; Box, David E <david.e.box(a)intel.com>
> Subject: Re: [PATCH] ACPICA: Export mutex functions
> =

> On Mon, Apr 17, 2017 at 07:27:37PM +0000, Moore, Robert wrote:
> >
> > > -----Original Message-----
> > > From: Moore, Robert
> > > Sent: Monday, April 17, 2017 10:13 AM
> > > To: Guenter Roeck <linux(a)roeck-us.net>; Zheng, Lv
> > > <lv.zheng(a)intel.com>
> > > Cc: Wysocki, Rafael J <rafael.j.wysocki(a)intel.com>; Len Brown
> > > <lenb(a)kernel.org>; linux-acpi(a)vger.kernel.org; devel(a)acpica.org;
> > > linux- kernel(a)vger.kernel.org
> > > Subject: RE: [PATCH] ACPICA: Export mutex functions
> > >
> > > There is a model for the drivers to directly acquire an AML mutex
> > > object. That is why the acquire/release public interfaces were added
> > > to ACPICA.
> > >
> > > I forget all of the details, but the model was developed with MS and
> > > others during the ACPI 6.0 timeframe.
> > >
> > >
> > [Moore, Robert]
> >
> >
> > Here is the case where the OS may need to directly acquire an AML
> mutex:
> >
> > From the ACPI spec:
> >
> > 19.6.2 Acquire (Acquire a Mutex)
> >
> > Note: For Mutex objects referenced by a _DLM object, the host OS may
> also contend for ownership.
> >
> From the context in the dsdt, and from description of expected use cases
> for _DLM objects I can find, this is what the mutex is used for (to
> serialize access to a resource on a low pin count serial interconnect,
> aka LPC).
> =

> What does that mean in practice ? That I am not supposed to use it
> because it doesn't follow standard ACPI mutex declaration rules ?
> =

> Thanks,
> Guenter
> =

> >
[Moore, Robert] =


I'm not an expert on the _DLM method, but I would point you to the descript=
ion section in the ACPI spec, 5.7.5 _DLM (DeviceLock Mutex).





> >
> >
> > Other than this case, the OS/drivers should never need to directly
> acquire an AML mutex.
> > Bob
> >

--===============4030764313534593173==--

