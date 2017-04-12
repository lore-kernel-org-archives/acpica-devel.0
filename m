Content-Type: multipart/mixed; boundary="===============6888059960576803965=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: Re: [Devel] [PATCH] ACPICA: Export mutex functions
Date: Wed, 12 Apr 2017 21:56:37 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37E592822@ORSMSX110.amr.corp.intel.com>
In-Reply-To: 20170412212241.GA12384@roeck-us.net
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============6888059960576803965==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



> -----Original Message-----
> From: Guenter Roeck [mailto:linux(a)roeck-us.net]
> Sent: Wednesday, April 12, 2017 2:23 PM
> To: Moore, Robert <robert.moore(a)intel.com>
> Cc: Zheng, Lv <lv.zheng(a)intel.com>; Wysocki, Rafael J
> <rafael.j.wysocki(a)intel.com>; Len Brown <lenb(a)kernel.org>; linux-
> acpi(a)vger.kernel.org; devel(a)acpica.org; linux-kernel(a)vger.kernel.org
> Subject: Re: [PATCH] ACPICA: Export mutex functions
> =

> On Wed, Apr 12, 2017 at 03:29:55PM +0000, Moore, Robert wrote:
> > The ACPICA mutex functions are based on the host OS functions, so they
> don't really buy you anything. You should just use the native Linux
> functions.
> >
> =

> You mean they don't really acquire the requested ACPI mutex, and the
> underlying DSDT which declares and uses the mutex just ignores if the
> mutex was acquired by acpi_acquire_mutex() ?
> =

[Moore, Robert] =


OK, I understand now. Yes, these mutex interfaces are in fact intended for =
the purpose you mention:

* FUNCTION:    AcpiAcquireMutex
 *
 * PARAMETERS:  Handle              - Mutex or prefix handle (optional)
 *              Pathname            - Mutex pathname (optional)
 *              Timeout             - Max time to wait for the lock (millis=
ec)
 *
 * RETURN:      Status
 *
 * DESCRIPTION: Acquire an AML mutex. This is a device driver interface to
 *              AML mutex objects, and allows for transaction locking betwe=
en
 *              drivers and AML code. The mutex node is pointed to by
 *              Handle:Pathname. Either Handle or Pathname can be NULL, but
 *              not both.


And yes, both the acquire and release interfaces should be exported.





> To clarify: You are saying that code such as
> =

> 	acpi_status status;
> =

> 	status =3D acpi_acquire_mutex(NULL, "\\_SB.PCI0.SBRG.SIO1.MUT0",
> 0x10);
> 	if (ACPI_FAILURE(status)) {
> 		pr_err("Failed to acquire ACPI mutex\n");
> 		return -EBUSY;
> 	}
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

> doesn't really provide exclusive access to the resource(s) protected by
> MUT0, even if acpi_acquire_mutex() returns ACPI_SUCCESS ?
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
> > > <lv.zheng(a)intel.com>; Wysocki, Rafael J
> > > <rafael.j.wysocki(a)intel.com>; Len Brown <lenb(a)kernel.org>
> > > Cc: linux-acpi(a)vger.kernel.org; devel(a)acpica.org; linux-
> > > kernel(a)vger.kernel.org; Guenter Roeck <linux(a)roeck-us.net>
> > > Subject: [PATCH] ACPICA: Export mutex functions
> > >
> > > Mutex functions may be needed by drivers. Examples are accesses to
> > > Super-IO SIO registers (0x2e/0x2f or 0x4e/0x4f) or Super-IO
> > > environmental monitor registers, both which may also be accessed
> > > through DSDT.
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
> > > @@ -150,6 +150,7 @@ acpi_acquire_mutex(acpi_handle handle,
> > > acpi_string pathname, u16 timeout)
> > >  	status =3D acpi_os_acquire_mutex(mutex_obj->mutex.os_mutex, timeout=
);
> > >  	return (status);
> > >  }
> > > +ACPI_EXPORT_SYMBOL(acpi_acquire_mutex)
> > >
> > >
> > > /*******************************************************************
> > > ****
> > > ********
> > >   *
> > > @@ -185,3 +186,4 @@ acpi_status acpi_release_mutex(acpi_handle
> > > handle, acpi_string pathname)
> > >  	acpi_os_release_mutex(mutex_obj->mutex.os_mutex);
> > >  	return (AE_OK);
> > >  }
> > > +ACPI_EXPORT_SYMBOL(acpi_release_mutex)
> > > --
> > > 2.7.4
> >

--===============6888059960576803965==--

