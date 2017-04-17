Content-Type: multipart/mixed; boundary="===============1479290268640491435=="
MIME-Version: 1.0
From: Zheng, Lv <lv.zheng at intel.com>
Subject: Re: [Devel] [PATCH] ACPICA: Export mutex functions
Date: Mon, 17 Apr 2017 09:39:35 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E886CE92A85@SHSMSX101.ccr.corp.intel.com>
In-Reply-To: 20170412212241.GA12384@roeck-us.net
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============1479290268640491435==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

> From: Guenter Roeck [mailto:linux(a)roeck-us.net]
> Subject: Re: [PATCH] ACPICA: Export mutex functions
> =

> On Wed, Apr 12, 2017 at 03:29:55PM +0000, Moore, Robert wrote:
> > The ACPICA mutex functions are based on the host OS functions, so they =
don't really buy you anything.
> You should just use the native Linux functions.
> >
> =

> You mean they don't really acquire the requested ACPI mutex,
> and the underlying DSDT which declares and uses the mutex
> just ignores if the mutex was acquired by acpi_acquire_mutex() ?
> =

> To clarify: You are saying that code such as
> =

> 	acpi_status status;
> =

> 	status =3D acpi_acquire_mutex(NULL, "\\_SB.PCI0.SBRG.SIO1.MUT0", 0x10);
> 	if (ACPI_FAILURE(status)) {
> 		pr_err("Failed to acquire ACPI mutex\n");
> 		return -EBUSY;
> 	}

Why do you need to access \_SB.PCI0.SBRG.SIO1.MUT0?
OSPM should only invoke entry methods predefined by ACPI spec or whatever s=
pecs.
There shouldn't be any needs that a driver acquires an arbitrary AML mutex.
You do not seem to have justified the usage model, IMO.

Thanks
Lv

> 	...
> =

> when used in conjunction with
> =

> 	...
> 	Mutex (MUT0, 0x00)
> 	Method (ENFG, 1, NotSerialized)
> 	{
> 		Acquire (MUT0, 0x0FFF)
> 		...
> 	}
> =

> doesn't really provide exclusive access to the resource(s) protected
> by MUT0, even if acpi_acquire_mutex() returns ACPI_SUCCESS ?
> =

> Outch. Really ?
> =

> Thanks,
> Guenter
> =

> >
> > > -----Original Message-----
> > > From: Guenter Roeck [mailto:linux(a)roeck-us.net]
> > > Sent: Wednesday, April 12, 2017 8:13 AM
> > > To: Moore, Robert <robert.moore(a)intel.com>; Zheng, Lv
> > > <lv.zheng(a)intel.com>; Wysocki, Rafael J <rafael.j.wysocki(a)intel.c=
om>;
> > > Len Brown <lenb(a)kernel.org>
> > > Cc: linux-acpi(a)vger.kernel.org; devel(a)acpica.org; linux-
> > > kernel(a)vger.kernel.org; Guenter Roeck <linux(a)roeck-us.net>
> > > Subject: [PATCH] ACPICA: Export mutex functions
> > >
> > > Mutex functions may be needed by drivers. Examples are accesses to
> > > Super-IO SIO registers (0x2e/0x2f or 0x4e/0x4f) or Super-IO
> > > environmental monitor registers, both which may also be accessed thro=
ugh
> > > DSDT.
> > >
> > > Signed-off-by: Guenter Roeck <linux(a)roeck-us.net>
> > > ---
> > >  drivers/acpi/acpica/utxfmutex.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/drivers/acpi/acpica/utxfmutex.c
> > > b/drivers/acpi/acpica/utxfmutex.c index c016211c35ae..5d20581f4b2f
> > > 100644
> > > --- a/drivers/acpi/acpica/utxfmutex.c
> > > +++ b/drivers/acpi/acpica/utxfmutex.c
> > > @@ -150,6 +150,7 @@ acpi_acquire_mutex(acpi_handle handle, acpi_string
> > > pathname, u16 timeout)
> > >  	status =3D acpi_os_acquire_mutex(mutex_obj->mutex.os_mutex, timeout=
);
> > >  	return (status);
> > >  }
> > > +ACPI_EXPORT_SYMBOL(acpi_acquire_mutex)
> > >
> > >
> > > /********************************************************************=
***
> > > ********
> > >   *
> > > @@ -185,3 +186,4 @@ acpi_status acpi_release_mutex(acpi_handle handle,
> > > acpi_string pathname)
> > >  	acpi_os_release_mutex(mutex_obj->mutex.os_mutex);
> > >  	return (AE_OK);
> > >  }
> > > +ACPI_EXPORT_SYMBOL(acpi_release_mutex)
> > > --
> > > 2.7.4
> >

--===============1479290268640491435==--

