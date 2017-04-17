Content-Type: multipart/mixed; boundary="===============6868481768333326153=="
MIME-Version: 1.0
From: Zheng, Lv <lv.zheng at intel.com>
Subject: Re: [Devel] [PATCH] ACPICA: Export mutex functions
Date: Mon, 17 Apr 2017 23:37:55 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E886CE93CE7@SHSMSX101.ccr.corp.intel.com>
In-Reply-To: 20170417155646.GA8730@roeck-us.net
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============6868481768333326153==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

> From: Guenter Roeck [mailto:linux(a)roeck-us.net]
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
> > > > The ACPICA mutex functions are based on the host OS functions, so t=
hey don't really buy you
> anything.
> > > You should just use the native Linux functions.
> > > >
> > >
> > > You mean they don't really acquire the requested ACPI mutex,
> > > and the underlying DSDT which declares and uses the mutex
> > > just ignores if the mutex was acquired by acpi_acquire_mutex() ?
> > >
> > > To clarify: You are saying that code such as
> > >
> > > 	acpi_status status;
> > >
> > > 	status =3D acpi_acquire_mutex(NULL, "\\_SB.PCI0.SBRG.SIO1.MUT0", 0x1=
0);
> > > 	if (ACPI_FAILURE(status)) {
> > > 		pr_err("Failed to acquire ACPI mutex\n");
> > > 		return -EBUSY;
> > > 	}
> >
> > Why do you need to access \_SB.PCI0.SBRG.SIO1.MUT0?
> > OSPM should only invoke entry methods predefined by ACPI spec or whatev=
er specs.
> > There shouldn't be any needs that a driver acquires an arbitrary AML mu=
tex.
> > You do not seem to have justified the usage model, IMO.
> >
> =

> I am sorry, I have no idea how to do that. I can see that the resource in
> question (IO address 0x2e/0x2f) is accessed from the DSDT, that the resou=
rce
> is mutex protected, and that accesses to the same IO address from the Lin=
ux
> kernel are unreliable unless I acquire the mutex in question. At the same=
 time,
> I can see that request_muxed_region() succeeds, so presumably ACPI does n=
ot
> reserve the region for its exclusive use.

Please refer to my previous reply.
Why don't you make it safe in super IO driver and the opregion driver in fi=
rst place.
Then check if you still need to acquire the mutex.

> =

> It may well be that the "official" response to this problem is "you must
> not instantiate a watchdog, environmental monitor, or gpio driver (or any=
thing
> else provided by the Super-IO chip that requires access to those ports) o=
n this
> platform in Linux". Is that what you are suggesting ?
> =


I didn't mean that.
Probably you have synchronization problems in the OS driver.

Thanks and best regards
Lv

> Thanks,
> Guenter

--===============6868481768333326153==--

