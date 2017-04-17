Content-Type: multipart/mixed; boundary="===============7566632547661220870=="
MIME-Version: 1.0
From: Zheng, Lv <lv.zheng at intel.com>
Subject: Re: [Devel] [PATCH] ACPICA: Export mutex functions
Date: Mon, 17 Apr 2017 23:46:50 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E886CE93D1C@SHSMSX101.ccr.corp.intel.com>
In-Reply-To: 20170417194527.GA16734@roeck-us.net
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============7566632547661220870==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

> From: Guenter Roeck [mailto:linux(a)roeck-us.net]
> Sent: Tuesday, April 18, 2017 3:45 AM
> Subject: Re: [PATCH] ACPICA: Export mutex functions
> =

> On Mon, Apr 17, 2017 at 07:27:37PM +0000, Moore, Robert wrote:
> >
> > > -----Original Message-----
> > > From: Moore, Robert
> > > Sent: Monday, April 17, 2017 10:13 AM
> > > To: Guenter Roeck <linux(a)roeck-us.net>; Zheng, Lv <lv.zheng(a)intel=
.com>
> > > Cc: Wysocki, Rafael J <rafael.j.wysocki(a)intel.com>; Len Brown
> > > <lenb(a)kernel.org>; linux-acpi(a)vger.kernel.org; devel(a)acpica.org=
; linux-
> > > kernel(a)vger.kernel.org
> > > Subject: RE: [PATCH] ACPICA: Export mutex functions
> > >
> > > There is a model for the drivers to directly acquire an AML mutex
> > > object. That is why the acquire/release public interfaces were added =
to
> > > ACPICA.
> > >
> > > I forget all of the details, but the model was developed with MS and
> > > others during the ACPI 6.0 timeframe.
> > >
> > >
> > [Moore, Robert]
> >
> >
> > Here is the case where the OS may need to directly acquire an AML mutex:
> >
> > From the ACPI spec:
> >
> > 19.6.2 Acquire (Acquire a Mutex)
> >
> > Note: For Mutex objects referenced by a _DLM object, the host OS may al=
so contend for ownership.
> >
> From the context in the dsdt, and from description of expected use cases =
for
> _DLM objects I can find, this is what the mutex is used for (to serialize
> access to a resource on a low pin count serial interconnect, aka LPC).
> =

> What does that mean in practice ? That I am not supposed to use it because
> it doesn't follow standard ACPI mutex declaration rules ?
> =


Could you find related _DLMs in your DSDT?
If there is any, could you please post it here for reference?

Thanks
Lv

> Thanks,
> Guenter
> =

> >
> >
> >
> > Other than this case, the OS/drivers should never need to directly acqu=
ire an AML mutex.
> > Bob
> >

--===============7566632547661220870==--

