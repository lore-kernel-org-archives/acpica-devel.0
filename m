Content-Type: multipart/mixed; boundary="===============1365792455654149702=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: Re: [Devel] [PATCH] ACPICA: Export mutex functions
Date: Fri, 14 Apr 2017 23:32:48 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37E592F3B@ORSMSX110.amr.corp.intel.com>
In-Reply-To: 2456461.gJP0PmoWKK@aspire.rjw.lan
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============1365792455654149702==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



> -----Original Message-----
> From: Rafael J. Wysocki [mailto:rjw(a)rjwysocki.net]
> Sent: Friday, April 14, 2017 3:30 PM
> To: Moore, Robert
> Cc: Guenter Roeck; Zheng, Lv; Wysocki, Rafael J; Len Brown; linux-
> acpi(a)vger.kernel.org; devel(a)acpica.org; linux-kernel(a)vger.kernel.org
> Subject: Re: [PATCH] ACPICA: Export mutex functions
> =

> On Wednesday, April 12, 2017 09:56:37 PM Moore, Robert wrote:
> >
> > > -----Original Message-----
> > > From: Guenter Roeck [mailto:linux(a)roeck-us.net]
> > > Sent: Wednesday, April 12, 2017 2:23 PM
> > > To: Moore, Robert <robert.moore(a)intel.com>
> > > Cc: Zheng, Lv <lv.zheng(a)intel.com>; Wysocki, Rafael J
> > > <rafael.j.wysocki(a)intel.com>; Len Brown <lenb(a)kernel.org>; linux-
> > > acpi(a)vger.kernel.org; devel(a)acpica.org; linux-kernel(a)vger.kerne=
l.org
> > > Subject: Re: [PATCH] ACPICA: Export mutex functions
> > >
> > > On Wed, Apr 12, 2017 at 03:29:55PM +0000, Moore, Robert wrote:
> > > > The ACPICA mutex functions are based on the host OS functions, so
> > > > they
> > > don't really buy you anything. You should just use the native Linux
> > > functions.
> > > >
> > >
> > > You mean they don't really acquire the requested ACPI mutex, and the
> > > underlying DSDT which declares and uses the mutex just ignores if
> > > the mutex was acquired by acpi_acquire_mutex() ?
> > >
> > [Moore, Robert]
> >
> > OK, I understand now. Yes, these mutex interfaces are in fact intended
> for the purpose you mention:
> >
> > * FUNCTION:    AcpiAcquireMutex
> >  *
> >  * PARAMETERS:  Handle              - Mutex or prefix handle (optional)
> >  *              Pathname            - Mutex pathname (optional)
> >  *              Timeout             - Max time to wait for the lock
> (millisec)
> >  *
> >  * RETURN:      Status
> >  *
> >  * DESCRIPTION: Acquire an AML mutex. This is a device driver interface
> to
> >  *              AML mutex objects, and allows for transaction locking
> between
> >  *              drivers and AML code. The mutex node is pointed to by
> >  *              Handle:Pathname. Either Handle or Pathname can be NULL,
> but
> >  *              not both.
> >
> >
> > And yes, both the acquire and release interfaces should be exported.
> =

> OK, so I'm assuming this will go in through the upstream ACPICA.
> =


Yes, done for next release.
Bob



> Thanks,
> Rafael


--===============1365792455654149702==--

