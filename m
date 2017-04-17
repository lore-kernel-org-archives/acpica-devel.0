Content-Type: multipart/mixed; boundary="===============6815494953719075891=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: Re: [Devel] [PATCH] ACPICA: Export mutex functions
Date: Mon, 17 Apr 2017 17:12:57 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37E59332C@ORSMSX110.amr.corp.intel.com>
In-Reply-To: 20170417155646.GA8730@roeck-us.net
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============6815494953719075891==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

There is a model for the drivers to directly acquire an AML mutex object. T=
hat is why the acquire/release public interfaces were added to ACPICA.

I forget all of the details, but the model was developed with MS and others=
 during the ACPI 6.0 timeframe.


> -----Original Message-----
> From: Guenter Roeck [mailto:linux(a)roeck-us.net]
> Sent: Monday, April 17, 2017 8:57 AM
> To: Zheng, Lv
> Cc: Moore, Robert; Wysocki, Rafael J; Len Brown; linux-
> acpi(a)vger.kernel.org; devel(a)acpica.org; linux-kernel(a)vger.kernel.org
> Subject: Re: [PATCH] ACPICA: Export mutex functions
> =

> Hi,
> =

> On Mon, Apr 17, 2017 at 09:39:35AM +0000, Zheng, Lv wrote:
> > Hi,
> >
> > > From: Guenter Roeck [mailto:linux(a)roeck-us.net]
> > > Subject: Re: [PATCH] ACPICA: Export mutex functions
> > >
> > > On Wed, Apr 12, 2017 at 03:29:55PM +0000, Moore, Robert wrote:
> > > > The ACPICA mutex functions are based on the host OS functions, so
> they don't really buy you anything.
> > > You should just use the native Linux functions.
> > > >
> > >
> > > You mean they don't really acquire the requested ACPI mutex, and the
> > > underlying DSDT which declares and uses the mutex just ignores if
> > > the mutex was acquired by acpi_acquire_mutex() ?
> > >
> > > To clarify: You are saying that code such as
> > >
> > > 	acpi_status status;
> > >
> > > 	status =3D acpi_acquire_mutex(NULL, "\\_SB.PCI0.SBRG.SIO1.MUT0",
> 0x10);
> > > 	if (ACPI_FAILURE(status)) {
> > > 		pr_err("Failed to acquire ACPI mutex\n");
> > > 		return -EBUSY;
> > > 	}
> >
> > Why do you need to access \_SB.PCI0.SBRG.SIO1.MUT0?
> > OSPM should only invoke entry methods predefined by ACPI spec or
> whatever specs.
> > There shouldn't be any needs that a driver acquires an arbitrary AML
> mutex.
> > You do not seem to have justified the usage model, IMO.
> >
> =

> I am sorry, I have no idea how to do that. I can see that the resource in
> question (IO address 0x2e/0x2f) is accessed from the DSDT, that the
> resource is mutex protected, and that accesses to the same IO address from
> the Linux kernel are unreliable unless I acquire the mutex in question. At
> the same time, I can see that request_muxed_region() succeeds, so
> presumably ACPI does not reserve the region for its exclusive use.
> =

> It may well be that the "official" response to this problem is "you must
> not instantiate a watchdog, environmental monitor, or gpio driver (or
> anything else provided by the Super-IO chip that requires access to those
> ports) on this platform in Linux". Is that what you are suggesting ?
> =

> Thanks,
> Guenter

--===============6815494953719075891==--

