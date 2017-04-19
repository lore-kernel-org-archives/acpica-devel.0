Content-Type: multipart/mixed; boundary="===============0780267695487999088=="
MIME-Version: 1.0
From: Zheng, Lv <lv.zheng at intel.com>
Subject: Re: [Devel] [PATCH] ACPICA: Export mutex functions
Date: Wed, 19 Apr 2017 01:35:55 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E886CE94626@SHSMSX101.ccr.corp.intel.com>
In-Reply-To: 1AE640813FDE7649BE1B193DEA596E886CE945E0@SHSMSX101.ccr.corp.intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============0780267695487999088==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

> From: Devel [mailto:devel-bounces(a)acpica.org] On Behalf Of Zheng, Lv
> Subject: Re: [Devel] [PATCH] ACPICA: Export mutex functions
> =

> Hi,
> =

> > From: Guenter Roeck [mailto:linux(a)roeck-us.net]
> > Subject: Re: [PATCH] ACPICA: Export mutex functions
> >
> > On 04/18/2017 12:14 AM, Zheng, Lv wrote:
> > > Hi,
> > >
> > >> From: Zheng, Lv
> > >> Subject: RE: [PATCH] ACPICA: Export mutex functions
> > >>
> > >> Hi,
> > >>
> > >>> From: Guenter Roeck [mailto:linux(a)roeck-us.net]
> > >>> Subject: Re: [PATCH] ACPICA: Export mutex functions
> > >>>
> > >>> On 04/17/2017 04:53 PM, Zheng, Lv wrote:
> > >>>> Hi,
> > >>>>
> > >>>>> From: Guenter Roeck [mailto:linux(a)roeck-us.net]
> > >>>>> Subject: Re: [PATCH] ACPICA: Export mutex functions
> > >>>>>
> > >>>>> On Mon, Apr 17, 2017 at 11:29:38PM +0200, Rafael J. Wysocki wrote:
> > >>>>>> On Mon, Apr 17, 2017 at 11:03 PM, Guenter Roeck <linux(a)roeck-u=
s.net> wrote:
> > >>>>>>> On Mon, Apr 17, 2017 at 08:40:38PM +0000, Moore, Robert wrote:
> > >>>>>>>>
> > >>>>>>>>
> > >>>>>>>>> From: Guenter Roeck [mailto:linux(a)roeck-us.net]
> > >>>>>>>>> Subject: Re: [PATCH] ACPICA: Export mutex functions
> > >>>>>>>>>
> > >>>>>>>>> On Mon, Apr 17, 2017 at 07:27:37PM +0000, Moore, Robert wrote:
> > >>>>>>>>>>
> > >>>>>>>>>>> From: Moore, Robert
> > >>>>>>>>>>> Subject: RE: [PATCH] ACPICA: Export mutex functions
> > >>>>>>>>>>>
> > >>>>>>>>>>> There is a model for the drivers to directly acquire an AML=
 mutex
> > >>>>>>>>>>> object. That is why the acquire/release public interfaces w=
ere added
> > >>>>>>>>>>> to ACPICA.
> > >>>>>>>>>>>
> > >>>>>>>>>>> I forget all of the details, but the model was developed wi=
th MS and
> > >>>>>>>>>>> others during the ACPI 6.0 timeframe.
> > >>>>>>>>>>>
> > >>>>>>>>>>>
> > >>>>>>>>>> [Moore, Robert]
> > >>>>>>>>>>
> > >>>>>>>>>>
> > >>>>>>>>>> Here is the case where the OS may need to directly acquire a=
n AML
> > >>>>>>>>> mutex:
> > >>>>>>>>>>
> > >>>>>>>>>> From the ACPI spec:
> > >>>>>>>>>>
> > >>>>>>>>>> 19.6.2 Acquire (Acquire a Mutex)
> > >>>>>>>>>>
> > >>>>>>>>>> Note: For Mutex objects referenced by a _DLM object, the hos=
t OS may
> > >>>>>>>>> also contend for ownership.
> > >>>>>>>>>>
> > >>>>>>>>> From the context in the dsdt, and from description of expecte=
d use cases
> > >>>>>>>>> for _DLM objects I can find, this is what the mutex is used f=
or (to
> > >>>>>>>>> serialize access to a resource on a low pin count serial inte=
rconnect,
> > >>>>>>>>> aka LPC).
> > >>>>>>>>>
> > >>>>>>>>> What does that mean in practice ? That I am not supposed to u=
se it
> > >>>>>>>>> because it doesn't follow standard ACPI mutex declaration rul=
es ?
> > >>>>>>>>>
> > >>>>>>>>> Thanks,
> > >>>>>>>>> Guenter
> > >>>>>>>>>
> > >>>>>>>>>>
> > >>>>>>>> [Moore, Robert]
> > >>>>>>>>
> > >>>>>>>> I'm not an expert on the _DLM method, but I would point you to=
 the description section in
> the
> > >>>>> ACPI spec, 5.7.5 _DLM (DeviceLock Mutex).
> > >>>>>>>>
> > >>>>>>>
> > >>>>>>> I did. However, not being an ACPI expert, that doesn't tell me =
anything.
> > >>>>>>
> > >>>>>> Basically, if the kernel and AML need to access a device concurr=
ently,
> > >>>>>> there should be a _DLM object under that device in the ACPI tabl=
es.
> > >>>>>> In that case it is expected to return a list of (AML) mutexes th=
at can
> > >>>>>> be acquired by the kernel in order to synchronize device access =
with
> > >>>>>> respect to AML (and for each mutex it may also return a descript=
ion of
> > >>>>>> the specific resources to be protected by it).
> > >>>>>>
> > >>>>>> Bottom line: without _DLM, the kernel cannot synchronize things =
with
> > >>>>>> respect to AML properly, because it has no information how to do=
 that
> > >>>>>> then.
> > >>>>>
> > >>>>> That is all quite interesting. I do see the mutex in question use=
d on various
> > >>>>> motherboards from various vendors (I checked boards from Gigabyte=
, MSI, and
> > >>>>> Intel). Interestingly, the naming seems to be consistent - it is =
always named
> > >>>>> "MUT0". For the most part, it seems to be available on more recent
> > >>>>> motherboards; older motherboards tend to use the resource without=
 locking.
> > >>>>> However, I don't see any mention of "_DLM" in any of the DSDTs.
> > >>>>>
> > >>>>
> > >>>> OK, then you might be having problems in your opregion driver.
> > >>>>
> > >>>>> At the same time, access to ports 0x2e/0x2f is widely used in the=
 kernel.
> > >>>>> As mentioned before, it is used in watchdog, hardware monitoring,=
 and gpio
> > >>>>> drivers, but also in parallel port and infrared driver code. Effe=
ctively
> > >>>>> that means that all this code is inherently unsafe on systems wit=
h ACPI
> > >>>>> support.
> > >>>>>
> > >>>>> I had thought about implementing a set of utility functions to ma=
ke the kernel
> > >>>>> code safer to use if the mutex is found to exist.
> > >>>>
> > >>>> As what you've mentioned, there are already lots of parallel acces=
ses in kernel without
> enabling
> > >>> ACPI.
> > >>>> Are these accesses mutually exclusive (safe)?
> > >>>
> > >>> In-kernel, yes (using request_muxed_region). Against ACPI, no.
> > >>>
> > >>>> If so, why do you need to invent a new synchronization mechanism?
> > >>>>
> > >>>
> > >>> Because I am seeing a problem with the current code (more specifica=
lly,
> > >>> with the it87 hwmon driver) on new Gigabyte boards.
> > >>
> > >> I checked superio_enter()/superio_exit(), IMO, the mutual exclusion
> > >> might be handled using 1 of the following 2 solutions:
> > >>
> > >> 1. _DLM, then you can find superio related mutex from _DLM and
> > >>    acquire/release it in superio_enter()/superio_exit().
> > >>    You really need a set of new APIs to acquire the _DLM related mut=
ex.
> > >>    If you don't have _DLM in your DSDT, directly exporting ACPICA mu=
tex
> > >>    functions seem to be a reasonable solution.
> > >> 2. Normally, AML developer should abstract superio accesses into cus=
tomized
> > >>    opregion, then you can prepare a superio opregion driver.
> > >>
> > >>>
> > >>>>> Right now I wonder, though,
> > >>>>> if such code would have a chance to be accepted. Any thoughts on =
that ?
> > >>>>
> > >>>> Is that possible to make it safe in the opregion driver?
> > >>>>
> > >>>
> > >>> Sorry, I don't think I understand what you mean with "opregion driv=
er".
> > >>> Do you refer to the drivers accessing the memory region in question,
> > >>> or in other words replicating the necessary code in every driver ac=
cessing
> > >>> that region ? Sure, I can do that, if that is the preferred solutio=
n;
> > >>> I have no problem with that. However, that would require exporting
> > >>> the ACPI mutex functions. My understanding is that you are opposed =
to
> > >>> exporting those, so I assume that is not what you refer to.
> > >>> Can you clarify ?
> > >>
> > >> I mean solution 2.
> > >
> > > Maybe I should provide more detailed examples for this solution.
> > >
> > > For example:
> > > OperationRegion (SIOT, SuperIOAddressSpace, Zero, 100)
> > > Field (SIOT, ByteAcc, Lock, Preserve)
> > > {
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
> > > acpi_install_operation_region(SuperIOAddressSpace, superio_opregion_h=
andler) from OS side.
> > > In its callback superio_opregion_handler(), you can:
> > >
> > > superio_enter();
> > > If (address =3D=3D 0) {
> > >    /* mean FNC1 */
> > >    Perform the locked superior accesses
> > > } else if (address =3D=3D 1) {
> > >    /* mean FNC2 */
> > >    Perform the locked superior accesses
> > > }
> > > superio_exit();
> > >
> > > Are there similar approach in your DSDT?
> > >
> >
> > Some snippets from the DSDT:
> >
> > 	Device (SIO1)
> >             {
> >          	Name (_HID, EisaId ("PNP0C02") /* PNP Motherboard Resources *=
/)  // _HID: Hardware ID
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
> > 		    OperationRegion (IOID, SystemIO, SP1O, 0x02)	/* SP1O is 0x2e */
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
> >                          If (((DMCH < 0x04) && ((Local1 =3D (DMCH & 0x0=
3)) !=3D Zero)))
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

> From the above AML code, the solution 2 is not possible for ensuring the
> mutual exclusion of accessing the resources.
> Because the mutual exclusion must be ensured for the entire transaction
> including ENFG() and EXFG() rather than a single SystemIo operation
> region field access.
> =

> So you really need the solution 1 and the new API.

Sorry, there is still another solution besides of the above 2 that
Can possibly solve your problem.

Let me explain.
Here for the DCNT method, there must be entry methods (those with
underscore prefixed, let me use _XXXX as an example) invoking it.
And OS will invoke those entry methods. So is that possible to add
request_muxed_region() before invoking those entry control methods.

For example:
superio_enter()
acpi_evaluate_object(_XXXX)
superio_exit()

Thanks and best regards
Lv

> =

> Thanks and best regards
> Lv
> =

> >
> > Thanks,
> > Guenter
> >
> > > Thanks and best regards
> > > Lv
> > >
> > >> From it87_find() I really couldn't see a possibility to convert supe=
rio
> > >> accesses into opregions. Could you paste some example superio access=
 AML
> > >> code from your DSDT here.
> > >>
> > >> Thanks and best regards
> > >> Lv
> =

> _______________________________________________
> Devel mailing list
> Devel(a)acpica.org
> https://lists.acpica.org/mailman/listinfo/devel

--===============0780267695487999088==--

