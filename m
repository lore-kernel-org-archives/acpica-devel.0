Content-Type: multipart/mixed; boundary="===============6405989023508752073=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: Re: [Devel] [PATCH] ACPICA: Export mutex functions
Date: Tue, 18 Apr 2017 16:07:59 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37E593908@ORSMSX110.amr.corp.intel.com>
In-Reply-To: 1773950.yRmmpX2ztC@aspire.rjw.lan
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============6405989023508752073==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



> -----Original Message-----
> From: Rafael J. Wysocki [mailto:rjw(a)rjwysocki.net]
> Sent: Tuesday, April 18, 2017 7:15 AM
> To: Guenter Roeck <linux(a)roeck-us.net>
> Cc: Zheng, Lv <lv.zheng(a)intel.com>; Rafael J. Wysocki
> <rafael(a)kernel.org>; Moore, Robert <robert.moore(a)intel.com>; Wysocki,
> Rafael J <rafael.j.wysocki(a)intel.com>; Len Brown <lenb(a)kernel.org>;
> linux-acpi(a)vger.kernel.org; devel(a)acpica.org; linux-
> kernel(a)vger.kernel.org; Box, David E <david.e.box(a)intel.com>
> Subject: Re: [PATCH] ACPICA: Export mutex functions
> =

> On Tuesday, April 18, 2017 06:50:26 AM Guenter Roeck wrote:
> > On 04/18/2017 12:14 AM, Zheng, Lv wrote:
> > > Hi,
> =

> [cut]
> =

> > >
> > > Maybe I should provide more detailed examples for this solution.
> > >
> > > For example:
> > > OperationRegion (SIOT, SuperIOAddressSpace, Zero, 100) Field (SIOT,
> > > ByteAcc, Lock, Preserve) {
> > >     FNC1, 8,
> > >     FNC2, 8,
> > >     ...
> > > }
> > >
> > > Acquire (MUX0)
> > > Store (0, FNC1)
> > > Release (MUX0)
> > >
> > > Then you can call (let me use casual pseudo code)
> > > acpi_install_operation_region(SuperIOAddressSpace,
> superio_opregion_handler) from OS side.
> > > In its callback superio_opregion_handler(), you can:
> > >
> > > superio_enter();
> > > If (address =3D=3D 0) {
> > >    /* mean FNC1 */
> > >    Perform the locked superior accesses } else if (address =3D=3D 1) {
> > >    /* mean FNC2 */
> > >    Perform the locked superior accesses } superio_exit();
> > >
> > > Are there similar approach in your DSDT?
> > >
> >
> > Some snippets from the DSDT:
> >
> > 	Device (SIO1)
> >             {
> >          	Name (_HID, EisaId ("PNP0C02") /* PNP Motherboard
> Resources */)  // _HID: Hardware ID
> >          	Name (_UID, Zero)  // _UID: Unique ID
> > 		...
> > 		Mutex (MUT0, 0x00)
> > 		Method (ENFG, 1, NotSerialized)
> >                      {
> >                          Acquire (MUT0, 0x0FFF)
> >                          INDX =3D 0x87
> >                          INDX =3D One
> >                          INDX =3D 0x55
> >                          If ((SP1O =3D=3D 0x2E))
> >                          {
> >                              INDX =3D 0x55
> >                          }
> >                          Else
> >                          {
> >                              INDX =3D 0xAA
> >                          }
> >
> >                          LDN =3D Arg0
> >                      }
> >
> >                      Method (EXFG, 0, NotSerialized)
> >                      {
> >                          INDX =3D 0x02
> >                          DATA =3D 0x02
> >                          Release (MUT0)
> >                      }
> >
> > 		    OperationRegion (IOID, SystemIO, SP1O, 0x02)	/* SP1O
> is 0x2e */
> >                      Field (IOID, ByteAcc, NoLock, Preserve)
> >                      {
> >                          INDX,   8,
> >                          DATA,   8
> >                      }
> > 		    ...
> >
> > Example for use:
> > 		Method (DCNT, 2, NotSerialized)
> >                      {
> >                          ENFG (CGLD (Arg0))
> >                          If (((DMCH < 0x04) && ((Local1 =3D (DMCH &
> 0x03)) !=3D Zero)))
> >                          {
> >                              RDMA (Arg0, Arg1, Local1++)
> >                          }
> >
> >                          ACTR =3D Arg1
> >                          Local1 =3D (IOAH << 0x08)
> >                          Local1 |=3D IOAL
> >                          RRIO (Arg0, Arg1, Local1, 0x08)
> >                          EXFG ()
> >                      }
> >
> > Can there be more than one address space handler for a given region ?
> > Each driver accessing the resource would need that handler.
> =

> Rather, every driver accessing the resource would need to be aware of
> the existence of the operation region handler and would need to use the
> mutual exclusion mechanism used by that handler, if my understanding
> here is correct.
> =

> The existence of an operation region for a specific section of address
> space is a declaration that AML is going to access locations in that
> section.  It allows the OS to install a handler for that region to
> intercept AML accesses and do what it likes with them.
> =

> Thanks,
> Rafael

Yes, agreed.
Bob


--===============6405989023508752073==--

